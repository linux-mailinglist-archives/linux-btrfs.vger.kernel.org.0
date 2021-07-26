Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CA63D578A
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbhGZJtB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 05:49:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:35832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233060AbhGZJs7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 05:48:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FA4D60F6D;
        Mon, 26 Jul 2021 10:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627295368;
        bh=IFjkzMiUQ5ioN2dhiZdk7KTgePBKp6UnzuMZ5UkRUj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rWV89RM48f64dYe7d+MWpJ2KXyKox0Mml5TAB3WjexB+t3J7w2WYhXw15d2R+44dH
         sE/3FBue6eODz6fSPJMbV8Oz4a8bjgu5TtY2C/xEG3lcWx4BKGXNY5ivYokwyaSNDF
         Nn/VQb3mkcS4uGer7qHu2bBMILKhBz8HY5Lzb2/PIFTiu+wCTLU/8A0PX1MbT+WEls
         Zoqoz+Iga/o0BaY0z8L0/BQ4Q+fNRO7TqBoOjnNY/MdJAXJqOxUjMwr0Zf1sKWPNfU
         GmaML0Gby/z8NiB4U6+1Rc3IKY5z0+sXlNtruse2+P/UjI1CoEhwd7sE3qow1i4Wca
         mD1tY9AiqF+YA==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-btrfs@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 16/21] btrfs/ioctl: allow idmapped BTRFS_IOC_SET_RECEIVED_SUBVOL{_32} ioctl
Date:   Mon, 26 Jul 2021 12:28:11 +0200
Message-Id: <20210726102816.612434-17-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210726102816.612434-1-brauner@kernel.org>
References: <20210726102816.612434-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; h=from:subject; bh=Mz0JOeEf7UECbFH5BcSEUTjC7ZP48Ll3zUev6VaOoGY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMST86zMVs4tYcO1EoRi7VIlqbOOezk/ii9iZ6hY++1P/5eGj f5mRHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABO5JsDIsDF4Z3xRj2Xd5NeMopasok 2/fv3cGpQZnaccLRi3yfdZAsN/54PN6gGy1mU9cyyl//ZXtjqm/v21Me7fsXZefZ1JeZ/ZAA==
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
---
 fs/btrfs/ioctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b9864d63ffbf..983d91429099 100644
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

