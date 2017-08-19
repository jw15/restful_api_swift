//
//  MovieTableViewController.swift
//  restful_api
//
//  Created by railsbridge on 8/19/17.
//  Copyright © 2017 railsbridge. All rights reserved.
//

import UIKit

class MovieTableViewController : UITableViewController {
    
    var movies:Array<Movie> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("view loaded")
        self.title = "Some Cool Movies!"
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=552e16fd60d4278110ee09fa4410f7d2")!
        
        let sessionTask = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            
            switch httpResponse.statusCode {
            case 200:
                if let movieJSON = try? JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                if let results = movieJSON!["results"] as? [[String: Any]] {
                    print(results)
                    for movieHash in results {
                        let posterPath = movieHash["poster_path"] as! String
                        
                        let movie = Movie(
                            title: movieHash["title"] as! String,
                            description: movieHash["overview"] as! String,
                            posterURL: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)?api_key=552e16fd60d4278110ee09fa4410f7d2")!
                        )
                        self.movies.append(movie)
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } else {
                    print("bad json!")
                    }
            
            default:
                print("bad response!")
            }
        })
        
        sessionTask.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = self.movies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieTableViewCell
        
        cell.titleLabel.text = movie.title
        cell.descriptionLabel.text = movie.description
        cell.posterImage.image = nil
        
        cell.posterURL = movie.posterURL
        
        downloadImageForCell(imageUrl: movie.posterURL, cell: cell)

        //cell.textLabel?.text = "I am cell \(indexPath.row)"
        
        return cell
    }
    func downloadImageForCell(imageUrl: URL, cell: MovieTableViewCell) {
        let sessionTask = URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            
            switch httpResponse.statusCode {
            case 200:
                let image = UIImage(data: data!)!
                if cell.posterURL == imageUrl {
                    DispatchQueue.main.async {
                        cell.posterImage.image = image
                    }
                }
            default:
                print("not 200!")
            }
        })
        
        sessionTask.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifer == "MovieDetailSegue"
        if let movieDetailVC = segue.destination as? MovieDetailViewController {
            
            movieDetailVC.movie = movies[self.tableView.indexPathForSelectedRow!.row]
        }
        }
    }
