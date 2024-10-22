static const char norm_fg[] = "#c8ccd4";
static const char norm_bg[] = "#282c34";
static const char norm_border[] = "#545862";

static const char sel_fg[] = "#c8ccd4";
static const char sel_bg[] = "#98c379";
static const char sel_border[] = "#c8ccd4";

static const char urg_fg[] = "#c8ccd4";
static const char urg_bg[] = "#e06c75";
static const char urg_border[] = "#e06c75";

static const char *colors[][3]      = {
    /*               fg           bg         border                         */
    [SchemeNorm] = { norm_fg,     norm_bg,   norm_border }, // unfocused wins
    [SchemeSel]  = { sel_fg,      sel_bg,    sel_border },  // the focused win
    [SchemeUrg] =  { urg_fg,      urg_bg,    urg_border },
};
