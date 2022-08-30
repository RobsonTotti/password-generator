import 'dart:math';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class GeneratePassword extends StatefulWidget {
  const GeneratePassword({Key? key}) : super(key: key);

  @override
  State<GeneratePassword> createState() => _GeneratePasswordState();
}

class _GeneratePasswordState extends State<GeneratePassword> {
  final _charsUppercase = "ABCÇDEFGHIJKLMNOPQRSTUVWXYZ";
  final _charsLowercase = "abcçdefghijklmnopqrstuvwxyz";
  final _charsNumbers = "0123456789";
  final _charsSymbols = "!@#\$%^&*()_+{}=´`^~/\\:;.>,<[]|¨'-?";

  final Random _rnd = Random();

  double _size = 18;
  bool _symbols = true;
  bool _uppercase = true;
  bool _lowercase = true;
  bool _number = true;
  String _password = "";

  @override
  void initState() {
    generatePassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Password Generator"),
        backgroundColor: const Color(0xff242423),
      ),
      backgroundColor: const Color(0xff333533),
      body: Center(
        child: SizedBox(
          width: width < 700 ? width : width * 0.5,
          child: Column(
            children: [
              CheckboxListTile(
                title: Text(
                  'Uppercase letters',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: const Color(0xffE8EDDF)),
                ),
                subtitle: Text(_charsUppercase,
                    style: GoogleFonts.poppins(
                        fontSize: 10, color: const Color(0xffCFDBD5))),
                autofocus: false,
                activeColor: const Color(0xffE8EDDF),
                checkColor: const Color(0xff242423),
                selected: _uppercase,
                value: _uppercase,
                onChanged: (bool? value) {
                  setState(() {
                    _uppercase = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Lowercase letters',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: const Color(0xffE8EDDF)),
                ),
                subtitle: Text(_charsLowercase,
                    style: GoogleFonts.poppins(
                        fontSize: 10, color: const Color(0xffCFDBD5))),
                autofocus: false,
                activeColor: const Color(0xffE8EDDF),
                checkColor: const Color(0xff242423),
                selected: _lowercase,
                value: _lowercase,
                onChanged: (bool? value) {
                  setState(() {
                    _lowercase = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Numbers',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: const Color(0xffE8EDDF)),
                ),
                subtitle: Text(_charsNumbers,
                    style: GoogleFonts.poppins(
                        fontSize: 10, color: const Color(0xffCFDBD5))),
                autofocus: false,
                activeColor: const Color(0xffE8EDDF),
                checkColor: const Color(0xff242423),
                selected: _number,
                value: _number,
                onChanged: (bool? value) {
                  setState(() {
                    _number = value!;
                  });
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Symbols',
                  style: GoogleFonts.poppins(
                      fontSize: 14, color: const Color(0xffE8EDDF)),
                ),
                subtitle: Text(_charsSymbols,
                    style: GoogleFonts.poppins(
                        fontSize: 10, color: const Color(0xffCFDBD5))),
                autofocus: false,
                activeColor: const Color(0xffE8EDDF),
                checkColor: const Color(0xff242423),
                selected: _symbols,
                value: _symbols,
                onChanged: (bool? value) {
                  setState(() {
                    _symbols = value!;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Password size: ${int.tryParse(_size.toStringAsFixed(0)).toString()}',
                style: GoogleFonts.poppins(
                    fontSize: 14, color: const Color(0xffE8EDDF)),
              ),
              Slider(
                min: 6,
                max: 120,
                divisions: 120,
                value: _size,
                label: int.tryParse(_size.toStringAsFixed(0)).toString(),
                activeColor: const Color(0xffE8EDDF),
                inactiveColor: const Color(0xff242423),
                thumbColor: const Color(0xffE8EDDF),
                onChanged: (value) {
                  setState(() {
                    _size = value;
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Your password',
                style: GoogleFonts.poppins(
                    fontSize: 14, color: const Color(0xffE8EDDF)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: _password == ''
                        ? const CircularProgressIndicator()
                        : Text(
                            _password,
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: const Color(0xffE8EDDF)),
                          ),
                  ),
                  IconButton(
                      onPressed: () {
                        FlutterClipboard.copy(_password).then((value) {
                          Fluttertoast.showToast(
                              msg: "Copyed to clipboard",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM_RIGHT,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                      icon: const Icon(
                        Icons.copy,
                        color: Color(0xffE8EDDF),
                      )),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                child: const Text('Generate new password'),
                onPressed: () {
                  setState(() {
                    _password = '';
                  });

                  generatePassword();
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xff44355b),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  generatePassword() {
    var _chars = "";

    if (_symbols) {
      _chars += _charsSymbols;
    }

    if (_uppercase) {
      _chars += _charsUppercase;
    }

    if (_lowercase) {
      _chars += _charsLowercase;
    }

    if (_number) {
      _chars += _charsNumbers;
    }

    setState(() {
      _password = String.fromCharCodes(Iterable.generate(
          int.tryParse(_size.toString())!,
          (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    });
  }
}
