export type SiteNavGroupId = "shop" | "support" | "company";

export type SiteNavLink = {
  labelKey: string;
  to: string;
  /** Show “Hot” pill next to label (e.g. Sale). */
  hotBadge?: boolean;
};

export type SiteNavGroup = {
  id: SiteNavGroupId;
  titleKey: string;
  links: SiteNavLink[];
  /** Scroll target on the landing page (Support / Company tabs). */
  homeScrollId?: string;
};

/**
 * Single source for primary header menus (Shop, Support, Company).
 */
export const SITE_NAV_GROUPS: SiteNavGroup[] = [
  {
    id: "shop",
    titleKey: "nav.primaryShop",
    links: [
      { labelKey: "nav.clubs", to: "/clubs" },
      { labelKey: "nav.balls", to: "/balls" },
      { labelKey: "nav.bags", to: "/bags" },
      { labelKey: "nav.apparel", to: "/apparel" },
      { labelKey: "nav.accessories", to: "/accessories" },
      { labelKey: "nav.sale", to: "/sale", hotBadge: true },
    ],
  },
  {
    id: "support",
    titleKey: "nav.primarySupport",
    links: [],
    homeScrollId: "home-support",
  },
  {
    id: "company",
    titleKey: "nav.primaryCompany",
    links: [],
    homeScrollId: "home-company",
  },
];
