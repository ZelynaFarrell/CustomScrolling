//
//  Card.swift
//  CustomScrolling
//
//  Created by Zelyna Sillas on 9/19/23.
//

import SwiftUI

struct Card: Identifiable {
    var id = UUID()
    var title: String
    var text: String
    var image: Image
}

var cards = [
    Card(title: "Hogwarts", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.hogwartsNight)),
    Card(title: "Hagrid's Hut", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.hagridHutNight)),
    Card(title: "Platform 9 & 3/4", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.platformNight)),
    Card(title: "Wizarding World", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.wizardingWorldNight)),
    
    Card(title: "Dark Arts Class", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.darkArts)),
    Card(title: "Potions Class", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.potions)),
    Card(title: "Divination Class", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.divination)),
    Card(title: "Herbology Class", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.herbology))
]

var lightCards = [
    Card(title: "Hogwarts", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.hogwartsDay)),
    Card(title: "Hagrid's Hut", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.hagridHutDay)),
    Card(title: "Platform 9 and 3/4", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.platformDay)),
    Card(title: "Wizarding World", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.wizardingWorldDay)),
    
    Card(title: "Dark Arts Class", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.darkArts)),
    Card(title: "Potions Class", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.potions)),
    Card(title: "Divination Class", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.divination)),
    Card(title: "Herbology Class", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis enim eu risus posuere congue.", image: Image(.herbology))
]
