Return-Path: <linux-btrfs+bounces-2007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D728457A4
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F2B1F2216D
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7035D48C;
	Thu,  1 Feb 2024 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UColmj6U"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D885D475;
	Thu,  1 Feb 2024 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790275; cv=none; b=Jol6mYw+2XQFmOUf1ohW8cSJG5IFrS0FYJ0p0fUvXmKdw3gnoyqrj3JkHdyC+Jq6JLjPq048dmHlhA/ocuvJReJx8MpWqgFrM82Z+tsKAxddfQHBYJAujReP+z4AbzIczgvJhoJF4EXDcVqcJ9wqBxniZqId920UKJMDjaUgxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790275; c=relaxed/simple;
	bh=ImMPqSa/1eG79rUA6sfyblWF47HclOUIR1Qm/VfkB8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=frB1YgMXtZMJUC5kJhzL2SUBemVQ1txAaO/XgyqxYpVLfo1XXQwKkMQtrv8BeBdl0zMeXyI7ZHqQHqHOP6aVC7U7dS0Nb14m72MN7iGNg9JTyXfycJ7yi6JvktfkBLm4EPqArOuVt58nX5rEXc2APt/67OVHqeLoHSVkofy3IuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UColmj6U; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790274; x=1738326274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ImMPqSa/1eG79rUA6sfyblWF47HclOUIR1Qm/VfkB8I=;
  b=UColmj6UjYpuFnHYazC+YM32SRoo6Aiu3Pk4whCiHAg9YTxazctDMv1E
   KmpR+4HbEmXhevo8puS7sadasC5AkmNnMDr3JHXJZEcDUvFRdYBVFPiDT
   A623aU914jEpZFNQ43klEtbzzntJ/8YRnkt6rRajqYKDuKHcX9z5i3O1b
   Wj7CDFl2A8gb8s8kzlzXV3ucBx8lZb9EV+KBwnuU0PzcLAiJZ7Qzu5g1i
   aR+uF4EZ9YF7xqXzmKcwYxSndbdg2nzwICX8psYzNG1zfSd7sp0wtOqeO
   56vVproQKMdeVH57NncvY3tBPz3OKFay5Jdwg826m/1xRFwGGlQOXM6vU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3747109"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3747109"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:24:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499125"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:24:28 -0800
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
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 12/21] bitmap: introduce generic optimized bitmap_size()
Date: Thu,  1 Feb 2024 13:22:07 +0100
Message-ID: <20240201122216.2634007-13-aleksander.lobakin@intel.com>
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
 include/linux/bitmap.h         | 8 +++++---
 include/linux/cpumask.h        | 2 +-
 tools/include/linux/bitmap.h   | 7 ++++---
 drivers/md/dm-clone-metadata.c | 5 -----
 drivers/s390/cio/idset.c       | 2 +-
 lib/math/prime_numbers.c       | 2 --
 6 files changed, 11 insertions(+), 15 deletions(-)

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
-- 
2.43.0


