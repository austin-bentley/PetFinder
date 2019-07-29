alias PetFinder.Repo
alias PetFinder.Account.User
alias Comeonin.Bcrypt

Repo.insert! %User {
  username: "User1!",
  encrypted_password: Bcrypt.hashpwsalt("cars1"),
  zip_code: "87110"
}

Repo.insert! %User {
  username: "User2!",
  encrypted_password: Bcrypt.hashpwsalt("cars2"),
  zip_code: "87110"
}

Repo.insert! %User {
  username: "User3!",
  encrypted_password: Bcrypt.hashpwsalt("cars3"),
  zip_code: "87111"
}
