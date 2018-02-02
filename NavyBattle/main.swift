//
//  main.swift
//  NavyBattle
//
//  Created by Richard Bergoin on 26/01/2017.
//  Copyright © 2017 Richard Bergoin. All rights reserved.
//

import Foundation



typealias NextCasePositionToPlay = (_: CasePosition?) -> CasePosition





func main(_ nextCasePositionToPlay: gameboard.NextCasePositionToPlay) {
    var gameBoard = [CasePosition : Gameboard.CaseState]()
    let ships = gameBoard.positionShips()
    var lastCasePositionPlayed: CasePosition?
    repeat {
        var playingAt = "Playing at "
        let caseToPlay = nextCasePositionToPlay(lastCasePositionPlayed)
        playingAt += "\(caseToPlay.description)... "
        if let ship = isAShipAtThisPosition(caseToPlay, ships: ships) {
            gameBoard[caseToPlay] = .red
            if isShipEntirelyStriked(ship, gameBoard: gameBoard) {
                playingAt += "\(ship.description) coulé"
            } else {
                playingAt += "\(ship.description) touché"
            }
        } else {
            gameBoard[caseToPlay] = .white
            playingAt += "À l'eau"
        }
        lastCasePositionPlayed = caseToPlay
        print(playingAt)
        gameBoard.displayBoard(gameBoard: gameBoard)
    } while allShipsStricked(ships: ships, gameBoard: gameBoard) == false
}

main(nextPositionToPlayWillBeAtRight(previousOne:))
