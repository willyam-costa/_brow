//
//  ViewController.swift
//  _brow
//
//  Created by victor willyam on 11/3/21.
//

import UIKit

protocol AdicionaRefeicaoDelegate {
    func add(_ refeicao: Refeicao)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AdicionaItensDelegate {
   
    
    // MARK: - IBOutlet
    
    @IBOutlet var itensTableVIew: UITableView?
    
    
    // MARK: - Atributos
    
    var delegate: AdicionaRefeicaoDelegate?
    var itens: [Item] = [Item(nome: "picadinho de custela", calorias: 44.5),
                         Item(nome: "Queijo Cotage", calorias: 47.5),
                         Item(nome: "A bunda da Morena", calorias: 1004.5),
                         Item(nome: "Alface", calorias: 7.5)]
    
    var itensSelecionados: [Item] = []
    
    // MARK: - IBOutlet
    
   @IBOutlet var nomeTextField: UITextField?
   @IBOutlet weak var felicidadeTextField: UITextField?
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        let botaoAdicionaItem = UIBarButtonItem(title: "adicionar", style: .plain, target: self, action: #selector(adicionarItem))
        
        navigationItem.rightBarButtonItem = botaoAdicionaItem
    }
    
    @objc func adicionarItem() {
        let adicionarItensVIewController = AdicionarItensViewController(delegate: self)
        navigationController?.pushViewController(adicionarItensVIewController, animated: true)
    }
    
    func add(_ item: Item) {
        itens.append(item)
        if let tableView = itensTableVIew {
            tableView.reloadData()
        } else {
            Alerta(controller: self).exibe(titulo: "Desculpe", mensagem: "não foi possível atualizar a tabela")
        }
    }
       
    // MARK: - UITableViewDataSoucer
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        let linhaDaTabela = indexPath.row
        
        let item = itens[linhaDaTabela]
        
        celula.textLabel?.text = item.nome
        
        return celula
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let celula = tableView.cellForRow(at: indexPath) else { return }
        if celula.accessoryType == .none {
            celula.accessoryType = .checkmark
            let linhaDaTabela = indexPath.row
            itensSelecionados.append(itens[linhaDaTabela])
        } else {
            celula.accessoryType = .none
            
            let item = itens[indexPath.row]
            if let position = itensSelecionados.index(of: item) {
                itensSelecionados.remove(at: position)
                
                
            }
        }
                
    }
    
    func recuperaRefeicaoDoFormulario() -> Refeicao? {
       
        guard let nomeDaRefeicao = nomeTextField?.text else {
            return nil
            
            }
        
        guard let felicidadeDaRefeicao = felicidadeTextField?.text, let felicidade = Int(felicidadeDaRefeicao) else {
            return nil
            
        }
        
        let refeicao = Refeicao(nome: nomeDaRefeicao, felicidade: felicidade, itens: itensSelecionados)
        
        return refeicao
    }
    
    // MARK: - IBActions
    
    @IBAction func adicionar() {
        guard let refeicao = recuperaRefeicaoDoFormulario() else {
            return Alerta(controller: self).exibe(mensagem: "Erro ao ler dados do formulário")
            
        }
        delegate?.add(refeicao)
        navigationController?.popViewController(animated: true)
    }
}

