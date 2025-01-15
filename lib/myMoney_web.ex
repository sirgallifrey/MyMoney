defmodule MyMoneyWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, components, channels, and so on.

  This can be used in your application as:

      use MyMoneyWeb, :controller
      use MyMoneyWeb, :html

  The definitions below will be executed for every controller,
  component, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define additional modules and import
  those modules here.
  """

  def static_paths, do: ~w(assets fonts images favicon.ico robots.txt)

  def router do
    quote do
      use Phoenix.Router, helpers: false

      # Import common connection and controller functions to use in pipelines
      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
    end
  end

  def controller do
    quote do
      use Phoenix.Controller,
        formats: [:html, :json],
        layouts: [html: MyMoneyWeb.Layouts]

      import Plug.Conn
      import MyMoneyWeb.Gettext

      unquote(verified_routes())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {MyMoneyWeb.Layouts, :app}

      unquote(html_helpers())
    end
  end

  def live_view_dashboard do
    quote do
      use Phoenix.LiveView,
        layout: {MyMoneyWeb.Dashboard, :dashboard}

      unquote(html_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(html_helpers())
    end
  end

  def component do
    quote do
      use Phoenix.Component

      unquote(html_helpers())
    end
  end

  def html do
    quote do
      use Phoenix.Component

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_csrf_token: 0, view_module: 1, view_template: 1]

      # Include general helpers for rendering HTML
      unquote(html_helpers())
    end
  end

  defp html_helpers do
    quote do
      # HTML escaping functionality
      import Phoenix.HTML
      # Core UI components and translation
      import MyMoneyWeb.CoreComponents
      import MyMoneyWeb.Gettext
      import MyMoneyWeb.Component
      import MyMoneyWeb.Component.Helpers
      alias MyMoneyWeb.Component.Accordion
      alias MyMoneyWeb.Component.Alert
      alias MyMoneyWeb.Component.AlertDialog
      alias MyMoneyWeb.Component.Avatar
      alias MyMoneyWeb.Component.Badge
      alias MyMoneyWeb.Component.Breadcrumb
      alias MyMoneyWeb.Component.Button
      alias MyMoneyWeb.Component.Card
      alias MyMoneyWeb.Component.Checkbox
      alias MyMoneyWeb.Component.Collapsible
      alias MyMoneyWeb.Component.Dialog
      alias MyMoneyWeb.Component.DropdownMenu
      alias MyMoneyWeb.Component.Form
      alias MyMoneyWeb.Component.HoverCard
      alias MyMoneyWeb.Component.Icon
      alias MyMoneyWeb.Component.Input
      alias MyMoneyWeb.Component.Label
      alias MyMoneyWeb.Component.LiveChart
      alias MyMoneyWeb.Component.Menu
      alias MyMoneyWeb.Component.Pagination
      alias MyMoneyWeb.Component.Popover
      alias MyMoneyWeb.Component.Progress
      alias MyMoneyWeb.Component.RadioGroup
      alias MyMoneyWeb.Component.ScrollArea
      alias MyMoneyWeb.Component.Select
      alias MyMoneyWeb.Component.Separator
      alias MyMoneyWeb.Component.Sheet
      alias MyMoneyWeb.Component.Sidebar
      alias MyMoneyWeb.Component.Skeleton
      alias MyMoneyWeb.Component.Slider
      alias MyMoneyWeb.Component.Switch
      alias MyMoneyWeb.Component.Table
      alias MyMoneyWeb.Component.Tabs
      alias MyMoneyWeb.Component.Textarea
      alias MyMoneyWeb.Component.Toggle
      alias MyMoneyWeb.Component.ToggleGroup
      alias MyMoneyWeb.Component.Tooltip
      # Shortcut for generating JS commands
      alias Phoenix.LiveView.JS

      # Routes generation with the ~p sigil
      unquote(verified_routes())
    end
  end

  def verified_routes do
    quote do
      use Phoenix.VerifiedRoutes,
        endpoint: MyMoneyWeb.Endpoint,
        router: MyMoneyWeb.Router,
        statics: MyMoneyWeb.static_paths()
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/live_view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
