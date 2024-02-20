shader_type canvas_item;

void fragment() {
    // Obtener el color del pixel actual
    vec4 color = texture(TEXTURE, UV);

    // Convertir el color a escala de grises
    float gray = dot(color.rgb, vec3(0.299, 0.587, 0.114));

    // Asignar el nuevo color al pixel
    COLOR = vec4(gray, gray, gray, color.a);
}