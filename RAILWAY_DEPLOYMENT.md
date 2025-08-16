# CompreFace Railway Deployment Guide

This repository has been configured for deployment on Railway. Follow these steps to deploy CompreFace on Railway.

## Prerequisites

1. A Railway account (https://railway.app)
2. A GitHub account with this repository

## Deployment Steps

### 1. Deploy to Railway

1. Go to [Railway](https://railway.app)
2. Click "Start a New Project"
3. Select "Deploy from GitHub repo"
4. Choose this repository
5. Railway will automatically detect the `railway.json` configuration

### 2. Add PostgreSQL Database

1. In your Railway project dashboard, click "Add Service"
2. Select "Database" → "PostgreSQL" 
3. Railway will automatically provision a PostgreSQL database

### 3. Configure Environment Variables

The following environment variables will be automatically set by Railway's PostgreSQL service:
- `PGHOST` - Database host
- `PGPORT` - Database port (usually 5432)
- `PGDATABASE` - Database name
- `PGUSER` - Database username  
- `PGPASSWORD` - Database password

Optional environment variables you can set:
- `EMAIL_USERNAME` - SMTP email username
- `EMAIL_FROM` - Email from address
- `EMAIL_PASSWORD` - SMTP email password
- `ENABLE_EMAIL_SERVER` - Enable email notifications (true/false)
- `MAX_FILE_SIZE` - Maximum file upload size (default: 5MB)
- `MAX_REQUEST_SIZE` - Maximum request size (default: 10M)
- `COMPREFACE_API_JAVA_OPTIONS` - Java options for API service (default: -Xmx4g)
- `COMPREFACE_ADMIN_JAVA_OPTIONS` - Java options for admin service (default: -Xmx1g)

### 4. Deploy

1. Railway will automatically start building and deploying your application
2. The build process may take 5-10 minutes as it needs to pull and start multiple Docker containers
3. Once deployed, Railway will provide you with a public URL

### 5. Access CompreFace

1. Once deployment is complete, click on the provided Railway URL
2. You should see the CompreFace login page
3. Default admin credentials will be shown in the application logs

## Important Notes

- **Memory Requirements**: CompreFace requires significant memory. Make sure your Railway plan has sufficient resources (recommended: at least 4GB RAM)
- **Startup Time**: Initial startup may take several minutes as Docker containers are pulled and started
- **Persistence**: Data is stored in the Railway PostgreSQL database and will persist across deployments
- **Scaling**: This setup runs all services in a single container. For production use, consider splitting services

## Troubleshooting

### Build Issues
- Check the build logs in Railway dashboard
- Ensure your Railway plan has sufficient memory allocation

### Connection Issues  
- Verify that the PostgreSQL service is running
- Check that environment variables are properly set
- Review application logs for database connection errors

### Performance Issues
- Monitor memory usage in Railway dashboard
- Consider upgrading your Railway plan for better performance
- Adjust Java heap sizes via environment variables

## Support

For CompreFace-specific issues, visit the [official repository](https://github.com/exadel-inc/CompreFace).
For Railway deployment issues, check the [Railway documentation](https://docs.railway.app).