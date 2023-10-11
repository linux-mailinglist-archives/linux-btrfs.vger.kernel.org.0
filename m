Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CE47C5EAE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 22:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbjJKUtu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Oct 2023 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjJKUtu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Oct 2023 16:49:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A989E
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 13:49:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A89F71F45F
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697057386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8yjNpkbDGv1WSdgrer/raX0gZJGhGZIVJmstQL6B2lg=;
        b=Tmqyp4DCuZvsWdYh6+JgSmfO7IvYOUbxvkbnmlN7rN0hgyYnlQ+cC+V0KLpahkrLeNBb0h
        jhho2d/surUYIUevnLJkwWiWdOdV7G5JJOs9KBhWeflJeZ5z6+E2Grfj6fc2hUrlv7joNP
        G+XV55q9Y7g6xdTmjJUg58nRs+EbYuA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8FBB134F5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IGCWJWkKJ2XCJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Oct 2023 20:49:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 1/2] btrfs-progs: mkfs/rootdir: copy missing attributes for the rootdir inode
Date:   Thu, 12 Oct 2023 07:19:25 +1030
Message-ID: <d33e5e10e92a0c8c2a82005eba1da47927bf286a.1697057301.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697057301.git.wqu@suse.com>
References: <cover.1697057301.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
When using "mkfs.btrfs" with "--rootdir" option, the top level inode
(rootdir) will not get the same xattr from the source dir:

  mkdir -p source_dir/
  touch source_dir/file
  setfattr -n user.rootdir_xattr source_dir/
  setfattr -n user.regular_xattr source_dir/file
  mkfs.btrfs -f --rootdir source_dir $dev
  mount $dev $mnt
  getfattr $mnt
  # Nothing <<<
  getfattr $mnt/file
  # file: $mnt/file
  user.regular_xattr <<<

[CAUSE]
In function traverse_directory(), we only call add_xattr_item() for all
the child inodes, not really for the rootdir inode itself, leading to
the missing xattr items.

Not only xattr, in fact we also miss the uid/gid/timestamps/mode for the
rootdir inode.

[FIX]
Extract a dedicated function, copy_rootdir_inode(), to handle every
needed attributes for the rootdir inode, including:

- xattr
- uid
- gid
- mode
- timestamps

Issue: #688
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 mkfs/rootdir.c | 88 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 21 deletions(-)

diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index a413a31eb2d6..24e26cdf50e0 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -429,6 +429,69 @@ end:
 	return ret;
 }
 
+static int copy_rootdir_inode(struct btrfs_trans_handle *trans,
+			      struct btrfs_root *root, const char *dir_name)
+{
+	u64 root_dir_inode_size;
+	struct btrfs_inode_item *inode_item;
+	struct btrfs_path path = { 0 };
+	struct btrfs_key key;
+	struct extent_buffer *leaf;
+	struct stat st;
+	int ret;
+
+	ret = stat(dir_name, &st);
+	if (ret < 0) {
+		ret = -errno;
+		error("lstat failed for direcotry %s: $m", dir_name);
+		return ret;
+	}
+
+	ret = add_xattr_item(trans, root, btrfs_root_dirid(&root->root_item),
+			     dir_name);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to add xattr item for the top level inode: %m");
+		return ret;
+	}
+
+	key.objectid = btrfs_root_dirid(&root->root_item);
+	key.offset = 0;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	ret = btrfs_lookup_inode(trans, root, &path, &key, 1);
+	if (ret > 0)
+		ret = -ENOENT;
+	if (ret) {
+		error("failed to lookup root dir: %d", ret);
+		goto error;
+	}
+
+	leaf = path.nodes[0];
+	inode_item = btrfs_item_ptr(leaf, path.slots[0],
+				    struct btrfs_inode_item);
+
+	root_dir_inode_size = calculate_dir_inode_size(dir_name);
+	btrfs_set_inode_size(leaf, inode_item, root_dir_inode_size);
+
+	/* Unlike fill_inode_item, we only need to copy part of the attributes. */
+	btrfs_set_inode_uid(leaf, inode_item, st.st_uid);
+	btrfs_set_inode_gid(leaf, inode_item, st.st_gid);
+	btrfs_set_inode_mode(leaf, inode_item, st.st_mode);
+	btrfs_set_timespec_sec(leaf, &inode_item->atime, st.st_atime);
+	btrfs_set_timespec_nsec(leaf, &inode_item->atime, 0);
+	btrfs_set_timespec_sec(leaf, &inode_item->ctime, st.st_ctime);
+	btrfs_set_timespec_nsec(leaf, &inode_item->ctime, 0);
+	btrfs_set_timespec_sec(leaf, &inode_item->mtime, st.st_mtime);
+	btrfs_set_timespec_nsec(leaf, &inode_item->mtime, 0);
+	btrfs_set_timespec_sec(leaf, &inode_item->otime, 0);
+	btrfs_set_timespec_nsec(leaf, &inode_item->otime, 0);
+	btrfs_mark_buffer_dirty(leaf);
+
+error:
+	btrfs_release_path(&path);
+	return ret;
+}
+
 static int traverse_directory(struct btrfs_trans_handle *trans,
 			      struct btrfs_root *root, const char *dir_name,
 			      struct directory_name_entry *dir_head)
@@ -436,7 +499,6 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
 	int ret = 0;
 
 	struct btrfs_inode_item cur_inode;
-	struct btrfs_inode_item *inode_item;
 	int count, i, dir_index_cnt;
 	struct dirent **files;
 	struct stat st;
@@ -445,10 +507,6 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
 	ino_t parent_inum, cur_inum;
 	ino_t highest_inum = 0;
 	const char *parent_dir_name;
-	struct btrfs_path path = { 0 };
-	struct extent_buffer *leaf;
-	struct btrfs_key root_dir_key;
-	u64 root_dir_inode_size = 0;
 
 	/* Add list for source directory */
 	dir_entry = malloc(sizeof(struct directory_name_entry));
@@ -466,25 +524,13 @@ static int traverse_directory(struct btrfs_trans_handle *trans,
 	dir_entry->inum = parent_inum;
 	list_add_tail(&dir_entry->list, &dir_head->list);
 
-	root_dir_key.objectid = btrfs_root_dirid(&root->root_item);
-	root_dir_key.offset = 0;
-	root_dir_key.type = BTRFS_INODE_ITEM_KEY;
-	ret = btrfs_lookup_inode(trans, root, &path, &root_dir_key, 1);
-	if (ret) {
-		error("failed to lookup root dir: %d", ret);
+	ret = copy_rootdir_inode(trans, root, dir_name);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to copy rootdir inode: %m");
 		goto fail_no_dir;
 	}
 
-	leaf = path.nodes[0];
-	inode_item = btrfs_item_ptr(leaf, path.slots[0],
-				    struct btrfs_inode_item);
-
-	root_dir_inode_size = calculate_dir_inode_size(dir_name);
-	btrfs_set_inode_size(leaf, inode_item, root_dir_inode_size);
-	btrfs_mark_buffer_dirty(leaf);
-
-	btrfs_release_path(&path);
-
 	do {
 		parent_dir_entry = list_entry(dir_head->list.next,
 					      struct directory_name_entry,
-- 
2.42.0

