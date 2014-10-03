# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

check_omnitest <- function(result) {
    # Get e
    e <- get('e', parent.frame())
    rflag <- omnitest(result)
    if (!rflag) {
        qpts <<- .9*qpts
        cat("Sorry, now question is worth ",qpts," points. \n")
    } else {
        cat("Got ",qpts," in this question.\n")
        cal <<- cal + qpts
        qpts <<- 10
    }
    rflag
}

check_var_is <- function(ans) {
    e <- get('e', parent.frame())
    rflag <- var_is_a('character','name')
    if (!rflag) {
        qpts <<- .9*qpts
        cat("Sorry, now question is worth ",qpts," points. \n")
    } else {
        cat("Got ",qpts," in this question.\n")
        sid <<- eval(e$expr)
        cal <<- cal + qpts
        qpts <<- 10
    }
    rflag
}