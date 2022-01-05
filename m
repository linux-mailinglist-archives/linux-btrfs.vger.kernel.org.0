Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CDD484F5A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jan 2022 09:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238527AbiAEIaU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jan 2022 03:30:20 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:43462 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238514AbiAEIaT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jan 2022 03:30:19 -0500
X-Sender-Id: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D4CC7921C38
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 08:30:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a245.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 11217921ACB
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 08:30:17 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
Received: from pdx1-sub0-mail-a245.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.120.81.137 (trex/6.4.3);
        Wed, 05 Jan 2022 08:30:17 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
X-MailChannels-Auth-Id: dreamhost
X-Zesty-Decisive: 632db1562babb710_1641371417744_3552283879
X-MC-Loop-Signature: 1641371417743:3951624221
X-MC-Ingress-Time: 1641371417743
Received: from meinmachine.hsd1.ca.comcast.net (c-73-92-232-183.hsd1.ca.comcast.net [73.92.232.183])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sahil.kang@asilaycomputing.com)
        by pdx1-sub0-mail-a245.dreamhost.com (Postfix) with ESMTPSA id 4JTN2w5rKcz4B
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jan 2022 00:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=asilaycomputing.com;
        s=asilaycomputing.com; t=1641371416;
        bh=W7CQ8175CVvG6vetKWcjlX8SWtk=;
        h=From:To:Subject:Date:Content-Transfer-Encoding;
        b=B3nDUQDA70L9+5L5WHYivVjA29w9AS8YLGUuQiVXc/98ln5RCzttiMFPZdLnqhuzV
         jCphiWiMyaViMeofGYOTmKj3Cm5IoICeyy8CTPPbaJBSBEGnHhuX+CZuZVlyw8WpEW
         fKW+owSaR5MSL521CZeU1iSm9GeCOMqO5+VLLUSc=
From:   Sahil Kang <sahil.kang@asilaycomputing.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/1] btrfs: reuse existing pointers from btrfs_ioctl
Date:   Wed,  5 Jan 2022 00:30:06 -0800
Message-Id: <20220105083006.2793559-2-sahil.kang@asilaycomputing.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220105083006.2793559-1-sahil.kang@asilaycomputing.com>
References: <20220105083006.2793559-1-sahil.kang@asilaycomputing.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_ioctl already contains pointers to the inode and btrfs_root
structs, so we can pass them into the subfunctions instead of the
toplevel struct file.

Signed-off-by: Sahil Kang <sahil.kang@asilaycomputing.com>
---
 fs/btrfs/ioctl.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index edfecfe62b4b..26cade35eccd 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -414,10 +414,8 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
 	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
 }
 
-static int btrfs_ioctl_getversion(struct file *file, int __user *arg)
+static int btrfs_ioctl_getversion(struct inode *inode, int __user *arg)
 {
-	struct inode *inode = file_inode(file);
-
 	return put_user(inode->i_generation, arg);
 }
 
@@ -2559,25 +2557,22 @@ static int btrfs_search_path_in_tree_user(struct user_namespace *mnt_userns,
 	return ret;
 }
 
-static noinline int btrfs_ioctl_ino_lookup(struct file *file,
+static noinline int btrfs_ioctl_ino_lookup(struct btrfs_root *root,
 					   void __user *argp)
 {
 	struct btrfs_ioctl_ino_lookup_args *args;
-	struct inode *inode;
 	int ret = 0;
 
 	args = memdup_user(argp, sizeof(*args));
 	if (IS_ERR(args))
 		return PTR_ERR(args);
 
-	inode = file_inode(file);
-
 	/*
 	 * Unprivileged query to obtain the containing subvolume root id. The
 	 * path is reset so it's consistent with btrfs_search_path_in_tree.
 	 */
 	if (args->treeid == 0)
-		args->treeid = BTRFS_I(inode)->root->root_key.objectid;
+		args->treeid = root->root_key.objectid;
 
 	if (args->objectid == BTRFS_FIRST_FREE_OBJECTID) {
 		args->name[0] = 0;
@@ -2589,7 +2584,7 @@ static noinline int btrfs_ioctl_ino_lookup(struct file *file,
 		goto out;
 	}
 
-	ret = btrfs_search_path_in_tree(BTRFS_I(inode)->root->fs_info,
+	ret = btrfs_search_path_in_tree(root->fs_info,
 					args->treeid, args->objectid,
 					args->name);
 
@@ -2765,7 +2760,8 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
  * Return ROOT_REF information of the subvolume containing this inode
  * except the subvolume name.
  */
-static int btrfs_ioctl_get_subvol_rootref(struct file *file, void __user *argp)
+static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *subvol_root,
+					  void __user *argp)
 {
 	struct btrfs_ioctl_get_subvol_rootref_args *rootrefs;
 	struct btrfs_root_ref *rref;
@@ -2773,7 +2769,6 @@ static int btrfs_ioctl_get_subvol_rootref(struct file *file, void __user *argp)
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
-	struct inode *inode;
 	u64 objectid;
 	int slot;
 	int ret;
@@ -2789,9 +2784,8 @@ static int btrfs_ioctl_get_subvol_rootref(struct file *file, void __user *argp)
 		return PTR_ERR(rootrefs);
 	}
 
-	inode = file_inode(file);
-	root = BTRFS_I(inode)->root->fs_info->tree_root;
-	objectid = BTRFS_I(inode)->root->root_key.objectid;
+	root = subvol_root->fs_info->tree_root;
+	objectid = subvol_root->root_key.objectid;
 
 	key.objectid = objectid;
 	key.type = BTRFS_ROOT_REF_KEY;
@@ -4873,7 +4867,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 
 	switch (cmd) {
 	case FS_IOC_GETVERSION:
-		return btrfs_ioctl_getversion(file, argp);
+		return btrfs_ioctl_getversion(inode, argp);
 	case FS_IOC_GETFSLABEL:
 		return btrfs_ioctl_get_fslabel(fs_info, argp);
 	case FS_IOC_SETFSLABEL:
@@ -4921,7 +4915,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_TREE_SEARCH_V2:
 		return btrfs_ioctl_tree_search_v2(file, argp);
 	case BTRFS_IOC_INO_LOOKUP:
-		return btrfs_ioctl_ino_lookup(file, argp);
+		return btrfs_ioctl_ino_lookup(root, argp);
 	case BTRFS_IOC_INO_PATHS:
 		return btrfs_ioctl_ino_to_path(root, argp);
 	case BTRFS_IOC_LOGICAL_INO:
@@ -5000,7 +4994,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_GET_SUBVOL_INFO:
 		return btrfs_ioctl_get_subvol_info(file, argp);
 	case BTRFS_IOC_GET_SUBVOL_ROOTREF:
-		return btrfs_ioctl_get_subvol_rootref(file, argp);
+		return btrfs_ioctl_get_subvol_rootref(root, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
 		return btrfs_ioctl_ino_lookup_user(file, argp);
 	case FS_IOC_ENABLE_VERITY:
-- 
Sahil

