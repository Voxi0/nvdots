// @ts-check
import { defineConfig } from "astro/config";
import starlight from "@astrojs/starlight";

// https://astro.build/config
export default defineConfig({
	site: "https://nvdots.pages.dev/",
	integrations: [
		starlight({
			title: "nvdocs",
			social: [{ icon: "github", label: "GitHub", href: "https://github.com/Voxi0/nvdots" }],
			sidebar: [
				{
					label: "Getting Started",
					autogenerate: { directory: "guides" },
				}
			],
		}),
	],

	viewTransitions: false,
	prefetch: true,
	build: {
		inlineStylesheets: "always",
	},
});
