## Canteen Database Management system and automation

The __Canteen Database Management__ system and automation is a SQL-based project that simplifies and organizes the management of canteen operations. This system allows canteen staff to track and manage food items, orders, customers, payments and food rating. The database ensures smooth transactions and an organized inventory, providing real-time insights into day-to-day operations.

<h2>Overview:</h2>
This project is designed as a back-end solution for canteen management, focusing on creating a robust and scalable database using SQL for efficient data storage, retrieval, and management.


### Features
`Food Menu Management:` Add, update, or remove food items with details like name, category, price, and availability.

`Order Tracking:` Manage and track customer orders, including order status (e.g., pending, completed, or cancelled).

`Customer Management:` Store customer details to track regular customers and streamline the ordering process.

`Inventory Management:` Keep track of the canteen's stock levels and notify when items need to be reordered.

`Payment and Billing:` Process payments and generate billing information for each order.

`Reports Generation:` Generate reports on sales, daily orders, and inventory usage.


### Project Structure
The database is structured into several main tables, including:

`Customers:` Stores customer information (ID, name, contact, etc.)

`Food_Items:` Contains details of the food items offered (ID, name, category, price, stock).

`Food_rating:` Contains ratings from customers (name, foodrating, foodname)

`Orders:` Logs all customer orders (ID, customer ID, order date, total price).

`Order_Details:` Contains information about each item in a customer’s order (order ID, food item ID, quantity, subtotal).

`Payments:` Handles payment transactions for orders (ID, order ID, amount, payment date, payment method).
