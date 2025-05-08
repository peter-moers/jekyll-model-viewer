# jekyll-model-viewer
Simple Jekyll plugin for displaying 3D objects (glb) on Jekyll pages and posts.
The plugin is a simple integration of https://modelviewer.dev/

## Create plugin file

Copy the contents of model-viewer.rb to the _plugins directory of your Jekyll data.

## Add plugin to Jekyll

Make sure your _config.yml loads the plugin:
```yaml
plugins_dir: _plugins
```

## Use the tag 

In your Jekyll posts/pages:
```liquid
{% modelviewer src="/assets/models/car.glb" width="400px" height="300px" alt="3D Car Model" disable-zoom exposure="0.8" shadow_intensity="1" %}
```
