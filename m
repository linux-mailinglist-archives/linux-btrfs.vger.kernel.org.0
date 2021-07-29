Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF5D3DA073
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 11:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbhG2JkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 05:40:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57126 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbhG2JkI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 05:40:08 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FC99223FB;
        Thu, 29 Jul 2021 09:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627551604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=DjQETP2MjqNmkVBtGh/V/+uaUy/Hhl/JvA0br2yUK2Y=;
        b=JHy2l2EMoqCAWLWgxacTUu+/Z5MXLfKJAhkJhj5J8seeFxAjCREfUJjCy6lIgo+grnGUpv
        Jtjxlnim9BzP8V4BfjK5mYZze43LELIutXTO2ptn/Gtx1eX6QWTORZ+9BF6Fey8N0k8Bpf
        FQoYQfzJszWlBqk1VGQD9k+cyDQ3IVk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE01213ECF;
        Thu, 29 Jul 2021 08:21:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id j4eYISFlAmHjHgAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Thu, 29 Jul 2021 08:21:53 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v2] btrfs: Introduce btrfs_search_backwards function
Date:   Thu, 29 Jul 2021 05:22:16 -0300
Message-Id: <20210729082216.22886-1-mpdesouza@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It's a common practice to start a search using offset (u64)-1, which is
the u64 maximum value, meaning that we want the search_slot function to
be set in the last item with the same objectid and type.

Once we are in this position, it's a matter to start a search backwards
by calling btrfs_previous_item, which will check if we'll need to go to
a previous leaf and other necessary checks, only to be sure that we are
in last offset of the same object and type.

The new btrfs_search_backwards function does the all these procedures when
necessary, and can be used to avoid code duplication.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---

 Changes from v1:
 * Remove the found_key argument (David)
 * Remove endinness mentiones (David)

 fs/btrfs/ctree.c   | 22 ++++++++++++++++++++++
 fs/btrfs/ctree.h   |  4 ++++
 fs/btrfs/ioctl.c   | 30 ++++++++----------------------
 fs/btrfs/super.c   | 26 ++++++--------------------
 fs/btrfs/volumes.c |  7 +------
 5 files changed, 41 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 99b33a5b33c8..f4b2c5d48d8c 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2101,6 +2101,28 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
 	return 0;
 }
 
+/*
+ * Execute search and call btrfs_previous_item to traverse backwards if the item
+ * was not found.
+ *
+ * Return 0 if found, 1 if not found and < 0 if error.
+ */
+int btrfs_search_backwards(struct btrfs_root *root,
+				struct btrfs_key *key,
+				struct btrfs_path *path)
+{
+	int ret;
+
+	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
+	if (ret > 0)
+		ret = btrfs_previous_item(root, path, key->objectid, key->type);
+
+	if (ret == 0)
+		btrfs_item_key_to_cpu(path->nodes[0], key, path->slots[0]);
+
+	return ret;
+}
+
 /*
  * adjust the pointers going up the tree, starting at level
  * making sure the right key of each node is points to 'key'.
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index f17be4b023cb..a898257ad2b5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2908,6 +2908,10 @@ static inline int btrfs_insert_empty_item(struct btrfs_trans_handle *trans,
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			u64 time_seq);
+
+int btrfs_search_backwards(struct btrfs_root *root, struct btrfs_key *key,
+			   struct btrfs_path *path);
+
 static inline int btrfs_next_old_item(struct btrfs_root *root,
 				      struct btrfs_path *p, u64 time_seq)
 {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 85c8b5a87a6a..ba1dab6a5012 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2389,23 +2389,16 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	key.offset = (u64)-1;
 
 	while (1) {
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		ret = btrfs_search_backwards(root, &key, path);
 		if (ret < 0)
 			goto out;
 		else if (ret > 0) {
-			ret = btrfs_previous_item(root, path, dirid,
-						  BTRFS_INODE_REF_KEY);
-			if (ret < 0)
-				goto out;
-			else if (ret > 0) {
-				ret = -ENOENT;
-				goto out;
-			}
+			ret = -ENOENT;
+			goto out;
 		}
 
 		l = path->nodes[0];
 		slot = path->slots[0];
-		btrfs_item_key_to_cpu(l, &key, slot);
 
 		iref = btrfs_item_ptr(l, slot, struct btrfs_inode_ref);
 		len = btrfs_inode_ref_name_len(l, iref);
@@ -2480,23 +2473,16 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 		key.type = BTRFS_INODE_REF_KEY;
 		key.offset = (u64)-1;
 		while (1) {
-			ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-			if (ret < 0) {
+			ret = btrfs_search_backwards(root, &key, path);
+			if (ret < 0)
+				goto out_put;
+			else if (ret > 0) {
+				ret = -ENOENT;
 				goto out_put;
-			} else if (ret > 0) {
-				ret = btrfs_previous_item(root, path, dirid,
-							  BTRFS_INODE_REF_KEY);
-				if (ret < 0) {
-					goto out_put;
-				} else if (ret > 0) {
-					ret = -ENOENT;
-					goto out_put;
-				}
 			}
 
 			leaf = path->nodes[0];
 			slot = path->slots[0];
-			btrfs_item_key_to_cpu(leaf, &key, slot);
 
 			iref = btrfs_item_ptr(leaf, slot, struct btrfs_inode_ref);
 			len = btrfs_inode_ref_name_len(leaf, iref);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d444338db3c6..409bee3e7587 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1201,21 +1201,14 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 		key.type = BTRFS_ROOT_BACKREF_KEY;
 		key.offset = (u64)-1;
 
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		ret = btrfs_search_backwards(root, &key, path);
 		if (ret < 0) {
 			goto err;
 		} else if (ret > 0) {
-			ret = btrfs_previous_item(root, path, subvol_objectid,
-						  BTRFS_ROOT_BACKREF_KEY);
-			if (ret < 0) {
-				goto err;
-			} else if (ret > 0) {
-				ret = -ENOENT;
-				goto err;
-			}
+			ret = -ENOENT;
+			goto err;
 		}
 
-		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 		subvol_objectid = key.offset;
 
 		root_ref = btrfs_item_ptr(path->nodes[0], path->slots[0],
@@ -1248,21 +1241,14 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 			key.type = BTRFS_INODE_REF_KEY;
 			key.offset = (u64)-1;
 
-			ret = btrfs_search_slot(NULL, fs_root, &key, path, 0, 0);
+			ret = btrfs_search_backwards(fs_root, &key, path);
 			if (ret < 0) {
 				goto err;
 			} else if (ret > 0) {
-				ret = btrfs_previous_item(fs_root, path, dirid,
-							  BTRFS_INODE_REF_KEY);
-				if (ret < 0) {
-					goto err;
-				} else if (ret > 0) {
-					ret = -ENOENT;
-					goto err;
-				}
+				ret = -ENOENT;
+				goto err;
 			}
 
-			btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);
 			dirid = key.offset;
 
 			inode_ref = btrfs_item_ptr(path->nodes[0],
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 230192d097c4..536e60c6ade3 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1586,14 +1586,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	key.offset = search_start;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	ret = btrfs_search_backwards(root, &key, path);
 	if (ret < 0)
 		goto out;
-	if (ret > 0) {
-		ret = btrfs_previous_item(root, path, key.objectid, key.type);
-		if (ret < 0)
-			goto out;
-	}
 
 	while (1) {
 		l = path->nodes[0];
-- 
2.26.2

