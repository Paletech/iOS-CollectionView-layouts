//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 08.04.2023.
//

import UIKit

class TagViewController: UIViewController {
    var collectionView: UICollectionView!
    var tags: [String] = [
        "Stellar Voyage",
        "Wanderlust",
        "Infinite Horizons",
        "Moonlit Dreams",
        "Eni",
        "A Symphony of Stardust",
        "Ephemeral Echoes",
        "Sunset Serenade",
        "Pixelated",
        "Fleeting Whispers",
        "Intertwined",
        "Mystic Breeze",
        "Luminescence",
        "Astral Adventure of Time Kaleidoscope",
        "Quasar",
        "Through the Looking Glass",
        "Vortex of Reverie",
        "Ripple",
        "Painted Skies",
        "Metamorphosis",
        "Waves of Serenity",
        "Sublime",
        "Lie",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: TagLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "TagCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "default")
        tags = collectionView.sortedTagsBasedOnCellSize(tags, cellType: TagCollectionViewCell.self)

        view.addSubview(collectionView)
    }
}

extension TagViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "default", for: indexPath) as! TagCollectionViewCell
        cell.config(info: tags[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tags[indexPath.item]
        return TagCollectionViewCell.preferredSize(for: tag)
    }
}
