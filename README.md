# ReScript Select

Rescript select example.

I used react-select and emotion for styling my components.  For style children components I used simple CSS and prop `~prefixClassName`. I tried to bind the style function to style components with emotion, but this solution seems to have much extra code, or I haven't enough experience to solve this problem myself.

Demo: https://github.com/fedodd/rs-country-select

## Used packages

- flag-icons - task recommendation
- react-select - task recommendation
- react-window - for virtualization list of options
- @emotion/css - for styling
- @ryyppy/rescript-promise - it was recommended in doc https://rescript-lang.org/docs/manual/latest/promise#promise-new

## Local start

`npm run start` - for rescript builds
`npm run webstart` - for webpack serve
