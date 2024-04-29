import 'package:bet/model/open_result.dart';
import 'package:flutter/material.dart';

import '../../../../utils/values.dart';

class Chart extends StatelessWidget {
  const Chart({super.key,required this.result});
  final List<OpenResult> result;
  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
        reverse: true,

        scrollDirection: Axis.horizontal,
        child: getContent());

    return  Row(

crossAxisAlignment: CrossAxisAlignment.start,
      children: [

                Container(
                  child: item(2,"1"),
                ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              item(1, '1'),
              item(1, '1'),
              item(1, '1'),
              item(1, '1'),
              item(1, '1'),
              item(1, '1'),
            ],
          )
        ),
        Container(
          child: item(2,"1"),
        ),
        
      ],
    );



  }


  item(int openresult,String issue ){
   return Container(
     margin: EdgeInsets.only(left: 3,top: 3),
     child: ClipOval(

        child: Container(
          width: 50,
          height: 50,


          color: openresult > 1 ? Colors.red : Colors.blue,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  issue,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  openresult.toString(),
                  style: TextStyle(
                    fontSize: 13,
                    color: Values.Grey,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
   );
  }


  Widget getContent(){

    List<Widget> columns = [];
    List<Widget> currentColumn = [];

    for (int i = 0; i < result.length; i++) {
      var itemObj = this.result[i];
      print(itemObj.result);
      currentColumn.add(
          item(itemObj.result, itemObj.issue.toString()),
      );

      // If it's the last item or the next item is different, create a Column
      if (i == this.result.length - 1 || itemObj.result != this.result[i + 1].result) {
        columns.add(
          Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: currentColumn,
              ),
            ),
          ),
        );
        currentColumn = []; // Reset the currentColumn
      }
    }

    return SingleChildScrollView(
      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns,
      ),
    );
  }
}
