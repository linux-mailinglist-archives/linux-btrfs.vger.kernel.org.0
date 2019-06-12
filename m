Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 433BD4288A
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2019 16:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfFLOOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Jun 2019 10:14:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbfFLOOQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Jun 2019 10:14:16 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03B820866
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2019 14:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560348855;
        bh=qTyefbpj8+rX6uX/xcAY48C8O9xYMsSE3SNhz7QKmeU=;
        h=From:To:Subject:Date:From;
        b=xk2R/9TUvW7yeQXGUeMdxuGSrRW9XNPd5HjVmiWPfWonuh/wlYChZlRW//+borGZy
         i+MXqDHbjsDMHORU6aEFA+Bq1HFMs+yH0OglKBtwbfS8WYGNOBKoDzChRxwlxkgBbk
         IvOK76zJlTO1o9+IU3wbHYO9Gw9CwGtDqT6nPNWg=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH for 5.2] Btrfs: fix failure to persist compression property xattr deletion on fsync
Date:   Wed, 12 Jun 2019 15:14:11 +0100
Message-Id: <20190612141411.25339-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

After the recent series of cleanups in the properties and xattrs modules
that landed in the 5.2 merge window, we ended up with a regression where
after deleting the compression xattr property through the setflags ioctl,
we don't set the BTRFS_INODE_COPY_EVERYTHING flag in the inode anymore.
As a consequence, if the inode was fsync'ed when it had the compression
property set, after deleting the compression property through the setflags
ioctl and fsync'ing again the inode, the log will still contain the
compression xattr, because the inode did not had that bit set, which
made the fsync not delete all xattrs from the log and copy all xattrs
from the subvolume tree to the log tree.

This regression happens due to the fact that that series of cleanups
made btrfs_set_prop() call the old function do_setxattr() (which is now
named btrfs_setxattr()), and not the old version of btrfs_setxattr(),
which is now called btrfs_setxattr_trans().

Fix this by setting the BTRFS_INODE_COPY_EVERYTHING bit in the current
btrfs_setxattr() function and remove it from everywhere else, including
its setup at btrfs_ioctl_setflags(). This is cleaner, avoids similar
regressions in the future, and centralizes the setup of the bit. After
all, the need to setup this bit should only be in the xattrs module,
since it is an implementation of xattrs.

Fixes: 04e6863b19c722 ("btrfs: split btrfs_setxattr calls regarding transaction")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ioctl.c | 2 --
 fs/btrfs/xattr.c | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6dafa857bbb9..2a1be0d1a698 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -312,8 +312,6 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 			btrfs_abort_transaction(trans, ret);
 			goto out_end_trans;
 		}
-		set_bit(BTRFS_INODE_COPY_EVERYTHING,
-			&BTRFS_I(inode)->runtime_flags);
 	} else {
 		ret = btrfs_set_prop(trans, inode, "btrfs.compression", NULL,
 				     0, 0);
diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
index 78b6ba2029e8..95d9aebff2c4 100644
--- a/fs/btrfs/xattr.c
+++ b/fs/btrfs/xattr.c
@@ -213,6 +213,9 @@ int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
 	}
 out:
 	btrfs_free_path(path);
+	if (!ret)
+		set_bit(BTRFS_INODE_COPY_EVERYTHING,
+			&BTRFS_I(inode)->runtime_flags);
 	return ret;
 }
 
@@ -236,7 +239,6 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
 
 	inode_inc_iversion(inode);
 	inode->i_ctime = current_time(inode);
-	set_bit(BTRFS_INODE_COPY_EVERYTHING, &BTRFS_I(inode)->runtime_flags);
 	ret = btrfs_update_inode(trans, root, inode);
 	BUG_ON(ret);
 out:
@@ -388,8 +390,6 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
 	if (!ret) {
 		inode_inc_iversion(inode);
 		inode->i_ctime = current_time(inode);
-		set_bit(BTRFS_INODE_COPY_EVERYTHING,
-			&BTRFS_I(inode)->runtime_flags);
 		ret = btrfs_update_inode(trans, root, inode);
 		BUG_ON(ret);
 	}
-- 
2.11.0

