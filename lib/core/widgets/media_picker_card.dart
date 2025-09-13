import 'package:flutter/material.dart';
import 'dart:io';

enum MediaType { image, gif }

class MediaPickerCard extends StatelessWidget {
  final String title;
  final File? selectedFile;
  final VoidCallback onTap;
  final VoidCallback? onRemove;
  final MediaType mediaType;
  final double height;

  const MediaPickerCard({
    super.key,
    required this.title,
    required this.selectedFile,
    required this.onTap,
    this.onRemove,
    this.mediaType = MediaType.image,
    this.height = 140,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: height,
            width: double.infinity,
            decoration: BoxDecoration(
              color: selectedFile != null ? null : theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selectedFile != null
                    ? theme.colorScheme.primary.withValues(alpha: 0.4)
                    : theme.colorScheme.outline.withValues(alpha: 0.3),
                width: selectedFile != null ? 2 : 1,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: selectedFile != null
                  ? _buildSelectedImage(theme)
                  : _buildPlaceholder(theme),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedImage(ThemeData theme) {
    return Stack(
      children: [
        Image.file(
          selectedFile!,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        if (onRemove != null)
          Positioned(
            top: 8,
            right: 8,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.error,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: theme.colorScheme.onError,
                  size: 16,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder(ThemeData theme) {
    final icon = mediaType == MediaType.image
        ? Icons.add_photo_alternate_outlined
        : Icons.gif_box_outlined;
    final text = mediaType == MediaType.image
        ? 'Tap to select image'
        : 'Tap to select GIF';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 40,
          color: theme.colorScheme.primary.withValues(alpha: 0.7),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}
