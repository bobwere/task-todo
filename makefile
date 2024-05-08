.PHONY: generate
generate:
	flutter pub run build_runner build --delete-conflicting-outputs 

.PHONY: run
run:
	flutter clean && flutter pub get && flutter analyze && flutter run
