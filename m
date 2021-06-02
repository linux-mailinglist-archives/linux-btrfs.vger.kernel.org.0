Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2567F397EB0
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 04:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhFBCRZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 22:17:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39000 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhFBCRY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 22:17:24 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7D6C92194F
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622600141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MO0iBTta4de6gsPKrD0AUH85Ji1gCV5Wo2lVn6EwIa0=;
        b=UfVaOqDUfSR7z0C/2EyMdXyQmlWrAH6NBzrGUupxV9tdkW7wsdx7fiTjoHcRXgHhoQYbId
        SiZ/8QGjEPzgXZeJHj/GsAlYDvdV/qKMVJZpHsWkPC35MtSVx/cbDYbrjt2TqB39v6e8M2
        /OPlPs2CJjLCEUBmgem7pS7PCeGgmRY=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 7E05DA3B81
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:40 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 05/10] btrfs: defrag: introduce a helper to defrag a continuous prepared range
Date:   Wed,  2 Jun 2021 10:15:23 +0800
Message-Id: <20210602021528.68617-6-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602021528.68617-1-wqu@suse.com>
References: <20210602021528.68617-1-wqu@suse.com>
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
index 6af37a9e0738..26957cd91ea6 100644
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
+				    struct page **pages, int nr_pages)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_changeset *data_reserved = NULL;
+	struct extent_state *cached_state = NULL;
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
+			 EXTENT_DEFRAG, 0, 0, &cached_state);
+	set_extent_defrag(&inode->io_tree, start, start + len - 1,
+			  &cached_state);
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
2.31.1

