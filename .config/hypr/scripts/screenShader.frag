//
// Example blue light filter shader with red tint.
// 

precision mediump float;
varying vec2 v_texcoord;
uniform sampler2D tex;

void main() {
    vec4 pixColor = texture2D(tex, v_texcoord);

    // Decrease the blue channel
    pixColor[2] *= 0.5; // Reduce blue intensity

    // Increase the red channel
    pixColor[0] *= 1.2; // Increase red intensity (adjust this value as needed)

    gl_FragColor = pixColor;
}

