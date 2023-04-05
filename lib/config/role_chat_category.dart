// ignore_for_file: constant_identifier_names

enum RoleChatCategory {
  Art,
  Business,
  Cooking,
  Entertainment,
  Fashion,
  History,
  Law,
  Literature,
  Medical,
  Music,
  Politics,
  Religion,
  Science,
  Sports,
  Technology,
}

String getRoleChatCategory(RoleChatCategory category) {
  switch (category) {
    case RoleChatCategory.Art:
      return 'Art';
    case RoleChatCategory.Business:
      return 'Business';
    case RoleChatCategory.Cooking:
      return 'Cooking';
    case RoleChatCategory.Entertainment:
      return 'Entertainment';
    case RoleChatCategory.Fashion:
      return 'Fashion';
    case RoleChatCategory.History:
      return 'History';
    case RoleChatCategory.Law:
      return 'Law';
    case RoleChatCategory.Literature:
      return 'Literature';
    case RoleChatCategory.Medical:
      return 'Medical';
    case RoleChatCategory.Music:
      return 'Music';
    case RoleChatCategory.Politics:
      return 'Politics';
    case RoleChatCategory.Religion:
      return 'Religion';
    case RoleChatCategory.Science:
      return 'Science';
    case RoleChatCategory.Sports:
      return 'Sports';
    case RoleChatCategory.Technology:
      return 'Technology';
    default:
      return '';
  }
}

String getRoleChatCategoryImage(RoleChatCategory category) {
  switch (category) {
    case RoleChatCategory.Art:
      return 'Art';
    case RoleChatCategory.Business:
      return 'Business';
    case RoleChatCategory.Cooking:
      return 'Cooking';
    case RoleChatCategory.Entertainment:
      return 'Entertainment';
    case RoleChatCategory.Fashion:
      return 'Fashion';
    case RoleChatCategory.History:
      return 'History';
    case RoleChatCategory.Law:
      return 'Law';
    case RoleChatCategory.Literature:
      return 'Literature';
    case RoleChatCategory.Medical:
      return 'Medical';
    case RoleChatCategory.Music:
      return 'Music';
    case RoleChatCategory.Politics:
      return 'Politics';
    case RoleChatCategory.Religion:
      return 'Religion';
    case RoleChatCategory.Science:
      return 'Science';
    case RoleChatCategory.Sports:
      return 'Sports';
    case RoleChatCategory.Technology:
      return 'Technology';
    default:
      return '';
  }
}
