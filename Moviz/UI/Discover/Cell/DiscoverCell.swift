//
//  DiscoverCell.swift
//  Moviz
//
//  Created by Li Hao Lai on 13/12/20.
//

import UIKit
import RxSwift
import RxCocoa

class DiscoverCell: UITableViewCell, ViewModelBasedType {
    static let reuseIdentifier = String(describing: DiscoverCell.self)
    
    typealias ViewModel = DiscoverCellViewModel
    
    var viewModel: ViewModel!
    
    private let disposeBag = DisposeBag()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        
        return label
    }()
    
    private lazy var labelsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.insertSublayer(labelsViewGradientColor, at: 0)
        
        return view
    }()
    
    private lazy var labelsViewGradientColor: CAGradientLayer = {
        let colorTop = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        let colorBottom = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        let gradient = CAGradientLayer()
        gradient.colors = [colorTop, colorBottom]
        gradient.locations = [0.0, 1.0]
        
        return gradient
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      layout()
    }

    required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelsViewGradientColor.frame = labelsView.bounds
    }

    private func layout() {
        [posterImageView, labelsView].forEach(addSubview)
        [titleLabel, releaseDateLabel].forEach(labelsView.addSubview)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            labelsView.heightAnchor.constraint(equalToConstant: 60),
            labelsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            labelsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: labelsView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor, constant: 8),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(equalTo: labelsView.leadingAnchor, constant: 8),
        ])
    }
    
    func bind(viewModel: ViewModel) {
        self.viewModel = viewModel
        
        let output = viewModel.transform(input: .init())
        
        output.bgDataDriver
            .map { UIImage(data: $0) }
            .drive(posterImageView.rx.image)
            .disposed(by: disposeBag)
        
        output.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.releaseDate
            .map { "Release Date: \($0)" }
            .drive(releaseDateLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
