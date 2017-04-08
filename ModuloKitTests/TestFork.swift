//
//  TestFork.swift
//  modulo
//
//  Created by Dawson, Christopher on 4/7/17.
//  Copyright © 2017 TheHolyGrail. All rights reserved.
//

import XCTest
import ELCLI
import ELFoundation
import MockURLSession

import 
@testable import ModuloKit


class TestFork: XCTestCase {
    let modulo = Modulo()
    

    let session = MockURLSession()
    
    // Starting stub for mocking the GitHub API request
    func test_GET_RequestsTheURL() {
        
        
        // Inject the session to the target app code and the response will be mocked like below
//        let app = Modulo.init(session: session)
        app.doSomething()
        
        print(NSString(data:app.data!, encoding:NSUTF8StringEncoding)!)  // Foo 123
        print(app.error)    // nil
        
        // Make sure that the data task is resumed in the app code
        print(session.resumedResponse(MyApp.apiUrl) != nil)  // true
    }
    
    var session = nil
    
    override func setUp() {
        super.setUp()
        moduloReset()
        
        // Initialization
        session = MockURLSession()
        
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
        
        let result = Modulo.run(["fork", "--only", "test-add" ], session: session )
        XCTAssertTrue(result == .success)
        XCTAssertTrue(session)
    }
    
    // Only fork the specified module using except
    func testBasicForkWithoutSpecificPath() {
        let _ = Git().clone("git@github.com:modulo-dm/test-add.git", path: "test-add")
        let status = Git().clone("git@github.com:modulo-dm/test-add.git", path: "test2-add")
        XCTAssertTrue(status == .success)
        
        FileManager.setWorkingPath("test-add")
        
        let result = Modulo.run(["fork", "--except", "test2-add" ])
        XCTAssertTrue(result == .success)
    }
    
    
}

