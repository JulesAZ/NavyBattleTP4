//
//  Gameboard.swift
//  NavyBattle
//
//  Created by Jules AZEMAR on 02/02/2018.
//  Copyright © 2018 Richard Bergoin. All rights reserved.
//

import Foundation

struct Gameboard{
    
    let board: [CasePosition: Gameboard.CaseState]
    
    let lines = (1...10).map({ return $0 })
    let columns = "ABCDEFGHIJ".map({ return $0 })
    
    enum CaseState: Character {
        case white = "O"
        case red = "X"
    }
    
    func displayBoard(gameBoard: [CasePosition: CaseState]) {
        var headline = "  "
        for column in columns {
            headline += "|\(column)"
        }
        headline += "|"
        print(headline)
        for line in lines {
            var printLine = String(format: "%*2d", 2, line) // https://en.wikipedia.org/wiki/Printf_format_string
            printLine += "|"
            for column in columns {
                let casePosition = CasePosition(line: line, column: column)
                var character: Character = " "
                if let caseState = board[casePosition] {
                    character = caseState.rawValue
                }
                printLine.append(character)
                printLine += "|"
            }
            print(printLine)
        }
    }
    
    func allShipsStriked(ships: [Ship], board: [CasePosition: Gameboard.CaseState]) -> Bool {
        var allShipsStriked = true
        for ship in ships {
            if ship.isShipEntirelyStriked(gameBoard: gameBoard) == false {
                allShipsStriked = false
                break
            }
        }
        return allShipsStriked
    }
    
    func isAShipAtThisPosition(_ casePosition: CasePosition, ships: [Ship]) -> Ship? {
        for ship in ships {
            if ship.isAt(casePosition: casePosition) {
                return ship
            }
        }
        return nil
    }
    
    func nextPositionToPlayWillBeAtRight(previousOne: CasePosition?) -> CasePosition {
        if let previousOne = previousOne {
            if previousOne.line == 10 {
                let index = columns.index(of: previousOne.column)! + 1
                let column = columns[index]
                return CasePosition(line: 1, column: column)
            } else {
                return CasePosition(line: previousOne.line + 1, column: previousOne.column)
            }
        } else {
            return CasePosition(line: 1, column: "A")
        }
    }
    func positionShips() -> [Ship] {
        let contreTorpilleurCases = [CasePosition(line: 1, column: "B"), CasePosition(line: 2, column: "B"), CasePosition(line: 3, column: "B")]
        let contreTorpilleur = Ship(cases: contreTorpilleurCases)
        let torpilleurCases = [CasePosition(line: 4, column: "E"), CasePosition(line: 4, column: "F")]
        let torpilleur = Ship(cases: torpilleurCases)
        return [torpilleur, contreTorpilleur]
    }
}
