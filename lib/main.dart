import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const StudentInfoApp());
}

class StudentInfoApp extends StatelessWidget {
  const StudentInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSS3344 Lab 02',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const StudentProfileScreen(),
    );
  }
}

// Main screen with adaptive layout
class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CSS3344 Mobile App Dev - Lab 02'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? _buildPortraitView()
              : _buildLandscapeView();
        },
      ),
    );
  }

  // Portrait layout
  Widget _buildPortraitView() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        StudentDetailsSection(),
        SizedBox(height: 16),
        UniversitySection(),
      ],
    );
  }

  // Landscape layout
  Widget _buildLandscapeView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(12.0),
            child: StudentDetailsSection(),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(12.0),
            child: UniversitySection(),
          ),
        ),
      ],
    );
  }
}

// Student profile section
class StudentDetailsSection extends StatelessWidget {
  const StudentDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/my_picture.jpg'),
            ),
            SizedBox(height: 20),

            TitleSection(
              name: 'AUDREY BRUNYIE ANAK JOHNNY',
              location: 'Student ID: BCS24090058',
            ),

            Divider(height: 32, thickness: 1),

            Text(
              'Personal Life Goal / Quote:',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8),

            Text(
              '"Healthy"',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontStyle: FontStyle.italic,
                color: Colors.indigo,
              ),
            ),

            SizedBox(height: 24),

            PickerSection(),
          ],
        ),
      ),
    );
  }
}

// University information section
class UniversitySection extends StatelessWidget {
  const UniversitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'University Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),

            TitleSection(
              name: 'University of Technology Sarawak (UTS)',
              location:
                  'No. 1, Jalan Universiti, 96000 Sibu, Sarawak, Malaysia',
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable TitleSection from Exercise 2.1
class TitleSection extends StatelessWidget {
  final String name;
  final String location;

  const TitleSection({super.key, required this.name, required this.location});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 4),
                Text(location, style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// All four pickers
class PickerSection extends StatefulWidget {
  const PickerSection({super.key});

  @override
  State<PickerSection> createState() => _PickerSectionState();
}

class _PickerSectionState extends State<PickerSection> {
  DateTime? _selectedDate;
  String _selectedRole = 'Lecture Theatre A';

  final List<String> _roles = [
    'Lecture Theatre A',
    'Lecture Theatre B',
    'Lecture Theatre C',
    'Hibiscus Hall',
  ];

  // 1. Material Date Picker
  Future<void> _selectMaterialDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // 2. Cupertino Date Picker (Modal Sheet)
  void _showCupertinoDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (popupContext) => Container(
        height: 240,
        color: CupertinoColors.systemBackground.resolveFrom(popupContext),
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: _selectedDate ?? DateTime.now(),
          minimumDate: DateTime(1950),
          maximumDate: DateTime.now(),
          onDateTimeChanged: (DateTime newDate) {
            setState(() {
              _selectedDate = newDate;
            });
          },
        ),
      ),
    );
  }

  // 3. Material DropdownButton
  Widget _buildMaterialDropdown() {
    return DropdownButton<String>(
      value: _selectedRole,
      isExpanded: true,
      items: _roles.map((String role) {
        return DropdownMenuItem<String>(value: role, child: Text(role));
      }).toList(),
      onChanged: (String? newValue) {
        if (newValue != null) {
          setState(() {
            _selectedRole = newValue;
          });
        }
      },
    );
  }

  // 4. Cupertino Picker (Wheel)
  void _showCupertinoRolePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (popupContext) => Container(
        height: 200,
        color: CupertinoColors.systemBackground.resolveFrom(popupContext),
        child: CupertinoPicker(
          itemExtent: 32,
          scrollController: FixedExtentScrollController(
            initialItem: _roles.indexOf(_selectedRole),
          ),
          onSelectedItemChanged: (int index) {
            setState(() {
              _selectedRole = _roles[index];
            });
          },
          children: _roles.map((role) {
            return Center(child: Text(role));
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Interactive Pickers (Lab 02)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const Divider(height: 24),

        // Display selected date
        Text(
          _selectedDate == null
              ? 'Selected Date: Not selected'
              : 'Selected Date: '
                    '${_selectedDate!.year}-'
                    '${_selectedDate!.month.toString().padLeft(2, '0')}-'
                    '${_selectedDate!.day.toString().padLeft(2, '0')}',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 4),

        // Display selected location
        Text(
          'Selected Location: $_selectedRole',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),

        const SizedBox(height: 16),

        // Material Date Picker
        OutlinedButton.icon(
          onPressed: () => _selectMaterialDate(context),
          icon: const Icon(Icons.calendar_month),
          label: const Text('Material Date Picker'),
        ),

        // Cupertino Date Picker
        OutlinedButton.icon(
          onPressed: () => _showCupertinoDatePicker(context),
          icon: const Icon(Icons.event),
          label: const Text('Cupertino Date Picker'),
        ),

        const SizedBox(height: 16),

        // Material Dropdown
        const Text(
          'Material Dropdown',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),

        _buildMaterialDropdown(),

        const SizedBox(height: 8),

        // Cupertino Wheel Picker
        OutlinedButton.icon(
          onPressed: () => _showCupertinoRolePicker(context),
          icon: const Icon(Icons.view_carousel),
          label: const Text('Cupertino Wheel Picker'),
        ),
      ],
    );
  }
}
