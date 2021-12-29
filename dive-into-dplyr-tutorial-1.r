{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.021041,
     "end_time": "2021-12-29T06:18:35.072736",
     "exception": false,
     "start_time": "2021-12-29T06:18:35.051695",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Introduction: why dplyr?\n",
    "\n",
    "There are a _lot_ of amazing packages in the [Tidyverse](https://www.tidyverse.org/packages/), but `dplyr` is hands-down my absolute favorite package. I use `dplyr` when I'm cleaning and exploring my dataset, and what I particularly love is that after I get a good handle on my dataset with `dplyr`, I can feed the various manipulations I've creating into the `ggplot2` package for visualization.  \n",
    "\n",
    "This tutorial is for anyone interested in learning the basics of the `dplyr` package. We'll be focusing on data exploration and manipulation, building off of the examples in the `dplyr` package documentation using the [Palmer Penguins](https://www.kaggle.com/parulpandey/palmer-archipelago-antarctica-penguin-data) dataset.   \n",
    "\n",
    "**By the end of this notebook, you'll be able to:**  \n",
    "* Demonstrate what each of the main five `dplyr` functions does\n",
    "* Use the pipe operator `%>%` to chain together multiple `dplyr` functions"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.019162,
     "end_time": "2021-12-29T06:18:35.111681",
     "exception": false,
     "start_time": "2021-12-29T06:18:35.092519",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### My analytical workflow\n",
    "\n",
    "We won't be covering _all_ of the steps in my workflow in this tutorial, but in general I follow these steps: \n",
    "\n",
    "1. Set up the programming environment by loading packages  \n",
    "2. Import my data  \n",
    "3. Check out my data \n",
    "4. Explore my data \n",
    "5. Model my data\n",
    "6. Communicate what I've learned"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.019436,
     "end_time": "2021-12-29T06:18:35.150568",
     "exception": false,
     "start_time": "2021-12-29T06:18:35.131132",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Set up our environment"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:35.220737Z",
     "iopub.status.busy": "2021-12-29T06:18:35.218642Z",
     "iopub.status.idle": "2021-12-29T06:18:36.703640Z",
     "shell.execute_reply": "2021-12-29T06:18:36.701626Z"
    },
    "papermill": {
     "duration": 1.533483,
     "end_time": "2021-12-29T06:18:36.703982",
     "exception": false,
     "start_time": "2021-12-29T06:18:35.170499",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.0 ──\n",
      "\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.2     \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.0.3     \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.2\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.1.2     \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 1.3.1     \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.0\n",
      "\n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\n"
     ]
    }
   ],
   "source": [
    "# we have a couple of options here - we can load the entire tidyverse or we can just load the \n",
    "# tidyverse packages that we're interested in using. I'm going to load the tidyverse, but alternatively you\n",
    "# could run the following instead:\n",
    "\n",
    "#library(readr)\n",
    "#library(dplyr)\n",
    "\n",
    "# load the tidyverse\n",
    "library(tidyverse)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.019719,
     "end_time": "2021-12-29T06:18:36.744790",
     "exception": false,
     "start_time": "2021-12-29T06:18:36.725071",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### A quick note on Conflicts\n",
    "\n",
    "After running `library(tidyverse)` you might have noticed that the print out told us which packages were attached successfully (all of them, as evidenced by the green check marks), and where we have conflicts (the red x's).  \n",
    "\n",
    "Conflicts aren't necessarily a bad thing! Because R is an open source language and anyone can create a package, it's common for different packages to use the same name for similar functions. In our conflicts we see that the `filter()` function from the `dplyr` package masks the `filter()` function from the `stats` package. We know this because the package name comes before the double colon and the function name comes after, like this:  \n",
    "\n",
    "> `package::function()`\n",
    "\n",
    "What if we want to use the `filter()` function from the stats package? All is not lost! What we can do in our code is use the full `package::function()` syntax and R will know to use the `filter()` function from the `stats` package instead of the `dplyr` package."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.019464,
     "end_time": "2021-12-29T06:18:36.783850",
     "exception": false,
     "start_time": "2021-12-29T06:18:36.764386",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Import our data"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:36.862256Z",
     "iopub.status.busy": "2021-12-29T06:18:36.827284Z",
     "iopub.status.idle": "2021-12-29T06:18:36.979257Z",
     "shell.execute_reply": "2021-12-29T06:18:36.978065Z"
    },
    "papermill": {
     "duration": 0.175559,
     "end_time": "2021-12-29T06:18:36.979401",
     "exception": false,
     "start_time": "2021-12-29T06:18:36.803842",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Parsed with column specification:\n",
      "cols(\n",
      "  species = \u001b[31mcol_character()\u001b[39m,\n",
      "  island = \u001b[31mcol_character()\u001b[39m,\n",
      "  culmen_length_mm = \u001b[32mcol_double()\u001b[39m,\n",
      "  culmen_depth_mm = \u001b[32mcol_double()\u001b[39m,\n",
      "  flipper_length_mm = \u001b[32mcol_double()\u001b[39m,\n",
      "  body_mass_g = \u001b[32mcol_double()\u001b[39m,\n",
      "  sex = \u001b[31mcol_character()\u001b[39m\n",
      ")\n",
      "\n"
     ]
    }
   ],
   "source": [
    "penguins <- read_csv('../input/palmer-archipelago-antarctica-penguin-data/penguins_size.csv')"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.019605,
     "end_time": "2021-12-29T06:18:37.019994",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.000389",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Parsing the parsing statement\n",
    "\n",
    "One thing that took me awhile to get used to was that just because the text is in BRIGHT RED doesn't mean that something bad has happened, or that I've made a mistake. And that's the same as what we're seeing here!    \n",
    "\n",
    "What the parsing statement does is tell us how R formatted each of the columns in our dataframe. The `read_csv()` function looks at the first thousand rows of a dataset and makes an educated guess as to what the remaining rows are. We can override this if we need to, either by telling R to use more rows to guess using the `guess_max` argument, or by explicitly telling R what type of data is in each column."
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.019767,
     "end_time": "2021-12-29T06:18:37.060367",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.040600",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Check out our data\n",
    "\n",
    "Here's where I like to get a handle on what I'm working with. I'll use various functions to make sure my data imported correctly, and start to get an understanding of the data structure and data types. The functions I commonly use to accomplish this are:  \n",
    "\n",
    "* `glimpse()`\n",
    "* `head()` and `tail()`\n",
    "* `summary()`"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.020067,
     "end_time": "2021-12-29T06:18:37.100984",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.080917",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### glimpse() is grrrreat!\n",
    "\n",
    "`glimpse()` gives you just about everything you could want, all wrapped up in a single function. We get our dataframe structure with the printout to rows and columns, telling us that in our `penguins` dataset we have 344 rows (or observations) and 7 columns (or variables).  \n",
    "\n",
    "![](http://)We also see each of the variables listed out by name, followed by the data type `<datatype>`, and then a look at the first few rows of each variable."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:37.148612Z",
     "iopub.status.busy": "2021-12-29T06:18:37.146579Z",
     "iopub.status.idle": "2021-12-29T06:18:37.192594Z",
     "shell.execute_reply": "2021-12-29T06:18:37.190822Z"
    },
    "papermill": {
     "duration": 0.071102,
     "end_time": "2021-12-29T06:18:37.192814",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.121712",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "Rows: 344\n",
      "Columns: 7\n",
      "$ species           \u001b[3m\u001b[38;5;246m<chr>\u001b[39m\u001b[23m \"Adelie\", \"Adelie\", \"Adelie\", \"Adelie\", \"Adelie\", \"…\n",
      "$ island            \u001b[3m\u001b[38;5;246m<chr>\u001b[39m\u001b[23m \"Torgersen\", \"Torgersen\", \"Torgersen\", \"Torgersen\",…\n",
      "$ culmen_length_mm  \u001b[3m\u001b[38;5;246m<dbl>\u001b[39m\u001b[23m 39.1, 39.5, 40.3, NA, 36.7, 39.3, 38.9, 39.2, 34.1,…\n",
      "$ culmen_depth_mm   \u001b[3m\u001b[38;5;246m<dbl>\u001b[39m\u001b[23m 18.7, 17.4, 18.0, NA, 19.3, 20.6, 17.8, 19.6, 18.1,…\n",
      "$ flipper_length_mm \u001b[3m\u001b[38;5;246m<dbl>\u001b[39m\u001b[23m 181, 186, 195, NA, 193, 190, 181, 195, 193, 190, 18…\n",
      "$ body_mass_g       \u001b[3m\u001b[38;5;246m<dbl>\u001b[39m\u001b[23m 3750, 3800, 3250, NA, 3450, 3650, 3625, 4675, 3475,…\n",
      "$ sex               \u001b[3m\u001b[38;5;246m<chr>\u001b[39m\u001b[23m \"MALE\", \"FEMALE\", \"FEMALE\", NA, \"FEMALE\", \"MALE\", \"…\n"
     ]
    }
   ],
   "source": [
    "glimpse(penguins)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.019812,
     "end_time": "2021-12-29T06:18:37.234815",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.215003",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### The heck is a culmen?\n",
    "\n",
    "> I didn't know either, but [Allison Horst](https://twitter.com/allison_horst) has an amazing illustration explaining it!\n",
    "\n",
    "![](https://pbs.twimg.com/media/EaAXQn8U4AAoKUj.jpg:small)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.019807,
     "end_time": "2021-12-29T06:18:37.274649",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.254842",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### head()\n",
    "\n",
    "Before reading further (or running the code) take a second to think about what the `head()` function might return.  \n",
    "\n",
    "If you guessed the \"head\" of the dataframe, or the first few rows, you'd be correct! I use `head()` to check a couple of things. First, I want to see if my data imported correctly. It's not uncommon to have the first few rows of a `.csv` file be blank, or contain information that I don't want in my final dataset. Second, `head()` prints out a nicely-formatted table that lets me take a quick look and see if the data is formatted consistently.  \n",
    "\n",
    "Using `head()` and seeing that your data is formatted consistently isn't a guarantee that you won't run into problems later, but it's a great first check.  "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:37.320386Z",
     "iopub.status.busy": "2021-12-29T06:18:37.318812Z",
     "iopub.status.idle": "2021-12-29T06:18:37.355079Z",
     "shell.execute_reply": "2021-12-29T06:18:37.353685Z"
    },
    "papermill": {
     "duration": 0.060373,
     "end_time": "2021-12-29T06:18:37.355231",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.294858",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.1</td><td>18.7</td><td>181</td><td>3750</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.5</td><td>17.4</td><td>186</td><td>3800</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>40.3</td><td>18.0</td><td>195</td><td>3250</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>  NA</td><td>  NA</td><td> NA</td><td>  NA</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>36.7</td><td>19.3</td><td>193</td><td>3450</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.3</td><td>20.6</td><td>190</td><td>3650</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie & Torgersen & 39.1 & 18.7 & 181 & 3750 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 39.5 & 17.4 & 186 & 3800 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 40.3 & 18.0 & 195 & 3250 & FEMALE\\\\\n",
       "\t Adelie & Torgersen &   NA &   NA &  NA &   NA & NA    \\\\\n",
       "\t Adelie & Torgersen & 36.7 & 19.3 & 193 & 3450 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 39.3 & 20.6 & 190 & 3650 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Adelie | Torgersen | 39.1 | 18.7 | 181 | 3750 | MALE   |\n",
       "| Adelie | Torgersen | 39.5 | 17.4 | 186 | 3800 | FEMALE |\n",
       "| Adelie | Torgersen | 40.3 | 18.0 | 195 | 3250 | FEMALE |\n",
       "| Adelie | Torgersen |   NA |   NA |  NA |   NA | NA     |\n",
       "| Adelie | Torgersen | 36.7 | 19.3 | 193 | 3450 | FEMALE |\n",
       "| Adelie | Torgersen | 39.3 | 20.6 | 190 | 3650 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "  species island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1 Adelie  Torgersen 39.1             18.7            181              \n",
       "2 Adelie  Torgersen 39.5             17.4            186              \n",
       "3 Adelie  Torgersen 40.3             18.0            195              \n",
       "4 Adelie  Torgersen   NA               NA             NA              \n",
       "5 Adelie  Torgersen 36.7             19.3            193              \n",
       "6 Adelie  Torgersen 39.3             20.6            190              \n",
       "  body_mass_g sex   \n",
       "1 3750        MALE  \n",
       "2 3800        FEMALE\n",
       "3 3250        FEMALE\n",
       "4   NA        NA    \n",
       "5 3450        FEMALE\n",
       "6 3650        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(penguins)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.021732,
     "end_time": "2021-12-29T06:18:37.399981",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.378249",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### summary()\n",
    "\n",
    "`summary()` might be one of the first functions I remember using and going \"ooooh, this is pretty cool!\" Like with the `head()` function, the name tells you what it does - any data that we pass to `summary()` will return a set of summary statistics appropriate for that datatype.  \n",
    "\n",
    "We can send individual variables to `summary()`, or an entire dataframe, and get a quick idea of our data types, the spread of our data, and an idea of how much missing missing data we'll be dealing with."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:37.449144Z",
     "iopub.status.busy": "2021-12-29T06:18:37.447881Z",
     "iopub.status.idle": "2021-12-29T06:18:37.468720Z",
     "shell.execute_reply": "2021-12-29T06:18:37.467675Z"
    },
    "papermill": {
     "duration": 0.046999,
     "end_time": "2021-12-29T06:18:37.468871",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.421872",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   species             island          culmen_length_mm culmen_depth_mm\n",
       " Length:344         Length:344         Min.   :32.10    Min.   :13.10  \n",
       " Class :character   Class :character   1st Qu.:39.23    1st Qu.:15.60  \n",
       " Mode  :character   Mode  :character   Median :44.45    Median :17.30  \n",
       "                                       Mean   :43.92    Mean   :17.15  \n",
       "                                       3rd Qu.:48.50    3rd Qu.:18.70  \n",
       "                                       Max.   :59.60    Max.   :21.50  \n",
       "                                       NA's   :2        NA's   :2      \n",
       " flipper_length_mm  body_mass_g       sex           \n",
       " Min.   :172.0     Min.   :2700   Length:344        \n",
       " 1st Qu.:190.0     1st Qu.:3550   Class :character  \n",
       " Median :197.0     Median :4050   Mode  :character  \n",
       " Mean   :200.9     Mean   :4202                     \n",
       " 3rd Qu.:213.0     3rd Qu.:4750                     \n",
       " Max.   :231.0     Max.   :6300                     \n",
       " NA's   :2         NA's   :2                        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(penguins)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.022382,
     "end_time": "2021-12-29T06:18:37.515047",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.492665",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### a note on names()\n",
    "\n",
    "I have a really hard time remembering what the names of my variables are, and because R is case-sensitive, how the names are formatted. We could fix this by converting all of our variable names to the same case, but for now just know that if you ever need a refresher on the names of the variables in your dataset (and how they're formatted!) you can run `names()`, like this:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:37.564476Z",
     "iopub.status.busy": "2021-12-29T06:18:37.562751Z",
     "iopub.status.idle": "2021-12-29T06:18:37.579998Z",
     "shell.execute_reply": "2021-12-29T06:18:37.578407Z"
    },
    "papermill": {
     "duration": 0.042884,
     "end_time": "2021-12-29T06:18:37.580138",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.537254",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'species'</li><li>'island'</li><li>'culmen_length_mm'</li><li>'culmen_depth_mm'</li><li>'flipper_length_mm'</li><li>'body_mass_g'</li><li>'sex'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'species'\n",
       "\\item 'island'\n",
       "\\item 'culmen\\_length\\_mm'\n",
       "\\item 'culmen\\_depth\\_mm'\n",
       "\\item 'flipper\\_length\\_mm'\n",
       "\\item 'body\\_mass\\_g'\n",
       "\\item 'sex'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'species'\n",
       "2. 'island'\n",
       "3. 'culmen_length_mm'\n",
       "4. 'culmen_depth_mm'\n",
       "5. 'flipper_length_mm'\n",
       "6. 'body_mass_g'\n",
       "7. 'sex'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] \"species\"           \"island\"            \"culmen_length_mm\" \n",
       "[4] \"culmen_depth_mm\"   \"flipper_length_mm\" \"body_mass_g\"      \n",
       "[7] \"sex\"              "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "names(penguins)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.021814,
     "end_time": "2021-12-29T06:18:37.624099",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.602285",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Exploring our data with dplyr\n",
    "\n",
    "**Main functions we'll use**\n",
    "* `arrange()`\n",
    "* `filter()`\n",
    "* `select()`\n",
    "* `mutate()`\n",
    "* `summarise()` (you can also use `summarize()`)\n",
    "\n",
    "**Reading and writing R code**  \n",
    "One thing that I really enjoy about working in R is that I can write out what I want to do in a sentence, and then translate that into code. For example, if I say:\n",
    "\n",
    "> Take the penguins dataset and then filter for all penguins that live on Torgersen island\n",
    "\n",
    "* _Take the penguins dataset_ **translates to** `penguins`\n",
    "* _and then_ **translates to** `%>%`\n",
    "* _filter for all penguins that live on Torgersen island_ **translates to** `filter(island == \"Torgersen\")`\n",
    "\n",
    "We can then take these three lines and put them together to get the following:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:37.674665Z",
     "iopub.status.busy": "2021-12-29T06:18:37.673211Z",
     "iopub.status.idle": "2021-12-29T06:18:37.743510Z",
     "shell.execute_reply": "2021-12-29T06:18:37.741967Z"
    },
    "papermill": {
     "duration": 0.096967,
     "end_time": "2021-12-29T06:18:37.743711",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.646744",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 52 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.1</td><td>18.7</td><td>181</td><td>3750</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.5</td><td>17.4</td><td>186</td><td>3800</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>40.3</td><td>18.0</td><td>195</td><td>3250</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>  NA</td><td>  NA</td><td> NA</td><td>  NA</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>36.7</td><td>19.3</td><td>193</td><td>3450</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.3</td><td>20.6</td><td>190</td><td>3650</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>38.9</td><td>17.8</td><td>181</td><td>3625</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.2</td><td>19.6</td><td>195</td><td>4675</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>34.1</td><td>18.1</td><td>193</td><td>3475</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>42.0</td><td>20.2</td><td>190</td><td>4250</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>37.8</td><td>17.1</td><td>186</td><td>3300</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>37.8</td><td>17.3</td><td>180</td><td>3700</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>41.1</td><td>17.6</td><td>182</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>38.6</td><td>21.2</td><td>191</td><td>3800</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>34.6</td><td>21.1</td><td>198</td><td>4400</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>36.6</td><td>17.8</td><td>185</td><td>3700</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>38.7</td><td>19.0</td><td>195</td><td>3450</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>42.5</td><td>20.7</td><td>197</td><td>4500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>34.4</td><td>18.4</td><td>184</td><td>3325</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>46.0</td><td>21.5</td><td>194</td><td>4200</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>35.9</td><td>16.6</td><td>190</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>41.8</td><td>19.4</td><td>198</td><td>4450</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>33.5</td><td>19.0</td><td>190</td><td>3600</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.7</td><td>18.4</td><td>190</td><td>3900</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.6</td><td>17.2</td><td>196</td><td>3550</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>45.8</td><td>18.9</td><td>197</td><td>4150</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>35.5</td><td>17.5</td><td>190</td><td>3700</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>42.8</td><td>18.5</td><td>195</td><td>4250</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>40.9</td><td>16.8</td><td>191</td><td>3700</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>37.2</td><td>19.4</td><td>184</td><td>3900</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>36.2</td><td>16.1</td><td>187</td><td>3550</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>42.1</td><td>19.1</td><td>195</td><td>4000</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>34.6</td><td>17.2</td><td>189</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>42.9</td><td>17.6</td><td>196</td><td>4700</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>36.7</td><td>18.8</td><td>187</td><td>3800</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>35.1</td><td>19.4</td><td>193</td><td>4200</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>38.6</td><td>17.0</td><td>188</td><td>2900</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>37.3</td><td>20.5</td><td>199</td><td>3775</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>35.7</td><td>17.0</td><td>189</td><td>3350</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>41.1</td><td>18.6</td><td>189</td><td>3325</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>36.2</td><td>17.2</td><td>187</td><td>3150</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>37.7</td><td>19.8</td><td>198</td><td>3500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>40.2</td><td>17.0</td><td>176</td><td>3450</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>41.4</td><td>18.5</td><td>202</td><td>3875</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>35.2</td><td>15.9</td><td>186</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>40.6</td><td>19.0</td><td>199</td><td>4000</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>38.8</td><td>17.6</td><td>191</td><td>3275</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>41.5</td><td>18.3</td><td>195</td><td>4300</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.0</td><td>17.1</td><td>191</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>44.1</td><td>18.0</td><td>210</td><td>4000</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>38.5</td><td>17.9</td><td>190</td><td>3325</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>43.1</td><td>19.2</td><td>197</td><td>3500</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 52 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie & Torgersen & 39.1 & 18.7 & 181 & 3750 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 39.5 & 17.4 & 186 & 3800 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 40.3 & 18.0 & 195 & 3250 & FEMALE\\\\\n",
       "\t Adelie & Torgersen &   NA &   NA &  NA &   NA & NA    \\\\\n",
       "\t Adelie & Torgersen & 36.7 & 19.3 & 193 & 3450 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 39.3 & 20.6 & 190 & 3650 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 38.9 & 17.8 & 181 & 3625 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 39.2 & 19.6 & 195 & 4675 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 34.1 & 18.1 & 193 & 3475 & NA    \\\\\n",
       "\t Adelie & Torgersen & 42.0 & 20.2 & 190 & 4250 & NA    \\\\\n",
       "\t Adelie & Torgersen & 37.8 & 17.1 & 186 & 3300 & NA    \\\\\n",
       "\t Adelie & Torgersen & 37.8 & 17.3 & 180 & 3700 & NA    \\\\\n",
       "\t Adelie & Torgersen & 41.1 & 17.6 & 182 & 3200 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 38.6 & 21.2 & 191 & 3800 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 34.6 & 21.1 & 198 & 4400 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 36.6 & 17.8 & 185 & 3700 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 38.7 & 19.0 & 195 & 3450 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 42.5 & 20.7 & 197 & 4500 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 34.4 & 18.4 & 184 & 3325 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 46.0 & 21.5 & 194 & 4200 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 35.9 & 16.6 & 190 & 3050 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 41.8 & 19.4 & 198 & 4450 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 33.5 & 19.0 & 190 & 3600 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 39.7 & 18.4 & 190 & 3900 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 39.6 & 17.2 & 196 & 3550 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 45.8 & 18.9 & 197 & 4150 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 35.5 & 17.5 & 190 & 3700 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 42.8 & 18.5 & 195 & 4250 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 40.9 & 16.8 & 191 & 3700 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 37.2 & 19.4 & 184 & 3900 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 36.2 & 16.1 & 187 & 3550 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 42.1 & 19.1 & 195 & 4000 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 34.6 & 17.2 & 189 & 3200 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 42.9 & 17.6 & 196 & 4700 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 36.7 & 18.8 & 187 & 3800 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 35.1 & 19.4 & 193 & 4200 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 38.6 & 17.0 & 188 & 2900 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 37.3 & 20.5 & 199 & 3775 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 35.7 & 17.0 & 189 & 3350 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 41.1 & 18.6 & 189 & 3325 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 36.2 & 17.2 & 187 & 3150 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 37.7 & 19.8 & 198 & 3500 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 40.2 & 17.0 & 176 & 3450 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 41.4 & 18.5 & 202 & 3875 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 35.2 & 15.9 & 186 & 3050 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 40.6 & 19.0 & 199 & 4000 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 38.8 & 17.6 & 191 & 3275 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 41.5 & 18.3 & 195 & 4300 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 39.0 & 17.1 & 191 & 3050 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 44.1 & 18.0 & 210 & 4000 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 38.5 & 17.9 & 190 & 3325 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 43.1 & 19.2 & 197 & 3500 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 52 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Adelie | Torgersen | 39.1 | 18.7 | 181 | 3750 | MALE   |\n",
       "| Adelie | Torgersen | 39.5 | 17.4 | 186 | 3800 | FEMALE |\n",
       "| Adelie | Torgersen | 40.3 | 18.0 | 195 | 3250 | FEMALE |\n",
       "| Adelie | Torgersen |   NA |   NA |  NA |   NA | NA     |\n",
       "| Adelie | Torgersen | 36.7 | 19.3 | 193 | 3450 | FEMALE |\n",
       "| Adelie | Torgersen | 39.3 | 20.6 | 190 | 3650 | MALE   |\n",
       "| Adelie | Torgersen | 38.9 | 17.8 | 181 | 3625 | FEMALE |\n",
       "| Adelie | Torgersen | 39.2 | 19.6 | 195 | 4675 | MALE   |\n",
       "| Adelie | Torgersen | 34.1 | 18.1 | 193 | 3475 | NA     |\n",
       "| Adelie | Torgersen | 42.0 | 20.2 | 190 | 4250 | NA     |\n",
       "| Adelie | Torgersen | 37.8 | 17.1 | 186 | 3300 | NA     |\n",
       "| Adelie | Torgersen | 37.8 | 17.3 | 180 | 3700 | NA     |\n",
       "| Adelie | Torgersen | 41.1 | 17.6 | 182 | 3200 | FEMALE |\n",
       "| Adelie | Torgersen | 38.6 | 21.2 | 191 | 3800 | MALE   |\n",
       "| Adelie | Torgersen | 34.6 | 21.1 | 198 | 4400 | MALE   |\n",
       "| Adelie | Torgersen | 36.6 | 17.8 | 185 | 3700 | FEMALE |\n",
       "| Adelie | Torgersen | 38.7 | 19.0 | 195 | 3450 | FEMALE |\n",
       "| Adelie | Torgersen | 42.5 | 20.7 | 197 | 4500 | MALE   |\n",
       "| Adelie | Torgersen | 34.4 | 18.4 | 184 | 3325 | FEMALE |\n",
       "| Adelie | Torgersen | 46.0 | 21.5 | 194 | 4200 | MALE   |\n",
       "| Adelie | Torgersen | 35.9 | 16.6 | 190 | 3050 | FEMALE |\n",
       "| Adelie | Torgersen | 41.8 | 19.4 | 198 | 4450 | MALE   |\n",
       "| Adelie | Torgersen | 33.5 | 19.0 | 190 | 3600 | FEMALE |\n",
       "| Adelie | Torgersen | 39.7 | 18.4 | 190 | 3900 | MALE   |\n",
       "| Adelie | Torgersen | 39.6 | 17.2 | 196 | 3550 | FEMALE |\n",
       "| Adelie | Torgersen | 45.8 | 18.9 | 197 | 4150 | MALE   |\n",
       "| Adelie | Torgersen | 35.5 | 17.5 | 190 | 3700 | FEMALE |\n",
       "| Adelie | Torgersen | 42.8 | 18.5 | 195 | 4250 | MALE   |\n",
       "| Adelie | Torgersen | 40.9 | 16.8 | 191 | 3700 | FEMALE |\n",
       "| Adelie | Torgersen | 37.2 | 19.4 | 184 | 3900 | MALE   |\n",
       "| Adelie | Torgersen | 36.2 | 16.1 | 187 | 3550 | FEMALE |\n",
       "| Adelie | Torgersen | 42.1 | 19.1 | 195 | 4000 | MALE   |\n",
       "| Adelie | Torgersen | 34.6 | 17.2 | 189 | 3200 | FEMALE |\n",
       "| Adelie | Torgersen | 42.9 | 17.6 | 196 | 4700 | MALE   |\n",
       "| Adelie | Torgersen | 36.7 | 18.8 | 187 | 3800 | FEMALE |\n",
       "| Adelie | Torgersen | 35.1 | 19.4 | 193 | 4200 | MALE   |\n",
       "| Adelie | Torgersen | 38.6 | 17.0 | 188 | 2900 | FEMALE |\n",
       "| Adelie | Torgersen | 37.3 | 20.5 | 199 | 3775 | MALE   |\n",
       "| Adelie | Torgersen | 35.7 | 17.0 | 189 | 3350 | FEMALE |\n",
       "| Adelie | Torgersen | 41.1 | 18.6 | 189 | 3325 | MALE   |\n",
       "| Adelie | Torgersen | 36.2 | 17.2 | 187 | 3150 | FEMALE |\n",
       "| Adelie | Torgersen | 37.7 | 19.8 | 198 | 3500 | MALE   |\n",
       "| Adelie | Torgersen | 40.2 | 17.0 | 176 | 3450 | FEMALE |\n",
       "| Adelie | Torgersen | 41.4 | 18.5 | 202 | 3875 | MALE   |\n",
       "| Adelie | Torgersen | 35.2 | 15.9 | 186 | 3050 | FEMALE |\n",
       "| Adelie | Torgersen | 40.6 | 19.0 | 199 | 4000 | MALE   |\n",
       "| Adelie | Torgersen | 38.8 | 17.6 | 191 | 3275 | FEMALE |\n",
       "| Adelie | Torgersen | 41.5 | 18.3 | 195 | 4300 | MALE   |\n",
       "| Adelie | Torgersen | 39.0 | 17.1 | 191 | 3050 | FEMALE |\n",
       "| Adelie | Torgersen | 44.1 | 18.0 | 210 | 4000 | MALE   |\n",
       "| Adelie | Torgersen | 38.5 | 17.9 | 190 | 3325 | FEMALE |\n",
       "| Adelie | Torgersen | 43.1 | 19.2 | 197 | 3500 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "   species island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1  Adelie  Torgersen 39.1             18.7            181              \n",
       "2  Adelie  Torgersen 39.5             17.4            186              \n",
       "3  Adelie  Torgersen 40.3             18.0            195              \n",
       "4  Adelie  Torgersen   NA               NA             NA              \n",
       "5  Adelie  Torgersen 36.7             19.3            193              \n",
       "6  Adelie  Torgersen 39.3             20.6            190              \n",
       "7  Adelie  Torgersen 38.9             17.8            181              \n",
       "8  Adelie  Torgersen 39.2             19.6            195              \n",
       "9  Adelie  Torgersen 34.1             18.1            193              \n",
       "10 Adelie  Torgersen 42.0             20.2            190              \n",
       "11 Adelie  Torgersen 37.8             17.1            186              \n",
       "12 Adelie  Torgersen 37.8             17.3            180              \n",
       "13 Adelie  Torgersen 41.1             17.6            182              \n",
       "14 Adelie  Torgersen 38.6             21.2            191              \n",
       "15 Adelie  Torgersen 34.6             21.1            198              \n",
       "16 Adelie  Torgersen 36.6             17.8            185              \n",
       "17 Adelie  Torgersen 38.7             19.0            195              \n",
       "18 Adelie  Torgersen 42.5             20.7            197              \n",
       "19 Adelie  Torgersen 34.4             18.4            184              \n",
       "20 Adelie  Torgersen 46.0             21.5            194              \n",
       "21 Adelie  Torgersen 35.9             16.6            190              \n",
       "22 Adelie  Torgersen 41.8             19.4            198              \n",
       "23 Adelie  Torgersen 33.5             19.0            190              \n",
       "24 Adelie  Torgersen 39.7             18.4            190              \n",
       "25 Adelie  Torgersen 39.6             17.2            196              \n",
       "26 Adelie  Torgersen 45.8             18.9            197              \n",
       "27 Adelie  Torgersen 35.5             17.5            190              \n",
       "28 Adelie  Torgersen 42.8             18.5            195              \n",
       "29 Adelie  Torgersen 40.9             16.8            191              \n",
       "30 Adelie  Torgersen 37.2             19.4            184              \n",
       "31 Adelie  Torgersen 36.2             16.1            187              \n",
       "32 Adelie  Torgersen 42.1             19.1            195              \n",
       "33 Adelie  Torgersen 34.6             17.2            189              \n",
       "34 Adelie  Torgersen 42.9             17.6            196              \n",
       "35 Adelie  Torgersen 36.7             18.8            187              \n",
       "36 Adelie  Torgersen 35.1             19.4            193              \n",
       "37 Adelie  Torgersen 38.6             17.0            188              \n",
       "38 Adelie  Torgersen 37.3             20.5            199              \n",
       "39 Adelie  Torgersen 35.7             17.0            189              \n",
       "40 Adelie  Torgersen 41.1             18.6            189              \n",
       "41 Adelie  Torgersen 36.2             17.2            187              \n",
       "42 Adelie  Torgersen 37.7             19.8            198              \n",
       "43 Adelie  Torgersen 40.2             17.0            176              \n",
       "44 Adelie  Torgersen 41.4             18.5            202              \n",
       "45 Adelie  Torgersen 35.2             15.9            186              \n",
       "46 Adelie  Torgersen 40.6             19.0            199              \n",
       "47 Adelie  Torgersen 38.8             17.6            191              \n",
       "48 Adelie  Torgersen 41.5             18.3            195              \n",
       "49 Adelie  Torgersen 39.0             17.1            191              \n",
       "50 Adelie  Torgersen 44.1             18.0            210              \n",
       "51 Adelie  Torgersen 38.5             17.9            190              \n",
       "52 Adelie  Torgersen 43.1             19.2            197              \n",
       "   body_mass_g sex   \n",
       "1  3750        MALE  \n",
       "2  3800        FEMALE\n",
       "3  3250        FEMALE\n",
       "4    NA        NA    \n",
       "5  3450        FEMALE\n",
       "6  3650        MALE  \n",
       "7  3625        FEMALE\n",
       "8  4675        MALE  \n",
       "9  3475        NA    \n",
       "10 4250        NA    \n",
       "11 3300        NA    \n",
       "12 3700        NA    \n",
       "13 3200        FEMALE\n",
       "14 3800        MALE  \n",
       "15 4400        MALE  \n",
       "16 3700        FEMALE\n",
       "17 3450        FEMALE\n",
       "18 4500        MALE  \n",
       "19 3325        FEMALE\n",
       "20 4200        MALE  \n",
       "21 3050        FEMALE\n",
       "22 4450        MALE  \n",
       "23 3600        FEMALE\n",
       "24 3900        MALE  \n",
       "25 3550        FEMALE\n",
       "26 4150        MALE  \n",
       "27 3700        FEMALE\n",
       "28 4250        MALE  \n",
       "29 3700        FEMALE\n",
       "30 3900        MALE  \n",
       "31 3550        FEMALE\n",
       "32 4000        MALE  \n",
       "33 3200        FEMALE\n",
       "34 4700        MALE  \n",
       "35 3800        FEMALE\n",
       "36 4200        MALE  \n",
       "37 2900        FEMALE\n",
       "38 3775        MALE  \n",
       "39 3350        FEMALE\n",
       "40 3325        MALE  \n",
       "41 3150        FEMALE\n",
       "42 3500        MALE  \n",
       "43 3450        FEMALE\n",
       "44 3875        MALE  \n",
       "45 3050        FEMALE\n",
       "46 4000        MALE  \n",
       "47 3275        FEMALE\n",
       "48 4300        MALE  \n",
       "49 3050        FEMALE\n",
       "50 4000        MALE  \n",
       "51 3325        FEMALE\n",
       "52 3500        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "penguins %>%\n",
    "  filter(island == \"Torgersen\")"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.02412,
     "end_time": "2021-12-29T06:18:37.793128",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.769008",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Wait what the heck is %>%?\n",
    "\n",
    "`%>%` is the pipe operator, and it allows us to push our data through sequential functions in R. Much like we use the words \"and then\" to describe instructions or steps on how to do something, `%>%` acts like an \"and then\" statement between functions.  \n",
    "\n",
    "We can take the code we wrote above _and then_ add a function we've already used, `head()` to print out a much shorter table, like this:"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:37.848351Z",
     "iopub.status.busy": "2021-12-29T06:18:37.846979Z",
     "iopub.status.idle": "2021-12-29T06:18:37.871482Z",
     "shell.execute_reply": "2021-12-29T06:18:37.870355Z"
    },
    "papermill": {
     "duration": 0.053771,
     "end_time": "2021-12-29T06:18:37.871687",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.817916",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.1</td><td>18.7</td><td>181</td><td>3750</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.5</td><td>17.4</td><td>186</td><td>3800</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>40.3</td><td>18.0</td><td>195</td><td>3250</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>  NA</td><td>  NA</td><td> NA</td><td>  NA</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>36.7</td><td>19.3</td><td>193</td><td>3450</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.3</td><td>20.6</td><td>190</td><td>3650</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie & Torgersen & 39.1 & 18.7 & 181 & 3750 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 39.5 & 17.4 & 186 & 3800 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 40.3 & 18.0 & 195 & 3250 & FEMALE\\\\\n",
       "\t Adelie & Torgersen &   NA &   NA &  NA &   NA & NA    \\\\\n",
       "\t Adelie & Torgersen & 36.7 & 19.3 & 193 & 3450 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 39.3 & 20.6 & 190 & 3650 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Adelie | Torgersen | 39.1 | 18.7 | 181 | 3750 | MALE   |\n",
       "| Adelie | Torgersen | 39.5 | 17.4 | 186 | 3800 | FEMALE |\n",
       "| Adelie | Torgersen | 40.3 | 18.0 | 195 | 3250 | FEMALE |\n",
       "| Adelie | Torgersen |   NA |   NA |  NA |   NA | NA     |\n",
       "| Adelie | Torgersen | 36.7 | 19.3 | 193 | 3450 | FEMALE |\n",
       "| Adelie | Torgersen | 39.3 | 20.6 | 190 | 3650 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "  species island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1 Adelie  Torgersen 39.1             18.7            181              \n",
       "2 Adelie  Torgersen 39.5             17.4            186              \n",
       "3 Adelie  Torgersen 40.3             18.0            195              \n",
       "4 Adelie  Torgersen   NA               NA             NA              \n",
       "5 Adelie  Torgersen 36.7             19.3            193              \n",
       "6 Adelie  Torgersen 39.3             20.6            190              \n",
       "  body_mass_g sex   \n",
       "1 3750        MALE  \n",
       "2 3800        FEMALE\n",
       "3 3250        FEMALE\n",
       "4   NA        NA    \n",
       "5 3450        FEMALE\n",
       "6 3650        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "penguins %>%\n",
    "  filter(island == \"Torgersen\") %>%\n",
    "  head()"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.02479,
     "end_time": "2021-12-29T06:18:37.923090",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.898300",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "So let's get to it! In this section we'll go through a couple of examples with each of the individual `dplyr` functions, and then start combining them to do some powerful data manipulations!"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.025331,
     "end_time": "2021-12-29T06:18:37.974336",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.949005",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Applying arrange()\n",
    "\n",
    "`arrange()` \"arranges,\" or organizes, our data in _ascending_ order, starting from the lowest value and running to the highest (or in the case of character data, in alphabetical order).  \n",
    "\n",
    "We can provide a single argument to the `arrange()` function, such as `culmen_length_mm` (double) or `species` (character)."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:38.032239Z",
     "iopub.status.busy": "2021-12-29T06:18:38.030849Z",
     "iopub.status.idle": "2021-12-29T06:18:38.070350Z",
     "shell.execute_reply": "2021-12-29T06:18:38.069087Z"
    },
    "papermill": {
     "duration": 0.070715,
     "end_time": "2021-12-29T06:18:38.070509",
     "exception": false,
     "start_time": "2021-12-29T06:18:37.999794",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 6 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie</td><td>Dream    </td><td>32.1</td><td>15.5</td><td>188</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Dream    </td><td>33.1</td><td>16.1</td><td>178</td><td>2900</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>33.5</td><td>19.0</td><td>190</td><td>3600</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Dream    </td><td>34.0</td><td>17.1</td><td>185</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>34.1</td><td>18.1</td><td>193</td><td>3475</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>34.4</td><td>18.4</td><td>184</td><td>3325</td><td>FEMALE</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 6 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie & Dream     & 32.1 & 15.5 & 188 & 3050 & FEMALE\\\\\n",
       "\t Adelie & Dream     & 33.1 & 16.1 & 178 & 2900 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 33.5 & 19.0 & 190 & 3600 & FEMALE\\\\\n",
       "\t Adelie & Dream     & 34.0 & 17.1 & 185 & 3400 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 34.1 & 18.1 & 193 & 3475 & NA    \\\\\n",
       "\t Adelie & Torgersen & 34.4 & 18.4 & 184 & 3325 & FEMALE\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 6 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Adelie | Dream     | 32.1 | 15.5 | 188 | 3050 | FEMALE |\n",
       "| Adelie | Dream     | 33.1 | 16.1 | 178 | 2900 | FEMALE |\n",
       "| Adelie | Torgersen | 33.5 | 19.0 | 190 | 3600 | FEMALE |\n",
       "| Adelie | Dream     | 34.0 | 17.1 | 185 | 3400 | FEMALE |\n",
       "| Adelie | Torgersen | 34.1 | 18.1 | 193 | 3475 | NA     |\n",
       "| Adelie | Torgersen | 34.4 | 18.4 | 184 | 3325 | FEMALE |\n",
       "\n"
      ],
      "text/plain": [
       "  species island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1 Adelie  Dream     32.1             15.5            188              \n",
       "2 Adelie  Dream     33.1             16.1            178              \n",
       "3 Adelie  Torgersen 33.5             19.0            190              \n",
       "4 Adelie  Dream     34.0             17.1            185              \n",
       "5 Adelie  Torgersen 34.1             18.1            193              \n",
       "6 Adelie  Torgersen 34.4             18.4            184              \n",
       "  body_mass_g sex   \n",
       "1 3050        FEMALE\n",
       "2 2900        FEMALE\n",
       "3 3600        FEMALE\n",
       "4 3400        FEMALE\n",
       "5 3475        NA    \n",
       "6 3325        FEMALE"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# numeric data \n",
    "# I've added the head() function to the end of the function chain to reduce the length of the table that's printed out\n",
    "# you can remove it in your version!\n",
    "\n",
    "penguins %>%\n",
    "  arrange(culmen_length_mm) %>%\n",
    "  head()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:38.129502Z",
     "iopub.status.busy": "2021-12-29T06:18:38.128057Z",
     "iopub.status.idle": "2021-12-29T06:18:38.209190Z",
     "shell.execute_reply": "2021-12-29T06:18:38.207932Z"
    },
    "papermill": {
     "duration": 0.112002,
     "end_time": "2021-12-29T06:18:38.209506",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.097504",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 344 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.1</td><td>18.7</td><td>181</td><td>3750</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.5</td><td>17.4</td><td>186</td><td>3800</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>40.3</td><td>18.0</td><td>195</td><td>3250</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>  NA</td><td>  NA</td><td> NA</td><td>  NA</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>36.7</td><td>19.3</td><td>193</td><td>3450</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.3</td><td>20.6</td><td>190</td><td>3650</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>38.9</td><td>17.8</td><td>181</td><td>3625</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>39.2</td><td>19.6</td><td>195</td><td>4675</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>34.1</td><td>18.1</td><td>193</td><td>3475</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>42.0</td><td>20.2</td><td>190</td><td>4250</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>37.8</td><td>17.1</td><td>186</td><td>3300</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>37.8</td><td>17.3</td><td>180</td><td>3700</td><td>NA    </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>41.1</td><td>17.6</td><td>182</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>38.6</td><td>21.2</td><td>191</td><td>3800</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>34.6</td><td>21.1</td><td>198</td><td>4400</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>36.6</td><td>17.8</td><td>185</td><td>3700</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>38.7</td><td>19.0</td><td>195</td><td>3450</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>42.5</td><td>20.7</td><td>197</td><td>4500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>34.4</td><td>18.4</td><td>184</td><td>3325</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Torgersen</td><td>46.0</td><td>21.5</td><td>194</td><td>4200</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>37.8</td><td>18.3</td><td>174</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>37.7</td><td>18.7</td><td>180</td><td>3600</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>35.9</td><td>19.2</td><td>189</td><td>3800</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>38.2</td><td>18.1</td><td>185</td><td>3950</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>38.8</td><td>17.2</td><td>180</td><td>3800</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>35.3</td><td>18.9</td><td>187</td><td>3800</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>40.6</td><td>18.6</td><td>183</td><td>3550</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>40.5</td><td>17.9</td><td>187</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>37.9</td><td>18.6</td><td>172</td><td>3150</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie</td><td>Biscoe   </td><td>40.5</td><td>18.9</td><td>180</td><td>3950</td><td>MALE  </td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>44.5</td><td>14.7</td><td>214</td><td>4850</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>50.8</td><td>15.7</td><td>226</td><td>5200</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>49.4</td><td>15.8</td><td>216</td><td>4925</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>46.9</td><td>14.6</td><td>222</td><td>4875</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>48.4</td><td>14.4</td><td>203</td><td>4625</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>51.1</td><td>16.5</td><td>225</td><td>5250</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>48.5</td><td>15.0</td><td>219</td><td>4850</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>55.9</td><td>17.0</td><td>228</td><td>5600</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>47.2</td><td>15.5</td><td>215</td><td>4975</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>49.1</td><td>15.0</td><td>228</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>47.3</td><td>13.8</td><td>216</td><td>4725</td><td>NA    </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>46.8</td><td>16.1</td><td>215</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>41.7</td><td>14.7</td><td>210</td><td>4700</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>53.4</td><td>15.8</td><td>219</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>43.3</td><td>14.0</td><td>208</td><td>4575</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>48.1</td><td>15.1</td><td>209</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>50.5</td><td>15.2</td><td>216</td><td>5000</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>49.8</td><td>15.9</td><td>229</td><td>5950</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>43.5</td><td>15.2</td><td>213</td><td>4650</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>51.5</td><td>16.3</td><td>230</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>46.2</td><td>14.1</td><td>217</td><td>4375</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>55.1</td><td>16.0</td><td>230</td><td>5850</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>44.5</td><td>15.7</td><td>217</td><td>4875</td><td>.     </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>48.8</td><td>16.2</td><td>222</td><td>6000</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>47.2</td><td>13.7</td><td>214</td><td>4925</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>  NA</td><td>  NA</td><td> NA</td><td>  NA</td><td>NA    </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>46.8</td><td>14.3</td><td>215</td><td>4850</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>50.4</td><td>15.7</td><td>222</td><td>5750</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>45.2</td><td>14.8</td><td>212</td><td>5200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo</td><td>Biscoe</td><td>49.9</td><td>16.1</td><td>213</td><td>5400</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 344 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie & Torgersen & 39.1 & 18.7 & 181 & 3750 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 39.5 & 17.4 & 186 & 3800 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 40.3 & 18.0 & 195 & 3250 & FEMALE\\\\\n",
       "\t Adelie & Torgersen &   NA &   NA &  NA &   NA & NA    \\\\\n",
       "\t Adelie & Torgersen & 36.7 & 19.3 & 193 & 3450 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 39.3 & 20.6 & 190 & 3650 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 38.9 & 17.8 & 181 & 3625 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 39.2 & 19.6 & 195 & 4675 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 34.1 & 18.1 & 193 & 3475 & NA    \\\\\n",
       "\t Adelie & Torgersen & 42.0 & 20.2 & 190 & 4250 & NA    \\\\\n",
       "\t Adelie & Torgersen & 37.8 & 17.1 & 186 & 3300 & NA    \\\\\n",
       "\t Adelie & Torgersen & 37.8 & 17.3 & 180 & 3700 & NA    \\\\\n",
       "\t Adelie & Torgersen & 41.1 & 17.6 & 182 & 3200 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 38.6 & 21.2 & 191 & 3800 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 34.6 & 21.1 & 198 & 4400 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 36.6 & 17.8 & 185 & 3700 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 38.7 & 19.0 & 195 & 3450 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 42.5 & 20.7 & 197 & 4500 & MALE  \\\\\n",
       "\t Adelie & Torgersen & 34.4 & 18.4 & 184 & 3325 & FEMALE\\\\\n",
       "\t Adelie & Torgersen & 46.0 & 21.5 & 194 & 4200 & MALE  \\\\\n",
       "\t Adelie & Biscoe    & 37.8 & 18.3 & 174 & 3400 & FEMALE\\\\\n",
       "\t Adelie & Biscoe    & 37.7 & 18.7 & 180 & 3600 & MALE  \\\\\n",
       "\t Adelie & Biscoe    & 35.9 & 19.2 & 189 & 3800 & FEMALE\\\\\n",
       "\t Adelie & Biscoe    & 38.2 & 18.1 & 185 & 3950 & MALE  \\\\\n",
       "\t Adelie & Biscoe    & 38.8 & 17.2 & 180 & 3800 & MALE  \\\\\n",
       "\t Adelie & Biscoe    & 35.3 & 18.9 & 187 & 3800 & FEMALE\\\\\n",
       "\t Adelie & Biscoe    & 40.6 & 18.6 & 183 & 3550 & MALE  \\\\\n",
       "\t Adelie & Biscoe    & 40.5 & 17.9 & 187 & 3200 & FEMALE\\\\\n",
       "\t Adelie & Biscoe    & 37.9 & 18.6 & 172 & 3150 & FEMALE\\\\\n",
       "\t Adelie & Biscoe    & 40.5 & 18.9 & 180 & 3950 & MALE  \\\\\n",
       "\t ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮\\\\\n",
       "\t Gentoo & Biscoe & 44.5 & 14.7 & 214 & 4850 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 50.8 & 15.7 & 226 & 5200 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 49.4 & 15.8 & 216 & 4925 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 46.9 & 14.6 & 222 & 4875 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 48.4 & 14.4 & 203 & 4625 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 51.1 & 16.5 & 225 & 5250 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 48.5 & 15.0 & 219 & 4850 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 55.9 & 17.0 & 228 & 5600 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 47.2 & 15.5 & 215 & 4975 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 49.1 & 15.0 & 228 & 5500 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 47.3 & 13.8 & 216 & 4725 & NA    \\\\\n",
       "\t Gentoo & Biscoe & 46.8 & 16.1 & 215 & 5500 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 41.7 & 14.7 & 210 & 4700 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 53.4 & 15.8 & 219 & 5500 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 43.3 & 14.0 & 208 & 4575 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 48.1 & 15.1 & 209 & 5500 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 50.5 & 15.2 & 216 & 5000 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 49.8 & 15.9 & 229 & 5950 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 43.5 & 15.2 & 213 & 4650 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 51.5 & 16.3 & 230 & 5500 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 46.2 & 14.1 & 217 & 4375 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 55.1 & 16.0 & 230 & 5850 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 44.5 & 15.7 & 217 & 4875 & .     \\\\\n",
       "\t Gentoo & Biscoe & 48.8 & 16.2 & 222 & 6000 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 47.2 & 13.7 & 214 & 4925 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe &   NA &   NA &  NA &   NA & NA    \\\\\n",
       "\t Gentoo & Biscoe & 46.8 & 14.3 & 215 & 4850 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 50.4 & 15.7 & 222 & 5750 & MALE  \\\\\n",
       "\t Gentoo & Biscoe & 45.2 & 14.8 & 212 & 5200 & FEMALE\\\\\n",
       "\t Gentoo & Biscoe & 49.9 & 16.1 & 213 & 5400 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 344 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Adelie | Torgersen | 39.1 | 18.7 | 181 | 3750 | MALE   |\n",
       "| Adelie | Torgersen | 39.5 | 17.4 | 186 | 3800 | FEMALE |\n",
       "| Adelie | Torgersen | 40.3 | 18.0 | 195 | 3250 | FEMALE |\n",
       "| Adelie | Torgersen |   NA |   NA |  NA |   NA | NA     |\n",
       "| Adelie | Torgersen | 36.7 | 19.3 | 193 | 3450 | FEMALE |\n",
       "| Adelie | Torgersen | 39.3 | 20.6 | 190 | 3650 | MALE   |\n",
       "| Adelie | Torgersen | 38.9 | 17.8 | 181 | 3625 | FEMALE |\n",
       "| Adelie | Torgersen | 39.2 | 19.6 | 195 | 4675 | MALE   |\n",
       "| Adelie | Torgersen | 34.1 | 18.1 | 193 | 3475 | NA     |\n",
       "| Adelie | Torgersen | 42.0 | 20.2 | 190 | 4250 | NA     |\n",
       "| Adelie | Torgersen | 37.8 | 17.1 | 186 | 3300 | NA     |\n",
       "| Adelie | Torgersen | 37.8 | 17.3 | 180 | 3700 | NA     |\n",
       "| Adelie | Torgersen | 41.1 | 17.6 | 182 | 3200 | FEMALE |\n",
       "| Adelie | Torgersen | 38.6 | 21.2 | 191 | 3800 | MALE   |\n",
       "| Adelie | Torgersen | 34.6 | 21.1 | 198 | 4400 | MALE   |\n",
       "| Adelie | Torgersen | 36.6 | 17.8 | 185 | 3700 | FEMALE |\n",
       "| Adelie | Torgersen | 38.7 | 19.0 | 195 | 3450 | FEMALE |\n",
       "| Adelie | Torgersen | 42.5 | 20.7 | 197 | 4500 | MALE   |\n",
       "| Adelie | Torgersen | 34.4 | 18.4 | 184 | 3325 | FEMALE |\n",
       "| Adelie | Torgersen | 46.0 | 21.5 | 194 | 4200 | MALE   |\n",
       "| Adelie | Biscoe    | 37.8 | 18.3 | 174 | 3400 | FEMALE |\n",
       "| Adelie | Biscoe    | 37.7 | 18.7 | 180 | 3600 | MALE   |\n",
       "| Adelie | Biscoe    | 35.9 | 19.2 | 189 | 3800 | FEMALE |\n",
       "| Adelie | Biscoe    | 38.2 | 18.1 | 185 | 3950 | MALE   |\n",
       "| Adelie | Biscoe    | 38.8 | 17.2 | 180 | 3800 | MALE   |\n",
       "| Adelie | Biscoe    | 35.3 | 18.9 | 187 | 3800 | FEMALE |\n",
       "| Adelie | Biscoe    | 40.6 | 18.6 | 183 | 3550 | MALE   |\n",
       "| Adelie | Biscoe    | 40.5 | 17.9 | 187 | 3200 | FEMALE |\n",
       "| Adelie | Biscoe    | 37.9 | 18.6 | 172 | 3150 | FEMALE |\n",
       "| Adelie | Biscoe    | 40.5 | 18.9 | 180 | 3950 | MALE   |\n",
       "| ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ |\n",
       "| Gentoo | Biscoe | 44.5 | 14.7 | 214 | 4850 | FEMALE |\n",
       "| Gentoo | Biscoe | 50.8 | 15.7 | 226 | 5200 | MALE   |\n",
       "| Gentoo | Biscoe | 49.4 | 15.8 | 216 | 4925 | MALE   |\n",
       "| Gentoo | Biscoe | 46.9 | 14.6 | 222 | 4875 | FEMALE |\n",
       "| Gentoo | Biscoe | 48.4 | 14.4 | 203 | 4625 | FEMALE |\n",
       "| Gentoo | Biscoe | 51.1 | 16.5 | 225 | 5250 | MALE   |\n",
       "| Gentoo | Biscoe | 48.5 | 15.0 | 219 | 4850 | FEMALE |\n",
       "| Gentoo | Biscoe | 55.9 | 17.0 | 228 | 5600 | MALE   |\n",
       "| Gentoo | Biscoe | 47.2 | 15.5 | 215 | 4975 | FEMALE |\n",
       "| Gentoo | Biscoe | 49.1 | 15.0 | 228 | 5500 | MALE   |\n",
       "| Gentoo | Biscoe | 47.3 | 13.8 | 216 | 4725 | NA     |\n",
       "| Gentoo | Biscoe | 46.8 | 16.1 | 215 | 5500 | MALE   |\n",
       "| Gentoo | Biscoe | 41.7 | 14.7 | 210 | 4700 | FEMALE |\n",
       "| Gentoo | Biscoe | 53.4 | 15.8 | 219 | 5500 | MALE   |\n",
       "| Gentoo | Biscoe | 43.3 | 14.0 | 208 | 4575 | FEMALE |\n",
       "| Gentoo | Biscoe | 48.1 | 15.1 | 209 | 5500 | MALE   |\n",
       "| Gentoo | Biscoe | 50.5 | 15.2 | 216 | 5000 | FEMALE |\n",
       "| Gentoo | Biscoe | 49.8 | 15.9 | 229 | 5950 | MALE   |\n",
       "| Gentoo | Biscoe | 43.5 | 15.2 | 213 | 4650 | FEMALE |\n",
       "| Gentoo | Biscoe | 51.5 | 16.3 | 230 | 5500 | MALE   |\n",
       "| Gentoo | Biscoe | 46.2 | 14.1 | 217 | 4375 | FEMALE |\n",
       "| Gentoo | Biscoe | 55.1 | 16.0 | 230 | 5850 | MALE   |\n",
       "| Gentoo | Biscoe | 44.5 | 15.7 | 217 | 4875 | .      |\n",
       "| Gentoo | Biscoe | 48.8 | 16.2 | 222 | 6000 | MALE   |\n",
       "| Gentoo | Biscoe | 47.2 | 13.7 | 214 | 4925 | FEMALE |\n",
       "| Gentoo | Biscoe |   NA |   NA |  NA |   NA | NA     |\n",
       "| Gentoo | Biscoe | 46.8 | 14.3 | 215 | 4850 | FEMALE |\n",
       "| Gentoo | Biscoe | 50.4 | 15.7 | 222 | 5750 | MALE   |\n",
       "| Gentoo | Biscoe | 45.2 | 14.8 | 212 | 5200 | FEMALE |\n",
       "| Gentoo | Biscoe | 49.9 | 16.1 | 213 | 5400 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "    species island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1   Adelie  Torgersen 39.1             18.7            181              \n",
       "2   Adelie  Torgersen 39.5             17.4            186              \n",
       "3   Adelie  Torgersen 40.3             18.0            195              \n",
       "4   Adelie  Torgersen   NA               NA             NA              \n",
       "5   Adelie  Torgersen 36.7             19.3            193              \n",
       "6   Adelie  Torgersen 39.3             20.6            190              \n",
       "7   Adelie  Torgersen 38.9             17.8            181              \n",
       "8   Adelie  Torgersen 39.2             19.6            195              \n",
       "9   Adelie  Torgersen 34.1             18.1            193              \n",
       "10  Adelie  Torgersen 42.0             20.2            190              \n",
       "11  Adelie  Torgersen 37.8             17.1            186              \n",
       "12  Adelie  Torgersen 37.8             17.3            180              \n",
       "13  Adelie  Torgersen 41.1             17.6            182              \n",
       "14  Adelie  Torgersen 38.6             21.2            191              \n",
       "15  Adelie  Torgersen 34.6             21.1            198              \n",
       "16  Adelie  Torgersen 36.6             17.8            185              \n",
       "17  Adelie  Torgersen 38.7             19.0            195              \n",
       "18  Adelie  Torgersen 42.5             20.7            197              \n",
       "19  Adelie  Torgersen 34.4             18.4            184              \n",
       "20  Adelie  Torgersen 46.0             21.5            194              \n",
       "21  Adelie  Biscoe    37.8             18.3            174              \n",
       "22  Adelie  Biscoe    37.7             18.7            180              \n",
       "23  Adelie  Biscoe    35.9             19.2            189              \n",
       "24  Adelie  Biscoe    38.2             18.1            185              \n",
       "25  Adelie  Biscoe    38.8             17.2            180              \n",
       "26  Adelie  Biscoe    35.3             18.9            187              \n",
       "27  Adelie  Biscoe    40.6             18.6            183              \n",
       "28  Adelie  Biscoe    40.5             17.9            187              \n",
       "29  Adelie  Biscoe    37.9             18.6            172              \n",
       "30  Adelie  Biscoe    40.5             18.9            180              \n",
       "⋮   ⋮       ⋮         ⋮                ⋮               ⋮                \n",
       "315 Gentoo  Biscoe    44.5             14.7            214              \n",
       "316 Gentoo  Biscoe    50.8             15.7            226              \n",
       "317 Gentoo  Biscoe    49.4             15.8            216              \n",
       "318 Gentoo  Biscoe    46.9             14.6            222              \n",
       "319 Gentoo  Biscoe    48.4             14.4            203              \n",
       "320 Gentoo  Biscoe    51.1             16.5            225              \n",
       "321 Gentoo  Biscoe    48.5             15.0            219              \n",
       "322 Gentoo  Biscoe    55.9             17.0            228              \n",
       "323 Gentoo  Biscoe    47.2             15.5            215              \n",
       "324 Gentoo  Biscoe    49.1             15.0            228              \n",
       "325 Gentoo  Biscoe    47.3             13.8            216              \n",
       "326 Gentoo  Biscoe    46.8             16.1            215              \n",
       "327 Gentoo  Biscoe    41.7             14.7            210              \n",
       "328 Gentoo  Biscoe    53.4             15.8            219              \n",
       "329 Gentoo  Biscoe    43.3             14.0            208              \n",
       "330 Gentoo  Biscoe    48.1             15.1            209              \n",
       "331 Gentoo  Biscoe    50.5             15.2            216              \n",
       "332 Gentoo  Biscoe    49.8             15.9            229              \n",
       "333 Gentoo  Biscoe    43.5             15.2            213              \n",
       "334 Gentoo  Biscoe    51.5             16.3            230              \n",
       "335 Gentoo  Biscoe    46.2             14.1            217              \n",
       "336 Gentoo  Biscoe    55.1             16.0            230              \n",
       "337 Gentoo  Biscoe    44.5             15.7            217              \n",
       "338 Gentoo  Biscoe    48.8             16.2            222              \n",
       "339 Gentoo  Biscoe    47.2             13.7            214              \n",
       "340 Gentoo  Biscoe      NA               NA             NA              \n",
       "341 Gentoo  Biscoe    46.8             14.3            215              \n",
       "342 Gentoo  Biscoe    50.4             15.7            222              \n",
       "343 Gentoo  Biscoe    45.2             14.8            212              \n",
       "344 Gentoo  Biscoe    49.9             16.1            213              \n",
       "    body_mass_g sex   \n",
       "1   3750        MALE  \n",
       "2   3800        FEMALE\n",
       "3   3250        FEMALE\n",
       "4     NA        NA    \n",
       "5   3450        FEMALE\n",
       "6   3650        MALE  \n",
       "7   3625        FEMALE\n",
       "8   4675        MALE  \n",
       "9   3475        NA    \n",
       "10  4250        NA    \n",
       "11  3300        NA    \n",
       "12  3700        NA    \n",
       "13  3200        FEMALE\n",
       "14  3800        MALE  \n",
       "15  4400        MALE  \n",
       "16  3700        FEMALE\n",
       "17  3450        FEMALE\n",
       "18  4500        MALE  \n",
       "19  3325        FEMALE\n",
       "20  4200        MALE  \n",
       "21  3400        FEMALE\n",
       "22  3600        MALE  \n",
       "23  3800        FEMALE\n",
       "24  3950        MALE  \n",
       "25  3800        MALE  \n",
       "26  3800        FEMALE\n",
       "27  3550        MALE  \n",
       "28  3200        FEMALE\n",
       "29  3150        FEMALE\n",
       "30  3950        MALE  \n",
       "⋮   ⋮           ⋮     \n",
       "315 4850        FEMALE\n",
       "316 5200        MALE  \n",
       "317 4925        MALE  \n",
       "318 4875        FEMALE\n",
       "319 4625        FEMALE\n",
       "320 5250        MALE  \n",
       "321 4850        FEMALE\n",
       "322 5600        MALE  \n",
       "323 4975        FEMALE\n",
       "324 5500        MALE  \n",
       "325 4725        NA    \n",
       "326 5500        MALE  \n",
       "327 4700        FEMALE\n",
       "328 5500        MALE  \n",
       "329 4575        FEMALE\n",
       "330 5500        MALE  \n",
       "331 5000        FEMALE\n",
       "332 5950        MALE  \n",
       "333 4650        FEMALE\n",
       "334 5500        MALE  \n",
       "335 4375        FEMALE\n",
       "336 5850        MALE  \n",
       "337 4875        .     \n",
       "338 6000        MALE  \n",
       "339 4925        FEMALE\n",
       "340   NA        NA    \n",
       "341 4850        FEMALE\n",
       "342 5750        MALE  \n",
       "343 5200        FEMALE\n",
       "344 5400        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# character data\n",
    "\n",
    "penguins %>%\n",
    "  arrange(species)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.026023,
     "end_time": "2021-12-29T06:18:38.262191",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.236168",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Creating a subset\n",
    "\n",
    "It's a little hard to see what's going on in the above table, so I'm going to create a smaller subset of the `penguins` dataset so that we can see what's going on a bit more clearly. You can run the code on the subset of the data, or replace `penguins_subset` with `penguins` to see what happens on the full dataset!"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:38.318637Z",
     "iopub.status.busy": "2021-12-29T06:18:38.317353Z",
     "iopub.status.idle": "2021-12-29T06:18:38.348295Z",
     "shell.execute_reply": "2021-12-29T06:18:38.347047Z"
    },
    "papermill": {
     "duration": 0.060376,
     "end_time": "2021-12-29T06:18:38.348428",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.288052",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 12 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>41.4</td><td>18.5</td><td>202</td><td>3875</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>50.1</td><td>17.9</td><td>190</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>50.5</td><td>15.9</td><td>222</td><td>5550</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>49.0</td><td>19.6</td><td>212</td><td>4300</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>43.5</td><td>18.1</td><td>202</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>51.5</td><td>16.3</td><td>230</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>40.5</td><td>17.9</td><td>187</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>43.5</td><td>15.2</td><td>213</td><td>4650</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream    </td><td>36.3</td><td>19.5</td><td>190</td><td>3800</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>39.0</td><td>17.1</td><td>191</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>41.6</td><td>18.0</td><td>192</td><td>3950</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>47.6</td><td>14.5</td><td>215</td><td>5400</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 12 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie    & Torgersen & 41.4 & 18.5 & 202 & 3875 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 50.1 & 17.9 & 190 & 3400 & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & 50.5 & 15.9 & 222 & 5550 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 49.0 & 19.6 & 212 & 4300 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 43.5 & 18.1 & 202 & 3400 & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & 51.5 & 16.3 & 230 & 5500 & MALE  \\\\\n",
       "\t Adelie    & Biscoe    & 40.5 & 17.9 & 187 & 3200 & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & 43.5 & 15.2 & 213 & 4650 & FEMALE\\\\\n",
       "\t Adelie    & Dream     & 36.3 & 19.5 & 190 & 3800 & MALE  \\\\\n",
       "\t Adelie    & Torgersen & 39.0 & 17.1 & 191 & 3050 & FEMALE\\\\\n",
       "\t Adelie    & Biscoe    & 41.6 & 18.0 & 192 & 3950 & MALE  \\\\\n",
       "\t Gentoo    & Biscoe    & 47.6 & 14.5 & 215 & 5400 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 12 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Adelie    | Torgersen | 41.4 | 18.5 | 202 | 3875 | MALE   |\n",
       "| Chinstrap | Dream     | 50.1 | 17.9 | 190 | 3400 | FEMALE |\n",
       "| Gentoo    | Biscoe    | 50.5 | 15.9 | 222 | 5550 | MALE   |\n",
       "| Chinstrap | Dream     | 49.0 | 19.6 | 212 | 4300 | MALE   |\n",
       "| Chinstrap | Dream     | 43.5 | 18.1 | 202 | 3400 | FEMALE |\n",
       "| Gentoo    | Biscoe    | 51.5 | 16.3 | 230 | 5500 | MALE   |\n",
       "| Adelie    | Biscoe    | 40.5 | 17.9 | 187 | 3200 | FEMALE |\n",
       "| Gentoo    | Biscoe    | 43.5 | 15.2 | 213 | 4650 | FEMALE |\n",
       "| Adelie    | Dream     | 36.3 | 19.5 | 190 | 3800 | MALE   |\n",
       "| Adelie    | Torgersen | 39.0 | 17.1 | 191 | 3050 | FEMALE |\n",
       "| Adelie    | Biscoe    | 41.6 | 18.0 | 192 | 3950 | MALE   |\n",
       "| Gentoo    | Biscoe    | 47.6 | 14.5 | 215 | 5400 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "   species   island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1  Adelie    Torgersen 41.4             18.5            202              \n",
       "2  Chinstrap Dream     50.1             17.9            190              \n",
       "3  Gentoo    Biscoe    50.5             15.9            222              \n",
       "4  Chinstrap Dream     49.0             19.6            212              \n",
       "5  Chinstrap Dream     43.5             18.1            202              \n",
       "6  Gentoo    Biscoe    51.5             16.3            230              \n",
       "7  Adelie    Biscoe    40.5             17.9            187              \n",
       "8  Gentoo    Biscoe    43.5             15.2            213              \n",
       "9  Adelie    Dream     36.3             19.5            190              \n",
       "10 Adelie    Torgersen 39.0             17.1            191              \n",
       "11 Adelie    Biscoe    41.6             18.0            192              \n",
       "12 Gentoo    Biscoe    47.6             14.5            215              \n",
       "   body_mass_g sex   \n",
       "1  3875        MALE  \n",
       "2  3400        FEMALE\n",
       "3  5550        MALE  \n",
       "4  4300        MALE  \n",
       "5  3400        FEMALE\n",
       "6  5500        MALE  \n",
       "7  3200        FEMALE\n",
       "8  4650        FEMALE\n",
       "9  3800        MALE  \n",
       "10 3050        FEMALE\n",
       "11 3950        MALE  \n",
       "12 5400        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# creating a random subset of the penguins dataset\n",
    "set.seed(406)\n",
    "\n",
    "penguins_subset <- penguins %>%\n",
    "  sample_n(12)  # another dplyr function!\n",
    "\n",
    "penguins_subset"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:38.406796Z",
     "iopub.status.busy": "2021-12-29T06:18:38.405427Z",
     "iopub.status.idle": "2021-12-29T06:18:38.439413Z",
     "shell.execute_reply": "2021-12-29T06:18:38.438262Z"
    },
    "papermill": {
     "duration": 0.064502,
     "end_time": "2021-12-29T06:18:38.439540",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.375038",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 12 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>41.4</td><td>18.5</td><td>202</td><td>3875</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>40.5</td><td>17.9</td><td>187</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream    </td><td>36.3</td><td>19.5</td><td>190</td><td>3800</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>39.0</td><td>17.1</td><td>191</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>41.6</td><td>18.0</td><td>192</td><td>3950</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>50.1</td><td>17.9</td><td>190</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>49.0</td><td>19.6</td><td>212</td><td>4300</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>43.5</td><td>18.1</td><td>202</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>50.5</td><td>15.9</td><td>222</td><td>5550</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>51.5</td><td>16.3</td><td>230</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>43.5</td><td>15.2</td><td>213</td><td>4650</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>47.6</td><td>14.5</td><td>215</td><td>5400</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 12 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie    & Torgersen & 41.4 & 18.5 & 202 & 3875 & MALE  \\\\\n",
       "\t Adelie    & Biscoe    & 40.5 & 17.9 & 187 & 3200 & FEMALE\\\\\n",
       "\t Adelie    & Dream     & 36.3 & 19.5 & 190 & 3800 & MALE  \\\\\n",
       "\t Adelie    & Torgersen & 39.0 & 17.1 & 191 & 3050 & FEMALE\\\\\n",
       "\t Adelie    & Biscoe    & 41.6 & 18.0 & 192 & 3950 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 50.1 & 17.9 & 190 & 3400 & FEMALE\\\\\n",
       "\t Chinstrap & Dream     & 49.0 & 19.6 & 212 & 4300 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 43.5 & 18.1 & 202 & 3400 & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & 50.5 & 15.9 & 222 & 5550 & MALE  \\\\\n",
       "\t Gentoo    & Biscoe    & 51.5 & 16.3 & 230 & 5500 & MALE  \\\\\n",
       "\t Gentoo    & Biscoe    & 43.5 & 15.2 & 213 & 4650 & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & 47.6 & 14.5 & 215 & 5400 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 12 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Adelie    | Torgersen | 41.4 | 18.5 | 202 | 3875 | MALE   |\n",
       "| Adelie    | Biscoe    | 40.5 | 17.9 | 187 | 3200 | FEMALE |\n",
       "| Adelie    | Dream     | 36.3 | 19.5 | 190 | 3800 | MALE   |\n",
       "| Adelie    | Torgersen | 39.0 | 17.1 | 191 | 3050 | FEMALE |\n",
       "| Adelie    | Biscoe    | 41.6 | 18.0 | 192 | 3950 | MALE   |\n",
       "| Chinstrap | Dream     | 50.1 | 17.9 | 190 | 3400 | FEMALE |\n",
       "| Chinstrap | Dream     | 49.0 | 19.6 | 212 | 4300 | MALE   |\n",
       "| Chinstrap | Dream     | 43.5 | 18.1 | 202 | 3400 | FEMALE |\n",
       "| Gentoo    | Biscoe    | 50.5 | 15.9 | 222 | 5550 | MALE   |\n",
       "| Gentoo    | Biscoe    | 51.5 | 16.3 | 230 | 5500 | MALE   |\n",
       "| Gentoo    | Biscoe    | 43.5 | 15.2 | 213 | 4650 | FEMALE |\n",
       "| Gentoo    | Biscoe    | 47.6 | 14.5 | 215 | 5400 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "   species   island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1  Adelie    Torgersen 41.4             18.5            202              \n",
       "2  Adelie    Biscoe    40.5             17.9            187              \n",
       "3  Adelie    Dream     36.3             19.5            190              \n",
       "4  Adelie    Torgersen 39.0             17.1            191              \n",
       "5  Adelie    Biscoe    41.6             18.0            192              \n",
       "6  Chinstrap Dream     50.1             17.9            190              \n",
       "7  Chinstrap Dream     49.0             19.6            212              \n",
       "8  Chinstrap Dream     43.5             18.1            202              \n",
       "9  Gentoo    Biscoe    50.5             15.9            222              \n",
       "10 Gentoo    Biscoe    51.5             16.3            230              \n",
       "11 Gentoo    Biscoe    43.5             15.2            213              \n",
       "12 Gentoo    Biscoe    47.6             14.5            215              \n",
       "   body_mass_g sex   \n",
       "1  3875        MALE  \n",
       "2  3200        FEMALE\n",
       "3  3800        MALE  \n",
       "4  3050        FEMALE\n",
       "5  3950        MALE  \n",
       "6  3400        FEMALE\n",
       "7  4300        MALE  \n",
       "8  3400        FEMALE\n",
       "9  5550        MALE  \n",
       "10 5500        MALE  \n",
       "11 4650        FEMALE\n",
       "12 5400        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# let's re-run the arrange() function on character data in the penguins_subset data\n",
    "\n",
    "penguins_subset %>%\n",
    "  arrange(species)"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.027256,
     "end_time": "2021-12-29T06:18:38.493989",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.466733",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### Nesting desc() inside arrange()\n",
    "\n",
    "What if we don't want our data in ascending order? Then we can nest the `desc()` function, which stands for _descending_, within the `arrange()` function. This will then order our numeric data from highest to lowest, and our character data in reverse alphabetical order."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:38.553407Z",
     "iopub.status.busy": "2021-12-29T06:18:38.552042Z",
     "iopub.status.idle": "2021-12-29T06:18:38.579970Z",
     "shell.execute_reply": "2021-12-29T06:18:38.578675Z"
    },
    "papermill": {
     "duration": 0.05892,
     "end_time": "2021-12-29T06:18:38.580159",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.521239",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 12 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>51.5</td><td>16.3</td><td>230</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>50.5</td><td>15.9</td><td>222</td><td>5550</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>50.1</td><td>17.9</td><td>190</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>49.0</td><td>19.6</td><td>212</td><td>4300</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>47.6</td><td>14.5</td><td>215</td><td>5400</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>43.5</td><td>18.1</td><td>202</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>43.5</td><td>15.2</td><td>213</td><td>4650</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>41.6</td><td>18.0</td><td>192</td><td>3950</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>41.4</td><td>18.5</td><td>202</td><td>3875</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>40.5</td><td>17.9</td><td>187</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>39.0</td><td>17.1</td><td>191</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream    </td><td>36.3</td><td>19.5</td><td>190</td><td>3800</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 12 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Gentoo    & Biscoe    & 51.5 & 16.3 & 230 & 5500 & MALE  \\\\\n",
       "\t Gentoo    & Biscoe    & 50.5 & 15.9 & 222 & 5550 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 50.1 & 17.9 & 190 & 3400 & FEMALE\\\\\n",
       "\t Chinstrap & Dream     & 49.0 & 19.6 & 212 & 4300 & MALE  \\\\\n",
       "\t Gentoo    & Biscoe    & 47.6 & 14.5 & 215 & 5400 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 43.5 & 18.1 & 202 & 3400 & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & 43.5 & 15.2 & 213 & 4650 & FEMALE\\\\\n",
       "\t Adelie    & Biscoe    & 41.6 & 18.0 & 192 & 3950 & MALE  \\\\\n",
       "\t Adelie    & Torgersen & 41.4 & 18.5 & 202 & 3875 & MALE  \\\\\n",
       "\t Adelie    & Biscoe    & 40.5 & 17.9 & 187 & 3200 & FEMALE\\\\\n",
       "\t Adelie    & Torgersen & 39.0 & 17.1 & 191 & 3050 & FEMALE\\\\\n",
       "\t Adelie    & Dream     & 36.3 & 19.5 & 190 & 3800 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 12 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Gentoo    | Biscoe    | 51.5 | 16.3 | 230 | 5500 | MALE   |\n",
       "| Gentoo    | Biscoe    | 50.5 | 15.9 | 222 | 5550 | MALE   |\n",
       "| Chinstrap | Dream     | 50.1 | 17.9 | 190 | 3400 | FEMALE |\n",
       "| Chinstrap | Dream     | 49.0 | 19.6 | 212 | 4300 | MALE   |\n",
       "| Gentoo    | Biscoe    | 47.6 | 14.5 | 215 | 5400 | MALE   |\n",
       "| Chinstrap | Dream     | 43.5 | 18.1 | 202 | 3400 | FEMALE |\n",
       "| Gentoo    | Biscoe    | 43.5 | 15.2 | 213 | 4650 | FEMALE |\n",
       "| Adelie    | Biscoe    | 41.6 | 18.0 | 192 | 3950 | MALE   |\n",
       "| Adelie    | Torgersen | 41.4 | 18.5 | 202 | 3875 | MALE   |\n",
       "| Adelie    | Biscoe    | 40.5 | 17.9 | 187 | 3200 | FEMALE |\n",
       "| Adelie    | Torgersen | 39.0 | 17.1 | 191 | 3050 | FEMALE |\n",
       "| Adelie    | Dream     | 36.3 | 19.5 | 190 | 3800 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "   species   island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1  Gentoo    Biscoe    51.5             16.3            230              \n",
       "2  Gentoo    Biscoe    50.5             15.9            222              \n",
       "3  Chinstrap Dream     50.1             17.9            190              \n",
       "4  Chinstrap Dream     49.0             19.6            212              \n",
       "5  Gentoo    Biscoe    47.6             14.5            215              \n",
       "6  Chinstrap Dream     43.5             18.1            202              \n",
       "7  Gentoo    Biscoe    43.5             15.2            213              \n",
       "8  Adelie    Biscoe    41.6             18.0            192              \n",
       "9  Adelie    Torgersen 41.4             18.5            202              \n",
       "10 Adelie    Biscoe    40.5             17.9            187              \n",
       "11 Adelie    Torgersen 39.0             17.1            191              \n",
       "12 Adelie    Dream     36.3             19.5            190              \n",
       "   body_mass_g sex   \n",
       "1  5500        MALE  \n",
       "2  5550        MALE  \n",
       "3  3400        FEMALE\n",
       "4  4300        MALE  \n",
       "5  5400        MALE  \n",
       "6  3400        FEMALE\n",
       "7  4650        FEMALE\n",
       "8  3950        MALE  \n",
       "9  3875        MALE  \n",
       "10 3200        FEMALE\n",
       "11 3050        FEMALE\n",
       "12 3800        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# numeric data arranged in descending order\n",
    "\n",
    "penguins_subset %>%\n",
    "  arrange(desc(culmen_length_mm))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:38.641346Z",
     "iopub.status.busy": "2021-12-29T06:18:38.640093Z",
     "iopub.status.idle": "2021-12-29T06:18:38.668630Z",
     "shell.execute_reply": "2021-12-29T06:18:38.667310Z"
    },
    "papermill": {
     "duration": 0.060481,
     "end_time": "2021-12-29T06:18:38.668784",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.608303",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 12 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>50.5</td><td>15.9</td><td>222</td><td>5550</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>51.5</td><td>16.3</td><td>230</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>43.5</td><td>15.2</td><td>213</td><td>4650</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>47.6</td><td>14.5</td><td>215</td><td>5400</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>50.1</td><td>17.9</td><td>190</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>49.0</td><td>19.6</td><td>212</td><td>4300</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>43.5</td><td>18.1</td><td>202</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>41.4</td><td>18.5</td><td>202</td><td>3875</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>40.5</td><td>17.9</td><td>187</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream    </td><td>36.3</td><td>19.5</td><td>190</td><td>3800</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>39.0</td><td>17.1</td><td>191</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>41.6</td><td>18.0</td><td>192</td><td>3950</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 12 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Gentoo    & Biscoe    & 50.5 & 15.9 & 222 & 5550 & MALE  \\\\\n",
       "\t Gentoo    & Biscoe    & 51.5 & 16.3 & 230 & 5500 & MALE  \\\\\n",
       "\t Gentoo    & Biscoe    & 43.5 & 15.2 & 213 & 4650 & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & 47.6 & 14.5 & 215 & 5400 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 50.1 & 17.9 & 190 & 3400 & FEMALE\\\\\n",
       "\t Chinstrap & Dream     & 49.0 & 19.6 & 212 & 4300 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 43.5 & 18.1 & 202 & 3400 & FEMALE\\\\\n",
       "\t Adelie    & Torgersen & 41.4 & 18.5 & 202 & 3875 & MALE  \\\\\n",
       "\t Adelie    & Biscoe    & 40.5 & 17.9 & 187 & 3200 & FEMALE\\\\\n",
       "\t Adelie    & Dream     & 36.3 & 19.5 & 190 & 3800 & MALE  \\\\\n",
       "\t Adelie    & Torgersen & 39.0 & 17.1 & 191 & 3050 & FEMALE\\\\\n",
       "\t Adelie    & Biscoe    & 41.6 & 18.0 & 192 & 3950 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 12 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Gentoo    | Biscoe    | 50.5 | 15.9 | 222 | 5550 | MALE   |\n",
       "| Gentoo    | Biscoe    | 51.5 | 16.3 | 230 | 5500 | MALE   |\n",
       "| Gentoo    | Biscoe    | 43.5 | 15.2 | 213 | 4650 | FEMALE |\n",
       "| Gentoo    | Biscoe    | 47.6 | 14.5 | 215 | 5400 | MALE   |\n",
       "| Chinstrap | Dream     | 50.1 | 17.9 | 190 | 3400 | FEMALE |\n",
       "| Chinstrap | Dream     | 49.0 | 19.6 | 212 | 4300 | MALE   |\n",
       "| Chinstrap | Dream     | 43.5 | 18.1 | 202 | 3400 | FEMALE |\n",
       "| Adelie    | Torgersen | 41.4 | 18.5 | 202 | 3875 | MALE   |\n",
       "| Adelie    | Biscoe    | 40.5 | 17.9 | 187 | 3200 | FEMALE |\n",
       "| Adelie    | Dream     | 36.3 | 19.5 | 190 | 3800 | MALE   |\n",
       "| Adelie    | Torgersen | 39.0 | 17.1 | 191 | 3050 | FEMALE |\n",
       "| Adelie    | Biscoe    | 41.6 | 18.0 | 192 | 3950 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "   species   island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1  Gentoo    Biscoe    50.5             15.9            222              \n",
       "2  Gentoo    Biscoe    51.5             16.3            230              \n",
       "3  Gentoo    Biscoe    43.5             15.2            213              \n",
       "4  Gentoo    Biscoe    47.6             14.5            215              \n",
       "5  Chinstrap Dream     50.1             17.9            190              \n",
       "6  Chinstrap Dream     49.0             19.6            212              \n",
       "7  Chinstrap Dream     43.5             18.1            202              \n",
       "8  Adelie    Torgersen 41.4             18.5            202              \n",
       "9  Adelie    Biscoe    40.5             17.9            187              \n",
       "10 Adelie    Dream     36.3             19.5            190              \n",
       "11 Adelie    Torgersen 39.0             17.1            191              \n",
       "12 Adelie    Biscoe    41.6             18.0            192              \n",
       "   body_mass_g sex   \n",
       "1  5550        MALE  \n",
       "2  5500        MALE  \n",
       "3  4650        FEMALE\n",
       "4  5400        MALE  \n",
       "5  3400        FEMALE\n",
       "6  4300        MALE  \n",
       "7  3400        FEMALE\n",
       "8  3875        MALE  \n",
       "9  3200        FEMALE\n",
       "10 3800        MALE  \n",
       "11 3050        FEMALE\n",
       "12 3950        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# character data arranged in descending - reverse alphabetical - order\n",
    "\n",
    "penguins_subset %>%\n",
    "  arrange(desc(species))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.029851,
     "end_time": "2021-12-29T06:18:38.728868",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.699017",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Fun with filter()\n",
    "\n",
    "`filter()` is probably one of my most used functions, because it allows me to look at subsets quickly and easily. What's nice about `filter()` is its flexibility - we can use it on a single condition or multiple conditions."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:38.792236Z",
     "iopub.status.busy": "2021-12-29T06:18:38.790793Z",
     "iopub.status.idle": "2021-12-29T06:18:38.816253Z",
     "shell.execute_reply": "2021-12-29T06:18:38.814998Z"
    },
    "papermill": {
     "duration": 0.05843,
     "end_time": "2021-12-29T06:18:38.816394",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.757964",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 9 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>41.4</td><td>18.5</td><td>202</td><td>3875</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>50.1</td><td>17.9</td><td>190</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>49.0</td><td>19.6</td><td>212</td><td>4300</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>43.5</td><td>18.1</td><td>202</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>51.5</td><td>16.3</td><td>230</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>40.5</td><td>17.9</td><td>187</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream    </td><td>36.3</td><td>19.5</td><td>190</td><td>3800</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>39.0</td><td>17.1</td><td>191</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>41.6</td><td>18.0</td><td>192</td><td>3950</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 9 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie    & Torgersen & 41.4 & 18.5 & 202 & 3875 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 50.1 & 17.9 & 190 & 3400 & FEMALE\\\\\n",
       "\t Chinstrap & Dream     & 49.0 & 19.6 & 212 & 4300 & MALE  \\\\\n",
       "\t Chinstrap & Dream     & 43.5 & 18.1 & 202 & 3400 & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & 51.5 & 16.3 & 230 & 5500 & MALE  \\\\\n",
       "\t Adelie    & Biscoe    & 40.5 & 17.9 & 187 & 3200 & FEMALE\\\\\n",
       "\t Adelie    & Dream     & 36.3 & 19.5 & 190 & 3800 & MALE  \\\\\n",
       "\t Adelie    & Torgersen & 39.0 & 17.1 & 191 & 3050 & FEMALE\\\\\n",
       "\t Adelie    & Biscoe    & 41.6 & 18.0 & 192 & 3950 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 9 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Adelie    | Torgersen | 41.4 | 18.5 | 202 | 3875 | MALE   |\n",
       "| Chinstrap | Dream     | 50.1 | 17.9 | 190 | 3400 | FEMALE |\n",
       "| Chinstrap | Dream     | 49.0 | 19.6 | 212 | 4300 | MALE   |\n",
       "| Chinstrap | Dream     | 43.5 | 18.1 | 202 | 3400 | FEMALE |\n",
       "| Gentoo    | Biscoe    | 51.5 | 16.3 | 230 | 5500 | MALE   |\n",
       "| Adelie    | Biscoe    | 40.5 | 17.9 | 187 | 3200 | FEMALE |\n",
       "| Adelie    | Dream     | 36.3 | 19.5 | 190 | 3800 | MALE   |\n",
       "| Adelie    | Torgersen | 39.0 | 17.1 | 191 | 3050 | FEMALE |\n",
       "| Adelie    | Biscoe    | 41.6 | 18.0 | 192 | 3950 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "  species   island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1 Adelie    Torgersen 41.4             18.5            202              \n",
       "2 Chinstrap Dream     50.1             17.9            190              \n",
       "3 Chinstrap Dream     49.0             19.6            212              \n",
       "4 Chinstrap Dream     43.5             18.1            202              \n",
       "5 Gentoo    Biscoe    51.5             16.3            230              \n",
       "6 Adelie    Biscoe    40.5             17.9            187              \n",
       "7 Adelie    Dream     36.3             19.5            190              \n",
       "8 Adelie    Torgersen 39.0             17.1            191              \n",
       "9 Adelie    Biscoe    41.6             18.0            192              \n",
       "  body_mass_g sex   \n",
       "1 3875        MALE  \n",
       "2 3400        FEMALE\n",
       "3 4300        MALE  \n",
       "4 3400        FEMALE\n",
       "5 5500        MALE  \n",
       "6 3200        FEMALE\n",
       "7 3800        MALE  \n",
       "8 3050        FEMALE\n",
       "9 3950        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# filter with a single numeric condition\n",
    "\n",
    "penguins_subset %>%\n",
    "  filter(culmen_depth_mm > 16.2)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:38.881161Z",
     "iopub.status.busy": "2021-12-29T06:18:38.879783Z",
     "iopub.status.idle": "2021-12-29T06:18:38.903426Z",
     "shell.execute_reply": "2021-12-29T06:18:38.901989Z"
    },
    "papermill": {
     "duration": 0.057445,
     "end_time": "2021-12-29T06:18:38.903607",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.846162",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 4 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Chinstrap</td><td>Dream</td><td>50.1</td><td>17.9</td><td>190</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream</td><td>49.0</td><td>19.6</td><td>212</td><td>4300</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream</td><td>43.5</td><td>18.1</td><td>202</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream</td><td>36.3</td><td>19.5</td><td>190</td><td>3800</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 4 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Chinstrap & Dream & 50.1 & 17.9 & 190 & 3400 & FEMALE\\\\\n",
       "\t Chinstrap & Dream & 49.0 & 19.6 & 212 & 4300 & MALE  \\\\\n",
       "\t Chinstrap & Dream & 43.5 & 18.1 & 202 & 3400 & FEMALE\\\\\n",
       "\t Adelie    & Dream & 36.3 & 19.5 & 190 & 3800 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 4 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Chinstrap | Dream | 50.1 | 17.9 | 190 | 3400 | FEMALE |\n",
       "| Chinstrap | Dream | 49.0 | 19.6 | 212 | 4300 | MALE   |\n",
       "| Chinstrap | Dream | 43.5 | 18.1 | 202 | 3400 | FEMALE |\n",
       "| Adelie    | Dream | 36.3 | 19.5 | 190 | 3800 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "  species   island culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1 Chinstrap Dream  50.1             17.9            190              \n",
       "2 Chinstrap Dream  49.0             19.6            212              \n",
       "3 Chinstrap Dream  43.5             18.1            202              \n",
       "4 Adelie    Dream  36.3             19.5            190              \n",
       "  body_mass_g sex   \n",
       "1 3400        FEMALE\n",
       "2 4300        MALE  \n",
       "3 3400        FEMALE\n",
       "4 3800        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# filter with a single character condition\n",
    "\n",
    "penguins_subset %>%\n",
    "  filter(island == \"Dream\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:38.969346Z",
     "iopub.status.busy": "2021-12-29T06:18:38.967983Z",
     "iopub.status.idle": "2021-12-29T06:18:38.992826Z",
     "shell.execute_reply": "2021-12-29T06:18:38.991530Z"
    },
    "papermill": {
     "duration": 0.059046,
     "end_time": "2021-12-29T06:18:38.992968",
     "exception": false,
     "start_time": "2021-12-29T06:18:38.933922",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 6 × 7</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>50.1</td><td>17.9</td><td>190</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>43.5</td><td>18.1</td><td>202</td><td>3400</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>51.5</td><td>16.3</td><td>230</td><td>5500</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>40.5</td><td>17.9</td><td>187</td><td>3200</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>39.0</td><td>17.1</td><td>191</td><td>3050</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>41.6</td><td>18.0</td><td>192</td><td>3950</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 6 × 7\n",
       "\\begin{tabular}{lllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Chinstrap & Dream     & 50.1 & 17.9 & 190 & 3400 & FEMALE\\\\\n",
       "\t Chinstrap & Dream     & 43.5 & 18.1 & 202 & 3400 & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & 51.5 & 16.3 & 230 & 5500 & MALE  \\\\\n",
       "\t Adelie    & Biscoe    & 40.5 & 17.9 & 187 & 3200 & FEMALE\\\\\n",
       "\t Adelie    & Torgersen & 39.0 & 17.1 & 191 & 3050 & FEMALE\\\\\n",
       "\t Adelie    & Biscoe    & 41.6 & 18.0 & 192 & 3950 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 6 × 7\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|\n",
       "| Chinstrap | Dream     | 50.1 | 17.9 | 190 | 3400 | FEMALE |\n",
       "| Chinstrap | Dream     | 43.5 | 18.1 | 202 | 3400 | FEMALE |\n",
       "| Gentoo    | Biscoe    | 51.5 | 16.3 | 230 | 5500 | MALE   |\n",
       "| Adelie    | Biscoe    | 40.5 | 17.9 | 187 | 3200 | FEMALE |\n",
       "| Adelie    | Torgersen | 39.0 | 17.1 | 191 | 3050 | FEMALE |\n",
       "| Adelie    | Biscoe    | 41.6 | 18.0 | 192 | 3950 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "  species   island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1 Chinstrap Dream     50.1             17.9            190              \n",
       "2 Chinstrap Dream     43.5             18.1            202              \n",
       "3 Gentoo    Biscoe    51.5             16.3            230              \n",
       "4 Adelie    Biscoe    40.5             17.9            187              \n",
       "5 Adelie    Torgersen 39.0             17.1            191              \n",
       "6 Adelie    Biscoe    41.6             18.0            192              \n",
       "  body_mass_g sex   \n",
       "1 3400        FEMALE\n",
       "2 3400        FEMALE\n",
       "3 5500        MALE  \n",
       "4 3200        FEMALE\n",
       "5 3050        FEMALE\n",
       "6 3950        MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# filter with a single numeric condition between two values\n",
    "\n",
    "penguins_subset %>%\n",
    "  filter(between(culmen_depth_mm, 16.2, 18.1 ))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.032214,
     "end_time": "2021-12-29T06:18:39.056352",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.024138",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Starting with select()\n",
    "\n",
    "`select()` allows us to pick which columns (variables) we want to look at, and we can use it to pull a subset of variables, or even rearrange the order of our variables within a dataframe."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:39.123815Z",
     "iopub.status.busy": "2021-12-29T06:18:39.122273Z",
     "iopub.status.idle": "2021-12-29T06:18:39.159621Z",
     "shell.execute_reply": "2021-12-29T06:18:39.152521Z"
    },
    "papermill": {
     "duration": 0.072391,
     "end_time": "2021-12-29T06:18:39.159788",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.087397",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 12 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>flipper_length_mm</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>202</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>190</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>222</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>212</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>202</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>230</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>187</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>213</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>190</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>191</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>192</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>215</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 12 × 3\n",
       "\\begin{tabular}{lll}\n",
       " species & flipper\\_length\\_mm & sex\\\\\n",
       " <chr> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie    & 202 & MALE  \\\\\n",
       "\t Chinstrap & 190 & FEMALE\\\\\n",
       "\t Gentoo    & 222 & MALE  \\\\\n",
       "\t Chinstrap & 212 & MALE  \\\\\n",
       "\t Chinstrap & 202 & FEMALE\\\\\n",
       "\t Gentoo    & 230 & MALE  \\\\\n",
       "\t Adelie    & 187 & FEMALE\\\\\n",
       "\t Gentoo    & 213 & FEMALE\\\\\n",
       "\t Adelie    & 190 & MALE  \\\\\n",
       "\t Adelie    & 191 & FEMALE\\\\\n",
       "\t Adelie    & 192 & MALE  \\\\\n",
       "\t Gentoo    & 215 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 12 × 3\n",
       "\n",
       "| species &lt;chr&gt; | flipper_length_mm &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|\n",
       "| Adelie    | 202 | MALE   |\n",
       "| Chinstrap | 190 | FEMALE |\n",
       "| Gentoo    | 222 | MALE   |\n",
       "| Chinstrap | 212 | MALE   |\n",
       "| Chinstrap | 202 | FEMALE |\n",
       "| Gentoo    | 230 | MALE   |\n",
       "| Adelie    | 187 | FEMALE |\n",
       "| Gentoo    | 213 | FEMALE |\n",
       "| Adelie    | 190 | MALE   |\n",
       "| Adelie    | 191 | FEMALE |\n",
       "| Adelie    | 192 | MALE   |\n",
       "| Gentoo    | 215 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "   species   flipper_length_mm sex   \n",
       "1  Adelie    202               MALE  \n",
       "2  Chinstrap 190               FEMALE\n",
       "3  Gentoo    222               MALE  \n",
       "4  Chinstrap 212               MALE  \n",
       "5  Chinstrap 202               FEMALE\n",
       "6  Gentoo    230               MALE  \n",
       "7  Adelie    187               FEMALE\n",
       "8  Gentoo    213               FEMALE\n",
       "9  Adelie    190               MALE  \n",
       "10 Adelie    191               FEMALE\n",
       "11 Adelie    192               MALE  \n",
       "12 Gentoo    215               MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# selecting species, flipper_length_mm, and sex columns\n",
    "\n",
    "penguins_subset %>%\n",
    "  select(species, flipper_length_mm, sex)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:39.229890Z",
     "iopub.status.busy": "2021-12-29T06:18:39.228409Z",
     "iopub.status.idle": "2021-12-29T06:18:39.256271Z",
     "shell.execute_reply": "2021-12-29T06:18:39.254614Z"
    },
    "papermill": {
     "duration": 0.064225,
     "end_time": "2021-12-29T06:18:39.256434",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.192209",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 12 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream    </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 12 × 3\n",
       "\\begin{tabular}{lll}\n",
       " species & island & sex\\\\\n",
       " <chr> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie    & Torgersen & MALE  \\\\\n",
       "\t Chinstrap & Dream     & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & MALE  \\\\\n",
       "\t Chinstrap & Dream     & MALE  \\\\\n",
       "\t Chinstrap & Dream     & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & MALE  \\\\\n",
       "\t Adelie    & Biscoe    & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & FEMALE\\\\\n",
       "\t Adelie    & Dream     & MALE  \\\\\n",
       "\t Adelie    & Torgersen & FEMALE\\\\\n",
       "\t Adelie    & Biscoe    & MALE  \\\\\n",
       "\t Gentoo    & Biscoe    & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 12 × 3\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|\n",
       "| Adelie    | Torgersen | MALE   |\n",
       "| Chinstrap | Dream     | FEMALE |\n",
       "| Gentoo    | Biscoe    | MALE   |\n",
       "| Chinstrap | Dream     | MALE   |\n",
       "| Chinstrap | Dream     | FEMALE |\n",
       "| Gentoo    | Biscoe    | MALE   |\n",
       "| Adelie    | Biscoe    | FEMALE |\n",
       "| Gentoo    | Biscoe    | FEMALE |\n",
       "| Adelie    | Dream     | MALE   |\n",
       "| Adelie    | Torgersen | FEMALE |\n",
       "| Adelie    | Biscoe    | MALE   |\n",
       "| Gentoo    | Biscoe    | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "   species   island    sex   \n",
       "1  Adelie    Torgersen MALE  \n",
       "2  Chinstrap Dream     FEMALE\n",
       "3  Gentoo    Biscoe    MALE  \n",
       "4  Chinstrap Dream     MALE  \n",
       "5  Chinstrap Dream     FEMALE\n",
       "6  Gentoo    Biscoe    MALE  \n",
       "7  Adelie    Biscoe    FEMALE\n",
       "8  Gentoo    Biscoe    FEMALE\n",
       "9  Adelie    Dream     MALE  \n",
       "10 Adelie    Torgersen FEMALE\n",
       "11 Adelie    Biscoe    MALE  \n",
       "12 Gentoo    Biscoe    MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# selecting all character data\n",
    "\n",
    "penguins_subset %>%\n",
    "  select(where(is.character))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:39.328592Z",
     "iopub.status.busy": "2021-12-29T06:18:39.327190Z",
     "iopub.status.idle": "2021-12-29T06:18:39.352624Z",
     "shell.execute_reply": "2021-12-29T06:18:39.351169Z"
    },
    "papermill": {
     "duration": 0.062889,
     "end_time": "2021-12-29T06:18:39.352780",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.289891",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 12 × 4</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>41.4</td><td>18.5</td><td>202</td><td>3875</td></tr>\n",
       "\t<tr><td>50.1</td><td>17.9</td><td>190</td><td>3400</td></tr>\n",
       "\t<tr><td>50.5</td><td>15.9</td><td>222</td><td>5550</td></tr>\n",
       "\t<tr><td>49.0</td><td>19.6</td><td>212</td><td>4300</td></tr>\n",
       "\t<tr><td>43.5</td><td>18.1</td><td>202</td><td>3400</td></tr>\n",
       "\t<tr><td>51.5</td><td>16.3</td><td>230</td><td>5500</td></tr>\n",
       "\t<tr><td>40.5</td><td>17.9</td><td>187</td><td>3200</td></tr>\n",
       "\t<tr><td>43.5</td><td>15.2</td><td>213</td><td>4650</td></tr>\n",
       "\t<tr><td>36.3</td><td>19.5</td><td>190</td><td>3800</td></tr>\n",
       "\t<tr><td>39.0</td><td>17.1</td><td>191</td><td>3050</td></tr>\n",
       "\t<tr><td>41.6</td><td>18.0</td><td>192</td><td>3950</td></tr>\n",
       "\t<tr><td>47.6</td><td>14.5</td><td>215</td><td>5400</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 12 × 4\n",
       "\\begin{tabular}{llll}\n",
       " culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g\\\\\n",
       " <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t 41.4 & 18.5 & 202 & 3875\\\\\n",
       "\t 50.1 & 17.9 & 190 & 3400\\\\\n",
       "\t 50.5 & 15.9 & 222 & 5550\\\\\n",
       "\t 49.0 & 19.6 & 212 & 4300\\\\\n",
       "\t 43.5 & 18.1 & 202 & 3400\\\\\n",
       "\t 51.5 & 16.3 & 230 & 5500\\\\\n",
       "\t 40.5 & 17.9 & 187 & 3200\\\\\n",
       "\t 43.5 & 15.2 & 213 & 4650\\\\\n",
       "\t 36.3 & 19.5 & 190 & 3800\\\\\n",
       "\t 39.0 & 17.1 & 191 & 3050\\\\\n",
       "\t 41.6 & 18.0 & 192 & 3950\\\\\n",
       "\t 47.6 & 14.5 & 215 & 5400\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 12 × 4\n",
       "\n",
       "| culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; |\n",
       "|---|---|---|---|\n",
       "| 41.4 | 18.5 | 202 | 3875 |\n",
       "| 50.1 | 17.9 | 190 | 3400 |\n",
       "| 50.5 | 15.9 | 222 | 5550 |\n",
       "| 49.0 | 19.6 | 212 | 4300 |\n",
       "| 43.5 | 18.1 | 202 | 3400 |\n",
       "| 51.5 | 16.3 | 230 | 5500 |\n",
       "| 40.5 | 17.9 | 187 | 3200 |\n",
       "| 43.5 | 15.2 | 213 | 4650 |\n",
       "| 36.3 | 19.5 | 190 | 3800 |\n",
       "| 39.0 | 17.1 | 191 | 3050 |\n",
       "| 41.6 | 18.0 | 192 | 3950 |\n",
       "| 47.6 | 14.5 | 215 | 5400 |\n",
       "\n"
      ],
      "text/plain": [
       "   culmen_length_mm culmen_depth_mm flipper_length_mm body_mass_g\n",
       "1  41.4             18.5            202               3875       \n",
       "2  50.1             17.9            190               3400       \n",
       "3  50.5             15.9            222               5550       \n",
       "4  49.0             19.6            212               4300       \n",
       "5  43.5             18.1            202               3400       \n",
       "6  51.5             16.3            230               5500       \n",
       "7  40.5             17.9            187               3200       \n",
       "8  43.5             15.2            213               4650       \n",
       "9  36.3             19.5            190               3800       \n",
       "10 39.0             17.1            191               3050       \n",
       "11 41.6             18.0            192               3950       \n",
       "12 47.6             14.5            215               5400       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# selecting all numeric data\n",
    "\n",
    "penguins_subset %>%\n",
    "  select(where(is.numeric))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:39.425644Z",
     "iopub.status.busy": "2021-12-29T06:18:39.424120Z",
     "iopub.status.idle": "2021-12-29T06:18:39.450286Z",
     "shell.execute_reply": "2021-12-29T06:18:39.448928Z"
    },
    "papermill": {
     "duration": 0.064465,
     "end_time": "2021-12-29T06:18:39.450446",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.385981",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 12 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream    </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 12 × 3\n",
       "\\begin{tabular}{lll}\n",
       " species & island & sex\\\\\n",
       " <chr> & <chr> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie    & Torgersen & MALE  \\\\\n",
       "\t Chinstrap & Dream     & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & MALE  \\\\\n",
       "\t Chinstrap & Dream     & MALE  \\\\\n",
       "\t Chinstrap & Dream     & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & MALE  \\\\\n",
       "\t Adelie    & Biscoe    & FEMALE\\\\\n",
       "\t Gentoo    & Biscoe    & FEMALE\\\\\n",
       "\t Adelie    & Dream     & MALE  \\\\\n",
       "\t Adelie    & Torgersen & FEMALE\\\\\n",
       "\t Adelie    & Biscoe    & MALE  \\\\\n",
       "\t Gentoo    & Biscoe    & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 12 × 3\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|\n",
       "| Adelie    | Torgersen | MALE   |\n",
       "| Chinstrap | Dream     | FEMALE |\n",
       "| Gentoo    | Biscoe    | MALE   |\n",
       "| Chinstrap | Dream     | MALE   |\n",
       "| Chinstrap | Dream     | FEMALE |\n",
       "| Gentoo    | Biscoe    | MALE   |\n",
       "| Adelie    | Biscoe    | FEMALE |\n",
       "| Gentoo    | Biscoe    | FEMALE |\n",
       "| Adelie    | Dream     | MALE   |\n",
       "| Adelie    | Torgersen | FEMALE |\n",
       "| Adelie    | Biscoe    | MALE   |\n",
       "| Gentoo    | Biscoe    | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "   species   island    sex   \n",
       "1  Adelie    Torgersen MALE  \n",
       "2  Chinstrap Dream     FEMALE\n",
       "3  Gentoo    Biscoe    MALE  \n",
       "4  Chinstrap Dream     MALE  \n",
       "5  Chinstrap Dream     FEMALE\n",
       "6  Gentoo    Biscoe    MALE  \n",
       "7  Adelie    Biscoe    FEMALE\n",
       "8  Gentoo    Biscoe    FEMALE\n",
       "9  Adelie    Dream     MALE  \n",
       "10 Adelie    Torgersen FEMALE\n",
       "11 Adelie    Biscoe    MALE  \n",
       "12 Gentoo    Biscoe    MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# selecting all character data by using \"where not numeric\" data\n",
    "\n",
    "penguins_subset %>%\n",
    "  select(!where(is.numeric))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.033749,
     "end_time": "2021-12-29T06:18:39.518397",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.484648",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Math with mutate()\n",
    "\n",
    "What's not to love about a function that let's us create new columns (variables)?! For these examples we'll work strictly with `mutate()`, but when you work on extending this notebook, try using `group_by()` and _then_ `mutate()`! (We'll talk about `group_by()` in the next section.)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:39.592046Z",
     "iopub.status.busy": "2021-12-29T06:18:39.590744Z",
     "iopub.status.idle": "2021-12-29T06:18:39.620031Z",
     "shell.execute_reply": "2021-12-29T06:18:39.618486Z"
    },
    "papermill": {
     "duration": 0.067188,
     "end_time": "2021-12-29T06:18:39.620186",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.552998",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A spec_tbl_df: 12 × 8</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>body_mass_g</th><th scope=col>sex</th><th scope=col>body_weight_pounds</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>41.4</td><td>18.5</td><td>202</td><td>3875</td><td>MALE  </td><td> 8.542913</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>50.1</td><td>17.9</td><td>190</td><td>3400</td><td>FEMALE</td><td> 7.495717</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>50.5</td><td>15.9</td><td>222</td><td>5550</td><td>MALE  </td><td>12.235656</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>49.0</td><td>19.6</td><td>212</td><td>4300</td><td>MALE  </td><td> 9.479877</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>43.5</td><td>18.1</td><td>202</td><td>3400</td><td>FEMALE</td><td> 7.495717</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>51.5</td><td>16.3</td><td>230</td><td>5500</td><td>MALE  </td><td>12.125424</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>40.5</td><td>17.9</td><td>187</td><td>3200</td><td>FEMALE</td><td> 7.054792</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>43.5</td><td>15.2</td><td>213</td><td>4650</td><td>FEMALE</td><td>10.251495</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream    </td><td>36.3</td><td>19.5</td><td>190</td><td>3800</td><td>MALE  </td><td> 8.377566</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>39.0</td><td>17.1</td><td>191</td><td>3050</td><td>FEMALE</td><td> 6.724099</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>41.6</td><td>18.0</td><td>192</td><td>3950</td><td>MALE  </td><td> 8.708259</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>47.6</td><td>14.5</td><td>215</td><td>5400</td><td>MALE  </td><td>11.904962</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A spec\\_tbl\\_df: 12 × 8\n",
       "\\begin{tabular}{llllllll}\n",
       " species & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & body\\_mass\\_g & sex & body\\_weight\\_pounds\\\\\n",
       " <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Adelie    & Torgersen & 41.4 & 18.5 & 202 & 3875 & MALE   &  8.542913\\\\\n",
       "\t Chinstrap & Dream     & 50.1 & 17.9 & 190 & 3400 & FEMALE &  7.495717\\\\\n",
       "\t Gentoo    & Biscoe    & 50.5 & 15.9 & 222 & 5550 & MALE   & 12.235656\\\\\n",
       "\t Chinstrap & Dream     & 49.0 & 19.6 & 212 & 4300 & MALE   &  9.479877\\\\\n",
       "\t Chinstrap & Dream     & 43.5 & 18.1 & 202 & 3400 & FEMALE &  7.495717\\\\\n",
       "\t Gentoo    & Biscoe    & 51.5 & 16.3 & 230 & 5500 & MALE   & 12.125424\\\\\n",
       "\t Adelie    & Biscoe    & 40.5 & 17.9 & 187 & 3200 & FEMALE &  7.054792\\\\\n",
       "\t Gentoo    & Biscoe    & 43.5 & 15.2 & 213 & 4650 & FEMALE & 10.251495\\\\\n",
       "\t Adelie    & Dream     & 36.3 & 19.5 & 190 & 3800 & MALE   &  8.377566\\\\\n",
       "\t Adelie    & Torgersen & 39.0 & 17.1 & 191 & 3050 & FEMALE &  6.724099\\\\\n",
       "\t Adelie    & Biscoe    & 41.6 & 18.0 & 192 & 3950 & MALE   &  8.708259\\\\\n",
       "\t Gentoo    & Biscoe    & 47.6 & 14.5 & 215 & 5400 & MALE   & 11.904962\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A spec_tbl_df: 12 × 8\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | body_mass_g &lt;dbl&gt; | sex &lt;chr&gt; | body_weight_pounds &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|\n",
       "| Adelie    | Torgersen | 41.4 | 18.5 | 202 | 3875 | MALE   |  8.542913 |\n",
       "| Chinstrap | Dream     | 50.1 | 17.9 | 190 | 3400 | FEMALE |  7.495717 |\n",
       "| Gentoo    | Biscoe    | 50.5 | 15.9 | 222 | 5550 | MALE   | 12.235656 |\n",
       "| Chinstrap | Dream     | 49.0 | 19.6 | 212 | 4300 | MALE   |  9.479877 |\n",
       "| Chinstrap | Dream     | 43.5 | 18.1 | 202 | 3400 | FEMALE |  7.495717 |\n",
       "| Gentoo    | Biscoe    | 51.5 | 16.3 | 230 | 5500 | MALE   | 12.125424 |\n",
       "| Adelie    | Biscoe    | 40.5 | 17.9 | 187 | 3200 | FEMALE |  7.054792 |\n",
       "| Gentoo    | Biscoe    | 43.5 | 15.2 | 213 | 4650 | FEMALE | 10.251495 |\n",
       "| Adelie    | Dream     | 36.3 | 19.5 | 190 | 3800 | MALE   |  8.377566 |\n",
       "| Adelie    | Torgersen | 39.0 | 17.1 | 191 | 3050 | FEMALE |  6.724099 |\n",
       "| Adelie    | Biscoe    | 41.6 | 18.0 | 192 | 3950 | MALE   |  8.708259 |\n",
       "| Gentoo    | Biscoe    | 47.6 | 14.5 | 215 | 5400 | MALE   | 11.904962 |\n",
       "\n"
      ],
      "text/plain": [
       "   species   island    culmen_length_mm culmen_depth_mm flipper_length_mm\n",
       "1  Adelie    Torgersen 41.4             18.5            202              \n",
       "2  Chinstrap Dream     50.1             17.9            190              \n",
       "3  Gentoo    Biscoe    50.5             15.9            222              \n",
       "4  Chinstrap Dream     49.0             19.6            212              \n",
       "5  Chinstrap Dream     43.5             18.1            202              \n",
       "6  Gentoo    Biscoe    51.5             16.3            230              \n",
       "7  Adelie    Biscoe    40.5             17.9            187              \n",
       "8  Gentoo    Biscoe    43.5             15.2            213              \n",
       "9  Adelie    Dream     36.3             19.5            190              \n",
       "10 Adelie    Torgersen 39.0             17.1            191              \n",
       "11 Adelie    Biscoe    41.6             18.0            192              \n",
       "12 Gentoo    Biscoe    47.6             14.5            215              \n",
       "   body_mass_g sex    body_weight_pounds\n",
       "1  3875        MALE    8.542913         \n",
       "2  3400        FEMALE  7.495717         \n",
       "3  5550        MALE   12.235656         \n",
       "4  4300        MALE    9.479877         \n",
       "5  3400        FEMALE  7.495717         \n",
       "6  5500        MALE   12.125424         \n",
       "7  3200        FEMALE  7.054792         \n",
       "8  4650        FEMALE 10.251495         \n",
       "9  3800        MALE    8.377566         \n",
       "10 3050        FEMALE  6.724099         \n",
       "11 3950        MALE    8.708259         \n",
       "12 5400        MALE   11.904962         "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# converting grams to pounds\n",
    "# notice how the order of our columns stays the same, and the new column, body_weight_pounds, gets placed at the \n",
    "# far right of the dataframe. what function could we use to change this order?\n",
    "\n",
    "penguins_subset %>%\n",
    "  mutate(body_weight_pounds = body_mass_g / 453.59237)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:39.694595Z",
     "iopub.status.busy": "2021-12-29T06:18:39.693092Z",
     "iopub.status.idle": "2021-12-29T06:18:39.725799Z",
     "shell.execute_reply": "2021-12-29T06:18:39.724597Z"
    },
    "papermill": {
     "duration": 0.071173,
     "end_time": "2021-12-29T06:18:39.725939",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.654766",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 12 × 8</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>body_mass_g</th><th scope=col>body_weight_pounds</th><th scope=col>island</th><th scope=col>culmen_length_mm</th><th scope=col>culmen_depth_mm</th><th scope=col>flipper_length_mm</th><th scope=col>sex</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>3875</td><td> 8.542913</td><td>Torgersen</td><td>41.4</td><td>18.5</td><td>202</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>3400</td><td> 7.495717</td><td>Dream    </td><td>50.1</td><td>17.9</td><td>190</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>5550</td><td>12.235656</td><td>Biscoe   </td><td>50.5</td><td>15.9</td><td>222</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>4300</td><td> 9.479877</td><td>Dream    </td><td>49.0</td><td>19.6</td><td>212</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>3400</td><td> 7.495717</td><td>Dream    </td><td>43.5</td><td>18.1</td><td>202</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>5500</td><td>12.125424</td><td>Biscoe   </td><td>51.5</td><td>16.3</td><td>230</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>3200</td><td> 7.054792</td><td>Biscoe   </td><td>40.5</td><td>17.9</td><td>187</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>4650</td><td>10.251495</td><td>Biscoe   </td><td>43.5</td><td>15.2</td><td>213</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>3800</td><td> 8.377566</td><td>Dream    </td><td>36.3</td><td>19.5</td><td>190</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Adelie   </td><td>3050</td><td> 6.724099</td><td>Torgersen</td><td>39.0</td><td>17.1</td><td>191</td><td>FEMALE</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>3950</td><td> 8.708259</td><td>Biscoe   </td><td>41.6</td><td>18.0</td><td>192</td><td>MALE  </td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>5400</td><td>11.904962</td><td>Biscoe   </td><td>47.6</td><td>14.5</td><td>215</td><td>MALE  </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 12 × 8\n",
       "\\begin{tabular}{llllllll}\n",
       " species & body\\_mass\\_g & body\\_weight\\_pounds & island & culmen\\_length\\_mm & culmen\\_depth\\_mm & flipper\\_length\\_mm & sex\\\\\n",
       " <chr> & <dbl> & <dbl> & <chr> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t Adelie    & 3875 &  8.542913 & Torgersen & 41.4 & 18.5 & 202 & MALE  \\\\\n",
       "\t Chinstrap & 3400 &  7.495717 & Dream     & 50.1 & 17.9 & 190 & FEMALE\\\\\n",
       "\t Gentoo    & 5550 & 12.235656 & Biscoe    & 50.5 & 15.9 & 222 & MALE  \\\\\n",
       "\t Chinstrap & 4300 &  9.479877 & Dream     & 49.0 & 19.6 & 212 & MALE  \\\\\n",
       "\t Chinstrap & 3400 &  7.495717 & Dream     & 43.5 & 18.1 & 202 & FEMALE\\\\\n",
       "\t Gentoo    & 5500 & 12.125424 & Biscoe    & 51.5 & 16.3 & 230 & MALE  \\\\\n",
       "\t Adelie    & 3200 &  7.054792 & Biscoe    & 40.5 & 17.9 & 187 & FEMALE\\\\\n",
       "\t Gentoo    & 4650 & 10.251495 & Biscoe    & 43.5 & 15.2 & 213 & FEMALE\\\\\n",
       "\t Adelie    & 3800 &  8.377566 & Dream     & 36.3 & 19.5 & 190 & MALE  \\\\\n",
       "\t Adelie    & 3050 &  6.724099 & Torgersen & 39.0 & 17.1 & 191 & FEMALE\\\\\n",
       "\t Adelie    & 3950 &  8.708259 & Biscoe    & 41.6 & 18.0 & 192 & MALE  \\\\\n",
       "\t Gentoo    & 5400 & 11.904962 & Biscoe    & 47.6 & 14.5 & 215 & MALE  \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 12 × 8\n",
       "\n",
       "| species &lt;chr&gt; | body_mass_g &lt;dbl&gt; | body_weight_pounds &lt;dbl&gt; | island &lt;chr&gt; | culmen_length_mm &lt;dbl&gt; | culmen_depth_mm &lt;dbl&gt; | flipper_length_mm &lt;dbl&gt; | sex &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|\n",
       "| Adelie    | 3875 |  8.542913 | Torgersen | 41.4 | 18.5 | 202 | MALE   |\n",
       "| Chinstrap | 3400 |  7.495717 | Dream     | 50.1 | 17.9 | 190 | FEMALE |\n",
       "| Gentoo    | 5550 | 12.235656 | Biscoe    | 50.5 | 15.9 | 222 | MALE   |\n",
       "| Chinstrap | 4300 |  9.479877 | Dream     | 49.0 | 19.6 | 212 | MALE   |\n",
       "| Chinstrap | 3400 |  7.495717 | Dream     | 43.5 | 18.1 | 202 | FEMALE |\n",
       "| Gentoo    | 5500 | 12.125424 | Biscoe    | 51.5 | 16.3 | 230 | MALE   |\n",
       "| Adelie    | 3200 |  7.054792 | Biscoe    | 40.5 | 17.9 | 187 | FEMALE |\n",
       "| Gentoo    | 4650 | 10.251495 | Biscoe    | 43.5 | 15.2 | 213 | FEMALE |\n",
       "| Adelie    | 3800 |  8.377566 | Dream     | 36.3 | 19.5 | 190 | MALE   |\n",
       "| Adelie    | 3050 |  6.724099 | Torgersen | 39.0 | 17.1 | 191 | FEMALE |\n",
       "| Adelie    | 3950 |  8.708259 | Biscoe    | 41.6 | 18.0 | 192 | MALE   |\n",
       "| Gentoo    | 5400 | 11.904962 | Biscoe    | 47.6 | 14.5 | 215 | MALE   |\n",
       "\n"
      ],
      "text/plain": [
       "   species   body_mass_g body_weight_pounds island    culmen_length_mm\n",
       "1  Adelie    3875         8.542913          Torgersen 41.4            \n",
       "2  Chinstrap 3400         7.495717          Dream     50.1            \n",
       "3  Gentoo    5550        12.235656          Biscoe    50.5            \n",
       "4  Chinstrap 4300         9.479877          Dream     49.0            \n",
       "5  Chinstrap 3400         7.495717          Dream     43.5            \n",
       "6  Gentoo    5500        12.125424          Biscoe    51.5            \n",
       "7  Adelie    3200         7.054792          Biscoe    40.5            \n",
       "8  Gentoo    4650        10.251495          Biscoe    43.5            \n",
       "9  Adelie    3800         8.377566          Dream     36.3            \n",
       "10 Adelie    3050         6.724099          Torgersen 39.0            \n",
       "11 Adelie    3950         8.708259          Biscoe    41.6            \n",
       "12 Gentoo    5400        11.904962          Biscoe    47.6            \n",
       "   culmen_depth_mm flipper_length_mm sex   \n",
       "1  18.5            202               MALE  \n",
       "2  17.9            190               FEMALE\n",
       "3  15.9            222               MALE  \n",
       "4  19.6            212               MALE  \n",
       "5  18.1            202               FEMALE\n",
       "6  16.3            230               MALE  \n",
       "7  17.9            187               FEMALE\n",
       "8  15.2            213               FEMALE\n",
       "9  19.5            190               MALE  \n",
       "10 17.1            191               FEMALE\n",
       "11 18.0            192               MALE  \n",
       "12 14.5            215               MALE  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# OK I wanted to show you how to combine select and mutate\n",
    "# what do you think the everything() function might do? confirm your guess by looking at the documentation (linked at \n",
    "# the end of the notebook).\n",
    "\n",
    "penguins_subset %>%\n",
    "  mutate(body_weight_pounds = body_mass_g / 453.59237) %>%\n",
    "  select(species, body_mass_g, body_weight_pounds, everything())"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.035142,
     "end_time": "2021-12-29T06:18:39.796913",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.761771",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Summaries with summarise(), with help from group_by()\n",
    "\n",
    "You can use either `summarise()` or `summarize()` to get a summary, or overview, of your data. What's more, once we introduce `group_by()` you can get summary data for _subsets_ of your data."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:39.871862Z",
     "iopub.status.busy": "2021-12-29T06:18:39.870623Z",
     "iopub.status.idle": "2021-12-29T06:18:39.892263Z",
     "shell.execute_reply": "2021-12-29T06:18:39.890949Z"
    },
    "papermill": {
     "duration": 0.060308,
     "end_time": "2021-12-29T06:18:39.892420",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.832112",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>avg_body_mass</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>4172.917</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 1\n",
       "\\begin{tabular}{l}\n",
       " avg\\_body\\_mass\\\\\n",
       " <dbl>\\\\\n",
       "\\hline\n",
       "\t 4172.917\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 1\n",
       "\n",
       "| avg_body_mass &lt;dbl&gt; |\n",
       "|---|\n",
       "| 4172.917 |\n",
       "\n"
      ],
      "text/plain": [
       "  avg_body_mass\n",
       "1 4172.917     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# summarising the average body mass of penguins, in grams\n",
    "\n",
    "penguins_subset %>%\n",
    "  summarise(avg_body_mass = mean(body_mass_g))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:39.969166Z",
     "iopub.status.busy": "2021-12-29T06:18:39.967940Z",
     "iopub.status.idle": "2021-12-29T06:18:39.993922Z",
     "shell.execute_reply": "2021-12-29T06:18:39.992649Z"
    },
    "papermill": {
     "duration": 0.065442,
     "end_time": "2021-12-29T06:18:39.994102",
     "exception": false,
     "start_time": "2021-12-29T06:18:39.928660",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>avg_body_mass</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>NA</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 1\n",
       "\\begin{tabular}{l}\n",
       " avg\\_body\\_mass\\\\\n",
       " <dbl>\\\\\n",
       "\\hline\n",
       "\t NA\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 1\n",
       "\n",
       "| avg_body_mass &lt;dbl&gt; |\n",
       "|---|\n",
       "| NA |\n",
       "\n"
      ],
      "text/plain": [
       "  avg_body_mass\n",
       "1 NA           "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# since we're now summarising our data we can go ahead and use the full dataframe, since the printout will be reasonably-sized\n",
    "\n",
    "penguins %>%\n",
    "  summarise(avg_body_mass = mean(body_mass_g))"
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.036613,
     "end_time": "2021-12-29T06:18:40.067385",
     "exception": false,
     "start_time": "2021-12-29T06:18:40.030772",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### The NAs!\n",
    "\n",
    "If we don't handle our `NA` values we're going to be in for a bad time. There are multiple ways of dealing with `NA` values in R - for now we're going to use `na.rm = TRUE`, but you could use `filter()` from the `dplyr` package or `drop_na()` from the `tidyr` package as well!  \n",
    "\n",
    "`na.rm` is like asking the question, \"Should we remove `NA`s from our code?\" where `na` stands for `NA` values, and `rm` stands for remove. So when we set `na.rm = TRUE` we're saying \"Yes, please remove `NA` values from my calculations.\" Likewise if we use `na.rm = FALSE` we're telling R that we want to include `NA` values in our calculations.  \n",
    "\n",
    "And if you're not sure, `NA` stands for \"Not Available,\" meaning data that is missing."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:40.149511Z",
     "iopub.status.busy": "2021-12-29T06:18:40.148108Z",
     "iopub.status.idle": "2021-12-29T06:18:40.169929Z",
     "shell.execute_reply": "2021-12-29T06:18:40.168628Z"
    },
    "papermill": {
     "duration": 0.06543,
     "end_time": "2021-12-29T06:18:40.170127",
     "exception": false,
     "start_time": "2021-12-29T06:18:40.104697",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 1 × 1</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>avg_body_mass</th></tr>\n",
       "\t<tr><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>4201.754</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 1 × 1\n",
       "\\begin{tabular}{l}\n",
       " avg\\_body\\_mass\\\\\n",
       " <dbl>\\\\\n",
       "\\hline\n",
       "\t 4201.754\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 1 × 1\n",
       "\n",
       "| avg_body_mass &lt;dbl&gt; |\n",
       "|---|\n",
       "| 4201.754 |\n",
       "\n"
      ],
      "text/plain": [
       "  avg_body_mass\n",
       "1 4201.754     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# summarising body mass on the entire penguins dataset while removing NA values from the calculation\n",
    "\n",
    "penguins %>%\n",
    "  summarise(avg_body_mass = mean(body_mass_g, na.rm = TRUE))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:40.250025Z",
     "iopub.status.busy": "2021-12-29T06:18:40.248731Z",
     "iopub.status.idle": "2021-12-29T06:18:40.278356Z",
     "shell.execute_reply": "2021-12-29T06:18:40.276927Z"
    },
    "papermill": {
     "duration": 0.07049,
     "end_time": "2021-12-29T06:18:40.278514",
     "exception": false,
     "start_time": "2021-12-29T06:18:40.208024",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` ungrouping output (override with `.groups` argument)\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 3 × 2</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>avg_species_body_mass</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>3700.662</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>3733.088</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>5076.016</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 3 × 2\n",
       "\\begin{tabular}{ll}\n",
       " species & avg\\_species\\_body\\_mass\\\\\n",
       " <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Adelie    & 3700.662\\\\\n",
       "\t Chinstrap & 3733.088\\\\\n",
       "\t Gentoo    & 5076.016\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 3 × 2\n",
       "\n",
       "| species &lt;chr&gt; | avg_species_body_mass &lt;dbl&gt; |\n",
       "|---|---|\n",
       "| Adelie    | 3700.662 |\n",
       "| Chinstrap | 3733.088 |\n",
       "| Gentoo    | 5076.016 |\n",
       "\n"
      ],
      "text/plain": [
       "  species   avg_species_body_mass\n",
       "1 Adelie    3700.662             \n",
       "2 Chinstrap 3733.088             \n",
       "3 Gentoo    5076.016             "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# now let's use the grouping function, group_by(), to look at the average body mass of penguins, in grams,\n",
    "# by species\n",
    "\n",
    "penguins %>%\n",
    "  group_by(species) %>%\n",
    "  summarise(avg_species_body_mass = mean(body_mass_g, na.rm = TRUE)) "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "metadata": {
    "execution": {
     "iopub.execute_input": "2021-12-29T06:18:40.360650Z",
     "iopub.status.busy": "2021-12-29T06:18:40.359214Z",
     "iopub.status.idle": "2021-12-29T06:18:40.388407Z",
     "shell.execute_reply": "2021-12-29T06:18:40.387194Z"
    },
    "papermill": {
     "duration": 0.070774,
     "end_time": "2021-12-29T06:18:40.388543",
     "exception": false,
     "start_time": "2021-12-29T06:18:40.317769",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` regrouping output by 'species' (override with `.groups` argument)\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 5 × 3</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>species</th><th scope=col>island</th><th scope=col>avg_species_body_mass</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>Adelie   </td><td>Biscoe   </td><td>3709.659</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Dream    </td><td>3688.393</td></tr>\n",
       "\t<tr><td>Adelie   </td><td>Torgersen</td><td>3706.373</td></tr>\n",
       "\t<tr><td>Chinstrap</td><td>Dream    </td><td>3733.088</td></tr>\n",
       "\t<tr><td>Gentoo   </td><td>Biscoe   </td><td>5076.016</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 5 × 3\n",
       "\\begin{tabular}{lll}\n",
       " species & island & avg\\_species\\_body\\_mass\\\\\n",
       " <chr> & <chr> & <dbl>\\\\\n",
       "\\hline\n",
       "\t Adelie    & Biscoe    & 3709.659\\\\\n",
       "\t Adelie    & Dream     & 3688.393\\\\\n",
       "\t Adelie    & Torgersen & 3706.373\\\\\n",
       "\t Chinstrap & Dream     & 3733.088\\\\\n",
       "\t Gentoo    & Biscoe    & 5076.016\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 5 × 3\n",
       "\n",
       "| species &lt;chr&gt; | island &lt;chr&gt; | avg_species_body_mass &lt;dbl&gt; |\n",
       "|---|---|---|\n",
       "| Adelie    | Biscoe    | 3709.659 |\n",
       "| Adelie    | Dream     | 3688.393 |\n",
       "| Adelie    | Torgersen | 3706.373 |\n",
       "| Chinstrap | Dream     | 3733.088 |\n",
       "| Gentoo    | Biscoe    | 5076.016 |\n",
       "\n"
      ],
      "text/plain": [
       "  species   island    avg_species_body_mass\n",
       "1 Adelie    Biscoe    3709.659             \n",
       "2 Adelie    Dream     3688.393             \n",
       "3 Adelie    Torgersen 3706.373             \n",
       "4 Chinstrap Dream     3733.088             \n",
       "5 Gentoo    Biscoe    5076.016             "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# now let's calculate the average body mass by species AND island\n",
    "\n",
    "penguins %>%\n",
    "  group_by(species, island) %>%\n",
    "  summarise(avg_species_body_mass = mean(body_mass_g, na.rm = TRUE)) "
   ]
  },
  {
   "cell_type": "markdown",
   "metadata": {
    "papermill": {
     "duration": 0.03851,
     "end_time": "2021-12-29T06:18:40.466381",
     "exception": false,
     "start_time": "2021-12-29T06:18:40.427871",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## Where to next?\n",
    "\n",
    "What we've done here only scratches the surface of what you can accomplish with `dplyr`. `dplyr` is a powerful package in its own right, but even more so once you dive into column-wise operations, like `across()`, as well as combine it with other packages in the Tidyverse, such as `purrr` and `ggplot2`.  \n",
    "\n",
    "What I recommend is making a copy of this notebook and running the cells to ensure you understand what's happening with each function, and then build out additional chains of `dplyr` functions to see what you can discover and learn! Play around and don't worry about making mistakes - it's all part of learning!   \n",
    "\n",
    "These are some helpful resources to get you started:  \n",
    "\n",
    "* [`dplyr` documentation - so many functions!](https://dplyr.tidyverse.org/reference/index.html)\n",
    "* [R for Data Science text](https://r4ds.had.co.nz/transform.html)\n",
    "* [STAT545](https://stat545.com/)\n",
    "* [More on column-wise operations](https://dplyr.tidyverse.org/articles/colwise.html)"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "3.6.3"
  },
  "papermill": {
   "duration": 8.242846,
   "end_time": "2021-12-29T06:18:40.614014",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2021-12-29T06:18:32.371168",
   "version": "2.1.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 4
}
