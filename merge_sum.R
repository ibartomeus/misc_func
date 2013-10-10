#this function merges two dataframes, while summing common columns
#From: http://stackoverflow.com/questions/14731861/merge-data-frames-whilst-summing-common-columns-in-r

merge_sum <- function(.df1, .df2, .id_columns, .match_columns){
  #this function merges two dataframes, while summing common columns
  #Args: df1 & 2 are dataframes to sum-merge
  #Returns: a sum-merged data.frame
  merged_columns <- unique(c(names(.df1),names(.df2)))
  merged_df1 <- data.frame(matrix(nrow=nrow(.df1), ncol=length(merged_columns)))
  names(merged_df1) <- merged_columns
  for (column in merged_columns){
    if(column %in% .id_columns | !column %in% names(.df2)){
      merged_df1[, column] <- .df1[, column]
    } else if (!column %in% names(.df1)){
      merged_df1[, column] <- .df2[match(.df1[, .match_columns],.df2[, .match_columns]), column]
    } else {
      df1_values=.df1[, column]
      df2_values=.df2[match(.df1[, .match_columns],.df2[, .match_columns]), column]
      df2_values[is.na(df2_values)] <- 0
      merged_df1[, column] <- df1_values + df2_values
    }
  }
  return(merged_df1)
}
###