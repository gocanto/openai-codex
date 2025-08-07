# openai-codex

A Dockerised environment and Makefile for interacting with the OpenAI Codex (via the OpenAI CLI) inside a container. 
This setup isolates your local development environment from the Node.js and OpenAI CLI dependencies.

## Features

- **Dockerfile**: Defines a Node.js container with the OpenAI CLI installed.
- **docker-compose.yml**: Runs the service with environment variables loaded from a given `.env` file.
- **Makefile**: Provides shortcuts for building, running, and interacting with Codex via Docker:
    - Build and manage containers.
    - Shell access.
    - Dependency install & update.
    - Codex completions and edits.
- **.env.example**: Template for environment variables.

## Prerequisites

- [Docker](https://www.docker.com/) (v20+)
- Docker Compose plugin (use `docker compose`)
- An [OpenAI API key](https://platform.openai.com/account/api-keys)

## Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/gocanto/openai-codex.git
   cd openai-codex
   ```
2. **Copy and configure `.env`**
   ```bash
   cp .env.example .env
   ```
    - `OPENAI_API_KEY`: Your OpenAI secret key
    - `NPM_TOKEN`: (Optional) Your npm access token for private packages

## Usage

### Build & run containers

```bash
make build   # Build the Docker image
make up      # Start containers in detached mode
```

### Common Makefile commands

- `make help`   : See all the available commands
- `make build`  : Build the Docker image
- `make up`     : Start containers in detached mode
- `make logs`   : View container logs
- `make shell`  : Open an interactive shell in the container
- `make install`: Install npm dependencies (`npm ci`) inside container
- `make update` : Update npm dependencies (`npm update`) inside container
- `make start`  : Run your application (`npm start`)
- `make down`   : Stop and remove containers

### Generate code with Codex

- **Complete from prompt**
  ```bash
  make codex-complete prompt="<Describe your coding task>"
  ```

- **Edit existing file**
  ```bash
  make codex-edit file=path/to/file prompt="<Edit instructions>"
  ```

Outputs (edits or completions) appear in your terminal or overwrite the target file (with a `.edited` suffix if configured).

## Contributing

Feel free to submit issues or pull requests for enhancements or bug fixes.

## License

This project is licensed under the MIT Licence. See [LICENSE](https://github.com/gocanto/openai-codex/blob/main/LICENSE) for details.
