import 'package:flutter/foundation.dart';

import '../../../../app/get_network_caller.dart';
import '../../../../app/urls.dart';
import '../../data/models/customer_model.dart';

class CustomerListProvider extends ChangeNotifier {
  int _pageNo = 0;

  final int _pageSize = 20;

  int? _lastPage;

  bool _initialLoading = false;

  bool get initialLoading => _initialLoading;

  bool _isLoadingMore = false;

  bool get isLoadingMore => _isLoadingMore;

  final List<CustomerModel> _customerList = [];

  List<CustomerModel> get customerList => _customerList;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  int _totalCustomer = 0;

  int get totalCustomer => _totalCustomer;

  Future<void> getCustomerList() async {
    if (_lastPage != null && _pageNo >= _lastPage!) {
      return;
    }

    _pageNo++;

    final bool isFirstPage = _pageNo == 1;

    if (isFirstPage) {
      _initialLoading = true;
    } else {
      _isLoadingMore = true;
    }
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await getNetworkCaller().getRequest(
        Urls.customerListUrl(_pageNo, _pageSize),
      );

      if (response.isSuccess) {
        final pageInfo = response.body['PageInfo'];
        _lastPage ??= pageInfo['PageCount'];
        _totalCustomer = pageInfo['TotalRecordCount'];

        final List customerList = response.body['CustomerList'];

        final List<CustomerModel> newCustomerList = customerList
            .map((customer) => CustomerModel.fromJson(customer))
            .toList();

        _customerList.addAll(newCustomerList);
      } else {
        _pageNo--;
        _errorMessage = response.errorMessage;
      }
    } catch (e) {
      _pageNo--;
      _errorMessage = e.toString();
    } finally {
      if (isFirstPage) {
        _initialLoading = false;
      } else {
        _isLoadingMore = false;
      }
      notifyListeners();
    }
  }

  bool get isLoading => _initialLoading || _isLoadingMore;

  void refreshCustomerList() {
    _pageNo = 0;
    _lastPage = null;
    _customerList.clear();
    _errorMessage = null;
    notifyListeners();
    getCustomerList();
  }
}
