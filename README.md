# Elm vocab

Every feedback is highly welcomed.

## Usage

To start it for now use ```elm-reactor```.

## Purpose

This app is meant to be used to learn vocabs.
Each vocabulary card has a front and a backside.

It stores along the way how often you knew and didn't knew a certain vocab.

## Architecture

The main types are stored in App/Types, which are cards and stats for these cards.

On the rendering level we have a route for the actual vocabulary learing and one for showing the stats.

The actual vocabs can be added in data/vocabs.js. An example .dist file is provided.

## General TODO

* Document more architecture
* Styles
* Store stats somehow in localStorage or similar

