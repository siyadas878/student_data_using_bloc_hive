import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_details_hive_bloc/presentation/details_screen/details_screen.dart';
import 'package:sample_details_hive_bloc/presentation/editing_screen/edit_screen.dart';
import 'package:sample_details_hive_bloc/presentation/input/inout_screen.dart';
import 'package:sample_details_hive_bloc/presentation/search_screen.dart/search.dart';
import '../../application/home_bloc/home_bloc_bloc.dart';
import '../../domain/student_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeBlocBloc>(context).add(StudentGetAll());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ));
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: SafeArea(child: BlocBuilder<HomeBlocBloc, HomeBlocState>(
        builder: (context, state) {
          return state.studentlist.isEmpty
              ? const Center(child: Text('Empty'))
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 10),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
                  shrinkWrap: true,
                  itemCount: state.studentlist.length,
                  itemBuilder: (context, index) {
                    StudentModel stu = state.studentlist[index];
                    File? image;
                    if (stu.imgpath != 'no-img') {
                      image = File(stu.imgpath);
                    }
                    return ListTile(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetsilScreen(data: stu),));
                      },
                      title: Text(stu.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(stu.age),
                          const SizedBox(width: 10),
                          Text(stu.place),
                        ],
                      ),
                      leading: CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(30),
                            child: (image != null)
                                ? Image.file(
                                    image,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset('assets/iconAdd.jpg'),
                          ),
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditScreen(
                                          data: stu, dataIndex: index),
                                    ));
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<HomeBlocBloc>(context)
                                    .add(StudentRemove(data: stu));
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                    );
                  },
                );
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InputScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
