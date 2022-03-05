alias DelportCa.Repo
alias DelportCa.Accounts
alias DelportCa.Content

{:ok, _} =
  Accounts.register_user(%{
    email: Faker.Internet.email(),
    password: "secretpassword",
    confirmed_at: DateTime.now!("Etc/UTC")
  })

for _ <- 0..20 do
  Repo.insert!(%Content.Post{
    title: Faker.StarWars.quote() |> String.slice(0..75),
    body: Faker.Lorem.paragraphs(5) |> Enum.join(" "),
    date: Faker.Date.backward(2000)
  })
end
