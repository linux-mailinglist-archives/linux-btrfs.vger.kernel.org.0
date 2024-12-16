Return-Path: <linux-btrfs+bounces-10395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A00769F2958
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 05:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F537A214E
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 04:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A476B1C3C09;
	Mon, 16 Dec 2024 04:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mLr5xmRg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mLr5xmRg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F5D1922FA
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734324700; cv=none; b=ulanCuoGAA8omt42ZgoxSsF9CrXwbcZHTvMKnQez9pnEplBsOoNe36sNUVHQtsHpaMTNCmHbWpLgTLeinO+HacExVytOIyxN2+HgrUNIle78+LO1yVUl2TRTs63SzbMWOJkzZVzj8cBQSmPXnxDz4tv2kTA7xVZzvRrdM+8CX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734324700; c=relaxed/simple;
	bh=LxMuVNPxuv+w9FVOM+EivEUx5skz9fNwOQ4u+gviKto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzpSwa7798pkXYfcvWrYv0eExL6xwcN67sRdTzjqqBrxm6O3lKAL3Lyio3jy5YMJb/Ti9imVMVkQggYrASaGqD4myjvCGEhoUjXjznR6Zxn5wrC8ITwcsgTv32w3Q6pfkzV1oXFbOdLHnoL5MIUpFSuI1X7Py06EAcy6MyDDAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mLr5xmRg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mLr5xmRg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 893F51F443
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgpkyJFYv+OV4YdMQbsjQENVFM+XuXXz+okR2CdWEIc=;
	b=mLr5xmRgELL/07xFdQ7x+4pc9zqG5o8w6TWjf8nkLYD4vPW+L4Oxdj4PYDXS7U+CD2cQUb
	REerwThNA/BErH5TCXhY54jR5641HE7e6mKrG2PHvgc97GpbU3fOQBJUiufENUQZwgzsuQ
	sEj3UJf/xXRXiRSv+ZYwvpAaARpfiUg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=mLr5xmRg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CgpkyJFYv+OV4YdMQbsjQENVFM+XuXXz+okR2CdWEIc=;
	b=mLr5xmRgELL/07xFdQ7x+4pc9zqG5o8w6TWjf8nkLYD4vPW+L4Oxdj4PYDXS7U+CD2cQUb
	REerwThNA/BErH5TCXhY54jR5641HE7e6mKrG2PHvgc97GpbU3fOQBJUiufENUQZwgzsuQ
	sEj3UJf/xXRXiRSv+ZYwvpAaARpfiUg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13E4D137CF
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cO5OL9KxX2ciNwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:30 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/4] btrfs-progs: convert btrfs_fs_info::sectorsize to blocksize
Date: Mon, 16 Dec 2024 15:21:04 +1030
Message-ID: <e9fce135ac0c02962cfa3cfe8d68a20c08ff3846.1734324435.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734324435.git.wqu@suse.com>
References: <cover.1734324435.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 893F51F443
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
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

This will change all usage of btrfs_fs_info::sectorsize to
btrfs_fs_info::blocksize.

There are some extra changes involved:

- Rename csum_tree_block_size()'s @csum_sectorsize to @csum_size
  In fact @csum_sectorsize is only used in the declaration, and the
  implementation is already using @csum_size instead.

- Involved comments and simple function/variable names

- btrfs_free_space_ctrl::sectorsize to blocksize

- btrfs_mkfs_config::sectorsize to blocksize

The following one is not changed yet, as it is part of on-disk format,
thus will be changed in a dedicate patch.

- btrfs_super_block::sectorsize

The following one will not be changed:

- btrfs_chunk::sector_size
- btrfs_device_item::sector_size

As "sector size" is correct terminology for minimum block IO size for a
device.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c            | 24 ++++----
 check/main.c                     | 44 +++++++-------
 check/mode-common.c              | 18 +++---
 check/mode-lowmem.c              | 24 ++++----
 check/repair.c                   |  4 +-
 cmds/inspect-dump-tree.c         |  8 +--
 cmds/rescue-chunk-recover.c      | 24 ++++----
 cmds/restore.c                   |  6 +-
 common/clear-cache.c             |  2 +-
 common/fsfeatures.c              | 52 ++++++++---------
 common/fsfeatures.h              |  4 +-
 convert/common.c                 | 16 +++---
 convert/main.c                   | 24 ++++----
 convert/source-ext2.c            | 18 +++---
 convert/source-fs.c              | 16 +++---
 convert/source-reiserfs.c        | 12 ++--
 kernel-shared/ctree.h            |  5 +-
 kernel-shared/disk-io.c          | 20 +++----
 kernel-shared/disk-io.h          |  2 +-
 kernel-shared/extent-tree.c      | 10 ++--
 kernel-shared/file-item.c        | 18 +++---
 kernel-shared/file-item.h        |  4 +-
 kernel-shared/file.c             | 18 +++---
 kernel-shared/free-space-cache.c | 40 ++++++-------
 kernel-shared/free-space-cache.h |  4 +-
 kernel-shared/free-space-tree.c  | 28 ++++-----
 kernel-shared/print-tree.c       |  8 +--
 kernel-shared/tree-checker.c     | 98 ++++++++++++++++----------------
 kernel-shared/volumes.c          | 20 +++----
 mkfs/common.c                    | 22 +++----
 mkfs/common.h                    |  2 +-
 mkfs/main.c                      | 40 ++++++-------
 mkfs/rootdir.c                   | 78 ++++++++++++-------------
 tune/change-csum.c               | 26 ++++-----
 34 files changed, 370 insertions(+), 369 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index fc71eb2cbf72..3f413c7684ce 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -45,14 +45,14 @@
 
 static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror)
 {
-	const u32 sectorsize = root->fs_info->sectorsize;
+	const u32 blocksize = root->fs_info->blocksize;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	int ret;
 	int num_copies;
 	int mirror_num = 1;
 	void *buf;
 
-	buf = malloc(root->fs_info->sectorsize);
+	buf = malloc(root->fs_info->blocksize);
 	if (!buf) {
 		error_msg(ERROR_MSG_MEMORY, "allocating memory for bytenr %llu",
 			  logical);
@@ -61,11 +61,11 @@ static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror
 
 	while (1) {
 		if (!mirror || mirror_num == mirror) {
-			u64 read_len = sectorsize;
+			u64 read_len = blocksize;
 
 			ret = read_data_from_disk(fs_info, buf, logical,
 						  &read_len, mirror_num);
-			if (read_len < sectorsize)
+			if (read_len < blocksize)
 				ret = -EIO;
 			if (ret < 0) {
 				errno = -ret;
@@ -73,8 +73,8 @@ static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror
 				goto out;
 			}
 			printf("corrupting %llu copy %d\n", logical, mirror_num);
-			memset(buf, 0, sectorsize);
-			ret = write_data_to_disk(fs_info, buf, logical, sectorsize);
+			memset(buf, 0, blocksize);
+			ret = write_data_to_disk(fs_info, buf, logical, blocksize);
 			if (ret < 0) {
 				errno = -ret;
 				error("cannot write bytenr %llu: %m", logical);
@@ -82,7 +82,7 @@ static int debug_corrupt_sector(struct btrfs_root *root, u64 logical, int mirror
 			}
 		}
 
-		num_copies = btrfs_num_copies(root->fs_info, logical, sectorsize);
+		num_copies = btrfs_num_copies(root->fs_info, logical, blocksize);
 		if (num_copies == 1)
 			break;
 
@@ -122,7 +122,7 @@ static const char * const corrupt_block_usage[] = {
 	OPTLINE("-d|--delete", "delete item corresponding to passed key triplet"),
 	OPTLINE("-r|--root", "operate on this root"),
 	OPTLINE("-C|--csum BYTENR", "delete a csum for the specified bytenr.  When used "
-		"with -b it'll delete that many bytes, otherwise it's just sectorsize"),
+		"with -b it'll delete that many bytes, otherwise it's just blocksize"),
 	OPTLINE("--block-group OFFSET", "corrupt the given block group"),
 	OPTLINE("--value VALUE", "value to use for corrupting item data"),
 	OPTLINE("--offset OFFSET", "offset to use for corrupting item data"),
@@ -1604,9 +1604,9 @@ int main(int argc, char **argv)
 		usage(&corrupt_block_cmd, 1);
 
 	if (bytes == 0)
-		bytes = root->fs_info->sectorsize;
+		bytes = root->fs_info->blocksize;
 
-	bytes = round_up(bytes, root->fs_info->sectorsize);
+	bytes = round_up(bytes, root->fs_info->blocksize);
 
 	while (bytes > 0) {
 		if (corrupt_block_keys) {
@@ -1631,8 +1631,8 @@ int main(int argc, char **argv)
 			}
 			free_extent_buffer(eb);
 		}
-		logical += root->fs_info->sectorsize;
-		bytes -= root->fs_info->sectorsize;
+		logical += root->fs_info->blocksize;
+		bytes -= root->fs_info->blocksize;
 	}
 	return ret;
 out_close:
diff --git a/check/main.c b/check/main.c
index 6290c6d4b9e2..2cceb31e4481 100644
--- a/check/main.c
+++ b/check/main.c
@@ -675,7 +675,7 @@ static void print_inode_error(struct btrfs_root *root, struct inode_record *rec)
 			if (rec->extent_end < rec->isize) {
 				start = rec->extent_end;
 				len = round_up(rec->isize,
-					       gfs_info->sectorsize) - start;
+					       gfs_info->blocksize) - start;
 			} else {
 				start = 0;
 				len = rec->extent_start;
@@ -1679,7 +1679,7 @@ static int process_file_extent(struct btrfs_root *root,
 	u64 num_bytes = 0;
 	u64 disk_bytenr = 0;
 	u64 extent_offset = 0;
-	u64 mask = gfs_info->sectorsize - 1;
+	u64 mask = gfs_info->blocksize - 1;
 	u32 max_inline_size = min_t(u32, mask,
 				BTRFS_MAX_INLINE_DATA_SIZE(gfs_info));
 	u8 compression;
@@ -1715,7 +1715,7 @@ static int process_file_extent(struct btrfs_root *root,
 		if (compression) {
 			if (btrfs_file_extent_inline_item_len(eb, slot) >
 			    max_inline_size ||
-			    num_bytes > gfs_info->sectorsize)
+			    num_bytes > gfs_info->blocksize)
 				rec->errors |= I_ERR_FILE_EXTENT_TOO_LARGE;
 		} else {
 			if (num_bytes > max_inline_size)
@@ -2740,7 +2740,7 @@ static int repair_inode_discount_extent(struct btrfs_trans_handle *trans,
 	/* special case for a file losing all its file extent */
 	if (!found) {
 		ret = btrfs_punch_hole(trans, root, rec->ino, 0,
-				       round_up(rec->isize, gfs_info->sectorsize));
+				       round_up(rec->isize, gfs_info->blocksize));
 		if (ret < 0)
 			goto out;
 	}
@@ -5613,9 +5613,9 @@ static int process_extent_item(struct btrfs_root *root,
 
 	update_block_group_used(block_group_cache, key.objectid, num_bytes);
 
-	if (!IS_ALIGNED(key.objectid, gfs_info->sectorsize)) {
+	if (!IS_ALIGNED(key.objectid, gfs_info->blocksize)) {
 		error("ignoring invalid extent, bytenr %llu is not aligned to %u",
-		      key.objectid, gfs_info->sectorsize);
+		      key.objectid, gfs_info->blocksize);
 		return -EIO;
 	}
 	if (item_size < sizeof(*ei)) {
@@ -5637,9 +5637,9 @@ static int process_extent_item(struct btrfs_root *root,
 		      num_bytes, gfs_info->nodesize);
 		return -EIO;
 	}
-	if (!metadata && !IS_ALIGNED(num_bytes, gfs_info->sectorsize)) {
+	if (!metadata && !IS_ALIGNED(num_bytes, gfs_info->blocksize)) {
 		error("ignore invalid data extent, length %llu is not aligned to %u",
-		      num_bytes, gfs_info->sectorsize);
+		      num_bytes, gfs_info->blocksize);
 		return -EIO;
 	}
 	if (metadata)
@@ -5804,7 +5804,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 	int num_copies;
 	bool csum_mismatch = false;
 
-	if (num_bytes % gfs_info->sectorsize)
+	if (num_bytes % gfs_info->blocksize)
 		return -EINVAL;
 
 	data = malloc(num_bytes);
@@ -5832,10 +5832,10 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 				tmp = offset + data_checked;
 
 				btrfs_csum_data(gfs_info, csum_type, data + tmp,
-						result, gfs_info->sectorsize);
+						result, gfs_info->blocksize);
 
 				csum_offset = leaf_offset +
-					 tmp / gfs_info->sectorsize * csum_size;
+					 tmp / gfs_info->blocksize * csum_size;
 				read_extent_buffer(eb, (char *)&csum_expected,
 						   csum_offset, csum_size);
 				if (memcmp(result, csum_expected, csum_size) != 0) {
@@ -5850,7 +5850,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 				"mirror %d bytenr %llu csum %s expected csum %s\n",
 						mirror, bytenr + tmp, found, want);
 				}
-				data_checked += gfs_info->sectorsize;
+				data_checked += gfs_info->blocksize;
 			}
 		}
 		offset += read_len;
@@ -6079,7 +6079,7 @@ static int check_csum_root(struct btrfs_root *root)
 			errors++;
 		}
 		num_entries = btrfs_item_size(leaf, path.slots[0]) / csum_size;
-		data_len = num_entries * gfs_info->sectorsize;
+		data_len = num_entries * gfs_info->blocksize;
 
 		if (num_entries > max_entries) {
 			error(
@@ -6528,7 +6528,7 @@ static int run_next_block(struct btrfs_root *root,
 								       ref),
 					btrfs_extent_data_ref_offset(buf, ref),
 					btrfs_extent_data_ref_count(buf, ref),
-					0, 0, gfs_info->sectorsize);
+					0, 0, gfs_info->blocksize);
 				continue;
 			}
 			if (key.type == BTRFS_SHARED_DATA_REF_KEY) {
@@ -6539,7 +6539,7 @@ static int run_next_block(struct btrfs_root *root,
 				add_data_backref(extent_cache,
 					key.objectid, key.offset, 0, 0, 0,
 					btrfs_shared_data_ref_count(buf, ref),
-					0, 0, gfs_info->sectorsize);
+					0, 0, gfs_info->blocksize);
 				continue;
 			}
 			if (key.type == BTRFS_ORPHAN_ITEM_KEY) {
@@ -6588,11 +6588,11 @@ static int run_next_block(struct btrfs_root *root,
 				continue;
 			}
 			/* key.offset (file offset) must be aligned */
-			if (!IS_ALIGNED(key.offset, gfs_info->sectorsize)) {
+			if (!IS_ALIGNED(key.offset, gfs_info->blocksize)) {
 				ret = -EUCLEAN;
 				error(
 			"invalid file offset, have %llu expect aligned to %u",
-					key.offset, gfs_info->sectorsize);
+					key.offset, gfs_info->blocksize);
 				continue;
 			}
 			if (btrfs_file_extent_disk_bytenr(buf, fi) == 0)
@@ -8262,7 +8262,7 @@ static int check_extent_refs(struct btrfs_root *root,
 			cur_err = 1;
 		}
 
-		if (!IS_ALIGNED(rec->start, gfs_info->sectorsize)) {
+		if (!IS_ALIGNED(rec->start, gfs_info->blocksize)) {
 			fprintf(stderr, "unaligned extent rec on [%llu %llu]\n",
 				rec->start, rec->nr);
 			ret = record_unaligned_extent_rec(rec);
@@ -8638,8 +8638,8 @@ static bool is_super_size_valid(void)
 	if (btrfs_super_flags(gfs_info->super_copy) &
 	    (BTRFS_SUPER_FLAG_METADUMP | BTRFS_SUPER_FLAG_METADUMP_V2))
 		return true;
-	if (!IS_ALIGNED(super_bytes, gfs_info->sectorsize) ||
-	    !IS_ALIGNED(total_bytes, gfs_info->sectorsize) ||
+	if (!IS_ALIGNED(super_bytes, gfs_info->blocksize) ||
+	    !IS_ALIGNED(total_bytes, gfs_info->blocksize) ||
 	    super_bytes != total_bytes) {
 		warning("minor unaligned/mismatch device size detected:"
 			"\tsuper block total bytes=%llu found total bytes=%llu",
@@ -8668,7 +8668,7 @@ static int check_devices(struct rb_root *dev_cache,
 			ret = err;
 
 		check_dev_size_alignment(dev_rec->devid, dev_rec->total_byte,
-					 gfs_info->sectorsize);
+					 gfs_info->blocksize);
 		if (dev_rec->bad_block_dev_size && !ret)
 			ret = 1;
 		dev_node = rb_next(dev_node);
@@ -9733,7 +9733,7 @@ static int check_range_csummed(struct btrfs_root *root, u64 addr, u64 length)
 			break;
 
 		num_entries = btrfs_item_size(leaf, path.slots[0]) / gfs_info->csum_size;
-		data_len = num_entries * gfs_info->sectorsize;
+		data_len = num_entries * gfs_info->blocksize;
 
 		if (addr >= key.offset && addr <= key.offset + data_len) {
 			u64 end = min(addr + length, key.offset + data_len);
diff --git a/check/mode-common.c b/check/mode-common.c
index 0467ba28395e..18b3e778b8cc 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -353,7 +353,7 @@ int count_csum_range(u64 start, u64 len, u64 *found)
 
 		size = btrfs_item_size(leaf, path.slots[0]);
 		csum_end = key.offset + (size / csum_size) *
-			   gfs_info->sectorsize;
+			   gfs_info->blocksize;
 		if (csum_end > start) {
 			size = min(csum_end - start, len);
 			len -= size;
@@ -505,12 +505,12 @@ out:
  * Extra (optional) check for dev_item size to report possible problem on a new
  * kernel.
  */
-void check_dev_size_alignment(u64 devid, u64 total_bytes, u32 sectorsize)
+void check_dev_size_alignment(u64 devid, u64 total_bytes, u32 blocksize)
 {
-	if (!IS_ALIGNED(total_bytes, sectorsize)) {
+	if (!IS_ALIGNED(total_bytes, blocksize)) {
 		warning(
 "unaligned total_bytes detected for devid %llu, have %llu should be aligned to %u",
-			devid, total_bytes, sectorsize);
+			devid, total_bytes, blocksize);
 		warning(
 "this is OK for older kernel, but may cause kernel warning for newer kernels");
 		warning("this can be fixed by 'btrfs rescue fix-device-size'");
@@ -1210,12 +1210,12 @@ static int populate_csum(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	u64 offset = 0;
-	u64 sectorsize = fs_info->sectorsize;
+	u64 blocksize = fs_info->blocksize;
 	int ret = 0;
 
 	while (offset < len) {
 		ret = read_data_from_disk(fs_info, buf, start + offset,
-					  &sectorsize, 0);
+					  &blocksize, 0);
 		if (ret)
 			break;
 		ret = btrfs_csum_file_block(trans, start + offset,
@@ -1223,7 +1223,7 @@ static int populate_csum(struct btrfs_trans_handle *trans,
 					    fs_info->csum_type, buf);
 		if (ret)
 			break;
-		offset += sectorsize;
+		offset += blocksize;
 	}
 	return ret;
 }
@@ -1243,7 +1243,7 @@ static int fill_csum_tree_from_one_fs_root(struct btrfs_trans_handle *trans,
 	int slot = 0;
 	int ret = 0;
 
-	buf = malloc(gfs_info->sectorsize);
+	buf = malloc(gfs_info->blocksize);
 	if (!buf)
 		return -ENOMEM;
 
@@ -1500,7 +1500,7 @@ static int fill_csum_tree_from_extent(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	buf = malloc(gfs_info->sectorsize);
+	buf = malloc(gfs_info->blocksize);
 	if (!buf) {
 		btrfs_release_path(&path);
 		return -ENOMEM;
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 34af77f88437..3b1393e8286f 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -1949,7 +1949,7 @@ static int check_file_extent_inline(struct btrfs_root *root,
 				    struct btrfs_path *path, u64 *size,
 				    u64 *end)
 {
-	u32 max_inline_extent_size = min_t(u32, gfs_info->sectorsize - 1,
+	u32 max_inline_extent_size = min_t(u32, gfs_info->blocksize - 1,
 				BTRFS_MAX_INLINE_DATA_SIZE(gfs_info));
 	struct extent_buffer *node = path->nodes[0];
 	struct btrfs_file_extent_item *fi;
@@ -1974,11 +1974,11 @@ static int check_file_extent_inline(struct btrfs_root *root,
 	}
 
 	if (compressed) {
-		if (extent_num_bytes > gfs_info->sectorsize) {
+		if (extent_num_bytes > gfs_info->blocksize ) {
 			error(
 "root %llu EXTENT_DATA[%llu %llu] too large inline extent ram size, have %llu, max: %u",
 				root->objectid, fkey.objectid, fkey.offset,
-				extent_num_bytes, gfs_info->sectorsize - 1);
+				extent_num_bytes, gfs_info->blocksize - 1);
 			err |= FILE_EXTENT_ERROR;
 		}
 
@@ -2041,7 +2041,7 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	u64 disk_num_bytes;
 	u64 extent_num_bytes;
 	u64 extent_offset;
-	u64 csum_found;		/* In byte size, sectorsize aligned */
+	u64 csum_found;		/* In byte size, blocksize aligned */
 	u64 search_start;	/* Logical range start we search for csum */
 	u64 search_len;		/* Logical range len we search for csum */
 	u64 gen;
@@ -2170,7 +2170,7 @@ static int check_file_extent(struct btrfs_root *root, struct btrfs_path *path,
 	 * Don't update extent end beyond rounded up isize. As holes
 	 * after isize is not considered as missing holes.
 	 */
-	*end = min(round_up(isize, gfs_info->sectorsize),
+	*end = min(round_up(isize, gfs_info->blocksize),
 		   fkey.offset + extent_num_bytes);
 	if (!is_hole)
 		*size += extent_num_bytes;
@@ -3452,27 +3452,27 @@ static int check_extent_data_item(struct btrfs_root *root,
 	}
 
 	/* Check unaligned disk_bytenr, disk_num_bytes and num_bytes */
-	if (!IS_ALIGNED(disk_bytenr, gfs_info->sectorsize)) {
+	if (!IS_ALIGNED(disk_bytenr, gfs_info->blocksize)) {
 		error(
 "file extent [%llu, %llu] has unaligned disk bytenr: %llu, should be aligned to %u",
 			fi_key.objectid, fi_key.offset, disk_bytenr,
-			gfs_info->sectorsize);
+			gfs_info->blocksize);
 		err |= BYTES_UNALIGNED;
 	}
-	if (!IS_ALIGNED(disk_num_bytes, gfs_info->sectorsize)) {
+	if (!IS_ALIGNED(disk_num_bytes, gfs_info->blocksize)) {
 		error(
 "file extent [%llu, %llu] has unaligned disk num bytes: %llu, should be aligned to %u",
 			fi_key.objectid, fi_key.offset, disk_num_bytes,
-			gfs_info->sectorsize);
+			gfs_info->blocksize);
 		err |= BYTES_UNALIGNED;
 	} else if (account_bytes) {
 		data_bytes_allocated += disk_num_bytes;
 	}
-	if (!IS_ALIGNED(extent_num_bytes, gfs_info->sectorsize)) {
+	if (!IS_ALIGNED(extent_num_bytes, gfs_info->blocksize)) {
 		error(
 "file extent [%llu, %llu] has unaligned num bytes: %llu, should be aligned to %u",
 			fi_key.objectid, fi_key.offset, extent_num_bytes,
-			gfs_info->sectorsize);
+			gfs_info->blocksize);
 		err |= BYTES_UNALIGNED;
 	} else if (account_bytes) {
 		data_bytes_referenced += extent_num_bytes;
@@ -4675,7 +4675,7 @@ next:
 			BTRFS_DEV_EXTENT_KEY, dev_id);
 		return ACCOUNTING_MISMATCH;
 	}
-	check_dev_size_alignment(dev_id, total_bytes, gfs_info->sectorsize);
+	check_dev_size_alignment(dev_id, total_bytes, gfs_info->blocksize);
 
 	dev = btrfs_find_device_by_devid(gfs_info->fs_devices, dev_id, 0);
 	if (!dev || dev->fd < 0)
diff --git a/check/repair.c b/check/repair.c
index e500c4fa0a3a..bed729143cab 100644
--- a/check/repair.c
+++ b/check/repair.c
@@ -258,8 +258,8 @@ static int populate_used_from_extent_root(struct btrfs_root *root,
 			end = start + fs_info->nodesize - 1;
 
 		if (start != end) {
-			if (!IS_ALIGNED(start, fs_info->sectorsize) ||
-			    !IS_ALIGNED(end + 1, fs_info->sectorsize)) {
+			if (!IS_ALIGNED(start, fs_info->blocksize) ||
+			    !IS_ALIGNED(end + 1, fs_info->blocksize)) {
 				fprintf(stderr, "unaligned value in the extent tree start %llu end %llu\n",
 						start, end + 1);
 				ret = -EINVAL;
diff --git a/cmds/inspect-dump-tree.c b/cmds/inspect-dump-tree.c
index 127ebb82af86..8259379de8b0 100644
--- a/cmds/inspect-dump-tree.c
+++ b/cmds/inspect-dump-tree.c
@@ -291,13 +291,13 @@ static int dump_print_tree_blocks(struct btrfs_fs_info *fs_info,
 
 		/*
 		 * Please note that here we can't check it against nodesize,
-		 * as it's possible a chunk is just aligned to sectorsize but
+		 * as it's possible a chunk is just aligned to blocksize but
 		 * not aligned to nodesize.
 		 */
-		if (!IS_ALIGNED(bytenr, fs_info->sectorsize)) {
+		if (!IS_ALIGNED(bytenr, fs_info->blocksize)) {
 			error(
-		"tree block bytenr %llu is not aligned to sectorsize %u",
-			      bytenr, fs_info->sectorsize);
+		"tree block bytenr %llu is not aligned to blocksize %u",
+			      bytenr, fs_info->blocksize);
 			ret = -EINVAL;
 			goto next;
 		}
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 60a705817c80..8bbf5b6deb4f 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -49,7 +49,7 @@ struct recover_control {
 
 	u16 csum_size;
 	u16 csum_type;
-	u32 sectorsize;
+	u32 blocksize;
 	u32 nodesize;
 	u64 generation;
 	u64 chunk_root_generation;
@@ -475,7 +475,7 @@ static void print_scan_result(struct recover_control *rc)
 
 	printf("DEVICE SCAN RESULT:\n");
 	printf("Filesystem Information:\n");
-	printf("\tsectorsize: %d\n", rc->sectorsize);
+	printf("\tblocksize: %d\n", rc->blocksize);
 	printf("\tnodesize: %d\n", rc->nodesize);
 	printf("\ttree root generation: %llu\n", rc->generation);
 	printf("\tchunk root generation: %llu\n", rc->chunk_root_generation);
@@ -770,7 +770,7 @@ static int scan_one_device(void *dev_scan_struct)
 		dev_scan->bytenr = bytenr;
 
 		if (is_super_block_address(bytenr))
-			bytenr += rc->sectorsize;
+			bytenr += rc->blocksize;
 
 		if (pread(fd, buf->data, rc->nodesize, bytenr) <
 		    rc->nodesize)
@@ -779,13 +779,13 @@ static int scan_one_device(void *dev_scan_struct)
 		if (memcmp_extent_buffer(buf, rc->fs_devices->metadata_uuid,
 					 btrfs_header_fsid(),
 					 BTRFS_FSID_SIZE)) {
-			bytenr += rc->sectorsize;
+			bytenr += rc->blocksize;
 			continue;
 		}
 
 		if (verify_tree_block_csum_silent(buf, rc->csum_size,
 						  rc->csum_type)) {
-			bytenr += rc->sectorsize;
+			bytenr += rc->blocksize;
 			continue;
 		}
 
@@ -1086,7 +1086,7 @@ again:
 
 	if (key.objectid < end) {
 		if (key.type == BTRFS_BLOCK_GROUP_ITEM_KEY) {
-			key.objectid += fs_info->sectorsize;
+			key.objectid += fs_info->blocksize;
 			key.type = BTRFS_EXTENT_ITEM_KEY;
 			key.offset = 0;
 		}
@@ -1471,7 +1471,7 @@ open_ctree_with_broken_chunk(struct recover_control *rc)
 	}
 
 	UASSERT(!memcmp(disk_super->fsid, rc->fs_devices->fsid, BTRFS_FSID_SIZE));
-	fs_info->sectorsize = btrfs_super_sectorsize(disk_super);
+	fs_info->blocksize = btrfs_super_sectorsize(disk_super);
 	fs_info->nodesize = btrfs_super_nodesize(disk_super);
 	fs_info->stripesize = btrfs_super_stripesize(disk_super);
 
@@ -1535,7 +1535,7 @@ static int recover_prepare(struct recover_control *rc, const char *path)
 		goto out_close_fd;
 	}
 
-	rc->sectorsize = btrfs_super_sectorsize(&sb);
+	rc->blocksize = btrfs_super_sectorsize(&sb);
 	rc->nodesize = btrfs_super_nodesize(&sb);
 	rc->generation = btrfs_super_generation(&sb);
 	rc->chunk_root_generation = btrfs_super_chunk_root_generation(&sb);
@@ -1822,7 +1822,7 @@ static int next_csum(struct btrfs_root *csum_root,
 {
 	int ret = 0;
 	struct btrfs_csum_item *csum_item;
-	u32 blocksize = csum_root->fs_info->sectorsize;
+	u32 blocksize = csum_root->fs_info->blocksize;
 	u16 csum_size = csum_root->fs_info->csum_size;
 	int csums_in_item = btrfs_item_size(*leaf, *slot) / csum_size;
 
@@ -1906,7 +1906,7 @@ out:
 
 static u64 item_end_offset(struct btrfs_root *root, struct btrfs_key *key,
 			   struct extent_buffer *leaf, int slot) {
-	u32 blocksize = root->fs_info->sectorsize;
+	u32 blocksize = root->fs_info->blocksize;
 	u16 csum_size = root->fs_info->csum_size;
 
 	u64 offset = btrfs_item_size(leaf, slot);
@@ -1996,7 +1996,7 @@ static int rebuild_raid_data_chunk_stripes(struct recover_control *rc,
 	u64 chunk_end = chunk->offset + chunk->length;
 	u64 csum_offset = 0;
 	u64 data_offset;
-	u32 blocksize = root->fs_info->sectorsize;
+	u32 blocksize = root->fs_info->blocksize;
 	u32 tree_csum;
 	int index = 0;
 	int num_unordered = 0;
@@ -2228,7 +2228,7 @@ static int btrfs_recover_chunks(struct recover_control *rc)
 		chunk->type_flags = bg->flags;
 		chunk->io_width = BTRFS_STRIPE_LEN;
 		chunk->io_align = BTRFS_STRIPE_LEN;
-		chunk->sector_size = rc->sectorsize;
+		chunk->sector_size = rc->blocksize;
 		chunk->sub_stripes = btrfs_bg_type_to_sub_stripes(bg->flags);
 
 		ret = insert_cache_extent(&rc->chunk, &chunk->cache);
diff --git a/cmds/restore.c b/cmds/restore.c
index 6bc619b347d1..a339e039affc 100644
--- a/cmds/restore.c
+++ b/cmds/restore.c
@@ -139,7 +139,7 @@ static int decompress_lzo(struct btrfs_root *root, unsigned char *inbuf,
 
 		inbuf += LZO_LEN;
 		tot_in += LZO_LEN;
-		new_len = lzo1x_worst_compress(root->fs_info->sectorsize);
+		new_len = lzo1x_worst_compress(root->fs_info->blocksize);
 		ret = lzo1x_decompress_safe((const unsigned char *)inbuf, in_len,
 					    (unsigned char *)outbuf,
 					    (void *)&new_len, NULL);
@@ -156,8 +156,8 @@ static int decompress_lzo(struct btrfs_root *root, unsigned char *inbuf,
 		 * If the 4 byte header does not fit to the rest of the page we
 		 * have to move to the next one, unless we read some garbage
 		 */
-		mod_page = tot_in % root->fs_info->sectorsize;
-		rem_page = root->fs_info->sectorsize - mod_page;
+		mod_page = tot_in % root->fs_info->blocksize;
+		rem_page = root->fs_info->blocksize - mod_page;
 		if (rem_page < LZO_LEN) {
 			inbuf += rem_page;
 			tot_in += rem_page;
diff --git a/common/clear-cache.c b/common/clear-cache.c
index 6493866d82b8..38c02a2b41bc 100644
--- a/common/clear-cache.c
+++ b/common/clear-cache.c
@@ -369,7 +369,7 @@ static int check_space_cache(struct btrfs_root *root, struct task_ctx *task_ctx)
 		start = cache->start + cache->length;
 		if (!cache->free_space_ctl) {
 			if (btrfs_init_free_space_ctl(cache,
-						fs_info->sectorsize)) {
+						fs_info->blocksize)) {
 				ret = -ENOMEM;
 				break;
 			}
diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 7aaddab6a192..c91502fe1327 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -588,10 +588,10 @@ u32 get_running_kernel_version(void)
 /*
  * Check if current kernel supports the given size
  */
-static bool check_supported_sectorsize(u32 sectorsize)
+static bool check_supported_blocksize(u32 blocksize)
 {
 	char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
-	char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
+	char blocksize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
 	char *this_char;
 	char *save_ptr = NULL;
 	int fd;
@@ -604,7 +604,7 @@ static bool check_supported_sectorsize(u32 sectorsize)
 	close(fd);
 	if (ret < 0)
 		return false;
-	snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE, "%u", sectorsize);
+	snprintf(blocksize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE, "%u", blocksize);
 
 	for (this_char = strtok_r(supported_buf, " ", &save_ptr);
 	     this_char != NULL;
@@ -613,61 +613,61 @@ static bool check_supported_sectorsize(u32 sectorsize)
 		 * Also check the terminal '\0' to handle cases like
 		 * "4096" and "40960".
 		 */
-		if (!strncmp(this_char, sectorsize_buf, strlen(sectorsize_buf) + 1))
+		if (!strncmp(this_char, blocksize_buf, strlen(blocksize_buf) + 1))
 			return true;
 	}
 	return false;
 }
 
-int btrfs_check_sectorsize(u32 sectorsize)
+int btrfs_check_blocksize(u32 blocksize)
 {
-	bool sectorsize_checked = false;
+	bool blocksize_checked = false;
 	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
 
-	if (!is_power_of_2(sectorsize)) {
-		error("invalid sectorsize %u, must be power of 2", sectorsize);
+	if (!is_power_of_2(blocksize)) {
+		error("invalid blocksize %u, must be power of 2", blocksize);
 		return -EINVAL;
 	}
-	if (sectorsize < SZ_4K || sectorsize > SZ_64K) {
-		error("invalid sectorsize %u, expected range is [4K, 64K]",
-		      sectorsize);
+	if (blocksize < SZ_4K || blocksize > SZ_64K) {
+		error("invalid blocksize %u, expected range is [4K, 64K]",
+		      blocksize);
 		return -EINVAL;
 	}
-	if (page_size == sectorsize)
-		sectorsize_checked = true;
+	if (page_size == blocksize)
+		blocksize_checked = true;
 	else
-		sectorsize_checked = check_supported_sectorsize(sectorsize);
+		blocksize_checked = check_supported_blocksize(blocksize);
 
-	if (!sectorsize_checked)
+	if (!blocksize_checked)
 		warning(
-"sectorsize %u does not match host CPU page size %u, with kernels 6.x and up\n"
-"\t the 4KiB sectorsize is supported on all architectures but other combinations\n"
-"\t may fail the filesystem mount, use \"--sectorsize %u\" to override that\n",
-			sectorsize, page_size, page_size);
+"blocksize %u does not match host CPU page size %u, with kernels 6.x and up\n"
+"\t the 4KiB blocksize is supported on all architectures but other combinations\n"
+"\t may fail the filesystem mount, use \"--blocksize %u\" to override that\n",
+			blocksize, page_size, page_size);
 	return 0;
 }
 
-int btrfs_check_nodesize(u32 nodesize, u32 sectorsize,
+int btrfs_check_nodesize(u32 nodesize, u32 blocksize,
 			 struct btrfs_mkfs_features *features)
 {
-	if (nodesize < sectorsize) {
+	if (nodesize < blocksize) {
 		error("illegal nodesize %u (smaller than %u)",
-				nodesize, sectorsize);
+				nodesize, blocksize);
 		return -1;
 	} else if (nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
 		error("illegal nodesize %u (larger than %u)",
 			nodesize, BTRFS_MAX_METADATA_BLOCKSIZE);
 		return -1;
-	} else if (nodesize & (sectorsize - 1)) {
+	} else if (nodesize & (blocksize - 1)) {
 		error("illegal nodesize %u (not aligned to %u)",
-			nodesize, sectorsize);
+			nodesize, blocksize);
 		return -1;
 	} else if (features->incompat_flags &
 		   BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS &&
-		   nodesize != sectorsize) {
+		   nodesize != blocksize) {
 		error(
 		"illegal nodesize %u (not equal to %u for mixed block group)",
-			nodesize, sectorsize);
+			nodesize, blocksize);
 		return -1;
 	}
 	return 0;
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index f636171f6bd9..ccb241b006e1 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -86,9 +86,9 @@ void btrfs_parse_runtime_features_to_string(char *buf,
 		const struct btrfs_mkfs_features *features);
 void print_kernel_version(FILE *stream, u32 version);
 u32 get_running_kernel_version(void);
-int btrfs_check_nodesize(u32 nodesize, u32 sectorsize,
+int btrfs_check_nodesize(u32 nodesize, u32 blocksize,
 			 struct btrfs_mkfs_features *features);
-int btrfs_check_sectorsize(u32 sectorsize);
+int btrfs_check_blocksize(u32 blocksize);
 int btrfs_check_features(const struct btrfs_mkfs_features *features,
 			 const struct btrfs_mkfs_features *allowed);
 int btrfs_tree_search2_ioctl_supported(int fd);
diff --git a/convert/common.c b/convert/common.c
index 802b809ca837..e7bd0309225f 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -109,7 +109,7 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
 	struct btrfs_super_block super = {};
 	int ret;
 
-	cfg->num_bytes = round_down(cfg->num_bytes, cfg->sectorsize);
+	cfg->num_bytes = round_down(cfg->num_bytes, cfg->blocksize);
 
 	if (*cfg->fs_uuid) {
 		if (uuid_parse(cfg->fs_uuid, super.fsid) != 0) {
@@ -143,7 +143,7 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
 	 * and csum tree.
 	 */
 	btrfs_set_super_bytes_used(&super, 6 * cfg->nodesize);
-	btrfs_set_super_sectorsize(&super, cfg->sectorsize);
+	btrfs_set_super_sectorsize(&super, cfg->blocksize);
 	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
 	btrfs_set_super_nodesize(&super, cfg->nodesize);
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
@@ -344,9 +344,9 @@ static int insert_temp_dev_item(int fd, struct extent_buffer *buf,
 	btrfs_set_device_bytes_used(buf, dev_item,
 			BTRFS_MKFS_SYSTEM_GROUP_SIZE +
 			BTRFS_CONVERT_META_GROUP_SIZE);
-	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
-	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
-	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
+	btrfs_set_device_io_align(buf, dev_item, cfg->blocksize);
+	btrfs_set_device_io_width(buf, dev_item, cfg->blocksize);
+	btrfs_set_device_sector_size(buf, dev_item, cfg->blocksize);
 	btrfs_set_device_type(buf, dev_item, 0);
 
 	/* Super dev_item is not complete, copy the complete one to sb */
@@ -388,9 +388,9 @@ static int insert_temp_chunk_item(int fd, struct extent_buffer *buf,
 	btrfs_set_chunk_owner(buf, chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_chunk_stripe_len(buf, chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_chunk_type(buf, chunk, type);
-	btrfs_set_chunk_io_align(buf, chunk, cfg->sectorsize);
-	btrfs_set_chunk_io_width(buf, chunk, cfg->sectorsize);
-	btrfs_set_chunk_sector_size(buf, chunk, cfg->sectorsize);
+	btrfs_set_chunk_io_align(buf, chunk, cfg->blocksize);
+	btrfs_set_chunk_io_width(buf, chunk, cfg->blocksize);
+	btrfs_set_chunk_sector_size(buf, chunk, cfg->blocksize);
 	btrfs_set_chunk_num_stripes(buf, chunk, 1);
 	/* TODO: Support DUP profile for system chunk */
 	btrfs_set_stripe_devid_nr(buf, chunk, 0, 1);
diff --git a/convert/main.c b/convert/main.c
index 805682705dff..8878a3782aff 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -191,7 +191,7 @@ static int csum_disk_extent(struct btrfs_trans_handle *trans,
 			    u64 disk_bytenr, u64 num_bytes)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	u32 blocksize = fs_info->sectorsize;
+	u32 blocksize = fs_info->blocksize;
 	u64 offset;
 	char *buffer;
 	int ret = 0;
@@ -237,12 +237,12 @@ static int create_image_file_range(struct btrfs_trans_handle *trans,
 	int ret;
 	u32 datacsum = convert_flags & CONVERT_FLAG_DATACSUM;
 
-	if (bytenr != round_down(bytenr, root->fs_info->sectorsize)) {
-		error("bytenr not sectorsize aligned: %llu", bytenr);
+	if (bytenr != round_down(bytenr, root->fs_info->blocksize)) {
+		error("bytenr not blocksize aligned: %llu", bytenr);
 		return -EINVAL;
 	}
-	if (len != round_down(len, root->fs_info->sectorsize)) {
-		error("length not sectorsize aligned: %llu", len);
+	if (len != round_down(len, root->fs_info->blocksize)) {
+		error("length not blocksize aligned: %llu", len);
 		return -EINVAL;
 	}
 	len = min_t(u64, len, BTRFS_MAX_EXTENT_SIZE);
@@ -333,8 +333,8 @@ static int create_image_file_range(struct btrfs_trans_handle *trans,
 				bytenr);
 	}
 
-	if (len != round_down(len, root->fs_info->sectorsize)) {
-		error("remaining length not sectorsize aligned: %llu", len);
+	if (len != round_down(len, root->fs_info->blocksize)) {
+		error("remaining length not blocksize aligned: %llu", len);
 		return -EINVAL;
 	}
 	ret = btrfs_convert_file_extent(trans, root, ino, inode, bytenr,
@@ -395,9 +395,9 @@ static int migrate_one_reserved_range(struct btrfs_trans_handle *trans,
 			break;
 		cur_len = min(cache->start + cache->size, range_end(range)) -
 			  cur_off;
-		if (cur_len < root->fs_info->sectorsize) {
-			error("reserved range cannot be migrated: length %llu < sectorsize %u",
-				cur_len, root->fs_info->sectorsize);
+		if (cur_len < root->fs_info->blocksize) {
+			error("reserved range cannot be migrated: length %llu < blocksize %u",
+				cur_len, root->fs_info->blocksize);
 			ret = -EUCLEAN;
 			break;
 		}
@@ -937,7 +937,7 @@ static int make_convert_data_block_groups(struct btrfs_trans_handle *trans,
 	 */
 	max_chunk_size = cfg->num_bytes / 10;
 	max_chunk_size = min((u64)(SZ_1G), max_chunk_size);
-	max_chunk_size = round_down(max_chunk_size, fs_info->sectorsize);
+	max_chunk_size = round_down(max_chunk_size, fs_info->blocksize);
 
 	for (cache = first_cache_extent(data_chunks); cache;
 	     cache = next_cache_extent(cache)) {
@@ -1265,7 +1265,7 @@ static int do_convert(const char *devname, u32 convert_flags, u32 nodesize,
 	mkfs_cfg.label = cctx.label;
 	mkfs_cfg.num_bytes = cctx.total_bytes;
 	mkfs_cfg.nodesize = nodesize;
-	mkfs_cfg.sectorsize = blocksize;
+	mkfs_cfg.blocksize = blocksize;
 	mkfs_cfg.stripesize = blocksize;
 	memcpy(&mkfs_cfg.features, features, sizeof(struct btrfs_mkfs_features));
 	mkfs_cfg.leaf_data_size = __BTRFS_LEAF_DATA_SIZE(nodesize);
diff --git a/convert/source-ext2.c b/convert/source-ext2.c
index fde3fff044ab..0d13c5bf1409 100644
--- a/convert/source-ext2.c
+++ b/convert/source-ext2.c
@@ -307,12 +307,12 @@ static int ext2_block_iterate_proc(ext2_filsys fs, blk_t *blocknr,
 static int iterate_one_file_extent(struct blk_iterate_data *data, u64 filepos,
 				   u64 len, u64 disk_bytenr, bool prealloced)
 {
-	const int sectorsize = data->trans->fs_info->sectorsize;
-	const int sectorbits = ilog2(sectorsize);
+	const int blocksize = data->trans->fs_info->blocksize;
+	const int sectorbits = ilog2(blocksize);
 	int ret;
 
 	UASSERT(len > 0);
-	for (int i = 0; i < len; i += sectorsize) {
+	for (int i = 0; i < len; i += blocksize) {
 		/*
 		 * Just treat preallocated extent as hole.
 		 *
@@ -336,8 +336,8 @@ static int iterate_file_extents(struct blk_iterate_data *data, ext2_filsys ext2f
 {
 	ext2_extent_handle_t handle = NULL;
 	struct ext2fs_extent extent;
-	const int sectorsize = data->trans->fs_info->sectorsize;
-	const int sectorbits = ilog2(sectorsize);
+	const int blocksize = data->trans->fs_info->blocksize;
+	const int sectorbits = ilog2(blocksize);
 	int op = EXT2_EXTENT_ROOT;
 	errcode_t errcode;
 	int ret = 0;
@@ -396,7 +396,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 	errcode_t err;
 	struct ext2_inode ext2_inode = { 0 };
 	u32 last_block;
-	u32 sectorsize = root->fs_info->sectorsize;
+	u32 blocksize = root->fs_info->blocksize;
 	u64 inode_size = btrfs_stack_inode_size(btrfs_inode);
 	bool meet_inline_size_limit;
 	struct blk_iterate_data data;
@@ -444,8 +444,8 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 		goto fail;
 	if ((convert_flags & CONVERT_FLAG_INLINE_DATA) && data.first_block == 0
 	    && data.num_blocks > 0 && meet_inline_size_limit) {
-		u64 num_bytes = data.num_blocks * sectorsize;
-		u64 disk_bytenr = data.disk_block * sectorsize;
+		u64 num_bytes = data.num_blocks * blocksize;
+		u64 disk_bytenr = data.disk_block * blocksize;
 		u64 nbytes;
 
 		buffer = malloc(num_bytes);
@@ -471,7 +471,7 @@ static int ext2_create_file_extents(struct btrfs_trans_handle *trans,
 			goto fail;
 	}
 	data.first_block += data.num_blocks;
-	last_block = (inode_size + sectorsize - 1) / sectorsize;
+	last_block = (inode_size + blocksize - 1) / blocksize;
 	if (last_block > data.first_block) {
 		ret = record_file_blocks(&data, data.first_block, 0,
 					 last_block - data.first_block);
diff --git a/convert/source-fs.c b/convert/source-fs.c
index 8a296bd9c7f4..6cc2f7287609 100644
--- a/convert/source-fs.c
+++ b/convert/source-fs.c
@@ -103,10 +103,10 @@ int block_iterate_proc(u64 disk_block, u64 file_block,
 	int do_barrier;
 	struct btrfs_root *root = idata->root;
 	struct btrfs_block_group *cache;
-	u32 sectorsize = root->fs_info->sectorsize;
-	u64 bytenr = disk_block * sectorsize;
+	u32 blocksize = root->fs_info->blocksize;
+	u64 bytenr = disk_block * blocksize;
 
-	reserved = intersect_with_reserved(bytenr, sectorsize);
+	reserved = intersect_with_reserved(bytenr, blocksize);
 	do_barrier = reserved || disk_block >= idata->boundary;
 	if ((idata->num_blocks > 0 && do_barrier) ||
 	    (file_block > idata->first_block + idata->num_blocks) ||
@@ -141,7 +141,7 @@ int block_iterate_proc(u64 disk_block, u64 file_block,
 
 		idata->first_block = file_block;
 		idata->disk_block = disk_block;
-		idata->boundary = bytenr / sectorsize;
+		idata->boundary = bytenr / blocksize;
 	}
 	idata->num_blocks++;
 fail:
@@ -252,10 +252,10 @@ int record_file_blocks(struct blk_iterate_data *data,
 	struct btrfs_root *root = data->root;
 	struct btrfs_root *convert_root = data->convert_root;
 	struct btrfs_path path = { 0 };
-	u32 sectorsize = root->fs_info->sectorsize;
-	u64 file_pos = file_block * sectorsize;
-	u64 old_disk_bytenr = disk_block * sectorsize;
-	u64 num_bytes = num_blocks * sectorsize;
+	u32 blocksize = root->fs_info->blocksize;
+	u64 file_pos = file_block * blocksize;
+	u64 old_disk_bytenr = disk_block * blocksize;
+	u64 num_bytes = num_blocks * blocksize;
 	u64 cur_off = old_disk_bytenr;
 
 	/* Hole, pass it to record_file_extent directly */
diff --git a/convert/source-reiserfs.c b/convert/source-reiserfs.c
index 82fc6afbf0d2..261fb89bcf46 100644
--- a/convert/source-reiserfs.c
+++ b/convert/source-reiserfs.c
@@ -351,21 +351,21 @@ static int convert_direct(struct btrfs_trans_handle *trans,
 			  u32 length, u64 offset, u32 convert_flags)
 {
 	struct btrfs_key key;
-	u32 sectorsize = root->fs_info->sectorsize;
+	u32 blocksize = root->fs_info->blocksize;
 	int ret;
 
-	BUG_ON(length > sectorsize);
-	ret = btrfs_reserve_extent(trans, root, sectorsize,
+	BUG_ON(length > blocksize);
+	ret = btrfs_reserve_extent(trans, root, blocksize,
 				   0, 0, -1ULL, &key, 1);
 	if (ret)
 		return ret;
 
-	ret = write_data_to_disk(root->fs_info, body, key.objectid, sectorsize);
+	ret = write_data_to_disk(root->fs_info, body, key.objectid, blocksize);
 	if (ret)
 		return ret;
 
 	return btrfs_convert_file_extent(trans, root, objectid, inode, offset,
-					key.objectid, sectorsize);
+					key.objectid, blocksize);
 }
 
 static int reiserfs_convert_tail(struct btrfs_trans_handle *trans,
@@ -379,7 +379,7 @@ static int reiserfs_convert_tail(struct btrfs_trans_handle *trans,
 	int ret;
 
 	if (length >= BTRFS_MAX_INLINE_DATA_SIZE(root->fs_info) ||
-	    length >= root->fs_info->sectorsize)
+	    length >= root->fs_info->blocksize)
 		return convert_direct(trans, root, objectid, inode, body,
 				      length, offset, convert_flags);
 
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index b8f7a19b64b4..3c490515be73 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -391,7 +391,8 @@ struct btrfs_fs_info {
 
 	/* Cached block sizes */
 	u32 nodesize;
-	u32 sectorsize;
+	/* Minimum data unit size, used to be called "sectorsize". */
+	u32 blocksize;
 	u32 stripesize;
 	u32 leaf_data_size;
 
@@ -653,7 +654,7 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
  * When a block group becomes very fragmented, we convert it to use bitmaps
  * instead of extents. A free space bitmap is keyed on
  * (start, FREE_SPACE_BITMAP, length); the corresponding item is a bitmap with
- * (length / sectorsize) bits.
+ * (length / blocksize) bits.
  */
 #define BTRFS_FREE_SPACE_BITMAP_KEY 200
 
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 3e8cab1187f0..c6189697675f 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -441,7 +441,7 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 {
 	int ret;
 	struct extent_buffer *eb;
-	u32 sectorsize = fs_info->sectorsize;
+	u32 blocksize = fs_info->blocksize;
 
 	/*
 	 * Don't even try to create tree block for unaligned tree block
@@ -449,9 +449,9 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	 * Such unaligned tree block will free overlapping extent buffer,
 	 * causing use-after-free bugs for fuzzed images.
 	 */
-	if (bytenr < sectorsize || !IS_ALIGNED(bytenr, sectorsize)) {
-		error("tree block bytenr %llu is not aligned to sectorsize %u",
-		      bytenr, sectorsize);
+	if (bytenr < blocksize || !IS_ALIGNED(bytenr, blocksize)) {
+		error("tree block bytenr %llu is not aligned to blocksize %u",
+		      bytenr, blocksize);
 		return ERR_PTR(-EIO);
 	}
 
@@ -1453,9 +1453,9 @@ int btrfs_setup_chunk_tree_and_device_map(struct btrfs_fs_info *fs_info,
 	generation = btrfs_super_chunk_root_generation(sb);
 
 	if (chunk_root_bytenr && !IS_ALIGNED(chunk_root_bytenr,
-					    fs_info->sectorsize)) {
+					    fs_info->blocksize)) {
 		warning("chunk_root_bytenr %llu is unaligned to %u, ignore it",
-			chunk_root_bytenr, fs_info->sectorsize);
+			chunk_root_bytenr, fs_info->blocksize);
 		chunk_root_bytenr = 0;
 	}
 
@@ -1587,7 +1587,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_args *oca
 		ASSERT(!memcmp(disk_super->metadata_uuid,
 			       fs_devices->metadata_uuid, BTRFS_FSID_SIZE));
 
-	fs_info->sectorsize = btrfs_super_sectorsize(disk_super);
+	fs_info->blocksize = btrfs_super_sectorsize(disk_super);
 	fs_info->nodesize = btrfs_super_nodesize(disk_super);
 	fs_info->stripesize = btrfs_super_stripesize(disk_super);
 	fs_info->csum_type = btrfs_super_csum_type(disk_super);
@@ -1742,7 +1742,7 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 
 /*
  * Check if the super is valid:
- * - nodesize/sectorsize - minimum, maximum, alignment
+ * - nodesize/blocksize - minimum, maximum, alignment
  * - tree block starts   - alignment
  * - number of devices   - something sane
  * - sys array size      - maximum
@@ -1817,12 +1817,12 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 		goto error_out;
 	}
 	if (btrfs_super_sectorsize(sb) < 4096) {
-		error("sectorsize too small: %u < 4096",
+		error("blocksize too small: %u < 4096",
 			btrfs_super_sectorsize(sb));
 		goto error_out;
 	}
 	if (!IS_ALIGNED(btrfs_super_sectorsize(sb), 4096)) {
-		error("sectorsize unaligned: %u", btrfs_super_sectorsize(sb));
+		error("blocksize unaligned: %u", btrfs_super_sectorsize(sb));
 		goto error_out;
 	}
 	if (btrfs_super_total_bytes(sb) == 0) {
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 0047db5e7c3e..c0252ba3f25f 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -229,7 +229,7 @@ int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type, const u8 *data
 		    u8 *out, size_t len);
 
 int btrfs_open_device(struct btrfs_device *dev);
-int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
+int csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 			 int verify, u16 csum_type);
 int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size,
 				  u16 csum_type);
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index af04b9eadcc5..7fcb5a95b052 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1845,7 +1845,7 @@ static int update_pinned_extents(struct btrfs_fs_info *fs_info,
 	while (num > 0) {
 		cache = btrfs_lookup_block_group(fs_info, bytenr);
 		if (!cache) {
-			len = min((u64)fs_info->sectorsize, num);
+			len = min((u64)fs_info->blocksize, num);
 			goto next;
 		}
 		WARN_ON(!cache);
@@ -2169,7 +2169,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans,
 {
 	int ret;
 
-	WARN_ON(num_bytes < trans->fs_info->sectorsize);
+	WARN_ON(num_bytes < trans->fs_info->blocksize);
 	/*
 	 * tree log blocks never actually go into the extent allocation
 	 * tree, just update pinning info and exit early.
@@ -2223,7 +2223,7 @@ static int noinline find_free_extent(struct btrfs_trans_handle *trans,
 	int full_scan = 0;
 	int wrapped = 0;
 
-	WARN_ON(num_bytes < info->sectorsize);
+	WARN_ON(num_bytes < info->blocksize);
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 
 	search_start = stripe_align(root, search_start);
@@ -2382,7 +2382,7 @@ int btrfs_reserve_extent(struct btrfs_trans_handle *trans,
 		BUG_ON(ret);
 	}
 
-	WARN_ON(num_bytes < info->sectorsize);
+	WARN_ON(num_bytes < info->blocksize);
 	ret = find_free_extent(trans, root, num_bytes, empty_size,
 			       search_start, search_end, hint_byte, ins,
 			       trans->alloc_exclude_start,
@@ -3136,7 +3136,7 @@ int btrfs_make_block_groups(struct btrfs_trans_handle *trans,
 	struct btrfs_block_group *cache;
 
 	total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
-	group_align = 64 * fs_info->sectorsize;
+	group_align = 64 * fs_info->blocksize;
 
 	cur_start = 0;
 	while (cur_start < total_bytes) {
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index 3b0078e003bf..74a678e1c6cc 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -148,7 +148,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 			goto fail;
 
 		csum_offset = (bytenr - found_key.offset) /
-				root->fs_info->sectorsize;
+				root->fs_info->blocksize;
 		csums_in_item = btrfs_item_size(leaf, path->slots[0]);
 		csums_in_item /= csum_size;
 
@@ -181,7 +181,7 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 logical,
 	struct extent_buffer *leaf = NULL;
 	u64 csum_offset;
 	u8 csum_result[BTRFS_CSUM_SIZE];
-	u32 sectorsize = root->fs_info->sectorsize;
+	u32 blocksize = root->fs_info->blocksize;
 	u32 nritems;
 	u32 ins_size;
 	u16 csum_size = btrfs_csum_type_size(csum_type);
@@ -256,7 +256,7 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 logical,
 	path->slots[0]--;
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
-	csum_offset = (file_key.offset - found_key.offset) / sectorsize;
+	csum_offset = (file_key.offset - found_key.offset) / blocksize;
 	if (found_key.objectid != csum_objectid ||
 	    found_key.type != BTRFS_EXTENT_CSUM_KEY ||
 	    csum_offset >= MAX_CSUM_ITEMS(root, csum_size)) {
@@ -276,9 +276,9 @@ insert:
 	btrfs_release_path(path);
 	csum_offset = 0;
 	if (found_next) {
-		u64 tmp = min(logical + sectorsize, next_offset);
+		u64 tmp = min(logical + blocksize, next_offset);
 		tmp -= file_key.offset;
-		tmp /= sectorsize;
+		tmp /= blocksize;
 		tmp = max((u64)1, tmp);
 		tmp = min(tmp, (u64)MAX_CSUM_ITEMS(root, csum_size));
 		ins_size = csum_size * tmp;
@@ -301,7 +301,7 @@ csum:
 					  csum_offset * csum_size);
 found:
 	btrfs_csum_data(root->fs_info, csum_type, (u8 *)data, csum_result,
-			sectorsize);
+			blocksize);
 	write_extent_buffer(leaf, csum_result, (unsigned long)item,
 			    csum_size);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
@@ -330,11 +330,11 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 	u16 csum_size = root->fs_info->csum_size;
 	u64 csum_end;
 	u64 end_byte = bytenr + len;
-	u32 blocksize = root->fs_info->sectorsize;
+	u32 blocksize = root->fs_info->blocksize;
 
 	leaf = path->nodes[0];
 	csum_end = btrfs_item_size(leaf, path->slots[0]) / csum_size;
-	csum_end *= root->fs_info->sectorsize;
+	csum_end *= root->fs_info->blocksize;
 	csum_end += key->offset;
 
 	if (key->offset < bytenr && csum_end <= end_byte) {
@@ -382,7 +382,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	struct extent_buffer *leaf;
 	int ret;
 	u16 csum_size = trans->fs_info->csum_size;
-	int blocksize = trans->fs_info->sectorsize;
+	int blocksize = trans->fs_info->blocksize;
 
 	path = btrfs_alloc_path();
 	if (!path)
diff --git a/kernel-shared/file-item.h b/kernel-shared/file-item.h
index f2d65f5d0ed5..6a9d3658bf05 100644
--- a/kernel-shared/file-item.h
+++ b/kernel-shared/file-item.h
@@ -98,7 +98,7 @@ int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
  * For symlink we allow up to PATH_MAX - 1 (PATH_MAX includes the terminating NUL,
  * but fs doesn't store that terminating NUL).
  *
- * But for inlined data extents, the up limit is sectorsize - 1 (inclusive), or a
+ * But for inlined data extents, the up limit is blocksize - 1 (inclusive), or a
  * regular extent should be created instead.
  */
 static inline u32 btrfs_symlink_max_size(struct btrfs_fs_info *fs_info)
@@ -110,7 +110,7 @@ static inline u32 btrfs_symlink_max_size(struct btrfs_fs_info *fs_info)
 static inline u32 btrfs_data_inline_max_size(struct btrfs_fs_info *fs_info)
 {
 	return min_t(u32, BTRFS_MAX_INLINE_DATA_SIZE(fs_info),
-		     fs_info->sectorsize - 1);
+		     fs_info->blocksize - 1);
 }
 
 #endif
diff --git a/kernel-shared/file.c b/kernel-shared/file.c
index 7ed1b6891795..70870898f5c3 100644
--- a/kernel-shared/file.c
+++ b/kernel-shared/file.c
@@ -181,14 +181,14 @@ out:
  *
  * @root:  fs/subvolume root containing the inode
  * @ino:   inode number
- * @start: offset inside the file, aligned to sectorsize
- * @len:   length to read, aligned to sectorisize
+ * @start: offset inside the file, aligned to blocksize
+ * @len:   length to read, aligned to blocksize
  * @dest:  where data will be stored
  *
  * NOTE:
  * 1) compression data is not supported yet
- * 2) @start and @len must be aligned to sectorsize
- * 3) data read out is also aligned to sectorsize, not truncated to inode size
+ * 2) @start and @len must be aligned to blocksize
+ * 3) data read out is also aligned to blocksize, not truncated to inode size
  *
  * Return < 0 for fatal error during read.
  * Otherwise return the number of successfully read data in bytes.
@@ -207,10 +207,10 @@ int btrfs_read_file(struct btrfs_root *root, u64 ino, u64 start, int len,
 	int read = 0;
 	int ret;
 
-	if (!IS_ALIGNED(start, fs_info->sectorsize) ||
-	    !IS_ALIGNED(len, fs_info->sectorsize)) {
+	if (!IS_ALIGNED(start, fs_info->blocksize) ||
+	    !IS_ALIGNED(len, fs_info->blocksize)) {
 		warning("@start and @len must be aligned to %u for function %s",
-			fs_info->sectorsize, __func__);
+			fs_info->blocksize, __func__);
 		return -EINVAL;
 	}
 
@@ -272,7 +272,7 @@ int btrfs_read_file(struct btrfs_root *root, u64 ino, u64 start, int len,
 				goto next;
 			read_extent_buffer(leaf, dest,
 				btrfs_file_extent_inline_start(fi), extent_len);
-			read += round_up(extent_len, fs_info->sectorsize);
+			read += round_up(extent_len, fs_info->blocksize);
 			break;
 		}
 
@@ -333,7 +333,7 @@ next:
 		ii = btrfs_item_ptr(path.nodes[0], path.slots[0],
 				    struct btrfs_inode_item);
 		isize = round_up(btrfs_inode_size(path.nodes[0], ii),
-				 fs_info->sectorsize);
+				 fs_info->blocksize);
 		read = min_t(u64, isize - start, len);
 	}
 out:
diff --git a/kernel-shared/free-space-cache.c b/kernel-shared/free-space-cache.c
index d80fe5707eb5..3d3fb5588541 100644
--- a/kernel-shared/free-space-cache.c
+++ b/kernel-shared/free-space-cache.c
@@ -35,11 +35,11 @@
 #include "common/messages.h"
 
 /*
- * Kernel always uses PAGE_CACHE_SIZE for sectorsize, but we don't have
+ * Kernel always uses PAGE_CACHE_SIZE for blocksize, but we don't have
  * anything like that in userspace and have to get the value from the
  * filesystem
  */
-#define BITS_PER_BITMAP(sectorsize)		((sectorsize) * 8)
+#define BITS_PER_BITMAP(blocksize)		((blocksize) * 8)
 #define MAX_CACHE_BYTES_PER_GIG	SZ_32K
 
 static int link_free_space(struct btrfs_free_space_ctl *ctl,
@@ -61,7 +61,7 @@ static int io_ctl_init(struct io_ctl *io_ctl, u64 size, u64 ino,
 		       struct btrfs_root *root)
 {
 	memset(io_ctl, 0, sizeof(struct io_ctl));
-	io_ctl->num_pages = DIV_ROUND_UP(size, root->fs_info->sectorsize);
+	io_ctl->num_pages = DIV_ROUND_UP(size, root->fs_info->blocksize);
 	io_ctl->buffer = kzalloc(size, GFP_NOFS);
 	if (!io_ctl->buffer)
 		return -ENOMEM;
@@ -89,11 +89,11 @@ static void io_ctl_map_page(struct io_ctl *io_ctl, int clear)
 {
 	BUG_ON(io_ctl->index >= io_ctl->num_pages);
 	io_ctl->cur = io_ctl->buffer + (io_ctl->index++ *
-					io_ctl->root->fs_info->sectorsize);
+					io_ctl->root->fs_info->blocksize);
 	io_ctl->orig = io_ctl->cur;
-	io_ctl->size = io_ctl->root->fs_info->sectorsize;
+	io_ctl->size = io_ctl->root->fs_info->blocksize;
 	if (clear)
-		memset(io_ctl->cur, 0, io_ctl->root->fs_info->sectorsize);
+		memset(io_ctl->cur, 0, io_ctl->root->fs_info->blocksize);
 }
 
 static void io_ctl_drop_pages(struct io_ctl *io_ctl)
@@ -229,7 +229,7 @@ static int io_ctl_check_crc(struct io_ctl *io_ctl, int index)
 
 	io_ctl_map_page(io_ctl, 0);
 	crc = crc32c(crc, io_ctl->orig + offset,
-			io_ctl->root->fs_info->sectorsize - offset);
+			io_ctl->root->fs_info->blocksize - offset);
 	put_unaligned_le32(~crc, (u8 *)&crc);
 	if (val != crc) {
 		printk("btrfs: csum mismatch on free space cache\n");
@@ -276,7 +276,7 @@ static int io_ctl_read_bitmap(struct io_ctl *io_ctl,
 	if (ret)
 		return ret;
 
-	memcpy(entry->bitmap, io_ctl->cur, io_ctl->root->fs_info->sectorsize);
+	memcpy(entry->bitmap, io_ctl->cur, io_ctl->root->fs_info->blocksize);
 	io_ctl_unmap_page(io_ctl);
 
 	return 0;
@@ -403,7 +403,7 @@ static int __load_free_space_cache(struct btrfs_root *root,
 		} else {
 			BUG_ON(!num_bitmaps);
 			num_bitmaps--;
-			e->bitmap = kzalloc(ctl->sectorsize, GFP_NOFS);
+			e->bitmap = kzalloc(ctl->blocksize, GFP_NOFS);
 			if (!e->bitmap) {
 				kfree(e);
 				goto free_cache;
@@ -575,7 +575,7 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 {
 	struct rb_node *n = ctl->free_space_offset.rb_node;
 	struct btrfs_free_space *entry, *prev = NULL;
-	u32 sectorsize = ctl->sectorsize;
+	u32 blocksize = ctl->blocksize;
 
 	/* find entry that is closest to the 'offset' */
 	while (1) {
@@ -660,7 +660,7 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 			    prev->offset + prev->bytes > offset)
 				return prev;
 		}
-		if (entry->offset + BITS_PER_BITMAP(sectorsize) * ctl->unit > offset)
+		if (entry->offset + BITS_PER_BITMAP(blocksize) * ctl->unit > offset)
 			return entry;
 	} else if (entry->offset + entry->bytes > offset)
 		return entry;
@@ -670,7 +670,7 @@ tree_search_offset(struct btrfs_free_space_ctl *ctl,
 
 	while (1) {
 		if (entry->bitmap) {
-			if (entry->offset + BITS_PER_BITMAP(sectorsize) *
+			if (entry->offset + BITS_PER_BITMAP(blocksize) *
 			    ctl->unit > offset)
 				break;
 		} else {
@@ -717,15 +717,15 @@ static int search_bitmap(struct btrfs_free_space_ctl *ctl,
 	unsigned long found_bits = 0;
 	unsigned long bits, i;
 	unsigned long next_zero;
-	u32 sectorsize = ctl->sectorsize;
+	u32 blocksize = ctl->blocksize;
 
 	i = offset_to_bit(bitmap_info->offset, ctl->unit,
 			  max_t(u64, *offset, bitmap_info->offset));
 	bits = bytes_to_bits(*bytes, ctl->unit);
 
-	for_each_set_bit_from(i, bitmap_info->bitmap, BITS_PER_BITMAP(sectorsize)) {
+	for_each_set_bit_from(i, bitmap_info->bitmap, BITS_PER_BITMAP(blocksize)) {
 		next_zero = find_next_zero_bit(bitmap_info->bitmap,
-					       BITS_PER_BITMAP(sectorsize), i);
+					       BITS_PER_BITMAP(blocksize), i);
 		if ((next_zero - i) >= bits) {
 			found_bits = next_zero - i;
 			break;
@@ -804,7 +804,7 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group,
 }
 
 int btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
-			      int sectorsize)
+			      int blocksize)
 {
 	struct btrfs_free_space_ctl *ctl;
 
@@ -812,8 +812,8 @@ int btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
 	if (!ctl)
 		return -ENOMEM;
 
-	ctl->sectorsize = sectorsize;
-	ctl->unit = sectorsize;
+	ctl->blocksize = blocksize;
+	ctl->unit = blocksize;
 	ctl->start = block_group->start;
 	ctl->private = block_group;
 	block_group->free_space_ctl = ctl;
@@ -871,7 +871,7 @@ static void merge_space_tree(struct btrfs_free_space_ctl *ctl)
 	struct btrfs_free_space *e, *prev = NULL;
 	struct rb_node *n;
 	int ret;
-	u32 sectorsize = ctl->sectorsize;
+	u32 blocksize = ctl->blocksize;
 
 again:
 	prev = NULL;
@@ -881,7 +881,7 @@ again:
 			u64 offset = e->offset, bytes = ctl->unit;
 			u64 end;
 
-			end = e->offset + (u64)(BITS_PER_BITMAP(sectorsize) * ctl->unit);
+			end = e->offset + (u64)(BITS_PER_BITMAP(blocksize) * ctl->unit);
 
 			unlink_free_space(ctl, e);
 			while (!(search_bitmap(ctl, e, &offset, &bytes))) {
diff --git a/kernel-shared/free-space-cache.h b/kernel-shared/free-space-cache.h
index ce5f444bc733..929da397d914 100644
--- a/kernel-shared/free-space-cache.h
+++ b/kernel-shared/free-space-cache.h
@@ -45,7 +45,7 @@ struct btrfs_free_space_ctl {
 	int unit;
 	u64 start;
 	void *private;
-	u32 sectorsize;
+	u32 blocksize;
 };
 
 int load_free_space_cache(struct btrfs_fs_info *fs_info,
@@ -57,7 +57,7 @@ void btrfs_dump_free_space(struct btrfs_block_group *block_group, u64 bytes);
 struct btrfs_free_space *
 btrfs_find_free_space(struct btrfs_free_space_ctl *ctl, u64 offset, u64 bytes);
 int btrfs_init_free_space_ctl(struct btrfs_block_group *block_group,
-			      int sectorsize);
+			      int blocksize);
 void unlink_free_space(struct btrfs_free_space_ctl *ctl,
 		       struct btrfs_free_space *info);
 int btrfs_add_free_space(struct btrfs_free_space_ctl *ctl, u64 offset,
diff --git a/kernel-shared/free-space-tree.c b/kernel-shared/free-space-tree.c
index 81fd57b886d2..a14273fa852e 100644
--- a/kernel-shared/free-space-tree.c
+++ b/kernel-shared/free-space-tree.c
@@ -57,7 +57,7 @@ void set_free_space_tree_thresholds(struct btrfs_fs_info *fs_info,
 	 * We convert to bitmaps when the disk space required for using extents
 	 * exceeds that required for using bitmaps.
 	 */
-	bitmap_range = fs_info->sectorsize * BTRFS_FREE_SPACE_BITMAP_BITS;
+	bitmap_range = fs_info->blocksize * BTRFS_FREE_SPACE_BITMAP_BITS;
 	num_bitmaps = div_u64(cache->start + bitmap_range - 1, bitmap_range);
 	bitmap_size = sizeof(struct btrfs_item) + BTRFS_FREE_SPACE_BITMAP_SIZE;
 	total_bitmap_size = num_bitmaps * bitmap_size;
@@ -114,7 +114,7 @@ static int free_space_test_bit(struct btrfs_block_group *block_group,
 	ASSERT(offset >= found_start && offset < found_end);
 
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	i = (offset - found_start) / leaf->fs_info->sectorsize;
+	i = (offset - found_start) / leaf->fs_info->blocksize;
 	return !!extent_buffer_test_bit(leaf, ptr, i);
 }
 
@@ -181,7 +181,7 @@ out:
 static inline u32 free_space_bitmap_size(const struct btrfs_fs_info *fs_info,
 					 u64 size)
 {
-	return DIV_ROUND_UP((u32)div_u64(size, fs_info->sectorsize), BITS_PER_BYTE);
+	return DIV_ROUND_UP((u32)div_u64(size, fs_info->blocksize), BITS_PER_BYTE);
 }
 
 static unsigned long *alloc_bitmap(u32 bitmap_size)
@@ -280,9 +280,9 @@ static int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 				ASSERT(found_key.objectid + found_key.offset <= end);
 
 				first = div_u64(found_key.objectid - start,
-						fs_info->sectorsize);
+						fs_info->blocksize);
 				last = div_u64(found_key.objectid + found_key.offset - start,
-					       fs_info->sectorsize);
+					       fs_info->blocksize);
 				le_bitmap_set(bitmap, first, last - first);
 
 				extent_count++;
@@ -323,7 +323,7 @@ static int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
 	}
 
 	bitmap_cursor = (char *)bitmap;
-	bitmap_range = fs_info->sectorsize * BTRFS_FREE_SPACE_BITMAP_BITS;
+	bitmap_range = fs_info->blocksize * BTRFS_FREE_SPACE_BITMAP_BITS;
 	i = start;
 	while (i < end) {
 		unsigned long ptr;
@@ -418,7 +418,7 @@ static int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 				ASSERT(found_key.objectid + found_key.offset <= end);
 
 				bitmap_pos = div_u64(found_key.objectid - start,
-						     fs_info->sectorsize *
+						     fs_info->blocksize *
 						     BITS_PER_BYTE);
 				bitmap_cursor = ((char *)bitmap) + bitmap_pos;
 				data_size = free_space_bitmap_size(fs_info,
@@ -454,16 +454,16 @@ static int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
 	btrfs_mark_buffer_dirty(leaf);
 	btrfs_release_path(path);
 
-	nrbits = div_u64(block_group->length, fs_info->sectorsize);
+	nrbits = div_u64(block_group->length, fs_info->blocksize);
 	start_bit = find_next_bit_le(bitmap, nrbits, 0);
 
 	while (start_bit < nrbits) {
 		end_bit = find_next_zero_bit_le(bitmap, nrbits, start_bit);
 		ASSERT(start_bit < end_bit);
 
-		key.objectid = start + start_bit * fs_info->sectorsize;
+		key.objectid = start + start_bit * fs_info->blocksize;
 		key.type = BTRFS_FREE_SPACE_EXTENT_KEY;
-		key.offset = (end_bit - start_bit) * fs_info->sectorsize;
+		key.offset = (end_bit - start_bit) * fs_info->blocksize;
 
 		ret = btrfs_insert_empty_item(trans, root, path, &key, 0);
 		if (ret)
@@ -557,8 +557,8 @@ static void free_space_set_bits(struct btrfs_block_group *block_group,
 		end = found_end;
 
 	ptr = btrfs_item_ptr_offset(leaf, path->slots[0]);
-	first = (*start - found_start) / fs_info->sectorsize;
-	last = (end - found_start) / fs_info->sectorsize;
+	first = (*start - found_start) / fs_info->blocksize;
+	last = (end - found_start) / fs_info->blocksize;
 	if (bit)
 		extent_buffer_bitmap_set(leaf, ptr, first, last - first);
 	else
@@ -619,7 +619,7 @@ static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
 	 * that block is within the block group.
 	 */
 	if (start > block_group->start) {
-		u64 prev_block = start - trans->fs_info->sectorsize;
+		u64 prev_block = start - trans->fs_info->blocksize;
 
 		key.objectid = prev_block;
 		key.type = (u8)-1;
@@ -1372,7 +1372,7 @@ static int load_free_space_bitmaps(struct btrfs_fs_info *fs_info,
 				extent_count++;
 			}
 			prev_bit = bit;
-			offset += fs_info->sectorsize;
+			offset += fs_info->blocksize;
 		}
 	}
 
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index bd2117e637c2..09130e97eafe 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1270,14 +1270,14 @@ static void print_extent_csum(struct extent_buffer *eb,
 
 	/*
 	 * If we don't have fs_info, only output its start position as we
-	 * don't have sectorsize for the calculation
+	 * don't have blocksize for the calculation
 	 */
 	if (!fs_info) {
 		printf("\t\trange start %llu\n", (unsigned long long)offset);
 		return;
 	}
 	csum_size = fs_info->csum_size;
-	size = (item_size / csum_size) * fs_info->sectorsize;
+	size = (item_size / csum_size) * fs_info->blocksize;
 	printf("\t\trange start %llu end %llu length %u\n",
 			(unsigned long long)offset,
 			(unsigned long long)offset + size, size);
@@ -1308,8 +1308,8 @@ static void print_extent_csum(struct extent_buffer *eb,
 			printf("[%llu] 0x", offset);
 			for (i = 0; i < csum_size; i++)
 				printf("%02x", *csum++);
-			offset += fs_info->sectorsize;
-			size -= fs_info->sectorsize;
+			offset += fs_info->blocksize;
+			size -= fs_info->blocksize;
 			curline--;
 		}
 		putchar('\n');
diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
index 985ceb175129..9947a57d7dac 100644
--- a/kernel-shared/tree-checker.c
+++ b/kernel-shared/tree-checker.c
@@ -154,7 +154,7 @@ static u64 file_extent_end(struct extent_buffer *leaf,
 
 	if (btrfs_file_extent_type(leaf, extent) == BTRFS_FILE_EXTENT_INLINE) {
 		len = btrfs_file_extent_ram_bytes(leaf, extent);
-		end = ALIGN(key->offset + len, leaf->fs_info->sectorsize);
+		end = ALIGN(key->offset + len, leaf->fs_info->blocksize);
 	} else {
 		len = btrfs_file_extent_num_bytes(leaf, extent);
 		end = key->offset + len;
@@ -238,14 +238,14 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_file_extent_item *fi;
-	u32 sectorsize = fs_info->sectorsize;
+	u32 blocksize = fs_info->blocksize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
 
-	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->offset, blocksize))) {
 		file_extent_err(leaf, slot,
 "unaligned file_offset for file extent, have %llu should be aligned to %u",
-			key->offset, sectorsize);
+			key->offset, blocksize);
 		return -EUCLEAN;
 	}
 
@@ -331,11 +331,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			item_size, sizeof(*fi));
 		return -EUCLEAN;
 	}
-	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_num_bytes, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize)))
+	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, blocksize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, blocksize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_num_bytes, blocksize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, offset, blocksize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, blocksize)))
 		return -EUCLEAN;
 
 	/* Catch extent end overflow */
@@ -376,7 +376,7 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			   int slot, struct btrfs_key *prev_key)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	u32 sectorsize = fs_info->sectorsize;
+	u32 blocksize = fs_info->blocksize;
 	const u32 csumsize = fs_info->csum_size;
 
 	/* For fs under csum change, we should not check the regular csum items. */
@@ -390,10 +390,10 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			key->objectid, BTRFS_EXTENT_CSUM_OBJECTID);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->offset, blocksize))) {
 		generic_err(leaf, slot,
 	"unaligned key offset for csum item, have %llu should be aligned to %u",
-			key->offset, sectorsize);
+			key->offset, blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(!IS_ALIGNED(btrfs_item_size(leaf, slot), csumsize))) {
@@ -407,7 +407,7 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 		u32 prev_item_size;
 
 		prev_item_size = btrfs_item_size(leaf, slot - 1);
-		prev_csum_end = (prev_item_size / csumsize) * sectorsize;
+		prev_csum_end = (prev_item_size / csumsize) * blocksize;
 		prev_csum_end += prev_key->offset;
 		if (unlikely(prev_csum_end > key->offset)) {
 			generic_err(leaf, slot - 1,
@@ -876,20 +876,20 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 			  num_stripes, nparity);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(logical, fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(logical, fs_info->blocksize))) {
 		chunk_err(leaf, chunk, logical,
 		"invalid chunk logical, have %llu should aligned to %u",
-			  logical, fs_info->sectorsize);
+			  logical, fs_info->blocksize);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_chunk_sector_size(leaf, chunk) != fs_info->sectorsize)) {
+	if (unlikely(btrfs_chunk_sector_size(leaf, chunk) != fs_info->blocksize)) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk sectorsize, have %u expect %u",
 			  btrfs_chunk_sector_size(leaf, chunk),
-			  fs_info->sectorsize);
+			  fs_info->blocksize);
 		return -EUCLEAN;
 	}
-	if (unlikely(!length || !IS_ALIGNED(length, fs_info->sectorsize))) {
+	if (unlikely(!length || !IS_ALIGNED(length, fs_info->blocksize))) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk length, have %llu", length);
 		return -EUCLEAN;
@@ -1249,10 +1249,10 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	}
 
 	/* Alignment and level check */
-	if (unlikely(!IS_ALIGNED(btrfs_root_bytenr(&ri), fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(btrfs_root_bytenr(&ri), fs_info->blocksize))) {
 		generic_err(leaf, slot,
 		"invalid root bytenr, have %llu expect to be aligned to %u",
-			    btrfs_root_bytenr(&ri), fs_info->sectorsize);
+			    btrfs_root_bytenr(&ri), fs_info->blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(btrfs_root_level(&ri) >= BTRFS_MAX_LEVEL)) {
@@ -1335,10 +1335,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	/* key->objectid is the bytenr for both key types */
-	if (unlikely(!IS_ALIGNED(key->objectid, fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->objectid, fs_info->blocksize))) {
 		generic_err(leaf, slot,
 		"invalid key objectid, have %llu expect to be aligned to %u",
-			   key->objectid, fs_info->sectorsize);
+			   key->objectid, fs_info->blocksize);
 		return -EUCLEAN;
 	}
 
@@ -1428,10 +1428,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   key->type, BTRFS_EXTENT_ITEM_KEY);
 			return -EUCLEAN;
 		}
-		if (unlikely(!IS_ALIGNED(key->offset, fs_info->sectorsize))) {
+		if (unlikely(!IS_ALIGNED(key->offset, fs_info->blocksize))) {
 			extent_err(leaf, slot,
 			"invalid extent length, have %llu expect aligned to %u",
-				   key->offset, fs_info->sectorsize);
+				   key->offset, fs_info->blocksize);
 			return -EUCLEAN;
 		}
 		if (unlikely(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)) {
@@ -1492,10 +1492,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 		/* Contains parent bytenr */
 		case BTRFS_SHARED_BLOCK_REF_KEY:
 			if (unlikely(!IS_ALIGNED(inline_offset,
-						 fs_info->sectorsize))) {
+						 fs_info->blocksize))) {
 				extent_err(leaf, slot,
 		"invalid tree parent bytenr, have %llu expect aligned to %u",
-					   inline_offset, fs_info->sectorsize);
+					   inline_offset, fs_info->blocksize);
 				return -EUCLEAN;
 			}
 			inline_refs++;
@@ -1512,10 +1512,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 					btrfs_extent_data_ref_objectid(leaf, dref),
 					btrfs_extent_data_ref_offset(leaf, dref));
 			if (unlikely(!IS_ALIGNED(dref_offset,
-						 fs_info->sectorsize))) {
+						 fs_info->blocksize))) {
 				extent_err(leaf, slot,
 		"invalid data ref offset, have %llu expect aligned to %u",
-					   dref_offset, fs_info->sectorsize);
+					   dref_offset, fs_info->blocksize);
 				return -EUCLEAN;
 			}
 			inline_refs += btrfs_extent_data_ref_count(leaf, dref);
@@ -1524,10 +1524,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 		case BTRFS_SHARED_DATA_REF_KEY:
 			sref = (struct btrfs_shared_data_ref *)(iref + 1);
 			if (unlikely(!IS_ALIGNED(inline_offset,
-						 fs_info->sectorsize))) {
+						 fs_info->blocksize))) {
 				extent_err(leaf, slot,
 		"invalid data parent bytenr, have %llu expect aligned to %u",
-					   inline_offset, fs_info->sectorsize);
+					   inline_offset, fs_info->blocksize);
 				return -EUCLEAN;
 			}
 			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
@@ -1612,17 +1612,17 @@ static int check_simple_keyed_refs(struct extent_buffer *leaf,
 			    expect_item_size, key->type);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->blocksize))) {
 		generic_err(leaf, slot,
 "invalid key objectid for shared block ref, have %llu expect aligned to %u",
-			    key->objectid, leaf->fs_info->sectorsize);
+			    key->objectid, leaf->fs_info->blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(key->type != BTRFS_TREE_BLOCK_REF_KEY &&
-		     !IS_ALIGNED(key->offset, leaf->fs_info->sectorsize))) {
+		     !IS_ALIGNED(key->offset, leaf->fs_info->blocksize))) {
 		extent_err(leaf, slot,
 		"invalid tree parent bytenr, have %llu expect aligned to %u",
-			   key->offset, leaf->fs_info->sectorsize);
+			   key->offset, leaf->fs_info->blocksize);
 		return -EUCLEAN;
 	}
 	return 0;
@@ -1642,10 +1642,10 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 			    sizeof(*dref), key->type);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->blocksize))) {
 		generic_err(leaf, slot,
 "invalid key objectid for shared block ref, have %llu expect aligned to %u",
-			    key->objectid, leaf->fs_info->sectorsize);
+			    key->objectid, leaf->fs_info->blocksize);
 		return -EUCLEAN;
 	}
 	for (; ptr < end; ptr += sizeof(*dref)) {
@@ -1657,10 +1657,10 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 		 */
 		dref = (struct btrfs_extent_data_ref *)ptr;
 		offset = btrfs_extent_data_ref_offset(leaf, dref);
-		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
+		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->blocksize))) {
 			extent_err(leaf, slot,
 	"invalid extent data backref offset, have %llu expect aligned to %u",
-				   offset, leaf->fs_info->sectorsize);
+				   offset, leaf->fs_info->blocksize);
 			return -EUCLEAN;
 		}
 	}
@@ -1722,10 +1722,10 @@ static int check_inode_ref(struct extent_buffer *leaf,
 static int check_raid_stripe_extent(const struct extent_buffer *leaf,
 				    const struct btrfs_key *key, int slot)
 {
-	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->blocksize))) {
 		generic_err(leaf, slot,
 "invalid key objectid for raid stripe extent, have %llu expect aligned to %u",
-			    key->objectid, leaf->fs_info->sectorsize);
+			    key->objectid, leaf->fs_info->blocksize);
 		return -EUCLEAN;
 	}
 
@@ -1744,7 +1744,7 @@ static int check_dev_extent_item(const struct extent_buffer *leaf,
 				 struct btrfs_key *prev_key)
 {
 	struct btrfs_dev_extent *de;
-	const u32 sectorsize = leaf->fs_info->sectorsize;
+	const u32 blocksize = leaf->fs_info->blocksize;
 
 	de = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
 	/* Basic fixed member checks. */
@@ -1765,25 +1765,25 @@ static int check_dev_extent_item(const struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	/* Alignment check. */
-	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->offset, blocksize))) {
 		generic_err(leaf, slot,
 			    "invalid dev extent key.offset, has %llu not aligned to %u",
-			    key->offset, sectorsize);
+			    key->offset, blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_chunk_offset(leaf, de),
-				 sectorsize))) {
+				 blocksize))) {
 		generic_err(leaf, slot,
 			    "invalid dev extent chunk offset, has %llu not aligned to %u",
 			    btrfs_dev_extent_chunk_objectid(leaf, de),
-			    sectorsize);
+			    blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_length(leaf, de),
-				 sectorsize))) {
+				 blocksize))) {
 		generic_err(leaf, slot,
 			    "invalid dev extent length, has %llu not aligned to %u",
-			    btrfs_dev_extent_length(leaf, de), sectorsize);
+			    btrfs_dev_extent_length(leaf, de), blocksize);
 		return -EUCLEAN;
 	}
 	/* Overlap check with previous dev extent. */
@@ -2087,10 +2087,10 @@ enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node)
 				"invalid NULL node pointer");
 			return BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
 		}
-		if (unlikely(!IS_ALIGNED(bytenr, fs_info->sectorsize))) {
+		if (unlikely(!IS_ALIGNED(bytenr, fs_info->blocksize))) {
 			generic_err(node, slot,
 			"unaligned pointer, have %llu should be aligned to %u",
-				bytenr, fs_info->sectorsize);
+				bytenr, fs_info->blocksize);
 			return BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
 		}
 
diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
index b21231efe8be..a8d6787548bc 100644
--- a/kernel-shared/volumes.c
+++ b/kernel-shared/volumes.c
@@ -1620,9 +1620,9 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_chunk_num_stripes(chunk, ctl->num_stripes);
 	btrfs_set_stack_chunk_io_align(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_io_width(chunk, BTRFS_STRIPE_LEN);
-	btrfs_set_stack_chunk_sector_size(chunk, info->sectorsize);
+	btrfs_set_stack_chunk_sector_size(chunk, info->blocksize);
 	btrfs_set_stack_chunk_sub_stripes(chunk, ctl->sub_stripes);
-	map->sector_size = info->sectorsize;
+	map->sector_size = info->blocksize;
 	map->stripe_len = BTRFS_STRIPE_LEN;
 	map->io_align = BTRFS_STRIPE_LEN;
 	map->io_width = BTRFS_STRIPE_LEN;
@@ -1777,8 +1777,8 @@ int btrfs_alloc_data_chunk(struct btrfs_trans_handle *trans,
 	struct btrfs_device *device;
 	struct alloc_chunk_ctl ctl;
 
-	if (*start != round_down(*start, info->sectorsize)) {
-		error("DATA chunk start not sectorsize aligned: %llu",
+	if (*start != round_down(*start, info->blocksize)) {
+		error("DATA chunk start not blocksize aligned: %llu",
 				(unsigned long long)*start);
 		return -EINVAL;
 	}
@@ -3004,7 +3004,7 @@ static int reset_device_item_total_bytes(struct btrfs_fs_info *fs_info,
 	u64 old_bytes = device->total_bytes;
 	int ret;
 
-	ASSERT(IS_ALIGNED(new_size, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(new_size, fs_info->blocksize));
 
 	/* Align the in-memory total_bytes first, and use it as correct size */
 	device->total_bytes = new_size;
@@ -3074,7 +3074,7 @@ static int btrfs_fix_block_device_size(struct btrfs_fs_info *fs_info,
 	}
 
 	block_dev_size = round_down(device_get_partition_size_fd_stat(device->fd, &st),
-				    fs_info->sectorsize);
+				    fs_info->blocksize);
 
 	/*
 	 * Total_bytes in device item is no larger than the device block size,
@@ -3115,11 +3115,11 @@ int btrfs_fix_device_size(struct btrfs_fs_info *fs_info, struct btrfs_device *de
 	 * Our value is already good, then check if it's device item mismatch against
 	 * block device size.
 	 */
-	if (IS_ALIGNED(old_bytes, fs_info->sectorsize))
+	if (IS_ALIGNED(old_bytes, fs_info->blocksize))
 		return btrfs_fix_block_device_size(fs_info, device);
 
 	return reset_device_item_total_bytes(fs_info, device,
-			round_down(old_bytes, fs_info->sectorsize));
+			round_down(old_bytes, fs_info->blocksize));
 }
 
 /*
@@ -3140,10 +3140,10 @@ int btrfs_fix_super_size(struct btrfs_fs_info *fs_info)
 		 * Caller should ensure this function is called after aligning
 		 * all devices' total_bytes.
 		 */
-		if (!IS_ALIGNED(device->total_bytes, fs_info->sectorsize)) {
+		if (!IS_ALIGNED(device->total_bytes, fs_info->blocksize)) {
 			error("device %llu total_bytes %llu not aligned to %u",
 				device->devid, device->total_bytes,
-				fs_info->sectorsize);
+				fs_info->blocksize);
 			return -EUCLEAN;
 		}
 		total_bytes += device->total_bytes;
diff --git a/mkfs/common.c b/mkfs/common.c
index e28b1e827ee7..10da578d0567 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -420,16 +420,16 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 		system_group_size = cfg->zone_size;
 	}
 
-	buf = malloc(sizeof(*buf) + max(cfg->sectorsize, cfg->nodesize));
+	buf = malloc(sizeof(*buf) + max(cfg->blocksize, cfg->nodesize));
 	if (!buf)
 		return -ENOMEM;
 
-	first_free = BTRFS_SUPER_INFO_OFFSET + cfg->sectorsize * 2 - 1;
-	first_free &= ~((u64)cfg->sectorsize - 1);
+	first_free = BTRFS_SUPER_INFO_OFFSET + cfg->blocksize * 2 - 1;
+	first_free &= ~((u64)cfg->blocksize - 1);
 
 	memset(&super, 0, sizeof(super));
 
-	num_bytes = (cfg->num_bytes / cfg->sectorsize) * cfg->sectorsize;
+	num_bytes = (cfg->num_bytes / cfg->blocksize) * cfg->blocksize;
 	if (!*cfg->fs_uuid) {
 		uuid_generate(super.fsid);
 		uuid_unparse(super.fsid, cfg->fs_uuid);
@@ -458,7 +458,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_chunk_root(&super, cfg->blocks[MKFS_CHUNK_TREE]);
 	btrfs_set_super_total_bytes(&super, num_bytes);
 	btrfs_set_super_bytes_used(&super, total_used);
-	btrfs_set_super_sectorsize(&super, cfg->sectorsize);
+	btrfs_set_super_sectorsize(&super, cfg->blocksize);
 	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
 	btrfs_set_super_nodesize(&super, cfg->nodesize);
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
@@ -600,9 +600,9 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_device_generation(buf, dev_item, 0);
 	btrfs_set_device_total_bytes(buf, dev_item, num_bytes);
 	btrfs_set_device_bytes_used(buf, dev_item, system_group_size);
-	btrfs_set_device_io_align(buf, dev_item, cfg->sectorsize);
-	btrfs_set_device_io_width(buf, dev_item, cfg->sectorsize);
-	btrfs_set_device_sector_size(buf, dev_item, cfg->sectorsize);
+	btrfs_set_device_io_align(buf, dev_item, cfg->blocksize);
+	btrfs_set_device_io_width(buf, dev_item, cfg->blocksize);
+	btrfs_set_device_sector_size(buf, dev_item, cfg->blocksize);
 	btrfs_set_device_type(buf, dev_item, 0);
 
 	write_extent_buffer(buf, super.dev_item.uuid,
@@ -631,9 +631,9 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_chunk_owner(buf, chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_chunk_stripe_len(buf, chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_chunk_type(buf, chunk, BTRFS_BLOCK_GROUP_SYSTEM);
-	btrfs_set_chunk_io_align(buf, chunk, cfg->sectorsize);
-	btrfs_set_chunk_io_width(buf, chunk, cfg->sectorsize);
-	btrfs_set_chunk_sector_size(buf, chunk, cfg->sectorsize);
+	btrfs_set_chunk_io_align(buf, chunk, cfg->blocksize);
+	btrfs_set_chunk_io_width(buf, chunk, cfg->blocksize);
+	btrfs_set_chunk_sector_size(buf, chunk, cfg->blocksize);
 	btrfs_set_chunk_num_stripes(buf, chunk, 1);
 	btrfs_set_stripe_devid_nr(buf, chunk, 0, 1);
 	btrfs_set_stripe_offset_nr(buf, chunk, 0,
diff --git a/mkfs/common.h b/mkfs/common.h
index c600c16622fa..72c5827a505c 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -76,7 +76,7 @@ struct btrfs_mkfs_config {
 	const char *label;
 	/* Block sizes */
 	u32 nodesize;
-	u32 sectorsize;
+	u32 blocksize;
 	u32 stripesize;
 	u32 leaf_data_size;
 	struct btrfs_mkfs_features features;
diff --git a/mkfs/main.c b/mkfs/main.c
index cdb9862a9524..2faabc550887 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1045,7 +1045,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	char dev_uuid[BTRFS_UUID_UNPARSED_SIZE] = { 0 };
 	u32 nodesize = 0;
 	bool nodesize_forced = false;
-	u32 sectorsize = 0;
+	u32 blocksize = 0;
 	u32 stripesize = 4096;
 	u64 metadata_profile = 0;
 	bool metadata_profile_set = false;
@@ -1202,7 +1202,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 				break;
 				}
 			case 's':
-				sectorsize = arg_strtou64_with_suffix(optarg);
+				blocksize = arg_strtou64_with_suffix(optarg);
 				break;
 			case 'b':
 				byte_count = arg_strtou64_with_suffix(optarg);
@@ -1341,17 +1341,17 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		printf("See %s for more information.\n\n", PACKAGE_URL);
 	}
 
-	if (!sectorsize)
-		sectorsize = (u32)SZ_4K;
-	if (btrfs_check_sectorsize(sectorsize)) {
+	if (!blocksize)
+		blocksize = (u32)SZ_4K;
+	if (btrfs_check_blocksize(blocksize)) {
 		ret = 1;
 		goto error;
 	}
 
 	if (!nodesize)
-		nodesize = max_t(u32, sectorsize, BTRFS_MKFS_DEFAULT_NODE_SIZE);
+		nodesize = max_t(u32, blocksize, BTRFS_MKFS_DEFAULT_NODE_SIZE);
 
-	stripesize = sectorsize;
+	stripesize = blocksize;
 	saved_optind = optind;
 	device_count = argc - optind;
 	if (device_count == 0)
@@ -1531,7 +1531,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		}
 
 		if (!nodesize_forced)
-			nodesize = sectorsize;
+			nodesize = blocksize;
 	}
 
 	/*
@@ -1595,14 +1595,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			warning("libblkid < 2.38 does not support zoned mode's superblock location, update recommended");
 	}
 
-	if (btrfs_check_nodesize(nodesize, sectorsize, &features)) {
+	if (btrfs_check_nodesize(nodesize, blocksize, &features)) {
 		ret = 1;
 		goto error;
 	}
 
-	if (sectorsize < sizeof(struct btrfs_super_block)) {
-		error("sectorsize smaller than superblock: %u < %zu",
-				sectorsize, sizeof(struct btrfs_super_block));
+	if (blocksize < sizeof(struct btrfs_super_block)) {
+		error("blocksize smaller than superblock: %u < %zu",
+				blocksize, sizeof(struct btrfs_super_block));
 		ret = 1;
 		goto error;
 	}
@@ -1611,7 +1611,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 					  opt_zoned ? zone_size(file) : 0,
 					  metadata_profile, data_profile);
 	if (byte_count) {
-		byte_count = round_down(byte_count, sectorsize);
+		byte_count = round_down(byte_count, blocksize);
 		if (opt_zoned)
 			byte_count = round_down(byte_count,  zone_size(file));
 	}
@@ -1651,10 +1651,10 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		 */
 		if (!byte_count)
 			byte_count = round_down(device_get_partition_size_fd_stat(fd, &statbuf),
-						sectorsize);
-		source_dir_size = btrfs_mkfs_size_dir(source_dir, sectorsize,
+						blocksize);
+		source_dir_size = btrfs_mkfs_size_dir(source_dir, blocksize,
 				min_dev_size, metadata_profile, data_profile);
-		UASSERT(IS_ALIGNED(source_dir_size, sectorsize));
+		UASSERT(IS_ALIGNED(source_dir_size, blocksize));
 		if (byte_count < source_dir_size) {
 			if (S_ISREG(statbuf.st_mode)) {
 				byte_count = source_dir_size;
@@ -1808,7 +1808,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	memcpy(mkfs_cfg.dev_uuid, dev_uuid, sizeof(mkfs_cfg.dev_uuid));
 	mkfs_cfg.num_bytes = dev_byte_count;
 	mkfs_cfg.nodesize = nodesize;
-	mkfs_cfg.sectorsize = sectorsize;
+	mkfs_cfg.blocksize = blocksize;
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
 	mkfs_cfg.csum_type = csum_type;
@@ -1916,7 +1916,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 
 		ret = btrfs_add_to_fsid(trans, root, prepare_ctx[i].fd,
 					prepare_ctx[i].file, dev_byte_count,
-					sectorsize, sectorsize, sectorsize);
+					blocksize, blocksize, blocksize);
 		if (ret) {
 			error("unable to add %s to filesystem: %d",
 			      prepare_ctx[i].file, ret);
@@ -2057,8 +2057,8 @@ raid_groups:
 		if (dev_uuid[0] != 0)
 			printf("Device UUID:        %s\n", mkfs_cfg.dev_uuid);
 		printf("Node size:          %u\n", nodesize);
-		printf("Sector size:        %u\t(CPU page size: %lu)\n",
-		       sectorsize, sysconf(_SC_PAGESIZE));
+		printf("Block size:        %u\t(CPU page size: %lu)\n",
+		       blocksize, sysconf(_SC_PAGESIZE));
 		printf("Filesystem size:    %s\n",
 			pretty_size(btrfs_super_total_bytes(fs_info->super_copy)));
 		printf("Block group profiles:\n");
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 919eca5083af..007e4487c320 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -75,7 +75,7 @@ static u32 fs_block_size;
  * 2) Data space for each (regular) inode
  *    To estimate data chunk size.
  *    Don't care if it can fit as an inline extent.
- *    Always round them up to sectorsize.
+ *    Always round them up to blocksize.
  */
 static u64 ftw_meta_nr_inode;
 static u64 ftw_data_size;
@@ -475,7 +475,7 @@ fail:
  * Returns the size of the compressed data if successful, -E2BIG if it is
  * incompressible, or an error code.
  */
-static ssize_t zlib_compress_extent(bool first_sector, u32 sectorsize,
+static ssize_t zlib_compress_extent(bool first_sector, u32 blocksize,
 				    const void *in_buf, size_t in_size,
 				    void *out_buf)
 {
@@ -501,7 +501,7 @@ static ssize_t zlib_compress_extent(bool first_sector, u32 sectorsize,
 	 * return -E2BIG.
 	 */
 	if (first_sector) {
-		strm.avail_in = sectorsize;
+		strm.avail_in = blocksize;
 
 		ret = deflate(&strm, Z_SYNC_FLUSH);
 
@@ -510,10 +510,10 @@ static ssize_t zlib_compress_extent(bool first_sector, u32 sectorsize,
 			return -EINVAL;
 		}
 
-		if (strm.avail_out < BTRFS_MAX_COMPRESSED - sectorsize)
+		if (strm.avail_out < BTRFS_MAX_COMPRESSED - blocksize)
 			return -E2BIG;
 
-		strm.avail_in += in_size - sectorsize;
+		strm.avail_in += in_size - blocksize;
 	}
 
 	ret = deflate(&strm, Z_FINISH);
@@ -525,7 +525,7 @@ static ssize_t zlib_compress_extent(bool first_sector, u32 sectorsize,
 		return -EINVAL;
 	}
 
-	if (out_buf + BTRFS_MAX_COMPRESSED - (void *)strm.next_out > sectorsize)
+	if (out_buf + BTRFS_MAX_COMPRESSED - (void *)strm.next_out > blocksize)
 		return (void *)strm.next_out - out_buf;
 
 	return -E2BIG;
@@ -536,7 +536,7 @@ static ssize_t zlib_compress_extent(bool first_sector, u32 sectorsize,
  * Returns the size of the compressed data if successful, -E2BIG if it is
  * incompressible, or an error code.
  */
-static ssize_t lzo_compress_extent(u32 sectorsize, const void *in_buf,
+static ssize_t lzo_compress_extent(u32 blocksize, const void *in_buf,
 				   size_t in_size, void *out_buf, char *wrkmem)
 {
 	int ret;
@@ -545,15 +545,15 @@ static ssize_t lzo_compress_extent(u32 sectorsize, const void *in_buf,
 
 	out_pos = LZO_LEN;
 	total_size = LZO_LEN;
-	sectors = DIV_ROUND_UP(in_size, sectorsize);
+	sectors = DIV_ROUND_UP(in_size, blocksize);
 
 	for (unsigned int i = 0; i < sectors; i++) {
 		size_t in_len, out_len, new_pos;
 		u32 padding;
 
-		in_len = min((size_t)sectorsize, in_size - (i * sectorsize));
+		in_len = min((size_t)blocksize, in_size - (i * blocksize));
 
-		ret = lzo1x_1_compress(in_buf + (i * sectorsize), in_len,
+		ret = lzo1x_1_compress(in_buf + (i * blocksize), in_len,
 				       out_buf + out_pos + LZO_LEN, &out_len,
 				       wrkmem);
 		if (ret) {
@@ -566,7 +566,7 @@ static ssize_t lzo_compress_extent(u32 sectorsize, const void *in_buf,
 		new_pos = out_pos + LZO_LEN + out_len;
 
 		/* Make sure that our header doesn't cross a sector boundary. */
-		if (new_pos / sectorsize != (new_pos + LZO_LEN - 1) / sectorsize)
+		if (new_pos / blocksize != (new_pos + LZO_LEN - 1) / blocksize)
 			padding = round_up(new_pos, LZO_LEN) - new_pos;
 		else
 			padding = 0;
@@ -578,7 +578,7 @@ static ssize_t lzo_compress_extent(u32 sectorsize, const void *in_buf,
 		 * Follow kernel in trying to compress the first three sectors,
 		 * then giving up if the output isn't any smaller.
 		 */
-		if (i >= 3 && total_size > i * sectorsize)
+		if (i >= 3 && total_size > i * blocksize)
 			return -E2BIG;
 	}
 
@@ -596,7 +596,7 @@ static ssize_t lzo_compress_extent(u32 sectorsize, const void *in_buf,
  * Returns the size of the compressed data if successful, -E2BIG if it is
  * incompressible, or an error code.
  */
-static ssize_t zstd_compress_extent(bool first_sector, u32 sectorsize,
+static ssize_t zstd_compress_extent(bool first_sector, u32 blocksize,
 				    const void *in_buf, size_t in_size,
 				    void *out_buf)
 {
@@ -641,7 +641,7 @@ static ssize_t zstd_compress_extent(bool first_sector, u32 sectorsize,
 	 * -E2BIG so that it gets marked as nocompress.
 	 */
 	if (first_sector) {
-		input.size = sectorsize;
+		input.size = blocksize;
 
 		zstd_ret = ZSTD_compressStream2(zstd_ctx, &output, &input,
 						ZSTD_e_flush);
@@ -653,7 +653,7 @@ static ssize_t zstd_compress_extent(bool first_sector, u32 sectorsize,
 			goto out;
 		}
 
-		if (zstd_ret != 0 || output.pos > sectorsize) {
+		if (zstd_ret != 0 || output.pos > blocksize) {
 			ret = -E2BIG;
 			goto out;
 		}
@@ -670,7 +670,7 @@ static ssize_t zstd_compress_extent(bool first_sector, u32 sectorsize,
 		goto out;
 	}
 
-	if (zstd_ret == 0 && output.pos <= in_size - sectorsize)
+	if (zstd_ret == 0 && output.pos <= in_size - blocksize)
 		ret = output.pos;
 	else
 		ret = -E2BIG;
@@ -705,7 +705,7 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 				u64 file_pos)
 {
 	int ret;
-	u32 sectorsize = root->fs_info->sectorsize;
+	u32 blocksize = root->fs_info->blocksize;
 	u64 bytes_read, first_block, to_read, to_write;
 	struct btrfs_key key;
 	struct btrfs_file_extent_item stack_fi = { 0 };
@@ -738,7 +738,7 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 		bytes_read += ret_read;
 	}
 
-	if (bytes_read <= sectorsize)
+	if (bytes_read <= blocksize)
 		do_comp = false;
 
 	if (do_comp) {
@@ -746,13 +746,13 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 
 		switch (g_compression) {
 		case BTRFS_COMPRESS_ZLIB:
-			comp_ret = zlib_compress_extent(first_sector, sectorsize,
+			comp_ret = zlib_compress_extent(first_sector, blocksize,
 							source->buf, bytes_read,
 							source->comp_buf);
 			break;
 #if COMPRESSION_LZO
 		case BTRFS_COMPRESS_LZO:
-			comp_ret = lzo_compress_extent(sectorsize, source->buf,
+			comp_ret = lzo_compress_extent(blocksize, source->buf,
 						       bytes_read,
 						       source->comp_buf,
 						       source->wrkmem);
@@ -760,7 +760,7 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 #endif
 #if COMPRESSION_ZSTD
 		case BTRFS_COMPRESS_ZSTD:
-			comp_ret = zstd_compress_extent(first_sector, sectorsize,
+			comp_ret = zstd_compress_extent(first_sector, blocksize,
 							source->buf, bytes_read,
 							source->comp_buf);
 			break;
@@ -810,7 +810,7 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 	if (do_comp) {
 		u64 features;
 
-		to_write = round_up(comp_ret, sectorsize);
+		to_write = round_up(comp_ret, blocksize);
 		write_buf = source->comp_buf;
 		memset(write_buf + comp_ret, 0, to_write - comp_ret);
 
@@ -829,7 +829,7 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 						       features);
 		}
 	} else {
-		to_write = round_up(to_read, sectorsize);
+		to_write = round_up(to_read, blocksize);
 		write_buf = source->buf;
 		memset(write_buf + to_read, 0, to_write - to_read);
 	}
@@ -848,11 +848,11 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	for (unsigned int i = 0; i < to_write / sectorsize; i++) {
-		ret = btrfs_csum_file_block(trans, first_block + (i * sectorsize),
+	for (unsigned int i = 0; i < to_write / blocksize; i++) {
+		ret = btrfs_csum_file_block(trans, first_block + (i * blocksize),
 					BTRFS_EXTENT_CSUM_OBJECTID,
 					root->fs_info->csum_type,
-					write_buf + (i * sectorsize));
+					write_buf + (i * blocksize));
 		if (ret)
 			return ret;
 	}
@@ -860,8 +860,8 @@ static int add_file_item_extent(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
 	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, first_block);
 	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi, to_write);
-	btrfs_set_stack_file_extent_num_bytes(&stack_fi, round_up(to_read, sectorsize));
-	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, round_up(to_read, sectorsize));
+	btrfs_set_stack_file_extent_num_bytes(&stack_fi, round_up(to_read, blocksize));
+	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, round_up(to_read, blocksize));
 
 	if (do_comp)
 		btrfs_set_stack_file_extent_compression(&stack_fi, g_compression);
@@ -1070,7 +1070,7 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	int ret = -1;
 	ssize_t ret_read;
-	u32 sectorsize = fs_info->sectorsize;
+	u32 blocksize = fs_info->blocksize;
 	u64 file_pos = 0;
 	char *buf = NULL, *comp_buf = NULL, *wrkmem = NULL;
 	struct source_descriptor source;
@@ -1100,7 +1100,7 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 	}
 
 	if (st->st_size <= BTRFS_MAX_INLINE_DATA_SIZE(fs_info) &&
-	    st->st_size < sectorsize) {
+	    st->st_size < blocksize) {
 		char *buffer = malloc(st->st_size);
 
 		if (!buffer) {
@@ -1179,10 +1179,10 @@ static int add_file_items(struct btrfs_trans_handle *trans,
 		 * - 3 bytes for possible padding
 		 */
 
-		sectors = BTRFS_MAX_COMPRESSED / sectorsize;
+		sectors = BTRFS_MAX_COMPRESSED / blocksize;
 
 		comp_buf_len = LZO_LEN;
-		comp_buf_len += (LZO_LEN + lzo_max_outlen(sectorsize) +
+		comp_buf_len += (LZO_LEN + lzo_max_outlen(blocksize) +
 				 LZO_LEN - 1) * sectors;
 
 		comp_buf = malloc(comp_buf_len);
@@ -1721,7 +1721,7 @@ static int ftw_add_entry_size(const char *fpath, const struct stat *st,
 	return 0;
 }
 
-u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
+u64 btrfs_mkfs_size_dir(const char *dir_name, u32 blocksize, u64 min_dev_size,
 			u64 meta_profile, u64 data_profile)
 {
 	u64 total_size = 0;
@@ -1737,7 +1737,7 @@ u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
 	float data_multiplier = 1;
 	float meta_multiplier = 1;
 
-	fs_block_size = sectorsize;
+	fs_block_size = blocksize;
 	ftw_data_size = 0;
 	ftw_meta_nr_inode = 0;
 
@@ -1759,7 +1759,7 @@ u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
 	 * 2) DIR_INDEX
 	 * 3) INODE_REF
 	 *
-	 * Plus possible inline extent size, which is sectorsize.
+	 * Plus possible inline extent size, which is blocksize.
 	 *
 	 * And finally, allow metadata usage to increase with data size.
 	 * Follow the old kernel 8:1 data:meta ratio.
@@ -1767,7 +1767,7 @@ u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
 	 * upper limit is 1M, instead of 128M in kernel.
 	 * This can bump meta usage easily.
 	 */
-	meta_size = ftw_meta_nr_inode * (PATH_MAX * 3 + sectorsize) +
+	meta_size = ftw_meta_nr_inode * (PATH_MAX * 3 + blocksize) +
 		    ftw_data_size / 8;
 
 	/* Minimal chunk size from btrfs_alloc_chunk(). */
@@ -1798,7 +1798,7 @@ u64 btrfs_mkfs_size_dir(const char *dir_name, u32 sectorsize, u64 min_dev_size,
 
 /*
  * Get the end position of the last device extent for given @devid;
- * @size_ret is exclusive (means it should be aligned to sectorsize)
+ * @size_ret is exclusive (means it should be aligned to blocksize)
  */
 static int get_device_extent_end(struct btrfs_fs_info *fs_info,
 				 u64 devid, u64 *size_ret)
@@ -1942,9 +1942,9 @@ int btrfs_mkfs_shrink_fs(struct btrfs_fs_info *fs_info, u64 *new_size_ret,
 		return ret;
 	}
 
-	if (!IS_ALIGNED(new_size, fs_info->sectorsize)) {
+	if (!IS_ALIGNED(new_size, fs_info->blocksize)) {
 		error("shrunk filesystem size %llu not aligned to %u",
-				new_size, fs_info->sectorsize);
+				new_size, fs_info->blocksize);
 		return -EUCLEAN;
 	}
 
diff --git a/tune/change-csum.c b/tune/change-csum.c
index 46aa96237960..ed6b9452996b 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -132,7 +132,7 @@ static int get_last_csum_bytenr(struct btrfs_fs_info *fs_info, u64 *result)
 	}
 	btrfs_item_key_to_cpu(path.nodes[0], &key, path.slots[0]);
 	*result = key.offset + btrfs_item_size(path.nodes[0], path.slots[0]) /
-			       fs_info->csum_size * fs_info->sectorsize;
+			       fs_info->csum_size * fs_info->blocksize;
 	btrfs_release_path(&path);
 	return 0;
 }
@@ -142,13 +142,13 @@ static int read_verify_one_data_sector(struct btrfs_fs_info *fs_info,
 				       const void *old_csums, u16 old_csum_type,
 				       bool output_error)
 {
-	const u32 sectorsize = fs_info->sectorsize;
-	int num_copies = btrfs_num_copies(fs_info, logical, sectorsize);
+	const u32 blocksize = fs_info->blocksize;
+	int num_copies = btrfs_num_copies(fs_info, logical, blocksize);
 	bool found_good = false;
 
 	for (int mirror = 1; mirror <= num_copies; mirror++) {
 		u8 csum_has[BTRFS_CSUM_SIZE];
-		u64 readlen = sectorsize;
+		u64 readlen = blocksize;
 		int ret;
 
 		ret = read_data_from_disk(fs_info, data_buf, logical, &readlen,
@@ -159,7 +159,7 @@ static int read_verify_one_data_sector(struct btrfs_fs_info *fs_info,
 			continue;
 		}
 		btrfs_csum_data(fs_info, fs_info->csum_type, data_buf, csum_has,
-				sectorsize);
+				blocksize);
 		if (memcmp(csum_has, old_csums, fs_info->csum_size) == 0) {
 			found_good = true;
 			break;
@@ -183,17 +183,17 @@ static int generate_new_csum_range(struct btrfs_trans_handle *trans,
 				   const void *old_csums)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	const u32 sectorsize = fs_info->sectorsize;
+	const u32 blocksize = fs_info->blocksize;
 	int ret = 0;
 	void *buf;
 
-	buf = malloc(fs_info->sectorsize);
+	buf = malloc(fs_info->blocksize);
 	if (!buf)
 		return -ENOMEM;
 
-	for (u64 cur = logical; cur < logical + length; cur += sectorsize) {
+	for (u64 cur = logical; cur < logical + length; cur += blocksize) {
 		ret = read_verify_one_data_sector(fs_info, cur, buf, old_csums +
-				(cur - logical) / sectorsize * fs_info->csum_size,
+				(cur - logical) / blocksize * fs_info->csum_size,
 				fs_info->csum_type, true);
 
 		if (ret < 0) {
@@ -229,7 +229,7 @@ static unsigned int calc_csum_change_nr_items(struct btrfs_fs_info *fs_info,
 {
 	const u32 new_csum_size = btrfs_csum_type_size(new_csum_type);
 	const u32 csum_item_size = CSUM_CHANGE_BYTES_THRESHOLD /
-				   fs_info->sectorsize * new_csum_size;
+				   fs_info->blocksize * new_csum_size;
 
 	return round_up(csum_item_size, fs_info->nodesize) / fs_info->nodesize * 2;
 }
@@ -296,7 +296,7 @@ static int generate_new_data_csums_range(struct btrfs_fs_info *fs_info, u64 star
 		item_size = btrfs_item_size(path.nodes[0], path.slots[0]);
 
 		csum_start = key.offset;
-		len = item_size / fs_info->csum_size * fs_info->sectorsize;
+		len = item_size / fs_info->csum_size * fs_info->blocksize;
 		read_extent_buffer(path.nodes[0], csum_buffer,
 				btrfs_item_ptr_offset(path.nodes[0], path.slots[0]),
 				item_size);
@@ -869,7 +869,7 @@ static int determine_csum_type(struct btrfs_fs_info *fs_info, u64 logical,
 			   csum_size);
 	btrfs_release_path(&path);
 
-	buf = malloc(fs_info->sectorsize);
+	buf = malloc(fs_info->blocksize);
 	if (!buf)
 		return -ENOMEM;
 	ret = read_verify_one_data_sector(fs_info, logical, buf, csum_expected,
@@ -952,7 +952,7 @@ static int resume_data_csum_change(struct btrfs_fs_info *fs_info, u16 new_csum_t
 	    old_csum_last >= new_csum_last) {
 		resume_start = new_csum_last + new_last_size /
 					btrfs_csum_type_size(new_csum_type) *
-					fs_info->sectorsize;
+					fs_info->blocksize;
 		goto new_data_csums;
 	}
 
-- 
2.47.1


