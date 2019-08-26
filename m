Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892C99D1BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 16:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbfHZOe2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 10:34:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:56614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726484AbfHZOe2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 10:34:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 209D8AC4A
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 14:34:27 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.cz
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Deprecate BTRFS_SUBVOL_CREATE_ASYNC flag
Date:   Mon, 26 Aug 2019 17:34:24 +0300
Message-Id: <20190826143424.10964-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826141002.GT2752@twin.jikos.cz>
References: <20190826141002.GT2752@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Support for asynchronous snapshot creation was originally added in
72fd032e9424 ("Btrfs: add SNAP_CREATE_ASYNC ioctl") to cater for
ceph's backend needs. However, since Ceph has deprecated support for
btrfs there is no longer need for that support in btrfs. Additionally,
this was never supported by btrfs-progs, the official userspace tools.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

V2: 
 * Switch to using btrfs_warn to make it more explicit and easily recognisable 
 it's a btrfs-sourced warning

 * Reword the SNAP_CREATE_V2 deprecation warning to make it easier to spot 
 which ioctl is deprecated. 

 fs/btrfs/ioctl.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c343f72a84d5..185b757f6cb6 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1837,8 +1837,14 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 		goto free_args;
 	}
 
-	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC)
+	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC) {
+		struct inode *inode = file_inode(file);
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+		btrfs_warn(fs_info, "SNAP_CREATE_V2 ioctl with CREATE_ASYNC is deprecated and will"
+			   " be removed in kernel 5.7\n");
+
 		ptr = &transid;
+	}
 	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
 		readonly = true;
 	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
@@ -4214,6 +4220,10 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 	u64 transid;
 	int ret;
 
+
+	btrfs_warn(root->fs_info, "START_SYNC ioctl is deprecated and will be removed in "
+		   "kernel 5.7\n");
+
 	trans = btrfs_attach_transaction_barrier(root);
 	if (IS_ERR(trans)) {
 		if (PTR_ERR(trans) != -ENOENT)
@@ -4241,6 +4251,9 @@ static noinline long btrfs_ioctl_wait_sync(struct btrfs_fs_info *fs_info,
 {
 	u64 transid;
 
+	btrfs_warn(fs_info, "WAIT_SYNC ioctl is deprecated and will be removed in "
+		   "kernel 5.7\n");
+
 	if (argp) {
 		if (copy_from_user(&transid, argp, sizeof(transid)))
 			return -EFAULT;
-- 
2.17.1

