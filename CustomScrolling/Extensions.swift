//
//  Extensions.swift
//  CustomScrolling
//
//  Created by Zelyna Sillas on 9/19/23.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

