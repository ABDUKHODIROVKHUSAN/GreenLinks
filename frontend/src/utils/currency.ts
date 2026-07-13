/** Stored catalog prices are USD; display shop prices in KRW. */
const USD_TO_KRW = 1350;

export function usdToKrw(usd: number): number {
  if (!Number.isFinite(usd)) return 0;
  return Math.round(usd * USD_TO_KRW);
}

export function formatShopPrice(usdAmount: number): string {
  return new Intl.NumberFormat("ko-KR", {
    style: "currency",
    currency: "KRW",
    maximumFractionDigits: 0,
  }).format(usdToKrw(usdAmount));
}
