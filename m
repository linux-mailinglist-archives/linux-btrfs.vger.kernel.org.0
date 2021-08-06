Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248EB3E24CF
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243387AbhHFINJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 04:13:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41112 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243413AbhHFINI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 04:13:08 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DB15920264
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628237572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YaOcT/e5oaT5t7uAJWnwJPOkDgVQ5Vgpvsi4VYSYKpg=;
        b=JUtJjBFywSyk7gmMGSfXaGH3RqVnV4Zytq6XGRjgS0ws2sCbaI6vPO/0vkTAlGFcKqt6jV
        AKJzvWF0+b7oN2n6jAeVzHv5p67Z0slxdI1eFggSssPElSfzMv0iZcj6S5znvPJzZh7kFU
        gdgSFzAvRuDXMT9HE34TYiKRSA/T2ro=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1CDA41399D
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id GMG2MwPvDGF6IQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 08:12:51 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 05/11] btrfs: defrag: introduce a new helper to collect target file extents
Date:   Fri,  6 Aug 2021 16:12:36 +0800
Message-Id: <20210806081242.257996-6-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806081242.257996-1-wqu@suse.com>
References: <20210806081242.257996-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper, defrag_collect_targets(), to collect all
possible targets to be defragged.

This function will not consider things like max_sectors_to_defrag, thus
caller should be responsible to ensure we don't exceed the limit.

This function will be the first stage of later defrag rework.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 120 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c0639780f99c..043c44daa5ae 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1427,6 +1427,126 @@ static int cluster_pages_for_defrag(struct inode *inode,
 
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
+ *		   will be ignored
+ * @newer_than:    Only defrag extents newer than this value
+ * @do_compress:   Whether the defrag is doing compression
+ *		   If true, @extent_thresh will be ignored and all regular
+ *		   file extents meeting @newer_than will be targets.
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
+		 * extents, thus no @extent_thresh or mergeable check.
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
+			/* Not mergeable with last entry */
+			if (last->start + last->len != cur)
+				goto next;
+
+			/* Mergeable, fall through to add it to @target_list. */
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
+				/* Mergeable, enlarge the last entry */
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
2.32.0

