Return-Path: <linux-btrfs+bounces-2006-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521B78457A1
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 13:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A211DB2AF72
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ECC15F32A;
	Thu,  1 Feb 2024 12:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By9K1243"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD175CDF2;
	Thu,  1 Feb 2024 12:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790270; cv=none; b=Gt7hN7D43L5R/ERMlyrcLwDrHmaoMWYMn3W1XsTcenK+pqIt0RNSUbvYypKYCYO72TT6sWX0RKfe4HjKngT+Me97FzY/zqpIE1Uj+x2gENjolqzbz0IqOLtq60u76lVdXuwrPp4clyR8OeHqFXO7Q2omteM8zL7R219uSTgy3xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790270; c=relaxed/simple;
	bh=EhaxBT+fJeccFTGgUfkWLIZtD5dU/gVhB4d84ScaJSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rm1qzXMFKweJbrkysYK7o/S5x14pBMFU9L75oZnSz8xE4ZxfkuUpRnB2S8+0UfXYwP5Gd8/ArVJqaZYy51xfC1i0Pvsd/mBjiUGQJs1vq5TmUw+EHEuJqS3h01SYT5rgYBueDsTeYkzWEgl5YR6DN+6MKcC7bv5bVSOVk5K16Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By9K1243; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706790269; x=1738326269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EhaxBT+fJeccFTGgUfkWLIZtD5dU/gVhB4d84ScaJSA=;
  b=By9K1243/TuJz0dBaMixGFK7x0LSHOQmG2J/2ZhPpgiPH78HoVEDyHlf
   gGFpHAYqJbux4AhUMe3yehwoRQeih1UxBNe3fZzF7D3nVVQMpWck7mS70
   W7LmQKQySHqTcMthahbVg4w3Ardk4/ikhxClM0EU4ak4Ee/GhN5BQ5Cn/
   hEf8nJlG224RadlgA358Ha+waxB056v8PewmTHq/vuD9l3dF9+K4xgCSz
   iYai/VsjR3uXcOT9RTBrY+pUQKhRVGY+KXOwpGCx4aC8h9NMkI8fnYFzs
   lMpSuV5uglCu0+8HpA7mgoQl6XgtMgLjcCbqYtMEsVh5BMQ5eQZtmysXQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3747094"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="3747094"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:24:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4499122"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 01 Feb 2024 04:24:23 -0800
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
Subject: [PATCH net-next v5 11/21] tools: move alignment-related macros to new <linux/align.h>
Date: Thu,  1 Feb 2024 13:22:06 +0100
Message-ID: <20240201122216.2634007-12-aleksander.lobakin@intel.com>
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

Currently, tools have *ALIGN*() macros scattered across the unrelated
headers, as there are only 3 of them and they were added separately
each time on an as-needed basis.
Anyway, let's make it more consistent with the kernel headers and allow
using those macros outside of the mentioned headers. Create
<linux/align.h> inside the tools/ folder and include it where needed.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 tools/include/linux/align.h  | 12 ++++++++++++
 tools/include/linux/bitmap.h |  2 +-
 tools/include/linux/mm.h     |  5 +----
 3 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 tools/include/linux/align.h

diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
new file mode 100644
index 000000000000..14e34ace80dd
--- /dev/null
+++ b/tools/include/linux/align.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _TOOLS_LINUX_ALIGN_H
+#define _TOOLS_LINUX_ALIGN_H
+
+#include <uapi/linux/const.h>
+
+#define ALIGN(x, a)		__ALIGN_KERNEL((x), (a))
+#define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
+#define IS_ALIGNED(x, a)	(((x) & ((typeof(x))(a) - 1)) == 0)
+
+#endif /* _TOOLS_LINUX_ALIGN_H */
diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index f3566ea0f932..8c6852dba04f 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -3,6 +3,7 @@
 #define _TOOLS_LINUX_BITMAP_H
 
 #include <string.h>
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/find.h>
 #include <stdlib.h>
@@ -126,7 +127,6 @@ static inline bool bitmap_and(unsigned long *dst, const unsigned long *src1,
 #define BITMAP_MEM_ALIGNMENT (8 * sizeof(unsigned long))
 #endif
 #define BITMAP_MEM_MASK (BITMAP_MEM_ALIGNMENT - 1)
-#define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) == 0)
 
 static inline bool bitmap_equal(const unsigned long *src1,
 				const unsigned long *src2, unsigned int nbits)
diff --git a/tools/include/linux/mm.h b/tools/include/linux/mm.h
index f3c82ab5b14c..7a6b98f4e579 100644
--- a/tools/include/linux/mm.h
+++ b/tools/include/linux/mm.h
@@ -2,8 +2,8 @@
 #ifndef _TOOLS_LINUX_MM_H
 #define _TOOLS_LINUX_MM_H
 
+#include <linux/align.h>
 #include <linux/mmzone.h>
-#include <uapi/linux/const.h>
 
 #define PAGE_SHIFT		12
 #define PAGE_SIZE		(_AC(1, UL) << PAGE_SHIFT)
@@ -11,9 +11,6 @@
 
 #define PHYS_ADDR_MAX	(~(phys_addr_t)0)
 
-#define ALIGN(x, a)			__ALIGN_KERNEL((x), (a))
-#define ALIGN_DOWN(x, a)		__ALIGN_KERNEL((x) - ((a) - 1), (a))
-
 #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
 
 #define __va(x) ((void *)((unsigned long)(x)))
-- 
2.43.0


