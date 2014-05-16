function test()
    local t = {}

    for i=1,1000 do
        local var = {}
        t[i] = var
        for j=1,100 do
            local var = {}
            var[1] = {"123"}
            var[1000] = function() print(var) end
            local var2 = {}
            var2[1] = {1, 2, 3}
            var2[1000] = function() print("hello") end
            t[i][j] = var
        end
    end
end


