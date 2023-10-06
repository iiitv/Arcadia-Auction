import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RulesPdfViewer extends StatefulWidget {
  static const routeName = '/rules-pdf-viewer';

  @override
  _RulesPdfViewerState createState() => _RulesPdfViewerState();
}

class _RulesPdfViewerState extends State<RulesPdfViewer> {
<<<<<<< HEAD
  // PdfViewerController? _pdfViewerController;
  // @override
  // void initState() {
  //   _pdfViewerController = PdfViewerController();
  //   _pdfViewerController!.jumpToPage(1);
  //   super.initState();
  // }

  // PdfTextSearchResult? _searchResult;
=======
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
>>>>>>> Rebuildthescreen

  @override
  Widget build(BuildContext context) {
    Object? s = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
<<<<<<< HEAD
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text('Rules'),
        //   actions: <Widget>[
        //     // IconButton(
        //     //   icon: Icon(
        //     //     Icons.search,
        //     //     color: Colors.white,
        //     //   ),
        //     //   onPressed: () async {
        //     //     _searchResult = await _pdfViewerController?.searchText(
        //     //       'the',
        //     //       searchOption: TextSearchOption.caseSensitive,
        //     //     );
        //     //   },
        //     // ),
        //     Visibility(
        //       visible: _searchResult?.hasResult ?? false,
        //       child: IconButton(
        //         icon: Icon(
        //           Icons.clear,
        //           color: Colors.white,
        //         ),
        //         onPressed: () {
        //           setState(() {
        //             _searchResult!.clear();
        //           });
        //         },
        //       ),
        //     ),
        //     Visibility(
        //       visible: _searchResult?.hasResult ?? false,
        //       child: IconButton(
        //         icon: Icon(
        //           Icons.keyboard_arrow_up,
        //           color: Colors.white,
        //         ),
        //         onPressed: () {
        //           _searchResult?.previousInstance();
        //         },
        //       ),
        //     ),
        //     Visibility(
        //       visible: _searchResult?.hasResult ?? false,
        //       child: IconButton(
        //         icon: Icon(
        //           Icons.keyboard_arrow_down,
        //           color: Colors.white,
        //         ),
        //         onPressed: () {
        //           _searchResult?.nextInstance();
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        // body: Container(
        //   // child: SfPdfViewer.network(
        //   //   pdfUrl,
        //   //   initialZoomLevel: 2,
        //   // ),
        //   child: SfPdfViewer.asset('assets/docs/RuleBook.pdf'),
        // ),
        );
=======
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
>>>>>>> Rebuildthescreen
  }
}
