.PHONY: opencode

opencode:
	docker compose up --build -d ai
	docker exec -it opencode-ai bash
