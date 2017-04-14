//
//  UrlSession.swift
//  modulo
//
//  Created by Dawson, Christopher on 4/14/17.
//  Copyright © 2017 TheHolyGrail. All rights reserved.
//

import Foundation

class ModuloUrlSession : URLSessionProtocol {
    
    var session: URLSession
    
    init( _ session: URLSession = URLSession.shared ) {
        self.session = session
    }
    
    func synchronousDataTask( _ url: URL ) -> ( Data?, URLResponse?, Error? ) {
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.session.dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            
            semaphore.signal()
        }
        dataTask.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
    
}
