Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEA26FE9E
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Sep 2020 15:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgIRNer (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Sep 2020 09:34:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:40980 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbgIRNeo (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Sep 2020 09:34:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1600436082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=pcETNj7xVcin9mXKhI0bL51K8ZiyB4lJNPb29avRk48=;
        b=OfBmgREzOkU66o09yzUzUBt805gGTVOoo/G62D57YXYALPgU6pjo3vXEDo2MeS8lWo6z0l
        U1aW1mvv9kbNxF6NKnn7gNQQ8jDYnz3mk8aYIjYOYq/3uXhF8xmZz/7OtIdsk1PYXjGUDA
        OGUyPr0tfxMudVT3150kn9WFEB5DFko=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0A99B18C;
        Fri, 18 Sep 2020 13:35:16 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 6/7] btrfs: Call submit_bio_hook directly for metadata pages
Date:   Fri, 18 Sep 2020 16:34:38 +0300
Message-Id: <20200918133439.23187-7-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200918133439.23187-1-nborisov@suse.com>
References: <20200918133439.23187-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No need to go through a function pointer indirection simply call
submit_bio_hook directly by exporting and renaming the helper to
btrfs_submit_metadata_bio. This makes the code more readable and should
result in somewhat faster code due to no longer paying the price for
specualtive attack mitigations that come with indirect function calls.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c   | 7 +++----
 fs/btrfs/disk-io.h   | 2 ++
 fs/btrfs/extent_io.c | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 73937954f464..54f2b95cc305 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -815,9 +815,8 @@ static int check_async_write(struct btrfs_fs_info *fs_info,
 	return 1;
 }
 
-static blk_status_t btree_submit_bio_hook(struct inode *inode, struct bio *bio,
-					  int mirror_num,
-					  unsigned long bio_flags)
+blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
+				       int mirror_num, unsigned long bio_flags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	int async = check_async_write(fs_info, BTRFS_I(inode));
@@ -4637,5 +4636,5 @@ static int btrfs_cleanup_transaction(struct btrfs_fs_info *fs_info)
 }
 
 static const struct extent_io_ops btree_extent_io_ops = {
-	.submit_bio_hook = btree_submit_bio_hook
+	.submit_bio_hook = NULL
 };
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index bc2e49246199..fee69ced58b4 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -79,6 +79,8 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 int btrfs_validate_metadata_buffer(struct btrfs_io_bio *io_bio, u64 phy_offset,
 				   struct page *page, u64 start, u64 end,
 				   int mirror);
+blk_status_t btrfs_submit_metadata_bio(struct inode *inode, struct bio *bio,
+				       int mirror_num, unsigned long bio_flags);
 #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
 struct btrfs_root *btrfs_alloc_dummy_root(struct btrfs_fs_info *fs_info);
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8cabcb7642a9..4a00cfd4082f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -172,8 +172,8 @@ int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 		ret = btrfs_submit_data_bio(tree->private_data, bio, mirror_num,
 					    bio_flags);
 	else
-		ret = tree->ops->submit_bio_hook(tree->private_data, bio,
-						 mirror_num, bio_flags);
+		ret = btrfs_submit_metadata_bio(tree->private_data, bio,
+						mirror_num, bio_flags);
 
 	return blk_status_to_errno(ret);
 }
-- 
2.17.1

