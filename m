Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6E41EA721
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgFAPiV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:34130 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgFAPhw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E0BF5B208;
        Mon,  1 Jun 2020 15:37:52 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 20/46] btrfs: Make fallback_to_cow take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:18 +0300
Message-Id: <20200601153744.31891-21-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It really wants btrfs_inode and is prepration to converting run_delalloc_nocow
to taking btrfs_inode.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2f6460241c61..27051e8a7013 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1352,13 +1352,13 @@ static noinline int csum_exist_in_range(struct btrfs_fs_info *fs_info,
 	return 1;
 }

-static int fallback_to_cow(struct inode *inode, struct page *locked_page,
+static int fallback_to_cow(struct btrfs_inode *inode, struct page *locked_page,
 			   const u64 start, const u64 end,
 			   int *page_started, unsigned long *nr_written)
 {
-	const bool is_space_ino = btrfs_is_free_space_inode(BTRFS_I(inode));
+	const bool is_space_ino = btrfs_is_free_space_inode(inode);
 	const u64 range_bytes = end + 1 - start;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct extent_io_tree *io_tree = &inode->io_tree;
 	u64 range_start = start;
 	u64 count;

@@ -1396,7 +1396,7 @@ static int fallback_to_cow(struct inode *inode, struct page *locked_page,
 				 EXTENT_NORESERVE, 0);
 	if (count > 0 || is_space_ino) {
 		const u64 bytes = is_space_ino ? range_bytes : count;
-		struct btrfs_fs_info *fs_info = BTRFS_I(inode)->root->fs_info;
+		struct btrfs_fs_info *fs_info = inode->root->fs_info;
 		struct btrfs_space_info *sinfo = fs_info->data_sinfo;

 		spin_lock(&sinfo->lock);
@@ -1408,8 +1408,8 @@ static int fallback_to_cow(struct inode *inode, struct page *locked_page,
 					 0, 0, NULL);
 	}

-	return cow_file_range(BTRFS_I(inode), locked_page, start, end,
-			      page_started, nr_written, 1);
+	return cow_file_range(inode, locked_page, start, end, page_started,
+			      nr_written, 1);
 }

 /*
@@ -1660,8 +1660,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,
 		 * NOCOW, following one which needs to be COW'ed
 		 */
 		if (cow_start != (u64)-1) {
-			ret = fallback_to_cow(inode, locked_page, cow_start,
-					      found_key.offset - 1,
+			ret = fallback_to_cow(BTRFS_I(inode), locked_page,
+					      cow_start, found_key.offset - 1,
 					      page_started, nr_written);
 			if (ret) {
 				if (nocow)
@@ -1751,8 +1751,8 @@ static noinline int run_delalloc_nocow(struct inode *inode,

 	if (cow_start != (u64)-1) {
 		cur_offset = end;
-		ret = fallback_to_cow(inode, locked_page, cow_start, end,
-				      page_started, nr_written);
+		ret = fallback_to_cow(BTRFS_I(inode), locked_page, cow_start,
+				      end, page_started, nr_written);
 		if (ret)
 			goto error;
 	}
--
2.17.1

