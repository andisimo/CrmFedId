﻿<UserControl
    x:Class="$rootnamespace$.Security.IdpCredentialsFlyout"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    xmlns:local="using:$rootnamespace$.Security"
    xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
    xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
    mc:Ignorable="d"
    d:DesignHeight="300"
    d:DesignWidth="400" KeyDown="UserControl_KeyDown">
    <UserControl.Resources>
        <Style x:Key="SettingsHeaderText" TargetType="RichTextBlock">
            <Setter Property="FontFamily" Value="Segoe UI" />
            <Setter Property="FontSize" Value="15" />            
            <Setter Property="TextWrapping" Value="Wrap" />
            <Setter Property="Margin" Value="0,0,0,10" />
        </Style>
        <Style TargetType="TextBlock">
            <Setter Property="FontFamily" Value="Segoe UI" />
            <Setter Property="FontWeight" Value="SemiBold" />
            <Setter Property="FontSize" Value="15" />
            <Setter Property="Foreground" Value="Black" />
            <Setter Property="VerticalAlignment" Value="Center" />
            <Setter Property="Margin" Value="0,10,0,10" />
            <Setter Property="TextWrapping" Value="Wrap"/>
        </Style>
        <Style TargetType="TextBox">
            <Setter Property="BorderBrush" Value="Black" />
            <Setter Property="Foreground" Value="Black" />
            <Setter Property="Width" Value="300" />
            <Setter Property="Height" Value="30" />
            <Setter Property="HorizontalAlignment" Value="Left" />
            <Setter Property="VerticalAlignment" Value="Center" />
            <Setter Property="Margin" Value="0,5,0,5" />
        </Style>
        <Style TargetType="PasswordBox">
            <Setter Property="BorderBrush" Value="Black" />
            <Setter Property="Foreground" Value="Black" />
            <Setter Property="Width" Value="300" />
            <Setter Property="Height" Value="30" />
            <Setter Property="HorizontalAlignment" Value="Left" />
            <Setter Property="VerticalAlignment" Value="Center" />
            <Setter Property="Margin" Value="0,5,0,5" />
        </Style>
        <Style TargetType="CheckBox">
            <Setter Property="BorderBrush" Value="Black" />
            <Setter Property="Foreground" Value="Black" />
            <Setter Property="Width" Value="200" />
            <Setter Property="HorizontalAlignment" Value="Left" />
            <Setter Property="Margin" Value="0,5,0,2" />
        </Style>
        <Style TargetType="Button">
            <Setter Property="BorderBrush" Value="LightGray" />
            <Setter Property="Foreground" Value="#fff" />
            <Setter Property="Background" Value="#2672ED" />
            <Setter Property="Width" Value="100" />
            <Setter Property="Margin" Value="0,20,0,20" />
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Grid>
                            <VisualStateManager.VisualStateGroups>
                                <VisualStateGroup x:Name="CommonStates">
                                    <VisualState x:Name="Normal"/>
                                    <VisualState x:Name="PointerOver">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="Border">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="#2672ED"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="#fff"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Pressed">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="Border">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ButtonPressedBackgroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ButtonPressedForegroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Disabled">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Background" Storyboard.TargetName="Border">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ButtonDisabledBackgroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="BorderBrush" Storyboard.TargetName="Border">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ButtonDisabledBorderThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource ButtonDisabledForegroundThemeBrush}"/>
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
                            <Border x:Name="Border" BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}" Margin="3">
                                <ContentPresenter x:Name="ContentPresenter" ContentTemplate="{TemplateBinding ContentTemplate}" ContentTransitions="{TemplateBinding ContentTransitions}" Content="{TemplateBinding Content}" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Margin="{TemplateBinding Padding}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                            </Border>
                            <Rectangle x:Name="FocusVisualWhite" IsHitTestVisible="False" Opacity="0" StrokeDashOffset="1.5" StrokeEndLineCap="Square" Stroke="{StaticResource FocusVisualWhiteStrokeThemeBrush}" StrokeDashArray="1,1"/>
                            <Rectangle x:Name="FocusVisualBlack" IsHitTestVisible="False" Opacity="0" StrokeDashOffset="0.5" StrokeEndLineCap="Square" Stroke="{StaticResource FocusVisualBlackStrokeThemeBrush}" StrokeDashArray="1,1"/>
                        </Grid>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
        <Style x:Key="CheckBoxStyle" TargetType="CheckBox">
            <Setter Property="Background" Value="Transparent"/>
            <Setter Property="Foreground" Value="Black"/>
            <Setter Property="Padding" Value="2,3,0,0"/>
            <Setter Property="HorizontalAlignment" Value="Stretch"/>
            <Setter Property="VerticalAlignment" Value="Center"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/>
            <Setter Property="VerticalContentAlignment" Value="Top"/>
            <Setter Property="FontFamily" Value="Segoe UI"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
            <Setter Property="FontSize" Value="15"/>
            <Setter Property="Margin" Value="0,10,0,10"/>
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="CheckBox">
                        <Border BorderBrush="{TemplateBinding BorderBrush}" BorderThickness="{TemplateBinding BorderThickness}" Background="{TemplateBinding Background}">
                            <VisualStateManager.VisualStateGroups>
                                <VisualStateGroup x:Name="CommonStates">
                                    <VisualState x:Name="Normal"/>
                                    <VisualState x:Name="PointerOver">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Fill" Storyboard.TargetName="NormalRectangle">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxPointerOverBackgroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Stroke" Storyboard.TargetName="NormalRectangle">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="LightGray"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Fill" Storyboard.TargetName="CheckGlyph">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxPointerOverForegroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Fill" Storyboard.TargetName="IndeterminateGlyph">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxPointerOverForegroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Pressed">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Fill" Storyboard.TargetName="NormalRectangle">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxPressedBackgroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Stroke" Storyboard.TargetName="NormalRectangle">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxPressedBorderThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Fill" Storyboard.TargetName="CheckGlyph">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxPressedForegroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Fill" Storyboard.TargetName="IndeterminateGlyph">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxPressedForegroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Disabled">
                                        <Storyboard>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Fill" Storyboard.TargetName="NormalRectangle">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxDisabledBackgroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Stroke" Storyboard.TargetName="NormalRectangle">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxDisabledBorderThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Fill" Storyboard.TargetName="CheckGlyph">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxDisabledForegroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Fill" Storyboard.TargetName="IndeterminateGlyph">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxDisabledForegroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                            <ObjectAnimationUsingKeyFrames Storyboard.TargetProperty="Foreground" Storyboard.TargetName="ContentPresenter">
                                                <DiscreteObjectKeyFrame KeyTime="0" Value="{StaticResource CheckBoxContentDisabledForegroundThemeBrush}"/>
                                            </ObjectAnimationUsingKeyFrames>
                                        </Storyboard>
                                    </VisualState>
                                </VisualStateGroup>
                                <VisualStateGroup x:Name="CheckStates">
                                    <VisualState x:Name="Checked">
                                        <Storyboard>
                                            <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="Opacity" Storyboard.TargetName="CheckGlyph"/>
                                        </Storyboard>
                                    </VisualState>
                                    <VisualState x:Name="Unchecked"/>
                                    <VisualState x:Name="Indeterminate">
                                        <Storyboard>
                                            <DoubleAnimation Duration="0" To="1" Storyboard.TargetProperty="Opacity" Storyboard.TargetName="IndeterminateGlyph"/>
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
                            <Grid>
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="27"/>
                                    <ColumnDefinition Width="*"/>
                                </Grid.ColumnDefinitions>
                                <Grid VerticalAlignment="Top">
                                    <Rectangle x:Name="NormalRectangle" Fill="{StaticResource CheckBoxBackgroundThemeBrush}" Height="21" Stroke="LightGray" StrokeThickness="2" UseLayoutRounding="False" Width="21"/>
                                    <Path x:Name="CheckGlyph" Data="F1 M 0,58 L 2,56 L 6,60 L 13,51 L 15,53 L 6,64 z" Fill="{StaticResource CheckBoxForegroundThemeBrush}" FlowDirection="LeftToRight" Height="14" Opacity="0" Stretch="Fill" Width="16"/>
                                    <Rectangle x:Name="IndeterminateGlyph" Fill="{StaticResource CheckBoxForegroundThemeBrush}" Height="9" Opacity="0" UseLayoutRounding="False" Width="9"/>
                                    <Rectangle x:Name="FocusVisualWhite" Height="27" Opacity="0" StrokeDashOffset="0.5" StrokeEndLineCap="Square" Stroke="{StaticResource FocusVisualWhiteStrokeThemeBrush}" StrokeDashArray="1,1" Width="27"/>
                                    <Rectangle x:Name="FocusVisualBlack" Height="27" Opacity="0" StrokeDashOffset="1.5" StrokeEndLineCap="Square" Stroke="{StaticResource FocusVisualBlackStrokeThemeBrush}" StrokeDashArray="1,1" Width="27"/>
                                </Grid>
                                <ContentPresenter x:Name="ContentPresenter" ContentTemplate="{TemplateBinding ContentTemplate}" ContentTransitions="{TemplateBinding ContentTransitions}" Content="{TemplateBinding Content}" Grid.Column="1" HorizontalAlignment="{TemplateBinding HorizontalContentAlignment}" Margin="{TemplateBinding Padding}" VerticalAlignment="{TemplateBinding VerticalContentAlignment}"/>
                            </Grid>
                        </Border>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </UserControl.Resources>
    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="100"></ColumnDefinition>
            <ColumnDefinition></ColumnDefinition>
        </Grid.ColumnDefinitions>
        <Grid.RowDefinitions>
            <RowDefinition></RowDefinition>
            <RowDefinition></RowDefinition>
            <RowDefinition></RowDefinition>
            <RowDefinition></RowDefinition>
            <RowDefinition></RowDefinition>
            <RowDefinition></RowDefinition>
            <RowDefinition></RowDefinition>
            <RowDefinition></RowDefinition>
        </Grid.RowDefinitions>
        <ProgressBar x:Name="LoadingProgressBar" Visibility="Visible" Opacity="0" IsIndeterminate="True" Grid.Row="0" Grid.ColumnSpan="2" FlowDirection="LeftToRight" VerticalAlignment="Top" Height="20"/>
        <RichTextBlock Grid.Column="0" Grid.Row="1" Grid.ColumnSpan="2" Style="{StaticResource SettingsHeaderText}">
            <Paragraph>
                <Run>Please enter your identity provider credentials for</Run>
                <LineBreak />
                <Run x:Name="SignInUrl" FontWeight="SemiBold" Foreground="Black"></Run>
            </Paragraph>
        </RichTextBlock>
        <TextBlock Grid.Column="0" Grid.Row="2" Text="Username" />
        <TextBox Grid.Column="1" Grid.Row="2" x:Name="UsernameInput" GotFocus="UsernameInput_GotFocus"/>
        <TextBlock Grid.Column="0" Grid.Row="3" Text="Password" />
        <PasswordBox Grid.Column="1" Grid.Row="3" x:Name="PasswordInput" IsPasswordRevealButtonEnabled="True" />
        <TextBlock Grid.Column="1" Grid.Row="4" Text="" x:Name="TxtErrorMessage" Foreground="Red" Visibility="Collapsed" />
        <CheckBox Grid.Column="1" Grid.Row="5" x:Name="KmsiInput" IsChecked="False" Content="Keep me signed in" Style="{StaticResource CheckBoxStyle}" />
        <Button Grid.Column="1" Grid.Row="6" x:Name="SignInInput" Margin="0" Content="Sign in" Click="SignIn" />
        <HyperlinkButton Grid.Column="0" Grid.Row="7" Grid.ColumnSpan="2" Padding="0,4,12,5" NavigateUri="http://go.microsoft.com/fwlink/?LinkID=190175">View privacy statement</HyperlinkButton>
    </Grid>
</UserControl>
