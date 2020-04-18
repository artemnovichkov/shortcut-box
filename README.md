```
<p align="center">
  <img src="https://github.com/artemnovichkov/shortcut-box/.github/example.png">
  <h3 align="center">shortcut-box</h3>
  <p align="center">👨‍💻 Update a pinned gist to contain random IDE shortcut</p>
</p>
```



![Update gist with random Xcode shortcut](https://github.com/artemnovichkov/shortcut-box/workflows/Update%20gist%20with%20random%20Xcode%20shortcut/badge.svg?event=schedule)



## Setup

1. Create a new public [GitHub Gist](https://gist.github.com).
1. Create a [token](https://github.com/settings/tokens/new) with the `gist` scope and copy it.
3. Fork this repo
4. Go to the repo **Settings > Secrets**
5. Add the following environment variables:
   - **GH_TOKEN:** The GitHub token generated above.
   - **GIST_TOKEN**: The ID portion from your gist url: `https://gist.github.com/artemnovichkov/`**c24fd619278b272471af51f06c1ce6b2**.