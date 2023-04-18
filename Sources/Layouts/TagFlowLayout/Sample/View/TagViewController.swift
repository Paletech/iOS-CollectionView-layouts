//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 08.04.2023.
//

import UIKit

public class TagViewController: UIViewController {
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
    
    let decorator = TagDecoratorImpl()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = TagLayout(decorator: decorator, xOffset: 0, yOffset: 0, spacing: 15)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)

        layout.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: "cellOne")

        view.addSubview(collectionView)
    }
}

extension TagViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellOne", for: indexPath) as! TagCollectionViewCell
        cell.config(info: tags[indexPath.item], decorator: decorator)
        return cell
    }
}

extension TagViewController: TagDataSource {
    func tag(at indexPath: IndexPath) -> String {
        return tags[indexPath.item]
    }
}
