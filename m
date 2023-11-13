Return-Path: <linux-btrfs+bounces-106-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9A47EA234
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 18:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF253B209A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA342241E2;
	Mon, 13 Nov 2023 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+vE/c0O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F33F23743;
	Mon, 13 Nov 2023 17:38:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DC91981;
	Mon, 13 Nov 2023 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897075; x=1731433075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+a6GSe4zVAmYMCDzzbGOTK0g1O4rjq1EWeIYoJFDaCM=;
  b=H+vE/c0OQ0gBfGP5fiDU2+RpPtq3Fe8uP8uVNinhVvPoRxgedP7B90Sn
   FDNj7BNnx6dYySM/dUKcZLhP2F//Q88MC69Dxu1FXr3wKP+tHGtMuFFEa
   vsgDJpcS/cSg4RXw/wirsC0xppKPLoi+wafJ6ZuqQ47AnNCbMbpQ6hCVJ
   m1YuAMt/G/P/TCjhFcYpyGJPu2TuuUELWiHa4CULRF60Ahyz+th89Vvdv
   XSV+x25g3uI17iJ087lwpeIpgjb+U3WUUe7MuAPqWIz6pEtOSh1ufQLhU
   T4jaT3EvojwNPvfjpgDwNge70PzFtuidKFK34/11U7eQ7PXCs+C6HY8Zg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370671655"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370671655"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:37:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095812742"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095812742"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 09:37:52 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Alexander Potapenko <glider@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	dm-devel@redhat.com,
	ntfs3@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] bitmap: make bitmap_{get,set}_value8() use bitmap_{read,write}()
Date: Mon, 13 Nov 2023 18:37:16 +0100
Message-ID: <20231113173717.927056-11-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113173717.927056-1-aleksander.lobakin@intel.com>
References: <20231113173717.927056-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have generic bitmap_read() and bitmap_write(), which are
inline and try to take care of non-bound-crossing and aligned cases
to keep them optimized, collapse bitmap_{get,set}_value8() into
simple wrappers around the former ones.
bloat-o-meter shows no difference in vmlinux and -2 bytes for
gpio-pca953x.ko, which says the optimization didn't suffer due to
that change. The converted helpers have the value width embedded
and always compile-time constant and that helps a lot.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/bitmap.h | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 9a6a27a7f675..f80e116b8f60 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -609,39 +609,6 @@ static inline void bitmap_from_u64(unsigned long *dst, u64 mask)
 	bitmap_from_arr64(dst, &mask, 64);
 }
 
-/**
- * bitmap_get_value8 - get an 8-bit value within a memory region
- * @map: address to the bitmap memory region
- * @start: bit offset of the 8-bit value; must be a multiple of 8
- *
- * Returns the 8-bit value located at the @start bit offset within the @src
- * memory region.
- */
-static inline unsigned long bitmap_get_value8(const unsigned long *map,
-					      unsigned long start)
-{
-	const size_t index = BIT_WORD(start);
-	const unsigned long offset = start % BITS_PER_LONG;
-
-	return (map[index] >> offset) & 0xFF;
-}
-
-/**
- * bitmap_set_value8 - set an 8-bit value within a memory region
- * @map: address to the bitmap memory region
- * @value: the 8-bit value; values wider than 8 bits may clobber bitmap
- * @start: bit offset of the 8-bit value; must be a multiple of 8
- */
-static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
-				     unsigned long start)
-{
-	const size_t index = BIT_WORD(start);
-	const unsigned long offset = start % BITS_PER_LONG;
-
-	map[index] &= ~(0xFFUL << offset);
-	map[index] |= value << offset;
-}
-
 /**
  * bitmap_read - read a value of n-bits from the memory region
  * @map: address to the bitmap memory region
@@ -715,6 +682,11 @@ static inline void bitmap_write(unsigned long *map, unsigned long value,
 	map[index + 1] |= (value >> space);
 }
 
+#define bitmap_get_value8(map, start)			\
+	bitmap_read(map, start, BITS_PER_BYTE)
+#define bitmap_set_value8(map, value, start)		\
+	bitmap_write(map, value, start, BITS_PER_BYTE)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.41.0


