import 'package:flutter/material.dart';
import 'package:autoflow_text/autoflow_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: AutoFlowWidget(
                widgets: [
                  Text("Lorem ipsum dolor sit amet. Sit unde cupiditate hic inventore perferendis sit laudantium pariatur. Aut fugiat voluptas ut itaque iste aut debitis sunt id fugiat incidunt vel doloremque iusto et laborum maiores ea ipsa voluptates! Et nesciunt voluptatem a iste voluptate rem fuga maxime et sunt veritatis.")
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: AutoFlowWidget(
                widgets: [
                  Text("Lorem ipsum dolor sit amet. Sit unde cupiditate hic inventore perferendis sit laudantium pariatur. Aut fugiat voluptas ut itaque iste aut debitis sunt id fugiat incidunt vel doloremque iusto et laborum maiores ea ipsa voluptates! Et nesciunt voluptatem a iste voluptate rem fuga maxime et sunt veritatis.")
                ],
                scrollDelay: Duration(seconds: 2),
                scrollDuration: Duration(seconds: 10),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: AutoFlowWidget(
                widgets: [
                  Text("Short")
                ],
              ),
            ),
            AutoFlowWidget(
              widgets: [
                Text("Short1 "),
                Text("Short2 "),
                Text("Short3 ")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
