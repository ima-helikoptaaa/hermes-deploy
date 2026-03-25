-- Create separate databases for each service
CREATE DATABASE exodus;
CREATE DATABASE muse;
CREATE DATABASE progression;
CREATE DATABASE sisyphus;
CREATE DATABASE honcho;

-- Enable pgvector extension for Honcho
\c honcho;
CREATE EXTENSION IF NOT EXISTS vector;
