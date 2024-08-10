import 'package:alumni_hub_ft_uh/features/auth/popup_claim_alumni_data.dart';
import 'package:flutter/material.dart';
import 'package:alumni_hub_ft_uh/constants/colors.dart';
import 'package:alumni_hub_ft_uh/common/widgets/button/button_widget.dart';
import 'package:alumni_hub_ft_uh/common/widgets/textField/text_field_widget.dart';
import 'package:intl/intl.dart';

class ClaimAlumniDataScreen extends StatefulWidget {
  static const route = "/claim_alumni_data";

  const ClaimAlumniDataScreen({super.key});

  @override
  State<ClaimAlumniDataScreen> createState() => _ClaimAlumniDataScreenState();
}

class _ClaimAlumniDataScreenState extends State<ClaimAlumniDataScreen> {
  final _namaLengkapController = TextEditingController();
  final _tanggalLahirController = TextEditingController();
  final _nimController = TextEditingController();
  bool agreeToTerms = false;

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _tanggalLahirController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _navigateAndShowPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Kelengkapan Data',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
              ),
              Text(
                'Klaim Data Alumni',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(
                thickness: 1.0,    // Thickness of the divider
              ),
            ],
          ),
          content: Text(
            'Untuk mendapatkan akses full, isi kelengkapan data alumni.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ButtonWidget(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    label: 'Nanti',
                    color: AppColors.gray3,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ButtonWidget(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog and stay on the same screen
                    },
                    label: 'Klaim data',
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  // Add list of alumni data
  List<AlumniData> alumniDataList = [
    AlumniData(
      name: 'Muh. Mahatma Arrayyan',
      nim: 'D121221015',
      dob: '30-10-2005',
      department: 'Teknik Informatika',
      year: '2021',
      onClaim: () {
        // Handle claim action for Muh. Mahatma Arrayyan
      },
      isClaimed: false, // Not claimed
    ),
    AlumniData(
      name: 'John Doe',
      nim: 'D121221016',
      dob: '15-05-2005',
      department: 'Teknik Elektro',
      year: '2021',
      onClaim: () {
        // Handle claim action for John Doe
      },
      isClaimed: true, // Already claimed
    ),
    AlumniData(
      name: 'Jane Smith',
      nim: 'D121221017',
      dob: '22-07-2005',
      department: 'Teknik Sipil',
      year: '2021',
      onClaim: () {
        // Handle claim action for Jane Smith
      },
      isClaimed: false, // Not claimed
    ),
  ];

  void _showPopupClaimAlumniData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupClaimAlumniData(
          alumniDataList: alumniDataList,
          onBack: () { /* Optional callback */ },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight:
              constraints.maxHeight - MediaQuery.of(context).padding.top,
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.02,
                      ),
                    ),
                    Text(
                      'Isi Data Alumni',
                      style: textTheme.titleMedium?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'Nama',
                      hint: 'Masukkan nama lengkap',
                      controller: _namaLengkapController,
                    ),
                    const SizedBox(height: 24),
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
                    const SizedBox(height: 24),
                    TextFieldWidget(
                      label: 'NIM/Stambuk (Optional)',
                      hint: 'Masukkan NIM/Stambuk',
                      controller: _nimController,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        onPressed: _showPopupClaimAlumniData, // Show the popup when pressed
                        label: 'Klaim Data',
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        onPressed: _navigateAndShowPopup, // Show the popup when pressed
                        label: 'Nanti',
                        color: AppColors.gray3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
