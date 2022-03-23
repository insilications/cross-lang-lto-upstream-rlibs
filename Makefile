-include ../tools.mk


# This test makes sure that we don't loose upstream object files when compiling
# staticlibs with -C linker-plugin-lto

nothin:
	rm ./*.o || :
	rm ./staticlib.a || :
	rm ./libupstream.rlib || :
	rm ./*.rmeta || :
	# Check No LTO
	rustc upstream.rs -C linker-plugin-lto -Ccodegen-units=1 -Cpanic=abort
	rustc staticlib.rs -C linker-plugin-lto -Ccodegen-units=1 -Cpanic=abort -L. -o ./staticlib.a
# 	/usr/bin/llvm-ar x ./staticlib.a
# 	# Make sure the upstream object file was included
# 	ls ./upstream.*.rcgu.o


thin:
	rm ./*.o || :
	rm ./staticlib.a || :
	rm ./libupstream.rlib || :
	rm ./*.rmeta || :
	# Check ThinLTO
	rustc upstream.rs -C linker-plugin-lto -Ccodegen-units=1 -Clto=thin -Cpanic=abort
	rustc staticlib.rs -C linker-plugin-lto -Ccodegen-units=1 -Clto=thin -Cpanic=abort -L. -o ./staticlib.a
# 	/usr/bin/llvm-ar x ./staticlib.a
# 	ls ./upstream.*.rcgu.o

clean:
	# Cleanup
	rm ./*.o || :
	rm ./staticlib.a || :
	rm ./libupstream.rlib || :
	rm ./*.rmeta || :
