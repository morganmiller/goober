var SetIntervalMixin = {
  componentWillMount: function() {
    this.intervals = [];
  },
  setInterval: function() {
    this.intervals.push(setInterval.apply(null, arguments));
  },
  componentWillUnmount: function() {
    this.intervals.map(clearInterval);
  }
};

var RideStatus = React.createClass({
  mixins: [SetIntervalMixin],

  getInitialState: function(){
    return {ride: this.props.initialRide, time: this.props.initialTime}
  },

  componentDidMount: function() {
    this.setInterval(this.updateStatus, 3000);
  },

  updateStatus: function() {
    $.ajax({
      url: '/rides/' + this.props.initialRide.id,
      success: function(response) {
        this.setState({ride: response.ride, time: response.time});
      }.bind(this)
    })
  },

  clearRide: function(){
    if(this.state.ride.status === "completed") {
      return(
        <div className="clear-ride">
          <button type="button" className="clear-ride-btn">Clear Ride</button>
        </div>
      )
    }
  },

  render: function() {
    return (
      <p>Your ride was marked {this.state.ride.status} on {this.state.time} {this.clearRide()}</p>
    )
  }
});
