export class SizeConstants {
  // Base spacing tokens
  static readonly PAD_MINI: string = '8px';
  static readonly PAD_SMALL: string = '16px';
  static readonly PAD_MED: string = '24px';
  static readonly PAD_LARGE: string = '32px';
  static readonly PAD_XL: string = '48px';
  static readonly PAD_XXL: string = '64px';

  // Compound padding — screen layout (top/bottom: LARGE, left/right: XXL)
  static readonly PAD_SCREEN: Padding = {
    top: '32px', right: '64px', bottom: '32px', left: '64px'
  };

  // Compound padding — vertical only
  static readonly PAD_VERTICAL_XL: Padding = { top: '48px', bottom: '48px' };
  static readonly PAD_VERTICAL_XXL: Padding = { top: '64px', bottom: '64px' };

  // Compound padding — symmetric inner (top/bottom: XL, left/right: LARGE)
  static readonly PAD_INNER: Padding = {
    top: '48px', right: '32px', bottom: '48px', left: '32px'
  };

  // Compound padding — primary button (vertical: MED, horizontal: LARGE)
  static readonly PAD_BTN_PRIMARY: Padding = {
    top: '24px', right: '32px', bottom: '24px', left: '32px'
  };
}
