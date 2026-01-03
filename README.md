
# Omkar Shakti Kendra - Backend API

## Overview
Complete PHP-MySQL backend API for the astrology website with admin panel functionality.

## Setup Instructions

### 1. Database Setup
1. Create a MySQL database named `astrology_db`
2. Import the schema from `database.sql`
3. Update database credentials in `config.php`

### 2. Configuration
1. Update `config.php` with your database credentials
2. Change the JWT secret key for production
3. Configure email settings in `mailer.php`

### 3. File Permissions
Ensure proper permissions for file uploads:
```bash
chmod 755 api/
chmod 644 api/*.php
```

### 4. Admin Access
Default admin credentials:
- Email: admin@omkarshaktikendra.com
- Password: admin123

**Important: Change the admin password after first login!**

## API Endpoints

### Public APIs

#### Services
- `GET /services/list.php` - List all active services
- `GET /services/details.php?slug={slug}` - Get service details
- `GET /services/benefits.php?slug={slug}` - Get service benefits

#### Appointments
- `POST /appointments/book.php` - Book an appointment
- `GET /appointments/available.php?date={date}` - Get available slots

#### Contact
- `POST /contact/submit.php` - Submit contact form

#### Blogs
- `GET /blogs/list.php` - List published blogs
- `GET /blogs/details.php?slug={slug}` - Get blog details with comments

### Admin APIs (Require Authorization Header)

#### Authentication
- `POST /admin/login.php` - Admin login

#### Dashboard
- `GET /admin/dashboard.php` - Get dashboard statistics

## Request/Response Format

### Authentication
Admin APIs require Authorization header:
```
Authorization: Bearer {token}
```

### Request Format
```json
{
  "field1": "value1",
  "field2": "value2"
}
```

### Response Format
```json
{
  "success": true,
  "data": {},
  "message": "Success message"
}
```

### Error Format
```json
{
  "error": "Error message"
}
```

## Deployment

### cPanel Deployment
1. Create subdomain `api.yourdomain.com`
2. Upload all files to the subdomain's document root
3. Import database schema
4. Update configuration files

### Security Notes
- Change default admin password
- Update JWT secret key
- Use HTTPS in production
- Regular database backups
- Monitor error logs

## File Structure
```
api/
├── config.php              # Database config & utilities
├── auth.php                # Authentication functions
├── mailer.php              # Email functionality
├── database.sql            # Database schema
├── README.md               # This file
├── services/               # Service-related APIs
├── appointments/           # Appointment booking APIs
├── contact/               # Contact form API
├── blogs/                 # Blog APIs
└── admin/                 # Admin panel APIs
```

## Support
For technical support, contact: admin@omkarshaktikendra.com
