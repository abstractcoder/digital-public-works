defmodule DigitalPublicWorks.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  alias DigitalPublicWorks.Accounts.{User, ProjectInvite}
  alias DigitalPublicWorks.Projects.{ProjectFollower, ProjectUser}
  alias DigitalPublicWorks.Posts.Post

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "projects" do
    field :body, :string
    field :title, :string
    field :is_featured, :boolean
    field :is_public, :boolean, default: :false
    belongs_to :user, User
    has_many :posts, Post
    many_to_many :followers, User, join_through: ProjectFollower
    many_to_many :users, User, join_through: ProjectUser
    has_many :project_invites, ProjectInvite

    timestamps()
  end

  @doc false
  def changeset(project, attrs \\ %{}) do
    project
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
    |> unique_constraint(:title)
    |> Ecto.Changeset.foreign_key_constraint(:followers,
      name: "projects_followers_project_id_fkey",
      message: "You can't delete a project that has followers."
    )
  end
end
