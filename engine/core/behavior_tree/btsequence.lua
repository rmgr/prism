--- Executes each child in order. If every child succeeds, the sequence succeeds. If any
--- child fails, the sequence fails. If a child returns an ``Action``, execution pauses and
--- that action is returned immediately.
--- @class BehaviorTree.Sequence : BehaviorTree.Node
--- @overload fun(children: BehaviorTree.Node[]): BehaviorTree.Sequence
local BTSequence = prism.BehaviorTree.Node:extend("BehaviorTree.Sequence")

--- Creates a new BTSequence.
--- @param children BehaviorTree.Node[]
function BTSequence:__new(children)
   self.children = children
end

--- Runs the sequence node.
--- @param level Level
--- @param actor Actor
--- @param controller Controller
--- @return boolean|Action
function BTSequence:run(level, actor, controller)
   for i, child in ipairs(self.children) do
      local result = child:run(level, actor, controller)
      if result == false then return false end
      if type(result) == "table" then return result end
   end
   return true
end

return BTSequence
