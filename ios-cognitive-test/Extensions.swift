//
//  Extensions.swift
//  ios-cognitive-test
//
//  Created by Francisco on 2018-11-02.
//  Copyright © 2018 franciscoigor. All rights reserved.
//

import Foundation


extension NSArray {
    
    func shuffleData() -> NSArray{
        let copy = self.mutableCopy() as! NSMutableArray
        let result = NSMutableArray();
        while(copy.count>0){
            let pos = Int(arc4random()) % (copy.count)
            result.add(copy[pos])
            copy.removeObject(at: pos)
        }
        return result
    }
}

extension Array {
    
    func shuffleData() -> Array{
        var copy = Array(self)
        var result = Array();
        while(copy.count>0){
            let pos = Int(arc4random()) % (copy.count)
            result.append(copy[pos])
            copy.remove(at: pos)
        }
        return result
    }
}

extension String {
    
    func shuffle() -> String {
        var letters = Array(self)
        letters = letters.shuffleData()
        return String(letters)
    }
}
