Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43193D5784
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhGZJsr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:48:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232702AbhGZJsq (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5261360F5C;
        Mon, 26 Jul 2021 10:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295355;
        bh=ITp6zKF2ku79v6UmcBJuo2as1vyVpaYwaE3ZzHNVVDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k3VRPffF8whPjl/lUkMsKXFgajDh3N9OBRyiVKukYHn4rbJl1LsGE+fIWxoWNw0+o
         GrkmwqsJ+fzp4ZyFqpl8ayWd4+vFSkej+NQlx4+d1w0uh9IHZqGfrunrlBQ50gT+56
         pcPmky9+/DR9bZ3/3vEVfJCATrhzdCY1CXCJ+nUkN25VsHPFpbtgdw99kfYa+fjDU4
         KplMEL/qHB68NXDWbeZU7rYhNGLf8DqiQxwI6/B/Lq2jEIbCsH9oHMG4SxQiD0uREy
         mSiYbsw5aaIZAMPwwfRk1Wgpp0zr89LJl2Yc5g1BOQtgkTb44IMV18vym/y1zF0sAC
         ZDUfK+gp44owA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 10/21] btrfs/inode: allow idmapped setattr iop
Date:   Mon, 26 Jul 2021 12:28:05 +0200
Message-Id: <20210726102816.612434-11-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1469; h=from:subject; bh=HVDJ+To28YiuoIsFFLQoRX1te1c6AgCxGRFWMrI/XEM=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zNWnZL/Lsy28EJ549qoqZa2c20te6KFZ0YY7n9auypp y7/tHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMRE2VkWPr8m0CZ/YR/djvu9hpEZi 5r3sFedZZ77x2dviO27nt72RkZWlzkbfgsArdeXv/HwDeNSWTWlfrv2n9tmt+tP/Nz6o4nPAA=
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable btrfs_setattr() to handle idmapped mounts. This is just a matter of
passing down the mount's userns.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged

/* v3 */
unchanged
---
 fs/btrfs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 0a45e3152016..2d9717861a6b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5342,7 +5342,7 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	err = setattr_prepare(&init_user_ns, dentry, attr);
+	err = setattr_prepare(mnt_userns, dentry, attr);
 	if (err)
 		return err;
 
@@ -5353,12 +5353,12 @@ static int btrfs_setattr(struct user_namespace *mnt_userns, struct dentry *dentr
 	}
 
 	if (attr->ia_valid) {
-		setattr_copy(&init_user_ns, inode, attr);
+		setattr_copy(mnt_userns, inode, attr);
 		inode_inc_iversion(inode);
 		err = btrfs_dirty_inode(inode);
 
 		if (!err && attr->ia_valid & ATTR_MODE)
-			err = posix_acl_chmod(&init_user_ns, inode,
+			err = posix_acl_chmod(mnt_userns, inode,
 					      inode->i_mode);
 	}
 
-- 
2.30.2

