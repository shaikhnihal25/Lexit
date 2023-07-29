import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lexit/constant/appColors.dart';
import 'package:velocity_x/velocity_x.dart';

class LegalDocumentsPage extends StatefulWidget {
  @override
  _LegalDocumentsPageState createState() => _LegalDocumentsPageState();
}

class _LegalDocumentsPageState extends State<LegalDocumentsPage> {
  List<LegalDocument> legalDocuments = [
    LegalDocument(
      title: 'Article For Rental Agreement',
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer bibendum, purus vitae tincidunt mollis, est erat consectetur tortor, nec ultrices velit mauris eu nisi.',
    ),
    LegalDocument(
      title: 'Document 2',
      content:
          'Quisque vulputate varius feugiat. Ut sollicitudin, metus vel tristique finibus, eros nisi mattis ex, in pulvinar erat metus et arcu.',
    ),
    // Add more legal documents here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Documents & Articles',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('articles')
                    .doc('COI')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?['data'].length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var title = snapshot.data['data'][index]['title'];
                        var desc = snapshot.data['data'][index]['description'];
                        return ExpansionTile(
                          title: Text(title),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(desc),
                            ),
                          ],
                        );
                      },
                    );
                  }
                  return VxShimmer(
                      primaryColor: AppColors.backgroundLight,
                      secondaryColor: AppColors.background,
                      showGradient: true,
                      duration: Duration(seconds: 10),
                      child: Container(
                        height: 60,
                        width: 250,
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LegalDocument {
  String title;
  String content;

  LegalDocument({required this.title, required this.content});
}
