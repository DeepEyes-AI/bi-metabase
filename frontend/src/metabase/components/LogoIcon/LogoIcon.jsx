import { Component } from "react";
import PropTypes from "prop-types";
import cx from "classnames";

import { PLUGIN_LOGO_ICON_COMPONENTS } from "metabase/plugins";

class DefaultLogoIcon extends Component {
  static defaultProps = {
    height: 32,
  };
  static propTypes = {
    width: PropTypes.number,
    height: PropTypes.number,
    dark: PropTypes.bool,
  };

  render() {
    const { dark, height, width } = this.props;
    return (
      <svg
        className={cx("Icon", { "text-brand": !dark }, { "text-white": dark })}
        viewBox="0 0 280 280"
        width={width}
        height={height}
        fill="currentcolor"
        data-testid="main-logo"
      >
        <path d="m140,50l-90,90,90,90,90-90-90-90Zm0,172.27l-82.27-82.27,61.29-61.29,28.12,28.12c-10.89-2.32-22.71.71-31.15,9.16-13.24,13.24-13.24,34.79,0,48.04l41.14,41.14-17.12,17.12Zm20.15-102.42c11.11,11.11,11.11,29.19,0,40.31-11.12,11.11-29.2,11.11-40.31,0-11.11-11.11-11.11-29.19,0-40.31,11.11-11.11,29.2-11.11,40.31,0Zm-27.29,53.33c2.35.5,4.74.78,7.13.78,8.7,0,17.4-3.31,24.02-9.93,13.24-13.24,13.24-34.79,0-48.04l-41.14-41.14,17.12-17.12,82.27,82.27-61.29,61.29-28.12-28.12Z" />
      </svg>
    );
  }
}

export default function LogoIcon(props) {
  const [Component = DefaultLogoIcon] = PLUGIN_LOGO_ICON_COMPONENTS;
  return <Component {...props} />;
}
