
import UIKit

class MovieDetailViewController : UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = movie?.title
        self.descriptionLabel.text = movie?.description
        self.descriptionLabel.sizeToFit()
    }
}
