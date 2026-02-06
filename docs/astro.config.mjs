// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";
import starlightThemeBlack from "starlight-theme-black";
export default defineConfig({
	site: "https://nvdots.pages.dev/",
	viewTransitions: true,
	integrations: [
		starlight({
			title: "nvdocs",
			social: [{ icon: "github", label: "GitHub", href: "https://github.com/Voxi0/nvdots" }],
			plugins: [
				starlightThemeBlack({
					footerText: "neovim vimmity vi vi vim",
					navLinks: [{
						label: "docs",
						link: "/guides/getting-started",
					}],
				})
			],
			sidebar: [
				{
					label: "",
					autogenerate: { directory: "guides" },
				}
			],
		}),
	],
});
