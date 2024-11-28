#!/bin/bash

# Create the base project directory
mkdir parkplus
cd parkplus

# Initialize Git repository
git init

# Create the directory structure (same as before)
mkdir -p src/{components/{layout,home,auth,parking,fastag,shared},pages/{blogs,company},assets/images/{cars,banners,icons}}

# Create component files (same as before)
touch src/components/layout/{Navbar,Footer,MobileNav}.jsx
touch src/components/home/{CustomerServices,BusinessSolutions,LoyaltyProgram}.jsx
touch src/components/auth/{PhoneLogin,UserProfile}.jsx
touch src/components/parking/{SearchBar,LocationMap,SuggestSite,BookingList}.jsx
touch src/components/fastag/{Purchase,Recharge}.jsx
touch src/components/shared/BlogCard.jsx
touch src/pages/{index,parking,fastag}.jsx
touch src/pages/blogs/{cars,challan,fastag}.jsx
touch src/pages/company/{about,newsroom}.jsx

# Initialize npm and install dependencies including Netlify CLI
npm init -y
npm install react react-dom next @heroicons/react tailwindcss framer-motion lucide-react
npm install -D netlify-cli

# Update package.json scripts for Netlify
npm pkg set scripts.dev="next dev" \
    scripts.build="next build" \
    scripts.start="next start" \
    scripts.export="next build && next export" \
    scripts.netlify="netlify"

# Create next.config.js with necessary Netlify settings
echo "module.exports = {
  target: 'serverless',
  images: {
    loader: 'akamai',
    path: '',
  },
}" > next.config.js

# Create netlify.toml configuration
echo "[build]
  command = \"npm run export\"
  publish = \"out\"
  
[build.environment]
  NEXT_USE_NETLIFY = \"true\"

[[plugins]]
  package = \"@netlify/plugin-nextjs\"

[[redirects]]
  from = \"/*\"
  to = \"/index.html\"
  status = 200" > netlify.toml

# Initialize Tailwind CSS
npx tailwindcss init

# Create .gitignore
echo "node_modules/
.next/
.env
.env.local
.netlify
out/
build/
dist/" > .gitignore

# Create README.md with Netlify deployment instructions
echo "# Park+ Website Clone

Modern implementation of the Park+ website using React, Next.js, and Tailwind CSS.

## Setup Instructions

1. Clone the repository
2. Run \`npm install\`
3. Run \`npm run dev\` for local development

## Deployment

This project is configured for Netlify deployment:

1. Push your changes to GitHub
2. Connect your repository to Netlify
3. Configure build settings:
   - Build command: \`npm run export\`
   - Publish directory: \`out\`

[![Deploy to Netlify](https://www.netlify.com/img/deploy/button.svg)](https://app.netlify.com/start)" > README.md

# Initialize git and make first commit
git add .
git commit -m "Initial project structure setup with Netlify configuration"

echo "
Next steps:
1. Create a new repository on GitHub
2. Run:
   git remote add origin <your-github-repo-url>
   git branch -M main
   git push -u origin main
3. Go to Netlify and:
   - Connect to your GitHub repository
   - Configure build settings
   - Deploy!"