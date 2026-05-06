class DashboardResponse {
  String? period;
  int? totalTransactions;
  TransactionData? successful;
  TransactionData? cancelled;
  String? lastUpdated;

  DashboardResponse({
    this.period,
    this.totalTransactions,
    this.successful,
    this.cancelled,
    this.lastUpdated,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      period: json['period'],
      totalTransactions: json['totalTransactions'],
      successful: json['successful'] == null
          ? null
          : TransactionData.fromJson(json['successful']),
      cancelled: json['cancelled'] == null
          ? null
          : TransactionData.fromJson(json['cancelled']),
      lastUpdated: json['lastUpdated'],
    );
  }
}

class TransactionData {
  int? count;
  double? amount;

  TransactionData({this.count, this.amount});

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      count: json['count'],
      amount: (json['amount'] as num?)?.toDouble(),
    );
  }
}
