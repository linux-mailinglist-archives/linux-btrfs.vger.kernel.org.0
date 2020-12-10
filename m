Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6192D599C
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Dec 2020 12:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbgLJLqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Dec 2020 06:46:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:44760 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgLJLoB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Dec 2020 06:44:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1607600594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=bWVMTXYxeip1vOov0gHf7ci7k79Zm/fGwfIiJOu2PoQ=;
        b=ZdVclMJ44dmBY9SaSm1fe9g/iveWbqM/jjg0k5/hB30W/GkjD768c3ZON62lCsclBY9vmJ
        KxAnWHs/MlfQ31uolrZ96SyM1+UPtiQz6V2QDSiGhgtMdGm9vINa3ZX+4CmHfCJtke6Phm
        kIHXF/iXe8T88Zk1KDi89jhqNiL0Lqc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 70E72AD87;
        Thu, 10 Dec 2020 11:43:13 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Cleanup btrfs_file_write_iter
Date:   Thu, 10 Dec 2020 10:38:32 +0200
Message-Id: <20201210083832.1283574-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

First replace all inode instances with a pointer to btrfs_inode. This
removes multiple invocations of the BTRFS_I macro, subsequently remove
2 local variables as they are called only once and simply refer to
them directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/file.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e41459b8de6..e65223e3510d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1997,9 +1997,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 				    struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
-	struct inode *inode = file_inode(file);
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_inode *inode = BTRFS_I(file_inode(file));
 	ssize_t num_written = 0;
 	const bool sync = iocb->ki_flags & IOCB_DSYNC;
 
@@ -2008,7 +2006,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	 * have opened a file as writable, we have to stop this write operation
 	 * to ensure consistency.
 	 */
-	if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
+	if (test_bit(BTRFS_FS_STATE_ERROR, &inode->root->fs_info->fs_state))
 		return -EROFS;
 
 	if (!(iocb->ki_flags & IOCB_DIRECT) &&
@@ -2016,7 +2014,7 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 		return -EOPNOTSUPP;
 
 	if (sync)
-		atomic_inc(&BTRFS_I(inode)->sync_writers);
+		atomic_inc(&inode->sync_writers);
 
 	if (iocb->ki_flags & IOCB_DIRECT)
 		num_written = btrfs_direct_write(iocb, from);
@@ -2028,14 +2026,14 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	 * otherwise subsequent syncs to a file that's been synced in this
 	 * transaction will appear to have already occurred.
 	 */
-	spin_lock(&BTRFS_I(inode)->lock);
-	BTRFS_I(inode)->last_sub_trans = root->log_transid;
-	spin_unlock(&BTRFS_I(inode)->lock);
+	spin_lock(&inode->lock);
+	inode->last_sub_trans = inode->root->log_transid;
+	spin_unlock(&inode->lock);
 	if (num_written > 0)
 		num_written = generic_write_sync(iocb, num_written);
 
 	if (sync)
-		atomic_dec(&BTRFS_I(inode)->sync_writers);
+		atomic_dec(&inode->sync_writers);
 
 	current->backing_dev_info = NULL;
 	return num_written;
-- 
2.25.1

