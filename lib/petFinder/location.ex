defmodule PetFinder.Location do
  import Ecto.Query, warn: false
  alias PetFinder.Repo

  alias PetFinder.Pet.Animal
  alias PetFinder.Pet.Post
  alias PetFinder.Account

  def get_posts_near_user(nil), do: nil
  def get_posts_near_user(user_id) do
    get_zip_codes(user_id)
    |> get_user_ids_by_zip_codes()
    |> get_most_recent_post_by_animal()
  end

  defp get_user_ids_by_zip_codes(zip_list) do
    Animal
    |> where([a], a.location in ^zip_list)
    |> select([a], a.user_id)
    |> Repo.all()
  end

  def get_most_recent_post_by_animal(user_id_list) do
    Post
    |> where([p], p.animal_id in ^user_id_list)
    |> order_by(desc: :updated_at)
    |> distinct(desc: :animal_id)
    |> Repo.all()
  end

  defp get_zip_codes(user_id) do
    Account.get_user!(user_id)
    |> Map.get(:zip_code, "")
    |> nearby_zips_request()
    |> format_zips_into_list()
  end

  defp nearby_zips_request(zip) do
    case HTTPoison.get("https://www.zipcodeapi.com/rest/xViDTqMu89M34fHGfguSlO0VPpVkXEulf9uZ1yMvBbsOR4d8h0HfJCiv5m8XUyTd/radius.json/#{zip}/4/mile") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode!(body)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.inspect(label: "ERROR: No zip codes found!")
      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason, label: "ERROR: ")
    end
  end

  defp format_zips_into_list(request_body) do
    request_body["zip_codes"]
    |> Enum.map(& &1["zip_code"])
  end
end
