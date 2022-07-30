import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:posts/models/profile.dart';
import 'package:posts/repositories/profile/update_profile_repository.dart';
import 'package:posts/support/app_container.dart';
import 'package:posts/support/avatar_helper.dart';
import 'package:validators/validators.dart';
import 'package:masked_text_field/masked_text_field.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  const EditProfilePage({
    super.key,
    required this.profile,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  final _formKey = GlobalKey<FormState>();
  late String photo;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.profile.name);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phone);
    photo = widget.profile.photo;
  }

  void _save() async {
    final repo = AppContainer.resolve<UpdateProfileRepository>();
    try {
      await repo.updateProfile(widget.profile.copyWith(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        photo: photo,
      ));
      Navigator.pop(context, "has_updated");
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Oops, could not complete action!'),
        backgroundColor: Colors.redAccent,
      ));
    }
  }

  void _changeAvatar() {
    setState(() {
      photo = AvatarHelper().generateUrlAvatar();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: Hero(
                  tag: widget.profile.id,
                  child: SvgPicture.network(
                    photo,
                    placeholderBuilder: (_) =>
                        const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: _changeAvatar,
              child: const Text("Change avatar"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 24.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Name *',
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      validator: (String? value) {
                        if (!isEmail(value ?? "")) {
                          return "Invalid email";
                        }
                        return null;
                      },
                    ),
                    MaskedTextField(
                      mask: "(###) ####-####",
                      escapeCharacter: '#',
                      maxLength: 15,
                      textFieldController: _phoneController,
                      keyboardType: TextInputType.phone,
                      inputDecoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        labelText: 'Phone',
                      ),
                      onChange: (String value) {},
                    ),
                    const Divider(),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _save();
                        }
                      },
                      child: const Text("Update"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
