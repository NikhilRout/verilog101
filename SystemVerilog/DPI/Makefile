# Makefile — compile and run FPU DPI example
# Supports: VCS, Xcelium (xrun), Verilator

# ── VCS ───────────────────────────────────────────────────────────────────────
# VCS compiles the C++ shared library separately, then links at elaboration.
vcs:
	g++ -shared -fPIC -o fpu.so fpu.cpp
	vcs -sverilog -full64 \
	    fpu_dpi_pkg.sv fpu_rtl.sv fpu_tb.sv \
	    -LDFLAGS "-L. -Wl,-rpath,. fpu.so" \
	    -o simv
	./simv

# ── Xcelium (xrun) ───────────────────────────────────────────────────────────
# xrun can compile C inline with -sv_lib or by pointing to the .so
xrun:
	g++ -shared -fPIC -o fpu.so fpu.cpp
	xrun -sv \
	     fpu_dpi_pkg.sv fpu_rtl.sv fpu_tb.sv \
	     -sv_lib ./fpu.so

# ── Verilator ────────────────────────────────────────────────────────────────
# Verilator compiles SV to C++; DPI C files are added directly to the build.
# Verilator auto-generates the DPI header (VfpuDPI.h or similar).
verilator:
	verilator --binary --timing --cc \
	    fpu_dpi_pkg.sv fpu_rtl.sv fpu_tb.sv \
	    --exe fpu.cpp \
	    -CFLAGS "-std=c++17" \
	    -o Vfpu_tb
	make -C obj_dir -f Vfpu_tb.mk Vfpu_tb
	./obj_dir/Vfpu_tb

# ── Questa/ModelSim ──────────────────────────────────────────────────────────
questa:
	g++ -shared -fPIC -o fpu.so fpu.cpp
	vlib work
	vmap work work
	vlog -sv fpu_dpi_pkg.sv fpu_rtl.sv fpu_tb.sv
	vsim -sv_lib ./fpu work.fpu_tb -do "run -all; quit"

clean:
	rm -rf simv simv.daidir csrc *.so obj_dir work transcript vsim.wlf

.PHONY: vcs xrun verilator questa clean
