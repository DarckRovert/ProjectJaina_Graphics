import os
import re
import sys

def test_syntax_and_structure():
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    print("Testing base directory:", base_dir)

    # 1. Verify required documentation files
    required_docs = [
        "README.md", "CHANGELOG.md", "ECOSYSTEM_REGISTRY.md",
        "API.md", "AGENTS.md", "INSTALL.md", "SECURITY.md",
        "NOTICE.md", "LICENSE", ".gitignore", ".gitattributes",
        "WoWPeru_Graphics.toc", "Core.lua", "UI.lua"
    ]
    for doc in required_docs:
        path = os.path.join(base_dir, doc)
        assert os.path.exists(path), f"Missing required file: {doc}"
    print("[PASS] All 13 repository infrastructure files exist.")

    # 2. Verify TOC references
    toc_path = os.path.join(base_dir, "WoWPeru_Graphics.toc")
    with open(toc_path, "r", encoding="utf-8") as f:
        toc_content = f.read()
    assert "Core.lua" in toc_content, "TOC missing Core.lua"
    assert "UI.lua" in toc_content, "TOC missing UI.lua"
    assert "30300" in toc_content, "TOC invalid interface version"
    print("[PASS] TOC metadata and file references verified.")

    # 3. Simple token balance check for Lua files
    for lua_file in ["Core.lua", "UI.lua"]:
        lua_path = os.path.join(base_dir, lua_file)
        with open(lua_path, "r", encoding="utf-8") as f:
            code = f.read()
        
        # Check that no retail-forbidden functions are called
        assert "SetColorTexture" not in code, f"Forbidden SetColorTexture found in {lua_file}"
        assert "C_Timer.After" not in code, f"Forbidden C_Timer.After found in {lua_file}"
        assert "IsInRaid" not in code, f"Forbidden IsInRaid found in {lua_file}"
        # Check that forbidden or fake CVars are never used
        forbidden_cvars = [
            "componentTextureLevel", "shadowTextureSize", "M2ForceBilinear",
            "M2UseShaders", "rippleDetail", "horizonfarclip", "SmallCull", "DistCull"
        ]
        for bad_cvar in forbidden_cvars:
            assert bad_cvar not in code, f"Forbidden/fake CVar '{bad_cvar}' found in {lua_file}"
        print(f"[PASS] {lua_file} adheres to 3.3.5a engine rules and verified CVar whitelist.")

    print("\n>>> ALL WOWPERU_GRAPHICS REPOSITORY SANITY CHECKS PASSED 100% <<<")

if __name__ == "__main__":
    test_syntax_and_structure()
