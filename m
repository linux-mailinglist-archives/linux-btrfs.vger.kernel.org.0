Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6571D26889C
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 11:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgINJhe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 05:37:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:41234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgINJhS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 05:37:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 27DA1AF3D;
        Mon, 14 Sep 2020 09:37:32 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 5/9] btrfs: Remove mirror_num argument from extent_read_full_page
Date:   Mon, 14 Sep 2020 12:37:07 +0300
Message-Id: <20200914093711.13523-6-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093711.13523-1-nborisov@suse.com>
References: <20200914093711.13523-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's called only from btrfs_readpage which always passes 0 so just sink
the argument into extent_read_full_page.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 6 +++---
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4a0675ec90fa..355db40a1cb5 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3381,15 +3381,15 @@ static int __extent_read_full_page(struct page *page, struct bio **bio,
 	return ret;
 }

-int extent_read_full_page(struct page *page, int mirror_num)
+int extent_read_full_page(struct page *page)
 {
 	struct bio *bio = NULL;
 	unsigned long bio_flags = 0;
 	int ret;

-	ret = __extent_read_full_page(page, &bio, mirror_num, &bio_flags, 0);
+	ret = __extent_read_full_page(page, &bio, 0, &bio_flags, 0);
 	if (bio)
-		ret = submit_one_bio(bio, mirror_num, bio_flags);
+		ret = submit_one_bio(bio, 0, bio_flags);
 	return ret;
 }

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 272d5281bd4d..0ccb2dabc291 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -193,7 +193,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_inode *inode,
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);

-int extent_read_full_page(struct page *page, int mirror_num);
+int extent_read_full_page(struct page *page);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
 			      int mode);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index df8a4008b139..e78099d1db34 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8040,7 +8040,7 @@ static int btrfs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,

 int btrfs_readpage(struct file *file, struct page *page)
 {
-	return extent_read_full_page(page, 0);
+	return extent_read_full_page(page);
 }

 static int btrfs_writepage(struct page *page, struct writeback_control *wbc)
--
2.17.1

