Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B473D5AEE
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhGZNWp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 09:22:45 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45466 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZNWp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 09:22:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7BE121F60;
        Mon, 26 Jul 2021 14:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627308192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/D92rzVKZ6sCPAVdehwONjT2JdMifZzBTbDzN4jCypE=;
        b=ZO8c4AWt+wq6htpJc+PGUoTk6OGbmt05HsiNAPkiPdzd/C40/KUpvH3jZoJ6PcvXpn8e3T
        D1doIJWphOe3MYSwyLW9tFkdQWzSAxLn4ec5wjr5JQWtEnGTwbzv4CU0jYZc22CEzOVKMG
        /ysDxg/gb5+Rdf0hKyKRtqFn3Bc+e6M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BEDA13AB2;
        Mon, 26 Jul 2021 14:03:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nljWD5/A/mAITAAAMHmgww
        (envelope-from <mpdesouza@suse.com>); Mon, 26 Jul 2021 14:03:11 +0000
From:   Marcos Paulo de Souza <mpdesouza@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com,
        Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH] btrfs: Introduce btrfs_search_backwards function
Date:   Mon, 26 Jul 2021 11:03:17 -0300
Message-Id: <20210726140317.4907-1-mpdesouza@suse.com>
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
in last offset of the same object and type. If the item is found,
convert the ondisk structure to the current endianness of the machine
running the code.

The new btrfs_search_backwards function does the all these procedures when
necessary, and can be used to avoid code duplication.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 fs/btrfs/ctree.c   | 23 +++++++++++++++++++++++
 fs/btrfs/ctree.h   |  6 ++++++
 fs/btrfs/ioctl.c   | 30 ++++++++----------------------
 fs/btrfs/super.c   | 26 ++++++--------------------
 fs/btrfs/volumes.c |  7 +------
 5 files changed, 44 insertions(+), 48 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 394fec1d3fd9..2991ee845813 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -2100,6 +2100,29 @@ int btrfs_search_slot_for_read(struct btrfs_root *root,
 	return 0;
 }
 
+/*
+ * Execute search and call btrfs_previous_item to traverse backwards if the item
+ * was not found. If found, convert the stored item to the correct endianness.
+ *
+ * Return 0 if found, 1 if not found and < 0 if error.
+ */
+int btrfs_search_backwards(struct btrfs_root *root,
+				struct btrfs_key *key,
+				struct btrfs_key *found_key,
+				struct btrfs_path *path)
+{
+	int ret;
+
+	ret = btrfs_search_slot(NULL, root, key, path, 0, 0);
+	if (ret > 0)
+		ret = btrfs_previous_item(root, path, key->objectid, key->type);
+
+	if (ret == 0)
+		btrfs_item_key_to_cpu(path->nodes[0], found_key,
+					path->slots[0]);
+	return ret;
+}
+
 /*
  * adjust the pointers going up the tree, starting at level
  * making sure the right key of each node is points to 'key'.
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4a69aa604ac5..27aa2b959861 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2903,6 +2903,12 @@ int btrfs_next_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			u64 time_seq);
+
+int btrfs_search_backwards(struct btrfs_root *root,
+				struct btrfs_key *key,
+				struct btrfs_key *found_key,
+				struct btrfs_path *path);
+
 static inline int btrfs_next_old_item(struct btrfs_root *root,
 				      struct btrfs_path *p, u64 time_seq)
 {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0ba98e08a029..ac6c0530a941 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2382,23 +2382,16 @@ static noinline int btrfs_search_path_in_tree(struct btrfs_fs_info *info,
 	key.offset = (u64)-1;
 
 	while (1) {
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		ret = btrfs_search_backwards(root, &key, &key, path);
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
@@ -2473,23 +2466,16 @@ static int btrfs_search_path_in_tree_user(struct inode *inode,
 		key.type = BTRFS_INODE_REF_KEY;
 		key.offset = (u64)-1;
 		while (1) {
-			ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
-			if (ret < 0) {
+			ret = btrfs_search_backwards(root, &key, &key, path);
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
index d07b18b2b250..2960219f7299 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1201,21 +1201,14 @@ char *btrfs_get_subvol_name_from_objectid(struct btrfs_fs_info *fs_info,
 		key.type = BTRFS_ROOT_BACKREF_KEY;
 		key.offset = (u64)-1;
 
-		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		ret = btrfs_search_backwards(root, &key, &key, path);
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
+			ret = btrfs_search_backwards(fs_root, &key, &key, path);
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
index d57ad0c9bb99..8d08e200b712 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1597,14 +1597,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 	key.offset = search_start;
 	key.type = BTRFS_DEV_EXTENT_KEY;
 
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	ret = btrfs_search_backwards(root, &key, &key, path);
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

