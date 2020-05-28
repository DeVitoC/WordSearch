//
//  LetterButtonsLayout.swift
//  WordSearch
//
//  Created by Christopher Devito on 5/27/20.
//  Copyright © 2020 Christopher Devito. All rights reserved.
//

import UIKit

/// 1
class LetterButtonsLayout: UICollectionViewLayout {
    weak var delegate: LetterButtonsDelegate?
    private var layoutCircleFrame = CGRect.zero
    private let layoutInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    private let itemSize = CGSize(width: 30, height: 30)
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var cache2: [UICollectionViewLayoutAttributes] = []

    override var collectionViewContentSize: CGSize {
        collectionView?.bounds.size ?? .zero
    }

    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else { return }
        super.prepare()
        cache.removeAll()
        layoutCircleFrame = CGRect(origin: .zero, size: collectionViewContentSize)
            .inset(by: layoutInsets)
            .insetBy(dx: itemSize.width, dy: itemSize.height/2)
            .offsetBy(dx: collectionView.contentOffset.x, dy: collectionView.contentOffset.y)
            .insetBy(dx: -collectionView.contentOffset.x, dy: -collectionView.contentOffset.y)
        for section in 0..<collectionView.numberOfSections {
            switch section {
                case 0:
                    let itemCount = collectionView.numberOfItems(inSection: section)
                    cache = (0..<itemCount).map({ (index) -> UICollectionViewLayoutAttributes in
                        let angleStep: CGFloat = 2.0 * CGFloat.pi / CGFloat(itemCount)
                        var position = layoutCircleFrame.center
                        position.x += layoutCircleFrame.size.innerRadius * cos(angleStep * CGFloat(index))
                        position.y += layoutCircleFrame.size.innerRadius * sin(angleStep * CGFloat(index))
                        let indexPath = IndexPath(item: index, section: section)
                        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                        attributes.frame = CGRect(center: position, size: itemSize)
                        return attributes
                    })
                default:
                    fatalError("Unhandled section")
            }
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        cache
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let numberOfItems = collectionView?.numberOfItems(inSection: indexPath.section) ?? 0
        guard numberOfItems > 0 else { return nil }
        switch indexPath.section {
            case 0:
                return cache[indexPath.item]
            default:
                fatalError("Unknown section \(indexPath.section).")
        }
    }
}

protocol LetterButtonsDelegate: AnyObject {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

extension CGRect {
    init(center: CGPoint, size: CGSize) {
        self.init(x: center.x - size.width / 2.0, y: center.y - size.height / 2.0, width: size.width, height: size.height)
    }

    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}

extension CGSize {
    var innerRadius: CGFloat { return min(width, height) / 2.0 }
}
