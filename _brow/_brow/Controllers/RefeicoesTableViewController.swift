//
//  TableViewController.swift
//  _brow
//
//  Created by victor willyam on 11/9/21.
//

import Foundation
import UIKit

class RefeicoesTableViewController: UITableViewController, AdicionaRefeicaoDelegate {
    
    var refeicoes = [Refeicao(nome: "Macarrão", felicidade: 3),
                     Refeicao(nome: "Feijão", felicidade: 1),
                     Refeicao(nome: "Quijo", felicidade: 4),
                     Refeicao(nome: "Goiabada", felicidade: 5)]
    
       
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return refeicoes.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        let refeicao = refeicoes[indexPath.row]
        celula.textLabel?.text = refeicao.nome
        
                
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(mostrarDetalhes(_:)))
        celula.addGestureRecognizer(longPress)
        
        return celula
    }
    
    func add(_ refeicao:  Refeicao) {
        refeicoes.append(refeicao)
        tableView.reloadData()
        
    }
    
    @objc func mostrarDetalhes(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let celula = gesture.view as! UITableViewCell
            guard let indexPath = tableView.indexPath(for: celula) else { return }
            let refeicao = refeicoes[indexPath.row]
                                                   
            let alerta = UIAlertController(title: refeicao.nome, message: refeicao.detalhes(), preferredStyle: .alert)
            let botaoCancelar = UIAlertAction(title: "ok", style: .cancel)
            alerta.addAction(botaoCancelar)
            let botaoRemover = UIAlertAction(title: "remover", style: .destructive, handler: { alerta in
                self.refeicoes.remove(at: indexPath.row)
                self.tableView.reloadData()
            })
            
            alerta.addAction(botaoRemover)
            
            present(alerta, animated: true, completion: nil)
        }
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "adicionar" {
            if let viewController = segue.destination as? ViewController {
                viewController.delegate = self
            } 
        }
    }
}
        
