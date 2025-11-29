# BusGO
Bus Search Results App (React/JSX)

This is a single-file React application designed to simulate a modern, responsive bus search results screen. It displays a list of available bus services with key details like departure/arrival times, pricing, seating availability, and service type.

The entire application is contained within the BusSearchResultsApp.jsx file, utilizing React functional components and Tailwind CSS for rapid and aesthetic styling.

✨ Features

Responsive Design: Optimized for display on both mobile and desktop screens using Tailwind CSS utilities.

Bus Card Component: A dedicated component (BusResultCard) for clear, structured display of each individual bus service.

Real-time Details: Displays essential travel information:

Bus Name and Service Type (e.g., 'AC Seater', 'Luxury Sleeper').

Departure and Arrival Times.

Route information (NYC to Boston).

Price and Available Seats (with visual emphasis for low availability).

Dummy Data: Uses a pre-defined JavaScript array (busResults) to simulate fetching data from an API.

💻 Technical Stack

Technology

Purpose

React (JSX)

Core UI Library, used for component structure and state logic.

Tailwind CSS

Utility-first CSS framework for styling and responsiveness.

Lucide React

Used for clean, modern iconography (Bus, Clock, Dollar Sign, Users).

📁 File Structure

The application is entirely self-contained in one file as required by the environment:

BusSearchResultsApp.jsx: Contains the data model, the reusable BusResultCard component, and the main App component that renders the list of results.

🚀 Usage

Since this is a single, self-contained JSX file:

Setup: Ensure you have a working React environment configured to handle JSX and Tailwind CSS (which is usually provided in the Canvas environment).

Data: The bus data is currently hardcoded in the busResults array. In a real-world application, this array would be populated by an asynchronous API call (e.g., using fetch or axios within a useEffect hook).

Customization: The styling is handled purely by Tailwind utility classes. Modify the classes within the JSX to change the appearance.
