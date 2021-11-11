import 'package:ekuid_assignment/cubit/home_cubit_cubit.dart';
import 'package:ekuid_assignment/model/students_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditUsersPage extends StatefulWidget {
  final StudentsModel? model;

  const EditUsersPage({Key? key, this.model}) : super(key: key);
  @override
  _EditUsersPageState createState() => _EditUsersPageState();
}

class _EditUsersPageState extends State<EditUsersPage> {
  final homeCubit = HomeCubit();

  TextEditingController namaDepanController = TextEditingController();

  TextEditingController namaBelakangController = TextEditingController();

  TextEditingController umurController = TextEditingController();

  TextEditingController idController = TextEditingController();

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    namaDepanController.text = widget.model!.name ?? '';
    namaBelakangController.text = widget.model!.lastName ?? '';
    umurController.text = widget.model!.age.toString();
    idController.text = widget.model!.id!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add User'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12),
            child: Form(
              key: _keyForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'ID Harus diisi';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    controller: idController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text('Nama Depan'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Nama Depan Harus diisi';
                      }
                      return null;
                    },
                    controller: namaDepanController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text('Nama Belakang'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Nama belakang Harus diisi';
                      }
                      return null;
                    },
                    controller: namaBelakangController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text('Umur'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Umur Harus diisi';
                      }
                      return null;
                    },
                    controller: umurController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocConsumer<HomeCubit, HomeCubitState>(
                    bloc: homeCubit,
                    listener: (context, state) {
                      if (state is HomeCubitError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                          ),
                        );
                        context.read<HomeCubit>().getData();
                      } else if (state is HomeCubitSuccessAdd) {
                        context.read<HomeCubit>().getData();
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Success'),
                              content: Text('Berhasil Mengubah Data'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    builder: (context, state) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: state is HomeCubitButtonLoading
                              ? null
                              : () {
                                  if (_keyForm.currentState!.validate()) {
                                    homeCubit.editData(
                                        id: idController.text,
                                        age: umurController.text,
                                        lastName: namaBelakangController.text,
                                        name: namaDepanController.text);
                                  }
                                },
                          child: state is HomeCubitButtonLoading
                              ? SizedBox(
                                  width: 25,
                                  height: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                  ),
                                )
                              : Text('Submit'),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
