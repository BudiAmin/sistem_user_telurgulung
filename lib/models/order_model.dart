class OrderModel {
  final int? id;
  final int user_id;
  final int product_id;
  final int total_barang;
  final int balado;
  final int keju;
  final int pedas;
  final int asin;
  final int barbeque;
  final int total_harga;
  final String status;

  OrderModel({
    this.id,
    required this.user_id,
    required this.product_id,
    required this.total_barang,
    required this.balado,
    required this.keju,
    required this.pedas,
    required this.asin,
    required this.barbeque,
    required this.total_harga,
    required this.status,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      user_id: json['user_id'],
      product_id: json['product_id'],
      total_barang: json['total_barang'],
      balado: json['balado'],
      keju: json['keju'],
      pedas: json['pedas'],
      asin: json['asin'],
      barbeque: json['barbeque'],
      total_harga: json['total_harga'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'product_id': product_id,
      'total_barang': total_barang,
      'balado': balado,
      'keju': keju,
      'pedas': pedas,
      'asin': asin,
      'barbeque': barbeque,
      'total_harga': total_harga,
      'status': status,
    };
  }
}
