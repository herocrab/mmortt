extends Node

# Constants
const FIXED_SHIFT := 16 # could use 32
const FIXED_ONE := 1 << FIXED_SHIFT
#const FIXED_MASK := FIXED_ONE - 1 # can be used to remove fractional portion
const PI_FIXED := int(3.14159265 * FIXED_ONE)
const TWO_PI_FIXED := int(2 * 3.14159265 * FIXED_ONE)

# Multiply two fixed-point numbers
func mul(a: int, b: int) -> int:
	return (a * b) >> FIXED_SHIFT

# Square an integer
func sqr(x: int) -> int:
	return x * x

# Divide two fixed-point numbers, discard the decimal portion
func div(a: int, b: int) -> int:
	return (a << FIXED_SHIFT) / b

# Linear interpolation
func lerp(a: int, b: int, t: int) -> int:
	return a + mul(b - a, t)

# Integer square root (Newton's method), discard the decimal portion
func sqrt_fixed(n: int) -> int:
	if n < 0:
		return 0  # or error
	if n == 0:
		return 0
	var x := n
	for i in 6:
		x = (x + n / x) / 2
	return x

# Normalize an angle to 0–360 degrees in fixed-point
func normalize_angle(angle: int) -> int:
	angle %= 360 * FIXED_ONE
	if angle < 0:
		angle += 360 * FIXED_ONE
	return angle

# Shortest angle difference between two fixed-point degrees
func angle_diff(a: int, b: int) -> int:
	var diff := (b - a + 180 * FIXED_ONE) % (360 * FIXED_ONE)
	if diff < 0:
		diff += 360 * FIXED_ONE
	return diff - 180 * FIXED_ONE

# Convert float to fixed-point
func to_fixed(f: float) -> int:
	return int(f * FIXED_ONE)

# Convert fixed-point to float
func to_float(fx: int) -> float:
	return fx / float(FIXED_ONE)

# Converts fixed-point radians to degrees
func fixed_rad_to_deg(rad_fixed: int) -> int:
	return div(rad_fixed * 180, PI_FIXED)

# Converts fixed-point degrees to radians
func fixed_deg_to_rad(deg_fixed: int) -> int:
	return div(deg_fixed * PI_FIXED, 180)

# Calculate the distance between two grid locations
func distance(a: Vector2i, b: Vector2i) -> int:
	var delta := a - b
	var dist_sq := delta.x * delta.x + delta.y * delta.y
	return sqrt_fixed(dist_sq)
