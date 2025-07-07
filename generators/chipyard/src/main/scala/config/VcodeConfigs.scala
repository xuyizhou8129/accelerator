package chipyard.config

import org.chipsalliance.cde.config._
import freechips.rocketchip.subsystem._
import vcoderocc._

class VCodeConfig extends Config(
  new WithVCodeAccel ++
  new WithVCodePrintf ++  // Optional: for debug prints
  new WithNBigCores(1) ++
  new BaseConfig
)

class VCodeSmallConfig extends Config(
  new WithVCodeAccel ++
  new WithVCodePrintf ++
  new WithNBigCores(1) ++
  new WithCoherentBusTopology ++
  new BaseConfig
)