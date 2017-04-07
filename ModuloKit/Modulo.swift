//
//  Modulo.swift
//  ModuloKit
//
//  Created by Brandon Sneed on 6/15/16.
//  Copyright © 2016 TheHolyGrail. All rights reserved.
//

import Foundation

#if NOFRAMEWORKS
#else
    import ELCLI
    import ELFoundation
#endif

@objc
open class Modulo: NSObject {
    
    open static func run() {
        let error = run([])
        exit(Int32(error.rawValue))
    }
    
    open static func run(_ args: [String]) -> ErrorCode {
        let cli = CLI(name: "modulo", version: "1.0", description: "A simple dependency manager")
        
        if args.count > 0 {
            cli.allArgumentsToExecutable = args
        }
        
        cli.addCommands([InitCommand(), AddCommand(), UpdateCommand(), StatusCommand(), MapCommand(), SetCommand(), ForkCommand()])
        
        if let error = ErrorCode(rawValue: cli.run()) {
            if error == .success {
                State.instance.showFinalInformation()
            }
            
            return error
        }
        
        return ErrorCode.unknownError
    }
}
