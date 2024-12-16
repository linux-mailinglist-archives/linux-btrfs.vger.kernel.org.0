Return-Path: <linux-btrfs+bounces-10413-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9729F374E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 18:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E31567A671A
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 17:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AE42054E9;
	Mon, 16 Dec 2024 17:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcExVcxw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C94206F0A
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369450; cv=none; b=bInV/dUuHwVSavMjouxy8IS9NIqwqhdLFSqyUvHFdI+3Xij76PHUzw/90dpQfytXcicsmtBQrKDHo7GB14KgT8xGSdghWyMYPt68xjk1UXy7ry1GUOlAyXNj9F82+AbCOmKgAHpNVBnbCXe6RVlZHPdPkXg8ZyXaClygY8c+jG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369450; c=relaxed/simple;
	bh=uqh/F2IDkqkoIMGP8UQa9BlDQEoE/LFE0Wkm7eVUFGg=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=efZ+6ikK8T0e8ekSBf5Dj+hYTiaqAtR2vJD1bwCX1I2Lpnd74TR6WX0DC/K+vx7A+TzB5iCB4MiIU1jbOq6sa0faZ2wcA58dpjVCVRC3dfnPynYWVhd1nXUauTVTcqzahbRFpQb02jSROSWU5TePuPUlW1nMyBpnQ/PE+wt8KWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcExVcxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17589C4AF09
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 17:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734369449;
	bh=uqh/F2IDkqkoIMGP8UQa9BlDQEoE/LFE0Wkm7eVUFGg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rcExVcxwqS3o1yIwo6sFNy/mMHFOp60tNs7xlPM1on2WO1DV/AoW5K5CKhctzyOOC
	 tT+CVKuT6KJilGSjc6It53DJE/S+NiF0t+bS2/Z/3Q/ZR14eaOOVtFGju0GOfDlgwJ
	 CauEbFI2ept0xe71vWWefKM4eMCHC+JxPtc1FVoYFJz4n4Fa/P4dzEOlDyx0CcKS9H
	 i5g8Jv5GkVCNI4sC0wLLiJTBbRHLIhxAk88WaAlMJ7G6NrowjtMsMlmo7Z1RZVJdef
	 56yq3xDPUi5C3Kg19laA8wOfGPPgIA/2s7DBohp16afOmcE7sufgre1Vri76SAT5Vm
	 QLKaPytJsF9SA==
From: fdmanana@kernel.org
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/9] btrfs: move csum related functions from ctree.c into fs.c
Date: Mon, 16 Dec 2024 17:17:17 +0000
Message-Id: <ca35ce34f64fc203266a7336390d82745d82ed5f.1734368270.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1734368270.git.fdmanana@suse.com>
References: <cover.1734368270.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

The ctree module is about the implementation of the btree data structure
and not a place holder for generic filesystem things like the csum
algorithm details. Move the functions related to the csum algorithm
details away from ctree.c and into fs.c, which is a far better place for
them. Also fix missing punctuation in comments and change one multiline
comment to a single line comment since everything fits in under 80
characters.

For some reason this also sligthly reduces the module's size.

Before this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1782126	 161045	  16920	1960091	 1de89b	fs/btrfs/btrfs.ko

After this change:

  $ size fs/btrfs/btrfs.ko
     text	   data	    bss	    dec	    hex	filename
  1782094	 161045	  16920	1960059	 1de87b	fs/btrfs/btrfs.ko

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 51 ------------------------------------------------
 fs/btrfs/ctree.h |  6 ------
 fs/btrfs/fs.c    | 49 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/fs.h    |  6 ++++++
 4 files changed, 55 insertions(+), 57 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 99a58ede387e..c93f52a30a16 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -37,19 +37,6 @@ static int push_node_left(struct btrfs_trans_handle *trans,
 static int balance_node_right(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *dst_buf,
 			      struct extent_buffer *src_buf);
-
-static const struct btrfs_csums {
-	u16		size;
-	const char	name[10];
-	const char	driver[12];
-} btrfs_csums[] = {
-	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
-	[BTRFS_CSUM_TYPE_XXHASH] = { .size = 8, .name = "xxhash64" },
-	[BTRFS_CSUM_TYPE_SHA256] = { .size = 32, .name = "sha256" },
-	[BTRFS_CSUM_TYPE_BLAKE2] = { .size = 32, .name = "blake2b",
-				     .driver = "blake2b-256" },
-};
-
 /*
  * The leaf data grows from end-to-front in the node.  this returns the address
  * of the start of the last item, which is the stop of the leaf data stack.
@@ -148,44 +135,6 @@ static inline void copy_leaf_items(const struct extent_buffer *dst,
 			      nr_items * sizeof(struct btrfs_item));
 }
 
-/* This exists for btrfs-progs usages. */
-u16 btrfs_csum_type_size(u16 type)
-{
-	return btrfs_csums[type].size;
-}
-
-int btrfs_super_csum_size(const struct btrfs_super_block *s)
-{
-	u16 t = btrfs_super_csum_type(s);
-	/*
-	 * csum type is validated at mount time
-	 */
-	return btrfs_csum_type_size(t);
-}
-
-const char *btrfs_super_csum_name(u16 csum_type)
-{
-	/* csum type is validated at mount time */
-	return btrfs_csums[csum_type].name;
-}
-
-/*
- * Return driver name if defined, otherwise the name that's also a valid driver
- * name
- */
-const char *btrfs_super_csum_driver(u16 csum_type)
-{
-	/* csum type is validated at mount time */
-	return btrfs_csums[csum_type].driver[0] ?
-		btrfs_csums[csum_type].driver :
-		btrfs_csums[csum_type].name;
-}
-
-size_t __attribute_const__ btrfs_get_num_csums(void)
-{
-	return ARRAY_SIZE(btrfs_csums);
-}
-
 struct btrfs_path *btrfs_alloc_path(void)
 {
 	might_sleep();
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 2c341956a01c..a1bab0b3f193 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -756,12 +756,6 @@ static inline bool btrfs_is_data_reloc_root(const struct btrfs_root *root)
 	return root->root_key.objectid == BTRFS_DATA_RELOC_TREE_OBJECTID;
 }
 
-u16 btrfs_csum_type_size(u16 type);
-int btrfs_super_csum_size(const struct btrfs_super_block *s);
-const char *btrfs_super_csum_name(u16 csum_type);
-const char *btrfs_super_csum_driver(u16 csum_type);
-size_t __attribute_const__ btrfs_get_num_csums(void);
-
 /*
  * We use folio flag owner_2 to indicate there is an ordered extent with
  * unfinished IO.
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index 31c1648bc0b4..3756a3b9c9da 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -5,6 +5,55 @@
 #include "fs.h"
 #include "accessors.h"
 
+static const struct btrfs_csums {
+	u16		size;
+	const char	name[10];
+	const char	driver[12];
+} btrfs_csums[] = {
+	[BTRFS_CSUM_TYPE_CRC32] = { .size = 4, .name = "crc32c" },
+	[BTRFS_CSUM_TYPE_XXHASH] = { .size = 8, .name = "xxhash64" },
+	[BTRFS_CSUM_TYPE_SHA256] = { .size = 32, .name = "sha256" },
+	[BTRFS_CSUM_TYPE_BLAKE2] = { .size = 32, .name = "blake2b",
+				     .driver = "blake2b-256" },
+};
+
+/* This exists for btrfs-progs usages. */
+u16 btrfs_csum_type_size(u16 type)
+{
+	return btrfs_csums[type].size;
+}
+
+int btrfs_super_csum_size(const struct btrfs_super_block *s)
+{
+	u16 t = btrfs_super_csum_type(s);
+
+	/* csum type is validated at mount time. */
+	return btrfs_csum_type_size(t);
+}
+
+const char *btrfs_super_csum_name(u16 csum_type)
+{
+	/* csum type is validated at mount time. */
+	return btrfs_csums[csum_type].name;
+}
+
+/*
+ * Return driver name if defined, otherwise the name that's also a valid driver
+ * name.
+ */
+const char *btrfs_super_csum_driver(u16 csum_type)
+{
+	/* csum type is validated at mount time */
+	return btrfs_csums[csum_type].driver[0] ?
+		btrfs_csums[csum_type].driver :
+		btrfs_csums[csum_type].name;
+}
+
+size_t __attribute_const__ btrfs_get_num_csums(void)
+{
+	return ARRAY_SIZE(btrfs_csums);
+}
+
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name)
 {
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 79a1a3d6f04d..b05f2af97140 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -982,6 +982,12 @@ void btrfs_exclop_balance(struct btrfs_fs_info *fs_info,
 
 int btrfs_check_ioctl_vol_args_path(const struct btrfs_ioctl_vol_args *vol_args);
 
+u16 btrfs_csum_type_size(u16 type);
+int btrfs_super_csum_size(const struct btrfs_super_block *s);
+const char *btrfs_super_csum_name(u16 csum_type);
+const char *btrfs_super_csum_driver(u16 csum_type);
+size_t __attribute_const__ btrfs_get_num_csums(void);
+
 /* Compatibility and incompatibility defines */
 void __btrfs_set_fs_incompat(struct btrfs_fs_info *fs_info, u64 flag,
 			     const char *name);
-- 
2.45.2


