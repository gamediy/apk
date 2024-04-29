import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserInfo {
  String account;
  String email;
  String xid;
  String phone;
  String realName;
  String createdAt;
  int payPassStatus;
  double balance;
  double totalBet;
  double totalDeposit;
  double totalWithdraw;
  double freeze;
  double totalProfit;
  double totalGift;



  UserInfo({
    required this.account,
    required this.email,
    required this.xid,
    required this.phone,
    required this.realName,
    required this.createdAt,
    required this.payPassStatus,
    required this.balance,
    required this.totalBet,
    required this.totalDeposit,
    required this.totalWithdraw,
    required this.freeze,
    required this.totalProfit,
    required this.totalGift,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      account: json['account'],
      email: json['email'],
      xid: json['xid'],
      phone: json['phone'],
      realName: json['realName'],
      createdAt: json['createdAt'],
      payPassStatus: json['payPassStatus'],
      balance: json['balance'],
      totalBet: json['totalBet'],
      totalDeposit: json['totalDeposit'],
      totalWithdraw: json['totalWithdraw'],
      freeze: json['freeze'],
      totalProfit: json['totalProfit'],
      totalGift: json['totalGift'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'account': account,
      'email': email,
      'xid': xid,
      'phone': phone,
      'realName': realName,
      'createdAt': createdAt,
      'payPassStatus': payPassStatus,
      'balance': balance,
      'totalBet': totalBet,
      'totalDeposit': totalDeposit,
      'totalWithdraw': totalWithdraw,
      'freeze': freeze,
      'totalProfit': totalProfit,
      'totalGift': totalGift,
    };
  }
}
