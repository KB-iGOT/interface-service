FROM node:17

# Create a non-root user
RUN useradd -m appuser

# Set working directory
WORKDIR /var/src/

# Give ownership of work directory to appuser
RUN chown -R appuser:appuser /var/src

# Switch to non-root user
USER appuser

# Copy package.json with correct ownership
COPY --chown=appuser:appuser ./src/package.json .

# Install node packages
RUN npm install --unsafe-perm

# Copy all application files
COPY --chown=appuser:appuser ./src .

# Expose application port
EXPOSE 3567

# Start the application
CMD ["node", "app.js"]
