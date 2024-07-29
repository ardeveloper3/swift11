
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  User? get currentUser=> _firebaseAuth.currentUser;
  Stream<User?>get authStateChenges => _firebaseAuth.authStateChanges();

  //signinMethode

  Future<void>signInWithEmailAndPassword({
    required String email,
    required String password,
  })async{
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password
    );
  }

  //signUpMethode

  Future<void>createUserWithEmailAndPassword({
    required String email,
    required String password,
  })async{
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password
    );

  }

  Future<void>signOut()async{
    await _firebaseAuth.signOut();
  }
}