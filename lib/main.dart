// 1.Khai bao thu vien
//import 'dart:ffi';

import 'package:flutter/material.dart';

//2.Main
void main() {
  //3. Khoi dong app
  runApp(MaterialApp(
    //4. Xay dung giao dien bang su dung thanh phan
    home: SafeArea(child: RandomWords()),
    debugShowCheckedModeBanner: false,
  ));
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _words = <String>[
    'Yêu',
    'Ghét',
    'Thương',
    'Nhớ',
    'Chán',
    'Bất ngờ',
    'Buồn',
    'Vui',
    'Thế Thái',
    'Khánh Chi',
    'Hâm',
  ];
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Center(
            child: Container(
              child: AppBar(
                backgroundColor: Colors.red,
                title: const Center(
                    child: Text(
                  "List Work",
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),
                ),
                ),

              ),
            ),
          ),
        ),
        //body:MyWidget()
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img.png'),
              fit: BoxFit.cover,
            )
          ),
          child: Stack(
            children: [
              ListView.builder(itemBuilder: (context, index) {
                if (index < _words.length) return _buildRow(_words[index],index);
              }),
              Positioned(
                bottom: 50,
                right: 40,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return _addRow();
                        });
                  },
                  child: Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      //border: Border.all(color: Colors.black54,width: 2)
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.black54,
                      size: 30,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Widget _addRow() {
    return AlertDialog(
      title: Text('Add work'),
      content: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          hintText: 'Enter your work',
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              String enteredWork = _textEditingController.text;
              if(!enteredWork.isEmpty) {
                _words.add(enteredWork);
              }
              _textEditingController.clear();
              Navigator.pop(context);
            },
            child: Text('OK')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
      ],
    );
  }

  Widget _buildRow(String wordPair,int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7,horizontal: 9),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: (index % 2 == 0)
        ? const Color.fromARGB(221, 255, 130, 229)
        : const Color.fromARGB(240, 246, 86, 86),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: ListTile(
          title: Text(
            wordPair.toString(),
            style: const TextStyle(fontSize: 23,color: Colors.black87,fontWeight: FontWeight.bold),
          ),
          trailing: GestureDetector(
            onTap: () {
              setState(() {
                _words.remove(wordPair);
              });
            },
            child: const Icon(
              Icons.delete_outline,
              color: Colors.black,
              size: 32,
            ),
          ),
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Edit work'),
                    content: TextField(
                        controller: _textEditingController2,
                        decoration: InputDecoration(
                          hintText: wordPair,
                        )
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            String enteredWork = _textEditingController2.text;
                            if(!enteredWork.isEmpty) {
                              print(wordPair);
                              updateItem(wordPair,enteredWork);
                              //_words[_words.indexOf(wordPair)] = enteredWork;
                              print(enteredWork);
                            }
                            _textEditingController2.clear();
                            Navigator.pop(context);
                          },
                          child: Text('OK')),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel')),
                    ],
                  );
                });
          },
        ),
      ),
    );
  }
  void updateItem(String wordPair,String enteredWork){
    setState(() {
      _words[_words.indexOf(wordPair)] = enteredWork;
    });
  }
}
