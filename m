Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B04436CF1C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239244AbhD0XFH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:05:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:36888 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239185AbhD0XFF (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:05:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dc8rY00BZDVq3ygWxQIWBeaT9dYq4mSvkokRgb/w9IY=;
        b=vKmf6xVduvOMVs4ID9U30M51kH7k7WVItwNDjcDMw057SaGWfyeKWbt0G8tK9cR+gunbgW
        1NHzTlCPeWM/OijQmLdxmyEs/jOrwrV6hNpuppWhmTX0WS0rJPMJgTzOEjVrrYgU9GN3sF
        sLcSCeFoFO7ee77s2D/MDAWRH2OWG7s=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12095AEF5
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:04:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 11/42] btrfs: introduce btrfs_lookup_first_ordered_range()
Date:   Wed, 28 Apr 2021 07:03:18 +0800
Message-Id: <20210427230349.369603-12-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Although we already have btrfs_lookup_first_ordered_extent() and
btrfs_lookup_ordered_extent(), they all have their own limitations:

- btrfs_lookup_ordered_extent() can't do extra range check

  It's only deisnged to lookup any ordered extent before certain bytenr.

- btrfs_lookup_first_ordered_extent() may not return the first OE in the
  range

  It doesn't ensure the first ordered extent is returned.
  The existing callers are only interesting in exhausting all ordered
  extents in a range, the order is not important.

For incoming btrfs_invalidatepage() refactor, we need a way to properly
iterate all ordered extents in their bytenr order of a range.

So this patch will introduce a new function,
btrfs_lookup_first_ordered_range(), to do ordered extent with bytenr
order awareness and extra range check.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ordered-data.c | 72 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/ordered-data.h |  3 ++
 2 files changed, 75 insertions(+)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 6776f73a8791..82574e3e62ec 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -932,6 +932,78 @@ btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset)
 	return entry;
 }
 
+/*
+ * Lookup the first ordered extent overlaps the range
+ * [@file_offset, @file_offset + @len).
+ *
+ * The difference between this and btrfs_lookup_first_ordered_extent() is
+ * this one won't return any ordered extent not overlapping the range.
+ * And the difference against btrfs_lookup_ordered_extent() is, this function
+ * ensures the first ordered extent get returned.
+ */
+struct btrfs_ordered_extent *
+btrfs_lookup_first_ordered_range(struct btrfs_inode *inode, u64 file_offset,
+				 u64 len)
+{
+	struct btrfs_ordered_inode_tree *tree = &inode->ordered_tree;
+	struct rb_node *n = tree->tree.rb_node;
+	struct rb_node *cur;
+	struct rb_node *prev;
+	struct rb_node *next;
+	struct btrfs_ordered_extent *entry = NULL;
+
+	spin_lock_irq(&tree->lock);
+	/*
+	 * Here we don't want to use tree_search() which will use tree->last
+	 * and screw up the search order.
+	 * And __tree_search() can't return the adjacent OEs either, thus here
+	 * we implement our own search here.
+	 */
+	while (n) {
+		entry = rb_entry(n, struct btrfs_ordered_extent, rb_node);
+
+		if (file_offset < entry->file_offset) {
+			n = n->rb_left;
+		} else if (file_offset >= entry_end(entry)) {
+			n = n->rb_right;
+		} else {
+			/* Direct hit, got an OE starts at @file_offset */
+			goto out;
+		}
+	}
+	if (!entry) {
+		/* Empty tree */
+		goto out;
+	}
+
+	cur = &entry->rb_node;
+	/* We got an entry around @file_offset, check adjacent entries */
+	if (entry->file_offset < file_offset) {
+		prev = cur;
+		next = rb_next(cur);
+	} else {
+		prev = rb_prev(cur);
+		next = cur;
+	}
+	if (prev) {
+		entry = rb_entry(prev, struct btrfs_ordered_extent, rb_node);
+		if (range_overlaps(entry, file_offset, len))
+			goto out;
+	}
+	if (next) {
+		entry = rb_entry(next, struct btrfs_ordered_extent, rb_node);
+		if (range_overlaps(entry, file_offset, len))
+			goto out;
+	}
+	/* No OE in the range */
+	entry = NULL;
+out:
+	if (entry)
+		refcount_inc(&entry->refs);
+	spin_unlock_irq(&tree->lock);
+	return entry;
+}
+
 /*
  * btrfs_flush_ordered_range - Lock the passed range and ensures all pending
  * ordered extents in it are run to completion.
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 72eb4b8cbb88..ad918bf67d66 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -196,6 +196,9 @@ void btrfs_start_ordered_extent(struct btrfs_ordered_extent *entry, int wait);
 int btrfs_wait_ordered_range(struct inode *inode, u64 start, u64 len);
 struct btrfs_ordered_extent *
 btrfs_lookup_first_ordered_extent(struct btrfs_inode *inode, u64 file_offset);
+struct btrfs_ordered_extent *
+btrfs_lookup_first_ordered_range(struct btrfs_inode *inode, u64 file_offset,
+				 u64 len);
 struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		struct btrfs_inode *inode,
 		u64 file_offset,
-- 
2.31.1

