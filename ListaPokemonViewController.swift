//
//  ViewController.swift
//  PokedexApp
//
//  Created by Samuel Cíes Gracia on 9/3/24.
//

import UIKit

class ListaPokemonViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tablaPokemon: UITableView!
    @IBOutlet weak var searchbBarPokemon: UISearchBar!
    
    // MARK: - Variables
    var pokemonManager = PokemonManager()
    var pokemonSeleccionado: Pokemon?
    var pokemons: [Pokemon] = []
    var pokemonFiltrados: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Registrar la nueva celda
        tablaPokemon.register(UINib(nibName: "CeldaPokemonTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        pokemonManager.delegado = self
        searchbBarPokemon.delegate = self
    
        tablaPokemon.delegate = self
        tablaPokemon.dataSource = self
        
        // Ejecutar el método para buscar la lista de pokemon
        pokemonManager.varPokemon()
        
        pokemonFiltrados = pokemons
    }

    
}
// MARK: - SearchBar
extension ListaPokemonViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pokemonFiltrados = []
        
        if searchText == ""{
            pokemonFiltrados = pokemons
        }else{
            for pokemonIndex in pokemons{
                if pokemonIndex.name.lowercased().contains(searchText.lowercased()){
                    pokemonFiltrados.append(pokemonIndex)
                }
            }
        }
        self.tablaPokemon.reloadData()
    }
}


// MARK: - Delegado Pokemon
extension ListaPokemonViewController: pokemonManagerDelegado{
    func mostrarListaPokemon(lista: [Pokemon]) {
        pokemons = lista
        
        DispatchQueue.main.async{
            self.pokemonFiltrados = lista
            self.tablaPokemon.reloadData()
        }
        
    }
}

// MARK: - Tabla
extension ListaPokemonViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pokemonFiltrados.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda =  tablaPokemon.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! CeldaPokemonTableViewCell
        
        celda.nombrePokemon.text = pokemonFiltrados[indexPath.row].name
        celda.ataquePokemon.text = "Ataque: \(pokemonFiltrados[indexPath.row].attack)"
        celda.defensaPokemon.text = "Defensa: \(pokemonFiltrados[indexPath.row].defense)"
        
        // Celda imagen desde URL
        if let urlString = pokemonFiltrados[indexPath.row].imageUrl as? String{
            if let imagenURL = URL(string: urlString){
                DispatchQueue.global().async{
                    guard let imagenData = try? Data(contentsOf: imagenURL) else{
                        return
                    }
                    let image = UIImage(data: imagenData)
                    DispatchQueue.main.async{
                        celda.imagenPokemon.image = image
                    }
                }
            }
        }
        
        return celda
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonSeleccionado = pokemonFiltrados[indexPath.row]
        
        performSegue(withIdentifier: "verPokemon", sender: self)
        
        //Deselccionar
        tablaPokemon.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "verPokemon"{
            let verPokemon = segue.destination as! DetallePokemonViewController
            
            verPokemon.pokemonMostrar = pokemonSeleccionado
                
            }
        }
}

