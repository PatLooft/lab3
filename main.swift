//
//  main.swift
//  lab3
//
//  Created by Pat Looft on 3/12/19.
//  Copyright © 2019 Pat Looft. All rights reserved.
//

import Foundation

var stores: Bookstore;
stores = Bookstore()!;

var b = Book(theTitle: "test", pages: 0, cost: 3, num: 1)!;

stores.startStore();
stores.displayPrompt();


