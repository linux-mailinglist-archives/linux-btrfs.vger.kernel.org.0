Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06CFC3CD394
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236582AbhGSKbH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236330AbhGSKbG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:31:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D807A6112D;
        Mon, 19 Jul 2021 11:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693106;
        bh=0TmMjcEfKfibdqPXhaB5QEBiiAD9Ql0JoNhIe5rmfYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgViBWhqosDBjg6HibSlSb8Z33IK+PtN7hfjMJRQ5KeArQyrAV97BhZkJoBIOUu4P
         wpVeNSZMTLfdnFODT3RJywKvR6kX6FIo8wlhsLvNm+z8tXy1E0nywRxt+9zSlXzUYw
         8hFqLtgfIemocQlrq+qsadrKEVqwhV5wbvozPN582jsfAGNw0YOToJvYbVUHZXUUVB
         BVoZGRYEFzSLD2yxKbVFjafV//cGG7KymRDTetGGjGqHoiwi7YCZMX2sh/joqPtOt4
         tjIdqGrcWNdDUGzwDMKjcm8EWsknOlJThYHlNnxyQakLBaapan1h+gG4yvaIMMUR5i
         iv97C6LFiOkfQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 19/21] btrfs/acl: handle idmapped mounts
Date:   Mon, 19 Jul 2021 13:10:50 +0200
Message-Id: <20210719111052.1626299-20-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2735; h=from:subject; bh=V86Ab3ogartsC8z1JJG1eyNEGTGDR8DjCud4mBGgT6k=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd2xs/juzw35G79MvLe0LiR2Br9E6kqFMI7fTR9erny1 5CDfnI5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJrNBl+Ke/+D7DvxzFKdtvtFcaLJ SOtvpxV1PfI9O3Jb+ZX3BRginDf7fdzk3Rrne8TT1/+ivN09umO2Pi9l9n0r9VzZOUZNNS5AAA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Make the btrfs acl code idmapped mount aware. The posix default and posix
access acls are the only acls other than some specific xattrs that take dac
permissions into account. On an idmapped mount they need to be translated
according to the mount's userns. The main change is done to __btrfs_set_acl()
which is responsible for translating posix acls to their final on-disk
representation. The btrfs_init_acl() helper does not need to take the idmapped
mount into account since it is called in the context of file creation
operations (mknod, create, mkdir, symlink, tmpfile) and is used for
btrfs_init_inode_security() to copy posix default and posix access permissions
from the parent directory. These acls need to be inherited unmodified from the
parent directory. This is identical to what we do for ext4 and xfs.

Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/acl.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/acl.c b/fs/btrfs/acl.c
index d95eb5c8cb37..c9f9789e828f 100644
--- a/fs/btrfs/acl.c
+++ b/fs/btrfs/acl.c
@@ -53,7 +53,8 @@ struct posix_acl *btrfs_get_acl(struct inode *inode, int type)
 }
 
 static int __btrfs_set_acl(struct btrfs_trans_handle *trans,
-			 struct inode *inode, struct posix_acl *acl, int type)
+			   struct user_namespace *mnt_userns,
+			   struct inode *inode, struct posix_acl *acl, int type)
 {
 	int ret, size = 0;
 	const char *name;
@@ -114,12 +115,12 @@ int btrfs_set_acl(struct user_namespace *mnt_userns, struct inode *inode,
 	umode_t old_mode = inode->i_mode;
 
 	if (type == ACL_TYPE_ACCESS && acl) {
-		ret = posix_acl_update_mode(&init_user_ns, inode,
+		ret = posix_acl_update_mode(mnt_userns, inode,
 					    &inode->i_mode, &acl);
 		if (ret)
 			return ret;
 	}
-	ret = __btrfs_set_acl(NULL, inode, acl, type);
+	ret = __btrfs_set_acl(NULL, mnt_userns, inode, acl, type);
 	if (ret)
 		inode->i_mode = old_mode;
 	return ret;
@@ -140,14 +141,14 @@ int btrfs_init_acl(struct btrfs_trans_handle *trans,
 		return ret;
 
 	if (default_acl) {
-		ret = __btrfs_set_acl(trans, inode, default_acl,
+		ret = __btrfs_set_acl(trans, &init_user_ns, inode, default_acl,
 				      ACL_TYPE_DEFAULT);
 		posix_acl_release(default_acl);
 	}
 
 	if (acl) {
 		if (!ret)
-			ret = __btrfs_set_acl(trans, inode, acl,
+			ret = __btrfs_set_acl(trans, &init_user_ns, inode, acl,
 					      ACL_TYPE_ACCESS);
 		posix_acl_release(acl);
 	}
-- 
2.30.2

