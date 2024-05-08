import 'package:luthor/luthor.dart';

class FormValidator {
  static String? validateTitle(String? title) {
    SingleValidationResult<String> validResult;

    if (title != null) {
      validResult =
          l.string().min(1, message: 'Title is required.').validateValue(title);
    } else {
      return null;
    }

    return validResult.maybeWhen(
      error: (errors) => errors[0],
      orElse: () => null,
    );
  }

  static String? validateDescription(String? value) {
    SingleValidationResult<String> validResult;

    if (value != null) {
      validResult = l
          .string()
          .min(1, message: 'Description is required.')
          .validateValue(value);
    } else {
      return null;
    }

    return validResult.maybeWhen(
      error: (errors) => errors[0],
      orElse: () => null,
    );
  }

  static String? validatePinned(String? value) {
    SingleValidationResult<String> validResult;

    if (value != null) {
      validResult = l
          .string()
          .min(1, message: 'Pinned status is required.')
          .validateValue(value);
    } else {
      return null;
    }

    return validResult.maybeWhen(
      error: (errors) => errors[0],
      orElse: () => null,
    );
  }

  static String? validateCategory(String? value) {
    SingleValidationResult<String> validResult;

    if (value != null) {
      validResult = l
          .string()
          .min(1, message: 'Category is required.')
          .validateValue(value);
    } else {
      return null;
    }

    return validResult.maybeWhen(
      error: (errors) => errors[0],
      orElse: () => null,
    );
  }

  static String? validateStatus(String? value) {
    SingleValidationResult<String> validResult;

    if (value != null) {
      validResult = l
          .string()
          .min(1, message: 'Status is required.')
          .validateValue(value);
    } else {
      return null;
    }

    return validResult.maybeWhen(
      error: (errors) => errors[0],
      orElse: () => null,
    );
  }

  static String? validatePriority(String? value) {
    SingleValidationResult<String> validResult;

    if (value != null) {
      validResult = l
          .string()
          .min(1, message: 'Priority is required.')
          .validateValue(value);
    } else {
      return null;
    }

    return validResult.maybeWhen(
      error: (errors) => errors[0],
      orElse: () => null,
    );
  }

  static bool isEditTaskFormValid({
    required String? title,
    required String? description,
    required String? pinned,
    required String? category,
    required String? status,
    required String? priority,
  }) {
    final titleErr = validateTitle(title);
    if (titleErr != null) {
      return false;
    }

    final desErr = validateDescription(description);
    if (desErr != null) {
      return false;
    }

    final pinnedErr = validatePinned(pinned);
    if (pinnedErr != null) {
      return false;
    }

    final categoryErr = validateCategory(category);
    if (categoryErr != null) {
      return false;
    }

    final statusErr = validateStatus(status);
    if (statusErr != null) {
      return false;
    }

    final priorityErr = validatePriority(priority);
    if (priorityErr != null) {
      return false;
    }

    return true;
  }

  static bool isAddTaskFormValid({
    required String? title,
    required String? description,
    required String? pinned,
    required String? category,
    required String? priority,
  }) {
    final titleErr = validateTitle(title);
    if (titleErr != null) {
      return false;
    }

    final desErr = validateDescription(description);
    if (desErr != null) {
      return false;
    }

    final pinnedErr = validatePinned(pinned);
    if (pinnedErr != null) {
      return false;
    }

    final categoryErr = validateCategory(category);
    if (categoryErr != null) {
      return false;
    }

    final priorityErr = validatePriority(priority);
    if (priorityErr != null) {
      return false;
    }

    return true;
  }
}
