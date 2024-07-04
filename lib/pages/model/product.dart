// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class Product {
  final String image, title, description,adres, location;
  final int  id;
  Product({
    required this.location,
    required this.id,
    required this.image,
    required this.title,
    required this.adres,
    required this.description,
  });
}

List<Product> products = [
  Product(
    id: 1,
    title: "Tuzla",
    adres: "Bülent Ecevit Cd",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    image: "assets/images/bülent.jpg",
    location: 'İstanbul',
  ),
  Product(
    id: 2,
    title: "Uludağ",
    adres: "Bursa cd",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    image: "assets/images/uludağ.jpg",
    location: 'Bursa',
  ),
  Product(
    id: 3,
    title: "Kordon",
    adres: "İzmir Cd",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    image: "assets/images/izmir.jpg",
    location: 'İzmir',
  ),
  Product(
    id: 4,
    title: "Cafe Ankara",
    adres: "Ankara Cd",
    description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit",
    image: "assets/images/artiom_vallat.jpg",
    location: 'Ankara',
  ),
];
