// fpu_dpi_pkg.sv — DPI import declarations
//
// The `import "DPI-C"` statement tells the simulator:
//   "there is a C function with this symbol name; here is its SV prototype"

package fpu_dpi_pkg;

    import "DPI-C" pure function automatic
        int unsigned fpu_add(input int unsigned a_bits, input int unsigned b_bits);

    import "DPI-C" pure function automatic
        int unsigned fpu_sub(input int unsigned a_bits, input int unsigned b_bits);

    import "DPI-C" pure function automatic
        int unsigned fpu_mul(input int unsigned a_bits, input int unsigned b_bits);

    import "DPI-C" pure function automatic
        int unsigned fpu_div(input int unsigned a_bits, input int unsigned b_bits);

endpackage
