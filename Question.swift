//
//  Question.swift
//  Finalproject_AM
//
//  Created by Alexander Truong McNulty on 6/12/18.
//  Copyright © 2018 Alexander Truong McNulty. All rights reserved.
//

import UIKit

class Question: NSObject {
    var prompt = ""
    var expanded = false
    var answers: [Int] = []
    init(prompt: String, expanded: Bool){
        self.prompt = prompt
        self.expanded = expanded
        self.answers = []
    }
    init(prompt: String, expanded: Bool, answers: [Int]) {
        self.prompt = prompt
        self.expanded = expanded
        self.answers = answers
    }
    init(q: Question) {
        self.prompt = q.prompt
        self.expanded = q.expanded
        self.answers = q.answers
    }
}
