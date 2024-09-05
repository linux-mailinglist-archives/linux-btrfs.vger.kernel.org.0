Return-Path: <linux-btrfs+bounces-7842-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C0C96CC1B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 03:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB2BB1C21E2B
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Sep 2024 01:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3B4946F;
	Thu,  5 Sep 2024 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GCTeRKCD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GCTeRKCD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7728F58
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725498832; cv=none; b=omlGIB+JAmAC9J95eLCLZZ8yQPa16RJsmQi+ruKbzCo9d3i9mwiQKafDDSNnLNN4ISKOOlbAH/y9zepX8qqLGx8wrfMO99jbHWuN1fOgOLgI2ipYW7lps4mFwEls1/8WYCNR3UrrtP9NG7BhAZkW3r5CfGjknxLMTXK+n5ezlD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725498832; c=relaxed/simple;
	bh=ElKbY9BBrRfTrH4YsO7q/xU8KmVMxUAbGg4Kq/aR+6w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QfJyw75VIjXAUJbOxz3yuOcoi28g/shq3WUFKsNI4V/h47Okx3s5owRINjPBiB1J6DgHaraRPqIrvmz3UQYVSvjX4QqQye0ZHD1DFSnfK5+fvoA65EdjBHTBVKS2TT2Xqvctej+l2fwL9xRxN2hmFYVGMSOiCq2ZsGJ4dPMinyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GCTeRKCD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GCTeRKCD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 214211F7F8
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQpFMKAuJPHv1EFSTqkizFNtAyzB3FQx+WFDWvfF3X8=;
	b=GCTeRKCD7vrpIzuC4FKQHEPxUblQHfmASk/K0W9ptA4ewRcDd/3sMYgdgX1ILZLpfb128V
	SznCz5nLADSEvd7mRNRWNVJPt6E+quRW/5PaVESqYVZIi7dfTHzdVyy/iPfT6mEn08uWlJ
	6cPRAoRslMs5+zkqvg3pQnhthiavyx8=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=GCTeRKCD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1725498828; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQpFMKAuJPHv1EFSTqkizFNtAyzB3FQx+WFDWvfF3X8=;
	b=GCTeRKCD7vrpIzuC4FKQHEPxUblQHfmASk/K0W9ptA4ewRcDd/3sMYgdgX1ILZLpfb128V
	SznCz5nLADSEvd7mRNRWNVJPt6E+quRW/5PaVESqYVZIi7dfTHzdVyy/iPfT6mEn08uWlJ
	6cPRAoRslMs5+zkqvg3pQnhthiavyx8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6305F13508
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Sep 2024 01:13:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ONz/CcsF2WbMKQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 05 Sep 2024 01:13:47 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/4] btrfs-progs: convert: fix inline extent size for symbol link
Date: Thu,  5 Sep 2024 10:43:21 +0930
Message-ID: <4e9620084674f98620c4508d482de383b653ea9f.1725498618.git.wqu@suse.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725498618.git.wqu@suse.com>
References: <cover.1725498618.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 214211F7F8
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
Sometimes test case btrfs/012 fails randomly, with the failure to read a
softlink:

     QA output created by 012
     Checking converted btrfs against the original one:
    -OK
    +readlink: Structure needs cleaning
     Checking saved ext2 image against the original one:
     OK

Furthermore, this will trigger a kernel error message:

 BTRFS critical (device dm-2): regular/prealloc extent found for non-regular inode 133081

[CAUSE]
For that specific inode 133081, the tree dump looks like this:

        item 127 key (133081 INODE_ITEM 0) itemoff 40984 itemsize 160
                generation 1 transid 1 size 4095 nbytes 4096
                block group 0 mode 120777 links 1 uid 0 gid 0 rdev 0
                sequence 0 flags 0x0(none)
        item 128 key (133081 INODE_REF 133080) itemoff 40972 itemsize 12
                index 2 namelen 2 name: l3
        item 129 key (133081 EXTENT_DATA 0) itemoff 40919 itemsize 53
                generation 4 type 1 (regular)
                extent data disk byte 2147483648 nr 38080512
                extent data offset 37974016 nr 4096 ram 38080512
                extent compression 0 (none)

Note that, the soft link inode size is 4095 at the max size (PATH_MAX,
removing the terminating NUL).
But the nbytes is 4096, exactly matching the sector size of the btrfs.

Thus it results the creation of a regular extent, but for btrfs we do
not accept a soft link with a regular/preallocated extent, thus kernel
rejects such read and failed the readlink call.

The root cause is in the convert code, where for soft links we always
create a data extent with its size + 1, causing the above problem.

I guess the original code is to handle the terminating NUL, but in btrfs
we never need to store the terminating NUL for inline extents nor
file names.

Thus this pitfall in btrfs-convert leads to the above invalid data
extent and fail the test case.

[FIX]
- Fix the ext2 and reiserfs symbolic link creation code
  To remove the terminating NUL.

- Add extra checks for the size of a symbolic link
  Btrfs has extra limits on the size of a symbolic link, as btrfs must
  store symbolic link targets as inlined extents.

  This means for 4K node sized btrfs, the size limit is smaller than the
  usual PATH_MAX - 1 (only around 4000 bytes instead of 4095).

  So for certain nodesize, some filesystems can not be converted to
  btrfs.
  (this should be rare, because the default nodesize is 16K already)

- Split the symbolic link and inline data extent size checks
  For symbolic links the real limit is PATH_MAX - 1 (removing the
  terminating NUL), but for inline data extents the limit is
  sectorsize - 1, which can be different from 4096 - 1 (e.g. 64K sector
  size).

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/source-ext2.c     | 29 +++++++++++++++++++++++------
 convert/source-reiserfs.c | 10 ++++++++--
 kernel-shared/file-item.c |  6 ++++++
 kernel-shared/file-item.h | 18 ++++++++++++++++++
 4 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index acba5db7ee81..d06f90a98e9b 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -390,6 +390,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 			       ext2_filsys ext2_fs, ext2_ino_t ext2_ino,
 			       u32 convert_flags)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret;
 	char *buffer = NULL;
 	errcode_t err;
@@ -397,8 +398,20 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 	u32 last_block;
 	u32 sectorsize = root->fs_info->sectorsize;
 	u64 inode_size = btrfs_stack_inode_size(btrfs_inode);
+	bool meet_inline_size_limit;
 	struct blk_iterate_data data;
 
+	if (S_ISLNK(btrfs_stack_inode_mode(btrfs_inode))) {
+		meet_inline_size_limit = inode_size <= btrfs_symlink_max_size(fs_info);
+		if (!meet_inline_size_limit) {
+			error("symlink too large for ext2 inode %u, has %llu max %u",
+			     ext2_ino, inode_size, btrfs_symlink_max_size(fs_info));
+			return -ENAMETOOLONG;
+		}
+	} else {
+		meet_inline_size_limit = inode_size <= btrfs_data_inline_max_size(fs_info);
+	}
+
 	init_blk_iterate_data(&data, trans, root, btrfs_inode, objectid,
 			convert_flags & CONVERT_FLAG_DATACSUM);
 
@@ -430,8 +443,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 	if (ret)
 		goto fail;
 	if ((convert_flags & CONVERT_FLAG_INLINE_DATA) && data.first_block == 0
-	    && data.num_blocks > 0 && inode_size < sectorsize
-	    && inode_size <= BTRFS_MAX_INLINE_DATA_SIZE(root->fs_info)) {
+	    && data.num_blocks > 0 && meet_inline_size_limit) {
 		u64 num_bytes = data.num_blocks * sectorsize;
 		u64 disk_bytenr = data.disk_block * sectorsize;
 		u64 nbytes;
@@ -476,21 +488,26 @@ static int ext2_create_symlink(struct btrfs_trans_handle *trans,
 	int ret;
 	char *pathname;
 	u64 inode_size = btrfs_stack_inode_size(btrfs_inode);
+
 	if (ext2fs_inode_data_blocks2(ext2_fs, ext2_inode)) {
-		btrfs_set_stack_inode_size(btrfs_inode, inode_size + 1);
+		if (inode_size > btrfs_symlink_max_size(trans->fs_info)) {
+			error("symlink too large for ext2 inode %u, has %llu max %u",
+				ext2_ino, inode_size,
+				btrfs_symlink_max_size(trans->fs_info));
+			return -ENAMETOOLONG;
+		}
 		ret = ext2_create_file_extents(trans, root, objectid,
 				btrfs_inode, ext2_fs, ext2_ino,
 				CONVERT_FLAG_DATACSUM |
 				CONVERT_FLAG_INLINE_DATA);
-		btrfs_set_stack_inode_size(btrfs_inode, inode_size);
 		return ret;
 	}
 
 	pathname = (char *)&(ext2_inode->i_block[0]);
 	BUG_ON(pathname[inode_size] != 0);
 	ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
-					 pathname, inode_size + 1);
-	btrfs_set_stack_inode_nbytes(btrfs_inode, inode_size + 1);
+					 pathname, inode_size);
+	btrfs_set_stack_inode_nbytes(btrfs_inode, inode_size);
 	return ret;
 }
 
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index 3edc72ed08a5..3475b15277dc 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -537,9 +537,15 @@ static int reiserfs_copy_symlink(struct btrfs_trans_handle *trans,
 	symlink = tp_item_body(&path);
 	len = get_ih_item_len(tp_item_head(&path));
 
+	if (len > btrfs_symlink_max_size(trans->fs_info)) {
+		error("symlink too large, has %u max %u",
+		      len, btrfs_symlink_max_size(trans->fs_info));
+		ret = -ENAMETOOLONG;
+		goto fail;
+	}
 	ret = btrfs_insert_inline_extent(trans, root, objectid, 0,
-					 symlink, len + 1);
-	btrfs_set_stack_inode_nbytes(btrfs_inode, len + 1);
+					 symlink, len);
+	btrfs_set_stack_inode_nbytes(btrfs_inode, len);
 fail:
 	pathrelse(&path);
 	return ret;
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index d2da56e1f523..eb9024022d9f 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -26,6 +26,7 @@
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/uapi/btrfs.h"
 #include "common/internal.h"
+#include "common/messages.h"
 
 #define MAX_CSUM_ITEMS(r, size) ((((BTRFS_LEAF_DATA_SIZE(r->fs_info) - \
 			       sizeof(struct btrfs_item) * 2) / \
@@ -88,6 +89,7 @@ int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root, u64 objectid,
 			       u64 offset, const char *buffer, size_t size)
 {
+	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_key key;
 	struct btrfs_path *path;
 	struct extent_buffer *leaf;
@@ -97,6 +99,10 @@ int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
 	int err = 0;
 	int ret;
 
+	if (size > max(btrfs_symlink_max_size(fs_info),
+		       btrfs_data_inline_max_size(fs_info)))
+		return -EUCLEAN;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
diff --git a/kernel-shared/file-item.h b/kernel-shared/file-item.h
index 0df8f4dfea72..2c1e17c990dc 100644
--- a/kernel-shared/file-item.h
+++ b/kernel-shared/file-item.h
@@ -92,5 +92,23 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 logical,
 int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
 			       struct btrfs_root *root, u64 objectid,
 			       u64 offset, const char *buffer, size_t size);
+/*
+ * For symlink we allow up to PATH_MAX - 1 (PATH_MAX includes the terminating NUL,
+ * but fs doesn't store that terminating NUL).
+ *
+ * But for inlined data extents, the up limit is sectorsize - 1 (inclusive), or a
+ * regular extent should be created instead.
+ */
+static inline u32 btrfs_symlink_max_size(struct btrfs_fs_info *fs_info)
+{
+	return min_t(u32, BTRFS_MAX_INLINE_DATA_SIZE(fs_info),
+		     PATH_MAX - 1);
+}
+
+static inline u32 btrfs_data_inline_max_size(struct btrfs_fs_info *fs_info)
+{
+	return min_t(u32, BTRFS_MAX_INLINE_DATA_SIZE(fs_info),
+		     fs_info->sectorsize - 1);
+}
 
 #endif
-- 
2.46.0


