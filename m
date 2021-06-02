Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF0B397EB1
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 04:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhFBCR1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 22:17:27 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49090 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhFBCR0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 22:17:26 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 487001FD2D
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622600143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L0ewTK4vZNbePpCFkKVH+LjZjB2V38dLEdci3FO5mSw=;
        b=oOyMFGTvwAdu75YIEzJgKIEEdvC+V/UWQS9SB01YMmuCqgj52fRxNAmczaWOv4qqBEicdz
        CpEI4jlhM6/F+O5kGL9uSaJHw3W8L4UgBVk1M7iKlxOCAVStLaQwOCPeo/om5ZPebb713q
        AluO8O/5FKmkV2ydv5gYz/3ol0qlcfE=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 487C0A3B81
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 06/10] btrfs: defrag: introduce a helper to defrag a range
Date:   Wed,  2 Jun 2021 10:15:24 +0800
Message-Id: <20210602021528.68617-7-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602021528.68617-1-wqu@suse.com>
References: <20210602021528.68617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A new helper, defrag_one_range(), is introduced to defrag one range.

This function will mostly prepare the needed pages and extent status for
defrag_one_locked_target().

As we can only have a consistent view of extent map with page and
extent bits locked, we need to re-check the range passed in to get a
real target list for defrag_one_locked_target().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 26957cd91ea6..a5ca752bcda8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1548,6 +1548,77 @@ static int defrag_one_locked_target(struct btrfs_inode *inode,
 	return ret;
 }
 
+static int defrag_one_range(struct btrfs_inode *inode,
+			    u64 start, u32 len,
+			    u32 extent_thresh, u64 newer_than,
+			    bool do_compress)
+{
+	struct extent_state *cached_state = NULL;
+	struct defrag_target_range *entry;
+	struct defrag_target_range *tmp;
+	LIST_HEAD(target_list);
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
+	/* Prepare all pages */
+	for (i = 0; i < nr_pages; i++) {
+		pages[i] = defrag_prepare_one_page(inode, start_index + i);
+		if (IS_ERR(pages[i])) {
+			ret = PTR_ERR(pages[i]);
+			pages[i] = NULL;
+			goto free_pages;
+		}
+	}
+	/* Also lock the pages range */
+	lock_extent_bits(&inode->io_tree, start_index << PAGE_SHIFT,
+			 (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+			 &cached_state);
+	/*
+	 * Now we have a consistent view about the extent map, re-check
+	 * which range really need to be defraged.
+	 */
+	ret = defrag_collect_targets(inode, start, len, extent_thresh,
+				     newer_than, do_compress, &target_list);
+	if (ret < 0)
+		goto unlock_extent;
+
+	list_for_each_entry(entry, &target_list, list) {
+		ret = defrag_one_locked_target(inode, entry, pages, nr_pages);
+		if (ret < 0)
+			break;
+	}
+
+	list_for_each_entry_safe(entry, tmp, &target_list, list) {
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+unlock_extent:
+	unlock_extent_cached(&inode->io_tree, start_index << PAGE_SHIFT,
+			     (last_index << PAGE_SHIFT) + PAGE_SIZE - 1,
+			     &cached_state);
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

