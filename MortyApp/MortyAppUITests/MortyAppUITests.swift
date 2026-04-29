//
//  MortyAppUITests.swift
//  MortyAppUITests
//
//  Created by angel aquino on 28/04/26.
//

import XCTest

final class MortyAppUITests: XCTestCase {

    func test_full_character_flow() {

        let app = XCUIApplication()
        app.launch()

        // 🔍 SEARCH
        let searchField = app.searchFields.firstMatch
        XCTAssertTrue(searchField.waitForExistence(timeout: 5))

        searchField.tap()
        searchField.typeText("Rick")

        // 📱 RESULTADO
        let cell = app.staticTexts["Rick Sanchez"]
        XCTAssertTrue(cell.waitForExistence(timeout: 5))

        // 👉 ENTRAR DETALLE
        cell.tap()

        // ❤️ FAVORITO (USANDO IDENTIFIER CORRECTO)
        let favoriteButton = app.buttons["favorite_button"]
        XCTAssertTrue(favoriteButton.waitForExistence(timeout: 5))
        favoriteButton.tap()

        // 🗺 MAPA
        let mapButton = app.buttons["View on Map"]
        XCTAssertTrue(mapButton.waitForExistence(timeout: 5))
        mapButton.tap()
    }
}
