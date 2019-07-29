alias PetFinder.Repo
alias PetFinder.Pet.Post

Repo.insert!(%Post{
  animal_id: 1,
  description: "3 year old brown lab/pit mix. Blue collar",
  status: "lost"
})

Repo.insert!(%Post{
  animal_id: 2,
  description: "Small calico cat, very noisy and hates everone.",
  status: "found"
})

Repo.insert!(%Post{
  animal_id: 3,
  description: "Turqoise green cheeck conure. Loves raspberries and sunflower seeds. Can fly but chooses not too more often than not.",
  status: "home"
})


