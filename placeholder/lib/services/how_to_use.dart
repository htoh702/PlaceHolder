// post
// User newUser = User(
//   firstName: firstNameController.text,
//   lastName: lastNameController.text,
//   email: emailController.text,
// );
//   userProvider.createUser(newUser);

// get
// userProvider.isLoading
//   ? CircularProgressIndicator()
//   : userProvider.hasError
//     ? Text('Error fetching user')
//     : userProvider.user == null
//       ? Text('No user data')
//       : Text('User: ${userProvider.user!.firstName} ${userProvider.user!.lastName}'),
// TextField(
//   controller: firstNameController,
//   decoration: InputDecoration(labelText: 'First Name'),
// ),
// TextField(
//   controller: lastNameController,
//   decoration: InputDecoration(labelText: 'Last Name'),
// ),
// TextField(
//   controller: emailController,
//   decoration: InputDecoration(labelText: 'Email'),
// ),