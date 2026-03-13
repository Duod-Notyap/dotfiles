local path = "/mnt/c/users/dell/test/test.sh";
local dir = string.match(path, [[.*[/\\]([^/\\]*)[/\\][^/\\]*$]] )
print(path, dir);
