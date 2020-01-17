Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08488140BEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgAQOCj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:02:39 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33188 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgAQOCj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:02:39 -0500
Received: by mail-qt1-f193.google.com with SMTP id d5so21830357qto.0
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BdvJtOaCKUTrVnYuAdJG0qYZ0UFyi42wu2IpzwLs664=;
        b=Fvt5yH+IWOAtb65uJ4dLa7TomloyQ16pKzdXR6kUjyVEGLfZx2lv1JP9nU4G7pf9qS
         xIlMT9NaEVfeJNjzcft2WACA1QRNdSQiCXetXJBO24OMyl4IYP/IgnOvRd8RnN4wHm+7
         nnTMRxXR4jnnxdSNBmplSlo7HxBHxxXBkbIx6r9GZwjzUKrvczitxnDi9mIQ8D70czMR
         rIQU3VQ4I0MVlxGC+NzBELikWil1QJtg541WWqSYIQIYyfOWRzULxhe7MXoLsQUupUxH
         vYHTZZifcmpjxpTc2ZKuQKZWrxrU4Zg4cDo5Zz0e9HAiA9/dSdvJnIGbiAOBdJ3BXrmD
         GDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BdvJtOaCKUTrVnYuAdJG0qYZ0UFyi42wu2IpzwLs664=;
        b=e3EO7xD1bDsI1XmE8ABVFNmG33XTJAP2g+1SsrIFAcO06DSTkJQGjjLUeHyIYGGr20
         isEFcnch6dQcCdRgzyJ2t9IeX4ADxMdUhSYPg+WtczJAAHw48qpkgiW5dXDN0SEEoAs4
         usQR8PU9ndB6foXZWmPEWKlRBMTZCy7kVlyw/NMeUXXc13XAw302BV5PEHUwQ2WhJgcd
         V5SximXZtQmBO1ehUHWscylCkDcsD17OcatFWIYAktCidXsLUOeYJScc4Rs4p4ebWqxW
         gxIPDZTz8dRnqs82z0BIoWoFueKCdma0dNnyG1OLRkcL4qn+PuTaxnO9kSOoAZUQ8YEG
         srxQ==
X-Gm-Message-State: APjAAAWwzlYVFo3I/apGlwn87KU9D/sIM75METE2NfSWu+jvIfsrgi3K
        CSUfX06FSEOx53b9ZVMUqkxCzXj+GG4sBg==
X-Google-Smtp-Source: APXvYqyfwK8A2HK84l7UUCzEwoVILI/hO8m2u+aAKXP98u0fLajevNFaVvKIKIfZ1J3K70GzcbHI7Q==
X-Received: by 2002:aed:3be1:: with SMTP id s30mr7760658qte.163.1579269757679;
        Fri, 17 Jan 2020 06:02:37 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r44sm13302137qta.26.2020.01.17.06.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:02:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 6/6] btrfs: delete the ordered isize update code
Date:   Fri, 17 Jan 2020 09:02:24 -0500
Message-Id: <20200117140224.42495-7-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117140224.42495-1-josef@toxicpanda.com>
References: <20200117140224.42495-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a safe way to update the isize, remove all of this code
as it's no longer needed.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ordered-data.c      | 128 -----------------------------------
 fs/btrfs/ordered-data.h      |   7 --
 include/trace/events/btrfs.h |   1 -
 3 files changed, 136 deletions(-)

diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
index 64281247bd18..a68b6d745010 100644
--- a/fs/btrfs/ordered-data.c
+++ b/fs/btrfs/ordered-data.c
@@ -780,134 +780,6 @@ btrfs_lookup_first_ordered_extent(struct inode *inode, u64 file_offset)
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
index 3beb4da4ab41..a46f319d9ae0 100644
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
@@ -182,8 +177,6 @@ struct btrfs_ordered_extent *btrfs_lookup_ordered_range(
 		struct btrfs_inode *inode,
 		u64 file_offset,
 		u64 len);
-int btrfs_ordered_update_i_size(struct inode *inode, u64 offset,
-				struct btrfs_ordered_extent *ordered);
 int btrfs_find_ordered_sum(struct inode *inode, u64 offset, u64 disk_bytenr,
 			   u8 *sum, int len);
 u64 btrfs_wait_ordered_extents(struct btrfs_root *root, u64 nr,
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 17088a112ed0..58b8a8107d7b 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -468,7 +468,6 @@ DEFINE_EVENT(
 		{ (1 << BTRFS_ORDERED_PREALLOC), 	"PREALLOC" 	}, \
 		{ (1 << BTRFS_ORDERED_DIRECT),	 	"DIRECT" 	}, \
 		{ (1 << BTRFS_ORDERED_IOERR), 		"IOERR" 	}, \
-		{ (1 << BTRFS_ORDERED_UPDATED_ISIZE), 	"UPDATED_ISIZE"	}, \
 		{ (1 << BTRFS_ORDERED_TRUNCATED), 	"TRUNCATED"	})
 
 
-- 
2.24.1

