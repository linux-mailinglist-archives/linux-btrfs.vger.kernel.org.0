Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2756A3D73BA
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Jul 2021 12:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236457AbhG0KvI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Jul 2021 06:51:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236401AbhG0KvH (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Jul 2021 06:51:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18476600CD;
        Tue, 27 Jul 2021 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627383067;
        bh=wlX0GfTdm4WkKZ/FF0BSt95lxb/TpGDEUvutV9t0C5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sOGwBCoPJ6dtqdG+wczC9qEdaKNqYvBE/XmG2ZG8OfcKh3mz6aAExTDAoD7QhyGu8
         bTi88tPheExsox/yJcCL0YG560N3YK41Yje0j5QogwwtTpyAqzowNjmP5NnNQd57wv
         soFp8II1po3brovoVQzDEs188YtfXjG/ppe01kcQG7zS7vRTZa1885xfNs/hEi9fT0
         GeZhuxC81HQWqBvfnyGgmjKb21oH5zdfgv0evPbTzGHtJgwh41PjyrFz5Y8D5vNOLX
         YNflP1BFKbdSrzo34B9wocXouj5nbq0DRlRDa19iUPtLXB6Nvi5J/CkqVpyxF1JtL+
         b/8RdFdaE//PA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v4 16/21] btrfs/ioctl: allow idmapped BTRFS_IOC_SET_RECEIVED_SUBVOL{_32} ioctl
Date:   Tue, 27 Jul 2021 12:48:55 +0200
Message-Id: <20210727104900.829215-17-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727104900.829215-1-brauner@kernel.org>
References: <20210727104900.829215-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222; h=from:subject; bh=cm8VFf4lNW0r6dDGyPuNxLwjORqInF5A5yqLnQxEBpg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST8fzJt15w/Amu2lqlcPnA08+lt1ewn6z2fTvrkkT7P5WJ+ 47YNER2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATKdzHyPDz75TdD7g/dAs3F/LJJX 57HZL8w/CPzsf6DRsb0s0z/hoy/I+ZpnS6fz3fdWuOA481zRQYrlW/YKlbra+jUHDonERrAhcA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The BTRFS_IOC_SET_RECEIVED_SUBVOL{_32} are used to set information about a
received subvolume. Make it possible to set information about a received
subvolume on idmapped mounts. This is a fairly straightforward operation since
all the permission checking helpers are already capable of handling idmapped
mounts. So we just need to pass down the mount's userns.

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

/* v4 */
unchanged
---
 fs/btrfs/ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 5a8df000cc41..c330b1b252a1 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4464,6 +4464,7 @@ static long btrfs_ioctl_quota_rescan_wait(struct btrfs_fs_info *fs_info,
 }
 
 static long _btrfs_ioctl_set_received_subvol(struct file *file,
+					    struct user_namespace *mnt_userns,
 					    struct btrfs_ioctl_received_subvol_args *sa)
 {
 	struct inode *inode = file_inode(file);
@@ -4475,7 +4476,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	int ret = 0;
 	int received_uuid_changed;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
@@ -4580,7 +4581,7 @@ static long btrfs_ioctl_set_received_subvol_32(struct file *file,
 	args64->rtime.nsec = args32->rtime.nsec;
 	args64->flags = args32->flags;
 
-	ret = _btrfs_ioctl_set_received_subvol(file, args64);
+	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_user_ns(file), args64);
 	if (ret)
 		goto out;
 
@@ -4614,7 +4615,7 @@ static long btrfs_ioctl_set_received_subvol(struct file *file,
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
-	ret = _btrfs_ioctl_set_received_subvol(file, sa);
+	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_user_ns(file), sa);
 
 	if (ret)
 		goto out;
-- 
2.30.2

