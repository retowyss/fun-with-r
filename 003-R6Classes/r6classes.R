# Best install tidyverse for this
library(R6)

## List

fancy_list <- R6Class(classname = "fancy-list",
  private = list(
    x = rlang::new_environment()
  ),
  public = list(
    print = function() {
      purrr::walk(ls(private$x), function(.key) {
        key <- stringr::str_pad(.key, 32)
        obj <- str_trunc(rlang::expr_text(private$x[[.key]]), 64)
        cat(key, " = ", obj, "\n")  
      })
    },
    set = function(key, value) {
      private$x[[key]] <- value
      invisible(self)
    },
    get = function(key) {
      private$x[[key]]
    }
  )
)

h <- fancy_list$new()

h$
  set("a", list(1, 2))$
  set("q", 4)$
  set("another-object", list(a = 3, b = 5))$
  set("a-model", lm(Sepal.Length ~ ., iris))

print(h)

## Tic Tac Toe

tic_tac_toe <- R6Class("tic-tac-toe", 
  private = list(
    board = matrix(rep(".", 9), nrow = 3),
    # Player 1 (1), Player  2 (-1)
    to_move = 1,
    draw = list("1" = "x", "-1" = "o")
  ),
  public = list(
    print = function() {
      purrr::walk(1:3, ~ cat(private$board[., 1:3], "\n"))
    },
    play = function(x, y) {
      private$board[[x, y]] <- private$draw[[private$to_move]]
      private$to_move <- private$to_move * (-1) 
      invisible(self)
    }
  )
)

ttt <- tic_tac_toe$new()

ttt$
  play(1, 1)$
  play(2, 2)$
  play(1, 2)$
  play(3, 1)$
  play(1, 3)

print(x)  


## This is a coin -------------------------------------------------------------

coin <- R6Class("coin",
  private = list(
    .p = NA_real_
  ),
  public = list(
    initialize = function(p = 0.5) {
      stopifnot(p <= 1, p >= 0)
      private$.p <- p
    },
    flip = function(n = 1) {
      runif(n) <= private$.p
    }
  )  
) 


fair_coin <- coin$new()
fair_coin$flip(10)

biased_coin <- coin$new(p = .9)
biased_coin$flip(100)

# This looks boring, now consider this

up <- runif(1)
ic <- coin$new(p = up)

# We want to find the unkown probability "up"
# let's flip the coin n times and take m samples

n <- 100
m <- 10000

flip_means <- as.double(purrr::rerun(m, mean(ic$flip(n = n)))) 

mean(flip_means)
sd(flip_means)
hist(flip_means)




