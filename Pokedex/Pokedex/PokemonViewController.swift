//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Kat Berge on 11/20/20.
//  Copyright © 2020 Kat Berge. All rights reserved.
//

import UIKit


class PokemonViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = pokemon.name
        numberLabel.text = String(pokemon.number)
    }
}
