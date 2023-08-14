import struct
import random

def float_to_bin(num):
    """Convert a float to IEEE 754 binary representation."""
    binary = format(struct.unpack('!I', struct.pack('!f', num))[0], '032b')
    return binary

def bin_to_float(binary):
    """Convert IEEE 754 binary representation to a float."""
    return struct.unpack('!f', struct.pack('!I', int(binary, 2)))[0]

def add_ieee754_binary(bin1, bin2):
    """Add two IEEE 754 binary representations and return the result binary."""
    num1 = bin_to_float(bin1)
    num2 = bin_to_float(bin2)
    result = num1 + num2
    return float_to_bin(result)

def get_random_float32():
    sign = random.randint(0, 1)
    exponent = random.randint(0, 7)
    mantissa = random.getrandbits(23)
    return struct.unpack('!f', struct.pack('!I', (sign << 31) | (exponent << 23) | mantissa))[0]

# Open the file for writing
with open("fps.tv", "w") as file:
    for _ in range(100):
        # Generate two random floating-point numbers using the provided function
        num1 = get_random_float32()
        num2 = get_random_float32()

        # Convert the numbers to IEEE 754 binary representation
        binary1 = float_to_bin(num1)
        binary2 = float_to_bin(num2)

        # Add the binary representations and get the result binary
        result_binary = add_ieee754_binary(binary1, binary2)

        # Construct the output string
        output_string = f"{binary1}_{binary2}_{result_binary}"

        # Write the output string to the file
        file.write(output_string + '\n')

print("100 output strings saved to 'fps.tv'")
