//
//  MovizUITests.swift
//  MovizUITests
//
//  Created by Li Hao Lai on 31/10/20.
//

import Foundation
import Cucumberish

public class CucumberishInitializer: NSObject {
    @objc public class func CucumberishSwiftInit() {
        //Using XCUIApplication only available in XCUI test targets not the normal Unit test targets.
        var application : XCUIApplication!
        //A closure that will be executed only before executing any of your features
        beforeStart { () -> Void in
            application = XCUIApplication()
        }
        
        //A Given step definition
        Given("user start the application") { (args, userInfo) -> Void in
            application.launch()
        }
        //Another step definition
        When("user land on the Discover list") { (args, userInfo) -> Void in
            XCTAssert(application.staticTexts["Discover"].waitForExistence(timeout: 10))
        }
        //Result
        Then("user should see at least 1 movie in the list") { (args, userInfo) -> Void in
            XCTAssert(application.tables.children(matching: .cell).count > 0)
        }
        
        //Create a bundle for the folder that contains your "Features" folder. In this example, the CucumberishInitializer.swift file is in the same directory as the "Features" folder.
        let bundle = Bundle(for: CucumberishInitializer.self)
        
        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: nil, excludeTags: nil)
    }
}
