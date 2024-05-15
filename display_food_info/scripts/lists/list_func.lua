-- declare List
List = {
	size=0 -- 列表大小
}
 

-- declare functions
--~ 构造方法
function List:new(...)
	-- 如果存在值，将值构建成table并设置大小
	local values = {...}
	values.size = table.getn(values)
 
	-- 设置元表
	setmetatable(values, {
		-- 绑定List元表（新表查询不存在时，从List表查询）
		__index = self,
		-- 返回字符串
		__tostring = function(self)
			local str = "["
			for i = 1, self.size do
				-- 如果元素为元表，获取元表值
				if "table" == type(self[i]) then
					str = str .. "{" .. table.concat(self[i], ", ") .. "}, "
				else -- 否则，直接连接
					str = str .. tostring(self[i]) .. ", "
				end
			end
			return string.sub(str, 1, ((self.size > 0 and -3) or -1)) .. "]"
		end,
		-- 加法操作
		__add = function(self, tab)
			-- 如果不是元表，抛出异常
			if "table" ~= type(tab) then
				error(tostring(tab) .. " is not a table")
			end
 
			-- 创建新表，添加当前表和tab表元素
			local temp = List()
			for i = 1, self.size do
				temp:add(self[i])
			end
			for i, v in ipairs(tab) do
				temp:add(v)
			end
			return temp
		end
	})
	return values
end
 
--~ 添加指定值
function List:add(e, index)
	if not index then		-- index为空，添加到列表末尾
		self[self.size + 1] = e
	elseif "number" ~= type(index) then 	-- index非数字，抛出异常
		error(tostring(index) .. " is not a number")
	else
		-- 负数下标转换
		if index < 0 then
			index = self.size + index + 2
		end
 
		index = math.ceil(index)
 
		-- 下标越界，抛出异常
		if index > self.size + 1 or index <= 0 then
			error("Array out of bound: " .. tostring(index))
		end
 
		-- 后移index开始的元素，将e付给index下标元素
		local i = self.size
		while i >= index do
			self[i + 1] = self[i]
			i = i - 1
		end
		self[index] = e
	end
 
	self.size = self.size + 1
end
 
--~ 移除指定下标元素
function List:remove(index)
	-- 如果非数字，抛出异常
	if ("number" ~= type(index)) then
		error(tostring(index) .. " is not a number")
	end
 
	-- 负数，转换为正数
	if index < 0 then
		index = self.size + index + 1
	end
 
	index = math.ceil(index)
 
	-- 获取移除位元素（不存在时返回nil）
	local e = self[index]
	-- 前移从index开始的元素
	for i = index, self.size do
		self[i] = self[i + 1]
	end
	self.size = self.size - 1
 
	return e
end
 
 
--~ 获取子列表
function List:sub(startIndex, endIndex)
	-- 判断startIndex是否为数字
	if ("number" ~= type(startIndex)) then
		error(tostring(startIndex) .. " is not a number")
	end
 
	-- 将下标转换为正数
	if startIndex < 0 then
		startIndex = self.size + startIndex + 1
	end
 
	-- 如果下标越界，抛出异常
	if startIndex <= 0 or startIndex > self.size then
		error("Array out of bound: " .. tostring(startIndex))
	end
 
	-- 创建List
	local temp = List:new()
	-- 如果endIndex为空
	if not endIndex then
		-- temp添加元素
		for i = startIndex, self.size do
			temp:add(self[i])
		end
	else -- endIndex不为空
		-- 判断endIndex是否为数字
		if ("number" ~= type(endIndex)) then
			error(tostring(endIndex) .. " is not a number")
		end
 
		-- 转换为正数
		if endIndex < 0 then
			endIndex = self.size + endIndex + 1
		end
 
		-- 如果endIndex < startIndex，抛出异常
		if endIndex < startIndex then
				error("endtIndex(" .. tostring(endIndex) .. ") can not be less than startIndex(" .. startIndex .. ")")
		end
 
		-- 如果下标越界，抛出异常
		if endIndex <= 0 or endIndex > self.size then
			error("Array out of bound: " .. tostring(endIndex))
		end
 
		-- temp添加元素
		for i = startIndex, endIndex do
			temp:add(self[i])
		end
	end
 
	return temp
end
 
--~ 获取列表长度
function List:length()
	return self.size
end
 
--~ 判断列表是否为空
function List:isEmpty()
	return 0 == self:length()
end
 
 
-- set meta table
setmetatable(List, {
	-- List（...）方法
	__call = function(self, ...)
		return self:new(...)
	end
})
 
 
-- return module
return List
 