/** @type {import('tailwindcss').Config} */
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,ts,tsx}'],
  theme: {
    extend: {
      fontFamily: {
        sans: ['DM Sans', 'system-ui', 'sans-serif'],
        serif: ['DM Serif Display', 'Georgia', 'serif'],
      },
      colors: {
        accent: '#C4654A',
      },
      backgroundColor: {
        page: '#FAFAF8',
      },
      textColor: {
        primary: '#1a1a1a',
        muted: '#6B7280',
      },
    },
  },
  plugins: [],
};
