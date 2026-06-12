class Employee {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String department;
  final String location;
  final String birthday;

  Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.department,
    required this.location,
    required this.birthday,
  });
}

final List<Employee> employeeList = [
  Employee(
  id: 'EMP001',
  name: 'admin',
  email: 'admin@gmail.com',
  mobile: '9876543214',
  department: 'admin',
  location: 'Chennai',
  birthday: '01-01-2026',
),
  
  Employee(
    id: 'EMP002',
    name: 'harry potter',
    email: 'harry@gmail.com',
    mobile: '9876543211',
    department: 'UI/UX Design',
    location: 'Chennai',
    birthday: '12-06-2026',
  ),
  Employee(
    id: 'EMP003',
    name: 'jack sparrow',
    email: 'jack@gmail.com',
    mobile: '9876543212',
    department: 'Backend Development',
    location: 'Bangalore',
    birthday: '22-08-2026',
  ),
  Employee(
    id: 'EMP004',
    name: 'Pavithra',
    email: 'pavithra@gmail.com',
    mobile: '9876543213',
    department: 'QA Testing',
    location: 'Hyderabad',
    birthday: '01-09-2026',
  ),
  Employee(
    id: 'EMP005',
    name: 'deanerys',
    email: 'dene@gmail.com',
    mobile: '9876543210',
    department: 'Flutter Development',
    location: 'Coimbatore',
    birthday: '13-06-2026',
  ),
];