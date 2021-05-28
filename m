Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23F393B65
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 May 2021 04:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbhE1CaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 May 2021 22:30:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236118AbhE1CaH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 May 2021 22:30:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622168912; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ho1T7lVxJUIKLOB6ztK3YU6xhZt1MdU9tSDj4izT334=;
        b=A8IBqSUVmC7YbYzhPjykeoDd2MweCIA8/UbmGFBDhZpIHIjF9bWELmpUsYe/csjJIkbtv4
        O+HW15BaS/7cJ4gxzF0H9zhkkv5I1zn3pzVBoXLqtLxuvCLRcOvuv6UeAIn3X5bgyM1crF
        P1ud1qHmP2gKXPBmcBnVYE+ifXsEdUk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15BEDAC3A
        for <linux-btrfs@vger.kernel.org>; Fri, 28 May 2021 02:28:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/7] btrfs: defrag: introduce a helper to defrag a continuous range
Date:   Fri, 28 May 2021 10:28:18 +0800
Message-Id: <20210528022821.81386-5-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528022821.81386-1-wqu@suse.com>
References: <20210528022821.81386-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Intrudouce a helper, defrag_one_target(), to defrag one continuous range
by:

- Lock and read the page
- Set the extent range defrag
- Set the involved page range dirty

There is a special note here, since the target range may be a hole now,
we use btrfs_set_extent_delalloc() with EXTENT_DEFRAG as @extra_bits,
other than set_extent_defrag().

This would properly add EXTENT_DELALLOC_NEW bit to make inode nbytes
updated properly, and still handle regular extents without any problem.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 1e57293a05f2..cd7650bcc70c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1486,6 +1486,82 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 	return ret;
 }
 
+#define CLUSTER_SIZE	(SZ_256K)
+static int defrag_one_target(struct btrfs_inode *inode,
+			     struct file_ra_state *ra, u64 start, u32 len)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct extent_changeset *data_reserved = NULL;
+	struct extent_state *cached_state = NULL;
+	struct page **pages;
+	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	unsigned long last_index = (start + len - 1) >> PAGE_SHIFT;
+	unsigned long start_index = start >> PAGE_SHIFT;
+	unsigned int nr_pages = last_index - start_index + 1;
+	int ret = 0;
+	int i;
+
+	ASSERT(nr_pages <= CLUSTER_SIZE / PAGE_SIZE);
+	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
+
+	pages = kzalloc(sizeof(struct page *) * nr_pages, GFP_NOFS);
+	if (!pages)
+		return -ENOMEM;
+
+	/* Kick in readahead */
+	if (ra)
+		page_cache_sync_readahead(inode->vfs_inode.i_mapping, ra, NULL,
+					  start_index, nr_pages);
+
+	/* Prepare all pages */
+	for (i = 0; i < nr_pages; i++) {
+		pages[i] = defrag_prepare_one_page(inode, start_index + i);
+		if (IS_ERR(pages[i])) {
+			ret = PTR_ERR(pages[i]);
+			pages[i] = NULL;
+			goto free_pages;
+		}
+	}
+	ret = btrfs_delalloc_reserve_space(inode, &data_reserved, start, len);
+	if (ret < 0)
+		goto free_pages;
+
+	/* Lock the extent bits and update the extent bits*/
+	lock_extent_bits(&inode->io_tree, start, start + len - 1,
+			 &cached_state);
+	clear_extent_bit(&inode->io_tree, start, start + len - 1,
+			 EXTENT_DELALLOC | EXTENT_DO_ACCOUNTING | EXTENT_DEFRAG,
+			 0, 0, &cached_state);
+
+	/*
+	 * Since the target list is gathered without inode nor extent lock, we
+	 * may get a range which is now a hole.
+	 * In that case, we have to set it with DELALLOC_NEW as if we're
+	 * writing a new data, or inode nbytes will mismatch.
+	 */
+	ret = btrfs_set_extent_delalloc(inode, start, start + len - 1,
+					EXTENT_DEFRAG, &cached_state);
+	/* Update the page status */
+	for (i = 0; i < nr_pages; i++) {
+		ClearPageChecked(pages[i]);
+		btrfs_page_clamp_set_dirty(fs_info, pages[i], start, len);
+	}
+	unlock_extent_cached(&inode->io_tree, start, start + len - 1,
+			     &cached_state);
+	btrfs_delalloc_release_extents(inode, len);
+	extent_changeset_free(data_reserved);
+
+free_pages:
+	for (i = 0; i < nr_pages; i++) {
+		if (pages[i]) {
+			unlock_page(pages[i]);
+			put_page(pages[i]);
+		}
+	}
+	kfree(pages);
+	return ret;
+}
+
 /*
  * Btrfs entrace for defrag.
  *
-- 
2.31.1

