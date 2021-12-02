Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53CB3466174
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Dec 2021 11:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356989AbhLBKeM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Dec 2021 05:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356980AbhLBKeK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Dec 2021 05:34:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D26CC06174A
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 02:30:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F07B4CE21E3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A188EC53FD0
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Dec 2021 10:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638441044;
        bh=jgw/cETeeOb/H13VPaef1031Zu3sMrNlDvhHn3BCOoE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SYvNjUw2s9PL/3n0q3sR2r5ACldlGi7vUiR8x2fz9RKBpocq19gkdizpnMz7g/xal
         EO/GKRsiS7Pm9xNEZN5EW9pOuCSk86MnmZWhzaKjVNScp7yDOWV3lS6u2qehXIs/a1
         hSO6GrBWR9uo3RbvmwINIZ2uEhgm61k8ydOfRGk1u5yE9biFehXtuUeQvsJkzkwWUT
         CBXLmsjMKxupOPjquDzul80fmhCAc6oq4g2wcO7S9Rm4+apLp92jYHzYxhfmF2OG3W
         MQSZf+bLeaBzsn3axh3dC6ibtHV5o8+RUqPRSQiLoouFkrkq7xSHFTXRTCAw//zjeA
         8IkUeqkY32s1g==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: allow generic_bin_search() to take low boundary as an argument
Date:   Thu,  2 Dec 2021 10:30:35 +0000
Message-Id: <a173e456fbf2af89f56a4ed0c5aec7fbb8a66de5.1638440535.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1638440535.git.fdmanana@suse.com>
References: <cover.1638440535.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Right now generic_bin_search() always uses a low boundary slot of 0, but
in the next patch we'll want to often skip slot 0 when searching for a
key. So make generic_bin_search() have the low boundary slot specified
as an argument, and move the check for the extent buffer level from
btrfs_bin_search() to generic_bin_search() to avoid adding another
wrapper around generic_bin_search().

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index d2297e449072..9329c8a3c855 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -726,21 +726,23 @@ int btrfs_realloc_node(struct btrfs_trans_handle *trans,
 }
 
 /*
- * search for key in the extent_buffer.  The items start at offset p,
- * and they are item_size apart.
+ * Search for a key in the given extent_buffer.
  *
- * the slot in the array is returned via slot, and it points to
- * the place where you would insert key if it is not found in
- * the array.
+ * The lower boundary for the search is specified by the slot number @low. Use a
+ * value of 0 to search over the whole extent buffer.
  *
- * Slot may point to total number of items if the key is bigger than
- * all of the keys
+ * The slot in the extent buffer is returned via @slot. If the key exists in the
+ * extent buffer, then @slot will point to the slot where the key is, otherwise
+ * it points to the slot where you would insert the key.
+ *
+ * Slot may point to the total number of items (i.e. one position beyond the last
+ * key) if the key is bigger than the last key in the extent buffer.
  */
-static noinline int generic_bin_search(struct extent_buffer *eb,
-				       unsigned long p, int item_size,
+static noinline int generic_bin_search(struct extent_buffer *eb, int low,
 				       const struct btrfs_key *key, int *slot)
 {
-	int low = 0;
+	unsigned long p;
+	int item_size;
 	int high = btrfs_header_nritems(eb);
 	int ret;
 	const int key_size = sizeof(struct btrfs_disk_key);
@@ -753,6 +755,14 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
 		return -EINVAL;
 	}
 
+	if (btrfs_header_level(eb) == 0) {
+		p = offsetof(struct btrfs_leaf, items);
+		item_size = sizeof(struct btrfs_item);
+	} else {
+		p = offsetof(struct btrfs_node, ptrs);
+		item_size = sizeof(struct btrfs_key_ptr);
+	}
+
 	while (low < high) {
 		unsigned long oip;
 		unsigned long offset;
@@ -791,20 +801,13 @@ static noinline int generic_bin_search(struct extent_buffer *eb,
 }
 
 /*
- * simple bin_search frontend that does the right thing for
- * leaves vs nodes
+ * Simple binary search on an extent buffer. Works for both leaves and nodes, and
+ * always searches over the whole range of keys (slot 0 to slot 'nritems - 1').
  */
 int btrfs_bin_search(struct extent_buffer *eb, const struct btrfs_key *key,
 		     int *slot)
 {
-	if (btrfs_header_level(eb) == 0)
-		return generic_bin_search(eb,
-					  offsetof(struct btrfs_leaf, items),
-					  sizeof(struct btrfs_item), key, slot);
-	else
-		return generic_bin_search(eb,
-					  offsetof(struct btrfs_node, ptrs),
-					  sizeof(struct btrfs_key_ptr), key, slot);
+	return generic_bin_search(eb, 0, key, slot);
 }
 
 static void root_add_used(struct btrfs_root *root, u32 size)
-- 
2.33.0

