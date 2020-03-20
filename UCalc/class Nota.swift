//
//  class Nota.swift
//  UCalc
//
//  Created by Eduardo Lopes de Carvalho on 10/03/20.
//  Copyright © 2020 Eduardo Lopes de Carvalho. All rights reserved.
//

import Foundation

class Nota {
var ganhos: Float
var gastos: Float

init(ganhos: Float, gastos: Float) {
    self.ganhos = ganhos
    self.gastos = gastos
}

func total () -> String{
    var total: Float
    total = ganhos - gastos
    
    return String(format: "%.2f", total)
}
}
