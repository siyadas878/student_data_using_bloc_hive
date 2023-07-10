import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_details_hive_bloc/presentation/details_screen/details_screen.dart';
import '../../application/search_bloc/search_bloc.dart';
import '../../domain/student_model.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SearchBloc>(context).add(InitialState());
    return Scaffold(
      appBar: AppBar(
        title: const Text('search'),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                BlocProvider.of<SearchBloc>(context)
                    .add(StudentSearch(query: value));
              },
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                labelText: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(child: searchFound())
        ],
      )),
    );
  }

  BlocBuilder<SearchBloc, SearchState> searchFound() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return searchController.text.isEmpty ||
                searchController.text.trim().isEmpty &&
                    state.searchlist!.isEmpty
            ? allData()
            : ListView.separated(
                padding: const EdgeInsets.only(top: 10),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                shrinkWrap: true,
                itemCount: searchController.text.isEmpty ||
                        searchController.text.trim().isEmpty
                    ? state.studentlist.length
                    : state.searchlist!.length,
                itemBuilder: (context, index) {
                  var stu = searchController.text.isEmpty ||
                      searchController.text.trim().isEmpty;
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => DetsilScreen(
                                data: StudentModel(
                                    imgpath: stu
                                        ? state.studentlist[index].imgpath
                                        : state.searchlist![index].imgpath,
                                    place: (searchController.text.isEmpty ||
                                            searchController.text
                                                .trim()
                                                .isEmpty)
                                        ? state.studentlist[index].age
                                        : state.searchlist![index].age,
                                    name: stu
                                        ? state.studentlist[index].name
                                        : state.searchlist![index].name,
                                    age: stu
                                        ? state.studentlist[index].age
                                        : state.searchlist![index].age)),
                          ));
                    },
                    leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        radius: 30,
                        backgroundImage: FileImage(File(stu
                            ? state.studentlist[index].imgpath
                            : state.searchlist![index].imgpath))),
                    title: Text(stu
                        ? state.studentlist[index].name
                        : state.searchlist![index].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(stu
                            ? state.studentlist[index].age
                            : state.searchlist![index].age),
                        Text(stu
                            ? state.studentlist[index].place
                            : state.searchlist![index].place),
                      ],
                    ),
                  );
                },
              );
      },
    );
  }

  empty() {
    return const Center(
      child: Text('Search Not Found'),
    );
  }

  searchEmpty(){

  }

  Widget allData() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return ListView.separated(
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
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => DetsilScreen(data: stu),
                    ));
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
            );
          },
        );
      },
    );
  }
}
