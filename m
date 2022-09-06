Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658235ADC83
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Sep 2022 02:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbiIFAgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 5 Sep 2022 20:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiIFAgA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 5 Sep 2022 20:36:00 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A86A4BB;
        Mon,  5 Sep 2022 17:35:58 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 30CCC803C8;
        Mon,  5 Sep 2022 20:35:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1662424558; bh=bKQghyockW23MJt5AmVdKo0ILd5SU33XjJm9hP50Lcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W2aIypND8kYrF574nXvtLulEVfSpwbJ412NF/KFcXuD9eI+psge3UuoorwmpObMeF
         jidcD3d2a6edbevTYqNG0vhgXXQThC6LEHxMCcQemSQZykJYdgoV9BnwUvSwqh9159
         JuOqk1KC3l6jF/Sf97BbJW6XS0S05wYaUfLrAsGxn0exij8poUd5ygglA9kOE2zQwf
         dXrw9aR/z9mWR5pO7NEConIWH8R1GjTKZebZ6BAeCC1ev5Gysxdl3RdAeG5Jo7/RnG
         tikhYwtJAt4MxjYP8G2GvHq/UeT4AktnRPtnUQNZ7/81vTytvO/7V8aiUSaqKYuiFr
         G/XeutaH+2ygw==
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-fscrypt@vger.kernel.org,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Omar Sandoval <osandov@osandov.com>,
        Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: [PATCH v2 10/20] btrfs: factor a fscrypt_name matching method
Date:   Mon,  5 Sep 2022 20:35:25 -0400
Message-Id: <685c8abce7bdb110bc306752314b4fb0e7867290.1662420176.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1662420176.git.sweettea-kernel@dorminy.me>
References: <cover.1662420176.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Omar Sandoval <osandov@osandov.com>

Now that everything in btrfs is dealing in fscrypt_names, fscrypt has a
useful function, fscrypt_match_name(), to check whether a fscrypt_name
matches a provided buffer. However, btrfs buffers are struct
extent_buffer rather than a raw char array, so we need to implement our
own imitation of fscrypt_match_name() that deals in extent_buffers,
falling back to a simple memcpy if fscrypt isn't compiled. We
can then use this matching method in btrfs_match_dir_item_name() and
other locations.

This also provides a useful occasion to introduce the new fscrypt file
for btrfs, handling the fscrypt-specific functions needed.

Signed-off-by: Omar Sandoval <osandov@osandov.com>
Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/btrfs/Makefile     |  1 +
 fs/btrfs/dir-item.c   | 13 +++++++------
 fs/btrfs/extent_io.c  | 37 +++++++++++++++++++++++++++++++++++++
 fs/btrfs/extent_io.h  |  2 ++
 fs/btrfs/fscrypt.c    | 32 ++++++++++++++++++++++++++++++++
 fs/btrfs/fscrypt.h    | 25 +++++++++++++++++++++++++
 fs/btrfs/inode-item.c |  8 ++++----
 fs/btrfs/inode.c      | 11 ++++-------
 fs/btrfs/root-tree.c  |  7 ++++---
 9 files changed, 116 insertions(+), 20 deletions(-)
 create mode 100644 fs/btrfs/fscrypt.c
 create mode 100644 fs/btrfs/fscrypt.h

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 99f9995670ea..b6444490cdbc 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -38,6 +38,7 @@ btrfs-$(CONFIG_BTRFS_FS_CHECK_INTEGRITY) += check-integrity.o
 btrfs-$(CONFIG_BTRFS_FS_REF_VERIFY) += ref-verify.o
 btrfs-$(CONFIG_BLK_DEV_ZONED) += zoned.o
 btrfs-$(CONFIG_FS_VERITY) += verity.o
+btrfs-$(CONFIG_FS_ENCRYPTION) += fscrypt.o
 
 btrfs-$(CONFIG_BTRFS_FS_RUN_SANITY_TESTS) += tests/free-space-tests.o \
 	tests/extent-buffer-tests.o tests/btrfs-tests.o \
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index b4c1e2a40401..8d7c3c32ed8e 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -5,6 +5,7 @@
 
 #include "ctree.h"
 #include "disk-io.h"
+#include "fscrypt.h"
 #include "transaction.h"
 
 /*
@@ -390,15 +391,15 @@ struct btrfs_dir_item *btrfs_match_dir_item_name(struct btrfs_fs_info *fs_info,
 
 	total_len = btrfs_item_size(leaf, path->slots[0]);
 	while (cur < total_len) {
-		unsigned long name_ptr = (unsigned long)(dir_item + 1);
-		this_len = sizeof(*dir_item) +
-			btrfs_dir_name_len(leaf, dir_item) +
+		int dir_name_len = btrfs_dir_name_len(leaf, dir_item);
+		this_len = sizeof(*dir_item) + dir_name_len +
 			btrfs_dir_data_len(leaf, dir_item);
 
-		if (btrfs_dir_name_len(leaf, dir_item) == fname_len(fname) &&
-		    memcmp_extent_buffer(leaf, fname_name(fname), name_ptr,
-					 fname_len(fname)) == 0)
+		if (btrfs_fscrypt_match_name(fname, leaf,
+					     (unsigned long)(dir_item + 1),
+					     dir_name_len)) {
 			return dir_item;
+		}
 
 		cur += this_len;
 		dir_item = (struct btrfs_dir_item *)((char *)dir_item +
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 591c191a58bc..a467a7553bd9 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <crypto/sha2.h>
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/bio.h>
@@ -6892,6 +6893,42 @@ void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 	}
 }
 
+void extent_buffer_sha256(const struct extent_buffer *eb, unsigned long start,
+			  unsigned long len, u8 *out)
+{
+	size_t cur;
+	size_t offset;
+	struct page *page;
+	char *kaddr;
+	unsigned long i = get_eb_page_index(start);
+	struct sha256_state sctx;
+
+	if (check_eb_range(eb, start, len))
+		return;
+
+	offset = get_eb_offset_in_page(eb, start);
+
+	/*
+	 * TODO: This should maybe be using the crypto API, not the fallback,
+	 * but fscrypt uses the fallback and this is only used in emulation of
+	 * fscrypt's buffer sha256 method.
+	 */
+	sha256_init(&sctx);
+	while (len > 0) {
+		page = eb->pages[i];
+		assert_eb_page_uptodate(eb, page);
+
+		cur = min(len, PAGE_SIZE - offset);
+		kaddr = page_address(page);
+		sha256_update(&sctx, (u8 *)(kaddr + offset), cur);
+
+		len -= cur;
+		offset = 0;
+		i++;
+	}
+	sha256_final(&sctx, out);
+}
+
 void copy_extent_buffer_full(const struct extent_buffer *dst,
 			     const struct extent_buffer *src)
 {
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 69a86ae6fd50..d6c1b91cd690 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -222,6 +222,8 @@ void memmove_extent_buffer(const struct extent_buffer *dst,
 			   unsigned long len);
 void memzero_extent_buffer(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long len);
+void extent_buffer_sha256(const struct extent_buffer *eb, unsigned long start,
+			  unsigned long len, u8 *out);
 int extent_buffer_test_bit(const struct extent_buffer *eb, unsigned long start,
 			   unsigned long pos);
 void extent_buffer_bitmap_set(const struct extent_buffer *eb, unsigned long start,
diff --git a/fs/btrfs/fscrypt.c b/fs/btrfs/fscrypt.c
new file mode 100644
index 000000000000..2ed844dd61d0
--- /dev/null
+++ b/fs/btrfs/fscrypt.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Facebook
+ */
+
+#include "ctree.h"
+#include "fscrypt.h"
+
+/* fscrypt_match_name() but for an extent_buffer. */
+bool btrfs_fscrypt_match_name(const struct fscrypt_name *fname,
+			      struct extent_buffer *leaf, unsigned long de_name,
+			      u32 de_name_len)
+{
+	const struct fscrypt_nokey_name *nokey_name =
+		(const void *)fname->crypto_buf.name;
+	u8 digest[SHA256_DIGEST_SIZE];
+
+	if (likely(fname->disk_name.name)) {
+		if (de_name_len != fname->disk_name.len)
+			return false;
+		return !memcmp_extent_buffer(leaf, fname->disk_name.name,
+					     de_name, de_name_len);
+	}
+	if (de_name_len <= sizeof(nokey_name->bytes))
+		return false;
+	if (memcmp_extent_buffer(leaf, nokey_name->bytes, de_name,
+				 sizeof(nokey_name->bytes)))
+		return false;
+	extent_buffer_sha256(leaf, de_name + sizeof(nokey_name->bytes),
+			     de_name_len - sizeof(nokey_name->bytes), digest);
+	return !memcmp(digest, nokey_name->sha256, sizeof(digest));
+}
diff --git a/fs/btrfs/fscrypt.h b/fs/btrfs/fscrypt.h
new file mode 100644
index 000000000000..7f24d12e6ee0
--- /dev/null
+++ b/fs/btrfs/fscrypt.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BTRFS_FSCRYPT_H
+#define BTRFS_FSCRYPT_H
+
+#include <linux/fscrypt.h>
+
+#ifdef CONFIG_FS_ENCRYPTION
+bool btrfs_fscrypt_match_name(const struct fscrypt_name *fname,
+			      struct extent_buffer *leaf,
+			      unsigned long de_name, u32 de_name_len);
+
+#else
+static bool btrfs_fscrypt_match_name(const struct fscrypt_name *fname,
+				     struct extent_buffer *leaf,
+				     unsigned long de_name, u32 de_name_len)
+{
+	if (de_name_len != fname->disk_name.len)
+		return false;
+	return !memcmp_extent_buffer(leaf, fname->disk_name.name,
+				     de_name, de_name_len);
+}
+#endif
+
+#endif /* BTRFS_FSCRYPT_H */
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 78053eb9589c..4ad75f9573aa 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -7,6 +7,7 @@
 #include "ctree.h"
 #include "inode-item.h"
 #include "disk-io.h"
+#include "fscrypt.h"
 #include "transaction.h"
 #include "print-tree.h"
 
@@ -62,10 +63,9 @@ struct btrfs_inode_extref *btrfs_find_name_in_ext_backref(
 		name_ptr = (unsigned long)(&extref->name);
 		ref_name_len = btrfs_inode_extref_name_len(leaf, extref);
 
-		if (ref_name_len == fname_len(fname) &&
-		    btrfs_inode_extref_parent(leaf, extref) == ref_objectid &&
-		    (memcmp_extent_buffer(leaf, fname_name(fname), name_ptr,
-					  fname_len(fname)) == 0))
+		if (btrfs_inode_extref_parent(leaf, extref) == ref_objectid &&
+		    btrfs_fscrypt_match_name(fname, leaf, name_ptr,
+					     ref_name_len))
 			return extref;
 
 		cur_offset += ref_name_len + sizeof(*extref);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 761293d763b6..482c5b3d9e70 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -55,6 +55,7 @@
 #include "zoned.h"
 #include "subpage.h"
 #include "inode-item.h"
+#include "fscrypt.h"
 
 struct btrfs_iget_args {
 	u64 ino;
@@ -5646,14 +5647,10 @@ static int fixup_tree_root_location(struct btrfs_fs_info *fs_info,
 
 	leaf = path->nodes[0];
 	ref = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_root_ref);
-	if (btrfs_root_ref_dirid(leaf, ref) != btrfs_ino(BTRFS_I(dir)) ||
-	    btrfs_root_ref_name_len(leaf, ref) != dentry->d_name.len)
+	if (btrfs_root_ref_dirid(leaf, ref) != btrfs_ino(BTRFS_I(dir)))
 		goto out;
-
-	ret = memcmp_extent_buffer(leaf, dentry->d_name.name,
-				   (unsigned long)(ref + 1),
-				   dentry->d_name.len);
-	if (ret)
+	if (!btrfs_fscrypt_match_name(&fname, leaf, (unsigned long)(ref + 1),
+				      btrfs_root_ref_name_len(leaf, ref)))
 		goto out;
 
 	btrfs_release_path(path);
diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index f44f02c22027..bbb215007896 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -8,6 +8,7 @@
 #include "ctree.h"
 #include "transaction.h"
 #include "disk-io.h"
+#include "fscrypt.h"
 #include "print-tree.h"
 #include "qgroup.h"
 #include "space-info.h"
@@ -351,14 +352,14 @@ int btrfs_del_root_ref(struct btrfs_trans_handle *trans, u64 root_id,
 	if (ret < 0) {
 		goto out;
 	} else if (ret == 0) {
+		u32 name_len;
 		leaf = path->nodes[0];
 		ref = btrfs_item_ptr(leaf, path->slots[0],
 				     struct btrfs_root_ref);
 		ptr = (unsigned long)(ref + 1);
+		name_len = btrfs_root_ref_name_len(leaf, ref);
 		if ((btrfs_root_ref_dirid(leaf, ref) != dirid) ||
-		    (btrfs_root_ref_name_len(leaf, ref) != fname_len(fname)) ||
-		    memcmp_extent_buffer(leaf, fname_name(fname), ptr,
-					 fname_len(fname))) {
+		    !btrfs_fscrypt_match_name(fname, leaf, ptr, name_len)) {
 			ret = -ENOENT;
 			goto out;
 		}
-- 
2.35.1

