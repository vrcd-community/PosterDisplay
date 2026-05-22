// all the ease functions
// 0: easeInSine
// 1: easeOutSine
// 2: easeInOutSine
// 3: easeInQuad
// 4: easeOutQuad
// 5: easeInOutQuad
// 6: easeInCubic
// 7: easeOutCubic
// 8: easeInOutCubic
// 9: easeInQuart
// 10: easeOutQuart
// 11: easeInOutQuart
// 12: easeInQuint
// 13: easeOutQuint
// 14: easeInOutQuint
// 15: easeInExpo
// 16: easeOutExpo
// 17: easeInOutExpo
// 18: easeInCirc
// 19: easeOutCirc
// 20: easeInOutCirc
// 21: easeInBack
// 22: easeOutBack
// 23: easeInOutBack
// 24: easeInElastic
// 25: easeOutElastic
// 26: easeInOutElastic
// 27: easeInBounce
// 28: easeOutBounce
// 29: easeInOutBounce

#ifndef EASE_FUNCTIONS_INCLUDED
#define EASE_FUNCTIONS_INCLUDED

// Reference: https://easings.net/ (ported to HLSL/Cg)
static const float EASE_PI = 3.14159265359;

inline float easeInSine(float t)
{
	return 1.0 - cos((t * EASE_PI) * 0.5);
}

inline float easeOutSine(float t)
{
	return sin((t * EASE_PI) * 0.5);
}

inline float easeInOutSine(float t)
{
	return -0.5 * (cos(EASE_PI * t) - 1.0);
}

inline float easeInQuad(float t)
{
	return t * t;
}

inline float easeOutQuad(float t)
{
	return 1.0 - (1.0 - t) * (1.0 - t);
}

inline float easeInOutQuad(float t)
{
	return (t < 0.5) ? (2.0 * t * t) : (1.0 - pow(-2.0 * t + 2.0, 2.0) * 0.5);
}

inline float easeInCubic(float t)
{
	return t * t * t;
}

inline float easeOutCubic(float t)
{
	float u = 1.0 - t;
	return 1.0 - u * u * u;
}

inline float easeInOutCubic(float t)
{
	return (t < 0.5) ? (4.0 * t * t * t) : (1.0 - pow(-2.0 * t + 2.0, 3.0) * 0.5);
}

inline float easeInQuart(float t)
{
	return t * t * t * t;
}

inline float easeOutQuart(float t)
{
	float u = 1.0 - t;
	return 1.0 - u * u * u * u;
}

inline float easeInOutQuart(float t)
{
	return (t < 0.5) ? (8.0 * t * t * t * t) : (1.0 - pow(-2.0 * t + 2.0, 4.0) * 0.5);
}

inline float easeInQuint(float t)
{
	return t * t * t * t * t;
}

inline float easeOutQuint(float t)
{
	float u = 1.0 - t;
	return 1.0 - u * u * u * u * u;
}

inline float easeInOutQuint(float t)
{
	return (t < 0.5) ? (16.0 * t * t * t * t * t) : (1.0 - pow(-2.0 * t + 2.0, 5.0) * 0.5);
}

inline float easeInExpo(float t)
{
	return (t <= 0.0) ? 0.0 : pow(2.0, 10.0 * t - 10.0);
}

inline float easeOutExpo(float t)
{
	return (t >= 1.0) ? 1.0 : (1.0 - pow(2.0, -10.0 * t));
}

inline float easeInOutExpo(float t)
{
	if (t <= 0.0)
		return 0.0;
	if (t >= 1.0)
		return 1.0;
	return (t < 0.5) ? (pow(2.0, 20.0 * t - 10.0) * 0.5) : ((2.0 - pow(2.0, -20.0 * t + 10.0)) * 0.5);
}

inline float easeInCirc(float t)
{
	return 1.0 - sqrt(1.0 - t * t);
}

inline float easeOutCirc(float t)
{
	float u = t - 1.0;
	return sqrt(1.0 - u * u);
}

inline float easeInOutCirc(float t)
{
	return (t < 0.5)
		? (0.5 * (1.0 - sqrt(1.0 - 4.0 * t * t)))
		: (0.5 * (sqrt(1.0 - pow(-2.0 * t + 2.0, 2.0)) + 1.0));
}

inline float easeInBack(float t)
{
	const float c1 = 1.70158;
	const float c3 = c1 + 1.0;
	return c3 * t * t * t - c1 * t * t;
}

inline float easeOutBack(float t)
{
	const float c1 = 1.70158;
	const float c3 = c1 + 1.0;
	float u = t - 1.0;
	return 1.0 + c3 * u * u * u + c1 * u * u;
}

inline float easeInOutBack(float t)
{
	const float c1 = 1.70158;
	const float c2 = c1 * 1.525;
	return (t < 0.5)
		? (pow(2.0 * t, 2.0) * ((c2 + 1.0) * 2.0 * t - c2) * 0.5)
		: ((pow(2.0 * t - 2.0, 2.0) * ((c2 + 1.0) * (t * 2.0 - 2.0) + c2) + 2.0) * 0.5);
}

inline float easeInElastic(float t)
{
	const float c4 = (2.0 * EASE_PI) / 3.0;
	if (t <= 0.0)
		return 0.0;
	if (t >= 1.0)
		return 1.0;
	return -pow(2.0, 10.0 * t - 10.0) * sin((t * 10.0 - 10.75) * c4);
}

inline float easeOutElastic(float t)
{
	const float c4 = (2.0 * EASE_PI) / 3.0;
	if (t <= 0.0)
		return 0.0;
	if (t >= 1.0)
		return 1.0;
	return pow(2.0, -10.0 * t) * sin((t * 10.0 - 0.75) * c4) + 1.0;
}

inline float easeInOutElastic(float t)
{
	const float c5 = (2.0 * EASE_PI) / 4.5;
	if (t <= 0.0)
		return 0.0;
	if (t >= 1.0)
		return 1.0;
	return (t < 0.5)
		? (-pow(2.0, 20.0 * t - 10.0) * sin((20.0 * t - 11.125) * c5) * 0.5)
		: (pow(2.0, -20.0 * t + 10.0) * sin((20.0 * t - 11.125) * c5) * 0.5 + 1.0);
}

inline float easeOutBounce(float t)
{
	const float n1 = 7.5625;
	const float d1 = 2.75;
	if (t < 1.0 / d1)
		return n1 * t * t;
	if (t < 2.0 / d1)
	{
		float u = t - 1.5 / d1;
		return n1 * u * u + 0.75;
	}
	if (t < 2.5 / d1)
	{
		float u = t - 2.25 / d1;
		return n1 * u * u + 0.9375;
	}
	float v = t - 2.625 / d1;
	return n1 * v * v + 0.984375;
}

inline float easeInBounce(float t)
{
	return 1.0 - easeOutBounce(1.0 - t);
}

inline float easeInOutBounce(float t)
{
	return (t < 0.5)
		? (0.5 * (1.0 - easeOutBounce(1.0 - 2.0 * t)))
		: (0.5 * (1.0 + easeOutBounce(2.0 * t - 1.0)));
}

inline float EaseFunction(float t, int easeType)
{
	t = saturate(t);
	// Dispatch by index to match _EaseFunction keyword order.

	if (easeType == 0) return easeInSine(t);
	if (easeType == 1) return easeOutSine(t);
	if (easeType == 2) return easeInOutSine(t);
	if (easeType == 3) return easeInQuad(t);
	if (easeType == 4) return easeOutQuad(t);
	if (easeType == 5) return easeInOutQuad(t);
	if (easeType == 6) return easeInCubic(t);
	if (easeType == 7) return easeOutCubic(t);
	if (easeType == 8) return easeInOutCubic(t);
	if (easeType == 9) return easeInQuart(t);
	if (easeType == 10) return easeOutQuart(t);
	if (easeType == 11) return easeInOutQuart(t);
	if (easeType == 12) return easeInQuint(t);
	if (easeType == 13) return easeOutQuint(t);
	if (easeType == 14) return easeInOutQuint(t);
	if (easeType == 15) return easeInExpo(t);
	if (easeType == 16) return easeOutExpo(t);
	if (easeType == 17) return easeInOutExpo(t);
	if (easeType == 18) return easeInCirc(t);
	if (easeType == 19) return easeOutCirc(t);
	if (easeType == 20) return easeInOutCirc(t);
	if (easeType == 21) return easeInBack(t);
	if (easeType == 22) return easeOutBack(t);
	if (easeType == 23) return easeInOutBack(t);
	if (easeType == 24) return easeInElastic(t);
	if (easeType == 25) return easeOutElastic(t);
	if (easeType == 26) return easeInOutElastic(t);
	if (easeType == 27) return easeInBounce(t);
	if (easeType == 28) return easeOutBounce(t);
	if (easeType == 29) return easeInOutBounce(t);

	return t;
}

#endif

