import 'package:evently_c16_sun/core/providers/app_config_provider.dart';
import 'package:evently_c16_sun/core/theme/app_colors.dart';
import 'package:evently_c16_sun/data/firebase/event_data_base.dart';
import 'package:evently_c16_sun/data/models/category.dart';
import 'package:evently_c16_sun/data/models/event.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../home/Select_Location_Screen/Select_location_screen.dart';


class EventManagementScreen extends StatefulWidget {
  static const String routeName = "/event-management";

  const EventManagementScreen({super.key});

  @override
  State<EventManagementScreen> createState() => _EventManagementScreenState();
}

class _EventManagementScreenState extends State<EventManagementScreen> {
  Category selectedCategory = Category.categories[0];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  late AppConfigProvider appConfigProvider;

  DateTime? selectedDate;
  TimeOfDay? currentTime;
  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    appConfigProvider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Create Event")),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(selectedCategory.imagePath),
            ),
            const SizedBox(height: 16),
            DefaultTabController(
              length: Category.categories.length,
              child: TabBar(
                dividerHeight: 0,
                tabAlignment: TabAlignment.start,
                indicator: const BoxDecoration(),
                labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                isScrollable: true,
                onTap: (index) {
                  selectedCategory = Category.categories[index];
                  setState(() {});
                },
                tabs: Category.categories
                    .map(
                      (e) =>
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCategory.id == e.id
                              ? Theme
                              .of(context)
                              .colorScheme
                              .primary
                              : Colors.transparent,
                          border: Border.all(
                            width: 2,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              e.iconData,
                              color: selectedCategory.id == e.id
                                  ? AppColors.offWhite
                                  : Theme
                                  .of(context)
                                  .colorScheme
                                  .primary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              appConfigProvider.isEn()
                                  ? e.nameEn
                                  : e.nameAr,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                color: selectedCategory.id == e.id
                                    ? AppColors.offWhite
                                    : Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                )
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Title"),
            const SizedBox(height: 8),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Event Title",
                prefixIcon: Icon(Icons.create),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Description"),
            const SizedBox(height: 8),
            TextFormField(
              controller: descriptionController,
              maxLines: 6,
              decoration:
              const InputDecoration(hintText: "Event Description"),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.date_range,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                ),
                const SizedBox(width: 8),
                const Text("Event Date"),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    DateTime? newSelectedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (newSelectedDate != null) {
                      selectedDate = newSelectedDate;
                      setState(() {});
                    }
                  },
                  child: Text(
                    selectedDate == null
                        ? "Choose Date"
                        : DateFormat("dd/MM/yyyy").format(selectedDate!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.alarm,
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                ),
                const SizedBox(width: 8),
                const Text("Event Time"),
                const Spacer(),
                TextButton(
                  onPressed: () async {
                    TimeOfDay? newSelectedTime = await showTimePicker(
                      context: context,
                      initialTime: currentTime ?? TimeOfDay.now(),
                    );
                    if (newSelectedTime != null) {
                      currentTime = newSelectedTime;
                      setState(() {});
                    }
                  },
                  child: Text(
                    currentTime == null
                        ? "Choose Time"
                        : currentTime!.format(context),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity, // الزر ياخد العرض بالكامل
              child: OutlinedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SelectLocationScreen(),
                    ),
                  );

                  if (result != null && result is LatLng) {
                    setState(() {
                      selectedLocation = result;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                        Text("Location selected successfully ✅"),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.location_on_outlined),
                label: Text(
                  selectedLocation == null
                      ? "Choose Event Location"
                      : "Lat: ${selectedLocation!.latitude.toStringAsFixed(
                      3)}, "
                      "Lng: ${selectedLocation!.longitude.toStringAsFixed(3)}",
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleMedium,
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .primary,
                    width: 1.8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate() &&
                    selectedDate != null &&
                    currentTime != null) {
                  try {
                    EventsDataBase.createEvent(
                      Event(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: selectedDate?.millisecondsSinceEpoch,
                        time: DateTime(
                          0,
                          0,
                          0,
                          currentTime!.hour,
                          currentTime!.minute,
                        ).millisecondsSinceEpoch,
                        categoryId: selectedCategory.id,
                        latitude: selectedLocation?.latitude,
                        longitude: selectedLocation?.longitude,
                      ),
                    );
                  } catch (e) {
                    print(e);
                  }
                }
              },
              child: const Text("Create Event"),
            ),
          ],
        ),
      ),
    );
  }
}