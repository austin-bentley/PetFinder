alias PetFinder.Repo
alias PetFinder.Pet.Image


Repo.insert!(%Image{
  id: 1,
  image: %{file_name: "frodo-dogo.jpg", updated_at: ~N[2019-08-08 15:44:48]},
  animal_id: 1,
  })

Repo.insert!(%Image{
  id: 2,
  image: %{file_name: "dane.jpg", updated_at: ~N[2019-08-08 15:44:49]},
  animal_id: 2,
  })

Repo.insert!(%Image{
  id: 3,
  image: %{file_name: "handful.jpg", updated_at: ~N[2019-08-08 15:44:47]},
  animal_id: 3,
})

Repo.insert!(%Image{
  id: 4,
  image: %{file_name: "happy-dog.jpg", updated_at: ~N[2019-08-08 15:44:50]},
  animal_id: 4,
})

Repo.insert!(%Image{
  id: 5,
  image: %{file_name: "normal-dog.jpeg", updated_at: ~N[2019-08-08 15:44:51]},
  animal_id: 5,
})

Repo.insert!(%Image{
  id: 6,
  image: %{file_name: "old-boy.jpeg", updated_at: ~N[2019-08-08 15:44:52]},
  animal_id: 6,
})
