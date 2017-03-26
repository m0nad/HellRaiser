class ScansChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'scans'
  end
end
