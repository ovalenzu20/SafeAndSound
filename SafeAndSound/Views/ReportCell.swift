//
//  ReportCell.swift
//  SafeAndSound
//
//  Created by Teran on 10/13/18.
//  Copyright © 2018 SDHACKS2018. All rights reserved.
//

import UIKit


class ReportCell: UITableViewCell {
    @IBOutlet weak var reportDateLabel: UILabel!
    @IBOutlet weak var reportTimeLabel: UILabel!
    
    
    
    func setupCell() {
        self.setProperties(bgColor: .clear, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: nil, borderColor: nil, borderWidth: nil)
        self.contentView.setProperties(bgColor: .white, shadowColor: nil, shadowRadius: nil, shadowOpacity: nil, shadowOffset: nil, cornerRadius: 2, borderColor: nil, borderWidth: nil)
        
        reportDateLabel.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: Padding(top: 8, left: 8))
        
        reportTimeLabel.anchor(top: reportDateLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: Padding(top: 8, left: 8, bottom: 8))
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
