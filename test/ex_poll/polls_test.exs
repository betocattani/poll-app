defmodule ExPoll.PollsTest do
  use ExPoll.DataCase

  alias ExPoll.Polls

  describe "polls" do
    alias ExPoll.Polls.{Poll, Option}

    @valid_attrs %{question: "some question"}
    @update_attrs %{question: "some updated question"}
    @invalid_attrs %{question: nil}
    @valid_with_options_attrs %{
      question: "some question",
      options: [%{value: "A"}, %{value: "B"}]
    }

    @valid_with_new_options_attrs %{
      options: [%{value: "C"}, %{value: "D"}]
    }

    def poll_fixture(attrs \\ %{}) do
      {:ok, poll} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polls.create_poll()

      poll
    end

    test "list_polls/0 returns all polls" do
      poll =
        %Poll{}
        |> Poll.changeset(@valid_attrs)
        |> Repo.insert!()

      assert Polls.list_polls() == [poll]
    end

    test "get_poll!/1 returns the poll with given id" do
      poll = poll_fixture()
      assert Polls.get_poll!(poll.id) == poll
    end

    test "create_poll/1 with valid data creates a poll" do
      assert {:ok, %Poll{} = poll} = Polls.create_poll(@valid_attrs)
      assert poll.question == "some question"
    end

    test "create_poll/1 with options create a poll with options" do
      assert {:ok, %Poll{} = poll} = Polls.create_poll(@valid_with_options_attrs)
      assert poll.question == "some question"
      assert [%Option{value: "A"}, %Option{value: "B"}] = poll.options
    end

    test "create_poll/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_poll(@invalid_attrs)
    end

    test "update_poll/2 with valid data updates the poll" do
      poll = poll_fixture()
      assert {:ok, %Poll{} = poll} = Polls.update_poll(poll, @update_attrs)
      assert poll.question == "some updated question"
    end

    test "updatea_poll/2 with new options updateas the options" do
      poll = poll_fixture()
      assert {:ok, %Poll{} = poll} = Polls.update_poll(poll, @valid_with_new_options_attrs)
      assert poll.question == "some question"
      assert [%Option{value: "C"}, %Option{value: "D"}] = poll.options
    end

    test "update_poll/2 with invalid data returns error changeset" do
      poll = poll_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_poll(poll, @invalid_attrs)
      assert poll == Polls.get_poll!(poll.id)
    end

    test "delete_poll/1 deletes the poll" do
      poll = poll_fixture()
      assert {:ok, %Poll{}} = Polls.delete_poll(poll)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_poll!(poll.id) end
    end

    test "change_poll/1 returns a poll changeset" do
      poll = poll_fixture()
      assert %Ecto.Changeset{} = Polls.change_poll(poll)
    end
  end

  describe "options" do
    alias ExPoll.Polls.Option

    @valid_attrs %{value: "some option"}
    @update_attrs %{value: "some updated option"}
    @invalid_attrs %{value: nil}

    def option_fixture(attrs \\ %{}) do
      attrs = Enum.into(attrs, @valid_attrs)
      {:ok, poll} = Polls.create_poll(%{question: "some question"})
      {:ok, option} = Polls.create_option(poll, attrs)

      option
    end

    test "get_option!/1 returns the option with given id" do
      option = option_fixture()
      assert Polls.get_option!(option.id) == option
    end

    test "create_option/1 with valid data creates a option" do
      poll = poll_fixture()
      assert {:ok, %Option{} = option} = Polls.create_option(poll, @valid_attrs)
      assert option.value == "some option"
    end

    test "create_option/1 with invalid data returns error changeset" do
      poll = poll_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.create_option(poll, @invalid_attrs)
    end

    test "update_option/2 with valid data updates the option" do
      option = option_fixture()
      assert {:ok, %Option{} = option} = Polls.update_option(option, @update_attrs)
      assert option.value == "some updated option"
    end

    test "update_option/2 with invalid data returns error changeset" do
      option = option_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_option(option, @invalid_attrs)
      assert option == Polls.get_option!(option.id)
    end

    test "delete_option/1 deletes the option" do
      option = option_fixture()
      assert {:ok, %Option{}} = Polls.delete_option(option)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_option!(option.id) end
    end

    test "change_option/1 returns a option changeset" do
      option = option_fixture()
      assert %Ecto.Changeset{} = Polls.change_option(option)
    end
  end

  describe "votes" do
    alias ExPoll.Polls.{Option, Vote}

    test "create_vote/1 with an option creates a vote" do
      option = option_fixture()
      assert %Option{vote_count: 0} = option
      assert {:ok, %Vote{} = _vote} = Polls.create_vote(option)
      assert %Option{vote_count: 1} = Polls.get_option!(option.id)
    end
  end
end
