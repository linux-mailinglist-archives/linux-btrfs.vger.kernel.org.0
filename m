Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634B57C9E4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Oct 2023 06:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjJPEjx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Oct 2023 00:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjJPEjv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Oct 2023 00:39:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF864E1
        for <linux-btrfs@vger.kernel.org>; Sun, 15 Oct 2023 21:39:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3121D21C19
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697431154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7mN5MzaQRRKpWEXGxijvSFPkWtKHV1Zmu5B13p9JMMI=;
        b=QkR3syhEoGbj+HJwFSvs7UgiCG2pcMu/td6WzJUKPlL5lqvNpHSSp2QHeFcfUQkHmR7PbO
        SzlBdPq+bPFqV5HHUVYGGyVsLArwd5UquywNWRoMWUdKz4bH/+Pe6AG1rzjKYdLJY5nuin
        TQN/DdzJ2KKtypuL32ZeiBdw2QHfjSU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C2F5138EF
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SEMxB3G+LGUaFgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Oct 2023 04:39:13 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs-progs: enhance and rename btrfs_mksubvol() function
Date:   Mon, 16 Oct 2023 15:08:48 +1030
Message-ID: <44d4cf2f6750305bdabe26beb499974480e6a638.1697430866.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697430866.git.wqu@suse.com>
References: <cover.1697430866.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         RCPT_COUNT_ONE(0.00)[1];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_mksubvol() is currently only utilized by
btrfs-convert, to create a subvolume to contain the image file.

With the incoming support for "mkfs.btrfs --subvolume" option, we need
the following features:

- Create the subvolume under a specified directory
  The old can only create the subvolume under the rootdir.

- Add some basic sanity checks
  Making sure the parent inode exists and is a directory inode.

And also the function name is confusing, the work of btrfs_mksubvol() is
really linking a subvolume under a directory, not really create the full
subvolume.

This patch would add those needed features, and rename the function to
btrfs_link_subvol().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/main.c        |  5 +--
 kernel-shared/ctree.h |  5 +--
 kernel-shared/inode.c | 76 +++++++++++++++++++++++++++++++------------
 3 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/convert/main.c b/convert/main.c
index c9e50c036f92..73740fe26d55 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1311,8 +1311,9 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		task_deinit(ctx.info);
 	}
 
-	image_root = btrfs_mksubvol(root, subvol_name,
-				    CONV_IMAGE_SUBVOL_OBJECTID, true);
+	image_root = btrfs_link_subvol(root, btrfs_root_dirid(&root->root_item),
+				       subvol_name,  CONV_IMAGE_SUBVOL_OBJECTID,
+				       true);
 	if (!image_root) {
 		error("unable to link subvolume %s", subvol_name);
 		goto fail;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index bcf11d870061..a10a30e36b94 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1230,8 +1230,9 @@ int btrfs_add_orphan_item(struct btrfs_trans_handle *trans,
 			  u64 ino);
 int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		char *name, int namelen, u64 parent_ino, u64 *ino, int mode);
-struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root, const char *base,
-				  u64 root_objectid, bool convert);
+struct btrfs_root *btrfs_link_subvol(struct btrfs_root *root, u64 parent_ino,
+				     const char *name, u64 root_objectid,
+				     bool retry_suffix_names);
 int btrfs_find_free_objectid(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *fs_root,
 			     u64 dirid, u64 *objectid);
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 50bb460acc79..ebb28b7666cc 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -601,11 +601,19 @@ out:
 	return ret;
 }
 
-struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
-				  const char *base, u64 root_objectid,
-				  bool convert)
+/*
+ * Link a subvolume with @root_objectid to @parent_ino of @root, with the name
+ * @base.
+ *
+ * If @retry_suffix_names is true, and if there is already a dir item with the
+ * same name of @base, then it would retry with an increasing number as suffix,
+ * until a conflict-free name is found, or have tried too many times.
+ */
+struct btrfs_root *btrfs_link_subvol(struct btrfs_root *root, u64 parent_ino,
+				     const char *name, u64 root_objectid,
+				     bool retry_suffix_names)
 {
-	struct btrfs_trans_handle *trans;
+	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *tree_root = fs_info->tree_root;
 	struct btrfs_root *new_root = NULL;
@@ -613,32 +621,58 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 	struct btrfs_inode_item *inode_item;
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
-	u64 dirid = btrfs_root_dirid(&root->root_item);
 	u64 index = 2;
 	char buf[BTRFS_NAME_LEN + 1]; /* for snprintf null */
 	int len;
 	int i;
 	int ret;
 
-	len = strlen(base);
-	if (len == 0 || len > BTRFS_NAME_LEN)
+	len = strlen(name);
+	if (len == 0 || len > BTRFS_NAME_LEN) {
+		error("invalid name length %u", len);
 		return NULL;
+	}
 
-	key.objectid = dirid;
+	/* Make sure @parent_ino of @root is a directory. */
+	key.objectid = parent_ino;
+	key.type = BTRFS_INODE_ITEM_KEY;
+	key.offset = 0;
+	ret = btrfs_lookup_inode(NULL, root, &path, &key, 0);
+	if (ret > 0) {
+		ret = -ENOENT;
+		/* Fallthrough */
+	}
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to locate directory inode %llu of root %lld: %m",
+		      parent_ino, root->root_key.objectid);
+		goto fail;
+	}
+	inode_item = btrfs_item_ptr(path.nodes[0], path.slots[0],
+				    struct btrfs_inode_item);
+	if (!S_ISDIR(btrfs_inode_mode(path.nodes[0], inode_item))) {
+		ret = -EUCLEAN;
+		error("inode %llu of root %lld is not a directory",
+		      parent_ino, root->root_key.objectid);
+		goto fail;
+	}
+	btrfs_release_path(&path);
+
+	/* Locate one free dir index number. */
+	key.objectid = parent_ino;
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = (u64)-1;
-
 	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret <= 0) {
 		error("search for DIR_INDEX dirid %llu failed: %d",
-				(unsigned long long)dirid, ret);
+		      parent_ino, ret);
 		goto fail;
 	}
 
 	if (path.slots[0] > 0) {
 		path.slots[0]--;
 		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-		if (key.objectid == dirid && key.type == BTRFS_DIR_INDEX_KEY)
+		if (key.objectid == parent_ino && key.type == BTRFS_DIR_INDEX_KEY)
 			index = key.offset + 1;
 	}
 	btrfs_release_path(&path);
@@ -651,14 +685,14 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 		goto fail;
 	}
 
-	key.objectid = dirid;
+	key.objectid = parent_ino;
 	key.offset = 0;
 	key.type =  BTRFS_INODE_ITEM_KEY;
 
 	ret = btrfs_lookup_inode(trans, root, &path, &key, 1);
 	if (ret) {
 		error("search for INODE_ITEM %llu failed: %d",
-				(unsigned long long)dirid, ret);
+				parent_ino, ret);
 		goto fail;
 	}
 	leaf = path.nodes[0];
@@ -669,21 +703,21 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 	key.offset = (u64)-1;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 
-	memcpy(buf, base, len);
-	if (convert) {
+	memcpy(buf, name, len);
+	if (retry_suffix_names) {
 		for (i = 0; i < 1024; i++) {
 			ret = btrfs_insert_dir_item(trans, root, buf, len,
-					dirid, &key, BTRFS_FT_DIR, index);
+					parent_ino, &key, BTRFS_FT_DIR, index);
 			if (ret != -EEXIST)
 				break;
-			len = snprintf(buf, ARRAY_SIZE(buf), "%s%d", base, i);
+			len = snprintf(buf, ARRAY_SIZE(buf), "%s%d", name, i);
 			if (len < 1 || len > BTRFS_NAME_LEN) {
 				ret = -EINVAL;
 				break;
 			}
 		}
 	} else {
-		ret = btrfs_insert_dir_item(trans, root, buf, len, dirid, &key,
+		ret = btrfs_insert_dir_item(trans, root, buf, len, parent_ino, &key,
 					    BTRFS_FT_DIR, index);
 	}
 	if (ret)
@@ -698,7 +732,7 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 	ret = btrfs_add_root_ref(trans, tree_root, root_objectid,
 				 BTRFS_ROOT_BACKREF_KEY,
 				 root->root_key.objectid,
-				 dirid, index, buf, len);
+				 parent_ino, index, buf, len);
 	if (ret) {
 		error("unable to add root backref for %llu: %d",
 				root->root_key.objectid, ret);
@@ -708,7 +742,7 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 	/* now add the forward ref */
 	ret = btrfs_add_root_ref(trans, tree_root, root->root_key.objectid,
 				 BTRFS_ROOT_REF_KEY, root_objectid,
-				 dirid, index, buf, len);
+				 parent_ino, index, buf, len);
 	if (ret) {
 		error("unable to add root ref for %llu: %d",
 				root->root_key.objectid, ret);
@@ -728,6 +762,8 @@ struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
 		new_root = NULL;
 	}
 fail:
+	if (trans && ret < 0)
+		btrfs_abort_transaction(trans, ret);
 	return new_root;
 }
 
-- 
2.42.0

