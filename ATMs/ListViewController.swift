//
//  ListViewController.swift
//  ATMs
//
//  Created by Karina Kovaleva on 27.12.22.
//

import UIKit

class ListViewController: UIViewController {

    private let network = NetworkAPI()

    private var atms = [ATM]()
    private var sections = [ATMSection]()
    private var dataSource: UICollectionViewDiffableDataSource<ATMSection, ATM>?

    private lazy var collectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "atmCell")
        collectionView.register(SectionHeader.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: SectionHeader.reuseId)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        collectionView.delegate = self
        network.getATMsList { atms in
            self.atms = atms
            self.createGroupedData(atms)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        setupCollectionView()
        setupDataSource()
        createSnapshot()
    }

    private func createGroupedData(_ atms: [ATM]) {
        let items = Dictionary(grouping: self.atms, by: {$0.city})
        let allKeys = Array(items.keys)
        var sections = [ATMSection]()
        for key in allKeys {
            let section = ATMSection(city: key, atm: items[key]!)
            sections.append(section)
        }
        self.sections = sections
    }

    private func setupCollectionView() {
        self.view.addSubview(self.collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<ATMSection, ATM>(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, atm -> UICollectionViewCell? in
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseId,
                                                              for: indexPath) as? CollectionViewCell
                cell?.configureCell(model: atm)
                return cell }
        )
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: SectionHeader.reuseId,
                for: indexPath
            ) as? SectionHeader else { return nil }
            guard let firstAtm = self?.dataSource?.itemIdentifier(for: indexPath) else { return nil }
            guard let section = self?.dataSource?.snapshot().sectionIdentifier(
                containingItem: firstAtm) else { return nil }
            if section.city.isEmpty { return nil }
            sectionHeader.headerLabel.text = section.city
            return sectionHeader
        }
    }

    private func createSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ATMSection, ATM>()
        snapshot.appendSections(sections)

        for section in sections {
            snapshot.appendItems(section.atm, toSection: section)
        }

        dataSource?.apply(snapshot)
    }

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize:
                                            NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                                   heightDimension: .fractionalHeight(1)))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                               heightDimension: .estimated(80)),
                                                       repeatingSubitem: item, count: 3)

        let spacing = CGFloat(10)
        group.interItemSpacing = .fixed(spacing)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let header = createSectionHeader()
        section.boundarySupplementaryItems = [header]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeader = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                         heightDimension: .estimated(20))
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: layoutSectionHeader,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        return header
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = MainViewController()
        viewController.chooseMapViewController()
    }
}

