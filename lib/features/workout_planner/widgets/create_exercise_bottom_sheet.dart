import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/exercise.dart';
import '../../../core/utils/constants.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/media_picker_card.dart';

class CreateExerciseBottomSheet extends StatefulWidget {
  final Function(Exercise) onExerciseCreated;

  const CreateExerciseBottomSheet({super.key, required this.onExerciseCreated});

  @override
  State<CreateExerciseBottomSheet> createState() =>
      _CreateExerciseBottomSheetState();
}

class _CreateExerciseBottomSheetState extends State<CreateExerciseBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  String _selectedEquipment = AppConstants.equipmentDumbbell;
  File? _assetImage;
  File? _gifAssetImage;

  bool _isLoading = false;

  // List of available equipment types
  final List<String> _equipmentTypes = [
    AppConstants.equipmentBarbell,
    AppConstants.equipmentDumbbell,
    AppConstants.equipmentCable,
    AppConstants.equipmentBodyweight,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage({required bool isGif}) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          if (isGif) {
            _gifAssetImage = File(image.path);
          } else {
            _assetImage = File(image.path);
          }
        });
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => CupertinoTheme(
            data: const CupertinoThemeData(brightness: Brightness.light),
            child: CupertinoAlertDialog(
              title: const Text('Image Selection Failed'),
              content: Text('Failed to pick image: $e'),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
        );
      }
    }
  }

  String _formatEquipmentName(String equipment) {
    switch (equipment) {
      case AppConstants.equipmentBarbell:
        return 'Barbell';
      case AppConstants.equipmentDumbbell:
        return 'Dumbbell';
      case AppConstants.equipmentCable:
        return 'Cable';
      case AppConstants.equipmentBodyweight:
        return 'Bodyweight';
      default:
        return equipment.toUpperCase();
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_assetImage == null) {
      showDialog(
        context: context,
        builder: (context) => CupertinoTheme(
          data: const CupertinoThemeData(brightness: Brightness.light),
          child: CupertinoAlertDialog(
            title: const Text('Missing Exercise Image'),
            content: const Text('Please select an exercise image'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      );
      return;
    }

    if (_gifAssetImage == null) {
      showDialog(
        context: context,
        builder: (context) => CupertinoTheme(
          data: const CupertinoThemeData(brightness: Brightness.light),
          child: CupertinoAlertDialog(
            title: const Text('Missing GIF Image'),
            content: const Text('Please select a GIF image'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Create new exercise
    final exercise = Exercise(
      name: _nameController.text.trim(),
      assetUrl: _assetImage!.path,
      gifAssetUrl: _gifAssetImage!.path,
      equipment: _selectedEquipment,
    );

    widget.onExerciseCreated(exercise);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exercise created successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.85,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: AppConstants.spacingM),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(AppConstants.spacingXL),
            child: Row(
              children: [
                Text(
                  'Create Exercise',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),

          // Form content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.spacingXL,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Exercise name field
                    Text(
                      'Exercise Name',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingS),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter exercise name',
                        hintStyle: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: theme.colorScheme.surface,
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter an exercise name';
                        }
                        if (value.trim().length < 2) {
                          return 'Exercise name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: AppConstants.spacingXL),

                    // Equipment selection
                    Text(
                      'Equipment Type',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: AppConstants.spacingM),

                    // Equipment selection tabs
                    Wrap(
                      spacing: AppConstants.spacingM,
                      runSpacing: AppConstants.spacingM,
                      children: _equipmentTypes.map((equipment) {
                        final isSelected = _selectedEquipment == equipment;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedEquipment = equipment;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppConstants.spacingL,
                              vertical: AppConstants.spacingM,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? theme.colorScheme.surfaceContainer
                                  : theme.colorScheme.surface,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: isSelected
                                    ? theme.colorScheme.onPrimary
                                    : theme.colorScheme.onSurface.withValues(
                                        alpha: 0.3,
                                      ),
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  AppConstants.equipmentIcons[equipment]!,
                                  width: 20,
                                  height: 20,
                                  color: theme.colorScheme.onSurface,
                                ),
                                const SizedBox(width: AppConstants.spacingS),
                                Text(
                                  _formatEquipmentName(equipment),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: AppConstants.spacingXL),

                    // Exercise image
                    MediaPickerCard(
                      title: 'Exercise Image',
                      selectedFile: _assetImage,
                      mediaType: MediaType.image,
                      onTap: () => _pickImage(isGif: false),
                      onRemove: _assetImage != null
                          ? () {
                              setState(() {
                                _assetImage = null;
                              });
                            }
                          : null,
                    ),

                    const SizedBox(height: AppConstants.spacingXL),

                    // GIF image
                    MediaPickerCard(
                      title: 'Exercise GIF',
                      selectedFile: _gifAssetImage,
                      mediaType: MediaType.gif,
                      onTap: () => _pickImage(isGif: true),
                      onRemove: _gifAssetImage != null
                          ? () {
                              setState(() {
                                _gifAssetImage = null;
                              });
                            }
                          : null,
                    ),

                    const SizedBox(height: AppConstants.spacingXXL),
                  ],
                ),
              ),
            ),
          ),

          // Create button
          Container(
            padding: const EdgeInsets.all(AppConstants.spacingXL),
            child: AppButton.elevated(
              radius: 40,
              text: 'Create Exercise',
              onPressed: _submitForm,
              isLoading: _isLoading,
              isFullWidth: true,
            ),
          ),
        ],
      ),
    );
  }
}
