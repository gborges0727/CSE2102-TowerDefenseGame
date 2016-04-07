//
//  TravelPoint.swift
//  SWTowerDefense
//
//  Created by Gabriel Borges on 4/6/16.
//  Copyright (c) 2016 Gabe Borges. All rights reserved.
//

import SpriteKit

class TravelPoint {
    var nextPoint = TravelPoint()
    
    // Constructor used to
    convenience init(nextPoint: TravelPoint) {
        self.init()
        self.nextPoint = nextPoint
    }
}
