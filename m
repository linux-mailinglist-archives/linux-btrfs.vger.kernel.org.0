Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE187D04CD
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Oct 2023 00:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjJSWag (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Oct 2023 18:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbjJSWaf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Oct 2023 18:30:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4776D126
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 15:30:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DE94A1FD7F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697754628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jblBmF/jyUuUDcw34EFfmbsBl/Nn1fL64HYawYeckII=;
        b=rN7GZhZmHX9h/i1ucwWAF7JkVxfEolF69WcvYp0smKV6ZX+3TvhmqUxEoSTZejcjshE7XW
        phc40TIxL0aYRLkOCoZsJQboee1wNSLYvAdn8goR0ItsDrch6CngrqGxr2iqdWRjKLQkNs
        EQEgDBlOFLfBGzr0goRizSWqbPJJ9rc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 15A7F1357F
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aGE3MQOuMWXzWgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Oct 2023 22:30:27 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/9] btrfs-progs: cross-port fs_types from kernel
Date:   Fri, 20 Oct 2023 09:00:00 +1030
Message-ID: <503e70dd59a9242380fd615e3fb950e56795427d.1697754500.git.wqu@suse.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs-progs we're using imode_to_type() and btrfs_type_to_imode() to
convert between the inode mode bits to filetype used in
DIR_ITEM/DIR_ENTRY.

However all BTRFS_FT_* are using the same bits of FT_*, and in kernel
we're utilizing this feature, thus to convert from imode to BTRFS_FT_*,
we just use btrfs_inode_type() which calls fs_umode_to_ftype().

To sync the code, this patch would:

- Cross-port fs_types.[ch] from kernel
  For the ecisting fs_umode_to_ftype() it's direct code copy.
  And those synced code would be in kernel-shared/, thus callers
  out of check/ directory can also utilize them.

- Introduce new fs_ftype_to_umode() helper
  Unlike kernel which can always grab inode->i_mode, here in progs we
  needs to convert ftype back to umode for DIR_ITEM/DIR_INDEX
  verification.

- Remove the btrfs-progs specific helpers
  This includes:
  * imode_ty_type()
    Replaced by fs_umode_to_ftype().

  * btrfs_type_to_imode()
    Replaced by fs_ftype_to_umode().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 Makefile                 |  1 +
 check/main.c             | 12 +++---
 check/mode-common.c      |  4 +-
 check/mode-common.h      | 32 ---------------
 check/mode-lowmem.c      | 22 +++++-----
 include/kerncompat.h     |  1 +
 kernel-shared/ctree.h    |  6 +++
 kernel-shared/fs_types.c | 62 ++++++++++++++++++++++++++++
 kernel-shared/fs_types.h | 87 ++++++++++++++++++++++++++++++++++++++++
 kernel-shared/inode.c    | 10 +++++
 10 files changed, 186 insertions(+), 51 deletions(-)
 create mode 100644 kernel-shared/fs_types.c
 create mode 100644 kernel-shared/fs_types.h

diff --git a/Makefile b/Makefile
index 725e5caa88bd..273a1f0e3b7c 100644
--- a/Makefile
+++ b/Makefile
@@ -183,6 +183,7 @@ objects = \
 	kernel-shared/extent_io.o	\
 	kernel-shared/file-item.o	\
 	kernel-shared/file.o	\
+	kernel-shared/fs_types.o	\
 	kernel-shared/free-space-cache.o	\
 	kernel-shared/free-space-tree.o	\
 	kernel-shared/inode-item.o	\
diff --git a/check/main.c b/check/main.c
index 6cf8016670f4..8dfb6ba2a8e8 100644
--- a/check/main.c
+++ b/check/main.c
@@ -835,7 +835,7 @@ static void maybe_free_inode_rec(struct cache_tree *inode_cache,
 	if (!rec->found_inode_item)
 		return;
 
-	filetype = imode_to_type(rec->imode);
+	filetype = btrfs_inode_type(rec->imode);
 	list_for_each_entry_safe(backref, tmp, &rec->backrefs, list) {
 		if (backref->found_dir_item && backref->found_dir_index) {
 			if (backref->filetype != filetype)
@@ -2142,7 +2142,7 @@ static int add_missing_dir_index(struct btrfs_root *root,
 	disk_key.offset = 0;
 
 	btrfs_set_dir_item_key(leaf, dir_item, &disk_key);
-	btrfs_set_dir_flags(leaf, dir_item, imode_to_type(rec->imode));
+	btrfs_set_dir_flags(leaf, dir_item, btrfs_inode_type(rec->imode));
 	btrfs_set_dir_data_len(leaf, dir_item, 0);
 	btrfs_set_dir_name_len(leaf, dir_item, backref->namelen);
 	name_ptr = (unsigned long)(dir_item + 1);
@@ -2329,7 +2329,7 @@ static int repair_inode_backrefs(struct btrfs_root *root,
 			ret = btrfs_insert_dir_item(trans, root, backref->name,
 						    backref->namelen,
 						    backref->dir, &location,
-						    imode_to_type(rec->imode),
+						    btrfs_inode_type(rec->imode),
 						    backref->index);
 			BUG_ON(ret);
 			btrfs_commit_transaction(trans, root);
@@ -2363,7 +2363,7 @@ static int find_file_type(struct inode_record *rec, u8 *type)
 
 	/* For inode item recovered case */
 	if (rec->found_inode_item) {
-		*type = imode_to_type(rec->imode);
+		*type = btrfs_inode_type(rec->imode);
 		return 0;
 	}
 
@@ -2622,7 +2622,7 @@ static int repair_inode_no_item(struct btrfs_trans_handle *trans,
 	}
 
 	ret = btrfs_new_inode(trans, root, rec->ino,
-			      mode | btrfs_type_to_imode(filetype));
+			      mode | fs_ftype_to_umode(filetype));
 	if (ret < 0)
 		goto out;
 
@@ -2634,7 +2634,7 @@ static int repair_inode_no_item(struct btrfs_trans_handle *trans,
 	 * We just fill the record and return
 	 */
 	rec->found_dir_item = 1;
-	rec->imode = mode | btrfs_type_to_imode(filetype);
+	rec->imode = mode | fs_ftype_to_umode(filetype);
 	rec->nlink = 0;
 	rec->errors &= ~I_ERR_NO_INODE_ITEM;
 	/* Ensure the inode_nlinks repair function will be called */
diff --git a/check/mode-common.c b/check/mode-common.c
index 7afd9ed96fd2..34e5267bfd8c 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -773,7 +773,7 @@ static int find_file_type_dir_index(struct btrfs_root *root, u64 ino, u64 dirid,
 	if (name_len != len || memcmp(namebuf, name, len))
 		goto out;
 	found = true;
-	*imode_ret = btrfs_type_to_imode(filetype);
+	*imode_ret = fs_ftype_to_umode(filetype);
 out:
 	btrfs_release_path(&path);
 	if (!found && !ret)
@@ -832,7 +832,7 @@ static int find_file_type_dir_item(struct btrfs_root *root, u64 ino, u64 dirid,
 				   (unsigned long)(di + 1), len);
 		if (name_len != len || memcmp(namebuf, name, len))
 			continue;
-		*imode_ret = btrfs_type_to_imode(filetype);
+		*imode_ret = fs_ftype_to_umode(filetype);
 		found = true;
 		goto out;
 	}
diff --git a/check/mode-common.h b/check/mode-common.h
index 894bbbb8141b..83296baf4a99 100644
--- a/check/mode-common.h
+++ b/check/mode-common.h
@@ -86,23 +86,6 @@ extern int check_data_csum;
 extern struct btrfs_fs_info *gfs_info;
 extern struct cache_tree *roots_info_cache;
 
-static inline u8 imode_to_type(u32 imode)
-{
-#define S_SHIFT 12
-	static unsigned char btrfs_type_by_mode[S_IFMT >> S_SHIFT] = {
-		[S_IFREG >> S_SHIFT]	= BTRFS_FT_REG_FILE,
-		[S_IFDIR >> S_SHIFT]	= BTRFS_FT_DIR,
-		[S_IFCHR >> S_SHIFT]	= BTRFS_FT_CHRDEV,
-		[S_IFBLK >> S_SHIFT]	= BTRFS_FT_BLKDEV,
-		[S_IFIFO >> S_SHIFT]	= BTRFS_FT_FIFO,
-		[S_IFSOCK >> S_SHIFT]	= BTRFS_FT_SOCK,
-		[S_IFLNK >> S_SHIFT]	= BTRFS_FT_SYMLINK,
-	};
-
-	return btrfs_type_by_mode[(imode & S_IFMT) >> S_SHIFT];
-#undef S_SHIFT
-}
-
 static inline bool fs_root_objectid(u64 objectid)
 {
 	if (objectid == BTRFS_TREE_RELOC_OBJECTID ||
@@ -167,21 +150,6 @@ static inline bool is_valid_imode(u32 imode)
 
 int recow_extent_buffer(struct btrfs_root *root, struct extent_buffer *eb);
 
-static inline u32 btrfs_type_to_imode(u8 type)
-{
-	static u32 imode_by_btrfs_type[] = {
-		[BTRFS_FT_REG_FILE]	= S_IFREG,
-		[BTRFS_FT_DIR]		= S_IFDIR,
-		[BTRFS_FT_CHRDEV]	= S_IFCHR,
-		[BTRFS_FT_BLKDEV]	= S_IFBLK,
-		[BTRFS_FT_FIFO]		= S_IFIFO,
-		[BTRFS_FT_SOCK]		= S_IFSOCK,
-		[BTRFS_FT_SYMLINK]	= S_IFLNK,
-	};
-
-	return imode_by_btrfs_type[(type)];
-}
-
 int get_extent_item_generation(u64 bytenr, u64 *gen_ret);
 
 /*
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 3b2807cc5de9..dd05fa47384f 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -1200,19 +1200,19 @@ next:
 	key.type = BTRFS_DIR_INDEX_KEY;
 	key.offset = index;
 	tmp_err |= find_dir_item(root, &key, &location, namebuf, len,
-			    imode_to_type(mode));
+				btrfs_inode_type(mode));
 
 	/* Find related dir_item */
 	key.objectid = ref_key->offset;
 	key.type = BTRFS_DIR_ITEM_KEY;
 	key.offset = btrfs_name_hash(namebuf, len);
 	tmp_err |= find_dir_item(root, &key, &location, namebuf, len,
-			    imode_to_type(mode));
+				 btrfs_inode_type(mode));
 end:
 	if (tmp_err && opt_check_repair) {
 		ret = repair_ternary_lowmem(root, ref_key->offset,
 					    ref_key->objectid, index, namebuf,
-					    name_len, imode_to_type(mode),
+					    name_len, btrfs_inode_type(mode),
 					    tmp_err);
 		if (!ret) {
 			need_research = 1;
@@ -1220,7 +1220,7 @@ end:
 		}
 	}
 	print_inode_ref_err(root, ref_key, index, namebuf, name_len,
-			    imode_to_type(mode), tmp_err);
+			    btrfs_inode_type(mode), tmp_err);
 	err |= tmp_err;
 	len = sizeof(*ref) + name_len;
 	ref = (struct btrfs_inode_ref *)((char *)ref + len);
@@ -1782,7 +1782,7 @@ begin:
 		ii = btrfs_item_ptr(path->nodes[0], path->slots[0],
 				    struct btrfs_inode_item);
 		mode = btrfs_inode_mode(path->nodes[0], ii);
-		if (imode_to_type(mode) != filetype) {
+		if (btrfs_inode_type(mode) != filetype) {
 			tmp_err |= INODE_ITEM_MISMATCH;
 			goto next;
 		}
@@ -1813,7 +1813,7 @@ next:
 		if (tmp_err && opt_check_repair) {
 			ret = repair_dir_item(root, di_key,
 					      location.objectid, index,
-					      imode_to_type(mode), namebuf,
+					      btrfs_inode_type(mode), namebuf,
 					      name_len, tmp_err);
 			if (ret != tmp_err) {
 				need_research = 1;
@@ -2635,7 +2635,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 	nbytes = btrfs_inode_nbytes(node, ii);
 	mode = btrfs_inode_mode(node, ii);
 	flags = btrfs_inode_flags(node, ii);
-	dir = imode_to_type(mode) == BTRFS_FT_DIR;
+	dir = btrfs_inode_type(mode) == BTRFS_FT_DIR;
 	nlink = btrfs_inode_nlink(node, ii);
 	generation = btrfs_inode_generation(node, ii);
 	transid = btrfs_inode_transid(node, ii);
@@ -2729,7 +2729,7 @@ static int check_inode_item(struct btrfs_root *root, struct btrfs_path *path)
 			if (!dir) {
 				warning("root %llu INODE[%llu] mode %u shouldn't have DIR_INDEX[%llu %llu]",
 					root->objectid,	inode_id,
-					imode_to_type(mode), key.objectid,
+					btrfs_inode_type(mode), key.objectid,
 					key.offset);
 			}
 			if (is_orphan && key.type == BTRFS_DIR_INDEX_KEY)
@@ -2772,7 +2772,7 @@ out:
 
 		if ((nlink != 1 || refs != 1) && opt_check_repair) {
 			ret = repair_inode_nlinks_lowmem(root, path, inode_id,
-				namebuf, name_len, refs, imode_to_type(mode),
+				namebuf, name_len, refs, btrfs_inode_type(mode),
 				&nlink);
 		}
 
@@ -2808,7 +2808,7 @@ out:
 			if (opt_check_repair)
 				ret = repair_inode_nlinks_lowmem(root, path,
 					 inode_id, namebuf, name_len, refs,
-					 imode_to_type(mode), &nlink);
+					 btrfs_inode_type(mode), &nlink);
 			if (!opt_check_repair || ret) {
 				err |= LINK_COUNT_ERROR;
 				error(
@@ -5192,7 +5192,7 @@ static int check_fs_first_inode(struct btrfs_root *root)
 		ii = btrfs_item_ptr(path.nodes[0], path.slots[0],
 				    struct btrfs_inode_item);
 		mode = btrfs_inode_mode(path.nodes[0], ii);
-		if (imode_to_type(mode) != BTRFS_FT_DIR)
+		if (btrfs_inode_type(mode) != BTRFS_FT_DIR)
 			err |= INODE_ITEM_MISMATCH;
 	}
 
diff --git a/include/kerncompat.h b/include/kerncompat.h
index 18b474f6aa41..a7b075a4ff80 100644
--- a/include/kerncompat.h
+++ b/include/kerncompat.h
@@ -179,6 +179,7 @@ typedef long long s64;
 typedef int s32;
 #endif
 
+typedef unsigned short umode_t;
 typedef u64 sector_t;
 
 struct vma_shared { int prio_tree_node; };
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index bcf11d870061..2df8166970be 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -31,6 +31,7 @@
 #include "kernel-shared/accessors.h"
 #include "kernel-shared/extent-io-tree.h"
 #include "kernel-shared/locking.h"
+#include "kernel-shared/fs_types.h"
 #include "crypto/crc32c.h"
 #include "common/extent-cache.h"
 
@@ -1213,6 +1214,11 @@ static inline int is_fstree(u64 rootid)
 void btrfs_uuid_to_key(const u8 *uuid, struct btrfs_key *key);
 
 /* inode.c */
+static inline u8 btrfs_inode_type(u32 inode_mode)
+{
+	return fs_umode_to_ftype(inode_mode);
+}
+
 int check_dir_conflict(struct btrfs_root *root, char *name, int namelen,
 		u64 dir, u64 index);
 int btrfs_new_inode(struct btrfs_trans_handle *trans, struct btrfs_root *root,
diff --git a/kernel-shared/fs_types.c b/kernel-shared/fs_types.c
new file mode 100644
index 000000000000..193d7ee80d93
--- /dev/null
+++ b/kernel-shared/fs_types.c
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Cross-ported from kernel fs/fs_types.c, with the following changes:
+ *
+ * - Add new ftype to imode converter.
+ *   This is btrfs-progs specific, as in kernel we always have a inode
+ *   to grab it's mode.
+ *   But in progs we need do convert from umode to ftype for verification.
+ */
+
+#include "kernel-shared/fs_types.h"
+
+/*
+ * dirent file type to fs on-disk file type conversion
+ * Values not initialized explicitly are FT_UNKNOWN (0).
+ */
+static const unsigned char fs_ftype_by_dtype[DT_MAX] = {
+	[DT_REG]	= FT_REG_FILE,
+	[DT_DIR]	= FT_DIR,
+	[DT_LNK]	= FT_SYMLINK,
+	[DT_CHR]	= FT_CHRDEV,
+	[DT_BLK]	= FT_BLKDEV,
+	[DT_FIFO]	= FT_FIFO,
+	[DT_SOCK]	= FT_SOCK,
+};
+
+/**
+ * fs_umode_to_ftype() - file mode to on-disk file type.
+ * @mode: The file mode to convert.
+ *
+ * This function converts the file mode value to the on-disk file type (FT_*).
+ *
+ * Context: Any context.
+ * Return:
+ * * FT_UNKNOWN		- Unknown type
+ * * FT_REG_FILE	- Regular file
+ * * FT_DIR		- Directory
+ * * FT_CHRDEV		- Character device
+ * * FT_BLKDEV		- Block device
+ * * FT_FIFO		- FIFO
+ * * FT_SOCK		- Local-domain socket
+ * * FT_SYMLINK		- Symbolic link
+ */
+unsigned char fs_umode_to_ftype(umode_t mode)
+{
+	return fs_ftype_by_dtype[S_DT(mode)];
+}
+
+umode_t fs_ftype_to_umode(unsigned char ftype)
+{
+	static u32 imode_by_ftype[] = {
+		[FT_REG_FILE]     = S_IFREG,
+		[FT_DIR]          = S_IFDIR,
+		[FT_CHRDEV]       = S_IFCHR,
+		[FT_BLKDEV]       = S_IFBLK,
+		[FT_FIFO]         = S_IFIFO,
+		[FT_SOCK]         = S_IFSOCK,
+		[FT_SYMLINK]      = S_IFLNK,
+       };
+       return imode_by_ftype[(ftype)];
+}
diff --git a/kernel-shared/fs_types.h b/kernel-shared/fs_types.h
new file mode 100644
index 000000000000..bdac8318413b
--- /dev/null
+++ b/kernel-shared/fs_types.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FS_TYPES_H
+#define _LINUX_FS_TYPES_H
+
+#include <dirent.h>
+#include <sys/stat.h>
+#include "kerncompat.h"
+
+/*
+ * This is cross-ported from kernel include/linux/fs_types.h, changes are:
+ *
+ * - New ftype to umode convertor
+ * - Use glibc's dirent.h to replace the DT_* declarations
+ */
+
+/*
+ * This is a header for the common implementation of dirent
+ * to fs on-disk file type conversion.  Although the fs on-disk
+ * bits are specific to every file system, in practice, many
+ * file systems use the exact same on-disk format to describe
+ * the lower 3 file type bits that represent the 7 POSIX file
+ * types.
+ *
+ * It is important to note that the definitions in this
+ * header MUST NOT change. This would break both the
+ * userspace ABI and the on-disk format of filesystems
+ * using this code.
+ *
+ * All those file systems can use this generic code for the
+ * conversions.
+ */
+
+/*
+ * struct dirent file types
+ * exposed to user via getdents(2), readdir(3)
+ *
+ * These match bits 12..15 of stat.st_mode
+ * (ie "(i_mode >> 12) & 15").
+ */
+#define S_DT_SHIFT	12
+#define S_DT(mode)	(((mode) & S_IFMT) >> S_DT_SHIFT)
+#define S_DT_MASK	(S_IFMT >> S_DT_SHIFT)
+
+/* these are defined by POSIX and also present in glibc's dirent.h */
+/*
+#define DT_UNKNOWN	0
+#define DT_FIFO		1
+#define DT_CHR		2
+#define DT_DIR		4
+#define DT_BLK		6
+#define DT_REG		8
+#define DT_LNK		10
+#define DT_SOCK		12
+#define DT_WHT		14
+*/
+
+#define DT_MAX		(S_DT_MASK + 1) /* 16 */
+
+/*
+ * fs on-disk file types.
+ * Only the low 3 bits are used for the POSIX file types.
+ * Other bits are reserved for fs private use.
+ * These definitions are shared and used by multiple filesystems,
+ * and MUST NOT change under any circumstances.
+ *
+ * Note that no fs currently stores the whiteout type on-disk,
+ * so whiteout dirents are exposed to user as DT_CHR.
+ */
+#define FT_UNKNOWN	0
+#define FT_REG_FILE	1
+#define FT_DIR		2
+#define FT_CHRDEV	3
+#define FT_BLKDEV	4
+#define FT_FIFO		5
+#define FT_SOCK		6
+#define FT_SYMLINK	7
+
+#define FT_MAX		8
+
+/*
+ * declarations for helper functions, accompanying implementation
+ * is in fs/fs_types.c
+ */
+extern unsigned char fs_umode_to_ftype(umode_t mode);
+extern umode_t fs_ftype_to_umode(unsigned char ftype);
+
+#endif
diff --git a/kernel-shared/inode.c b/kernel-shared/inode.c
index 3d420787c8f9..1893e48001af 100644
--- a/kernel-shared/inode.c
+++ b/kernel-shared/inode.c
@@ -33,9 +33,19 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-shared/transaction.h"
 #include "kernel-shared/disk-io.h"
+#include "kernel-shared/fs_types.h"
 #include "common/messages.h"
 #include "common/internal.h"
 
+static_assert(BTRFS_FT_UNKNOWN == FT_UNKNOWN);
+static_assert(BTRFS_FT_REG_FILE == FT_REG_FILE);
+static_assert(BTRFS_FT_DIR == FT_DIR);
+static_assert(BTRFS_FT_CHRDEV == FT_CHRDEV);
+static_assert(BTRFS_FT_BLKDEV == FT_BLKDEV);
+static_assert(BTRFS_FT_FIFO == FT_FIFO);
+static_assert(BTRFS_FT_SOCK == FT_SOCK);
+static_assert(BTRFS_FT_SYMLINK == FT_SYMLINK);
+
 /*
  * Find a free inode index for later btrfs_add_link().
  * Currently just search from the largest dir_index and +1.
-- 
2.42.0

