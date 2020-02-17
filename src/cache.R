compute_file_hash <- function(path) {
  string <- readr::read_file(path)
  hash <- digest::digest(string, algo = "md5", serialize = F)
  return(hash)
}

get_hash_cache <- function(dir, file) {
  path <- file.path(dir, file)
  if (dir.exists(dir) && file.exists(path)) {
    df <- readr::read_csv(path)
    hashes <- hashmap::hashmap(df$Path, df$Hash)
    return(hashes)
  }
  return(hashmap::hashmap(character(), character()))
}

write_hash_cache <- function(dir, file, map) {
  df <- data.frame(Path = map$keys(), Hash = map$values())
  colnames(df) <- c("Path", "Hash")

  if (!dir.exists(dir)) {
    dir.create(dir)
  }
  write.csv(df, file = file.path(dir, file))
}

in_hash_cache <- function(filename, put) {
  file_hash <- compute_file_hash(filename)
  hash_cache <- get_hash_cache("cache", "file_hash.csv")
  found <- TRUE
  if (!hash_cache$has_key(filename)) {
    if (put) {
      hash_cache[[filename]] <- file_hash
    }
    found <- FALSE
  } else {
    found <- hash_cache[[filename]] == file_hash
  }

  write_hash_cache("cache", "file_hash.csv", hash_cache)
  return(found)
}
