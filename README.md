# MatVim

Matvim is a Vim plugin which extends vim with some Matlab specific functionalities:

- Executing a script, section, selection or a line can be done within a few keystrokes.
- The vim command line can transform into a Matlab prompt.

Who will have a great time with Matvim?

- The scientist who uses Matlab and prefers to work text-based in Vim instead of using Matlab's IDE.
- People who are forced to use MATLAB through a terminal. (e.g. if matlab is installed on a server)

Who will not have a great time with Matvim?

- Matlab newbies.
- People who love clicking around in Matlab's IDE.

## Prerequisites

- Python 2.7
- [Matlab](http://www.mathworks.com/products/matlab/)
- [Matlab Engine for Python](http://www.mathworks.com/help/matlab/matlab-engine-for-python.html)

## Installation

Use your plugin manager of choice.

- [Pathogen](https://github.com/tpope/vim-pathogen)
  - `git clone https://github.com/JeroenMulkers/matvim ~/.vim/bundle/matvim`
- [Vundle](https://github.com/gmarik/vundle)
  - Add `Bundle 'https://github.com/JeroenMulkers/matvim'` to .vimrc
  - Run `:BundleInstall`
- [NeoBundle](https://github.com/Shougo/neobundle.vim)
  - Add `NeoBundle 'https://github.com/JeroenMulkers/matvim'` to .vimrc
  - Run `:NeoBundleInstall`
- [vim-plug](https://github.com/junegunn/vim-plug)
  - Add `Plug 'https://github.com/JeroenMulkers/matvim'` to .vimrc
  - Run `:PlugInstall`
