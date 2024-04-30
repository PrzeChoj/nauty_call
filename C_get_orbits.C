#define MAXN 1000 /* Define this before including nauty.h */
#include "nauty.h" /* which includes <stdio.h> and other system files */


#include <R.h>
#include <Rinternals.h>

// n - numer of vertices
// m - numer of edges
void C_get_orbits(int *p, int *lab, int *ptn, int *orbits, int *num_edges, int *edges_from, int *edges_to, int *out)
{
    graph g[MAXN*MAXM];
    static DEFAULTOPTIONS_GRAPH(options);
    statsblk stats;

    int m,v;
	
	options.defaultptn = FALSE;
	options.getcanon = TRUE;
	
	if (*p > MAXN){
		return; // This is illegal
	}
	
	m = SETWORDSNEEDED(*p);
	
	nauty_check(WORDSIZE,m,*p,NAUTYVERSIONID);
	
    EMPTYGRAPH(g,m,*p);
    for (v = 0; v < *num_edges; ++v)  ADDONEEDGE(g,edges_from[v],edges_to[v],m);
	
	graph canong[MAXN*MAXM];
	
	densenauty(g,lab,ptn,orbits,&options,&stats,m,*p,canong);
	
    for (v = 0; v < *p; ++v){
		out[v] = orbits[v];
	}
}

/*
gcc -shared -o C_get_orbits.so C_get_orbits.c -I/Library/Frameworks/R.framework/Headers -I/.../nauty2_8_8 -L/Library/Frameworks/R.framework/Libraries -L/.../nauty2_8_8 -lR /.../nauty2_8_8/nauty.a
*/
