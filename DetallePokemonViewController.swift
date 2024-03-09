//
//  DetallePokemonViewController.swift
//  PokedexApp
//
//  Created by Samuel Cíes Gracia on 9/3/24.
//

import UIKit

class DetallePokemonViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imagenPokemon: UIImageView!
    @IBOutlet weak var tipoPokemon: UILabel!
    @IBOutlet weak var descripcionPokemon: UITextView!
    @IBOutlet weak var ataquePokemon: UILabel!
    @IBOutlet weak var defensaPokemon: UILabel!
    
    // variables
    var pokemonMostrar: Pokemon?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Imagen a mostrar
        imagenPokemon.loadFrom(URLAddress: pokemonMostrar?.imageUrl ?? "")
        
        
        tipoPokemon.text = "Tipo: \(pokemonMostrar?.type ?? "")"
        ataquePokemon.text = "Ataque: \(pokemonMostrar!.attack)"
        defensaPokemon.text = "Defensa: \(pokemonMostrar!.defense)"
        descripcionPokemon.text = "Ataque: \(pokemonMostrar?.description ?? "")"
    }
}

extension UIImageView{
    func loadFrom(URLAddress: String){
        guard let url = URL(string: URLAddress) else { return }
        
        DispatchQueue.main.async { [weak self] in
            if let imagenData = try? Data(contentsOf: url){
                if let loadedImage = UIImage(data: imagenData){
                    self?.image = loadedImage
                    
                }
            }
        }
    }
}
