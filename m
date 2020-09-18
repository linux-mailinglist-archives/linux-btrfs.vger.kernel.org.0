Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7891A26FE9C
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 15:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgIRNep (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 09:34:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:40968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726770AbgIRNeo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600436082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=eDw+U32G1q1vPq2zVGpW1JiIg3H8wWeDPX5NRFpx0JI=;
        b=qCSCKf829iWKbc/KAQsye/Yge+yWrAqEF1tEzup83S04ReDSSaoPJDeXhCaAQB/Wgws6Yq
        4zLGtumyRcljoT/8qTUZvwnmcoMIcXfr8UsFOOXru4KC8cLbvbV28UcXyQgriZmcGz1Bas
        p6gO+0ixkHEJnRM8tOJQPmPFj7I+xZU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B2AEEB23E;
        Fri, 18 Sep 2020 13:35:16 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 5/7] btrfs: Stop calling submit_bio_hook for data inodes
Date:   Fri, 18 Sep 2020 16:34:37 +0300
Message-Id: <20200918133439.23187-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918133439.23187-1-nborisov@suse.com>
References: <20200918133439.23187-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Instead export and rename the function to btrfs_submit_data_bio and
call it directly in submit_one_bio. This avoids paying the cost for
speculative attacks mitigations and improves code readability.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/ctree.h     |  2 ++
 fs/btrfs/extent_io.c | 10 +++++++---
 fs/btrfs/inode.c     |  7 +++----
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 0c58d96b9fb3..5fc18b7ab771 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2962,6 +2962,8 @@ void btrfs_inode_safe_disk_i_size_write(struct btrfs_inode *inode,
 u64 btrfs_file_extent_end(const struct btrfs_path *path);
 
 /* inode.c */
+blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
+				   int mirror_num, unsigned long bio_flags);
 int btrfs_check_csum(struct btrfs_io_bio *io_bio, u64 phy_offset,
 		     struct page *page, u64 start, u64 end, int mirror);
 struct extent_map *btrfs_get_extent_fiemap(struct btrfs_inode *inode,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 26b002e2f3b3..8cabcb7642a9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -168,8 +168,12 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 
 	bio->bi_private = NULL;
 
-	ret = tree->ops->submit_bio_hook(tree->private_data, bio, mirror_num,
-					 bio_flags);
+	if (is_data_inode(tree->private_data))
+		ret = btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
+					    bio_flags);
+	else
+		ret = tree->ops->submit_bio_hook(tree->private_data, bio,
+						 mirror_num, bio_flags);
 
 	return blk_status_to_errno(ret);
 }
@@ -2880,7 +2884,7 @@ static void end_bio_extent_readpage(struct bio *bio)
 			if (!btrfs_submit_read_repair(inode, bio, offset, page,
 						start - page_offset(page),
 						start, end, mirror,
-						tree->ops->submit_bio_hook)) {
+						btrfs_submit_data_bio)) {
 				uptodate = !bio->bi_status;
 				offset += len;
 				continue;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 41565c5a05ef..955a66207fec 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2169,9 +2169,8 @@ static blk_status_t btrfs_submit_bio_start(void *private_data, struct bio *bio,
  *
  *    c-3) otherwise:			async submit
  */
-static blk_status_t btrfs_submit_bio_hook(struct inode *inode, struct bio *bio,
-					  int mirror_num,
-					  unsigned long bio_flags)
+blk_status_t btrfs_submit_data_bio(struct inode *inode, struct bio *bio,
+				   int mirror_num, unsigned long bio_flags)
 
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
@@ -10246,7 +10245,7 @@ static const struct file_operations btrfs_dir_file_operations = {
 };
 
 static const struct extent_io_ops btrfs_extent_io_ops = {
-	.submit_bio_hook = btrfs_submit_bio_hook
+	.submit_bio_hook = NULL
 };
 
 /*
-- 
2.17.1

