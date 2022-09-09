//
//  ViewController.swift
//  CompositionLayout
//
//  Created by Atul Dhiman on 05/09/22.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {

    @IBOutlet weak var collection: UICollectionView!
    let headerId = "headerId"
    static let categoryHeaderId = "categoryHeaderId"
    let movieViewModel = MovieViewModel()
    var moviedata = [ResultModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.MovieGrid()
        self.navigationItem.title = "Hotstar    "
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    private func reloaddata(){
        DispatchQueue.main.async {
            self.collection.reloadData()
            self.moviedata.count
        }
    }
    func MovieGrid(){
        movieViewModel.parse{
            values in
            self.moviedata = values
            self.reloaddata()
        }
    }
    func setupCollectionView() {

        self.collection.register(Header.self, forSupplementaryViewOfKind: ViewController.categoryHeaderId, withReuseIdentifier: headerId)
        self.collection.register(UINib(nibName: "SectionCell", bundle: nil), forCellWithReuseIdentifier: "SectionCell")
        self.collection.register(UINib(nibName: "SectionTwo", bundle: nil), forCellWithReuseIdentifier: "SectionTwo")
        self.collection.register(UINib(nibName: "SectionThree", bundle: nil), forCellWithReuseIdentifier: "SectionThree")
        //self.collection.register(UINib(nibName: "SectionFourCell", bundle: nil), forCellWithReuseIdentifier: "SectionFourCell")
        
        self.collection.collectionViewLayout = ViewController.createLayout()
        self.collection.dataSource = self
        self.collection.delegate = self
        
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, ent) -> NSCollectionLayoutSection? in
            if sectionNumber == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 2
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                
                section.orthogonalScrollingBehavior = .paging
                
                return section
            }else if sectionNumber == 1 {
                
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.25), heightDimension: .absolute(150)))
                item.contentInsets.trailing = 16
                item.contentInsets.bottom = 16
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)),
                          elementKind: categoryHeaderId,
                          alignment: .topLeading)
                ]
                //section.orthogonalScrollingBehavior = .paging
                return section
            }else{
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 32
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(125)), subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 16
                
                section.orthogonalScrollingBehavior = .continuous
                return section
            }
        }
    }
}


extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            if moviedata.count > 0{
                return 3
            }
            else{
                return 0
            }
        }
        else{
            if moviedata.count > 0{
                return 8
            }
            else{
                return 0
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionCell", for: indexPath) as! SectionCell
            //cell.Img.image = UIImage(named: "salad_\(indexPath.row + 1)")
            if self.moviedata.count > 0{
                let bind = moviedata[indexPath.row]
                cell.Img.sd_setImage(with: URL(string: bind.artworkUrl100 ?? ""))
                return cell

            }else{
                return UICollectionViewCell()
            }
            
                        
        }else if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionTwo", for: indexPath) as! SectionTwo
//            cell.img.image = UIImage(named: "food_icon_3")
//            return cell
            cell.label1.text = "testing"
            if self.moviedata.count > 0{
            let bind = moviedata[indexPath.row]
            cell.label1.text = bind.artistName
            cell.img.sd_setImage(with: URL(string: bind.artworkUrl100 ?? ""))
            //cell.backgroundColor = .yellow
            return cell
            }else{
                return UICollectionViewCell()
            }
            
        }else if indexPath.section == 2 {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionThree", for: indexPath) as! SectionThree
            if (indexPath.row) % 2 == 0 {
                cell.setGradientView(startColor: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
            }else {
                cell.setGradientView(startColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
            }
            return cell
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
            cell.backgroundColor = .white
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath)
        
        return header
        
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Section: \(indexPath.section)")
        print("Selected Item: \(indexPath.row)")
    }
}


class Header : UICollectionReusableView {
    
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Categories"
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


