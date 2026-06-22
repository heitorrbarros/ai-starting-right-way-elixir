.PHONY: opencode app

opencode:
	docker compose up --build -d ai
	docker exec -it opencode-ai bash

app:
	docker compose up --build -d app
	docker exec -it elixir-app bash
