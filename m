Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9066A203C61
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jun 2020 18:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbgFVQUm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Jun 2020 12:20:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:46346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729521AbgFVQUl (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Jun 2020 12:20:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F23CC220;
        Mon, 22 Jun 2020 16:20:40 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 6/8] btrfs: Use shared inode lock for direct writes within EOF
Date:   Mon, 22 Jun 2020 11:20:15 -0500
Message-Id: <20200622162017.21773-7-rgoldwyn@suse.de>
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

This is to parallelize direct writes within EOF or with direct I/O
reads. This covers the race with truncate() accidentally increasing the
filesize.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/file.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index aa6be931620b..c446a4aeb867 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1957,12 +1957,18 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	loff_t endbyte;
 	int err;
 	size_t count = 0;
-	bool relock = false;
 	int flags = IOMAP_DIOF_PGINVALID_FAIL;
 	int ilock_flags = 0;
 
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		ilock_flags |= BTRFS_ILOCK_TRY;
+	/*
+	 * If the write DIO within EOF,  use a shared lock
+	 */
+	if (pos + count <= i_size_read(inode))
+		ilock_flags |= BTRFS_ILOCK_SHARED;
+	else if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EAGAIN;
 
 	err = btrfs_inode_lock(inode, ilock_flags);
 	if (err < 0)
@@ -1975,20 +1981,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 	if (check_direct_IO(fs_info, from, pos))
 		goto buffered;
 
-	count = iov_iter_count(from);
-	/*
-	 * If the write DIO is beyond the EOF, we need update the isize, but it
-	 * is protected by i_mutex. So we can not unlock the i_mutex at this
-	 * case.
-	 */
-	if (pos + count <= inode->i_size) {
-		inode_unlock(inode);
-		relock = true;
-	} else if (iocb->ki_flags & IOCB_NOWAIT) {
-		err = -EAGAIN;
-		goto out;
-	}
-
 	if (is_sync_kiocb(iocb))
 		flags |= IOMAP_DIOF_WAIT_FOR_COMPLETION;
 
@@ -1997,9 +1989,6 @@ static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *from)
 			       flags);
 	up_read(&BTRFS_I(inode)->dio_sem);
 
-	if (relock)
-		inode_lock(inode);
-
 	if (written < 0 || !iov_iter_count(from)) {
 		err = written;
 		goto error;
-- 
2.25.0

