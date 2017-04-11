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
    
    public func configureOptions() {
//        addOptionValue(["--tag"], usage: "specify the version tag to use", valueSignature: "<tag>") { (option, value) -> Void in
//            if let value = value {
//                self.checkoutType = .tag(name: value)
//            }
//        }
//        
    }
    
    private func forkRepository( _ name: String, _ credentials: String ) { // , session: URLSessionProtocol ) {

        let urlPath:String = "https://api.github.com/v3"
        let url = NSURL(string: urlPath)
        let session = URLSession.shared
        print(url!)
        let _ = session.dataTask(with: url! as URL, completionHandler: {(data, reponse, error) in
            print("Task completed")
            // rest of the function...
        })
        
//        writeln(.stdout, "  \(name).")
    }
    
    private func getCredentials() -> String? {
        return "some oauth token..."
    }
    
//    private func getSessionFromOtherParams( _ otherParams: Array<String>? ) -> URLSessionProtocol? {
//        return HTTPClient()
//    }
    
    public func execute(_ otherParams: Array<String>?) -> Int {
        // get credentials from hub file or request

//        if let session = getSessionFromOtherParams( otherParams ) {
        if let credentials = getCredentials() {
        if let workingSpec = ModuleSpec.workingSpec() {
            let deps = workingSpec.allDependencies()
            deps.forEach { (dependency) in
                let name = dependency.name()
                forkRepository( name, credentials )//, session )
            }
            }
//        }
        }
        return -1
    }
}
