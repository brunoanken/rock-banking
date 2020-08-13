defmodule Notifications.Email do
  @moduledoc """
  Module responsible for sending email notifications to users.
  """

  def send_withdraw_email(%{user: user, withdraw: withdraw}) do
    # let's pretend this puts a message in some queue that will later talk to some service that will send the email
    send_email(user.email, user.name, withdraw.amount)
  end

  defp send_email(email, name, amount) do
    IO.puts("""
      To: #{email}
      Message: Hello #{name}, you have just performed a withdraw of the following amount: R$ #{
      amount
    }

      Congratulations!
    """)
  end
end
