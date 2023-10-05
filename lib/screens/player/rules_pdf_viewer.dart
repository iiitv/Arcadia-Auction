import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class RulesPdfViewer extends StatefulWidget {
  static const routeName = '/rules-pdf-viewer';

  @override
  _RulesPdfViewerState createState() => _RulesPdfViewerState();
}

class _RulesPdfViewerState extends State<RulesPdfViewer> {
  late PdfViewerController _pdfViewerController;
  late PdfTextSearchResult _searchResult;
  TextEditingController searchcontroller = TextEditingController();

  @override
  void initState() {
    _pdfViewerController = PdfViewerController();
    _searchResult = PdfTextSearchResult();
    super.initState();
  }

  @override
  void dispose() {
    searchcontroller.dispose();
    _pdfViewerController.dispose();
    super.dispose();
  }


  void showNotFoundSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(

        duration: Duration(milliseconds: 1000),
        content: Text("Not Found"),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Object? s = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PdfViewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(

                    title: Text('Search'),
                    content: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                          ),
                          controller: searchcontroller,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: Text("Search"),
                        onPressed: () async {
                          _searchResult = await _pdfViewerController
                              .searchText(searchcontroller.text.toString());
                          if (kIsWeb) {
                            setState(() {});
                          } else {
                            _searchResult.addListener(() {
                              if (_searchResult.hasResult) {
                                Navigator.maybePop(context);
                                searchcontroller.clear();
                                setState(() {});
                              } else if (!_searchResult.hasResult) {
                                Navigator.maybePop(context);
                                searchcontroller.clear();
                                setState(() {
                                  showNotFoundSnackBar(context);
                                });
                              }
                            });
                          }
                        },
                      ),
                    ],

                  );
                },
              );
            },
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _searchResult.clear();
                });
              },
            ),
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
              ),
              onPressed: () {
                _searchResult.previousInstance();
              },
            ),
          ),
          Visibility(
            visible: _searchResult.hasResult,
            child: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
              onPressed: () {
                _searchResult.nextInstance();
              },
            ),
          ),
        ],
      ),
      body: SfPdfViewer.asset(
        'assets/docs/RuleBook.pdf',
        controller: _pdfViewerController,
        currentSearchTextHighlightColor: Colors.yellow.withOpacity(0.6),
        otherSearchTextHighlightColor: Colors.yellow.withOpacity(0.3),
      ),
    );
  }
}
