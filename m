Return-Path: <linux-btrfs+bounces-5228-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC7D8CCB93
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2150E1F22B12
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF50013B284;
	Thu, 23 May 2024 05:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U2L8RPKX";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="U2L8RPKX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082E38DF2
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440637; cv=none; b=aVRswmo6tLZSIcG+qeurY7tM4NvusOjHqWwrNEVhbve+n+OBEEG7uIJ3lpW7uT6Dz2DJfWFbbJ9jO46SjuPAf36NPMl3+XTX6DFoO4fTEJ81gtXFn08IJfnBDSHvsQ4JWe0SEvyKEixawKCSACMXGWUGFiGMsxG9roGbnM/DST4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440637; c=relaxed/simple;
	bh=EWgkfTX7hITW6TmxXMy8A33IMCKefe7el/o3QKSuAtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te/JmuMLKid8dTfR1hvEZygJVmrWaM2nvLhbe1VNPPxQTvEwU90CObMSLLA1T9PSHfzF3w+YQo/b1n2NyXmyLl04642MeyW7ZbngrrLD78nCX32fFLmOJUSAbB5Bu+pWzEXskOLNkWhaWpqGREaUiw6FmLVdJcrdDpSzC2NmAOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U2L8RPKX; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=U2L8RPKX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F94B220E5;
	Thu, 23 May 2024 05:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zF6lsrx8kFeEzGyGuMGdZhuRCHJ2/CV7EhxUUQw9Emc=;
	b=U2L8RPKXXRnVONjU87YKuCAbhew3Af3kiN7bSyik9W1Yf6sLrwtDXuUHeiSqtcDXxNjkWC
	+EiBkXSj+p0AvH+lyeP4zGMbCn2nUBQEm2WrfmaRhelNsPDiKaId+DHGezO6o96vkh1BOs
	rEuYkzXpuUdziW29fYihIlVgWgmLpQc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=U2L8RPKX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zF6lsrx8kFeEzGyGuMGdZhuRCHJ2/CV7EhxUUQw9Emc=;
	b=U2L8RPKXXRnVONjU87YKuCAbhew3Af3kiN7bSyik9W1Yf6sLrwtDXuUHeiSqtcDXxNjkWC
	+EiBkXSj+p0AvH+lyeP4zGMbCn2nUBQEm2WrfmaRhelNsPDiKaId+DHGezO6o96vkh1BOs
	rEuYkzXpuUdziW29fYihIlVgWgmLpQc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29AAD13A6B;
	Thu, 23 May 2024 05:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFSBNDfOTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 May 2024 05:03:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v3 02/11] btrfs: export the expected file extent through can_nocow_extent()
Date: Thu, 23 May 2024 14:33:21 +0930
Message-ID: <8639ffd4a7889bddca372a07d4caa6f39ba4677e.1716440169.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716440169.git.wqu@suse.com>
References: <cover.1716440169.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5F94B220E5
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]

Currently function can_nocow_extent() only returns members needed for
extent_map.

However since we will soon change the extent_map structure to be more
like btrfs_file_extent_item, we want to expose the expected file extent
caused by the NOCOW write for future usage.

This introduces a new structure, btrfs_file_extent, to be a more
memory-access-friendly representation of btrfs_file_extent_item.
And use that structure to expose the expected file extent caused by the
NOCOW write.

For now there is no user of the new structure yet.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h | 17 ++++++++++++++++-
 fs/btrfs/file.c        |  2 +-
 fs/btrfs/inode.c       | 22 +++++++++++++++++++---
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 60fd81eaedb8..9ada4185ff93 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -514,9 +514,24 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
+
+/*
+ * This represents details about the target file extent item of a write
+ * operation.
+ */
+struct btrfs_file_extent {
+	u64 disk_bytenr;
+	u64 disk_num_bytes;
+	u64 num_bytes;
+	u64 ram_bytes;
+	u64 offset;
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
index a216a0fdf58d..7c42565da70c 100644
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
index 7148da50e435..8ac489fb5e39 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1855,6 +1855,9 @@ struct can_nocow_file_extent_args {
 	u64 extent_offset;
 	/* Number of bytes that can be written to in NOCOW mode. */
 	u64 num_bytes;
+
+	/* The expected file extent for the NOCOW write. */
+	struct btrfs_file_extent file_extent;
 };
 
 /*
@@ -1919,6 +1922,12 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 
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
@@ -1953,6 +1962,9 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	args->disk_bytenr += args->start - key->offset;
 	args->num_bytes = min(args->end + 1, extent_end) - args->start;
 
+	args->file_extent.num_bytes = args->num_bytes;
+	args->file_extent.offset += args->start - key->offset;
+
 	/*
 	 * Force COW if csums exist in the range. This ensures that csums for a
 	 * given extent are either valid or do not exist.
@@ -7137,7 +7149,8 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 			      u64 *orig_start, u64 *orig_block_len,
-			      u64 *ram_bytes, bool nowait, bool strict)
+			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
+			      bool nowait, bool strict)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	struct can_nocow_file_extent_args nocow_args = { 0 };
@@ -7226,6 +7239,9 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		*orig_start = key.offset - nocow_args.extent_offset;
 	if (orig_block_len)
 		*orig_block_len = nocow_args.disk_num_bytes;
+	if (file_extent)
+		memcpy(file_extent, &nocow_args.file_extent,
+		       sizeof(*file_extent));
 
 	*len = nocow_args.num_bytes;
 	ret = 1;
@@ -7445,7 +7461,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		block_start = em->block_start + (start - em->start);
 
 		if (can_nocow_extent(inode, start, &len, &orig_start,
-				     &orig_block_len, &ram_bytes, false, false) == 1) {
+				     &orig_block_len, &ram_bytes, NULL, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
@@ -10687,7 +10703,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, false, true);
+		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, NULL, false, true);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
-- 
2.45.1


