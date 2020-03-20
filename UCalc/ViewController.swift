//
//  ViewController.swift
//  UCalc
//
//  Created by Eduardo Lopes de Carvalho on 02/03/20.
//  Copyright © 2020 Eduardo Lopes de Carvalho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        opcoesGastos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return opcoesGastos[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = opcoesGastos[row]
        pickerTextField.resignFirstResponder()
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naturezaPicker.delegate = self
        naturezaPicker.dataSource = self
        valorCorrida.delegate = self
        valorRecebido.delegate = self
        valorGasto.delegate = self
        pickerTextField.inputView = naturezaPicker
        pickerTextField.textAlignment = .center
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var valorCorrida: UITextField!
    @IBOutlet var valorRecebido: UITextField!
    @IBOutlet var troco: UITextField!
    @IBOutlet var listaValor: UILabel!
    @IBOutlet var listaCorrida: UILabel!
    @IBOutlet var listaTroco: UILabel!
    @IBOutlet var totalGanhos: UILabel!
    @IBOutlet var valorGasto: UITextField!
    @IBOutlet var listaGastos: UILabel!
    @IBOutlet var totalGastos: UILabel!
    @IBOutlet var notaBotao: UIButton!
    @IBOutlet var listaNatureza: UILabel!
    @IBOutlet var pickerTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    let opcoesGastos: [String] = ["Gasolina", "Reparos", "Limpeza", "etc"]
    var naturezaPicker = UIPickerView()
    
    
    
    @IBAction func salvar(_ sender: Any) {
        salvarApagar()
    }
    
    func salvarApagar(){
        listaNatureza.text = ""
        listaGastos.text = ""
        listaTroco.text = ""
        listaValor.text = ""
        listaCorrida.text = ""
        notaBotao.setTitle("$   00.00", for: .normal)
        totalGastos.text = "0.0"
        totalGanhos.text = "0.0"
        
    }
    
    @IBAction func recebidoChanged(_ sender: Any) {
        preencherTroco()
        
    }
    
    
    func preencherTroco() {
        var corrida: Float
        let corridaTexto = valorCorrida.text!
        
        var recebido: Float
        let recebidoTexto = valorRecebido.text!
        
        var trocoNum: Float
        
        
        corrida = Float(corridaTexto)!
        recebido = Float(recebidoTexto) ?? 0.0
        trocoNum = recebido - corrida
        
        if recebido == 0.0 {
            troco.text = String(format: "%.2f", trocoNum)
            
        }
        troco.text = String(format: "%.2f", trocoNum)
        
        
        
    }
    
    @IBAction func botaoMais(_ sender: Any) {
        adicionarGanho()
    }
    func adicionarGanho(){
        
        var ganhoTexto = valorCorrida.text!
        let ganhoAntes = listaCorrida.text!
        var listaGanhosFloat: Float = 0.0
        let totalTexto: String = totalGanhos.text!
        
        var recebidoTexto = valorRecebido.text!
        let recebidoAntes = listaValor.text!
        var listaRecebidosFloat: Float = 0.0
        
        let trocoTexto = troco.text!
        let trocoAntes = listaTroco.text!
        
        var totalFloat: Float = 0.0
        
        listaGanhosFloat = Float(ganhoTexto)!
        ganhoTexto = String(format: "%.2f", listaGanhosFloat)
        listaCorrida.text = ganhoTexto + "\n" + ganhoAntes
        
        totalFloat = Float(totalTexto)! + listaGanhosFloat
        
        totalGanhos.text = String(format: "%.2f", totalFloat)
        
        if recebidoTexto == ""{
            
        }
        else{
            
            listaRecebidosFloat = Float(recebidoTexto)!
            recebidoTexto = String(format: "%.2f", listaRecebidosFloat)
        }
        listaValor.text = recebidoTexto + "\n" + recebidoAntes
        
        
        atualizarNota()
        
        if troco.text == "troco" {
            listaTroco.text = "\n" + trocoAntes
            
        }
        else {
            listaTroco.text = trocoTexto + "\n" + trocoAntes
        }
        
        valorCorrida.text = ""
        valorRecebido.text = ""
        troco.text = "troco"
    }
    
    
    @IBAction func botaoMenos(_ sender: Any) {
        adicionarGasto()
    }
    func adicionarGasto(){
        var gastoTexto = valorGasto.text!
        let gastosAntes = listaGastos.text!
        var listaGastosFloat: Float = 0.0
        let totalTexto: String = totalGastos.text!
        var totalFloat: Float = 0.0
        let pickerTexto = pickerTextField.text!
        let naturezaAntes = listaNatureza.text!
        
        listaGastosFloat = Float(gastoTexto)!
        totalFloat = Float(totalTexto)! + listaGastosFloat
        
        totalGastos.text = String(format: "%.2f", totalFloat)
        
        listaGastosFloat = Float(gastoTexto)!
        gastoTexto = String(format: "%.2f", listaGastosFloat)
        listaGastos.text = gastoTexto + "\n" + gastosAntes
        
        listaNatureza.text = pickerTexto + "\n" + naturezaAntes
        
        atualizarNota()
        
        valorGasto.text = ""
        
    }
    
    func atualizarNota() {
        let totalGastoTexto = totalGastos.text
        let totalGanhoTexto = totalGanhos.text
        var totalGastosFloat: Float = 0.0
        var totalGanhosFloat: Float = 0.0
        var tituloNota: String
        var somaNota: Float = 0.0
        
        totalGastosFloat = Float(totalGastoTexto!) ?? 0.0
        totalGanhosFloat = Float(totalGanhoTexto!) ?? 0.0
        somaNota = totalGanhosFloat - totalGastosFloat
        tituloNota = "$  " + String(format: "%.2f", somaNota)
        
        notaBotao.setTitle(tituloNota, for: .normal)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        valorCorrida.resignFirstResponder()
        valorRecebido.resignFirstResponder()
        valorGasto.resignFirstResponder()
        return true
    }
    
    
    @IBAction func abaixarTeclado(_ sender: Any) {
        valorCorrida.resignFirstResponder()
        valorRecebido.resignFirstResponder()
        valorGasto.resignFirstResponder()
    }
    
}

