import 'package:ekuid_assignment/cubit/home_cubit_cubit.dart';
import 'package:ekuid_assignment/view/add_users.dart';
import 'package:ekuid_assignment/view/edit_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<HomeCubit>().getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Students'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddUsersPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeCubit>().getData();
          },
          child: BlocConsumer<HomeCubit, HomeCubitState>(
            listener: (_, state) {
              if (state is HomeCubitSuccessDelete) {
                context.read<HomeCubit>().getData();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Berhasil menghapus data'),
                  ),
                );
              }
              if (state is HomeCubitError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                  ),
                );
              }
            },
            // bloc: homeCubit,
            builder: (_, state) {
              if (state is HomeCubitLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is HomeCubitLoaded) {
                return Container(
                  padding: EdgeInsets.all(14),
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Text('${state.data[index].name![0]}'),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${state.data[index].name ?? ''} ${state.data[index].lastName ?? ''}'),
                                Text('${state.data[index].age} years old')
                              ],
                            ),
                            Spacer(),
                            PopupMenuButton(
                              child: Icon(Icons.more_vert),
                              onSelected: (v) {
                                if (v == 1) {
                                  context
                                      .read<HomeCubit>()
                                      .deleteData(state.data[index].id);
                                } else if (v == 0) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditUsersPage(
                                        model: state.data[index],
                                      ),
                                    ),
                                  );
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 0,
                                    child: Text('Edit'),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: Text('Delete'),
                                  )
                                ];
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
