Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDAA3330CC
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Mar 2021 22:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCIVWU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Mar 2021 16:22:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:60761 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230320AbhCIVVw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Mar 2021 16:21:52 -0500
IronPort-SDR: IFDnFZ2mL30sbEd8nlWQ4IVjd4NbyZwQ69pjsPoPNf71LDERH2pY00eZQulZ7SAy8m5fLU/Jl2
 BBpu9100gqEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249698111"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="249698111"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 13:21:49 -0800
IronPort-SDR: DXIvulXrz6iwyMAMomsxCWlgVCQjJlfvLgkSyYTjtZrQinoUXt5JbINy1kxeuXrI9UVsMbXXty
 snNw3fxn8czQ==
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="509424707"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 13:21:49 -0800
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iov_iter: Lift memzero_page() to highmem.h
Date:   Tue,  9 Mar 2021 13:21:35 -0800
Message-Id: <20210309212137.2610186-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210309212137.2610186-1-ira.weiny@intel.com>
References: <20210309212137.2610186-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

memzero_page() can replace the kmap/memset/kunmap pattern in other
places in the code.  While zero_user() has the same interface it is not
the same call and its use should be limited and some of those calls may
be better converted from zero_user() to memzero_page().[1]  But that is
not addressed in this series.

Lift memzero_page() to highmem.

To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

[1] https://lore.kernel.org/lkml/CAHk-=wijdojzo56FzYqE5TOYw2Vws7ik3LEMGj9SPQaJJ+Z73Q@mail.gmail.com/
---
 include/linux/highmem.h | 7 +++++++
 lib/iov_iter.c          | 8 +-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 44170f312ae7..832b49b50c7b 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -332,4 +332,11 @@ static inline void memcpy_to_page(struct page *page, size_t offset,
 	kunmap_local(to);
 }
 
+static inline void memzero_page(struct page *page, size_t offset, size_t len)
+{
+	char *addr = kmap_atomic(page);
+	memset(addr + offset, 0, len);
+	kunmap_atomic(addr);
+}
+
 #endif /* _LINUX_HIGHMEM_H */
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f66c62aa7154..b0b1c8a01fae 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -5,6 +5,7 @@
 #include <linux/fault-inject-usercopy.h>
 #include <linux/uio.h>
 #include <linux/pagemap.h>
+#include <linux/highmem.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/splice.h>
@@ -464,13 +465,6 @@ void iov_iter_init(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_init);
 
-static void memzero_page(struct page *page, size_t offset, size_t len)
-{
-	char *addr = kmap_atomic(page);
-	memset(addr + offset, 0, len);
-	kunmap_atomic(addr);
-}
-
 static inline bool allocated(struct pipe_buffer *buf)
 {
 	return buf->ops == &default_pipe_buf_ops;
-- 
2.28.0.rc0.12.gb6a658bd00c9

