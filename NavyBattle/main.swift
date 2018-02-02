//
//  main.swift
//  NavyBattle
//
//  Created by Richard Bergoin on 26/01/2017.
//  Copyright © 2017 Richard Bergoin. All rights reserved.
//

import Foundation



typealias NextCasePositionToPlay = (_: CasePosition?) -> CasePosition


var gameBoard = [CasePosition : Gameboard.CaseState]()


func main(_ nextCasePositionToPlay: gameBoard.NextCasePositionToPlay) {
    
    let ships = gameBoard.positionShips()
    var lastCasePositionPlayed: CasePosition?
    repeat {
        var playingAt = "Playing at "
        let caseToPlay = gameBoard.nextCasePositionToPlay(lastCasePositionPlayed)
        playingAt += "\(caseToPlay.description)... "
        if let ship = gameBoard.isAShipAtThisPosition(caseToPlay, ships: ships) {
            gameBoard[caseToPlay] = .red
            if isShipEntirelyStriked(ship, gameBoard: Gameboard) {
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
    } while gameBoard.allShipsStriked(ships: ships) == false
}

main(nextPositionToPlayWillBeAtRight(previousOne:))
