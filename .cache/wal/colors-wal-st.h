const char *colorname[] = {

  /* 8 normal colors */
  [0] = "#282c34", /* black   */
  [1] = "#e06c75", /* red     */
  [2] = "#98c379", /* green   */
  [3] = "#e5c07b", /* yellow  */
  [4] = "#61afef", /* blue    */
  [5] = "#c678dd", /* magenta */
  [6] = "#56b6c2", /* cyan    */
  [7] = "#abb2bf", /* white   */

  /* 8 bright colors */
  [8]  = "#545862",  /* black   */
  [9]  = "#e06c75",  /* red     */
  [10] = "#98c379", /* green   */
  [11] = "#e5c07b", /* yellow  */
  [12] = "#61afef", /* blue    */
  [13] = "#c678dd", /* magenta */
  [14] = "#56b6c2", /* cyan    */
  [15] = "#c8ccd4", /* white   */

  /* special colors */
  [256] = "#282c34", /* background */
  [257] = "#abb2bf", /* foreground */
  [258] = "#abb2bf",     /* cursor */
};

/* Default colors (colorname index)
 * foreground, background, cursor */
 unsigned int defaultbg = 0;
 unsigned int defaultfg = 257;
 unsigned int defaultcs = 258;
 unsigned int defaultrcs= 258;
