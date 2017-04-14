//
//  ForkCommand.swift
//  modulo
//
//  Created by Dawson, Christopher on 4/7/17.
//  Copyright © 2017 TheHolyGrail. All rights reserved.
//


import Foundation
#if NOFRAMEWORKS
#else
    import ELCLI
#endif

import Foundation

open class ForkCommand: NSObject, Command {
    
    // internal properties
    fileprivate var updateAll: Bool = false
    fileprivate var dependencyName: String! = nil
    
    // Protocol conformance
    open var name: String { return "fork" }
    open var shortHelpDescription: String { return "Fork a remote module"  }
    open var longHelpDescription: String {
        return "NYI"
    }
    open var failOnUnrecognizedOptions: Bool { return true }
    
    open var verbose: Bool = false
    open var quiet: Bool = false
    private var session: URLSessionProtocol? = nil
    
    public func configureOptions() {
        //        addOptionValue(["--tag"], usage: "specify the version tag to use", valueSignature: "<tag>") { (option, value) -> Void in
        //            if let value = value {
        //                self.checkoutType = .tag(name: value)
        //            }
        //        }
        //
    }
    
    init( session: URLSessionProtocol? = nil ) {
        self.session = session
    }
    
    override init() {
        self.session = ModuloUrlSession()
        super.init()
    }
    
    private func forkRepository( _ name: String, _ credentials: String, _ session: URLSessionProtocol ) {
        
        let urlPath:String = "https://api.github.com/v3"
//        let url = NSURL(string: urlPath)
//        let session = URLSession.shared
//        print(url!)
//        let ( _, response, _ ) =
//            session.synchronousDataTask(with: url! as URL)
        let ( _, response, _ ) = session.synchronousDataTask( URL(string: urlPath )! )
        print( response ?? "Empty" )
        print("Task completed outside")
    }
    
    private func getCredentials() -> String? {
        return "some oauth token..."
    }
    
    func getSessionFromOtherParams(_ otherParams: Array<String>?) ->  URLSessionProtocol? {
        return ModuloUrlSession()
    }
    
    public func execute(_ otherParams: Array<String>?) -> Int {
        // get credentials from hub file or request
        
        if let session = getSessionFromOtherParams( otherParams ) {
            if let credentials = getCredentials() {
                if let workingSpec = ModuleSpec.workingSpec() {
                    let deps = workingSpec.allDependencies()
                    deps.forEach { (dependency) in
                        let name = dependency.name()
                        forkRepository( name, credentials, session )
                    }
                }
            }
        }
        return -1
    }
}
//
//
//protocol URLSessionProtocol {
//    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?)
//}
//
//extension URLSession {
//    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?) {
//        var data: Data?
//        var response: URLResponse?
//        var error: Error?
//        
//        let semaphore = DispatchSemaphore(value: 0)
//        
//        let dataTask = self.dataTask(with: url) {
//            data = $0
//            response = $1
//            error = $2
//            
//            semaphore.signal()
//        }
//        dataTask.resume()
//        
//        _ = semaphore.wait(timeout: .distantFuture)
//        
//        return (data, response, error)
//    }
//}
