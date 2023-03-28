import 'package:flutter/material.dart';

import '../utils/routes.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _phone = '';
  int _age = -1;
  int _selectedGender = 0;
  int _height = -1;
  int _weight = -1;
  bool _termsChecked = true;

  List<DropdownMenuItem<int>> genderList = [];

  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      value: 0,
      child: Text('Male'),
    ));
    genderList.add(const DropdownMenuItem(
      value: 1,
      child: Text('Female'),
    ));
    genderList.add(const DropdownMenuItem(
      value: 2,
      child: Text('Others'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    // Build a Form widget using the _formKey we created above
    return Form(
        key: _formKey,
        child: ListView(
          children: getFormWidget(),
        ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your name';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _name = value.toString();
        });
      },
    ));

    validatePhoneNumber(String? value) {
      if (value!.isEmpty) {
        return 'Enter phone number';
      }

      Pattern pattern = r'(^(?:[+]91)?[0-9]{10,12}$)';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value.toString())) {
        return 'Enter Valid Phone Number';
      } else {
        return null;
      }
    }

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          labelText: 'Enter Phone Number', hintText: 'Phone Number'),
      keyboardType: TextInputType.phone,
      validator: validatePhoneNumber,
      onSaved: (value) {
        setState(() {
          _phone = value.toString();
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(hintText: 'Age', labelText: 'Enter Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter age';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _age = int.parse(value.toString());
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          hintText: 'Height', labelText: 'Enter Height (in cms)'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter height';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _height = int.parse(value.toString());
        });
      },
    ));

    formWidget.add(TextFormField(
      decoration: const InputDecoration(
          hintText: 'Weight', labelText: 'Enter Weight (in kgs)'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter weight';
        } else {
          return null;
        }
      },
      onSaved: (value) {
        setState(() {
          _weight = int.parse(value.toString());
        });
      },
    ));

    formWidget.add(DropdownButton(
      hint: const Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));

    formWidget.add(CheckboxListTile(
      value: _termsChecked,
      onChanged: (value) {
        setState(() {
          _termsChecked = value.toString().toLowerCase() == 'true';
        });
      },
      subtitle: !_termsChecked
          ? const Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            )
          : null,
      title: const Text(
        'I agree to the terms and condition',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    void onPressedSubmit() {
      if (_formKey.currentState!.validate() && _termsChecked) {
        _formKey.currentState?.save();

        print("Name: " + _name);
        print("Phone Number: " + _phone);
        print("Age: " + _age.toString());
        print("Height: " + _height.toString());
        print("Weight: " + _weight.toString());
        switch (_selectedGender) {
          case 0:
            print("Gender: Male");
            break;
          case 1:
            print("Gender: Female");
            break;
          case 3:
            print("Gender: Others");
            break;
        }
        print("Terms checked: " + _termsChecked.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Form Submitted')));
        Navigator.pushNamed(context, MyRoutes.dashboardRoute);
      }
    }

    formWidget.add(
        ElevatedButton(child: const Text('Enter'), onPressed: onPressedSubmit));

    return formWidget;
  }
}
