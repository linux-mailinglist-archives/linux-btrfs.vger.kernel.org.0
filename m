Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6437E48FA5F
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 03:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiAPCtE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 21:49:04 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:21000 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233348AbiAPCtD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 21:49:03 -0500
X-Sender-Id: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BC97A621BEC
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 02:49:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a296.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5DACA621B7C
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Jan 2022 02:49:02 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
Received: from pdx1-sub0-mail-a296.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.121.92.82 (trex/6.4.3);
        Sun, 16 Jan 2022 02:49:02 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|sahil.kang@asilaycomputing.com
X-MailChannels-Auth-Id: dreamhost
X-Harbor-Imminent: 211a70d73ce82dbb_1642301342620_3584811230
X-MC-Loop-Signature: 1642301342620:2248458368
X-MC-Ingress-Time: 1642301342620
Received: from meinmachine.hsd1.ca.comcast.net (c-73-92-232-183.hsd1.ca.comcast.net [73.92.232.183])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sahil.kang@asilaycomputing.com)
        by pdx1-sub0-mail-a296.dreamhost.com (Postfix) with ESMTPSA id 4Jbzy603PYz1Px
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 18:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=asilaycomputing.com;
        s=asilaycomputing.com; t=1642301342;
        bh=GZ+2Z8itH9MyhdfVbzpAnaaUl8s=;
        h=From:To:Subject:Date:Content-Transfer-Encoding;
        b=UANRbqKQjvpW31wfKr4Cs6Z/1IITso/qmAZqN5vJSzqx8M6e18m5FCOYMM06CYHUz
         kdZZmayvbP+dXrw8MUgMBU7BJS73LtawUwb39Tl5MovtMw8LdtvP9UGOwD9SdS+Ngt
         eBrd3uCaaWJoDhX7bh9mktPPFFkk8EqextbuECBc=
From:   Sahil Kang <sahil.kang@asilaycomputing.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/1] btrfs: reuse existing inode from btrfs_ioctl
Date:   Sat, 15 Jan 2022 18:48:47 -0800
Message-Id: <20220116024847.29047-2-sahil.kang@asilaycomputing.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220116024847.29047-1-sahil.kang@asilaycomputing.com>
References: <20220106150334.GD14046@twin.jikos.cz>
 <20220116024847.29047-1-sahil.kang@asilaycomputing.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_ioctl extracts inode from file so we can pass that into the
subfunctions.

Signed-off-by: Sahil Kang <sahil.kang@asilaycomputing.com>
---
 fs/btrfs/ioctl.c | 43 ++++++++++++++++++-------------------------
 fs/btrfs/send.c  |  4 ++--
 fs/btrfs/send.h  |  2 +-
 3 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 26cae57b77aa..f202a9f18639 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1941,10 +1941,9 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 	return ret;
 }
 
-static noinline int btrfs_ioctl_subvol_getflags(struct file *file,
+static noinline int btrfs_ioctl_subvol_getflags(struct inode *inode,
 						void __user *arg)
 {
-	struct inode *inode = file_inode(file);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_root *root = BTRFS_I(inode)->root;
 	int ret = 0;
@@ -2274,12 +2273,11 @@ static noinline int search_ioctl(struct inode *inode,
 	return ret;
 }
 
-static noinline int btrfs_ioctl_tree_search(struct file *file,
-					   void __user *argp)
+static noinline int btrfs_ioctl_tree_search(struct inode *inode,
+					    void __user *argp)
 {
 	struct btrfs_ioctl_search_args __user *uargs;
 	struct btrfs_ioctl_search_key sk;
-	struct inode *inode;
 	int ret;
 	size_t buf_size;
 
@@ -2293,7 +2291,6 @@ static noinline int btrfs_ioctl_tree_search(struct file *file,
 
 	buf_size = sizeof(uargs->buf);
 
-	inode = file_inode(file);
 	ret = search_ioctl(inode, &sk, &buf_size, uargs->buf);
 
 	/*
@@ -2308,12 +2305,11 @@ static noinline int btrfs_ioctl_tree_search(struct file *file,
 	return ret;
 }
 
-static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
+static noinline int btrfs_ioctl_tree_search_v2(struct inode *inode,
 					       void __user *argp)
 {
 	struct btrfs_ioctl_search_args_v2 __user *uarg;
 	struct btrfs_ioctl_search_args_v2 args;
-	struct inode *inode;
 	int ret;
 	size_t buf_size;
 	const size_t buf_limit = SZ_16M;
@@ -2332,7 +2328,6 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
 	if (buf_size > buf_limit)
 		buf_size = buf_limit;
 
-	inode = file_inode(file);
 	ret = search_ioctl(inode, &args.key, &buf_size,
 			   (char __user *)(&uarg->buf[0]));
 	if (ret == 0 && copy_to_user(&uarg->key, &args.key, sizeof(args.key)))
@@ -2666,7 +2661,7 @@ static int btrfs_ioctl_ino_lookup_user(struct file *file, void __user *argp)
 }
 
 /* Get the subvolume information in BTRFS_ROOT_ITEM and BTRFS_ROOT_BACKREF */
-static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
+static int btrfs_ioctl_get_subvol_info(struct inode *inode, void __user *argp)
 {
 	struct btrfs_ioctl_get_subvol_info_args *subvol_info;
 	struct btrfs_fs_info *fs_info;
@@ -2678,7 +2673,6 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 	struct extent_buffer *leaf;
 	unsigned long item_off;
 	unsigned long item_len;
-	struct inode *inode;
 	int slot;
 	int ret = 0;
 
@@ -2692,7 +2686,6 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
 		return -ENOMEM;
 	}
 
-	inode = file_inode(file);
 	fs_info = BTRFS_I(inode)->root->fs_info;
 
 	/* Get root_item of inode's subvolume */
@@ -2786,12 +2779,11 @@ static int btrfs_ioctl_get_subvol_info(struct file *file, void __user *argp)
  * Return ROOT_REF information of the subvolume containing this inode
  * except the subvolume name.
  */
-static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *subvol_root,
+static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *root,
 					  void __user *argp)
 {
 	struct btrfs_ioctl_get_subvol_rootref_args *rootrefs;
 	struct btrfs_root_ref *rref;
-	struct btrfs_root *root;
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct extent_buffer *leaf;
@@ -2810,14 +2802,13 @@ static int btrfs_ioctl_get_subvol_rootref(struct btrfs_root *subvol_root,
 		return PTR_ERR(rootrefs);
 	}
 
-	root = subvol_root->fs_info->tree_root;
-	objectid = subvol_root->root_key.objectid;
-
+	objectid = root->root_key.objectid;
 	key.objectid = objectid;
 	key.type = BTRFS_ROOT_REF_KEY;
 	key.offset = rootrefs->min_treeid;
 	found = 0;
 
+	root = root->fs_info->tree_root;
 	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
 	if (ret < 0) {
 		goto out;
@@ -4859,7 +4850,9 @@ static int btrfs_ioctl_set_features(struct file *file, void __user *arg)
 	return ret;
 }
 
-static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
+static int _btrfs_ioctl_send(struct inode *inode,
+			     void __user *argp,
+			     bool compat)
 {
 	struct btrfs_ioctl_send_args *arg;
 	int ret;
@@ -4889,7 +4882,7 @@ static int _btrfs_ioctl_send(struct file *file, void __user *argp, bool compat)
 		if (IS_ERR(arg))
 			return PTR_ERR(arg);
 	}
-	ret = btrfs_ioctl_send(file, arg);
+	ret = btrfs_ioctl_send(inode, arg);
 	kfree(arg);
 	return ret;
 }
@@ -4924,7 +4917,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SNAP_DESTROY_V2:
 		return btrfs_ioctl_snap_destroy(file, argp, true);
 	case BTRFS_IOC_SUBVOL_GETFLAGS:
-		return btrfs_ioctl_subvol_getflags(file, argp);
+		return btrfs_ioctl_subvol_getflags(inode, argp);
 	case BTRFS_IOC_SUBVOL_SETFLAGS:
 		return btrfs_ioctl_subvol_setflags(file, argp);
 	case BTRFS_IOC_DEFAULT_SUBVOL:
@@ -4948,9 +4941,9 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_BALANCE:
 		return btrfs_ioctl_balance(file, NULL);
 	case BTRFS_IOC_TREE_SEARCH:
-		return btrfs_ioctl_tree_search(file, argp);
+		return btrfs_ioctl_tree_search(inode, argp);
 	case BTRFS_IOC_TREE_SEARCH_V2:
-		return btrfs_ioctl_tree_search_v2(file, argp);
+		return btrfs_ioctl_tree_search_v2(inode, argp);
 	case BTRFS_IOC_INO_LOOKUP:
 		return btrfs_ioctl_ino_lookup(root, argp);
 	case BTRFS_IOC_INO_PATHS:
@@ -4999,10 +4992,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_set_received_subvol_32(file, argp);
 #endif
 	case BTRFS_IOC_SEND:
-		return _btrfs_ioctl_send(file, argp, false);
+		return _btrfs_ioctl_send(inode, argp, false);
 #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
 	case BTRFS_IOC_SEND_32:
-		return _btrfs_ioctl_send(file, argp, true);
+		return _btrfs_ioctl_send(inode, argp, true);
 #endif
 	case BTRFS_IOC_GET_DEV_STATS:
 		return btrfs_ioctl_get_dev_stats(fs_info, argp);
@@ -5029,7 +5022,7 @@ long btrfs_ioctl(struct file *file, unsigned int
 	case BTRFS_IOC_SET_FEATURES:
 		return btrfs_ioctl_set_features(file, argp);
 	case BTRFS_IOC_GET_SUBVOL_INFO:
-		return btrfs_ioctl_get_subvol_info(file, argp);
+		return btrfs_ioctl_get_subvol_info(inode, argp);
 	case BTRFS_IOC_GET_SUBVOL_ROOTREF:
 		return btrfs_ioctl_get_subvol_rootref(root, argp);
 	case BTRFS_IOC_INO_LOOKUP_USER:
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index d8ccb62aa7d2..ebf83c4b5e25 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7473,10 +7473,10 @@ static void dedupe_in_progress_warn(const struct btrfs_root *root)
 		      root->root_key.objectid, root->dedupe_in_progress);
 }
 
-long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
+long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg)
 {
 	int ret = 0;
-	struct btrfs_root *send_root = BTRFS_I(file_inode(mnt_file))->root;
+	struct btrfs_root *send_root = BTRFS_I(inode)->root;
 	struct btrfs_fs_info *fs_info = send_root->fs_info;
 	struct btrfs_root *clone_root;
 	struct send_ctx *sctx = NULL;
diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 23bcefc84e49..08602fdd600a 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -126,7 +126,7 @@ enum {
 #define BTRFS_SEND_A_MAX (__BTRFS_SEND_A_MAX - 1)
 
 #ifdef __KERNEL__
-long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg);
+long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg);
 #endif
 
 #endif
-- 
Sahil

