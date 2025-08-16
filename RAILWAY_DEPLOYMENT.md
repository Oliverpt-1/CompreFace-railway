# CompreFace Railway Deployment Guide

This repository has been configured for deployment on Railway using a single-container approach that includes all CompreFace services.

## Prerequisites

1. A Railway account (https://railway.app)
2. A GitHub account with this repository

## Deployment Steps

### 1. Deploy to Railway

1. Go to [Railway](https://railway.app)
2. Click "Start a New Project"
3. Select "Deploy from GitHub repo"
4. Choose this repository
5. Railway will automatically detect the `railway.json` configuration and build using the custom Dockerfile

### 2. Configure Environment Variables (Optional)

The application includes an embedded PostgreSQL database, but you can customize these environment variables:

**Email Configuration:**
- `EMAIL_USERNAME` - SMTP email username
- `EMAIL_FROM` - Email from address
- `EMAIL_PASSWORD` - SMTP email password
- `ENABLE_EMAIL_SERVER` - Enable email notifications (true/false)

**Performance Tuning:**
- `MAX_FILE_SIZE` - Maximum file upload size (default: 5MB)
- `MAX_REQUEST_SIZE` - Maximum request size (default: 10MB)
- `COMPREFACE_API_JAVA_OPTIONS` - Java options for API service (default: -Xmx4g)
- `COMPREFACE_ADMIN_JAVA_OPTIONS` - Java options for admin service (default: -Xmx1g)
- `UWSGI_PROCESSES` - Number of UWSGI processes (default: 2)
- `UWSGI_THREADS` - Number of UWSGI threads (default: 1)

**Database Configuration (if using external database):**
- `PGHOST` - Database host
- `PGPORT` - Database port
- `PGDATABASE` - Database name
- `PGUSER` - Database username  
- `PGPASSWORD` - Database password

### 3. Deploy

1. Railway will automatically start building your application
2. The build process takes 10-15 minutes as it needs to:
   - Pull all CompreFace service images
   - Set up PostgreSQL database
   - Configure and start all services
3. Once deployed, Railway will provide you with a public URL

### 4. Access CompreFace

1. Once deployment is complete (you'll see "Running" status), click on the provided Railway URL
2. You should see the CompreFace login page
3. Create an admin account on first visit

## Architecture

This deployment uses a single Docker container that includes:
- **CompreFace Core** - Face recognition ML service
- **CompreFace API** - REST API backend
- **CompreFace Admin** - Admin backend service
- **CompreFace UI** - Web frontend (Nginx)
- **PostgreSQL** - Embedded database
- **Supervisor** - Process manager for all services

## Important Notes

- **Memory Requirements**: Requires at least 6GB RAM for optimal performance
- **Startup Time**: Initial startup takes 2-3 minutes for all services to initialize
- **Data Persistence**: Data persists in the container's database
- **Single Container**: All services run in one container for simplicity

## Troubleshooting

### Build Issues
- Check build logs in Railway dashboard
- Ensure Railway plan has sufficient memory (6GB+ recommended)
- Build timeout can occur - retry if needed

### Runtime Issues
- Check application logs for service startup errors
- Verify all services are running via supervisor logs
- Allow 2-3 minutes for full startup

### Memory Issues
- Monitor memory usage in Railway dashboard
- Reduce Java heap sizes if needed:
  - Set `COMPREFACE_API_JAVA_OPTIONS=-Xmx2g`
  - Set `COMPREFACE_ADMIN_JAVA_OPTIONS=-Xmx512m`

### Performance Optimization
- Increase memory allocation in Railway
- Adjust `UWSGI_PROCESSES` and `UWSGI_THREADS` based on workload
- Monitor CPU and memory metrics

## Support

For CompreFace-specific issues, visit the [official repository](https://github.com/exadel-inc/CompreFace).
For Railway deployment issues, check the [Railway documentation](https://docs.railway.app).