//
//  WSEventView.swift
//  Calendar
//
//  Created by Vimal on 30/01/23.
//

import UIKit

public class WSEventView: UIView {

    func setEventViewColor(_ color: UIColor?) {
        clipsToBounds = true
        backgroundColor = color
        layer.cornerRadius = frame.size.width / 2
    }

}
