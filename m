Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7E5971A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240291AbiHQOnr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240064AbiHQOnf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 10:43:35 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFA7481D4
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 07:43:33 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id A950580AA3;
        Wed, 17 Aug 2022 10:43:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1660747413; bh=OlnKPN9LLQ9IY/vPCiLjGyKlC424CDRyh1yCjVFkbKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOvt6U96igHqRa4gqDbqa0HsJyzjpC4JZRVx/TE19I/vRqDdG7wQzF9/w1N1alGHy
         rR1XytnbWg1w1sdpAKO1VstJWk+m/M7TXgx8qKLgeIyBydqFKhP047s3VMp/P9oQVY
         2YvBVKbrZu+oRj0AmQs2zGmACEZBFrQlpWGVp5kJBezHTQDlZ+jJlZqn+mgv4SdQoV
         ZUcZ3JwVcbdr7yem/Z84wbAA0Vzo2svMsWU86e5L6KPh0gBsDseQYs7lyTNPJYbMHg
         3nGCiHPOcPvHxu71Fz4mb8GReCROq5MlA4LWK+Xq7DOx5El9BnAThu4ZTXhKPvubQ9
         5PLxRlrTx8Vyw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH 2/6] btrfs-progs: adjust for new dir flag.
Date:   Wed, 17 Aug 2022 10:42:55 -0400
Message-Id: <4b01dda0d398550f76647a16ed3c146d8f7c2e17.1660729916.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1660729916.git.sweettea-kernel@dorminy.me>
References: <cover.1660729916.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The advent of encryption necessitates converting the directory type into
a directory type and a flag indicating encryption. Thus, rename the
field dir_type to dir_flags. For those uses which don't care about
encryption and just want to know what type the directory is, a new
helper is added to strip the encryption flag. This renaming, and use of
the helper where appropriate, is reflected throughout the codebase.

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 check/main.c               |  4 ++--
 check/mode-common.c        |  4 ++--
 check/mode-lowmem.c        |  6 +++---
 cmds/restore.c             |  2 +-
 kernel-shared/ctree.h      | 18 ++++++++++++++++--
 kernel-shared/dir-item.c   |  8 ++++----
 kernel-shared/inode.c      |  4 +++-
 kernel-shared/print-tree.c |  2 +-
 libbtrfsutil/btrfs_tree.h  |  3 +++
 9 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/check/main.c b/check/main.c
index 0ba38f73..790b091d 100644
--- a/check/main.c
+++ b/check/main.c
@@ -1418,7 +1418,7 @@ static int process_dir_item(struct extent_buffer *eb,
 		btrfs_dir_item_key_to_cpu(eb, di, &location);
 		name_len = btrfs_dir_name_len(eb, di);
 		data_len = btrfs_dir_data_len(eb, di);
-		filetype = btrfs_dir_type(eb, di);
+		filetype = btrfs_dir_flags_to_ftype(btrfs_dir_flags(eb, di));
 
 		rec->found_size += name_len;
 		if (cur + sizeof(*di) + name_len > total ||
@@ -2122,7 +2122,7 @@ static int add_missing_dir_index(struct btrfs_root *root,
 	disk_key.offset = 0;
 
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, imode_to_type(rec->imode));
+	btrfs_set_dir_flags(leaf, dir_item, imode_to_type(rec->imode));
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, backref->namelen);
 	name_ptr = (unsigned long)(dir_item + 1);
diff --git a/check/mode-common.c b/check/mode-common.c
index b867c350..0c5c7d6d 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -754,7 +754,7 @@ static int find_file_type_dir_index(struct btrfs_root *root, u64 ino, u64 dirid,
 	if (location.objectid != ino || location.type != BTRFS_INODE_ITEM_KEY ||
 	    location.offset != 0)
 		goto out;
-	filetype = btrfs_dir_type(path.nodes[0], di);
+	filetype = btrfs_dir_flags_to_ftype(btrfs_dir_flags(path.nodes[0], di));
 	if (filetype >= BTRFS_FT_MAX || filetype == BTRFS_FT_UNKNOWN)
 		goto out;
 	len = min_t(u32, BTRFS_NAME_LEN,
@@ -813,7 +813,7 @@ static int find_file_type_dir_item(struct btrfs_root *root, u64 ino, u64 dirid,
 		    location.type != BTRFS_INODE_ITEM_KEY ||
 		    location.offset != 0)
 			continue;
-		filetype = btrfs_dir_type(path.nodes[0], di);
+		filetype = btrfs_dir_flags_to_ftype(btrfs_dir_flags(path.nodes[0], di));
 		if (filetype >= BTRFS_FT_MAX || filetype == BTRFS_FT_UNKNOWN)
 			continue;
 		len = min_t(u32, BTRFS_NAME_LEN,
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index fa324506..920358d8 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -856,7 +856,7 @@ loop:
 		    location.offset != 0)
 			goto next;
 
-		filetype = btrfs_dir_type(node, di);
+		filetype = btrfs_dir_flags_to_ftype(btrfs_dir_flags(node, di));
 		if (file_type != filetype)
 			goto next;
 
@@ -954,7 +954,7 @@ static int find_dir_item(struct btrfs_root *root, struct btrfs_key *key,
 		    location.offset != location_key->offset)
 			goto next;
 
-		filetype = btrfs_dir_type(node, di);
+		filetype = btrfs_dir_flags_to_ftype(btrfs_dir_flags(node, di));
 		if (file_type != filetype)
 			goto next;
 
@@ -1744,7 +1744,7 @@ begin:
 		(*size) += name_len;
 		read_extent_buffer(node, namebuf, (unsigned long)(di + 1),
 				   len);
-		filetype = btrfs_dir_type(node, di);
+		filetype = btrfs_dir_flags_to_ftype(btrfs_dir_flags(node, di));
 
 		if (di_key->type == BTRFS_DIR_ITEM_KEY &&
 		    di_key->offset != btrfs_name_hash(namebuf, len)) {
diff --git a/cmds/restore.c b/cmds/restore.c
index b517c30c..84cc0724 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -991,7 +991,7 @@ static int search_dir(struct btrfs_root *root, struct btrfs_key *key,
 		name_len = btrfs_dir_name_len(leaf, dir_item);
 		read_extent_buffer(leaf, filename, name_ptr, name_len);
 		filename[name_len] = '\0';
-		type = btrfs_dir_type(leaf, dir_item);
+		type = btrfs_dir_flags_to_ftype(btrfs_dir_flags(leaf, dir_item));
 		btrfs_dir_item_key_to_cpu(leaf, dir_item, &location);
 
 		/* full path from root of btrfs being restored */
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 6e5bf74b..bbb4b534 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -176,6 +176,14 @@ enum btrfs_csum_type {
 #define BTRFS_FT_XATTR		8
 #define BTRFS_FT_MAX		9
 
+/* Name is encrypted */
+#define BTRFS_FT_FSCRYPT_NAME	0x80
+
+static inline __u8 btrfs_dir_flags_to_ftype(__u8 flags)
+{
+	return flags & ~BTRFS_FT_FSCRYPT_NAME;
+}
+
 #define BTRFS_ROOT_SUBVOL_RDONLY	(1ULL << 0)
 
 /*
@@ -2039,15 +2047,21 @@ BTRFS_SETGET_STACK_FUNCS(stack_root_ref_name_len, struct btrfs_root_ref, name_le
 
 /* struct btrfs_dir_item */
 BTRFS_SETGET_FUNCS(dir_data_len, struct btrfs_dir_item, data_len, 16);
-BTRFS_SETGET_FUNCS(dir_type, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_FUNCS(dir_flags, struct btrfs_dir_item, type, 8);
 BTRFS_SETGET_FUNCS(dir_name_len, struct btrfs_dir_item, name_len, 16);
 BTRFS_SETGET_FUNCS(dir_transid, struct btrfs_dir_item, transid, 64);
 
 BTRFS_SETGET_STACK_FUNCS(stack_dir_data_len, struct btrfs_dir_item, data_len, 16);
-BTRFS_SETGET_STACK_FUNCS(stack_dir_type, struct btrfs_dir_item, type, 8);
+BTRFS_SETGET_STACK_FUNCS(stack_dir_flags, struct btrfs_dir_item, type, 8);
 BTRFS_SETGET_STACK_FUNCS(stack_dir_name_len, struct btrfs_dir_item, name_len, 16);
 BTRFS_SETGET_STACK_FUNCS(stack_dir_transid, struct btrfs_dir_item, transid, 64);
 
+static inline __u8 btrfs_dir_ftype(const struct extent_buffer *eb,
+				 const struct btrfs_dir_item *item)
+{
+	return btrfs_dir_flags_to_ftype(btrfs_dir_flags(eb, item));
+}
+
 static inline void btrfs_dir_item_key(struct extent_buffer *eb,
 				      struct btrfs_dir_item *item,
 				      struct btrfs_disk_key *key)
diff --git a/kernel-shared/dir-item.c b/kernel-shared/dir-item.c
index 27dfb362..27cf459d 100644
--- a/kernel-shared/dir-item.c
+++ b/kernel-shared/dir-item.c
@@ -89,7 +89,7 @@ int btrfs_insert_xattr_item(struct btrfs_trans_handle *trans,
 	leaf = path->nodes[0];
 	btrfs_cpu_key_to_disk(&disk_key, &location);
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, BTRFS_FT_XATTR);
+	btrfs_set_dir_flags(leaf, dir_item, BTRFS_FT_XATTR);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
 	btrfs_set_dir_data_len(leaf, dir_item, data_len);
 	name_ptr = (unsigned long)(dir_item + 1);
@@ -141,7 +141,7 @@ int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, struct btrfs_root
 	leaf = path->nodes[0];
 	btrfs_cpu_key_to_disk(&disk_key, location);
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, type);
+	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
 	name_ptr = (unsigned long)(dir_item + 1);
@@ -170,7 +170,7 @@ insert:
 	leaf = path->nodes[0];
 	btrfs_cpu_key_to_disk(&disk_key, location);
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_type(leaf, dir_item, type);
+	btrfs_set_dir_flags(leaf, dir_item, type);
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, name_len);
 	name_ptr = (unsigned long)(dir_item + 1);
@@ -292,7 +292,7 @@ static int verify_dir_item(struct btrfs_root *root,
 		    struct btrfs_dir_item *dir_item)
 {
 	u16 namelen = BTRFS_NAME_LEN;
-	u8 type = btrfs_dir_type(leaf, dir_item);
+	u8 type = btrfs_dir_flags_to_ftype(btrfs_dir_flags(leaf, dir_item));
 
 	if (type == BTRFS_FT_XATTR)
 		namelen = XATTR_NAME_MAX;
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 8dfe5b0d..66c16a98 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -541,6 +541,7 @@ int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 
 	if (dir_item) {
 		struct btrfs_key found_key;
+		u8 type;
 
 		/*
 		 * Already have conflicting name, check if it is a dir.
@@ -548,7 +549,8 @@ int btrfs_mkdir(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		 */
 		btrfs_dir_item_key_to_cpu(path->nodes[0], dir_item, &found_key);
 		ret_ino = found_key.objectid;
-		if (btrfs_dir_type(path->nodes[0], dir_item) != BTRFS_FT_DIR)
+		type = btrfs_dir_flags_to_ftype(btrfs_dir_flags(path->nodes[0], dir_item));
+		if (type != BTRFS_FT_DIR)
 			ret = -EEXIST;
 		goto out;
 	}
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 24163258..3b1c2d4d 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -31,7 +31,7 @@
 static void print_dir_item_type(struct extent_buffer *eb,
                                 struct btrfs_dir_item *di)
 {
-	u8 type = btrfs_dir_type(eb, di);
+	u8 type = btrfs_dir_flags_to_ftype(btrfs_dir_flags(eb, di));
 	static const char* dir_item_str[] = {
 		[BTRFS_FT_REG_FILE]	= "FILE",
 		[BTRFS_FT_DIR] 		= "DIR",
diff --git a/libbtrfsutil/btrfs_tree.h b/libbtrfsutil/btrfs_tree.h
index 1df9efd6..fbe25037 100644
--- a/libbtrfsutil/btrfs_tree.h
+++ b/libbtrfsutil/btrfs_tree.h
@@ -322,6 +322,9 @@
 #define BTRFS_FT_XATTR		8
 #define BTRFS_FT_MAX		9
 
+/* Name is encrypted */
+#define BTRFS_FT_FSCRYPT_NAME	0x80
+
 /*
  * The key defines the order in the tree, and so it also defines (optimal)
  * block layout.
-- 
2.35.1

