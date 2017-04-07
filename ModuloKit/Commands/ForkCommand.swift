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
    
    private func forkRepository( _ name: String, _ credentials: String ) {
        // make the JSON request to github with the fork command
          writeln(.stdout, "  \(name).")
    }
    
    private func getCredentials() -> String? {
        return "some oauth token..."
    }
    
    public func execute(_ otherParams: Array<String>?) -> Int {
        // get credentials from hub file or request
        if let credentials = getCredentials() {
        if let workingSpec = ModuleSpec.workingSpec() {
            let deps = workingSpec.allDependencies()
            deps.forEach { (dependency) in
                let name = dependency.name()
                forkRepository( name, credentials )
            }
        }
        }
        return -1
    }
}
