Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FE12D4B2
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Dec 2019 22:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfL3Vbc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Dec 2019 16:31:32 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39770 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3Vbb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Dec 2019 16:31:31 -0500
Received: by mail-qk1-f195.google.com with SMTP id c16so27175076qko.6
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Dec 2019 13:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wX8kxsXzTAH8cXKUNYxwg9ut9y6Ze9uaz7hZwHtNmO8=;
        b=PGJh3dTCUzs851uDLxVmUeNA3zBPqfqvL+NAD6QgaeaFZ1nmEQrD+FumlhBPxl5a7k
         aQHg5fvFZvRfxxTmQaAF7JaGyzy0tswTbXY+BADsEwnqFC8SjHehpaTpMS6tEx+wBLle
         FBv8DIQaBzVhQYU+tDzlLg7YcH2YsA9XnacafNqzSUfs7M1Il7VLVIwuO/rXEwWe3hzv
         KNB/RLFdyvOjDnXX/RhKwRMBeyx1TB3VcmkgL4svmNElifOAt/NAhUrMvrTrfHBQyj+5
         /2CLeg/rErStItnYUyxZRZ6NY2a7ruvhBMsTiyEKPpptmRNNamh0Ks02EL2J9KEGTl9I
         Lysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wX8kxsXzTAH8cXKUNYxwg9ut9y6Ze9uaz7hZwHtNmO8=;
        b=sVrCoZfog8ENifmn3upj8uLq6nrl6aOxhKH2my0kIguVF2n9qsp6YwbPyq+H7LUEtD
         EW/YTjc3JG/OusnUofNamF12gWgzw2fPAmtuzjwF+kmBVgJSjX/iDxI/cL+LZVYHNMbh
         H2HJIYMOTEQDvlSjtvQPLS2si4PMGNpGmGdUo8BLxw2IcXM8Bal+wp+dNOjU4bUazo68
         KmsoqdzANuZhGa9r3BPjwjERUud4zOPGprJJ+fnyYGeS5St+8VBZHp4B/l98pKcf4R+3
         pfx6tfq9VUAmD8JBcSEngBCg+VZud9CkWJNLYFutrt+2qSAS7CR+cqCDp7hTu5ytNmRc
         8Mcw==
X-Gm-Message-State: APjAAAVPlMZoJYKVRtK2szflpinEcdnzxZ5iGSJ87v3vJ/VaIZRpTDU0
        gjDHB7DziFhemvFLgqWJDgI3Mb3iH5T3qA==
X-Google-Smtp-Source: APXvYqzyOfpVPVpo0Idi9prwfA1HKrRrdiIld13fkvAkCHqb799XMp0p1HuqfSDMO8flnXgry1EA0w==
X-Received: by 2002:a37:b402:: with SMTP id d2mr53865324qkf.195.1577741490013;
        Mon, 30 Dec 2019 13:31:30 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z4sm12690927qkz.62.2019.12.30.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 13:31:29 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 5/5] btrfs: delete the ordered isize update code
Date:   Mon, 30 Dec 2019 16:31:18 -0500
Message-Id: <20191230213118.7532-6-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191230213118.7532-1-josef@toxicpanda.com>
References: <20191230213118.7532-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a safe way to update the isize, remove all of this code
as it's no longer needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ordered-data.c      | 128 -----------------------------------
 fs/btrfs/ordered-data.h      |   7 --
 include/trace/events/btrfs.h |   1 -
 3 files changed, 136 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 3a3c648bb9d3..b8de2aea36b3 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -791,134 +791,6 @@ btrfs_lookup_first_ordered_extent(struct inode *inode, u64 file_offset)
 	return entry;
 }
 
-/*
- * After an extent is done, call this to conditionally update the on disk
- * i_size.  i_size is updated to cover any fully written part of the file.
- */
-int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
-				struct btrfs_ordered_extent *ordered)
-{
-	struct btrfs_ordered_inode_tree *tree = &BTRFS_I(inode)->ordered_tree;
-	u64 disk_i_size;
-	u64 new_i_size;
-	u64 i_size = i_size_read(inode);
-	struct rb_node *node;
-	struct rb_node *prev = NULL;
-	struct btrfs_ordered_extent *test;
-	int ret = 1;
-	u64 orig_offset = offset;
-
-	spin_lock_irq(&tree->lock);
-	if (ordered) {
-		offset = entry_end(ordered);
-		if (test_bit(BTRFS_ORDERED_TRUNCATED, &ordered->flags))
-			offset = min(offset,
-				     ordered->file_offset +
-				     ordered->truncated_len);
-	} else {
-		offset = ALIGN(offset, btrfs_inode_sectorsize(inode));
-	}
-	disk_i_size = BTRFS_I(inode)->disk_i_size;
-
-	/*
-	 * truncate file.
-	 * If ordered is not NULL, then this is called from endio and
-	 * disk_i_size will be updated by either truncate itself or any
-	 * in-flight IOs which are inside the disk_i_size.
-	 *
-	 * Because btrfs_setsize() may set i_size with disk_i_size if truncate
-	 * fails somehow, we need to make sure we have a precise disk_i_size by
-	 * updating it as usual.
-	 *
-	 */
-	if (!ordered && disk_i_size > i_size) {
-		BTRFS_I(inode)->disk_i_size = orig_offset;
-		ret = 0;
-		goto out;
-	}
-
-	/*
-	 * if the disk i_size is already at the inode->i_size, or
-	 * this ordered extent is inside the disk i_size, we're done
-	 */
-	if (disk_i_size == i_size)
-		goto out;
-
-	/*
-	 * We still need to update disk_i_size if outstanding_isize is greater
-	 * than disk_i_size.
-	 */
-	if (offset <= disk_i_size &&
-	    (!ordered || ordered->outstanding_isize <= disk_i_size))
-		goto out;
-
-	/*
-	 * walk backward from this ordered extent to disk_i_size.
-	 * if we find an ordered extent then we can't update disk i_size
-	 * yet
-	 */
-	if (ordered) {
-		node = rb_prev(&ordered->rb_node);
-	} else {
-		prev = tree_search(tree, offset);
-		/*
-		 * we insert file extents without involving ordered struct,
-		 * so there should be no ordered struct cover this offset
-		 */
-		if (prev) {
-			test = rb_entry(prev, struct btrfs_ordered_extent,
-					rb_node);
-			BUG_ON(offset_in_entry(test, offset));
-		}
-		node = prev;
-	}
-	for (; node; node = rb_prev(node)) {
-		test = rb_entry(node, struct btrfs_ordered_extent, rb_node);
-
-		/* We treat this entry as if it doesn't exist */
-		if (test_bit(BTRFS_ORDERED_UPDATED_ISIZE, &test->flags))
-			continue;
-
-		if (entry_end(test) <= disk_i_size)
-			break;
-		if (test->file_offset >= i_size)
-			break;
-
-		/*
-		 * We don't update disk_i_size now, so record this undealt
-		 * i_size. Or we will not know the real i_size.
-		 */
-		if (test->outstanding_isize < offset)
-			test->outstanding_isize = offset;
-		if (ordered &&
-		    ordered->outstanding_isize > test->outstanding_isize)
-			test->outstanding_isize = ordered->outstanding_isize;
-		goto out;
-	}
-	new_i_size = min_t(u64, offset, i_size);
-
-	/*
-	 * Some ordered extents may completed before the current one, and
-	 * we hold the real i_size in ->outstanding_isize.
-	 */
-	if (ordered && ordered->outstanding_isize > new_i_size)
-		new_i_size = min_t(u64, ordered->outstanding_isize, i_size);
-	BTRFS_I(inode)->disk_i_size = new_i_size;
-	ret = 0;
-out:
-	/*
-	 * We need to do this because we can't remove ordered extents until
-	 * after the i_disk_size has been updated and then the inode has been
-	 * updated to reflect the change, so we need to tell anybody who finds
-	 * this ordered extent that we've already done all the real work, we
-	 * just haven't completed all the other work.
-	 */
-	if (ordered)
-		set_bit(BTRFS_ORDERED_UPDATED_ISIZE, &ordered->flags);
-	spin_unlock_irq(&tree->lock);
-	return ret;
-}
-
 /*
  * search the ordered extents for one corresponding to 'offset' and
  * try to find a checksum.  This is used because we allow pages to
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index 5204171ea962..7f7f9ad091a6 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -52,11 +52,6 @@ enum {
 	BTRFS_ORDERED_DIRECT,
 	/* We had an io error when writing this out */
 	BTRFS_ORDERED_IOERR,
-	/*
-	 * indicates whether this ordered extent has done its due diligence in
-	 * updating the isize
-	 */
-	BTRFS_ORDERED_UPDATED_ISIZE,
 	/* Set when we have to truncate an extent */
 	BTRFS_ORDERED_TRUNCATED,
 	/* Regular IO for COW */
@@ -180,8 +175,6 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		struct btrfs_inode *inode,
 		u64 file_offset,
 		u64 len);
-int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
-				struct btrfs_ordered_extent *ordered);
 int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 			   u8 *sum, int len);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 620bf1b38fba..02ac28f0e99e 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -468,7 +468,6 @@ DEFINE_EVENT(
 		{ (1 << BTRFS_ORDERED_PREALLOC), 	"PREALLOC" 	}, \
 		{ (1 << BTRFS_ORDERED_DIRECT),	 	"DIRECT" 	}, \
 		{ (1 << BTRFS_ORDERED_IOERR), 		"IOERR" 	}, \
-		{ (1 << BTRFS_ORDERED_UPDATED_ISIZE), 	"UPDATED_ISIZE"	}, \
 		{ (1 << BTRFS_ORDERED_TRUNCATED), 	"TRUNCATED"	})
 
 
-- 
2.23.0

