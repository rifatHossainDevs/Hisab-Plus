class CustomerModel {
  final int id;
  final String name;
  final String? email;
  final String? primaryAddress;
  final String? notes;
  final String? phone;
  final String? imagePath;
  final double totalDue;
  final String? lastInvoiceNo;
  final String? lastSoldProduct;
  final double totalSalesValue;
  final double totalCollection;
  final String? lastTransactionDate;

  CustomerModel({
    required this.id,
    required this.name,
    this.email,
    this.primaryAddress,
    this.notes,
    this.phone,
    this.imagePath,
    required this.totalDue,
    this.lastInvoiceNo,
    this.lastSoldProduct,
    required this.totalSalesValue,
    required this.totalCollection,
    this.lastTransactionDate,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['Id'],
      name: json['Name'],
      email: json['Email'],
      primaryAddress: json['PrimaryAddress'],
      notes: json['Notes'],
      phone: json['Phone'],
      imagePath: json['ImagePath'],
      totalDue: (json['TotalDue'] as num?)?.toDouble() ?? 0.0,
      lastInvoiceNo: json['LastInvoiceNo'],
      lastSoldProduct: json['LastSoldProduct'],
      totalSalesValue: (json['TotalSalesValue'] as num?)?.toDouble() ?? 0.0,
      totalCollection: (json['TotalCollection'] as num?)?.toDouble() ?? 0.0,
      lastTransactionDate: json['LastTransactionDate'],
    );
  }
}
