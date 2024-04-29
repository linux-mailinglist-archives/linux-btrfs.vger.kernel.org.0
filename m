Return-Path: <linux-btrfs+bounces-4638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5E48B65A8
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1724B21A00
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A662194C84;
	Mon, 29 Apr 2024 22:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UIH8Nqk8";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="UIH8Nqk8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF10194C61
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429418; cv=none; b=uWxi1V6LQH8Z8pu6ofgyfwNNJ9aun4XNNobyKQf8AaDtv23MugUiOWSqh0QoqV7jZRx805UjFMW8pPk8cZ1EqtgjVwKfvIwHD+e9twdGGFOxXX9ElOC/6qU/cFtwFAgGR2K59LAORDXXXA8UVJQ2Z8XXItngau0xFcB8DPkc+Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429418; c=relaxed/simple;
	bh=QeGIgAM6KJ7TDZloKOhlbswXADZ1g/7mJsZP2l8Hu10=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdTCTiuNApJDKQFjb1qq/JIhb8/unt2zI8WBApIlyIixMZbSmEn2QfKtsKJj3o+qO+lv7OLHGaRdq7f3uBYpfR22kcKU7oIyu90Fw5VYb35NzkX0p1kooUvA20ffREhO+Ny3BLnFb9Gxhhq9LBlvgZiKGgXCJwJyGRxoWLrK+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UIH8Nqk8; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=UIH8Nqk8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 89C4033B63
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpmU3HDOHXIgxBcGcVH2HNw8rSSDBW9MSArdy+B6xNs=;
	b=UIH8Nqk8jmZnIXDgJRyvbk4hdb9v6h1xwpnG8TfJGvcCc6ilDpnWJOB3Lb74ARV2SSEwBA
	h2EfYQwOzMeuybGdj4JBBQdc5/wo60E5ym4RzhLTawHQnS5laHnB8qFvpYJFnsoaigECKc
	EtkxhAEtHnUCqcPkTEIuI5gfcFBp/48=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dpmU3HDOHXIgxBcGcVH2HNw8rSSDBW9MSArdy+B6xNs=;
	b=UIH8Nqk8jmZnIXDgJRyvbk4hdb9v6h1xwpnG8TfJGvcCc6ilDpnWJOB3Lb74ARV2SSEwBA
	h2EfYQwOzMeuybGdj4JBBQdc5/wo60E5ym4RzhLTawHQnS5laHnB8qFvpYJFnsoaigECKc
	EtkxhAEtHnUCqcPkTEIuI5gfcFBp/48=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B6AF139DE
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YNAcA+QdMGb2GQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs: export the expected file extent through can_nocow_extent()
Date: Tue, 30 Apr 2024 07:53:01 +0930
Message-ID: <7c9231a35751194fa07d64b2fc99dd406ec5b75a.1714428940.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1714428940.git.wqu@suse.com>
References: <cover.1714428940.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

Currently function can_nocow_extent() only returns members needed for
extent_map.

However since we will soon change the extent_map structure to be more
like btrfs_file_extent_item, we want to expose the expected file extent
caused by the NOCOW write for future usage.

This would introduce a new structure, btrfs_file_extent, to be a more
memory-access-friendly representation of btrfs_file_extent_item.
And use that structure to expose the expected file extent caused by the
NOCOW write.

For now there is no user of the new structure yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h | 20 +++++++++++++++++++-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       | 22 +++++++++++++++++++---
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index de918d89a582..18678762615a 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -443,9 +443,27 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
+
+/*
+ * A more access-friendly representation of btrfs_file_extent_item.
+ *
+ * Unused members are excluded.
+ */
+struct btrfs_file_extent {
+	u64 disk_bytenr;
+	u64 disk_num_bytes;
+
+	u64 num_bytes;
+	u64 ram_bytes;
+	u64 offset;
+
+	u8 compression;
+};
+
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-			      u64 *ram_bytes, bool nowait, bool strict);
+			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
+			      bool nowait, bool strict);
 
 void btrfs_del_delalloc_inode(struct btrfs_inode *inode);
 struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *dentry);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index d3cbd161cd90..63a13a4cace0 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1104,7 +1104,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 						   &cached_state);
 	}
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
-			NULL, NULL, NULL, nowait, false);
+			NULL, NULL, NULL, NULL, nowait, false);
 	if (ret <= 0)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 	else
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d8a87f3e767f..17377746a274 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1830,6 +1830,9 @@ struct can_nocow_file_extent_args {
 	u64 extent_offset;
 	/* Number of bytes that can be written to in NOCOW mode. */
 	u64 num_bytes;
+
+	/* The expected file extent for the NOCOW write. */
+	struct btrfs_file_extent file_extent;
 };
 
 /*
@@ -1894,6 +1897,12 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 
 	extent_end = btrfs_file_extent_end(path);
 
+	args->file_extent.disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
+	args->file_extent.disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
+	args->file_extent.ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
+	args->file_extent.offset = btrfs_file_extent_offset(leaf, fi);
+	args->file_extent.compression = btrfs_file_extent_compression(leaf, fi);
+
 	/*
 	 * The following checks can be expensive, as they need to take other
 	 * locks and do btree or rbtree searches, so release the path to avoid
@@ -1928,6 +1937,9 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	args->disk_bytenr += args->start - key->offset;
 	args->num_bytes = min(args->end + 1, extent_end) - args->start;
 
+	args->file_extent.num_bytes = args->num_bytes;
+	args->file_extent.offset += args->start - key->offset;
+
 	/*
 	 * Force COW if csums exist in the range. This ensures that csums for a
 	 * given extent are either valid or do not exist.
@@ -7058,7 +7070,8 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-			      u64 *ram_bytes, bool nowait, bool strict)
+			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
+			      bool nowait, bool strict)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
@@ -7147,6 +7160,9 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		*orig_start = key.offset - nocow_args.extent_offset;
 	if (orig_block_len)
 		*orig_block_len = nocow_args.disk_num_bytes;
+	if (file_extent)
+		memcpy(file_extent, &nocow_args.file_extent,
+		       sizeof(struct btrfs_file_extent));
 
 	*len = nocow_args.num_bytes;
 	ret = 1;
@@ -7366,7 +7382,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = em->block_start + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
-				     &orig_block_len, &ram_bytes, false, false) == 1) {
+				     &orig_block_len, &ram_bytes, NULL, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
@@ -10617,7 +10633,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, false, true);
+		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, NULL, false, true);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
-- 
2.44.0


