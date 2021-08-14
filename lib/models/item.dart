class Item {
  final String? id;
  final String? image;
  final String? name;
  final int? stock;
  final String? barcode;
  final String? email;

  Item({
    this.id,
    this.image,
    this.name,
    this.stock,
    this.barcode,
    this.email,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      stock: json['stock'],
      barcode: json['barcode'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': this.id,
    'image': this.image,
    'name': this.name,
    'stock': this.stock,
    'barcode': this.barcode,
    'email': this.email
  };
}
