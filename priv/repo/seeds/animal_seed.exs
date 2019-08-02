alias PetFinder.Repo
alias PetFinder.Pet.Animal

Repo.insert!(%Animal{
  color: ["brown"],
  species: "Dog",
  user_id: 1
})

Repo.insert!(%Animal{
  color: ["orange", "black", "white"],
  species: "Cat",
  user_id: 1
})

Repo.insert!(%Animal{
  color: ["brown", "teal"],
  species: "dog",
  user_id: 1
})

Repo.insert!(%Animal{
  color: ["green", "teal"],
  species: "Bird",
  user_id: 1
})

Repo.insert!(%Animal{
  color: ["black"],
  species: "Dog",
  user_id: 2
})

Repo.insert!(%Animal{
  color: ["yellow"],
  species: "Dog",
  user_id: 3
})
