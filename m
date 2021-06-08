Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1F39EC81
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jun 2021 05:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhFHDBh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Jun 2021 23:01:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:59464 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhFHDBh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Jun 2021 23:01:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 403C31FD50
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623121184; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/lTHsB17pH5gdG1IDyyJxLUljFDT+/lMLkyvM21NiZg=;
        b=AVVU0IScnuAdiAhpqUISta5oyY3bqzIMTx/Uvumv5dr+jlAke6Sp2V0H9tvSVdc6PoR6+T
        ZbRI7Jg3elhnE3gLA+d+iWX6X5KqSneaWr10zL04TTo4gp0oHgbBocGZKKPQ4VSVq6yOa/
        rZlAD456STnFPegilFkuG3Nekhulna0=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id D91CCA3B88
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Jun 2021 02:59:42 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 07/10] btrfs: defrag: introduce a new helper to defrag one cluster
Date:   Tue,  8 Jun 2021 10:59:24 +0800
Message-Id: <20210608025927.119169-8-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608025927.119169-1-wqu@suse.com>
References: <20210608025927.119169-1-wqu@suse.com>
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
 fs/btrfs/ioctl.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8259ad102469..cccecb5aec33 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1628,6 +1628,62 @@ static int defrag_one_range(struct btrfs_inode *inode,
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
+				     newer_than, do_compress, false,
+				     &target_list);
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

