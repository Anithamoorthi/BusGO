import 'package:flutter/material.dart';
void main() {
  runApp(const BusTicketBookingApp());
}

class Bus {
  final String name;
  final String route;
  final String departureTime;
  final String arrivalTime;
  final double price;
  final int availableSeats;
  final String busType; 

  Bus({
    required this.name,
    required this.route,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    required this.availableSeats,
    required this.busType,
  });
}

class BusTicketBookingApp extends StatelessWidget {
  const BusTicketBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BusGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: const Color(0xFF5E35B1), // Deep Purple
        scaffoldBackgroundColor: const Color(0xFFF7F7F7), // Light Gray background
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF5E35B1),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black54),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/search': (context) => const BusSearchResultsScreen(),
      },
    );
  }
}


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BusGo', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 30),
            onPressed: () {
              
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
         
            SearchCard(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Explore Top Routes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF5E35B1)),
              ),
            ),
            
            FeaturedRoutesSection(),
            const SizedBox(height: 20),
            
            PromoBanner(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Tickets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}

class BusSearchResultsScreen extends StatelessWidget {
  const BusSearchResultsScreen({super.key});

  final List<Bus> busResults = const [
  
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buses from NYC to Boston'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FilterButton(icon: Icons.sort, label: 'Sort'),
                FilterButton(icon: Icons.filter_list, label: 'Filter'),
                FilterButton(icon: Icons.chair_alt, label: 'Seat Type'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: busResults.length,
              itemBuilder: (context, index) {
                final bus = busResults[index];
                return BusCard(bus: bus);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TicketDetailsScreen extends StatelessWidget {
  final Bus bus;

  const TicketDetailsScreen({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Seat'),
        backgroundColor: const Color(0xFF673AB7),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       
            BusSummaryCard(bus: bus),
            const SizedBox(height: 20),

            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text('Select Your Seat', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
             
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'https://placehold.co/300x150/80DEEA/FFFFFF?text=Seat+Layout',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 150,
                          width: 300,
                          color: Colors.blue.shade100,
                          child: const Center(child: Text('Seat Map Placeholder')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      title: const Text("Booking Confirmed!"),
                      content: Text("You have successfully booked a seat on the ${bus.name} bus."),
                      actions: <Widget>[
                        TextButton(
                          child: const Text("Awesome!"),
                          onPressed: () {
                          
                            Navigator.popUntil(context, ModalRoute.withName('/'));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF5722), 
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 5,
              ),
              child: Text(
                'Pay \$${bus.price.toStringAsFixed(2)} & Book',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}



class SearchCard extends StatelessWidget {
  SearchCard({super.key});

  final TextEditingController _fromController = TextEditingController(text: 'New York City (NYC)');
  final TextEditingController _toController = TextEditingController(text: 'Boston (BOS)');
  final TextEditingController _dateController = TextEditingController(text: 'Today, 25 Nov');

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
        
          _buildLocationInput(context, 'From', 'NYC', _fromController, Icons.location_on),
       
          Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            child: Transform.rotate(
              angle: 1.5708, 
              child: IconButton(
                icon: const Icon(Icons.swap_horiz, color: Color(0xFFFF5722), size: 30),
                onPressed: () {
                 
                  String temp = _fromController.text;
                  _fromController.text = _toController.text;
                  _toController.text = temp;
                },
              ),
            ),
          ),
         
          _buildLocationInput(context, 'To', 'BOS', _toController, Icons.location_on),
          const Divider(height: 30),
         
          _buildDateInput(context, _dateController),
          const SizedBox(height: 20),
          
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/search');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF5E35B1), // Deep Purple
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 8,
              shadowColor: const Color(0xFF5E35B1).withOpacity(0.5),
            ),
            child: const Text(
              'Search Buses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInput(BuildContext context, String label, String hint, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
        contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
      readOnly: true, 
      onTap: () {
        
      },
    );
  }

  Widget _buildDateInput(BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Travel Date',
        prefixIcon: const Icon(Icons.calendar_today, color: Color(0xFF00ACC1)), 
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: const Color(0xFFF7F7F7),
      ),
      readOnly: true,
      onTap: () async {
      
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2028),
        );
        if (picked != null) {
          controller.text = picked.toString().split(' ')[0];
        }
      },
    );
  }
}

class FeaturedRoutesSection extends StatelessWidget {
   final List<Map<String, String>> routes = const [
    {'city': 'London', 'cost': '\$29', 'image': 'https://placehold.co/120x80/64B5F6/FFFFFF?text=LDN'},
    {'city': 'Paris', 'cost': '\$35', 'image': 'https://placehold.co/120x80/EF5350/FFFFFF?text=PRS'},
    {'city': 'Berlin', 'cost': '\$42', 'image': 'https://placehold.co/120x80/8BC34A/FFFFFF?text=BRL'},
  ];

  FeaturedRoutesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    route['image']!,
                    width: 150,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 150,
                      height: 80,
                      color: Colors.grey.shade300,
                      child: Center(child: Text(route['city']!)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(route['city']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('Starting from ${route['cost']!}', style: const TextStyle(color: Color(0xFF00ACC1), fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PromoBanner extends StatelessWidget {
  PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF00ACC1), // Cyan accent color
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [const Color(0xFF00ACC1), const Color(0xFF4DB6AC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00ACC1).withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.local_activity, color: Colors.white, size: 40),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Flat 15% OFF!',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Use code TRAVELNOW on your first booking.',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const FilterButton({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
       
      },
      icon: Icon(icon, color: Theme.of(context).primaryColor, size: 20),
      label: Text(
        label,
        style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
      ),
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5)),
        ),
      ),
    );
  }
}

class BusCard extends StatelessWidget {
  final Bus bus;

  const BusCard({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TicketDetailsScreen(bus: bus),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bus.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: bus.busType.contains('Sleeper') ? const Color(0xFFFF5722) : const Color(0xFF00ACC1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    bus.busType,
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
         
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeColumn(context, bus.departureTime, 'Departure'),
                Column(
                  children: [
                    const Icon(Icons.arrow_right_alt, color: Colors.grey, size: 30),
                    Text(
                      '${_calculateDuration(bus.departureTime, bus.arrivalTime)} hrs',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                _buildTimeColumn(context, bus.arrivalTime, 'Arrival', Alignment.centerRight),
              ],
            ),
            const SizedBox(height: 15),
         
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.chair_alt, size: 18, color: Colors.green),
                    const SizedBox(width: 5),
                    Text('${bus.availableSeats} Seats Left', style: const TextStyle(fontSize: 14, color: Colors.green)),
                  ],
                ),
                Text(
                  '\$${bus.price.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Color(0xFFFF5722)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeColumn(BuildContext context, String time, String label, [AlignmentGeometry alignment = Alignment.centerLeft]) {
    return Align(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: alignment == Alignment.centerLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

 
  String _calculateDuration(String depTime, String arrTime) {
   
    double parseTime(String time) {
      final parts = time.split(' ');
      final timeParts = parts[0].split(':').map(double.parse).toList();
      double hours = timeParts[0];
      final minutes = timeParts[1];

      if (parts[1] == 'PM' && hours < 12) {
        hours += 12;
      } else if (parts[1] == 'AM' && hours == 12) {
        hours = 0; 
      }
      return hours + minutes / 60.0;
    }

    double dep = parseTime(depTime);
    double arr = parseTime(arrTime);

    if (arr < dep) {
      arr += 24.0; 
    }

    double duration = arr - dep;
    return duration.toStringAsFixed(1);
  }
}

class BusSummaryCard extends StatelessWidget {
  final Bus bus;

  const BusSummaryCard({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.directions_bus, color: Colors.white, size: 30),
              const SizedBox(width: 10),
              Text(
                bus.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white54, height: 20),
          _buildInfoRow('Route', bus.route, Icons.alt_route),
          _buildInfoRow('Departs', bus.departureTime, Icons.access_time),
          _buildInfoRow('Arrives', bus.arrivalTime, Icons.schedule),
          _buildInfoRow('Type', bus.busType, Icons.local_activity),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 18),
          const SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: Text(
              '$title:',
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
