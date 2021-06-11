defmodule ExPoll.Polls.Option do
  use Ecto.Schema
  import Ecto.Changeset

  schema "options" do
    field :value, :string
    field :poll_id, :id

    timestamps()
  end

  @doc false
  def changeset(option, attrs) do
    option
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
