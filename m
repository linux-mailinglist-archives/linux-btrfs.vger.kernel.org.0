Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F17C45B5
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Oct 2023 01:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbjJJXuO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 19:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344234AbjJJXuO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 19:50:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6DD294
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 16:50:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B8BEA216DC
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 23:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696981805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rKYniGQpGct/wk9/WdpzHBH6OQs8r3SCCqhoS3jbtpM=;
        b=GRxxCKPJddycDf0rj5YSqySV4Evi+pOxi30QLR75Z4Y8pRWGo1ld/CfKVa3RIeJDozdJ0x
        aSY1lY50fXHtQ+RLXaRABjdDgw17p0QnyH6uMsK+3IN5sHppzm716yEfUetLMA5IDQNlOc
        3QCUWCmte7rB2jmkXukGDDbvxHVddKA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA1741348E
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 23:50:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AMerGSzjJWXySwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Oct 2023 23:50:04 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs-progs: mkfs/rootdir: copy missing attributes for the rootdir inode
Date:   Wed, 11 Oct 2023 10:19:43 +1030
Message-ID: <b51f2007d812e2c2a4a3c3502b71efb70688a90f.1696981203.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1696981203.git.wqu@suse.com>
References: <cover.1696981203.git.wqu@suse.com>
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
index a413a31eb2d6..fde5efdebe8b 100644
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
+	ret = lstat(dir_name, &st);
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

