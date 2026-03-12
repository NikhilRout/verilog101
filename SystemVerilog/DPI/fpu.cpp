// fpu.cpp — Single-precision FPU exposed via DPI-C
// Compile: g++ -shared -fPIC -o fpu.so fpu.cpp

#include <cstdint>   // uint32_t, int32_t
#include <cstring>   // memcpy (for type-mapping)
#include <cmath>     // INFINITY, NAN

extern "C" {

static inline float  bits_to_f32(uint32_t b) { float f;  memcpy(&f, &b, 4); return f; }
static inline uint32_t f32_to_bits(float  f) { uint32_t b; memcpy(&b, &f, 4); return b; }

uint32_t fpu_add(uint32_t a_bits, uint32_t b_bits) {
    float result = bits_to_f32(a_bits) + bits_to_f32(b_bits);
    return f32_to_bits(result);
}

uint32_t fpu_sub(uint32_t a_bits, uint32_t b_bits) {
    float result = bits_to_f32(a_bits) - bits_to_f32(b_bits);
    return f32_to_bits(result);
}

uint32_t fpu_mul(uint32_t a_bits, uint32_t b_bits) {
    float result = bits_to_f32(a_bits) * bits_to_f32(b_bits);
    return f32_to_bits(result);
}

uint32_t fpu_div(uint32_t a_bits, uint32_t b_bits) {
    float result = bits_to_f32(a_bits) / bits_to_f32(b_bits);
    return f32_to_bits(result);
}

} // extern "C"
