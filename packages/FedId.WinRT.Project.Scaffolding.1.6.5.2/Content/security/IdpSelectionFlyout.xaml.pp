<UserControl
    x:Class="$rootnamespace$.Security.IdpSelectionFlyout"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:local="using:$rootnamespace$.Security"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    mc:Ignorable="d"
    d:DesignHeight="300"
    d:DesignWidth="400">

  <UserControl.Resources>
    <Style x:Key="SettingsHeaderText" TargetType="TextBlock">
      <Setter Property="FontFamily" Value="Segoe UI" />
      <Setter Property="FontWeight" Value="SemiBold" />
      <Setter Property="FontSize" Value="14.6667" />
      <Setter Property="Padding" Value="8,8,10,10"/>
      <Setter Property="Foreground" Value="Black" />
      <Setter Property="TextWrapping" Value="Wrap" />
    </Style>
    <Style x:Key="ListBoxItemStyle" TargetType="ListBoxItem">
      <Setter Property="Background" Value="Transparent"/>
      <Setter Property="TabNavigation" Value="Local"/>
      <Setter Property="Padding" Value="8,8,10,10"/>
      <Setter Property="HorizontalContentAlignment" Value="Left"/>
      <Setter Property="FontFamily" Value="Segoe UI" />
      <Setter Property="Template">
        <Setter.Value>
          <ControlTemplate TargetType="ListBoxItem">
            <Border x:Name="LayoutRoot" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}">
              <VisualStateManager.VisualStateGroups>
                <VisualStateGroup x:Name="CommonStates">
                  <VisualState x:Name="Normal"/>
                  <VisualState x:Name="PointerOver">
                    <Storyboard>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="LayoutRoot">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemPointerOverBackgroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemPointerOverForegroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                    </Storyboard>
                  </VisualState>
                  <VisualState x:Name="Disabled">
                    <Storyboard>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="LayoutRoot">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="Transparent"/>
                      </ObjectAnimationUsingKeyFrames>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemDisabledForegroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                    </Storyboard>
                  </VisualState>
                  <VisualState x:Name="Pressed">
                    <Storyboard>
                      <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="Opacity" Storyboard.TargetName="PressedBackground"/>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemPressedForegroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                    </Storyboard>
                  </VisualState>
                </VisualStateGroup>
                <VisualStateGroup x:Name="SelectionStates">
                  <VisualState x:Name="Unselected"/>
                  <VisualState x:Name="Selected">
                    <Storyboard>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="InnerGrid">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedBackgroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedForegroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                    </Storyboard>
                  </VisualState>
                  <VisualState x:Name="SelectedUnfocused">
                    <Storyboard>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="InnerGrid">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedBackgroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedForegroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                    </Storyboard>
                  </VisualState>
                  <VisualState x:Name="SelectedDisabled">
                    <Storyboard>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="InnerGrid">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedDisabledBackgroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedDisabledForegroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                    </Storyboard>
                  </VisualState>
                  <VisualState x:Name="SelectedPointerOver">
                    <Storyboard>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="InnerGrid">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedPointerOverBackgroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedForegroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                    </Storyboard>
                  </VisualState>
                  <VisualState x:Name="SelectedPressed">
                    <Storyboard>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="InnerGrid">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedBackgroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                      <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                        <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ListBoxItemSelectedForegroundThemeBrush}"/>
                      </ObjectAnimationUsingKeyFrames>
                    </Storyboard>
                  </VisualState>
                </VisualStateGroup>
                <VisualStateGroup x:Name="FocusStates">
                  <VisualState x:Name="Focused">
                    <Storyboard>
                      <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="Opacity" Storyboard.TargetName="FocusVisualWhite"/>
                      <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="Opacity" Storyboard.TargetName="FocusVisualBlack"/>
                    </Storyboard>
                  </VisualState>
                  <VisualState x:Name="Unfocused"/>
                  <VisualState x:Name="PointerFocused"/>
                </VisualStateGroup>
              </VisualStateManager.VisualStateGroups>
              <Grid x:Name="InnerGrid" Background="Transparent">
                <Rectangle x:Name="PressedBackground" Fill="{StaticResource ListBoxItemPressedBackgroundThemeBrush}" Opacity="0"/>
                <ContentPresenter x:Name="ContentPresenter" ContentTemplate="{TemplateBinding ContentTemplate}" ContentTransitions="{TemplateBinding ContentTransitions}" Content="{TemplateBinding Content}" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Margin="{TemplateBinding Padding}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                <Rectangle x:Name="FocusVisualWhite" Opacity="0" StrokeDashOffset=".5" StrokeEndLineCap="Square" Stroke="{StaticResource FocusVisualWhiteStrokeThemeBrush}" StrokeDashArray="1,1"/>
                <Rectangle x:Name="FocusVisualBlack" Opacity="0" StrokeDashOffset="1.5" StrokeEndLineCap="Square" Stroke="{StaticResource FocusVisualBlackStrokeThemeBrush}" StrokeDashArray="1,1"/>
              </Grid>
            </Border>
          </ControlTemplate>
        </Setter.Value>
      </Setter>
    </Style>
  </UserControl.Resources>
 <Grid>
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>
        <ProgressBar x:Name="LoadingProgressBar" Visibility="Visible" Opacity="0" IsIndeterminate="True" Grid.Row="0"  FlowDirection="LeftToRight" VerticalAlignment="Top" Height="20"/>
        <Grid Grid.Row="1" x:Name="GrdIdentityProviders">
            <Grid.RowDefinitions>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
                <RowDefinition Height="Auto"/>
            </Grid.RowDefinitions>
            <TextBlock Grid.Row="0" Style="{StaticResource SettingsHeaderText}">Select the Identity Provider that you would like to signin with.</TextBlock>
            <ListBox x:Name="IdentityProviders" Grid.Row="1" HorizontalAlignment="Left" VerticalAlignment="Top" 
            ScrollViewer.HorizontalScrollBarVisibility="Auto" ItemContainerStyle="{StaticResource ListBoxItemStyle}" 
            SelectionChanged="IdentityProviders_SelectionChanged">
                <ListBox.ItemTemplate>
                    <DataTemplate>
                        <TextBlock Text="{Binding Name}"/>
                    </DataTemplate>
                </ListBox.ItemTemplate>
            </ListBox>
            <TextBlock Grid.Row="2" Text="" x:Name="TxtErrorMessage" Style="{StaticResource SettingsHeaderText}" Foreground="Red" Visibility="Collapsed" TextWrapping="Wrap" />
            <HyperlinkButton Grid.Row="3" Padding="6,4,12,5" NavigateUri="http://go.microsoft.com/fwlink/?LinkID=190175">View privacy statement</HyperlinkButton>
        </Grid>
    </Grid>
</UserControl>
