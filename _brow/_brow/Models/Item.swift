//
//  Item.swift
//  _brow
//
//  Created by victor willyam on 11/3/21.
//

import UIKit

class Item: NSObject {
    
    let nome: String
    let calorias: Double
    
    init(nome: String, calorias: Double) {
        self.nome = nome
        self.calorias = calorias
    }

}
