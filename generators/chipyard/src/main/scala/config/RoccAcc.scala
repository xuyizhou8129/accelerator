package chipyard.config

import org.chipsalliance.cde.config._
import freechips.rocketchip.subsystem._
import roccacc._

class RoccAccConfig extends Config(
  new WithRoccAcc ++
  new WithNBigCores(1) ++
  new BaseConfig
)