Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFFE3A23B8
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 07:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFJFL0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 01:11:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48242 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhFJFL0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 01:11:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3AE691FD37
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jun 2021 05:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623301770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nvVUDFD4RZ3BG8+q5qSSYC5VdidlH3x+AF4LH79ojWE=;
        b=n0KK13NH9ZMlP/GRoALs68tfXrgw12PhVXL4AVCCr2wineOInWqTnbE6lIT15MJqE8Uncr
        RYQ6Z6PIF29wGL8QRiQPE1dD6SbCvlazJbAJuBG4OvAGEmI30nXc1aWcq+ViSnhsbjsgQE
        Akaitzul936dEELOTY0EVo0Rf7sSKfs=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 3CD34A3B81
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jun 2021 05:09:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 05/10] btrfs: defrag: introduce a helper to defrag a continuous prepared range
Date:   Thu, 10 Jun 2021 13:09:12 +0800
Message-Id: <20210610050917.105458-6-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610050917.105458-1-wqu@suse.com>
References: <20210610050917.105458-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A new helper, defrag_one_locked_target(), introduced to do the real part
of defrag.

The caller needs to ensure both page and extents bits are locked, and no
ordered extent for the range, and all writeback is finished.

The core defrag part is pretty straight-forward:

- Reserve space
- Set extent bits to defrag
- Update involved pages to be dirty

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0bfd13b959ed..423c880e42d4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -47,6 +47,7 @@
 #include "space-info.h"
 #include "delalloc-space.h"
 #include "block-group.h"
+#include "subpage.h"
 
 #ifdef CONFIG_64BIT
 /* If we have a 32-bit userspace and 64-bit kernel, then the UAPI
@@ -1492,6 +1493,61 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 	return ret;
 }
 
+#define CLUSTER_SIZE	(SZ_256K)
+
+/*
+ * Defrag one continuous target range.
+ *
+ * @inode:	Target inode
+ * @target:	Target range to defrag
+ * @pages:	Locked pages covering the defrag range
+ * @nr_pages:	Number of locked pages
+ *
+ * Caller should ensure:
+ *
+ * - Pages are prepared
+ *   Pages should be locked, no ordered extent in the pages range,
+ *   no writeback.
+ *
+ * - Extent bits are locked
+ */
+static int defrag_one_locked_target(struct btrfs_inode *inode,
+				    struct defrag_target_range *target,
+				    struct page **pages, int nr_pages,
+				    struct extent_state **cached_state)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_changeset *data_reserved = NULL;
+	const u64 start = target->start;
+	const u64 len = target->len;
+	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
+	unsigned long start_index = start >> PAGE_SHIFT;
+	unsigned long first_index = page_index(pages[0]);
+	int ret = 0;
+	int i;
+
+	ASSERT(last_index - first_index + 1 <= nr_pages);
+
+	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start, len);
+	if (ret < 0)
+		return ret;
+	clear_extent_bit(&inode->io_tree, start, start + len - 1,
+			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING |
+			 EXTENT_DEFRAG, 0, 0, cached_state);
+	set_extent_defrag(&inode->io_tree, start, start + len - 1,
+			  cached_state);
+
+	/* Update the page status */
+	for (i = start_index - first_index; i <= last_index - first_index;
+	     i++) {
+		ClearPageChecked(pages[i]);
+		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
+	}
+	btrfs_delalloc_release_extents(inode, len);
+	extent_changeset_free(data_reserved);
+	return ret;
+}
+
 /*
  * Btrfs entrace for defrag.
  *
-- 
2.32.0

