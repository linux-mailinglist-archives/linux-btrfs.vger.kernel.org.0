Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9CB2776FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 18:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgIXQkK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 12:40:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36694 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbgIXQkJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 12:40:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D987FB295;
        Thu, 24 Sep 2020 16:40:07 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        johannes.thumshirn@wdc.com, dsterba@suse.com,
        darrick.wong@oracle.com, josef@toxicpanda.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 11/14] btrfs: Use inode_lock_shared() for direct writes within EOF
Date:   Thu, 24 Sep 2020 11:39:18 -0500
Message-Id: <20200924163922.2547-12-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200924163922.2547-1-rgoldwyn@suse.de>
References: <20200924163922.2547-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Direct writes within EOF are safe to be performed with inode shared lock
to improve parallelization with other direct writes or reads because EOF
is not changed and there is no race with truncate().

Direct reads are already performed under shared inode lock.

This patch is precursor to removing btrfs_inode->dio_sem.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 72fa1c692a53..83012d1e6f29 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1978,7 +1978,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	loff_t pos;
 	ssize_t written = 0;
-	bool relock = false;
 	ssize_t written_buffered;
 	loff_t endbyte;
 	int err;
@@ -1987,6 +1986,13 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
 
+	/*
+	 * If the write DIO within EOF,  use a shared lock
+	 */
+	if (iocb->ki_pos + iov_iter_count(from) <= i_size_read(inode))
+		ilock_flags |= BTRFS_ILOCK_SHARED;
+
+relock:
 	err = btrfs_inode_lock(inode, ilock_flags);
 	if (err < 0)
 		return err;
@@ -1998,21 +2004,23 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	}
 
 	pos = iocb->ki_pos;
+	/*
+	 * Re-check since file size may have changed
+	 * just before taking the lock or pos may have changed
+	 * because of O_APPEND in generic_write_check()
+	 */
+	if ((ilock_flags & BTRFS_ILOCK_SHARED) &&
+	    pos + iov_iter_count(from) > i_size_read(inode)) {
+		btrfs_inode_unlock(inode, ilock_flags);
+		ilock_flags &= ~BTRFS_ILOCK_SHARED;
+		goto relock;
+	}
 
 	if (check_direct_IO(fs_info, from, pos)) {
 		btrfs_inode_unlock(inode, ilock_flags);
 		goto buffered;
 	}
 
-	/*
-	 * If the write DIO is beyond the EOF, we need update
-	 * the isize, but it is protected by i_mutex. So we can
-	 * not unlock the i_mutex at this case.
-	 */
-	if (pos + iov_iter_count(from) <= inode->i_size) {
-		btrfs_inode_unlock(inode, 0);
-		relock = true;
-	}
 	down_read(&BTRFS_I(inode)->dio_sem);
 
 	/*
@@ -2030,8 +2038,7 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		written = 0;
 
 	up_read(&BTRFS_I(inode)->dio_sem);
-	if (relock)
-		btrfs_inode_lock(inode, 0);
+	btrfs_inode_unlock(inode, ilock_flags);
 
 	if (written < 0 || !iov_iter_count(from)) {
 		err = written;
-- 
2.26.2

