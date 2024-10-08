import 'package:alumni_hub_ft_uh/common/utils/ui_helper.dart';
import 'package:alumni_hub_ft_uh/constants/common.dart';
import 'package:alumni_hub_ft_uh/features/claim_alumni/bloc/add/add_alumni_bloc.dart';
import 'package:alumni_hub_ft_uh/features/claim_alumni/bloc/get_jurusan/get_jurusan_bloc.dart';
import 'package:alumni_hub_ft_uh/features/claim_alumni/domain/models/add_alumni_model.dart';
import 'package:alumni_hub_ft_uh/features/claim_alumni/domain/models/get_all_jurusan_model.dart';
import 'package:alumni_hub_ft_uh/features/user/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:alumni_hub_ft_uh/common/widgets/button/button_widget.dart';
import 'package:alumni_hub_ft_uh/common/widgets/textField/text_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class InsertAlumniDataScreen extends StatefulWidget {
  static const route = "/insert_alumni_data";

  const InsertAlumniDataScreen({super.key});

  @override
  State<InsertAlumniDataScreen> createState() => _InsertAlumniDataScreenState();
}

class _InsertAlumniDataScreenState extends State<InsertAlumniDataScreen> {
  String? selectedJurusan;
  // String? selectedAngkatan;
  String? selectedGender;
  bool agreeToTerms = false;

  final _namaLengkapController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _stambukController = TextEditingController();
  final _noTelpController = TextEditingController();
  final _angkatanController = TextEditingController();
  // final _jurusanController = TextEditingController();
  // final _golonganDarahController = TextEditingController();
  // final _agamaController = TextEditingController();
  String? _golonganDarahController;
  String? _agamaController;

  @override
  void initState() {
    // get all jurusan from bloc
    context.read<GetJurusanBloc>().add(GetAllJurusan());
    super.initState();
  }

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _tanggalLahirController.dispose();
    _stambukController.dispose();
    _noTelpController.dispose();
    _angkatanController.dispose();
    // _jurusanController.dispose();
    // _golonganDarahController.dispose();
    // _agamaController.dispose();

    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.red, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor:
                Colors.white, // background color of the dialog
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        _tanggalLahirController.text =
            DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  void _handleAddData() {
    if (!agreeToTerms) {
      // Show SnackBar if terms are not agreed upon
      showToastMessage(
        message: 'Anda harus menyetujui syarat dan ketentuan terlebih dahulu.',
      );
    } else {
      // Proceed with sign up if terms are agreed
      final userSession = context.read<UserBloc>().getUserSession();
      context.read<AddAlumniBloc>().add(
            AddAlumni(
              addAlumniBody: AddAlumniBody(
                name: _namaLengkapController.text,
                nim: _stambukController.text,
                kelamin: selectedGender! == 'Laki-laki' ? 'l' : 'p',
                tglLahir: _tanggalLahirController.text,
                jurusan: selectedJurusan ?? '',
                angkatan: _angkatanController.text,
                golonganDarah: _golonganDarahController,
                agama: _agamaController,
                noTelp: _noTelpController.text,
              ),
              token: userSession?.token,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: BlocBuilder<GetJurusanBloc, GetJurusanState>(
        builder: (context, jurusanState) {
          if (jurusanState is GetJurusanError) {
            return Center(
              child: Column(
                children: [
                  Text(
                    jurusanState.exception.message,
                    style: textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ButtonWidget(
                    onPressed: () {
                      context.read<GetJurusanBloc>().add(GetAllJurusan());
                    },
                    label: 'Coba Lagi',
                    color: Colors.white,
                  ),
                ],
              ),
            );
          } else if (jurusanState is GetJurusanLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          } else if (jurusanState is GetJurusanSuccess) {
            return SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: constraints.maxHeight -
                          MediaQuery.of(context).padding.top,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.2),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 24),
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Data Alumni',
                              style: textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.02,
                              ),
                            ),
                            Text(
                              'Isi Data Alumni',
                              style: textTheme.titleMedium?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFieldWidget(
                              label: 'Nama Lengkap',
                              hint: 'Masukkan nama lengkap',
                              controller: _namaLengkapController,
                            ),
                            const SizedBox(height: 12),
                            InkWell(
                              onTap: () => _selectDate(context),
                              child: IgnorePointer(
                                child: TextFieldWidget(
                                  label: 'Tanggal Lahir',
                                  hint: 'Masukkan tanggal lahir',
                                  controller: _tanggalLahirController,
                                  icon: const Icon(Icons.arrow_drop_down),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextFieldWidget(
                              label: 'NIM/Stambuk',
                              hint: 'Masukkan stambuk',
                              controller: _stambukController,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'Jenis Kelamin',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedGender = 'Laki-laki';
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedGender == 'Laki-laki'
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Center(
                                        child: Text(
                                          'Laki-laki',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: selectedGender == 'Laki-laki'
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedGender = 'Perempuan';
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: selectedGender == 'Perempuan'
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Center(
                                        child: Text(
                                          'Perempuan',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: selectedGender == 'Perempuan'
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No Telepon',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  constraints: const BoxConstraints(
                                    minHeight: 60,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFD80100),
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(8),
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '+62',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius:
                                          const BorderRadius.horizontal(
                                        right: Radius.circular(8),
                                      ),
                                    ),
                                    child: TextField(
                                      controller: _noTelpController,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.all(16.0),
                                        hintText: 'Masukkan nomor telepon',
                                        border: InputBorder.none,
                                        hintStyle:
                                            textTheme.bodyMedium?.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            TextFieldWidget(
                              label: 'Angkatan',
                              hint: 'Masukkan angkatan',
                              controller: _angkatanController,
                              maxLength: 4,
                            ),
                            // Jurusan Dropdown
                            const Text(
                              'Jurusan',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                hintStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                labelStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                              hint: Text(
                                'Pilih jurusan',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              value: selectedJurusan,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedJurusan = newValue;
                                });
                              },
                              items: jurusanState.response.data
                                  .map((Jurusan value) {
                                return DropdownMenuItem<String>(
                                  value: value.namaJurusan,
                                  child: Text(
                                    value.namaJurusan,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              }).toList(),
                            ),

                            const SizedBox(height: 12),
                            // dropdown golongan darah
                            const Text(
                              'Golongan Darah',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                hintStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                labelStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                              ),
                              hint: Text(
                                'Pilih golongan darah',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              value: _golonganDarahController,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _golonganDarahController = newValue;
                                });
                              },
                              items: golonganDarahList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              }).toList(),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Agama',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              dropdownColor: Colors.white,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                              ),
                              hint: Text(
                                'Pilih agama',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              value: _agamaController,
                              onChanged: (String? newValue) {
                                setState(() {
                                  _agamaController = newValue;
                                });
                              },
                              items: agamaList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                );
                              }).toList(),
                            ),
                            // TextFieldWidget(
                            //   label: 'Agama',
                            //   hint: 'Masukkan agama',
                            //   controller: _agamaController,
                            // ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                SizedBox(
                                  height: 24,
                                  child: Checkbox(
                                    value: agreeToTerms,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        agreeToTerms = value ?? false;
                                      });
                                    },
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Saya menyetujui ',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: Colors.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: 'syarat dan ketentuan',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.red,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pushNamed(
                                                  context, '/license');
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            BlocConsumer<AddAlumniBloc, AddAlumniState>(
                              listener: (context, state) {
                                if (state is AddAlumniSuccess) {
                                  showToastMessage(
                                      message:
                                          'Data alumni berhasil ditambahkan');
                                  Navigator.pushNamed(context, '/home');
                                } else if (state is AddAlumniError) {
                                  showToastMessage(
                                      message: state.exception.message);
                                }
                              },
                              builder: (context, state) {
                                return SizedBox(
                                  width: double.infinity,
                                  child: ButtonWidget(
                                      onPressed: _handleAddData,
                                      label: 'Daftar',
                                      isLoading: state is AddAlumniLoading,
                                      color: agreeToTerms
                                          ? Theme.of(context).primaryColor
                                          : Colors.grey,
                                      disabled:
                                          _namaLengkapController.text.isEmpty ||
                                              _tanggalLahirController
                                                  .text.isEmpty ||
                                              _stambukController.text.isEmpty ||
                                              selectedJurusan == null ||
                                              _angkatanController.text.isEmpty),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
