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
    
    var length : Int {
        return self.characters.count
    }
    
    func digitsOnly() -> String{
        let stringArray = self.componentsSeparatedByCharactersInSet(
            NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        let newString = stringArray.joinWithSeparator("")
        
        return newString
    }
    
}

var numberToCall :String? = ""

for argument in Process.arguments {
    numberToCall = numberToCall! + argument
}

numberToCall = numberToCall!.digitsOnly()

if numberToCall?.length == 0 {
    print("Invalid number")
    exit(0)
}

let myAppleScript = "open location \"tel://\(numberToCall!)?audio=yes\""

var error: NSDictionary?
if let scriptObject = NSAppleScript(source: myAppleScript) {
    if let output: NSAppleEventDescriptor = scriptObject.executeAndReturnError(&error) {
        print("Calling \(numberToCall!)...")
    }
    else if (error != nil) {
        print("error: \(error)")
    }
}

exit(0)

