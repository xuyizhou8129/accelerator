package chipyard

import org.chipsalliance.cde.config._
import freechips.rocketchip.subsystem._
import freechips.rocketchip.rocket.WithNBigCores
import freechips.rocketchip.system.BaseConfig
import roccacc._

class RoccAccConfig extends Config(
  new WithRoccAcc ++
  new WithNBigCores(1) ++
  new chipyard.config.AbstractConfig
)