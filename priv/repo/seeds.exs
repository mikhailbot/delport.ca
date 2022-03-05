alias DelportCa.Repo
alias DelportCa.Accounts
alias DelportCa.Content

{:ok, _} =
  Accounts.register_user(%{
    email: Faker.Internet.email(),
    password: "secretpassword",
    confirmed_at: DateTime.now!("Etc/UTC")
  })

for i <- 0..10 do
  Repo.insert!(%Content.Post{
    title: Faker.StarWars.quote(),
    body: Faker.Lorem.paragraphs(5) |> Enum.join(" "),
    date: Faker.Date.backward(1000)
  })
end
