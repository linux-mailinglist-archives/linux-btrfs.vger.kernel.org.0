Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E21268899
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 11:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgINJh0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 05:37:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:41246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbgINJhT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 05:37:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F87EAF74;
        Mon, 14 Sep 2020 09:37:32 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 7/9] btrfs: Sink mirror_num argument in extent_read_full_page
Date:   Mon, 14 Sep 2020 12:37:09 +0300
Message-Id: <20200914093711.13523-8-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093711.13523-1-nborisov@suse.com>
References: <20200914093711.13523-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's always set to 0 from the sole caller - btrfs_readpage.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c | 5 ++---
 fs/btrfs/extent_io.h | 2 +-
 fs/btrfs/inode.c     | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 402b88ddcbca..f43827bee7e6 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3365,7 +3365,7 @@ static inline void contiguous_readpages(struct page *pages[], int nr_pages,
 	}
 }

-int extent_read_full_page(struct page *page, struct bio **bio, int mirror_num,
+int extent_read_full_page(struct page *page, struct bio **bio,
 			  unsigned long *bio_flags, unsigned int read_flags)
 {
 	struct btrfs_inode *inode = BTRFS_I(page->mapping->host);
@@ -3375,8 +3375,7 @@ int extent_read_full_page(struct page *page, struct bio **bio, int mirror_num,

 	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);

-	ret = __do_readpage(page, NULL, bio, mirror_num, bio_flags, read_flags,
-			    NULL);
+	ret = __do_readpage(page, NULL, bio, 0, bio_flags, read_flags, NULL);
 	return ret;
 }

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 8fec00c50846..3562c9203de3 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -195,7 +195,7 @@ int try_release_extent_buffer(struct page *page);

 int __must_check submit_one_bio(struct bio *bio, int mirror_num,
 				unsigned long bio_flags);
-int extent_read_full_page(struct page *page, struct bio **bio, int mirror_num,
+int extent_read_full_page(struct page *page, struct bio **bio,
 			  unsigned long *bio_flags, unsigned int read_flags);
 int extent_write_full_page(struct page *page, struct writeback_control *wbc);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end,
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index f01066607901..31a154c7fb00 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -8044,7 +8044,7 @@ int btrfs_readpage(struct file *file, struct page *page)
 	unsigned long bio_flags = 0;
 	int ret;

-	ret = extent_read_full_page(page, &bio, 0, &bio_flags, 0);
+	ret = extent_read_full_page(page, &bio, &bio_flags, 0);
 	if (bio)
 		ret = submit_one_bio(bio, 0, bio_flags);
 	return ret;
--
2.17.1

