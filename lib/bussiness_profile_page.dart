import 'package:flutter/material.dart';

class BusinessProfilePage extends StatefulWidget {
  const BusinessProfilePage({super.key});

  @override
  State<BusinessProfilePage> createState() => _BusinessProfilePageState();
}

class _BusinessProfilePageState extends State<BusinessProfilePage> {
  String contactType = 'Enquiry No';
  final _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>()];
  final _controllers = List.generate(10, (_) => TextEditingController());
  List<TextEditingController> phoneControllers = [];
  List<TextEditingController> addressControllers = [];

  @override
  void initState() {
    super.initState();
    phoneControllers.add(TextEditingController());
    addressControllers.add(TextEditingController());
  }

  Widget _buildPhoneFields() {
    return Column(
      children: List.generate(phoneControllers.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildFormRow(
            index == 0 ? 'Phone' : '',
            phoneControllers[index],
            'Enter your contact number',
          ),
        );
      }),
    );
  }

  Widget _buildAddressFields() {
    return Column(
      children: List.generate(addressControllers.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: _buildFormRow(
            index == 0 ? 'Address' : '',
            addressControllers[index],
            'Enter your address',
          ),
        );
      }),
    );
  }

  Widget _buildAddButton(bool isPhone) {
    return TextButton(
      onPressed: () {
        setState(() {
          isPhone
              ? phoneControllers.add(TextEditingController())
              : addressControllers.add(TextEditingController());
        });
      },
      child: Text('Add another ${isPhone ? 'number' : 'address'}'),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              onPressed: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                width: 135,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.circle, color: Colors.white, size: 40),
                        Icon(Icons.headset_mic_rounded,
                            size: 20, color: Colors.blue),
                      ],
                    ),
                    Text('Support', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(color: Colors.grey, height: 1.0),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: MediaQuery.of(context).size.width / 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Setup your Business Profile',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildExpansionTile(context, 'Required information',
                          'Provide required information', _formKeys[0], [
                        _buildFormRow('Business Name', _controllers[0],
                            'This name will be visible to your users'),
                        _buildPhoneFields(),
                        _buildAddressFields(),
                        _buildFormRow('Create Workspace Name', _controllers[1],
                            'Enter your unique workspace name')
                      ]),
                      const SizedBox(height: 10),
                      _buildExpansionTile(context, 'Optional information',
                          'Provide optional information', _formKeys[1], [
                        _buildFormRow('Business Description', _controllers[2],
                            'Provide a short overview of your healthcare facility'),
                        _buildFormRow('Website', _controllers[3],
                            'eg.https://website.com'),
                        _buildFormRow('Primary Email', _controllers[4],
                            'eg.example@abc.com'),
                        _buildFormRow('GPS Coordinates', _controllers[5],
                            'Enter the coordinates'),
                        _buildFormRow('Legal Name', _controllers[6],
                            'Business legal name'),
                        _buildFormRow(
                            'GST Number', _controllers[7], 'eg. 24udg5365dcu'),
                      ]),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.black),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Cancel',
                                style: TextStyle(color: Colors.black)),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {
                            

                            },
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor:
                                  const Color.fromRGBO(45, 51, 65, 1),
                            ),
                            child: const Text('Create Profile',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

//       Future<void> postData() async {
//   // API URL
//   final url = Uri.parse('https://mrishab.pythonanywhere.com/api/');

//   // Data to be sent in POST request
//   final Map<String, dynamic> data = {
//     "business_name": "Sample Business",
//     "phone": "1234567890",
//     "address": "Sample Address",
//     "workspacename": "sampleworkspace.com",
//     "website": "https://samplewebsite.com",
//     "email": "sampleemail@gmail.com"
//   };

//   try {
//     // Make POST request
//     final response = await http.post(
//       url,
//       headers: {
//         "Content-Type": "application/json",
//       },
//       body: json.encode(data),
//     );

//     // Check response status
//     if (response.statusCode == 200) {
//       print("Success: ${response.body}");
//     } else {
//       print("Failed: ${response.statusCode} - ${response.reasonPhrase}");
//     }
//   } catch (e) {
//     print("Error: $e");
//   }
// }
  Widget _buildExpansionTile(BuildContext context, String title,
      String subtitle, GlobalKey<FormState> formKey, List<Widget> formFields) {
    ValueNotifier<bool> isExpandedNotifier = ValueNotifier<bool>(false);
    ValueNotifier<String> statusNotifier = ValueNotifier<String>('Incomplete');

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
              ],
            ),
            ValueListenableBuilder<String>(
              valueListenable: statusNotifier,
              builder: (context, status, child) {
                final colors = _getStatusColors(status);
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors['borderColor'] as Color),
                    borderRadius: BorderRadius.circular(50),
                    color: colors['backgroundColor'],
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: colors['textColor'],
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        childrenPadding: const EdgeInsets.all(8),
        initiallyExpanded: false,
        trailing: ValueListenableBuilder<bool>(
          valueListenable: isExpandedNotifier,
          builder: (context, isExpanded, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  !isExpanded ? Icons.circle_outlined : Icons.circle,
                  size: 45,
                  color: Colors.black,
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  size: 40,
                  color: !isExpanded ? Colors.black : Colors.white,
                ),
              ],
            );
          },
        ),
        onExpansionChanged: (expanded) {
          isExpandedNotifier.value = expanded;
          if (expanded) {
            statusNotifier.value = 'In Progress';
          } else {
            bool isValid = formKey.currentState?.validate() ?? false;
            statusNotifier.value = isValid ? 'Complete' : 'Incomplete';
          }
        },
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        textColor: Colors.black,
        collapsedBackgroundColor: Colors.transparent,
        iconColor: Colors.black,
        collapsedIconColor: Colors.grey,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(30),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if (title == 'Optional information') ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 30,
                            ),
                            Text('512 x 512 png')
                          ],
                        ),
                      ),
                    ),
                    const Text(
                      'Drop or upload your clinic logo',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  ListView(
                    shrinkWrap: true,
                    children: formFields,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, Color> _getStatusColors(String status) {
    Color borderColor;
    Color backgroundColor;
    Color textColor;

    switch (status) {
      case 'In Progress':
        textColor = const Color.fromRGBO(102, 66, 9, 1);
        borderColor = const Color.fromRGBO(45, 51, 65, 0.1);
        backgroundColor = const Color.fromRGBO(255, 228, 173, 1);
        break;
      case 'Complete':
        textColor = const Color.fromRGBO(52, 199, 89, 1);
        borderColor = const Color.fromRGBO(52, 199, 89, 0.2);
        backgroundColor = const Color.fromRGBO(52, 199, 89, 0.2);
        break;
      default:
        textColor = const Color.fromRGBO(45, 51, 65, 1);
        borderColor = const Color.fromRGBO(45, 51, 65, 0.1);
        backgroundColor = const Color.fromRGBO(238, 240, 243, 1);
    }

    return {
      'borderColor': borderColor,
      'backgroundColor': backgroundColor,
      'textColor': textColor
    };
  }

  Widget _buildFormRow(
      String label, TextEditingController controller, String hint) {
    Widget? prefixWidget;
    Widget? suffixWidget;

    if (hint == 'Enter your contact number') {
      suffixWidget = Container(
        height: 20,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.grey),
        ),
        padding: const EdgeInsets.only(left: 10),
        child: DropdownButton<String>(
          value: contactType,
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          onChanged: (String? newValue) {
            setState(() {
              contactType = newValue!;
            });
          },
          items: <String>['Enquiry No', 'Emergency No']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          underline: const SizedBox(),
        ),
      );
    } else if (label == 'Create Workspace Name') {
      prefixWidget = Container(
        margin: const EdgeInsets.only(right: 10),
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Center(
            child: Text(
          'https://healthcare.io/',
          style: TextStyle(color: Colors.grey),
        )),
      );
    } else if (label == 'GPS Coordinates') {
      suffixWidget = Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gps_fixed),
            SizedBox(
              width: 5,
            ),
            Text(
              'Find',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(label,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              const Text(':    ',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Expanded(
                flex: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(238, 240, 243, 1),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      suffixIcon: suffixWidget,
                      prefixIcon: prefixWidget,
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(45, 51, 65, 0.5)),
                      hintText: hint,
                      border: InputBorder.none,
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? 'Please fill this field'
                        : null,
                  ),
                ),
              ),
            ],
          ),
          if (label == 'Phone' || label == 'Address')
            Row(
              children: [
                const SizedBox(width: 250),
                _buildAddButton(label == 'Phone'),
              ],
            ),
        ],
      ),
    );
  }
}
