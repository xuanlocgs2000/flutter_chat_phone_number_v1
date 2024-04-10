import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_ffb/data/datasource/firebase_remote_datasource.dart';
// import 'package:flutter_chat_ffb/data/model/my_chat_model.dart';
// import 'package:flutter_chat_ffb/data/model/text_message_model.dart';
import 'package:flutter_chat_ffb/data/model/user_model.dart';
import 'package:flutter_chat_ffb/domain/entities/my_chat_entity.dart';
import 'package:flutter_chat_ffb/domain/entities/text_message_entity.dart';
// import 'package:flutter_chat_ffb/domain/entities/my_chat_entity.dart';
// import 'package:flutter_chat_ffb/domain/entities/text_message_entity.dart';
import 'package:flutter_chat_ffb/domain/entities/user_entity.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore fireStore;
  String _verificationId = "";
  FirebaseRemoteDataSourceImpl({required this.auth, required this.fireStore});
  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = fireStore.collection("users");
    final uid = await getCurrentUID();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        status: user.status,
        profileUrl: user.profileUrl,
        isOnline: user.isOnline,
        uid: uid,
        phoneNumber: user.phoneNumber,
        email: user.email,
        name: user.name,
      ).toDocument();
      if (!userDoc.exists) {
        //create new user
        userCollection.doc(uid).set(newUser);
      } else {
        //update user doc
        userCollection.doc(uid).update(newUser);
      }
    });
  }

  @override
  Future<String> getCurrentUID() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser!.uid != null;
  @override
  Future<void> signInWithPhoneNumber(String smsPinCode) async {
    final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: _verificationId, smsCode: smsPinCode);
    await auth.signInWithCredential(authCredential);
  }

  @override
  Future<void> signOut() async {
    // TODO: implement signOut
    Future<void> signOut() async => await auth.signOut();
  }

  @override
  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted phoneVerificationCompleted =
        (AuthCredential authCredential) {
      print("phone verified : Token ${authCredential.token}");
    };
    final PhoneVerificationFailed phoneVerificationFailed =
        (FirebaseAuthException firebaseAuthException) {
      print(
        "phone failed : ${firebaseAuthException.message},${firebaseAuthException.code}",
      );
    };
    final PhoneCodeAutoRetrievalTimeout phoneCodeAutoRetrievalTimeout =
        (String verificationId) {
      this._verificationId = verificationId;
      print("time out :$verificationId");
    };
    void phoneCodeSent(String verificationId, int? forceResendingToken) {
      print(
          "Verification ID: $verificationId, Force Resending Token: $forceResendingToken");
      // Handle verification code sent logic here (e.g., storing verificationId)
      _verificationId = verificationId;
    }

    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      timeout: const Duration(seconds: 10),
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }

  @override
  Future<void> addToMyChat(MyChatEntity myChatEntity) {
    // TODO: implement addToMyChat
    throw UnimplementedError();
  }

  @override
  Future<void> createOneToOneChatChannel(String uid, String otherUid) async {
    final userCollectionRef = fireStore.collection("users");
    final oneToOneChatChannelRef = fireStore.collection('myChatChannel');

    userCollectionRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((chatChannelDoc) {
      if (chatChannelDoc.exists) {
        return;
      }
      //if not exists
      final _chatChannelId = oneToOneChatChannelRef.doc().id;
      var channelMap = {
        "channelId": _chatChannelId,
        "channelType": "oneToOneChat",
      };
      oneToOneChatChannelRef.doc(_chatChannelId).set(channelMap);

      //currentUser
      userCollectionRef
          .doc(uid)
          .collection("engagedChatChannel")
          .doc(otherUid)
          .set(channelMap);

      //OtherUser
      userCollectionRef
          .doc(otherUid)
          .collection("engagedChatChannel")
          .doc(uid)
          .set(channelMap);

      return;
    });
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollectionRef = fireStore.collection("users");
    return userCollectionRef.snapshots().map((querySnapshot) {
      return querySnapshot.docs
          .map((docQuerySnapshot) => UserModel.fromSnapshot(docQuerySnapshot))
          .toList();
    });
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    // TODO: implement getMessages
    throw UnimplementedError();
  }

  @override
  Stream<List<MyChatEntity>> getMyChat(String uid) {
    // TODO: implement getMyChat
    throw UnimplementedError();
  }

  @override
  Future<String> getOneToOneSingleUserChannelId(String uid, String otherUid) {
    final userCollectionRef = fireStore.collection('users');
    return userCollectionRef
        .doc(uid)
        .collection('engagedChatChannel')
        .doc(otherUid)
        .get()
        .then((engagedChatChannel) {
      if (engagedChatChannel.exists) {
        return engagedChatChannel.data()?['channelId'];
      }
      return Future.value(null);
    });
  }

  @override
  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelId) {
    // TODO: implement sendTextMessage
    throw UnimplementedError();
  }
}
