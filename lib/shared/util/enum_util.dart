import 'package:todo_app/domain/enums/enums.dart';

SortTaskBy sortByFromString(String name) {
  switch (name) {
    case 'highestPriority':
      return SortTaskBy.highestPriority;
    case 'Highest Priority':
      return SortTaskBy.highestPriority;
    case 'leastPriority':
      return SortTaskBy.leastPriority;
    case 'Least Priority':
      return SortTaskBy.leastPriority;
    case 'mostRecentCreationDate':
      return SortTaskBy.mostRecentCreationDate;
    case 'Most Recent Creation Date':
      return SortTaskBy.mostRecentCreationDate;
    case 'leastRecentCreationDate':
      return SortTaskBy.leastRecentCreationDate;
    case 'Least Recent Creation Date':
      return SortTaskBy.leastRecentCreationDate;
    default:
      return SortTaskBy.highestPriority;
  }
}

String uiSortBy(String value) {
  switch (value) {
    case 'highestPriority':
      return 'Highest Priority';
    case 'leastPriority':
      return 'Least Priority';
    case 'mostRecentCreationDate':
      return 'Most Recent Creation Date';
    case 'leastRecentCreationDate':
      return 'Least Recent Creation Date';
    default:
      return 'Highest Priority';
  }
}

String intToPriority(int value) {
  switch (value) {
    case 5:
      return 'Critical';
    case 4:
      return 'High Priority';
    case 3:
      return 'Medium Priority';
    case 2:
      return 'Low Priority';
    case 1:
      return 'No Priority';
    default:
      return 'No Priority';
  }
}
