Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC867D04D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 00:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346639AbjJSWap (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 18:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346641AbjJSWaj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 18:30:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05E9CA
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 15:30:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C00DE1FD8C
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697754632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NDrBG4tfn0mFK8mYHMGERBtuIclJceYweLF4z9hkYyE=;
        b=ijy2NiVtbXEdR/t8VtgrPpyJuv1I0EuvP1IVnczHfY3vcFLI77cH2DEPO1bMPTF/F5ZkT/
        pxdJojClkOa8qsD0u+6oacjGUpt0+67H4ceytFcj//8pCDTamhWA7Sw5IpkqRU5RXfJ9I3
        nmj0YccKQyUfeJF1SGmvaNr8baz6b7M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0E051357F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OM9KKweuMWXzWgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:31 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/9] btrfs-progs: merge btrfs_mksubvol() into btrfs_add_link()
Date:   Fri, 20 Oct 2023 09:00:03 +1030
Message-ID: <4cc3c23201591b951500033213ddaa7a7531ad56.1697754500.git.wqu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697754500.git.wqu@suse.com>
References: <cover.1697754500.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
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
         PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_ONE(0.00)[1];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The function btrfs_mksubvol() is only utilized by convert, and its
functionality is not to create a subvolume, but linking one to fs_tree.

In kernel code, btrfs_add_link() can handle the following cases:

- Linking one inode to a directory inside the same subvolume
- Linking one root to a directory inside another subvolume

Although the parameters are different in btrfs-progs, there is not much
reason not to do the same in btrfs-progs.

So this patch would:

- Make btrfs_add_link() able to handle linking subvolume
  * Add a @parent_root parameter
  * Rename existing @ino/@root to @child_ino/@child_root
  * Add extra check to make sure if linking a subvolume, the @child_ino
    is the rootdir
  * If linking a subvolume, insert root and backref for @child_root
  * If linking a subvolume, use the root_key of @child_root

- Use btrfs_add_link() to implement link_image_subvol() for convert
  Since btrfs_add_link() would return -EEXIST before inserting any
  dir items, it's very safe to retry for a new subvolume name.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          |   2 +-
 check/mode-common.c   |   6 +-
 check/mode-lowmem.c   |   4 +-
 convert/main.c        |  83 ++++++++++++++-
 kernel-shared/ctree.h |   6 +-
 kernel-shared/inode.c | 241 +++++++++++++++---------------------------
 6 files changed, 172 insertions(+), 170 deletions(-)

diff --git a/check/main.c b/check/main.c
index 4beeb0adae76..4a88cc8f8708 100644
--- a/check/main.c
+++ b/check/main.c
@@ -2454,7 +2454,7 @@ static int reset_nlink(struct btrfs_trans_handle *trans,
 	 * add_link() will handle the nlink inc, so new nlink must be correct
 	 */
 	list_for_each_entry(backref, &rec->backrefs, list) {
-		ret = btrfs_add_link(trans, root, rec->ino, backref->dir,
+		ret = btrfs_add_link(trans, root, rec->ino, root, backref->dir,
 				     backref->name, backref->namelen,
 				     &backref->index, 0);
 		if (ret < 0)
diff --git a/check/mode-common.c b/check/mode-common.c
index 1f42743c390a..0dca0a789a4d 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -463,7 +463,7 @@ int link_inode_to_lostfound(struct btrfs_trans_handle *trans,
 		error("failed to create '%s' dir: %m", dir_name);
 		goto out;
 	}
-	ret = btrfs_add_link(trans, root, ino, lost_found_ino,
+	ret = btrfs_add_link(trans, root, ino, root, lost_found_ino,
 			     namebuf, name_len, NULL, 0);
 	/*
 	 * Add ".INO" suffix several times to handle case where
@@ -480,8 +480,8 @@ int link_inode_to_lostfound(struct btrfs_trans_handle *trans,
 		snprintf(namebuf + name_len, BTRFS_NAME_LEN - name_len,
 			 ".%llu", ino);
 		name_len += count_digits(ino) + 1;
-		ret = btrfs_add_link(trans, root, ino, lost_found_ino, namebuf,
-				     name_len, NULL, 0);
+		ret = btrfs_add_link(trans, root, ino, root, lost_found_ino,
+				     namebuf, name_len, NULL, 0);
 	}
 	if (ret < 0) {
 		errno = -ret;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 275f6d16ebc7..b52316754753 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -1040,8 +1040,8 @@ static int repair_ternary_lowmem(struct btrfs_root *root, u64 dir_ino, u64 ino,
 				name_len, 0);
 		if (ret)
 			goto out;
-		ret = btrfs_add_link(trans, root, ino, dir_ino, name, name_len,
-				     &index, 1);
+		ret = btrfs_add_link(trans, root, ino, root, dir_ino, name,
+				     name_len, &index, 1);
 		goto out;
 	}
 out:
diff --git a/convert/main.c b/convert/main.c
index c1047bacbe01..bcd310228fcd 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -104,6 +104,7 @@
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/free-space-tree.h"
 #include "kernel-shared/file-item.h"
+#include "kernel-shared/ctree.h"
 #include "crypto/hash.h"
 #include "common/defs.h"
 #include "common/extent-cache.h"
@@ -840,8 +841,8 @@ static int create_image(struct btrfs_root *root,
 			ino, root->root_key.objectid);
 		goto out;
 	}
-	ret = btrfs_add_link(trans, root, ino, BTRFS_FIRST_FREE_OBJECTID, name,
-			     strlen(name), NULL, 0);
+	ret = btrfs_add_link(trans, root, ino, root, BTRFS_FIRST_FREE_OBJECTID,
+			     name, strlen(name), NULL, 0);
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to link ino %llu to '/%s' in root %llu: %m",
@@ -1145,6 +1146,79 @@ static int convert_open_fs(const char *devname,
 	return -1;
 }
 
+static struct btrfs_root *link_image_subvol(struct btrfs_fs_info *fs_info,
+					    const char *base)
+{
+	struct btrfs_root *fs_root = fs_info->fs_root;
+	struct btrfs_root *image_root;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_key key;
+	char buf[BTRFS_NAME_LEN + 1]; /* for snprintf null */
+	int len;
+	int ret;
+
+	strcpy(buf, base);
+	len = strlen(base);
+	if (len == 0 || len > BTRFS_NAME_LEN) {
+		ret = -EINVAL;
+		error("invalid image subvolume name: %s", base);
+		image_root = ERR_PTR(ret);
+		goto out;
+	}
+
+	/*
+	 * 1 root ref, 1 root backref,
+	 * 1 dir_index, 1 dir_item.
+	 */
+	trans = btrfs_start_transaction(fs_root, 4);
+	if (IS_ERR(trans)) {
+		ret = PTR_ERR(trans);
+		errno = -ret;
+		error_msg(ERROR_MSG_START_TRANS, "%m");
+		image_root = ERR_PTR(ret);
+		goto out;
+	}
+	key.objectid = CONV_IMAGE_SUBVOL_OBJECTID;
+	key.type = BTRFS_ROOT_ITEM_KEY;
+	key.offset = (u64)-1;
+	image_root = btrfs_read_fs_root(fs_info, &key);
+	if (IS_ERR(image_root)) {
+		ret = PTR_ERR(image_root);
+		errno = -ret;
+		error("failed to read convert image subvolume: %m");
+		image_root = ERR_PTR(ret);
+		goto out;
+	}
+	for (int i = 0; i < 1024; i++) {
+		ret = btrfs_add_link(trans,
+			image_root, btrfs_root_dirid(&image_root->root_item),
+			fs_root, btrfs_root_dirid(&fs_root->root_item),
+			buf, len, NULL, 0);
+		if (ret != -EEXIST)
+			break;
+		len = snprintf(buf, ARRAY_SIZE(buf), "%s%d", base, i);
+		if (len < 1 || len > BTRFS_NAME_LEN) {
+			ret = -EINVAL;
+			break;
+		}
+	}
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to link image subvolume: %m");
+		image_root = ERR_PTR(ret);
+		goto out;
+	}
+	ret = btrfs_commit_transaction(trans, fs_root);
+	if (ret < 0) {
+		errno = -ret;
+		error("failed to commit transaction: %m");
+		image_root = ERR_PTR(ret);
+		goto out;
+	}
+out:
+	return image_root;
+}
+
 static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		const char *fslabel, int progress,
 		struct btrfs_mkfs_features *features, u16 csum_type,
@@ -1311,9 +1385,8 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 		task_deinit(ctx.info);
 	}
 
-	image_root = btrfs_mksubvol(root, subvol_name,
-				    CONV_IMAGE_SUBVOL_OBJECTID, true);
-	if (!image_root) {
+	image_root = link_image_subvol(root->fs_info, subvol_name);
+	if (IS_ERR(image_root)) {
 		error("unable to link subvolume %s", subvol_name);
 		goto fail;
 	}
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 501feaa08a0a..ff43fefca802 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1225,8 +1225,10 @@ int btrfs_new_inode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		u64 ino, u32 mode);
 int btrfs_change_inode_flags(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root, u64 ino, u64 flags);
-int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
-		   u64 ino, u64 parent_ino, char *name, int namelen,
+int btrfs_add_link(struct btrfs_trans_handle *trans,
+		   struct btrfs_root *child_root, u64 child_ino,
+		   struct btrfs_root *parent_root, u64 parent_ino,
+		   char *name, int namelen,
 		   u64 *index, int ignore_existed);
 int btrfs_unlink(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 u64 ino, u64 parent_ino, u64 index, const char *name,
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 43ab685a45e1..38ca882141e2 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -170,33 +170,44 @@ out:
 }
 
 /*
- * Add dir_item/index for 'parent_ino' if add_backref is true, also insert a
- * backref from the ino to parent dir and update the nlink(Kernel version does
- * not do this thing)
+ * Link child inode (@child_ino of @child_root) under the directory of parent
+ * inode (@parent_ino of @parent_root, must be a directory inode), using
+ * @name.
  *
- * Currently only supports adding link from an inode to another inode.
+ * If @child_root and @parent_root are different, @child_ino must be the rootdir
+ * of @child_root.
+ *
+ * If @index is not NULL, and points to a non-zero value, this function would use
+ * *index as the DIR_INDEX, caller must ensure there is no conflicts.
+ * If @ignore_existed is true, any conflicting DIR_ITEM/DIR_INDEX would be ignored.
  */
-int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
-		   u64 ino, u64 parent_ino, char *name, int namelen,
+int btrfs_add_link(struct btrfs_trans_handle *trans,
+		   struct btrfs_root *child_root, u64 child_ino,
+		   struct btrfs_root *parent_root, u64 parent_ino,
+		   char *name, int namelen,
 		   u64 *index, int ignore_existed)
 {
 	struct btrfs_path *path;
 	struct btrfs_key key;
 	struct btrfs_inode_item *inode_item;
+	bool link_subvol = false;
 	u32 imode;
 	u32 nlink;
 	u64 inode_size;
 	u64 ret_index = 0;
 	int ret = 0;
 
+	if (btrfs_comp_cpu_keys(&child_root->root_key, &parent_root->root_key))
+		link_subvol = true;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
 
-	key.objectid = ino;
+	key.objectid = child_ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	ret = btrfs_search_slot(NULL, child_root, &key, path, 0, 0);
 	if (ret > 0) {
 		ret = -ENOENT;
 		/* fallthrough */
@@ -209,31 +220,72 @@ int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	imode = btrfs_inode_mode(path->nodes[0], inode_item);
 	btrfs_release_path(path);
 
+	/*
+	 * If linking a subvolume, child_ino must be the rootdir of that
+	 * subvolume.
+	 */
+	if (link_subvol && child_ino != btrfs_root_dirid(&child_root->root_item)) {
+		error("child ino is not rootdir, has %llu expect %llu",
+		      child_ino, btrfs_root_dirid(&child_root->root_item));
+		ret = -EUCLEAN;
+		goto out;
+	}
+
 	if (index && *index) {
 		ret_index = *index;
 	} else {
-		ret = btrfs_find_free_dir_index(root, parent_ino, &ret_index);
+		ret = btrfs_find_free_dir_index(parent_root, parent_ino,
+						&ret_index);
 		if (ret < 0)
 			goto out;
 	}
 
-	ret = check_dir_conflict(root, name, namelen, parent_ino, ret_index);
+	ret = check_dir_conflict(parent_root, name, namelen, parent_ino,
+				 ret_index);
 	if (ret < 0 && !(ignore_existed && ret == -EEXIST))
 		goto out;
 
-	/* Add inode ref */
-	ret = btrfs_insert_inode_ref(trans, root, name, namelen,
-				     ino, parent_ino, ret_index);
-	if (ret < 0 && !(ignore_existed && ret == -EEXIST))
-		goto out;
+	if (link_subvol) {
+		struct btrfs_root *tree_root = trans->fs_info->tree_root;
+
+		/* Add root backref. */
+		ret = btrfs_add_root_ref(trans, tree_root,
+				child_root->root_key.objectid,
+				BTRFS_ROOT_BACKREF_KEY,
+				parent_root->root_key.objectid,
+				parent_ino, ret_index, name, namelen);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to add backref for child root %lld: %m",
+			      child_root->root_key.objectid);
+			goto out;
+		}
+
+		ret = btrfs_add_root_ref(trans, tree_root,
+				parent_root->root_key.objectid,
+				BTRFS_ROOT_REF_KEY, child_root->root_key.objectid,
+				parent_ino, ret_index, name, namelen);
+		if (ret < 0) {
+			errno = -ret;
+			error("failed to add root ref for child root %lld: %m",
+			      child_root->root_key.objectid);
+			goto out;
+		}
+	} else {
+		/* Add inode ref */
+		ret = btrfs_insert_inode_ref(trans, child_root, name, namelen,
+					     child_ino, parent_ino, ret_index);
+		if (ret < 0 && !(ignore_existed && ret == -EEXIST))
+			goto out;
+	}
 
 	/* do not update nlinks if existed */
-	if (!ret) {
-		/* Update nlinks for the inode */
-		key.objectid = ino;
+	if (!ret && !link_subvol) {
+		/* Update nlinks for the child inode. */
+		key.objectid = child_ino;
 		key.type = BTRFS_INODE_ITEM_KEY;
 		key.offset = 0;
-		ret = btrfs_search_slot(trans, root, &key, path, 1, 1);
+		ret = btrfs_search_slot(trans, child_root, &key, path, 1, 1);
 		if (ret) {
 			if (ret > 0)
 				ret = -ENOENT;
@@ -250,11 +302,16 @@ int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	}
 
 	/* Add dir_item and dir_index */
-	key.objectid = ino;
-	key.type = BTRFS_INODE_ITEM_KEY;
-	key.offset = 0;
-	ret = btrfs_insert_dir_item(trans, root, name, namelen, parent_ino,
-				    &key, fs_umode_to_ftype(imode), ret_index);
+	if (link_subvol) {
+		memcpy(&key, &child_root->root_key, sizeof(struct btrfs_key));
+	} else {
+		key.objectid = child_ino;
+		key.type = BTRFS_INODE_ITEM_KEY;
+		key.offset = 0;
+	}
+	ret = btrfs_insert_dir_item(trans, parent_root, name, namelen,
+				    parent_ino, &key,
+				    fs_umode_to_ftype(imode), ret_index);
 	if (ret < 0)
 		goto out;
 
@@ -262,7 +319,7 @@ int btrfs_add_link(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	key.objectid = parent_ino;
 	key.type = BTRFS_INODE_ITEM_KEY;
 	key.offset = 0;
-	ret = btrfs_search_slot(trans, root, &key, path, 1, 1);
+	ret = btrfs_search_slot(trans, parent_root, &key, path, 1, 1);
 	if (ret)
 		goto out;
 	inode_item = btrfs_item_ptr(path->nodes[0], path->slots[0],
@@ -596,8 +653,8 @@ int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	ret = btrfs_new_inode(trans, root, ret_ino, mode | S_IFDIR);
 	if (ret)
 		goto out;
-	ret = btrfs_add_link(trans, root, ret_ino, parent_ino, name, namelen,
-			     NULL, 0);
+	ret = btrfs_add_link(trans, root, ret_ino, root, parent_ino, name,
+			     namelen, NULL, 0);
 	if (ret)
 		goto out;
 out:
@@ -607,136 +664,6 @@ out:
 	return ret;
 }
 
-struct btrfs_root *btrfs_mksubvol(struct btrfs_root *root,
-				  const char *base, u64 root_objectid,
-				  bool convert)
-{
-	struct btrfs_trans_handle *trans;
-	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_root *tree_root = fs_info->tree_root;
-	struct btrfs_root *new_root = NULL;
-	struct btrfs_path path = { 0 };
-	struct btrfs_inode_item *inode_item;
-	struct extent_buffer *leaf;
-	struct btrfs_key key;
-	u64 dirid = btrfs_root_dirid(&root->root_item);
-	u64 index = 2;
-	char buf[BTRFS_NAME_LEN + 1]; /* for snprintf null */
-	int len;
-	int i;
-	int ret;
-
-	len = strlen(base);
-	if (len == 0 || len > BTRFS_NAME_LEN)
-		return NULL;
-
-	key.objectid = dirid;
-	key.type = BTRFS_DIR_INDEX_KEY;
-	key.offset = (u64)-1;
-
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-	if (ret <= 0) {
-		error("search for DIR_INDEX dirid %llu failed: %d",
-				(unsigned long long)dirid, ret);
-		goto fail;
-	}
-
-	if (path.slots[0] > 0) {
-		path.slots[0]--;
-		btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
-		if (key.objectid == dirid && key.type == BTRFS_DIR_INDEX_KEY)
-			index = key.offset + 1;
-	}
-	btrfs_release_path(&path);
-
-	trans = btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		errno = -ret;
-		error_msg(ERROR_MSG_START_TRANS, "%m");
-		goto fail;
-	}
-
-	key.objectid = dirid;
-	key.offset = 0;
-	key.type =  BTRFS_INODE_ITEM_KEY;
-
-	ret = btrfs_lookup_inode(trans, root, &path, &key, 1);
-	if (ret) {
-		error("search for INODE_ITEM %llu failed: %d",
-				(unsigned long long)dirid, ret);
-		goto fail;
-	}
-	leaf = path.nodes[0];
-	inode_item = btrfs_item_ptr(leaf, path.slots[0],
-				    struct btrfs_inode_item);
-
-	key.objectid = root_objectid;
-	key.offset = (u64)-1;
-	key.type = BTRFS_ROOT_ITEM_KEY;
-
-	memcpy(buf, base, len);
-	if (convert) {
-		for (i = 0; i < 1024; i++) {
-			ret = btrfs_insert_dir_item(trans, root, buf, len,
-					dirid, &key, BTRFS_FT_DIR, index);
-			if (ret != -EEXIST)
-				break;
-			len = snprintf(buf, ARRAY_SIZE(buf), "%s%d", base, i);
-			if (len < 1 || len > BTRFS_NAME_LEN) {
-				ret = -EINVAL;
-				break;
-			}
-		}
-	} else {
-		ret = btrfs_insert_dir_item(trans, root, buf, len, dirid, &key,
-					    BTRFS_FT_DIR, index);
-	}
-	if (ret)
-		goto fail;
-
-	btrfs_set_inode_size(leaf, inode_item, len * 2 +
-			     btrfs_inode_size(leaf, inode_item));
-	btrfs_mark_buffer_dirty(leaf);
-	btrfs_release_path(&path);
-
-	/* add the backref first */
-	ret = btrfs_add_root_ref(trans, tree_root, root_objectid,
-				 BTRFS_ROOT_BACKREF_KEY,
-				 root->root_key.objectid,
-				 dirid, index, buf, len);
-	if (ret) {
-		error("unable to add root backref for %llu: %d",
-				root->root_key.objectid, ret);
-		goto fail;
-	}
-
-	/* now add the forward ref */
-	ret = btrfs_add_root_ref(trans, tree_root, root->root_key.objectid,
-				 BTRFS_ROOT_REF_KEY, root_objectid,
-				 dirid, index, buf, len);
-	if (ret) {
-		error("unable to add root ref for %llu: %d",
-				root->root_key.objectid, ret);
-		goto fail;
-	}
-
-	ret = btrfs_commit_transaction(trans, root);
-	if (ret) {
-		errno = -ret;
-		error_msg(ERROR_MSG_COMMIT_TRANS, "%m");
-		goto fail;
-	}
-
-	new_root = btrfs_read_fs_root(fs_info, &key);
-	if (IS_ERR(new_root)) {
-		error("unable to fs read root: %lu", PTR_ERR(new_root));
-		new_root = NULL;
-	}
-fail:
-	return new_root;
-}
-
 /*
  * Walk the tree of allocated inodes and find a hole.
  */
-- 
2.42.0

