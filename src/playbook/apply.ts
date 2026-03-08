import { $ } from "bun";

export enum MiseType {
    Runtime,
    Tool
}

export interface MisePkg {
    name: string;
    type: MiseType;
    use: boolean; // Only install if false (true sets it globally)
    version?: string; // Install latest if empty
}

// TODO 2 packages array needed: defauts + user defined
// Input array based on your example, expanded to show different cases
const misePkgs: MisePkg[] = [
    {
        name: "lazygit", // Duplicate to test deduplication
        type: MiseType.Tool,
        use: true
    },
    {
        name: "helix", // Duplicate to test deduplication
        type: MiseType.Tool,
        use: true
    },
    {
        name: "go",
        type: MiseType.Runtime,
        use: true
    },
    {
        name: "python",
        type: MiseType.Runtime,
        use: true,
        // version: "3.12" // Specific version
    }
];

async function installMisePackages(packages: MisePkg[]) {
    console.log("🚀 Starting mise packages installation...");

    // Keep track of processed packages to avoid running duplicate commands
    const processed = new Set<string>();

    for (const pkg of packages) {
        // Resolve target version (default to '@latest' if undefined)
        const versionStr = pkg.version ? `@${pkg.version}` : "@latest";
        const target = `${pkg.name}${versionStr}`;

        // Create a unique key to prevent duplicate installations
        const uniqueKey = `${target}-${pkg.use}`;
        if (processed.has(uniqueKey)) {
            console.log(`⏭️  Skipping duplicate entry: ${target}`);
            continue;
        }
        processed.add(uniqueKey);

        try {
            if (pkg.use) {
                console.log(`📦 Using (and installing) globally: ${target}`);
                // 'mise use -g' installs the tool and sets it as the global default in ~/.config/mise/config.toml
                await $`mise use --global ${target}`;
            } else {
                console.log(`📥 Installing only: ${target}`);
                // 'mise install' only downloads and builds the tool without setting it as default
                await $`mise install ${target}`;
            }
            console.log(`✅ Successfully processed: ${target}\n`);
        } catch (error) {
            console.error(`❌ Failed to process ${target}:`, error);
            // Optional: process.exit(1) if you want to abort on first failure
        }
    }

    console.log("🎉 All mise packages have been processed!");
}

// Execute the async function
await installMisePackages(misePkgs);
