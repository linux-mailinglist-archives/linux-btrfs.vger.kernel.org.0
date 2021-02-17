Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 751B231DA05
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Feb 2021 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhBQNNm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 08:13:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:56740 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231686AbhBQNNj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 08:13:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613567573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R3UVrqH47izlpphBs2JT2WVmNApTdt3hth55B/RYWB4=;
        b=G7SzKImvnrbYwSYlw13Xfnp1NoTW7jChGCl3WHE1xRrzHyNxlZDiEaxPF4syipqYWcOFfB
        98JfKAGFlKLVia1aWvomM9uito5mMGDtPgPYhIDLAr6LgGMRBFf0ATUZsPeJnguWXt7cjI
        R4ldmgvqdb4SW5DapNiommbXSepN0PA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15CE4B8F3;
        Wed, 17 Feb 2021 13:12:53 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 3/4] btrfs: Replace offset_in_entry with in_range
Date:   Wed, 17 Feb 2021 15:12:49 +0200
Message-Id: <20210217131250.265859-4-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210217131250.265859-1-nborisov@suse.com>
References: <20210217131250.265859-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No point in duplicating the functionality just use the generic helper
we have.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ordered-data.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 985a21558437..07b0b4218791 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -107,17 +107,6 @@ static struct rb_node *__tree_search(struct rb_root *root, u64 file_offset,
 	return NULL;
 }
 
-/*
- * helper to check if a given offset is inside a given entry
- */
-static int offset_in_entry(struct btrfs_ordered_extent *entry, u64 file_offset)
-{
-	if (file_offset < entry->file_offset ||
-	    entry->file_offset + entry->num_bytes <= file_offset)
-		return 0;
-	return 1;
-}
-
 static int range_overlaps(struct btrfs_ordered_extent *entry, u64 file_offset,
 			  u64 len)
 {
@@ -142,7 +131,7 @@ static inline struct rb_node *tree_search(struct btrfs_ordered_inode_tree *tree,
 	if (tree->last) {
 		entry = rb_entry(tree->last, struct btrfs_ordered_extent,
 				 rb_node);
-		if (offset_in_entry(entry, file_offset))
+		if (in_range(file_offset, entry->file_offset, entry->num_bytes))
 			return tree->last;
 	}
 	ret = __tree_search(root, file_offset, &prev);
@@ -349,7 +338,7 @@ bool btrfs_dec_test_first_ordered_pending(struct btrfs_inode *inode,
 		goto out;
 
 	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
-	if (!offset_in_entry(entry, *file_offset))
+	if (!in_range(*file_offset, entry->file_offset, entry->num_bytes))
 		goto out;
 
 	dec_start = max(*file_offset, entry->file_offset);
@@ -428,7 +417,7 @@ bool btrfs_dec_test_ordered_pending(struct btrfs_inode *inode,
 
 	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
 have_entry:
-	if (!offset_in_entry(entry, file_offset))
+	if (!in_range(file_offset, entry->file_offset, entry->num_bytes))
 		goto out;
 
 	if (io_size > entry->bytes_left)
@@ -779,7 +768,7 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_extent(struct btrfs_inode *ino
 		goto out;
 
 	entry = rb_entry(node, struct btrfs_ordered_extent, rb_node);
-	if (!offset_in_entry(entry, file_offset))
+	if (!in_range(file_offset, entry->file_offset, entry->num_bytes))
 		entry = NULL;
 	if (entry)
 		refcount_inc(&entry->refs);
-- 
2.25.1

