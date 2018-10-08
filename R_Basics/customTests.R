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
        swirl_out("Sorry, that was not quite correct. Now question is worth ",
                  qpts*(.8)^(e$attempts-1)," points. \n")
    } else {
        swirl_out("You got ",qpts*(.8)^(e$attempts-2),"points out of ",
              qpts, "possible points.\n")
        sid <<- eval(e$expr)
        cal <<- cal + qpts*(.8)^(e$attempts-2)
        if (e$row == NPREG+1) {
            report_calif(round(cal, digits=2))
        }     
    }
    rflag
}

check_var_is <- function(ans) {
    e <- get('e', parent.frame())
    rflag <- var_is_a('character','matr')
    
    if (!is.null(e$skips)) {
        swirl_out("***Test won't count because you skipped a question.***")
        return(rflag)
    }

    if (!rflag) {
        swirl_out("Sorry, that was not quite correct. Now question is worth ",
                qpts*(.8)^(e$attempts-1)," points. \n")
    } else {
        swirl_out("You got ",qpts*(.8)^(e$attempts-2),"points out of ",
                qpts, "possible points.\n")
        sid <<- eval(e$expr)
        cal <<- cal + qpts*(.8)^(e$attempts-2)      
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
    code_sid_name <- base64(paste(matr, calificacion, u, sep=","))[[1]]
    cat("Coded grade (and info): ", code_sid_name, "\n\n")
    pre_fill_link <- "https://docs.google.com/forms/d/e/1FAIpQLSfaXU8_jPwWcxfK43yfUdKgAy2cCz9Zzp03-lhJhIWpp5j3vg/viewform?usp=pp_url&entry.1798593314="
    pre_fill_link <- paste0(pre_fill_link, code_sid_name)
    sel <- menu(c("Yes", "No"), title="Do you want to report this grade to your instructor?")
    if (sel == 1) browseURL(pre_fill_link)
}
