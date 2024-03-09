//
//  CeldaPokemonTableViewCell.swift
//  PokedexApp
//
//  Created by Samuel Cíes Gracia on 9/3/24.
//

import UIKit

class CeldaPokemonTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var ataquePokemon: UILabel!
    @IBOutlet weak var defensaPokemon: UILabel!
    @IBOutlet weak var nombrePokemon: UILabel!
    @IBOutlet weak var imagenPokemon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imagenPokemon.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
