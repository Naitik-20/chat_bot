import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color color1 = const Color(0xff7ccaf8); // Sky Blue
  final Color color2 = const Color(0xff66cbd9); // Light Teal
  final Color color3 = const Color(0xfff2cca2); // Peach

  final List<bool> isExpandedList = [false, false, false, false];

  void toggleExpand(int index) {
    setState(() => isExpandedList[index] = !isExpandedList[index]);
  }

  void showEditDialog({
    required String title,
    required String currentValue,
    required Function(String) onSave,
    bool isDropdown = false,
    List<String> dropdownItems = const [],
  }) {
    final TextEditingController controller = TextEditingController(text: currentValue);
    String selected = currentValue;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: color1.withOpacity(0.1),
        title: Text("Edit $title", style: TextStyle(color: color2, fontWeight: FontWeight.bold)),
        content: isDropdown
            ? DropdownButtonFormField<String>(
          value: selected,
          style: const TextStyle(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "Select $title",
            labelStyle: TextStyle(color: color2),
          ),
          items: dropdownItems
              .map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          ))
              .toList(),
          onChanged: (val) {
            if (val != null) selected = val;
          },
        )
            : TextField(
          controller: controller,
          style: const TextStyle(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: "Enter $title",
            labelStyle: TextStyle(color: color2),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(fontWeight: FontWeight.bold))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: color3),
            onPressed: () {
              onSave(isDropdown ? selected : controller.text);
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Sample Data
  String firstName = "Naitik";
  String lastName = "Gupta";
  String phone = "9876543210";
  String email = "naitik@example.com";
  String gender = "Male";
  String address = "123 Main Street";
  String dob = "01 Jan 2000";
  String tob = "10:30 AM";
  String pob = "Delhi";
  String zodiac = "Capricorn";
  String profession = "Engineer";
  String hobbies = "Photography, Gaming";
  String music = "Jazz";
  String favSport = "Cricket";
  String favActor = "SRK";
  String favPlace = "Ladakh";
  String favSinger = "Arijit Singh";
  String personality = "Introvert";
  String sleepTime = "11 PM";
  String workHours = "9 AM - 6 PM";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1.withOpacity(0.25), color2.withOpacity(0.8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              AppBar(
                backgroundColor: color2,
                title: const Text("Profile Page", style: TextStyle(fontWeight: FontWeight.bold)),
                centerTitle: true,
                elevation: 4,
              ),
              const SizedBox(height: 10),
              _buildExpandableTile(
                index: 0,
                title: "Basic Information",
                tileColor: color1,
                content: Column(
                  children: [
                    _infoRow("First Name", firstName, (val) => setState(() => firstName = val)),
                    _infoRow("Last Name", lastName, (val) => setState(() => lastName = val)),
                    _infoRow("Phone No", phone, (val) => setState(() => phone = val)),
                    _infoRow("Email", email, (val) => setState(() => email = val)),
                    _infoRow("Gender", gender, (val) => setState(() => gender = val),
                        isDropdown: true, dropdownItems: ["Male", "Female", "Other"]),
                    _infoRow("Address", address, (val) => setState(() => address = val)),
                  ],
                ),
              ),
              _buildExpandableTile(
                index: 1,
                title: "Personal Information",
                tileColor: color2,
                content: Column(
                  children: [
                    _infoRow("Date of Birth", dob, (val) => setState(() => dob = val)),
                    _infoRow("Time of Birth", tob, (val) => setState(() => tob = val)),
                    _infoRow("Place of Birth", pob, (val) => setState(() => pob = val)),
                    _infoRow("Zodiac Sign", zodiac, (val) => setState(() => zodiac = val)),
                  ],
                ),
              ),
              _buildExpandableTile(
                index: 2,
                title: "Hobbies / Profession",
                tileColor: color3,
                content: Column(
                  children: [
                    _infoRow("Profession", profession, (val) => setState(() => profession = val)),
                    _infoRow("Hobbies", hobbies, (val) => setState(() => hobbies = val)),
                    _infoRow("Music Type", music, (val) => setState(() => music = val)),
                    _infoRow("Fav Sport", favSport, (val) => setState(() => favSport = val)),
                    _infoRow("Fav Actor", favActor, (val) => setState(() => favActor = val)),
                    _infoRow("Fav Place", favPlace, (val) => setState(() => favPlace = val)),
                    _infoRow("Fav Singer", favSinger, (val) => setState(() => favSinger = val)),
                  ],
                ),
              ),
              _buildExpandableTile(
                index: 3,
                title: "Other Info",
                tileColor: Colors.deepPurple.shade100,
                content: Column(
                  children: [
                    _infoRow("Introvert/Extrovert", personality, (val) => setState(() => personality = val),
                        isDropdown: true, dropdownItems: ["Introvert", "Extrovert", "Ambivert"]),
                    _infoRow("Sleep Timing", sleepTime, (val) => setState(() => sleepTime = val)),
                    _infoRow("Working Hours", workHours, (val) => setState(() => workHours = val)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, Function(String) onEdit,
      {bool isDropdown = false, List<String> dropdownItems = const []}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: color2),
            onPressed: () => showEditDialog(
              title: label,
              currentValue: value,
              onSave: onEdit,
              isDropdown: isDropdown,
              dropdownItems: dropdownItems,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableTile({
    required int index,
    required String title,
    required Widget content,
    required Color tileColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [tileColor.withOpacity(0.95), tileColor.withOpacity(0.75)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          title: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(
            isExpandedList[index] ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.black54,
          ),
          onExpansionChanged: (expanded) => toggleExpand(index),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: tileColor.withOpacity(0.15),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: content,
            )
          ],
        ),
      ),
    );
  }
}
