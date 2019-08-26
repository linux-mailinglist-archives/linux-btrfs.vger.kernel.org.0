Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1667A9CFAD
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 14:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbfHZMhb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 08:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53448 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730901AbfHZMhb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 08:37:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28FFDAD78
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 12:37:30 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Deprecate BTRFS_SUBVOL_CREATE_ASYNC flag
Date:   Mon, 26 Aug 2019 15:37:28 +0300
Message-Id: <20190826123728.2854-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
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
 fs/btrfs/ioctl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c343f72a84d5..a412bd2036bb 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1837,8 +1837,12 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 		goto free_args;
 	}
 
-	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC)
+	if (vol_args->flags & BTRFS_SUBVOL_CREATE_ASYNC) {
+		pr_warn("BTRFS: async snapshot creation is deprecated and will"
+			" be removed in kernel 5.7\n");
+
 		ptr = &transid;
+	}
 	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
 		readonly = true;
 	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
@@ -4214,6 +4218,10 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 	u64 transid;
 	int ret;
 
+
+	pr_warn("BTRFS: START_SYNC ioctl is deprecated and will be removed in "
+		"kernel 5.7\n");
+
 	trans = btrfs_attach_transaction_barrier(root);
 	if (IS_ERR(trans)) {
 		if (PTR_ERR(trans) != -ENOENT)
@@ -4241,6 +4249,9 @@ static noinline long btrfs_ioctl_wait_sync(struct btrfs_fs_info *fs_info,
 {
 	u64 transid;
 
+	pr_warn("BTRFS: WAIT_SYNC ioctl is deprecated and will be removed in "
+		"kernel 5.7\n");
+
 	if (argp) {
 		if (copy_from_user(&transid, argp, sizeof(transid)))
 			return -EFAULT;
-- 
2.17.1

