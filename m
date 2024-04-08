Return-Path: <linux-btrfs+bounces-4035-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7B389CE78
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80165B229A2
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 22:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C760149C70;
	Mon,  8 Apr 2024 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hbJFsoNO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="hbJFsoNO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903E143890
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615654; cv=none; b=ROJI9S+4XuFCIGeYVDO8dYlrl8iibVLlbHbdIG0Jq9dG8hAFC5mtWQ8mJ+OKMGuFjlLd8P9z7RsC8ikxCKPQMe32DA5KVtkjG8xHDFI/RyGwNy1qGj1R+Pk5mPmHusiDDAtH9Kip+Wrl1AOjAm8bawqG8e2TQa1TM/DQX2b3k04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615654; c=relaxed/simple;
	bh=0ugmcOxtZl8M6j3JRN3d5QqToALBnqBv3FjoK1cST7Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NedvVutCMovTGahSbQoc8lDQ4ZoNSL09klq72fHkP45mRIZg5V7XWFuUCPMVBNlMXpoNTjLFpmZB+tUFVuT8OwjdIY5Vz+fslgmbUo0uFMvsL36KxTY8+iQmb2xWFCKnowkhS4lxGmo3CXfAIx/IUE75pRhS19Rx/nevvjsVWI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hbJFsoNO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=hbJFsoNO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8E16205EF
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olb/khfp7ELBGsRnDjxn4FDj/IK3/THRkz82BAboF44=;
	b=hbJFsoNOScR+qZfWyl+FkmaJ0fXHIACDdMOGuI8y9I2XFvULE8htM5braxzS3BCXhKr1d0
	48NsBj2wL4cQsHWGD0jCGhNsGvGmacPisP8ll+bVhwprLJiukTsTJHl4mHn/EOH0u7v0Un
	DdCsseP/kwrXb1Z9tbktfELKjIAQWHc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=hbJFsoNO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olb/khfp7ELBGsRnDjxn4FDj/IK3/THRkz82BAboF44=;
	b=hbJFsoNOScR+qZfWyl+FkmaJ0fXHIACDdMOGuI8y9I2XFvULE8htM5braxzS3BCXhKr1d0
	48NsBj2wL4cQsHWGD0jCGhNsGvGmacPisP8ll+bVhwprLJiukTsTJHl4mHn/EOH0u7v0Un
	DdCsseP/kwrXb1Z9tbktfELKjIAQWHc=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DA3031332F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 8NvQJuFwFGaSTQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Apr 2024 22:34:09 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 8/8] btrfs: reorder disk_bytenr/disk_num_bytes/ram_bytes/offset parameters
Date: Tue,  9 Apr 2024 08:03:47 +0930
Message-ID: <526aa9bf5492f74c1c848357b90d7ceff93d0f1f.1712614770.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712614770.git.wqu@suse.com>
References: <cover.1712614770.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A8E16205EF
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

Since we have cleaned up the old
block_start/block_len/orig_start/orig_block_len members, we can re-order
above parameters to a more common order.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |  6 +--
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       | 95 ++++++++++++++++++++++++------------------
 3 files changed, 58 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index f4514ee273ce..696e095e7111 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -443,9 +443,9 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_block_len,
-			      u64 *ram_bytes, bool nowait, bool strict,
-			      u64 *disk_bytenr_ret, u64 *extent_offset_ret);
+			      u64 *disk_bytenr, u64 *disk_num_bytes,
+			      u64 *ram_bytes, u64 *new_offset_ret,
+			      bool nowait, bool strict);
 
 void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 965d2ba34aeb..b3ba2d4f2b8b 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1094,7 +1094,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 						   &cached_state);
 	}
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
-			NULL, NULL, nowait, false, NULL, NULL);
+			NULL, NULL, NULL, NULL, nowait, false);
 	if (ret <= 0)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 	else
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index cbc40d291d76..0d9d743719e9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -139,9 +139,10 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len,
+				       u64 disk_bytenr,
 				       u64 disk_num_bytes,
-				       u64 ram_bytes, int compress_type,
-				       int type, u64 disk_bytenr, u64 offset);
+				       u64 ram_bytes, u64 offset, int compress_type,
+				       int type);
 
 static int data_reloc_print_warning_inode(u64 inum, u64 offset, u64 num_bytes,
 					  u64 root, void *warn_ctx)
@@ -1160,11 +1161,12 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	/* Here we're doing allocation and writeback of the compressed pages */
 	em = create_io_em(inode, start,
 			  async_extent->ram_size,	/* len */
-			  ins.offset,			/* orig_block_len */
+			  ins.objectid,			/* disk_bytenr */
+			  ins.offset,			/* disk_num_bytes */
 			  async_extent->ram_size,	/* ram_bytes */
+			  0,				/* offset */
 			  async_extent->compress_type,
-			  BTRFS_ORDERED_COMPRESSED,
-			  ins.objectid, 0);
+			  BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
@@ -1421,11 +1423,12 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		ram_size = ins.offset;
 		em = create_io_em(inode, start, ins.offset, /* len */
+				  ins.objectid, /* disk_bytenr */
 				  ins.offset, /* orig_block_len */
 				  ram_size, /* ram_bytes */
+				  0, /* offset */
 				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  BTRFS_ORDERED_REGULAR /* type */,
-				  ins.objectid, 0);
+				  BTRFS_ORDERED_REGULAR /* type */);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out_reserve;
@@ -2161,12 +2164,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			struct extent_map *em;
 
 			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
-					  nocow_args.orig_disk_num_bytes, /* orig_block_len */
-					  ram_bytes, BTRFS_COMPRESS_NONE,
-					  BTRFS_ORDERED_PREALLOC,
-					  nocow_args.orig_disk_bytenr,
+					  nocow_args.orig_disk_bytenr, /* disk_bytenr */
+					  nocow_args.orig_disk_num_bytes, /* disk_num_bytes */
+					  ram_bytes,
 					  cur_offset - found_key.offset +
-					  nocow_args.orig_offset);
+					  nocow_args.orig_offset, /* offset */
+					  BTRFS_COMPRESS_NONE,
+					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
 				btrfs_dec_nocow_writers(nocow_bg);
 				ret = PTR_ERR(em);
@@ -7012,20 +7016,20 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
 						  const u64 len,
-						  const u64 orig_block_len,
-						  const u64 ram_bytes,
-						  const int type,
 						  const u64 disk_bytenr,
-						  const u64 offset)
+						  const u64 disk_num_bytes,
+						  const u64 ram_bytes,
+						  const u64 offset,
+						  const int type)
 {
 	struct extent_map *em = NULL;
 	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
 		em = create_io_em(inode, start, len,
-				  orig_block_len, ram_bytes,
+				  disk_bytenr, disk_num_bytes, ram_bytes, offset,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  type, disk_bytenr, offset);
+				  type);
 		if (IS_ERR(em))
 			goto out;
 	}
@@ -7074,10 +7078,13 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	if (ret)
 		return ERR_PTR(ret);
 
-	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
-				     ins.offset,
-				     ins.offset, BTRFS_ORDERED_REGULAR,
-				     ins.objectid, 0);
+	em = btrfs_create_dio_extent(inode, dio_data,
+				     start, ins.offset,
+				     ins.objectid, /* disk_bytenr */
+				     ins.offset, /* disk_num_bytes */
+				     ins.offset, /* ram_bytes */
+				     0, /* offset */
+				     BTRFS_ORDERED_REGULAR);
 	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 	if (IS_ERR(em))
 		btrfs_free_reserved_extent(fs_info, ins.objectid, ins.offset,
@@ -7120,9 +7127,9 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  *	 any ordered extents.
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_block_len,
-			      u64 *ram_bytes, bool nowait, bool strict,
-			      u64 *disk_bytenr_ret, u64 *new_offset_ret)
+			      u64 *disk_bytenr, u64 *disk_num_bytes,
+			      u64 *ram_bytes, u64 *new_offset_ret,
+			      bool nowait, bool strict)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
@@ -7207,10 +7214,10 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		}
 	}
 
-	if (orig_block_len)
-		*orig_block_len = nocow_args.orig_disk_num_bytes;
-	if (disk_bytenr_ret)
-		*disk_bytenr_ret = nocow_args.orig_disk_bytenr;
+	if (disk_bytenr)
+		*disk_bytenr = nocow_args.orig_disk_bytenr;
+	if (disk_num_bytes)
+		*disk_num_bytes = nocow_args.orig_disk_num_bytes;
 	if (new_offset_ret)
 		*new_offset_ret = offset - key.offset +
 				  nocow_args.orig_offset;
@@ -7318,9 +7325,12 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len,
+				       u64 disk_bytenr,
 				       u64 disk_num_bytes,
-				       u64 ram_bytes, int compress_type,
-				       int type, u64 disk_bytenr, u64 offset)
+				       u64 ram_bytes,
+				       u64 offset,
+				       int compress_type,
+				       int type)
 {
 	struct extent_map *em;
 	int ret;
@@ -7428,8 +7438,9 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = extent_map_block_start(em) + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len,
-				     &orig_block_len, &ram_bytes, false, false,
-				     &disk_bytenr, &new_offset) == 1) {
+				     &disk_bytenr, &orig_block_len,
+				     &ram_bytes, &new_offset,
+				     false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
@@ -7455,9 +7466,11 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		space_reserved = true;
 
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      orig_block_len,
-					      ram_bytes, type,
-					      disk_bytenr, new_offset);
+					      disk_bytenr, /* disk_bytenr. */
+					      orig_block_len, /* disk_num_bytes */
+					      ram_bytes, /* ram_bytes */
+					      new_offset, /* offset */
+					      type);
 		btrfs_dec_nocow_writers(bg);
 		if (type == BTRFS_ORDERED_PREALLOC) {
 			free_extent_map(em);
@@ -10515,9 +10528,9 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	extent_reserved = true;
 
 	em = create_io_em(inode, start, num_bytes,
-			  ins.offset, ram_bytes, compression,
-			  BTRFS_ORDERED_COMPRESSED, ins.objectid,
-			  encoded->unencoded_offset);
+			  ins.objectid, ins.offset, ram_bytes,
+			  encoded->unencoded_offset, compression,
+			  BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
@@ -10847,8 +10860,8 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL,
-				       false, true, NULL, NULL);
+		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, NULL,
+				       false, true);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
-- 
2.44.0


