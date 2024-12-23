import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/repository/store_repository.dart';
import 'package:oneship_merchant_app/service/dialog.dart';

part 'register_store_state.dart';

class RegisterStoreCubit extends Cubit<RegisterStoreState> {
  final StoreRepository repository;
  RegisterStoreCubit(this.repository) : super(RegisterStoreState());

  final pageController = PageController();

  setStatusState(EState value) {
    emit(state.copyWith(status: value));
  }

  getAll() async {
    setStatusState(EState.loading);
    final response = await execute(
      () => repository.getAll(),
      isShowFailDialog: true,
    );
    response.when(success: (data) {
      setStatusState(EState.success);
      emit(state.copyWith(stores: data.items ?? []));
    }, failure: (error) {
      setStatusState(EState.failure);
    });
  }

  resetState() {
    emit(RegisterStoreState());
  }

  setAcceptTermsAndConditions(bool value) {
    emit(state.copyWith(isAcceptTermsAndConditions: value));
  }

  setCurrentPage(ERegisterPageType page) {
    emit(state.copyWith(currentPage: page));
  }

  setNextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setCurrentPage(ERegisterPageType.values[state.currentPage.index + 1]);
  }

  setPreviousPage() {
    if (state.currentPage.index == 0) {
      dialogService.showAlertDialog(
        title: 'Thông báo',
        description: 'Bạn có chắc chắn muốn thoát khỏi quá trình đăng ký?',
        buttonTitle: 'Thoát',
        onCancel: () => Get.back(),
        onPressed: () {
          Get.back();
          Get.back();
        },
        buttonCancelTitle: 'Hủy',
      );
      return;
    }
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setCurrentPage(ERegisterPageType.values[state.currentPage.index - 1]);
  }
}
