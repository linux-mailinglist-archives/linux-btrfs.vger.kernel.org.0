Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F54F37277
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 13:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbfFFLHD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 07:07:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:34940 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725784AbfFFLHD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 6 Jun 2019 07:07:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0E72AE54
        for <linux-btrfs@vger.kernel.org>; Thu,  6 Jun 2019 11:07:01 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs-progs: image: Introduce helper to determine if a tree block is in the range of system chunks
Date:   Thu,  6 Jun 2019 19:06:10 +0800
Message-Id: <20190606110611.27176-9-wqu@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110611.27176-1-wqu@suse.com>
References: <20190606110611.27176-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Introduce a new helper function, is_in_sys_chunks(), to determine if an
item is in the range of system chunks.

Since btrfs-image will merge adjacent same type extents into one item,
this function is designed to return true for any bytes in system chunk
range.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/image/main.c b/image/main.c
index 0460a5f5..dc677409 100644
--- a/image/main.c
+++ b/image/main.c
@@ -1780,6 +1780,54 @@ static int wait_for_worker(struct mdrestore_struct *mdres)
 	return ret;
 }
 
+/*
+ * Check if a range [start ,start + len] has ANY bytes covered by
+ * system chunks ranges.
+ */
+static bool is_in_sys_chunks(struct mdrestore_struct *mdres, u64 start,
+			     u64 len)
+{
+	struct rb_node *node = mdres->sys_chunks.root.rb_node;
+	struct cache_extent *entry;
+	struct cache_extent *next;
+	struct cache_extent *prev;
+
+	if (start > mdres->sys_chunk_end)
+		return false;
+
+	while (node) {
+		entry = rb_entry(node, struct cache_extent, rb_node);
+		if (start > entry->start) {
+			if (!node->rb_right)
+				break;
+			node = node->rb_right;
+		} else if (start < entry->start) {
+			if (!node->rb_left)
+				break;
+			node = node->rb_left;
+		} else {
+			/* already in a system chunk */
+			return true;
+		}
+	}
+	if (!node)
+		return false;
+	entry = rb_entry(node, struct cache_extent, rb_node);
+	/* Now we have entry which is the nearst chunk around @start */
+	if (start > entry->start) {
+		prev = entry;
+		next = next_cache_extent(entry);
+	} else {
+		prev = prev_cache_extent(entry);
+		next = entry;
+	}
+	if (prev && prev->start + prev->size > start)
+		return true;
+	if (next && start + len > next->start)
+		return true;
+	return false;
+}
+
 static int read_chunk_block(struct mdrestore_struct *mdres, u8 *buffer,
 			    u64 bytenr, u64 item_bytenr, u32 bufsize,
 			    u64 cluster_bytenr)
-- 
2.21.0

