module.exports =
  todayEpoch: new Date().getTime()
  nextweekEpoch: new Date(new Date().getTime() + (7*24*60) * 60000).getTime()
  lastweekEpoch: new Date(new Date().getTime() - (7*24*60) * 60000).getTime()
  twoweeksagoEpoch: new Date(new Date().getTime() - 2*(7*24*60) * 60000).getTime()
  lastmonthEpoch: new Date(new Date().getTime() - 4*(7*24*60) * 60000).getTime()
  threemonthsagoEpoch: new Date(new Date().getTime() - 12*(7*24*60) * 60000).getTime()
  sixmonthsagoEpoch: new Date(new Date().getTime() - 24*(7*24*60) * 60000).getTime()