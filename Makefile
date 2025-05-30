PREFIX ?= /usr/local
SHARE_DIR = $(PREFIX)/share/d20-cli
BIN_DIR = $(PREFIX)/bin

.PHONY: install uninstall check-install

install:
	@echo "⚙️ Установка d20-cli..."
	@mkdir -p $(SHARE_DIR)/lib
	@install -v -m 755 bin/d20 $(SHARE_DIR)/
	@install -v -m 644 lib/dice.sh $(SHARE_DIR)/lib/
	@ln -svf $(SHARE_DIR)/d20 $(BIN_DIR)/d20
	@echo "✅ Готово! Команда 'd20' установлена"
	@make check-install

uninstall:
	@echo "⚙️ Удаление d20-cli..."
	@rm -vrf $(SHARE_DIR)
	@rm -vf $(BIN_DIR)/d20
	@echo "✅ d20-cli полностью удалён"

check-install:
	@echo "\n🔍 Проверка установки:"
	@echo -n "• Бинарный файл: "
	@if [ -f "$(BIN_DIR)/d20" ]; then \
		echo "✅ $(BIN_DIR)/d20"; \
	else echo "❌ Не найден"; exit 1; fi
	
	@echo -n "• Библиотека: "
	@if [ -f "$(SHARE_DIR)/lib/dice.sh" ]; then \
		echo "✅ $(SHARE_DIR)/lib/dice.sh"; \
	else echo "❌ Не найдена"; exit 1; fi
	
	@echo -n "• Симлинк: "
	@if [ -L "$(BIN_DIR)/d20" ]; then \
		echo "✅ ведёт на $(readlink -f $(BIN_DIR)/d20)"; \
	else echo "❌ Не является симлинком"; exit 1; fi
	
	@echo -n "• Права: "
	@if [ -x "$(BIN_DIR)/d20" ]; then \
		echo "✅ Исполняемый"; \
	else echo "❌ Нет прав на выполнение"; exit 1; fi
	
	@echo "🎉 Проверка завершена успешно"

all: install test

clean:
	rm -f *.cast
	find . -name "*.swp" -delete

test:
	bats tests/test_dice.bats
	./tests/integration_test.sh
