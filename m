Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB3B397EAF
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Jun 2021 04:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhFBCRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 22:17:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:38994 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhFBCRW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 22:17:22 -0400
Received: from relay2.suse.de (unknown [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B639321952
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1622600139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WzeZPXGTC8s0D6z0xnYA+Tu32EVecJiFlialQGf8XZ8=;
        b=Q2sSoNp/jYjuzEvHjJyoZT6olZtMOOjNtb+e1OBUfnABIjKvPWbAC+nb3S2UMOyQuokh0K
        vPUGYNsWpn3nrtizGNRTr/A/I9omvNs2VGjQ+G6+hXRy/cFJ6R60jFIB/T6qZ7+0nMp8f/
        /D5bmsndb+lgvwFH1PrMPmiwJgNConw=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id BEC5CA3B81
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Jun 2021 02:15:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 04/10] btrfs: defrag: introduce a new helper to collect target file extents
Date:   Wed,  2 Jun 2021 10:15:22 +0800
Message-Id: <20210602021528.68617-5-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602021528.68617-1-wqu@suse.com>
References: <20210602021528.68617-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, defrag_collect_targets(), to collect all
possible targets to be defraged.

This function will not consider things like max_sectors_to_defrag, thus
caller should be responsible to ensure we don't exceed the limit.

This function will be the first stage of later defrag rework.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 24b0dc1325d3..6af37a9e0738 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1372,6 +1372,126 @@ static int cluster_pages_for_defrag(struct inode *inode,
 
 }
 
+struct defrag_target_range {
+	struct list_head list;
+	u64 start;
+	u64 len;
+};
+
+/*
+ * Helper to collect all valid target extents.
+ *
+ * @start:	   The file offset to lookup
+ * @len:	   The length to lookup
+ * @extent_thresh: File extent size threshold, any extent size >= this value
+ * 		   will be ignored
+ * @newer_than:    Only defrag extents newer than this value
+ * @do_compress:   Whether the defrag is doing compression
+ * 		   If true, @extent_thresh will be ignored and all regular
+ * 		   file extents meeting @newer_than will be targets.
+ * @target_list:   The list of targets file extents
+ */
+static int defrag_collect_targets(struct btrfs_inode *inode,
+				  u64 start, u64 len, u32 extent_thresh,
+				  u64 newer_than, bool do_compress,
+				  struct list_head *target_list)
+{
+	u64 cur = start;
+	int ret = 0;
+
+	while (cur < start + len) {
+		struct extent_map *em;
+		struct defrag_target_range *new;
+		bool next_mergeable = true;
+		u64 range_len;
+
+		em = defrag_lookup_extent(&inode->vfs_inode, cur);
+		if (!em)
+			break;
+
+		/* Skip hole/inline/preallocated extents */
+		if (em->block_start >= EXTENT_MAP_LAST_BYTE ||
+		    test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
+			goto next;
+
+		/* Skip older extent */
+		if (em->generation < newer_than)
+			goto next;
+
+		/*
+		 * For do_compress case, we want to compress all valid file
+		 * extents, thus no @extent_thresh or mergable check.
+		 */
+		if (do_compress)
+			goto add;
+
+		/* Skip too large extent */
+		if (em->len >= extent_thresh)
+			goto next;
+
+		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em);
+		if (!next_mergeable) {
+			struct defrag_target_range *last;
+
+			/* Empty target list, no way to merge with last entry */
+			if (list_empty(target_list))
+				goto next;
+			last = list_entry(target_list->prev,
+					struct defrag_target_range, list);
+			/* Not mergable with last entry */
+			if (last->start + last->len != cur)
+				goto next;
+
+			/* Mergable, fall throught to add it to @target_list. */
+		}
+
+add:
+		range_len = min(extent_map_end(em), start + len) - cur;
+		/*
+		 * This one is a good target, check if it can be merged into
+		 * last range of the target list
+		 */
+		if (!list_empty(target_list)) {
+			struct defrag_target_range *last;
+
+			last = list_entry(target_list->prev,
+					struct defrag_target_range, list);
+			ASSERT(last->start + last->len <= cur);
+			if (last->start + last->len == cur) {
+				/* Mergable, enlarge the last entry */
+				last->len += range_len;
+				goto next;
+			}
+			/* Fall through to allocate a new entry */
+		}
+
+		/* Allocate new defrag_target_range */
+		new = kmalloc(sizeof(*new), GFP_NOFS);
+		if (!new) {
+			free_extent_map(em);
+			ret = -ENOMEM;
+			break;
+		}
+		new->start = cur;
+		new->len = range_len;
+		list_add_tail(&new->list, target_list);
+
+next:
+		cur = extent_map_end(em);
+		free_extent_map(em);
+	}
+	if (ret < 0) {
+		struct defrag_target_range *entry;
+		struct defrag_target_range *tmp;
+
+		list_for_each_entry_safe(entry, tmp, target_list, list) {
+			list_del_init(&entry->list);
+			kfree(entry);
+		}
+	}
+	return ret;
+}
+
 /*
  * Btrfs entrace for defrag.
  *
-- 
2.31.1

