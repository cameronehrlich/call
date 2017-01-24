//
//  main.swift
//  call
//
//  Created by Cameron Ehrlich on 3/26/16.
//  Copyright © 2016 Thirty Seven. All rights reserved.
//

import Foundation
import Darwin

extension String {
    
    func digitsOnly() -> String {

        let stringArray = self.components(
            separatedBy: CharacterSet.decimalDigits.inverted)
        let newString = stringArray.joined(separator: "")
        
        return newString
    }
}



var numberToCall: String = CommandLine.arguments.joined(separator: "")

NSLog("tell://%@&includeAudio=%@", numberToCall, "true")

numberToCall = numberToCall.digitsOnly()

if numberToCall.characters.count == 0 {
    print("Invalid number")
    exit(0)
}

let myAppleScript = "open location \"tel://\(numberToCall)?audio=yes\""

var error: NSDictionary?
if let scriptObject = NSAppleScript(source: myAppleScript) {
    if let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error) {
        print("Calling \(numberToCall)...")
    }
    else if (error != nil) {
        print("error: \(error)")
    }
}

exit(0)

