alias PetFinder.Repo
alias PetFinder.Pet.Animal

Repo.insert!(%Animal{
  color: ["brown"],
  species: "Dog",
  location: "87108",
  user_id: 1
})

Repo.insert!(%Animal{
  color: ["orange", "black", "white"],
  species: "Cat",
  location: "23421",
  user_id: 1
})

Repo.insert!(%Animal{
  color: ["brown", "teal"],
  species: "dog",
  location: "87113",
  user_id: 1
})

Repo.insert!(%Animal{
  color: ["green", "teal"],
  species: "Bird",
  location: "87112",
  user_id: 1
})

Repo.insert!(%Animal{
  color: ["black"],
  species: "Dog",
  location: "87117",
  user_id: 2
})

Repo.insert!(%Animal{
  color: ["yellow"],
  species: "Dog",
  location: "87110",
  user_id: 3
})
