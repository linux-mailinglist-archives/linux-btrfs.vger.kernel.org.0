Return-Path: <linux-btrfs+bounces-2002-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FD3845790
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534111C23DF0
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4116D5336B;
	Thu,  1 Feb 2024 12:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dhIqul19"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD36015F318;
	Thu,  1 Feb 2024 12:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790249; cv=none; b=O/B96T+BgZVi13NC95nKZlUZoNnN0xMr7GXiMh6gn8lJFYAQVwIAu41Iy5JAIHOAWShATdJHRBJkVU8ZO6VryHN/FY/8sBUtml/w6ZKG1bcAFjM2TMnp3jtyfe9r3/jW4u90vBYBS8ovarPjXdOEo+JWy5GpZAB+D8PNcscEzfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790249; c=relaxed/simple;
	bh=7hQbTbBHJUnj59SwHJFVRJ8NAAFr11mdikwNORShsF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJ9C5SBoBL+bPOYHp8eGgQ51ZoySUA+PWsMZBID+vokhk5fmonEUyMFrWbyhr+k2YIhrhURTEDcbaVTOh8Lj5g/Qqncz8UsJVGRvFUCdicU5IP5ff9KWMr9HyrFYh9Al9/Btzq1db4VlFuQ/chDaTAyTqtTa6eO9EezCIVElmX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dhIqul19; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790248; x=1738326248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7hQbTbBHJUnj59SwHJFVRJ8NAAFr11mdikwNORShsF0=;
  b=dhIqul19FerNAfAYtVb3TDX5ktN5m0+m6dEMr545ATqSf8XqCF/+pAL9
   i7ywq3Fuw75Dm9hSUBWY7Vce9JfgkXoHZIi/MW9SU1rrUClCwPdsBr8tS
   xAObjbgygrlfr83pixDlIy93rqxxr0QtvkEwXSXehTbc7HnpiZkfO2WnR
   MMvz1uAfgYAdzePHB9Q1JM2HlrBY7UPBBLCyTpFkW1qavISUVV41KvLsD
   Njfew4vafXNUjuhY5oGX59SBX5zADHcHYnlCQwd2epyULQW/jz1a8TJVw
   2Mp/3dwaqYc7wp5/nncrSzhGvm4T7n2mo7lF9ESlJ0lMMFw4y0yAo5wI1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3747011"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3747011"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:24:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499108"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:24:03 -0800
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
Subject: [PATCH net-next v5 07/21] linkmode: convert linkmode_{test,set,clear,mod}_bit() to macros
Date: Thu,  1 Feb 2024 13:22:02 +0100
Message-ID: <20240201122216.2634007-8-aleksander.lobakin@intel.com>
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
index 287f590ed56b..d94bfd9ac8cc 100644
--- a/include/linux/linkmode.h
+++ b/include/linux/linkmode.h
@@ -43,29 +43,10 @@ static inline int linkmode_andnot(unsigned long *dst, const unsigned long *src1,
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
2.43.0


