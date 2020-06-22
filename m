Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B7E203C5C
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgFVQU1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 12:20:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:46044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729486AbgFVQU0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 12:20:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4865EC241;
        Mon, 22 Jun 2020 16:20:25 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/8] btrfs: Move pos increment and pagecache extension to btrfs_buffered_write()
Date:   Mon, 22 Jun 2020 11:20:10 -0500
Message-Id: <20200622162017.21773-2-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200622162017.21773-1-rgoldwyn@suse.de>
References: <20200622162017.21773-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

While we do this, correct the call to pagecache_isize_extended():
 - pagecache_isisze_extended needs to be called to the starting of the
   write as opposed to i_size
 - We don't need to check range befor the call, this is done in the
   function

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 7f75adf70bcd..01377a7d1d13 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1585,6 +1585,7 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	int ret = 0;
 	bool only_release_metadata = false;
 	bool force_page_uptodate = false;
+	loff_t old_isize = i_size_read(inode);
 
 	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
 			PAGE_SIZE / (sizeof(struct page *)));
@@ -1806,6 +1807,10 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	}
 
 	extent_changeset_free(data_reserved);
+	if (num_written > 0) {
+		pagecache_isize_extended(inode, old_isize, iocb->ki_pos);
+		iocb->ki_pos += num_written;
+	}
 	return num_written ? num_written : ret;
 }
 
@@ -1926,7 +1931,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	loff_t pos;
 	size_t count;
 	loff_t oldsize;
-	int clean_page = 0;
 
 	if (!(iocb->ki_flags & IOCB_DIRECT) &&
 	    (iocb->ki_flags & IOCB_NOWAIT))
@@ -1998,8 +2002,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 			inode_unlock(inode);
 			goto out;
 		}
-		if (start_pos > round_up(oldsize, fs_info->sectorsize))
-			clean_page = 1;
 	}
 
 	if (sync)
@@ -2009,11 +2011,6 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		num_written = btrfs_direct_write(iocb, from);
 	} else {
 		num_written = btrfs_buffered_write(iocb, from);
-		if (num_written > 0)
-			iocb->ki_pos = pos + num_written;
-		if (clean_page)
-			pagecache_isize_extended(inode, oldsize,
-						i_size_read(inode));
 	}
 
 	inode_unlock(inode);
-- 
2.25.0

