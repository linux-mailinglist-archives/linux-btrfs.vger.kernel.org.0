Return-Path: <linux-btrfs+bounces-100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FA37EA221
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 18:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9785F1C2095D
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1814922F0B;
	Mon, 13 Nov 2023 17:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xx09J7bU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4D122EFB;
	Mon, 13 Nov 2023 17:37:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DFE9173A;
	Mon, 13 Nov 2023 09:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897057; x=1731433057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WC84IXj/Kc3tJW0HYnQfLmcK97LUidMkeT2CxDdJbZY=;
  b=Xx09J7bUtHewXrv6S6FedXzOW2w/cWkKNhokYYmyS+OmJ24SjKRE/V3L
   Il59ylYZnuQGLAOjE8FkmnwELamE7fxQBqZO9cAEMRv0NgNngpyOJynVM
   qU9h6nba3AYC+LN9+t+p/G2uxQOdn84pabShT+et/Zy/VYgpN7++5E32W
   P7lKrhLFPQVy5lmKZEx3bY084ItqtcLO3DWG4Yy9MXjhpizkA/3Zr2aqU
   pIrrQN0VbIsjZ8HVJgt5hv908RediSxDLCsPSwaiLgtMf5THBUN7kkpx1
   Pq42bfbl46oeguW4KP1EUrMNOmOXUKD7kXtFAgHlC+Yz/5btvUB3fBNrD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370671553"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370671553"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:37:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095812659"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095812659"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 09:37:34 -0800
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
Subject: [PATCH v3 04/11] linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
Date: Mon, 13 Nov 2023 18:37:10 +0100
Message-ID: <20231113173717.927056-5-aleksander.lobakin@intel.com>
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

Since commit b03fc1173c0c ("bitops: let optimize out non-atomic bitops
on compile-time constants"), the non-atomic bitops are macros which can
be expanded by the compilers into compile-time expressions, which will
result in better optimized object code. Unfortunately, turned out that
passing `volatile` to those macros discards any possibility of
optimization, as the compilers then don't even try to look whether
the passed bitmap is known at compilation time. In addition to that,
the mentioned linkmode helpers are marked with `inline`, not
`__always_inline`, meaning that it's not guaranteed some compiler won't
uninline them for no reason, which will also effectively prevent them
from being optimized (it's a well-known thing the compilers sometimes
uninline `2 + 2`).
Convert linkmode_*_bit() from inlines to macros. Their calling
convention are 1:1 with the corresponding bitops, so that it's not even
needed to enumerate and map the arguments, only the names. No changes in
vmlinux' object code (compiled by LLVM for x86_64) whatsoever, but that
doesn't necessarily means the change is meaningless.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/linkmode.h | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
index 7303b4bc2ce0..f231e2edbfa5 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -38,29 +38,10 @@ static inline int linkmode_andnot(unsigned long *dst, const unsigned long *src1,
 	return bitmap_andnot(dst, src1, src2,  __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
-static inline void linkmode_set_bit(int nr, volatile unsigned long *addr)
-{
-	__set_bit(nr, addr);
-}
-
-static inline void linkmode_clear_bit(int nr, volatile unsigned long *addr)
-{
-	__clear_bit(nr, addr);
-}
-
-static inline void linkmode_mod_bit(int nr, volatile unsigned long *addr,
-				    int set)
-{
-	if (set)
-		linkmode_set_bit(nr, addr);
-	else
-		linkmode_clear_bit(nr, addr);
-}
-
-static inline int linkmode_test_bit(int nr, const volatile unsigned long *addr)
-{
-	return test_bit(nr, addr);
-}
+#define linkmode_test_bit	test_bit
+#define linkmode_set_bit	__set_bit
+#define linkmode_clear_bit	__clear_bit
+#define linkmode_mod_bit	__assign_bit
 
 static inline void linkmode_set_bit_array(const int *array, int array_size,
 					  unsigned long *addr)
-- 
2.41.0


