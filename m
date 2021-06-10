Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D9D3A23BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jun 2021 07:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhFJFLa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Jun 2021 01:11:30 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48248 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhFJFLa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Jun 2021 01:11:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BAFB01FD37
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jun 2021 05:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623301773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Bm9VnlJjip633Hs0lFF/lCU7L1DFI1eI5HWm3bdCzs=;
        b=Mr2e1czD1XPZ8KVw8tXRI9xrtaMgh8RNB69jCem/7SrzPg84kC65P2t7aJxJwhJPMd+h/n
        +J+j2b4IRFndD4LpUQ8Rjxn91yBm/2OorzYrWgLVs/1sk9d+38zQwsyUfsfm3vuqy2kenU
        aFBR5Goo793bU0PI+/pYFtQxle4jG30=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id BAE00A3B81
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jun 2021 05:09:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 07/10] btrfs: defrag: introduce a new helper to defrag one cluster
Date:   Thu, 10 Jun 2021 13:09:14 +0800
Message-Id: <20210610050917.105458-8-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210610050917.105458-1-wqu@suse.com>
References: <20210610050917.105458-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This new helper, defrag_one_cluster(), will defrag one cluster (at most
256K) by:

- Collect all initial targets

- Kick in readahead when possible

- Call defrag_one_range() on each initial target
  With some extra range clamping.

- Update @sectors_defragged parameter

This involves one behavior change, the defragged sectors accounting is
no longer as accurate as old behavior, as the initial targets are not
consistent.

We can have new holes punched inside the initial target, and we will
skip such holes later.
But the defragged sectors accounting doesn't need to be that accurate
anyway, thus I don't want to pass those extra accounting burden into
defrag_one_range().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7ca013781e69..c7f41b8f313d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1630,6 +1630,62 @@ static int defrag_one_range(struct btrfs_inode *inode,
 	return ret;
 }
 
+static int defrag_one_cluster(struct btrfs_inode *inode,
+			      struct file_ra_state *ra,
+			      u64 start, u32 len, u32 extent_thresh,
+			      u64 newer_than, bool do_compress,
+			      unsigned long *sectors_defragged,
+			      unsigned long max_sectors)
+{
+	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	struct defrag_target_range *entry;
+	struct defrag_target_range *tmp;
+	LIST_HEAD(target_list);
+	int ret;
+
+	BUILD_BUG_ON(!IS_ALIGNED(CLUSTER_SIZE, PAGE_SIZE));
+	ret = defrag_collect_targets(inode, start, len, extent_thresh,
+				     newer_than, do_compress, false,
+				     &target_list);
+	if (ret < 0)
+		goto out;
+
+	list_for_each_entry(entry, &target_list, list) {
+		u32 range_len = entry->len;
+
+		/* Reached the limit */
+		if (max_sectors && max_sectors == *sectors_defragged)
+			break;
+
+		if (max_sectors)
+			range_len = min_t(u32, range_len,
+				(max_sectors - *sectors_defragged) * sectorsize);
+
+		if (ra)
+			page_cache_sync_readahead(inode->vfs_inode.i_mapping,
+				ra, NULL, entry->start >> PAGE_SHIFT,
+				((entry->start + range_len - 1) >> PAGE_SHIFT) -
+				(entry->start >> PAGE_SHIFT) + 1);
+		/*
+		 * Here we may not defrag any range if holes are punched before
+		 * we locked the pages.
+		 * But that's fine, it only affects the @sectors_defragged
+		 * accounting.
+		 */
+		ret = defrag_one_range(inode, entry->start, range_len,
+					extent_thresh, newer_than, do_compress);
+		if (ret < 0)
+			break;
+		*sectors_defragged += range_len;
+	}
+out:
+	list_for_each_entry_safe(entry, tmp, &target_list, list) {
+		list_del_init(&entry->list);
+		kfree(entry);
+	}
+	return ret;
+}
+
 /*
  * Btrfs entrace for defrag.
  *
-- 
2.32.0

