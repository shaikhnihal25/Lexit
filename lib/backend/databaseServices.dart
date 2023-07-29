import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lexit/backend/notification/notificationServices.dart';
import 'package:lexit/backend/userProfileModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/appointment/appointmentHistory.dart';

class LexitDatabase {
  Future<List<Object?>?> getServices() async {
    try {
      QuerySnapshot servicesSnapshot =
          await FirebaseFirestore.instance.collection("services").get();
      List<Object?> services =
          servicesSnapshot.docs.map((doc) => doc.data()).toList();
      return services;
    } catch (error) {
      print(error.toString());
    }
  }

  Future<String?> bookAppointment(String lawyerId, String lawyerName,
      String service, String date, String time) async {
    try {
      FirebaseAuth _auth = FirebaseAuth.instance;
      DocumentReference appointmentRef = FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser!.uid);

      await appointmentRef.set({
        'appointments': FieldValue.arrayUnion([
          {
            'lawyerId': lawyerId,
            'lawyerName': lawyerName,
            'service': service,
            'status': 'Booked',
            'date': date,
            'time': time,
          }
        ])
      }, SetOptions(merge: true));

      LexitNotificationTemplates().bookingNotification(
          'Your Appointment for ${service} has been booked with ${lawyerName}');

      Get.to(AppointmentHistorySCreen(),
          transition: Transition.fade, duration: Duration(milliseconds: 400));

      return appointmentRef.id;
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> saveUserProfile(UserProfile userProfile) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      await userRef.set(userProfile.toMap(), SetOptions(merge: true));
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateUserProfile(
    String name,
    String email,
    String phone,
    String photo,
  ) async {
    name.isNotEmpty ? updateUserName(name) : '';
    email.isNotEmpty ? updateUserEmail(email) : '';
    phone.isNotEmpty ? updateUserPhone(phone) : '';

    LexitNotificationTemplates().profileUpdateNotification();
  }

  Future<void> updateUserName(
    String name,
  ) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      await userRef.set({
        'name': name,
      }, SetOptions(merge: true));
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateUserEmail(
    String email,
  ) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      await userRef.set({
        'email': email,
      }, SetOptions(merge: true));
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateUserPhone(
    String phone,
  ) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      await userRef.set({
        'phone': phone,
      }, SetOptions(merge: true));
      LexitNotificationTemplates().profileUpdateNotification();
    } catch (error) {
      print(error);
    }
  }

  Future<void> updateUserPhoto(
    String image,
  ) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference userRef =
          FirebaseFirestore.instance.collection("users").doc(userId);

      await userRef.set({
        'imageUrl': image,
      }, SetOptions(merge: true));

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('UpdatedProfileImage', image);
    } catch (error) {
      print(error);
    }
  }

  List<Map<String, String>> articlesList = [
    {
      'title': 'Article 19(1)(f)',
      'description':
          'Grants citizens the right to acquire, hold, and dispose of property, subject to reasonable restrictions.',
    },
    {
      'title': 'Article 20(1)',
      'description':
          'Ensures protection against ex post facto criminal laws, which means no person can be punished for an act that was not a crime when committed.',
    },
    {
      'title': 'Article 20(2)',
      'description':
          'Protects individuals from being prosecuted and punished for the same offense more than once, known as double jeopardy.',
    },
    {
      'title': 'Article 21',
      'description':
          'Guarantees the right to life and personal liberty, protecting individuals from arbitrary deprivation.',
    },
    {
      'title': 'Article 39A',
      'description':
          'Ensures equal justice and free legal aid to promote access to justice for all.',
    },
    {
      'title': 'Article 41',
      'description':
          'Provides for public assistance and rehabilitation for individuals who are unable to support themselves.',
    },
    {
      'title': 'Article 42',
      'description':
          'Protects the rights of workers by ensuring just and humane conditions of work and maternity relief.',
    },
    {
      'title': 'Article 43',
      'description':
          'Encourages the state to take steps towards securing a living wage and decent standard of life for workers.',
    },
    {
      'title': 'Article 44',
      'description':
          'Advocates for a Uniform Civil Code for all citizens, irrespective of religious practices.',
    },
    {
      'title': 'Article 46',
      'description':
          'Promotes the educational and economic interests of Scheduled Castes, Scheduled Tribes, and other weaker sections.',
    },
    {
      'title': 'Article 47',
      'description':
          'Directs the state to improve public health and nutrition and prohibit the consumption of intoxicating drinks and drugs.',
    },
    {
      'title': 'Article 48',
      'description':
          'Protects cows and cattle from slaughter and encourages the preservation of animal resources.',
    },
    {
      'title': 'Article 49',
      'description':
          "Preserves the historical and cultural heritage of India's monuments and sites of national importance.",
    },
    {
      'title': 'Article 51A',
      'description':
          'Lists fundamental duties of citizens, including cherishing the rich heritage of India.',
    },
    {
      'title': 'Article 59',
      'description':
          'Grants the President the power to grant pardons, reprieves, respites, or remission of punishment.',
    },
    {
      'title': 'Article 61',
      'description':
          'Deals with the impeachment of the President by the Parliament in case of violation of the Constitution.',
    },
    {
      'title': 'Article 72',
      'description':
          'Provides for the President\'s power to grant pardons, reprieves, respites, or remissions of punishment.',
    },
    {
      'title': 'Article 73',
      'description':
          'Specifies the extent of the executive power of the Union and its relationship with the states.',
    },
    {
      'title': 'Article 74',
      'description':
          'Deals with the Council of Ministers to aid and advise the President.',
    },
    {
      'title': 'Article 75',
      'description':
          'Outlines the appointment and term of the Prime Minister and other Ministers.',
    },
    {
      'title': 'Article 86',
      'description':
          'Specifies the manner of elections and composition of the Rajya Sabha, the upper house of Parliament.',
    },
    {
      'title': 'Article 100',
      'description':
          'Provides for the continuation of the business of the Lok Sabha, the lower house of Parliament, in case of a dissolution.',
    },
    {
      'title': 'Article 123',
      'description':
          'Grants the President the power to promulgate ordinances when Parliament is not in session.',
    },
    {
      'title': 'Article 131',
      'description':
          'Deals with the original jurisdiction of the Supreme Court in disputes between the Government of India and one or more states.',
    },
    {
      'title': 'Article 148',
      'description':
          'Establishes the office of the Comptroller and Auditor General of India, responsible for auditing government accounts.',
    },
    {
      'title': 'Article 151',
      'description':
          'Specifies the duties and powers of the Comptroller and Auditor General in relation to the accounts of the Union and the states.',
    },
    {
      'title': 'Article 163',
      'description':
          'Deals with the Council of Ministers in states and their functions, headed by the Chief Minister.',
    },
    {
      'title': 'Article 215',
      'description':
          'Provides for the High Courts to be courts of record and have the power of judicial review.',
    },
    {
      'title': 'Article 226',
      'description':
          'Empowers the High Courts to issue writs for the enforcement of fundamental rights and for any other purpose.',
    },
    {
      'title': 'Article 244',
      'description':
          'Specifies the administration of Scheduled Areas and Tribal Areas in various states.',
    },
    {
      'title': 'Article 246',
      'description':
          'Enumerates the distribution of legislative powers between the Union and the states.',
    },
    {
      'title': 'Article 249',
      'description':
          'Empowers the Parliament to legislate on a subject in the State List for reasons of national interest.',
    },
    {
      'title': 'Article 262',
      'description':
          'Deals with the adjudication of disputes relating to waters of inter-state rivers or river valleys.',
    },
    {
      'title': 'Article 280',
      'description':
          'Provides for the establishment of a Finance Commission to determine financial arrangements between the Union and the states.',
    },
    {
      'title': 'Article 300',
      'description':
          'Guarantees the right to property, which is no longer a fundamental right but a constitutional right.',
    },
    {
      'title': 'Article 312',
      'description':
          'Allows the creation of All India Services such as the Indian Administrative Service (IAS) and Indian Police Service (IPS).',
    },
    {
      'title': 'Article 323A',
      'description':
          'Provides for the establishment of Administrative Tribunals for resolving disputes related to recruitment and conditions of service for certain public servants.',
    },
    {
      'title': 'Article 340',
      'description':
          'Deals with the appointment of a Commission to investigate the conditions of socially and educationally backward classes.',
    },
    {
      'title': 'Article 343',
      'description':
          'Recognizes Hindi in Devanagari script as the official language of the Union, while also promoting the development of other Indian languages.',
    },
    {
      'title': 'Article 352',
      'description':
          'Deals with the proclamation of a National Emergency by the President in case of a threat to the security of India.',
    },
    {
      'title': 'Article 356',
      'description':
          'Gives the President the power to impose President\'s Rule in a state in case of a constitutional breakdown.',
    },
    {
      'title': 'Article 360',
      'description':
          'Empowers the President to proclaim Financial Emergency if the financial stability or credit of India is threatened.',
    },
    {
      'title': 'Article 368',
      'description':
          'Provides for the procedure of amending the Constitution, ensuring it is a flexible but controlled process.',
    },
    {
      'title': 'Article 371A',
      'description':
          'Special provisions for Nagaland, safeguarding their cultural and land rights.',
    },
    {
      'title': 'Article 371F',
      'description':
          'Special provisions for Sikkim, including an autonomous state legislature and protection of their laws.',
    },
    {
      'title': 'Article 371H',
      'description':
          'Special provisions for Arunachal Pradesh, ensuring equitable opportunities for economic and educational development.',
    },
    {
      'title': 'Article 372',
      'description':
          'Validates the laws in force before the commencement of the Constitution until they are repealed or amended.',
    },
    {
      'title': 'Article 378',
      'description':
          'Special provisions for the state of Jammu and Kashmir regarding the Governor and the High Court.',
    },
    {
      'title': 'Article 380',
      'description':
          'Special provisions for the state of Gujarat, including the formation of a bilingual state and compensation for its loss.',
    },
    {
      'title': 'Article 392',
      'description':
          'Provides for the power of the Supreme Court to review its judgments and orders.',
    },
    {
      'title': 'Article 395',
      'description':
          'Repeals the Indian Independence Act, 1947, and other enactments related to the Dominion of India and Pakistan.',
    },
    {
      'title': 'Article 396',
      'description':
          'Gives the President the power to make adaptations and modifications in existing laws for the proper functioning of the Government of India.',
    },
    {
      'title': 'Article 398',
      'description':
          'Deals with the power of the President to appoint and dismiss the Comptroller and Auditor General of India.',
    },
    {
      'title': 'Article 401',
      'description':
          'Specifies that the validity of any expenditure from the Consolidated Fund of India cannot be questioned in any court.',
    },
    {
      'title': 'Article 406',
      'description':
          'Defines the duties and powers of the Attorney General for India, the highest law officer of the country.',
    },
    {
      'title': 'Article 407',
      'description':
          'Deals with the conduct of Government business, including the distribution of business between the President and the Prime Minister.',
    },
    {
      'title': 'Article 417',
      'description':
          'Provides for the appointment of a Judge of the Supreme Court or a High Court as an ad hoc Judge of the Supreme Court.',
    },
    {
      'title': 'Article 418',
      'description':
          'Empowers the President to appoint retired judges of the Supreme Court to act as judges of that court.',
    },
    {
      'title': 'Article 420',
      'description':
          'Specifies the authority of the Supreme Court to review any judgment pronounced by it.',
    },
    {
      'title': 'Article 421',
      'description':
          'Provides for the power of the Supreme Court to review its own judgments and orders.',
    },
    {
      'title': 'Article 422',
      'description':
          'Deals with the power of the Supreme Court to recall and review its orders passed in certain cases.',
    },
    {
      'title': 'Article 424',
      'description':
          'Empowers the President to consult the Supreme Court on questions of law and fact of public importance.',
    },
    {
      'title': 'Article 425',
      'description':
          'Specifies the binding nature of the judgments and orders of the Supreme Court.',
    },
    {
      'title': 'Article 425A',
      'description':
          'Deals with the power of the Supreme Court to review its own judgments in civil matters.',
    },
    {
      'title': 'Article 425B',
      'description':
          'Deals with the power of the Supreme Court to review its own judgments in criminal matters.',
    },
    {
      'title': 'Article 432',
      'description':
          'Provides for the power of the President to suspend, remit, or commute the sentences of certain offenders.',
    },
    {
      'title': 'Article 361A',
      'description':
          'Deals with the special provisions for certain states regarding the conduct of State Public Service Commissions.',
    },
    {
      'title': 'Article 371I',
      'description':
          'Special provisions for the state of Goa, including reservation in legislative assembly seats.',
    },
    {
      'title': 'Article 371J',
      'description':
          'Special provisions for the state of Karnataka regarding seats in the Legislative Assembly and employment opportunities.',
    },
    {
      'title': 'Article 371K',
      'description':
          'Special provisions for the state of Andhra Pradesh regarding local recruitment of public services and educational facilities.',
    },
    {
      'title': 'Article 371L',
      'description':
          'Special provisions for the state of Kerala regarding local recruitment in certain services and educational facilities.',
    },
    {
      'title': 'Article 371M',
      'description':
          'Special provisions for the state of Maharashtra regarding the establishment of a separate development board.',
    },
    {
      'title': 'Article 371N',
      'description':
          'Special provisions for the state of Manipur regarding the assembly and council of ministers.',
    },
    {
      'title': 'Article 371O',
      'description':
          'Special provisions for the state of Assam regarding a separate development board.',
    },
    {
      'title': 'Article 371P',
      'description':
          'Special provisions for the state of Sikkim regarding the number of seats in the Legislative Assembly.',
    },
    {
      'title': 'Article 371Q',
      'description':
          'Special provisions for the state of Telangana regarding the reservation of seats and educational facilities.',
    },
    {
      'title': 'Article 371R',
      'description':
          'Special provisions for the state of Mizoram regarding the assembly and council of ministers.',
    },
    {
      'title': 'Article 371S',
      'description':
          'Special provisions for the state of Arunachal Pradesh regarding the assembly and council of ministers.',
    },
    {
      'title': 'Article 371T',
      'description':
          'Special provisions for the state of Goa regarding the reservation of seats in the Legislative Assembly.',
    },
    {
      'title': 'Article 371U',
      'description':
          'Special provisions for the state of Jammu and Kashmir regarding the reservation of seats and educational facilities.',
    },
  ];

  uploadToFirebase() async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection('articles');

    // Upload the articlesMap to Firestore
    await collection.doc('COI').set({'data': articlesList});
  }
}
