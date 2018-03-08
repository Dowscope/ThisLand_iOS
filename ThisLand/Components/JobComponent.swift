//
//  JobComponent.swift
//  ThisLand
//
//  Created by Timothy Dowling on 2018-03-07.
//  Copyright © 2018 Timothy Dowling. All rights reserved.
//

import GameplayKit

enum JOB_TITLE {
    case GENERAL
    case FARMER
    case LUMBERJACK
}

class JobComponent: GKComponent {
    
    var title: JOB_TITLE
    
    init(type: JOB_TITLE) {
        title = type
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
