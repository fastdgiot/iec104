defmodule IEC104.Frame.InformationTransfer do
  alias IEC104.Frame.SequenceNumber

  @type t() :: %__MODULE__{
          sent_sequence_number: integer(),
          received_sequence_number: integer()
        }
  defstruct [:sent_sequence_number, :received_sequence_number]

  def encode(%{sent_sequence_number: sent, received_sequence_number: received}) do
    <<SequenceNumber.encode(sent)::bytes-size(2), SequenceNumber.encode(received)::bytes-size(2)>>
  end

  def decode(<<_::7, 0::1, _rest::bitstring>> = control_flags) do
    <<sent::bytes-size(2), received::bytes-size(2)>> = control_flags

    %__MODULE__{
      sent_sequence_number: SequenceNumber.decode(sent),
      received_sequence_number: SequenceNumber.decode(received)
    }
  end
end
