//
//  iPharmaApp2UITests.swift
//  iPharmaApp2UITests
//
//  Created by LakshithaS on 2025-05-02.
//

import XCTest

final class iPharmaApp2UITests: XCTestCase {

    let app = XCUIApplication()

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    func testConfirmOrderFlow() {
        // Step 1: Wait for the menu item using its static text
        let acceptedPrescriptionsItem = app.staticTexts["Accepted Prescriptions"]
        XCTAssertTrue(acceptedPrescriptionsItem.waitForExistence(timeout: 5), "Accepted Prescriptions menu not found")
        acceptedPrescriptionsItem.tap()

        // Step 2: Try to tap "Confirm Order" if it exists
        let confirmButton = app.buttons["Confirm Order"]
        if confirmButton.waitForExistence(timeout: 5) {
            confirmButton.tap()
        }

        // Step 3: Expect to see the PIN label
        let pinLabel = app.staticTexts.containing(NSPredicate(format: "label BEGINSWITH 'Your Pickup PIN:'")).firstMatch
        XCTAssertTrue(pinLabel.waitForExistence(timeout: 5), "PIN label not found after confirming order")
    }
}

