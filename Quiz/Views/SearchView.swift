//
//  SearchView.swift
//  Quiz
//
//  Created by Lucija Balja on 06/06/2020.
//  Copyright © 2020 Lucija Balja. All rights reserved.
//

import UIKit

class SearchView: UIView {
    var searchTextField = UITextField()
    var searchButton = UIButton(type: .system)
    var searchDelegate: SearchDelegate?
    
    init() {
        super.init(frame: .zero)
        setupUI()
        setupConstraints()
        setupEvents()
    }
    
    func setupEvents() {
        searchButton.addTarget(self, action: #selector(onSearchPressed), for: .touchUpInside)
    }
    
    @objc func onSearchPressed(_ sender: UIButton) {
        guard let searchWord = searchTextField.text else { return }
        searchDelegate?.onSearchPressed(searchWord: searchWord)
    }
    
    func setupUI() {
        Setup.setTextField(searchTextField)
        searchTextField.attributedPlaceholder = NSAttributedString(string: "Type here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        Setup.setButton(searchButton, size: 15.0,  title: "Search")
        searchButton.backgroundColor = .systemIndigo
        searchButton.tintColor = .white
        
        addSubview(searchTextField)
        addSubview(searchButton)
    }
    
    func setupConstraints() {
        searchTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchTextField.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        searchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.leftAnchor.constraint(equalTo: searchTextField.rightAnchor, constant: 10).isActive = true
        searchButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
