Return-Path: <linux-btrfs+bounces-1996-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B56E845766
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C455291DA2
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7383F15F325;
	Thu,  1 Feb 2024 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d0DU34it"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11F715F31C;
	Thu,  1 Feb 2024 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790218; cv=none; b=puMw3AP7YfK95QX47ApqVnixhPJqrE0hL2W8x1D6rEa4xZq1RUd6bhncMoiD5DrtjY1vXI//7/36mNCQc8Y8KPWKFZI2fa2ji25LzSFfVSdzXv+o7aSxVflfDG3rVi7IPc3nJmIeRW47uyrkh+3dsfh5NjHeUrSiv14QlAjDSoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790218; c=relaxed/simple;
	bh=FkdWCDGhSzmNJ65dmfIHiTVxvqOrslZqMpuEArCTxEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEFYDcvrbBXGvri5/yysb+7LdlgMMQKzlofehsjH09xzYkkOez0s7tLP4z8qJgZvsDzEQ2YCODcixj04enVXmrz1SrsTJnU9BVlXeS+T8GbJqymXT4hEVzWydt3I8K2gFk6oHBrIoxA1dflEysMOW/rfZ+sh2yauLPD9qdDalbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d0DU34it; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790218; x=1738326218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FkdWCDGhSzmNJ65dmfIHiTVxvqOrslZqMpuEArCTxEw=;
  b=d0DU34itVs0PV8ayeqXPcJ9RDc4UJpkZD8sqBojExjn6shKlp7etVYkX
   e9QdCHuGjZZmjwfq47NBfJGldbp0kZN6UFD8ruZIb+4rBTk37tuBqOY6q
   Ek0dTWxHaV/7T13qtVHN/IdRscp8GZ9EJ486UdG9e5I8G+8bc1rPH5xz5
   IZlGPRS1Nxl5GzXsMldbRLPNubjM3oNvZxWyAU2VbyAljVTtjPpRTCDi2
   +2DWZnLY/Z8Lrjigm6ry4pcb0LU921SAFwsLr1KIDSsQlWVJpikMnkwmA
   kQWoIenZuC/c4hxdLxRCoVugjTV4cJ4dnrwFSr4j8yboffbMSk3onOOSd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3746870"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3746870"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:23:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499077"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:23:31 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Ido Schimmel <idosch@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Simon Horman <horms@kernel.org>,
	linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com,
	ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Syed Nayyar Waris <syednwaris@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	William Breathitt Gray <william.gray@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v5 01/21] lib/bitmap: add bitmap_{read,write}()
Date: Thu,  1 Feb 2024 13:21:56 +0100
Message-ID: <20240201122216.2634007-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
References: <20240201122216.2634007-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Syed Nayyar Waris <syednwaris@gmail.com>

The two new functions allow reading/writing values of length up to
BITS_PER_LONG bits at arbitrary position in the bitmap.

The code was taken from "bitops: Introduce the for_each_set_clump macro"
by Syed Nayyar Waris with a number of changes and simplifications:
 - instead of using roundup(), which adds an unnecessary dependency
   on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
 - indentation is reduced by not using else-clauses (suggested by
   checkpatch for bitmap_get_value());
 - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
   and bitmap_write();
 - some redundant computations are omitted.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
Suggested-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitmap.h | 77 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d6..7ca0379be8c1 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -79,6 +79,10 @@ struct device;
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
+ *                                              map at start
+ *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
+ *                                              map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -636,6 +640,79 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_read - read a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
+ *
+ * Returns: value of @nbits bits located at the @start bit offset within the
+ * @map memory region. For @nbits = 0 and @nbits > BITS_PER_LONG the return
+ * value is undefined.
+ */
+static inline unsigned long bitmap_read(const unsigned long *map,
+					unsigned long start,
+					unsigned long nbits)
+{
+	size_t index = BIT_WORD(start);
+	unsigned long offset = start % BITS_PER_LONG;
+	unsigned long space = BITS_PER_LONG - offset;
+	unsigned long value_low, value_high;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return 0;
+
+	if (space >= nbits)
+		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
+
+	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
+	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
+	return (value_low >> offset) | (value_high << space);
+}
+
+/**
+ * bitmap_write - write n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value to write, clamped to nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
+ *
+ * bitmap_write() behaves as-if implemented as @nbits calls of __assign_bit(),
+ * i.e. bits beyond @nbits are ignored:
+ *
+ *   for (bit = 0; bit < nbits; bit++)
+ *           __assign_bit(start + bit, bitmap, val & BIT(bit));
+ *
+ * For @nbits == 0 and @nbits > BITS_PER_LONG no writes are performed.
+ */
+static inline void bitmap_write(unsigned long *map, unsigned long value,
+				unsigned long start, unsigned long nbits)
+{
+	size_t index;
+	unsigned long offset;
+	unsigned long space;
+	unsigned long mask;
+	bool fit;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return;
+
+	mask = BITMAP_LAST_WORD_MASK(nbits);
+	value &= mask;
+	offset = start % BITS_PER_LONG;
+	space = BITS_PER_LONG - offset;
+	fit = space >= nbits;
+	index = BIT_WORD(start);
+
+	map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
+	map[index] |= value << offset;
+	if (fit)
+		return;
+
+	map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
+	map[index + 1] |= (value >> space);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.43.0


