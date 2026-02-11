FROM rust:1.77-slim

# Install ALSA development libraries and other dependencies
RUN apt-get update && apt-get install -y \
    libasound2-dev \
    pkg-config \
    libwebkit2gtk-4.0-dev \
    libssl-dev \
    libgtk-3-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy the entire project
COPY . .

# Build the meetily package
RUN cargo build --release --package meetily

# Set the entrypoint
CMD ["./target/release/meetily"]
