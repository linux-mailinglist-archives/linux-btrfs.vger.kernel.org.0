Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44B9397EB2
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 04:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFBCR2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 22:17:28 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:39006 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhFBCR2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 22:17:28 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 15B1E2194F
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622600145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acd5yRSwQ2zRapn/VMLgsgcWXFaflAjHVru+xpKFUjA=;
        b=WUC/X//62oT7786Rxf9Ov14C3o5QobxWnf/4AorLFUzMAoZhPl+J22jhxIktJzKTuaZut5
        UAxAGaEwzL7DmYEGQE+oeKdDLyM454ygc/5NETOq2++WQ1xRFUUnM0EnpM8ruEM1bB58xI
        80lVtkzKYGHjRb216N44pXp5+d1fyG4=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id 12661A3B81
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 07/10] btrfs: defrag: introduce a new helper to defrag one cluster
Date:   Wed,  2 Jun 2021 10:15:25 +0800
Message-Id: <20210602021528.68617-8-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602021528.68617-1-wqu@suse.com>
References: <20210602021528.68617-1-wqu@suse.com>
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

- Update @sectors_defraged parameter

This involves one behavior change, the defraged sectors accounting is
no longer as accurate as old behavior, as the initial targets are not
consistent.

We can have new holes punched inside the initial target, and we will
skip such holes later.
But the defraged sectors accounting doesn't need to be that accurate
anyway, thus I don't want to pass those extra accounting burden into
defrag_one_range().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a5ca752bcda8..27bb67af44d8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1619,6 +1619,61 @@ static int defrag_one_range(struct btrfs_inode *inode,
 	return ret;
 }
 
+static int defrag_one_cluster(struct btrfs_inode *inode,
+			      struct file_ra_state *ra,
+			      u64 start, u32 len, u32 extent_thresh,
+			      u64 newer_than, bool do_compress,
+			      unsigned long *sectors_defraged,
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
+				     newer_than, do_compress, &target_list);
+	if (ret < 0)
+		goto out;
+
+	list_for_each_entry(entry, &target_list, list) {
+		u32 range_len = entry->len;
+
+		/* Reached the limit */
+		if (max_sectors && max_sectors == *sectors_defraged)
+			break;
+
+		if (max_sectors)
+			range_len = min_t(u32, range_len,
+				(max_sectors - *sectors_defraged) * sectorsize);
+
+		if (ra)
+			page_cache_sync_readahead(inode->vfs_inode.i_mapping,
+				ra, NULL, entry->start >> PAGE_SHIFT,
+				((entry->start + range_len - 1) >> PAGE_SHIFT) -
+				(entry->start >> PAGE_SHIFT) + 1);
+		/*
+		 * Here we may not defrag any range if holes are punched before
+		 * we locked the pages.
+		 * But that's fine, it only affects the @sectors_defraged
+		 * accounting.
+		 */
+		ret = defrag_one_range(inode, entry->start, range_len,
+					extent_thresh, newer_than, do_compress);
+		if (ret < 0)
+			break;
+		*sectors_defraged += range_len;
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
2.31.1

