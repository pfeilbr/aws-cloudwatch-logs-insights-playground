main_file = "main.sh"

.PHONY: dev
dev:
	@bash $(main_file)
	@fswatch -o $(main_file) | xargs -n1 -I{} bash $(main_file)

