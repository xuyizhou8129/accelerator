package chipyard

import org.chipsalliance.cde.config._
import freechips.rocketchip.subsystem._
import freechips.rocketchip.rocket.WithNHugeCores
import freechips.rocketchip.system.BaseConfig
import roccacc._

class RoccAccConfig extends Config(
  new WithRoccAccPrintf ++
  new WithRoccAcc ++
  new WithNHugeCores(1) ++
  new chipyard.config.AbstractConfig
)