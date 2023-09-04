import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/database_provider.dart';
import '../default_text.dart';
import './all_expenses_list.dart';
import './expense_search.dart';

class AllExpensesFetcher extends StatefulWidget {
  const AllExpensesFetcher({super.key});

  @override
  State<AllExpensesFetcher> createState() => _AllExpensesFetcherState();
}

class _AllExpensesFetcherState extends State<AllExpensesFetcher> {
  late Future _allExpensesList;

  Future _getAllExpenses() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchAllExpenses();
  }

  @override
  void initState() {
    super.initState();
    _allExpensesList = _getAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _allExpensesList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: DefaultText(text: snapshot.error.toString()),
            );
          } else {
            return  Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0.w,vertical: 10.h),
              child:  Column(
                children: [
                  ExpenseSearch(),
                  SizedBox(height: 15.h,),
                  Expanded(child: AllExpensesList()),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
