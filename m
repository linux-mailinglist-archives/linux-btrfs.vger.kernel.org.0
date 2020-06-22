Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5374203C5F
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgFVQUg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 12:20:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:46174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgFVQUg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 12:20:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6AB98C241;
        Mon, 22 Jun 2020 16:20:34 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 4/8] btrfs: Introduce btrfs_inode_lock()/unlock()
Date:   Mon, 22 Jun 2020 11:20:13 -0500
Message-Id: <20200622162017.21773-5-rgoldwyn@suse.de>
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

btrfs_inode_lock/unlock() acquires the inode->i_rwsem depending on the
flags passed. ilock_flags determines the type of lock to be taken:

BTRFS_ILOCK_SHARED - for shared locks, for possible parallel DIO
BTRFS_ILOCK_TRY - for the RWF_NOWAIT sequence

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h |  8 ++++++++
 fs/btrfs/file.c  | 51 +++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 161533040978..346fea668ca0 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2953,6 +2953,14 @@ void btrfs_update_ioctl_balance_args(struct btrfs_fs_info *fs_info,
 			       struct btrfs_ioctl_balance_args *bargs);
 
 /* file.c */
+
+/* ilock flags definition */
+#define BTRFS_ILOCK_SHARED	0x1
+#define BTRFS_ILOCK_TRY 	0x2
+
+int btrfs_inode_lock(struct inode *inode, int ilock_flags);
+void btrfs_inode_unlock(struct inode *inode, int ilock_flags);
+
 int __init btrfs_auto_defrag_init(void);
 void __cold btrfs_auto_defrag_exit(void);
 int btrfs_add_inode_defrag(struct btrfs_trans_handle *trans,
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index ba7c3b2cf1c5..1a9a0a9e4b3d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -70,6 +70,37 @@ static int __compare_inode_defrag(struct inode_defrag *defrag1,
 		return 0;
 }
 
+int btrfs_inode_lock(struct inode *inode, int ilock_flags)
+{
+	if (ilock_flags & BTRFS_ILOCK_SHARED) {
+		if (ilock_flags & BTRFS_ILOCK_TRY) {
+			if (!inode_trylock_shared(inode))
+				return -EAGAIN;
+			else
+				return 0;
+		}
+		inode_lock_shared(inode);
+	} else {
+		if (ilock_flags & BTRFS_ILOCK_TRY) {
+			if (!inode_trylock(inode))
+				return -EAGAIN;
+			else
+				return 0;
+		}
+		inode_lock(inode);
+	}
+	return 0;
+}
+
+void btrfs_inode_unlock(struct inode *inode, int ilock_flags)
+{
+	if (ilock_flags & BTRFS_ILOCK_SHARED)
+		inode_unlock_shared(inode);
+	else
+		inode_unlock(inode);
+
+}
+
 /* pop a record for an inode into the defrag tree.  The lock
  * must be held already
  *
@@ -1978,6 +2009,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
 	ssize_t err;
+	int ilock_flags = 0;
 
 	/*
 	 * If BTRFS flips readonly due to some impossible error
@@ -1992,12 +2024,12 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	    (iocb->ki_flags & IOCB_NOWAIT))
 		return -EOPNOTSUPP;
 
-	if (iocb->ki_flags & IOCB_NOWAIT) {
-		if (!inode_trylock(inode))
-			return -EAGAIN;
-	} else {
-		inode_lock(inode);
-	}
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		ilock_flags |= BTRFS_ILOCK_TRY;
+
+	err = btrfs_inode_lock(inode, ilock_flags);
+	if (err < 0)
+		goto out;
 
 	err = btrfs_write_check(iocb, from);
 	if (err <= 0) {
@@ -2014,7 +2046,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		num_written = btrfs_buffered_write(iocb, from);
 	}
 
-	inode_unlock(inode);
+	btrfs_inode_unlock(inode, ilock_flags);
 
 	/*
 	 * We also have to set last_sub_trans to the current log transid,
@@ -3547,9 +3579,10 @@ static ssize_t btrfs_direct_read(struct kiocb *iocb, struct iov_iter *to)
 	if (is_sync_kiocb(iocb))
 		flags |= IOMAP_DIOF_WAIT_FOR_COMPLETION;
 
-	inode_lock_shared(inode);
+	btrfs_inode_lock(inode, BTRFS_ILOCK_SHARED);
         ret = iomap_dio_rw(iocb, to, &btrfs_dio_iomap_ops, &btrfs_dops, flags);
-	inode_unlock_shared(inode);
+	btrfs_inode_unlock(inode, BTRFS_ILOCK_SHARED);
+
 	return ret;
 }
 
-- 
2.25.0

