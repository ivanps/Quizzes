# Put custom tests in this file.

# Uncommenting the following line of code will disable
# auto-detection of new variables and thus prevent swirl from
# executing every command twice, which can slow things down.

# AUTO_DETECT_NEWVAR <- FALSE

# However, this means that you should detect user-created
# variables when appropriate. The answer test, creates_new_var()
# can be used for for the purpose, but it also re-evaluates the
# expression which the user entered, so care must be taken.

check_omnitest <- function(correctExpr=NULL, correctVal=NULL, strict=FALSE) {
    # Get e
    e <- get('e', parent.frame())
    if (!is.null(correctExpr)) {
        rflag <- omnitest(correctExpr=correctExpr, strict=strict)
    } else {
        rflag <- omnitest(correctVal=correctVal, strict=strict)
    }

    if (!is.null(e$skips)) {
        swirl_out("***Test won't count because you skipped a question.***")
        return(rflag)
    }  
    
    if (!rflag) {
        swirl_out("Sorry, now question is worth ",qpts*(.9)^(e$attempts-1)," points. \n")
    } else {
        swirl_out("Got ",qpts*(.9)^(e$attempts-2)," in this question.\n")
        sid <<- eval(e$expr)
        cal <<- cal + qpts*(.9)^(e$attempts-2)
        if (e$row == NPREG+1) {
            report_calif(round(cal, digits=2))
        }     
    }
    rflag
}

check_var_is <- function(ans) {
    e <- get('e', parent.frame())
    rflag <- var_is_a('character','name')
    
    if (!is.null(e$skips)) {
        swirl_out("***Test won't count because you skipped a question.***")
        return(rflag)
    }

    if (!rflag) {
        swirl_out("Sorry, now question is worth ",qpts*(.9)^(e$attempts-1)," points. \n")
    } else {
        swirl_out("Got ",qpts*(.9)^(e$attempts-2)," in this question.\n")
        sid <<- eval(e$expr)
        cal <<- cal + qpts*(.9)^(e$attempts-2)      
        if (e$row == NPREG+1) {
            report_calif(round(cal, digits=2))
        }     
    }
    rflag
}

report_calif <- function(calificacion) {
    u <- as.integer(runif(1, min=0, max=100))
    cat("\n\n\nTEST RESULTS \n")
    cat("Grade: ", calificacion, "\n")
    cat("Coded grade: ", base64(paste(name,calificacion,u,sep="-"))[[1]], "\n\n")
    readline("...")
    cat("If you want to report your grade, open your browser and go \n")
    cat("to the following link and report to grade. \n")
    cat("https://docs.google.com/a/itesm.mx/forms/d/1CTLG2eVqOUjurzsb5GxOefb5gXvXTa1twMK8HYgFENY/viewform")
    cat("\n\n\n")
    readline("...")
    cat("Don't forget that you can take the test again, but you have\n")
    cat("to send your grade at the end, before the deadline.\n\n\n")
}