Return-Path: <linux-btrfs+bounces-104-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5E97EA22F
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 18:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96874280EE9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Nov 2023 17:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5342376A;
	Mon, 13 Nov 2023 17:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3wCLEkQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F523743;
	Mon, 13 Nov 2023 17:37:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DAB1728;
	Mon, 13 Nov 2023 09:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699897069; x=1731433069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QmLTJQ3DGSbK+0NxwdNEeIapVkPN18QwsI1fWOyABbg=;
  b=l3wCLEkQ+KK4P/xdLlmCEmnzeuR4CGMqhWy94bZRKPP8zZuQgIoIlYR6
   lB2ohGO0abivQ9+Y1i96iu+w/9pnbgBtyZ/s3mmTMi0JT415kg3qbDu9f
   CHNy1VDLMxBnpeNy6hkJiXIjfeuzV4OjrjUNj2q8g3AHBfcENw+FeALGW
   1o7TPjaA/OEhPPZwyVu5dSEknBfHN8ZUhb1wn2wdpJMgN7XUZOaLvLXOX
   SiEmkpI0l9bQzyEAShaMko5D+9pZabktmnYD8AUpxCBrhcCvbzxzw+nXt
   0IXv7eT2C8jeIP87qS3b5nrqxByxqIP2Sv7pD/zHmKePcMWIeMypU9RbM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="370671621"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="370671621"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 09:37:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1095812714"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1095812714"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmsmga005.fm.intel.com with ESMTP; 13 Nov 2023 09:37:46 -0800
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
Subject: [PATCH v3 08/11] tools: move alignment-related macros to new <linux/align.h>
Date: Mon, 13 Nov 2023 18:37:14 +0100
Message-ID: <20231113173717.927056-9-aleksander.lobakin@intel.com>
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

Currently, tools have *ALIGN*() macros scattered across the unrelated
headers, as there are only 3 of them and they were added separately
each time on an as-needed basis.
Anyway, let's make it more consistent with the kernel headers and allow
using those macros outside of the mentioned headers. Create
<linux/align.h> inside the tools/ folder and include it where needed.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 tools/include/linux/align.h  | 11 +++++++++++
 tools/include/linux/bitmap.h |  2 +-
 tools/include/linux/mm.h     |  5 +----
 3 files changed, 13 insertions(+), 5 deletions(-)
 create mode 100644 tools/include/linux/align.h

diff --git a/tools/include/linux/align.h b/tools/include/linux/align.h
new file mode 100644
index 000000000000..62e5582bbb1f
--- /dev/null
+++ b/tools/include/linux/align.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
2.41.0


