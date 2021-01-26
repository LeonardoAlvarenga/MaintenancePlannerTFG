import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:tfg_app/models/errors/firebase_auth_expection.dart';

class UserFb {
  final String uid;
  final String email;
  final String profilePictureUrl;

  UserFb({
    @required this.uid,
    @required this.email,
    this.profilePictureUrl,
  });
}

class AuthServices {
  final _auth = FirebaseAuth.instance;
  UserFb currentUserFb;

  Future<void> updateEmail(String email) async {
    final user = await _auth.currentUser();
    try {
      await user.updateEmail(email);
    } catch (error) {
      throw FbAuthException(error);
    }
  }

  Future<void> updatePassword(String password) async {
    final user = await _auth.currentUser();
    try {
      await user.updatePassword(password);
    } catch (error) {
      throw FbAuthException(error);
    }
  }

  Future<void> deleteUser() async {
    final user = await _auth.currentUser();
    try {
      await user.delete();
    } catch (error) {
      throw FbAuthException(error);
    }
  }

  //create user object based on FirebaseUser
  UserFb _userFromFirebase(FirebaseUser user) {
    if (user != null) {
      currentUserFb = UserFb(
        uid: user.uid,
        email: user.email,
        profilePictureUrl: user.photoUrl,
      );
      return currentUserFb;
    } else {
      return null;
    }
  }

  //auth change user stream
  Stream<UserFb> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebase);
  }

  //sign in email && password
  Future<UserFb> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser userFromFb = result.user;
      return _userFromFirebase(userFromFb);
    } catch (error) {
      throw FbAuthException(error);
    }
  }

  //register with email && password
  Future<UserFb> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser userFromFb = result.user;
      return _userFromFirebase(userFromFb);
    } catch (error) {
      throw FbAuthException(error);
    }
  }

  //sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _userFromFirebase(null);
    } catch (error) {
      throw FbAuthException(error);
    }
  }
}
