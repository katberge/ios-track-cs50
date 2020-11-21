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
        
        let url = URL(string: pokemon.url)
        guard let u = url else {
            return
        }
        
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonData.self, from: data)
                self.nameLabel.text = self.pokemon.name
                self.numberLabel.text = String(format: "#%03d", pokemonData.id)
            }
            catch let error {
                print(error)
            }
        }.resume()
    }
}
