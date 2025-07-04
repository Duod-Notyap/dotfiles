local ls = require("luasnip")

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local l = require("luasnip.extras").lambda
local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
local m = require("luasnip.extras").match
local n = require("luasnip.extras").nonempty
local dl = require("luasnip.extras").dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local types = require("luasnip.util.types")
local conds = require("luasnip.extras.conditions")
local conds_expand = require("luasnip.extras.conditions.expand")

local copy;
function copy(args)
    return args[1]
end


ls.add_snippets("cpp", {
    s("ecenum", {
        t("enum class "), i(1, "error_name"), t({" {",
        ""}), i(0), t({"",
        "}",
        "",
        "struct "}), f(copy, 1), t({"_category : public std::error_category {",
        "    const char* name() const noexcept {"}),
      t("        return \""), f(copy, 1), t({"\";",
        "    }",
        "",
        "    std::string message(int ev) const noexcept {",
        "        switch(static_cast<"}), f(copy, 1), t({">(ev)) {",
        "        //TODO",
        "        }",
        "        return \"TODO\";",
        "    }",
        "};",
        "",
        "std::error_code make_error_code(const "}), f(copy, 1), t({"& ec) noexcept {",
        "    return {static_cast<int>(ec), "}), f(copy, 1), t({"_category{}};",
        "}",
        "",
        "namespace std {",
        "    template <>",
        "    class is_error_code_enum<"}), i(2), f(copy, 1), t({"> : public true_type {};",
        "} /* std */"})
    })
})
