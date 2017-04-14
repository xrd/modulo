//
//  UrlSessionProtocol.swift
//  modulo
//
//  Created by Dawson, Christopher on 4/14/17.
//  Copyright © 2017 TheHolyGrail. All rights reserved.
//

import Foundation

public protocol URLSessionProtocol {
    func synchronousDataTask( _ url: URL ) -> ( Data?, URLResponse?, Error? )
}

