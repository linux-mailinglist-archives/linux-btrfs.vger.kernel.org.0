Return-Path: <linux-btrfs+bounces-105-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE927EA232
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 18:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B72D1F21F55
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 17:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305BC23774;
	Mon, 13 Nov 2023 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2bVfb4r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021123743;
	Mon, 13 Nov 2023 17:37:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6434E1BF5;
	Mon, 13 Nov 2023 09:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897072; x=1731433072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RaoJmZHtQplaKRbtgYjC8ApgqEEvGU+Ywf+tLuvU7YY=;
  b=L2bVfb4rxsi2MWegJt2juhaEFpGp2hvQ47oeoFgisv2ct9V6qHwarflu
   cg76S9FNg8OvFboyCnrYlP0NX9FO2F5uAIzceaNDiJpobNvH2URmO3en9
   a2Owne4GAgS+ytzJ5XJQIPncaEohtEl9H4IWfOP1tK6bqmj/VO/NDxPfD
   9rACjrDCruqLHTqzqt2PgLu8D54VuZapvkoNoHoVhuKSFcZ5ByJg99q9p
   bK9F/Tgmt2xm8OKS1H3z1wcrC3I/Lyz0QtgCSlLt3ca1MovjdZkS7HuGy
   cEXSRdJLFRnme4kZxszFB515eR71gIGQ+/HOc+//9ob/TzRC3nSzHRcvH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370671635"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370671635"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:37:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095812724"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095812724"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 09:37:49 -0800
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
Subject: [PATCH v3 09/11] bitmap: introduce generic optimized bitmap_size()
Date: Mon, 13 Nov 2023 18:37:15 +0100
Message-ID: <20231113173717.927056-10-aleksander.lobakin@intel.com>
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

The number of times yet another open coded
`BITS_TO_LONGS(nbits) * sizeof(long)` can be spotted is huge.
Some generic helper is long overdue.

Add one, bitmap_size(), but with one detail.
BITS_TO_LONGS() uses DIV_ROUND_UP(). The latter works well when both
divident and divisor are compile-time constants or when the divisor
is not a pow-of-2. When it is however, the compilers sometimes tend
to generate suboptimal code (GCC 13):

48 83 c0 3f          	add    $0x3f,%rax
48 c1 e8 06          	shr    $0x6,%rax
48 8d 14 c5 00 00 00 00	lea    0x0(,%rax,8),%rdx

%BITS_PER_LONG is always a pow-2 (either 32 or 64), but GCC still does
full division of `nbits + 63` by it and then multiplication by 8.
Instead of BITS_TO_LONGS(), use ALIGN() and then divide by 8. GCC:

8d 50 3f             	lea    0x3f(%rax),%edx
c1 ea 03             	shr    $0x3,%edx
81 e2 f8 ff ff 1f    	and    $0x1ffffff8,%edx

Now it shifts `nbits + 63` by 3 positions (IOW performs fast division
by 8) and then masks bits[2:0]. bloat-o-meter:

add/remove: 0/0 grow/shrink: 20/133 up/down: 156/-773 (-617)

Clang does it better and generates the same code before/after starting
from -O1, except that with the ALIGN() approach it uses %edx and thus
still saves some bytes:

add/remove: 0/0 grow/shrink: 9/133 up/down: 18/-538 (-520)

Note that we can't expand DIV_ROUND_UP() by adding a check and using
this approach there, as it's used in array declarations where
expressions are not allowed.
Add this helper to tools/ as well.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/md/dm-clone-metadata.c | 5 -----
 drivers/s390/cio/idset.c       | 2 +-
 include/linux/bitmap.h         | 8 +++++---
 include/linux/cpumask.h        | 2 +-
 lib/math/prime_numbers.c       | 2 --
 tools/include/linux/bitmap.h   | 7 ++++---
 6 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/md/dm-clone-metadata.c b/drivers/md/dm-clone-metadata.c
index c43d55672bce..47c1fa7aad8b 100644
--- a/drivers/md/dm-clone-metadata.c
+++ b/drivers/md/dm-clone-metadata.c
@@ -465,11 +465,6 @@ static void __destroy_persistent_data_structures(struct dm_clone_metadata *cmd)
 
 /*---------------------------------------------------------------------------*/
 
-static size_t bitmap_size(unsigned long nr_bits)
-{
-	return BITS_TO_LONGS(nr_bits) * sizeof(long);
-}
-
 static int __dirty_map_init(struct dirty_map *dmap, unsigned long nr_words,
 			    unsigned long nr_regions)
 {
diff --git a/drivers/s390/cio/idset.c b/drivers/s390/cio/idset.c
index 0a1105a483bf..e5f28370a903 100644
--- a/drivers/s390/cio/idset.c
+++ b/drivers/s390/cio/idset.c
@@ -18,7 +18,7 @@ struct idset {
 
 static inline unsigned long idset_bitmap_size(int num_ssid, int num_id)
 {
-	return BITS_TO_LONGS(num_ssid * num_id) * sizeof(unsigned long);
+	return bitmap_size(size_mul(num_ssid, num_id));
 }
 
 static struct idset *idset_new(int num_ssid, int num_id)
diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 7ca0379be8c1..9a6a27a7f675 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -218,9 +218,11 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = bitmap_size(nbits);
 
 	if (small_const_nbits(nbits))
 		*dst = 0;
@@ -230,7 +232,7 @@ static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 
 static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = bitmap_size(nbits);
 
 	if (small_const_nbits(nbits))
 		*dst = ~0UL;
@@ -241,7 +243,7 @@ static inline void bitmap_fill(unsigned long *dst, unsigned int nbits)
 static inline void bitmap_copy(unsigned long *dst, const unsigned long *src,
 			unsigned int nbits)
 {
-	unsigned int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
+	unsigned int len = bitmap_size(nbits);
 
 	if (small_const_nbits(nbits))
 		*dst = *src;
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..a2064c2a9441 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -839,7 +839,7 @@ static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
  */
 static inline unsigned int cpumask_size(void)
 {
-	return BITS_TO_LONGS(large_cpumask_bits) * sizeof(long);
+	return bitmap_size(large_cpumask_bits);
 }
 
 /*
diff --git a/lib/math/prime_numbers.c b/lib/math/prime_numbers.c
index d42cebf7407f..d3b64b10da1c 100644
--- a/lib/math/prime_numbers.c
+++ b/lib/math/prime_numbers.c
@@ -6,8 +6,6 @@
 #include <linux/prime_numbers.h>
 #include <linux/slab.h>
 
-#define bitmap_size(nbits) (BITS_TO_LONGS(nbits) * sizeof(unsigned long))
-
 struct primes {
 	struct rcu_head rcu;
 	unsigned long last, sz;
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 8c6852dba04f..210c13b1b857 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -26,13 +26,14 @@ bool __bitmap_intersects(const unsigned long *bitmap1,
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 #define BITMAP_LAST_WORD_MASK(nbits) (~0UL >> (-(nbits) & (BITS_PER_LONG - 1)))
 
+#define bitmap_size(nbits)	(ALIGN(nbits, BITS_PER_LONG) / BITS_PER_BYTE)
+
 static inline void bitmap_zero(unsigned long *dst, unsigned int nbits)
 {
 	if (small_const_nbits(nbits))
 		*dst = 0UL;
 	else {
-		int len = BITS_TO_LONGS(nbits) * sizeof(unsigned long);
-		memset(dst, 0, len);
+		memset(dst, 0, bitmap_size(nbits));
 	}
 }
 
@@ -84,7 +85,7 @@ static inline void bitmap_or(unsigned long *dst, const unsigned long *src1,
  */
 static inline unsigned long *bitmap_zalloc(int nbits)
 {
-	return calloc(1, BITS_TO_LONGS(nbits) * sizeof(unsigned long));
+	return calloc(1, bitmap_size(nbits));
 }
 
 /*
-- 
2.41.0


