Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17CC3CD391
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Jul 2021 13:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbhGSKbA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 19 Jul 2021 06:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236654AbhGSKa7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 19 Jul 2021 06:30:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AD7E610FB;
        Mon, 19 Jul 2021 11:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626693099;
        bh=CIhc9aZbuMCh85zSIZOctJcasDvhpNAFVIEeIzjvFM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c2QjkonLbxBHNBePVoAulYaxswlqHW7rpg2x6TzAYb9yJKpkXM1m2jYvg4QemPuxb
         MQjU+7rZu/G9PfE4v2+ptyNAcNgLA8BKqC7mwIv8TNDdOzrHHk9LehYUwMfbyaV4Pl
         d899j4l0U1uAGo/ukh++7d9euMSNZF/70xmE7lQiih5q9YoNUFzYleUFw4dmCPmI93
         PR6arEl237r2+e9p3FOe4h0FRLNN6Vrt4MxbnAmTfkaeJzWAewiFWnwqTGdyfQVuQ0
         mwjJf9YuvNGIYDs8CTJZ3lUE9rz45mrhBPcyY18XxsEN6R78u/GtwYDtnCegJvDgKk
         LS0T8KnbHMo+A==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 16/21] btrfs/ioctl: allow idmapped BTRFS_IOC_SET_RECEIVED_SUBVOL{_32} ioctl
Date:   Mon, 19 Jul 2021 13:10:47 +0200
Message-Id: <20210719111052.1626299-17-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210719111052.1626299-1-brauner@kernel.org>
References: <20210719111052.1626299-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2127; h=from:subject; bh=UOz8ZUGGvks1eZvm8DVLFZP4fMG0s8EHx74ivt0aUpo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSR8jd1+aTtPj/u71739pz7ca8w32sngtWyGxr7ZiZGZoQ3L W6X2dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenANzkM4wME26qlpW/f/li/Xdze74tyR Wpc3bbde+tiU3jiI+ec+/CRkaGzYcOJa8Pk3+y7+/z++u7vp9xeSbl3ZSbUu67TdO1WGYDEwA=
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
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
unchanged
---
 fs/btrfs/ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 72045ae30d1c..d631a1cb621d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4466,6 +4466,7 @@ static long btrfs_ioctl_quota_rescan_wait(struct btrfs_fs_info *fs_info,
 }
 
 static long _btrfs_ioctl_set_received_subvol(struct file *file,
+					    struct user_namespace *mnt_userns,
 					    struct btrfs_ioctl_received_subvol_args *sa)
 {
 	struct inode *inode = file_inode(file);
@@ -4477,7 +4478,7 @@ static long _btrfs_ioctl_set_received_subvol(struct file *file,
 	int ret = 0;
 	int received_uuid_changed;
 
-	if (!inode_owner_or_capable(&init_user_ns, inode))
+	if (!inode_owner_or_capable(mnt_userns, inode))
 		return -EPERM;
 
 	ret = mnt_want_write_file(file);
@@ -4582,7 +4583,7 @@ static long btrfs_ioctl_set_received_subvol_32(struct file *file,
 	args64->rtime.nsec = args32->rtime.nsec;
 	args64->flags = args32->flags;
 
-	ret = _btrfs_ioctl_set_received_subvol(file, args64);
+	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_user_ns(file), args64);
 	if (ret)
 		goto out;
 
@@ -4616,7 +4617,7 @@ static long btrfs_ioctl_set_received_subvol(struct file *file,
 	if (IS_ERR(sa))
 		return PTR_ERR(sa);
 
-	ret = _btrfs_ioctl_set_received_subvol(file, sa);
+	ret = _btrfs_ioctl_set_received_subvol(file, file_mnt_user_ns(file), sa);
 
 	if (ret)
 		goto out;
-- 
2.30.2

