#define PROCESSING_COLOR_SHADER

uniform float time;
uniform vec2 resolution;

// From https://iquilezles.org/articles/distfunctions2d/
float dot2( in vec2 v ) { return dot(v,v); }
float sdHeart( in vec2 p )
{
    p.x = abs(p.x);

    if( p.y+p.x>1.0 )
        return sqrt(dot2(p-vec2(0.25,0.75))) - sqrt(2.0)/4.0;
    return sqrt(min(dot2(p-vec2(0.00,1.00)),
                    dot2(p-0.5*max(p.x+p.y,0.0)))) * sign(p.x-p.y);
}

void main( void ) {
     vec2 uv = (gl_FragCoord.xy * 2.0 - resolution.xy) / resolution.y;


    uv.y += 0.5;
    //float d = length(uv);
    float d = sdHeart(uv);


    d = sin(d*8. -time )/8.;
    d = abs(d);

    d = 0.02 /d;

	gl_FragColor = vec4(d, d, d,1.0);

}
