Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583E32D34A4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 22:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbgLHUyW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 15:54:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:60726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729324AbgLHUyW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 8 Dec 2020 15:54:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74C61ACEB;
        Tue,  8 Dec 2020 18:42:46 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 1/2] btrfs: Fold generic_write_checks() in btrfs_write_check()
Date:   Tue,  8 Dec 2020 12:42:40 -0600
Message-Id: <8dabce11b6bc9dc4ba534a2d5cf169ca3d0a812d.1607449636.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1607449636.git.rgoldwyn@suse.com>
References: <cover.1607449636.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Code Cleanup.

Fold generic_write_checks() in btrfs_write_check(), because
generic_write_checks() is called before btrfs_write_check() in both
cases. The prototype of btrfs_write_check() has been changed to return
ssize_t and it can return zero as a valid error code. btrfs_write_check
now returns the count of I/O to be performed.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0e41459b8de6..272660a8279f 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1583,17 +1583,28 @@ static void update_time_for_write(struct inode *inode)
 		inode_inc_iversion(inode);
 }
 
-static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
-			     size_t count)
+/* btrfs_write_check - checks if a write can be performed
+ *
+ * Returns:
+ * count - in case the write can be successfully performed
+ * < 0 - error in case write cannot be performed
+ * 0 - if the write is not required
+ */
+static ssize_t btrfs_write_check(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	loff_t pos = iocb->ki_pos;
-	int ret;
+	ssize_t ret;
+	ssize_t count;
 	loff_t oldsize;
 	loff_t start_pos;
 
+	count = generic_write_checks(iocb, from);
+	if (count <= 0)
+		return count;
+
 	if (iocb->ki_flags & IOCB_NOWAIT) {
 		size_t nocow_bytes = count;
 
@@ -1635,7 +1646,7 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
 		}
 	}
 
-	return 0;
+	return count;
 }
 
 static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
@@ -1665,14 +1676,10 @@ static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	ret = generic_write_checks(iocb, i);
+	ret = btrfs_write_check(iocb, i);
 	if (ret <= 0)
 		goto out;
 
-	ret = btrfs_write_check(iocb, i, ret);
-	if (ret < 0)
-		goto out;
-
 	pos = iocb->ki_pos;
 	nrptrs = min(DIV_ROUND_UP(iov_iter_count(i), PAGE_SIZE),
 			PAGE_SIZE / (sizeof(struct page *)));
@@ -1920,14 +1927,8 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (err < 0)
 		return err;
 
-	err = generic_write_checks(iocb, from);
+	err = btrfs_write_check(iocb, from);
 	if (err <= 0) {
-		btrfs_inode_unlock(inode, ilock_flags);
-		return err;
-	}
-
-	err = btrfs_write_check(iocb, from, err);
-	if (err < 0) {
 		btrfs_inode_unlock(inode, ilock_flags);
 		goto out;
 	}
-- 
2.29.2

