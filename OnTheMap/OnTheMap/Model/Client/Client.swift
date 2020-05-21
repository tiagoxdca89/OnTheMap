//
//  Client.swift
//  OnTheMap
//
//  Created by Tiago Xavier da Cunha Almeida on 17/05/2020.
//  Copyright © 2020 Tiago Xavier da Cunha Almeida. All rights reserved.
//

import Foundation

class Client {
    
    static let apiKey = "YOUR_TMDB_API_KEY"
    
    enum Endpoints {
        case login
        case deleteSession
        case studentInformation(userID: String)
        case getStudentsLocations
        case createStudentLocation
        case updateStudentLocation(studentID: String)
        
        
        var stringValue: String {
            switch self {
            case .login:
                return LoginRequest.login.path
            case .deleteSession:
                return DeleteSessionRequest.deleteSession.path
            case .studentInformation(let userID):
                return String(format: StudentsLocationsRequest.getStudentsLocations.path, userID)
            case .getStudentsLocations:
                return StudentsLocationsRequest.getStudentsLocations.path
            case .createStudentLocation:
                return CreateStudentLocationRequest.postStudentLocation.path
            case .updateStudentLocation(let studentID):
                return String(format: UpdateStudentRequest.updateStudentLocation.path, studentID)
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
}

extension Client {
    
    static func login(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = LoginBody(udacity: Credentials(username: username, password: password))
        taskForPOSTRequest(url: Endpoints.login.url, responseType: LoginResponse.self, body: body) { response, error in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    static func deleteSession(completion: @escaping (Bool, Error?) -> Void) {
        taskForDELETERequest(url: Endpoints.deleteSession.url, responseType: DeleteSessionResponse.self) { (response, error) in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    static func getStudentInformation(studentID: String, completion: @escaping ([StudentInformation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.studentInformation(userID: studentID).url, responseType: StudentsLocations.self) { (response, error) in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    static func getStudentsLocations(completion: @escaping ([StudentInformation], Error?) -> Void) {
        taskForGETRequest(url: Endpoints.getStudentsLocations.url, responseType: StudentsLocations.self) { response, error in
            if let response = response {
                completion(response.results, nil)
            } else {
                completion([], error)
            }
        }
    }
    
    static func postStudentLocation(username: String, password: String, completion: @escaping (Bool, Error?) -> Void) {
        let body = StudentsLocations.getFakeStudentInformation()
        taskForPOSTRequest(url: Endpoints.createStudentLocation.url, responseType: PostLocationResponse.self, body: body) { response, error in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
    static func updateStudentLocation(studentID: String, completion: @escaping (Bool, Error?) -> Void) {
        let url = Endpoints.updateStudentLocation(studentID: studentID).url
        let body = StudentsLocations.getFakeStudentInformation()
        taskForPOSTRequest(url: url, responseType: UpdateLocationResponse.self, body: body) { response, error in
            if response != nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
    
}


extension Client {
    
    @discardableResult
    static func taskForGETRequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        
        return task
    }
}

extension Client {
    
    static func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            if RequestType.self == LoginBody.self {
                let range = Range(5...data.count-1)
                data = data.subdata(in: range)
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}

extension Client {
    
    static func taskForDELETERequest<ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
          if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
          request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard var data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            if ResponseType.self == DeleteSessionResponse.self {
                let range = Range(5...data.count-1)
                data = data.subdata(in: range)
            }
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
}

