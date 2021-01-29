//
// Created by Salomon BRYS on 24/08/2020.
// Copyright (c) 2020 Acinq. All rights reserved.
//

import SwiftUI

extension Color {

	@available(*, deprecated, message:
	    "Doesn't support Dark Mode. Maybe try: Color(UIColor.systemBackground)")
    static let appBackground = Color(red: 0.96, green: 0.96, blue: 0.98) // deprecated
	
    // See Colors.xcassets for RGB values.
    // The assets catalog allows us to customize the values for light vs dark modes.

    static let appHorizon = Color("appHorizon")
    static let appRed = Color("appRed")
    static let appGreen = Color("appGreen")
    static let appYellow = Color("appYellow")
	
//	static let accent = Color("accent") // on hold until we decide on theme colors for dark mode
	
	static let buttonFill = Color("buttonFill")
	static let primaryBackground = Color("primaryBackground")
	static let primaryForeground = Color("primaryForeground")

}