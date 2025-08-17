---
title: TDS Data Analyst Agent
emoji: 🤖
colorFrom: blue
colorTo: purple
sdk: docker
app_port: 7860
pinned: false
---

# TDS Data Analyst Agent - Hugging Face Spaces Deployment Guide

## Overview
This is a FastAPI-based AI data analyst that uses LangChain agents with Google Gemini LLM to analyze datasets and answer questions with visualizations.

## Features
- 🤖 AI-powered data analysis using LangChain agents
- 📊 Automatic visualization generation with matplotlib
- 🗄️ DuckDB integration for efficient data processing
- 📁 Support for multiple file formats (CSV, Excel, JSON, Parquet)
- 🌐 Web interface for easy interaction

## Deployment to Hugging Face Spaces

### Step 1: Prepare Your Files
Ensure you have these files in your project:
- `Dockerfile` (✅ Created)
- `.dockerignore` (✅ Created)
- `main.py` (✅ Your FastAPI application)
- `requirements.txt` (✅ Python dependencies)
- `index.html` (✅ Frontend interface)
- `question.txt` (✅ Sample questions)

### Step 2: Create Hugging Face Space

1. **Go to Hugging Face Spaces**: https://huggingface.co/spaces
2. **Click "Create new Space"**
3. **Configure your Space**:
   - **Space name**: `tds-data-analyst-agent` (or your preferred name)
   - **License**: Choose appropriate license (MIT recommended)
   - **Select SDK**: Choose **Docker**
   - **Hardware**: CPU Basic (free tier) or upgrade if needed
   - **Visibility**: Public or Private (your choice)

### Step 3: Environment Variables Setup

In your Hugging Face Space settings, add these environment variables:

**Required:**
```
GOOGLE_API_KEY=your_google_gemini_api_key_here
PORT=7860
```

**Optional (for enhanced functionality):**
```
LANGCHAIN_TRACING_V2=true
LANGCHAIN_API_KEY=your_langchain_api_key_here
AWS_ACCESS_KEY_ID=your_aws_access_key
AWS_SECRET_ACCESS_KEY=your_aws_secret_key
```

### Step 4: Upload Files

You can upload files in two ways:

**Option A: Upload via Web Interface**
1. Go to your Space's "Files" tab
2. Upload all project files one by one

**Option B: Git Clone and Push** (Recommended)
```bash
# Clone your space repository
git clone https://huggingface.co/spaces/YOUR_USERNAME/YOUR_SPACE_NAME
cd YOUR_SPACE_NAME

# Copy all files from your project
cp /home/dpc/projects/tds2/* .

# Add and commit files
git add .
git commit -m "Initial deployment of TDS Data Analyst Agent"
git push
```

### Step 5: Dockerfile Configuration (Already Created)

Your Dockerfile is configured with:
- Python 3.11-slim base image
- System dependencies for data science libraries
- DuckDB directory setup
- Health check endpoint
- Port 7860 (Hugging Face standard)
- Non-root user for security

### Step 6: Monitor Deployment

1. **Check Build Logs**: Go to your Space and monitor the build process
2. **Wait for Deployment**: First build may take 5-10 minutes
3. **Test Your App**: Once deployed, test the interface

## Usage

### Web Interface
1. Upload a `.txt` file with your questions
2. Optionally upload a dataset (CSV, Excel, etc.)
3. Click "Analyze Data"
4. View results with visualizations

### API Endpoints
- `GET /`: Web interface
- `POST /api`: Data analysis endpoint
- `GET /health`: Health check

### Sample Questions Format
```
What is the distribution of cases by court?
Show me a trend analysis of case disposal over time.
Create a visualization showing the relationship between case type and disposal time.
```

## Environment Variables Details

### GOOGLE_API_KEY (Required)
- Get from: https://makersuite.google.com/app/apikey
- Used for: Google Gemini LLM integration

### LANGCHAIN_API_KEY (Optional)
- Get from: https://smith.langchain.com/
- Used for: LangChain tracing and monitoring

### AWS Keys (Optional)
- Get from: AWS Console
- Used for: S3 data access via DuckDB

## Troubleshooting

### Common Issues

1. **Build Fails with Memory Error**
   - Upgrade to CPU Basic (paid) or GPU hardware
   - Reduce dependencies in requirements.txt

2. **App Doesn't Start**
   - Check environment variables are set correctly
   - Verify GOOGLE_API_KEY is valid

3. **Import Errors**
   - Ensure all dependencies in requirements.txt
   - Check Python version compatibility

4. **API Timeouts**
   - Increase timeout limits in main.py
   - Consider upgrading hardware

### Performance Tips

1. **For Large Datasets**: Use DuckDB with S3 URLs instead of file uploads
2. **For High Traffic**: Upgrade to GPU hardware
3. **For Faster Responses**: Cache common queries

## Local Development

To test locally before deployment:

```bash
# Install dependencies
pip install -r requirements.txt

# Set environment variables
export GOOGLE_API_KEY=your_key_here

# Run the application
python main.py
```

Visit http://localhost:8001 to test locally.

## Support

If you encounter issues:
1. Check Hugging Face Spaces documentation
2. Review build logs in your Space
3. Test locally first
4. Ensure all environment variables are set correctly

Happy analyzing! 🚀📊
