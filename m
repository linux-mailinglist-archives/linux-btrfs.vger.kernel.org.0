Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A195630467F
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Jan 2021 19:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730856AbhAZRX3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Jan 2021 12:23:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:54362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390262AbhAZIfI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Jan 2021 03:35:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611650061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=53sXpeOi0krDhFcsRtSKZuJon3LKbdzOpHmgNvB7MFQ=;
        b=G965OtYBidwsgssnp0NU1N7tx0ZDL66YTiyi8Jqyd+Gb6meMtKz0ZTiTZ6YCycb2S1cUUk
        GdbItFKkzXgMZUoKRCBU6TRvyo/fCwSaoQEOI1qZcuRfBLkKPRyMTmPuyhvgxhhyqXkeAW
        2bC5zeUBFEzdB4XvbYub8kWBR25JSds=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D202CAF38;
        Tue, 26 Jan 2021 08:34:21 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: [PATCH v5 03/18] btrfs: introduce the skeleton of btrfs_subpage structure
Date:   Tue, 26 Jan 2021 16:33:47 +0800
Message-Id: <20210126083402.142577-4-wqu@suse.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126083402.142577-1-wqu@suse.com>
References: <20210126083402.142577-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For sectorsize < page size support, we need a structure to record extra
status info for each sector of a page.

Introduce the skeleton structure, all subpage related code would go to
subpage.[ch].

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/Makefile  |  3 ++-
 fs/btrfs/subpage.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/subpage.h | 33 +++++++++++++++++++++++++++++++++
 fs/btrfs/super.c   |  1 -
 4 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 fs/btrfs/subpage.c
 create mode 100644 fs/btrfs/subpage.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 9f1b1a88e317..942562e11456 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -11,7 +11,8 @@ btrfs-y += super.o ctree.o extent-tree.o print-tree.o root-tree.o dir-item.o \
 	   compression.o delayed-ref.o relocation.o delayed-inode.o scrub.o \
 	   reada.o backref.o ulist.o qgroup.o send.o dev-replace.o raid56.o \
 	   uuid-tree.o props.o free-space-tree.o tree-checker.o space-info.o \
-	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o
+	   block-rsv.o delalloc-space.o block-group.o discard.o reflink.o \
+	   subpage.o
 
 btrfs-$(CONFIG_BTRFS_FS_POSIX_ACL) += acl.o
 btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
new file mode 100644
index 000000000000..a3e5b6a13d54
--- /dev/null
+++ b/fs/btrfs/subpage.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/slab.h>
+#include "ctree.h"
+#include "subpage.h"
+
+int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
+			 struct page *page, enum btrfs_subpage_type type)
+{
+	struct btrfs_subpage *subpage;
+
+	/*
+	 * We have cases like a dummy extent buffer page, which is not mappped
+	 * and doesn't need to be locked.
+	 */
+	if (page->mapping)
+		ASSERT(PageLocked(page));
+	/* Either not subpage, or the page already has private attached */
+	if (fs_info->sectorsize == PAGE_SIZE || PagePrivate(page))
+		return 0;
+
+	subpage = kzalloc(sizeof(struct btrfs_subpage), GFP_NOFS);
+	if (!subpage)
+		return -ENOMEM;
+
+	spin_lock_init(&subpage->lock);
+	attach_page_private(page, subpage);
+	return 0;
+}
+
+void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
+			  struct page *page)
+{
+	struct btrfs_subpage *subpage;
+
+	/* Either not subpage, or already detached */
+	if (fs_info->sectorsize == PAGE_SIZE || !PagePrivate(page))
+		return;
+
+	subpage = (struct btrfs_subpage *)detach_page_private(page);
+	ASSERT(subpage);
+	kfree(subpage);
+}
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
new file mode 100644
index 000000000000..676280bc7562
--- /dev/null
+++ b/fs/btrfs/subpage.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_SUBPAGE_H
+#define BTRFS_SUBPAGE_H
+
+#include <linux/spinlock.h>
+
+/*
+ * Maximum page size we support is 64K, minimum sector size is 4K, u16 bitmap
+ * is sufficient. Regular bitmap_* is not used due to size reasons.
+ */
+#define BTRFS_SUBPAGE_BITMAP_SIZE	16
+
+/*
+ * Structure to trace status of each sector inside a page, attached to
+ * page::private for both data and metadata inodes.
+ */
+struct btrfs_subpage {
+	/* Common members for both data and metadata pages */
+	spinlock_t lock;
+};
+
+enum btrfs_subpage_type {
+	BTRFS_SUBPAGE_METADATA,
+	BTRFS_SUBPAGE_DATA,
+};
+
+int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
+			 struct page *page, enum btrfs_subpage_type type);
+void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info,
+			  struct page *page);
+
+#endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 12d7d3be7cd4..919ed5c357e9 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -48,7 +48,6 @@
 #include "tests/btrfs-tests.h"
 #include "block-group.h"
 #include "discard.h"
-
 #include "qgroup.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
-- 
2.30.0

