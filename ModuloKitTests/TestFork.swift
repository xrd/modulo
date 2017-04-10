
//  TestFork.swift
//  modulo
//
//  Created by Dawson, Christopher on 4/7/17.
//  Copyright © 2017 TheHolyGrail. All rights reserved.
//

import XCTest
import ELCLI
import ELFoundation
//@testable
import MockURLSession
@testable import ModuloKit


class TestFork: XCTestCase {
    let modulo = Modulo()
    var mockUrlSession = nil
    
    override func setUp() {
        super.setUp()
        moduloReset()
        
        // Initialization
        mockUrlSession = MockURLSession()
        
        // Setup a mock response, need to fix this a bit, not the right API call OBVSLY!
        let data = "{ \"fork\": \"me\", \"on\": \"github\" }".dataUsingEncoding(NSUTF8StringEncoding)!
        session.registerMockResponse( "https://api.github.com/v2", data:data)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasicFork() {
        let status = Git().clone("git@github.com:modulo-dm/test-add.git", path: "test-add")
        XCTAssertTrue(status == .success)
        
        FileManager.setWorkingPath("test-add")
        
        let result = Modulo.run(["fork"])
        XCTAssertTrue(result == .success)
    }
    
    // Only fork the specified module
    //
    // Does it make sense to allow the user to only fork some of the modules to work on?
    //
    func testBasicForkWithSpecificPath() {
        let status = Git().clone("git@github.com:modulo-dm/test-add.git", path: "test-add")
        XCTAssertTrue(status == .success)
        
        FileManager.setWorkingPath("test-add")
        
        let result = Modulo.run(["fork", "--only", "test-add" ], session: mockUrlSession )
        XCTAssertTrue(result == .success)
        
        // Let's verify that the session got what was supposed to happen
        XCTAssertTrue(session)
        
        print(session.resumedResponse(MyApp.apiUrl) != nil)  // true
    }
    
    // Only fork the specified module using except
    func testBasicForkWithoutSpecificPath() {
        let _ = Git().clone("git@github.com:modulo-dm/test-add.git", path: "test-add")
        let status = Git().clone("git@github.com:modulo-dm/test-add.git", path: "test2-add")
        XCTAssertTrue(status == .success)
        
        FileManager.setWorkingPath("test-add")
        
        let result = Modulo.run(["fork", "--except", "test2-add" ], session: mockUrlSession )
        XCTAssertTrue(result == .success)
    }
    
    
}

