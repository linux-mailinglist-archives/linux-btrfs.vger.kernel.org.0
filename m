Return-Path: <linux-btrfs+bounces-4702-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3AF8BA6CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 08:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A53CE1F228AF
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 06:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED61139D10;
	Fri,  3 May 2024 06:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l47yQYfK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="l47yQYfK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765E1C6BD
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716133; cv=none; b=LkLePj1CHvkKVyVTx+lIShJafDiv66OOU41XgU3BOAomB39E3fE3sxJCS1u2jmPXkR+GOcibQPl1/V8HZHlvu2LCt3j0rzm4Ja5qrg054yfDraZuqz2cbcxU9QWIh4FoDJG4x2DpcgcSi7SgeE9Q4BQho4P6Q6WuNuHGUVqwyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716133; c=relaxed/simple;
	bh=OtEmf87W9IKwX55Kn5mEE1w0G1YFx07b7sDmcfDG68c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=II5lKAP7KTIyfCGPwa1PFs+XofuqUFsGo6U/gaKXyjssPdrGtCpQUh3F29ueZ9ftqcb//S+rycd1yB8k+zpulfBxK4mi8GMNZy+UIfpiGec3OoUc/HUtG/ib5Tnq01uwIgtBPxWGA/9WO0Sw8Vok/oxM8dxdc2jZdxd+xoiOybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l47yQYfK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=l47yQYfK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7DC822881;
	Fri,  3 May 2024 06:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ll26ndOFh71OqEfFv8bEaQQizLFcoYQEHKlTSsUwmg=;
	b=l47yQYfKN8kzEXWZnRFx9qFH3MhMTUT/opLWmP24E6pLs2zpdUXiJ4d/DaABnKN6CA1ol4
	eKL6LHaHhNW9nrSwGcPCuWcbnSKlcx3aeYKgsde/QL0PWPbyrR3+gmV814M24n/NHVV+H9
	44WZGVbvVbdvy31PTqmRj5IdTbeVEOg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=l47yQYfK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ll26ndOFh71OqEfFv8bEaQQizLFcoYQEHKlTSsUwmg=;
	b=l47yQYfKN8kzEXWZnRFx9qFH3MhMTUT/opLWmP24E6pLs2zpdUXiJ4d/DaABnKN6CA1ol4
	eKL6LHaHhNW9nrSwGcPCuWcbnSKlcx3aeYKgsde/QL0PWPbyrR3+gmV814M24n/NHVV+H9
	44WZGVbvVbdvy31PTqmRj5IdTbeVEOg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 893B013991;
	Fri,  3 May 2024 06:02:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MD1WD+B9NGbgawAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 03 May 2024 06:02:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 02/11] btrfs: export the expected file extent through can_nocow_extent()
Date: Fri,  3 May 2024 15:31:37 +0930
Message-ID: <e351482ededb22c1fb81eeed217ae8e34e8e1427.1714707707.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1714707707.git.wqu@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C7DC822881
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

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
Signed-off-by: David Sterba <dsterba@suse.com>
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
index 0e5d4517af0e..2815b72f2d85 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1857,6 +1857,9 @@ struct can_nocow_file_extent_args {
 	u64 extent_offset;
 	/* Number of bytes that can be written to in NOCOW mode. */
 	u64 num_bytes;
+
+	/* The expected file extent for the NOCOW write. */
+	struct btrfs_file_extent file_extent;
 };
 
 /*
@@ -1921,6 +1924,12 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 
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
@@ -1955,6 +1964,9 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	args->disk_bytenr += args->start - key->offset;
 	args->num_bytes = min(args->end + 1, extent_end) - args->start;
 
+	args->file_extent.num_bytes = args->num_bytes;
+	args->file_extent.offset += args->start - key->offset;
+
 	/*
 	 * Force COW if csums exist in the range. This ensures that csums for a
 	 * given extent are either valid or do not exist.
@@ -7099,7 +7111,8 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-			      u64 *ram_bytes, bool nowait, bool strict)
+			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
+			      bool nowait, bool strict)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
@@ -7188,6 +7201,9 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		*orig_start = key.offset - nocow_args.extent_offset;
 	if (orig_block_len)
 		*orig_block_len = nocow_args.disk_num_bytes;
+	if (file_extent)
+		memcpy(file_extent, &nocow_args.file_extent,
+		       sizeof(struct btrfs_file_extent));
 
 	*len = nocow_args.num_bytes;
 	ret = 1;
@@ -7407,7 +7423,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = em->block_start + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
-				     &orig_block_len, &ram_bytes, false, false) == 1) {
+				     &orig_block_len, &ram_bytes, NULL, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
@@ -10660,7 +10676,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, false, true);
+		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, NULL, false, true);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
-- 
2.45.0


