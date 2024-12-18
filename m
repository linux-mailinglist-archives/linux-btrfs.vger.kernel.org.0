Return-Path: <linux-btrfs+bounces-10543-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A371B9F6201
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BECC71894310
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B65519D071;
	Wed, 18 Dec 2024 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XA+vpUpB";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="XA+vpUpB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE09119B5A7
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514938; cv=none; b=VzjNZQn6nv5d9MeNl0hPfZq7yEiAD8ARfynTeun3oQ+W5EclwLINUFbd1PJrGEzEM3UMY8/c6+TvBpuIfFluB89Qfl1EQDZVB5itn6kPmX2gOgkaKWL7jwSrqWbcMOZfnTbJ4GG/8ZD+NG+g0KBiG1DCp7vFQcDIWO+5Q4eW7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514938; c=relaxed/simple;
	bh=1+zqYI94I7B3ES/vOmOy1jr0GEhLq6x3wvBp0YSucMQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNReoEbcCmMuGt7M70HVCLXsTQ2eqx089VoHtf4ODdiL+Q82ifC1nNJA++veR/TNSyCW7KTSq/wZKbg5g4sF0feVbk6Zwd2CXExwDn+rFyPNItauRTLLSp0BsjBTBHJtqw+Q1+cODQEupeq1+4E0RRy4ToZKSkSbBU58+b8UbfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XA+vpUpB; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=XA+vpUpB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 186C62115D
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKI+Pg1xH10mDnpPOe5AKZUIm+f2GfcOQnaAD1/pSBk=;
	b=XA+vpUpBBGsbVZ+lkkufMzYaul2uvy3hDybUtUwxASHb+zAInhbQYL5c20dWDeVPnkbBvH
	/TsHqzbGdubSH6OuKMiA7ub9Frzl/3Ht6EI6rYaUVV1gKdqOEJSMekWCLbfmVWz7oLgX6i
	VoZctqSPWUH81lBcFrwAtKX4cGOHam8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=XA+vpUpB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514932; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RKI+Pg1xH10mDnpPOe5AKZUIm+f2GfcOQnaAD1/pSBk=;
	b=XA+vpUpBBGsbVZ+lkkufMzYaul2uvy3hDybUtUwxASHb+zAInhbQYL5c20dWDeVPnkbBvH
	/TsHqzbGdubSH6OuKMiA7ub9Frzl/3Ht6EI6rYaUVV1gKdqOEJSMekWCLbfmVWz7oLgX6i
	VoZctqSPWUH81lBcFrwAtKX4cGOHam8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44DAC132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cCchAfOYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:11 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 14/18] btrfs: migrate the remaining sector size users to use block size terminology
Date: Wed, 18 Dec 2024 20:11:30 +1030
Message-ID: <36297da5c8f2583ea449444e504262d9863f94fc.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 186C62115D
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Those files are minor users of the old sector size terminology, so just
migrate them all in one go.

Note that, btrfs_device::sector_size is not renamed, as we keep the
"sector" usage for block devices.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/accessors.h      |  2 +-
 fs/btrfs/block-group.c    |  4 ++--
 fs/btrfs/delalloc-space.c | 26 +++++++++++++-------------
 fs/btrfs/delayed-inode.c  |  2 +-
 fs/btrfs/delayed-ref.c    | 12 ++++++------
 fs/btrfs/delayed-ref.h    |  4 ++--
 fs/btrfs/dev-replace.c    | 12 ++++++------
 fs/btrfs/direct-io.c      |  6 +++---
 fs/btrfs/extent-tree.c    | 14 +++++++-------
 fs/btrfs/extent_map.h     |  2 +-
 fs/btrfs/fiemap.c         |  6 +++---
 fs/btrfs/inode-item.c     |  8 ++++----
 fs/btrfs/ioctl.c          | 14 +++++++-------
 fs/btrfs/print-tree.c     | 14 +++++++-------
 fs/btrfs/qgroup.c         | 10 +++++-----
 fs/btrfs/qgroup.h         |  2 +-
 fs/btrfs/reflink.c        | 22 +++++++++++-----------
 fs/btrfs/relocation.c     | 16 ++++++++--------
 fs/btrfs/send.c           | 36 ++++++++++++++++++------------------
 fs/btrfs/super.c          | 10 +++++-----
 fs/btrfs/sysfs.c          |  4 ++--
 fs/btrfs/tree-log.c       |  6 +++---
 fs/btrfs/volumes.c        | 26 +++++++++++++-------------
 fs/btrfs/zoned.c          |  6 +++---
 24 files changed, 132 insertions(+), 132 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 7a7e0ef69973..a796ec3fcb67 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -131,7 +131,7 @@ static inline void btrfs_set_device_total_bytes(const struct extent_buffer *eb,
 						u64 val)
 {
 	static_assert(sizeof(u64) == sizeof_field(struct btrfs_dev_item, total_bytes));
-	WARN_ON(!IS_ALIGNED(val, eb->fs_info->sectorsize));
+	WARN_ON(!IS_ALIGNED(val, eb->fs_info->blocksize));
 	btrfs_set_64(eb, s, offsetof(struct btrfs_dev_item, total_bytes), val);
 }
 
diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5be029734cfa..e1dc9345310f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -489,7 +489,7 @@ static void fragment_free_space(struct btrfs_block_group *block_group)
 	u64 start = block_group->start;
 	u64 len = block_group->length;
 	u64 chunk = block_group->flags & BTRFS_BLOCK_GROUP_METADATA ?
-		fs_info->nodesize : fs_info->sectorsize;
+		fs_info->nodesize : fs_info->blocksize;
 	u64 step = chunk << 1;
 
 	while (len > chunk) {
@@ -3267,7 +3267,7 @@ static int cache_save_setup(struct btrfs_block_group *block_group,
 		cache_size = 1;
 
 	cache_size *= 16;
-	cache_size *= fs_info->sectorsize;
+	cache_size *= fs_info->blocksize;
 
 	ret = btrfs_check_data_free_space(BTRFS_I(inode), &data_reserved, 0,
 					  cache_size, false);
diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 88e900e5a43d..c18de463c02a 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -117,8 +117,8 @@ int btrfs_alloc_data_chunk_ondemand(const struct btrfs_inode *inode, u64 bytes)
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	enum btrfs_reserve_flush_enum flush = BTRFS_RESERVE_FLUSH_DATA;
 
-	/* Make sure bytes are sectorsize aligned */
-	bytes = ALIGN(bytes, fs_info->sectorsize);
+	/* Make sure bytes are blocksize aligned */
+	bytes = ALIGN(bytes, fs_info->blocksize);
 
 	if (btrfs_is_free_space_inode(inode))
 		flush = BTRFS_RESERVE_FLUSH_FREE_SPACE_INODE;
@@ -135,9 +135,9 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 	int ret;
 
 	/* align the range */
-	len = round_up(start + len, fs_info->sectorsize) -
-	      round_down(start, fs_info->sectorsize);
-	start = round_down(start, fs_info->sectorsize);
+	len = round_up(start + len, fs_info->blocksize) -
+	      round_down(start, fs_info->blocksize);
+	start = round_down(start, fs_info->blocksize);
 
 	if (noflush)
 		flush = BTRFS_RESERVE_NO_FLUSH;
@@ -173,7 +173,7 @@ void btrfs_free_reserved_data_space_noquota(struct btrfs_fs_info *fs_info,
 {
 	struct btrfs_space_info *data_sinfo;
 
-	ASSERT(IS_ALIGNED(len, fs_info->sectorsize));
+	ASSERT(IS_ALIGNED(len, fs_info->blocksize));
 
 	data_sinfo = fs_info->data_sinfo;
 	btrfs_space_info_free_bytes_may_use(data_sinfo, len);
@@ -191,10 +191,10 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	/* Make sure the range is aligned to sectorsize */
-	len = round_up(start + len, fs_info->sectorsize) -
-	      round_down(start, fs_info->sectorsize);
-	start = round_down(start, fs_info->sectorsize);
+	/* Make sure the range is aligned to blocksize */
+	len = round_up(start + len, fs_info->blocksize) -
+	      round_down(start, fs_info->blocksize);
+	start = round_down(start, fs_info->blocksize);
 
 	btrfs_free_reserved_data_space_noquota(fs_info, len);
 	btrfs_qgroup_free_data(inode, reserved, start, len, NULL);
@@ -329,8 +329,8 @@ int btrfs_delalloc_reserve_metadata(struct btrfs_inode *inode, u64 num_bytes,
 			flush = BTRFS_RESERVE_FLUSH_LIMIT;
 	}
 
-	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
-	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->sectorsize);
+	num_bytes = ALIGN(num_bytes, fs_info->blocksize);
+	disk_num_bytes = ALIGN(disk_num_bytes, fs_info->blocksize);
 
 	/*
 	 * We always want to do it this way, every other way is wrong and ends
@@ -397,7 +397,7 @@ void btrfs_delalloc_release_metadata(struct btrfs_inode *inode, u64 num_bytes,
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 
-	num_bytes = ALIGN(num_bytes, fs_info->sectorsize);
+	num_bytes = ALIGN(num_bytes, fs_info->blocksize);
 	spin_lock(&inode->lock);
 	if (!(inode->flags & BTRFS_INODE_NODATASUM))
 		inode->csum_bytes -= num_bytes;
diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index 508bdbae29a0..024254229dda 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1887,7 +1887,7 @@ int btrfs_fill_inode(struct inode *inode, u32 *rdev)
 	i_gid_write(inode, btrfs_stack_inode_gid(inode_item));
 	btrfs_i_size_write(BTRFS_I(inode), btrfs_stack_inode_size(inode_item));
 	btrfs_inode_set_file_extent_range(BTRFS_I(inode), 0,
-			round_up(i_size_read(inode), fs_info->sectorsize));
+			round_up(i_size_read(inode), fs_info->blocksize));
 	inode->i_mode = btrfs_stack_inode_mode(inode_item);
 	set_nlink(inode, btrfs_stack_inode_nlink(inode_item));
 	inode_set_bytes(inode, btrfs_stack_inode_nbytes(inode_item));
diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index 30f7079fa28e..1c88970b1cab 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -496,7 +496,7 @@ struct btrfs_delayed_ref_head *btrfs_select_ref_head(
 
 	spin_lock(&delayed_refs->lock);
 again:
-	start_index = (delayed_refs->run_delayed_start >> fs_info->sectorsize_bits);
+	start_index = (delayed_refs->run_delayed_start >> fs_info->blocksize_bits);
 	xa_for_each_start(&delayed_refs->head_refs, found_index, head, start_index) {
 		if (!head->processing) {
 			found_head = true;
@@ -546,7 +546,7 @@ void btrfs_delete_ref_head(const struct btrfs_fs_info *fs_info,
 			   struct btrfs_delayed_ref_root *delayed_refs,
 			   struct btrfs_delayed_ref_head *head)
 {
-	const unsigned long index = (head->bytenr >> fs_info->sectorsize_bits);
+	const unsigned long index = (head->bytenr >> fs_info->blocksize_bits);
 
 	lockdep_assert_held(&delayed_refs->lock);
 	lockdep_assert_held(&head->lock);
@@ -825,7 +825,7 @@ add_delayed_ref_head(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_delayed_ref_head *existing;
 	struct btrfs_delayed_ref_root *delayed_refs;
-	const unsigned long index = (head_ref->bytenr >> fs_info->sectorsize_bits);
+	const unsigned long index = (head_ref->bytenr >> fs_info->blocksize_bits);
 	bool qrecord_inserted = false;
 
 	delayed_refs = &trans->transaction->delayed_refs;
@@ -1006,7 +1006,7 @@ static int add_delayed_ref(struct btrfs_trans_handle *trans,
 	struct btrfs_delayed_ref_head *new_head_ref;
 	struct btrfs_delayed_ref_root *delayed_refs;
 	struct btrfs_qgroup_extent_record *record = NULL;
-	const unsigned long index = (generic_ref->bytenr >> fs_info->sectorsize_bits);
+	const unsigned long index = (generic_ref->bytenr >> fs_info->blocksize_bits);
 	bool qrecord_reserved = false;
 	bool qrecord_inserted;
 	int action = generic_ref->action;
@@ -1121,7 +1121,7 @@ int btrfs_add_delayed_extent_op(struct btrfs_trans_handle *trans,
 				u64 bytenr, u64 num_bytes, u8 level,
 				struct btrfs_delayed_extent_op *extent_op)
 {
-	const unsigned long index = (bytenr >> trans->fs_info->sectorsize_bits);
+	const unsigned long index = (bytenr >> trans->fs_info->blocksize_bits);
 	struct btrfs_delayed_ref_head *head_ref;
 	struct btrfs_delayed_ref_head *head_ref_ret;
 	struct btrfs_delayed_ref_root *delayed_refs;
@@ -1185,7 +1185,7 @@ btrfs_find_delayed_ref_head(const struct btrfs_fs_info *fs_info,
 			    struct btrfs_delayed_ref_root *delayed_refs,
 			    u64 bytenr)
 {
-	const unsigned long index = (bytenr >> fs_info->sectorsize_bits);
+	const unsigned long index = (bytenr >> fs_info->blocksize_bits);
 
 	lockdep_assert_held(&delayed_refs->lock);
 
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index a35067cebb97..aa2616a08e1a 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -202,7 +202,7 @@ struct btrfs_delayed_ref_root {
 	/*
 	 * Track head references.
 	 * The keys correspond to the logical address of the extent ("bytenr")
-	 * right shifted by fs_info->sectorsize_bits. This is both to get a more
+	 * right shifted by fs_info->blocksize_bits. This is both to get a more
 	 * dense index space (optimizes xarray structure) and because indexes in
 	 * xarrays are of "unsigned long" type, meaning they are 32 bits wide on
 	 * 32 bits platforms, limiting the extent range to 4G which is too low
@@ -214,7 +214,7 @@ struct btrfs_delayed_ref_root {
 	/*
 	 * Track dirty extent records.
 	 * The keys correspond to the logical address of the extent ("bytenr")
-	 * right shifted by fs_info->sectorsize_bits, for same reasons as above.
+	 * right shifted by fs_info->blocksize_bits, for same reasons as above.
 	 */
 	struct xarray dirty_extents;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index ac8e97ed13f7..727b619bf280 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -216,9 +216,9 @@ int btrfs_init_dev_replace(struct btrfs_fs_info *fs_info)
 				&dev_replace->tgtdev->dev_state);
 
 			WARN_ON(fs_info->fs_devices->rw_devices == 0);
-			dev_replace->tgtdev->io_width = fs_info->sectorsize;
-			dev_replace->tgtdev->io_align = fs_info->sectorsize;
-			dev_replace->tgtdev->sector_size = fs_info->sectorsize;
+			dev_replace->tgtdev->io_width = fs_info->blocksize;
+			dev_replace->tgtdev->io_align = fs_info->blocksize;
+			dev_replace->tgtdev->sector_size = fs_info->blocksize;
 			dev_replace->tgtdev->fs_info = fs_info;
 			set_bit(BTRFS_DEV_STATE_IN_FS_METADATA,
 				&dev_replace->tgtdev->dev_state);
@@ -302,9 +302,9 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 
 	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	device->generation = 0;
-	device->io_width = fs_info->sectorsize;
-	device->io_align = fs_info->sectorsize;
-	device->sector_size = fs_info->sectorsize;
+	device->io_width = fs_info->blocksize;
+	device->io_align = fs_info->blocksize;
+	device->sector_size = fs_info->blocksize;
 	device->total_bytes = btrfs_device_get_total_bytes(srcdev);
 	device->disk_total_bytes = btrfs_device_get_disk_total_bytes(srcdev);
 	device->bytes_used = btrfs_device_get_bytes_used(srcdev);
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index 3229f07f5d6d..843bba0b995e 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -183,7 +183,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 
 	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, len);
 again:
-	ret = btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
+	ret = btrfs_reserve_extent(root, len, len, fs_info->blocksize,
 				   0, alloc_hint, &ins, 1, 1);
 	if (ret == -EAGAIN) {
 		ASSERT(btrfs_is_zoned(fs_info));
@@ -385,7 +385,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	 * to allocate a contiguous array for the checksums.
 	 */
 	if (!write)
-		len = min_t(u64, len, fs_info->sectorsize * BTRFS_MAX_BIO_BLOCKS);
+		len = min_t(u64, len, fs_info->blocksize * BTRFS_MAX_BIO_BLOCKS);
 
 	lockstart = start;
 	lockend = start + len - 1;
@@ -778,7 +778,7 @@ static struct iomap_dio *btrfs_dio_write(struct kiocb *iocb, struct iov_iter *it
 static ssize_t check_direct_IO(struct btrfs_fs_info *fs_info,
 			       const struct iov_iter *iter, loff_t offset)
 {
-	const u32 blocksize_mask = fs_info->sectorsize - 1;
+	const u32 blocksize_mask = fs_info->blocksize - 1;
 
 	if (offset & blocksize_mask)
 		return -EINVAL;
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e849fc34d8d9..bd282a760c51 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -356,9 +356,9 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				ASSERT(fs_info);
 				/*
 				 * Every shared one has parent tree block,
-				 * which must be aligned to sector size.
+				 * which must be aligned to block size.
 				 */
-				if (offset && IS_ALIGNED(offset, fs_info->sectorsize))
+				if (offset && IS_ALIGNED(offset, fs_info->blocksize))
 					return type;
 			}
 		} else if (is_data == BTRFS_REF_TYPE_DATA) {
@@ -368,10 +368,10 @@ int btrfs_get_extent_inline_ref_type(const struct extent_buffer *eb,
 				ASSERT(fs_info);
 				/*
 				 * Every shared one has parent tree block,
-				 * which must be aligned to sector size.
+				 * which must be aligned to block size.
 				 */
 				if (offset &&
-				    IS_ALIGNED(offset, fs_info->sectorsize))
+				    IS_ALIGNED(offset, fs_info->blocksize))
 					return type;
 			}
 		} else {
@@ -4363,7 +4363,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
 	struct btrfs_space_info *space_info;
 	bool full_search = false;
 
-	WARN_ON(ffe_ctl->num_bytes < fs_info->sectorsize);
+	WARN_ON(ffe_ctl->num_bytes < fs_info->blocksize);
 
 	ffe_ctl->search_start = 0;
 	/* For clustered allocation */
@@ -4666,7 +4666,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 
 	flags = get_alloc_profile_by_root(root, is_data);
 again:
-	WARN_ON(num_bytes < fs_info->sectorsize);
+	WARN_ON(num_bytes < fs_info->blocksize);
 
 	ffe_ctl.ram_bytes = ram_bytes;
 	ffe_ctl.num_bytes = num_bytes;
@@ -4685,7 +4685,7 @@ int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
 		if (!final_tried && ins->offset) {
 			num_bytes = min(num_bytes >> 1, ins->offset);
 			num_bytes = round_down(num_bytes,
-					       fs_info->sectorsize);
+					       fs_info->blocksize);
 			num_bytes = max(num_bytes, min_alloc_size);
 			ram_bytes = num_bytes;
 			if (num_bytes == min_alloc_size)
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index cd123b266b64..2a7412f294e1 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -54,7 +54,7 @@ struct extent_map {
 	 * Length of the file extent.
 	 *
 	 * For non-inlined file extents it's btrfs_file_extent_item::num_bytes.
-	 * For inline extents it's sectorsize, since inline data starts at
+	 * For inline extents it's blocksize, since inline data starts at
 	 * offsetof(struct btrfs_file_extent_item, disk_bytenr) thus
 	 * btrfs_file_extent_item::num_bytes is not valid.
 	 */
diff --git a/fs/btrfs/fiemap.c b/fs/btrfs/fiemap.c
index b80c07ad8c5e..37020fa980bf 100644
--- a/fs/btrfs/fiemap.c
+++ b/fs/btrfs/fiemap.c
@@ -641,7 +641,7 @@ static int extent_fiemap(struct btrfs_inode *inode,
 	u64 prev_extent_end;
 	u64 range_start;
 	u64 range_end;
-	const u64 sectorsize = inode->root->fs_info->sectorsize;
+	const u64 blocksize = inode->root->fs_info->blocksize;
 	bool stopped = false;
 	int ret;
 
@@ -657,8 +657,8 @@ static int extent_fiemap(struct btrfs_inode *inode,
 	}
 
 restart:
-	range_start = round_down(start, sectorsize);
-	range_end = round_up(start + len, sectorsize);
+	range_start = round_down(start, blocksize);
+	range_end = round_up(start + len, blocksize);
 	prev_extent_end = range_start;
 
 	lock_extent(&inode->io_tree, range_start, range_end, &cached_state);
diff --git a/fs/btrfs/inode-item.c b/fs/btrfs/inode-item.c
index 29572dfaf878..7fd7bcdda7a7 100644
--- a/fs/btrfs/inode-item.c
+++ b/fs/btrfs/inode-item.c
@@ -582,8 +582,8 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 					btrfs_file_extent_num_bytes(leaf, fi);
 				extent_num_bytes = ALIGN(new_size -
 						found_key.offset,
-						fs_info->sectorsize);
-				clear_start = ALIGN(new_size, fs_info->sectorsize);
+						fs_info->blocksize);
+				clear_start = ALIGN(new_size, fs_info->blocksize);
 
 				btrfs_set_file_extent_num_bytes(leaf, fi,
 							 extent_num_bytes);
@@ -627,10 +627,10 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 			} else {
 				/*
 				 * Inline extents are special, we just treat
-				 * them as a full sector worth in the file
+				 * them as a full block worth in the file
 				 * extent tree just for simplicity sake.
 				 */
-				clear_len = fs_info->sectorsize;
+				clear_len = fs_info->blocksize;
 			}
 
 			control->sub_bytes += item_end + 1 - new_size;
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7872de140489..888f7b97434c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -457,9 +457,9 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
 	/*
 	 * NOTE: Don't truncate the range using super->total_bytes.  Bytenr of
 	 * block group is in the logical address space, which can be any
-	 * sectorsize aligned bytenr in  the range [0, U64_MAX].
+	 * blocksize aligned bytenr in  the range [0, U64_MAX].
 	 */
-	if (range.len < fs_info->sectorsize)
+	if (range.len < fs_info->blocksize)
 		return -EINVAL;
 
 	range.minlen = max(range.minlen, minlen);
@@ -1155,7 +1155,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		goto out_finish;
 	}
 
-	new_size = round_down(new_size, fs_info->sectorsize);
+	new_size = round_down(new_size, fs_info->blocksize);
 
 	if (new_size > old_size) {
 		trans = btrfs_start_transaction(root, 0);
@@ -2781,8 +2781,8 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 
 	memcpy(&fi_args->fsid, fs_devices->fsid, sizeof(fi_args->fsid));
 	fi_args->nodesize = fs_info->nodesize;
-	fi_args->sectorsize = fs_info->sectorsize;
-	fi_args->clone_alignment = fs_info->sectorsize;
+	fi_args->sectorsize = fs_info->blocksize;
+	fi_args->clone_alignment = fs_info->blocksize;
 
 	if (flags_in & BTRFS_FS_INFO_FLAG_CSUM_INFO) {
 		fi_args->csum_type = btrfs_super_csum_type(fs_info->super_copy);
@@ -4489,7 +4489,7 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
 		bool unlocked = false;
 		u64 start, lockend, count;
 
-		start = ALIGN_DOWN(kiocb.ki_pos, fs_info->sectorsize);
+		start = ALIGN_DOWN(kiocb.ki_pos, fs_info->blocksize);
 		lockend = start + BTRFS_MAX_UNCOMPRESSED - 1;
 
 		if (args.compression)
@@ -4865,7 +4865,7 @@ static int btrfs_uring_encoded_read(struct io_uring_cmd *cmd, unsigned int issue
 	if (issue_flags & IO_URING_F_NONBLOCK)
 		kiocb.ki_flags |= IOCB_NOWAIT;
 
-	start = ALIGN_DOWN(pos, fs_info->sectorsize);
+	start = ALIGN_DOWN(pos, fs_info->blocksize);
 	lockend = start + BTRFS_MAX_UNCOMPRESSED - 1;
 
 	ret = btrfs_encoded_read(&kiocb, &iter, &args, &cached_state,
diff --git a/fs/btrfs/print-tree.c b/fs/btrfs/print-tree.c
index fc821aa446f0..5c5428329490 100644
--- a/fs/btrfs/print-tree.c
+++ b/fs/btrfs/print-tree.c
@@ -150,10 +150,10 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
 			 * offset is supposed to be a tree block which
 			 * must be aligned to nodesize.
 			 */
-			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
+			if (!IS_ALIGNED(offset, eb->fs_info->blocksize))
 				pr_info(
-			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
-					offset, eb->fs_info->sectorsize);
+			"\t\t\t(parent %llu not aligned to blocksize %u)\n",
+					offset, eb->fs_info->blocksize);
 			break;
 		case BTRFS_EXTENT_DATA_REF_KEY:
 			dref = (struct btrfs_extent_data_ref *)(&iref->offset);
@@ -165,12 +165,12 @@ static void print_extent_item(const struct extent_buffer *eb, int slot, int type
 			       offset, btrfs_shared_data_ref_count(eb, sref));
 			/*
 			 * Offset is supposed to be a tree block which must be
-			 * aligned to sectorsize.
+			 * aligned to blocksize.
 			 */
-			if (!IS_ALIGNED(offset, eb->fs_info->sectorsize))
+			if (!IS_ALIGNED(offset, eb->fs_info->blocksize))
 				pr_info(
-			"\t\t\t(parent %llu not aligned to sectorsize %u)\n",
-				     offset, eb->fs_info->sectorsize);
+			"\t\t\t(parent %llu not aligned to blocksize %u)\n",
+				     offset, eb->fs_info->blocksize);
 			break;
 		case BTRFS_EXTENT_OWNER_REF_KEY:
 			oref = (struct btrfs_extent_owner_ref *)(&iref->offset);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 993b5e803699..b66f63bf7b02 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2015,7 +2015,7 @@ int btrfs_qgroup_trace_extent_nolock(struct btrfs_fs_info *fs_info,
 				     u64 bytenr)
 {
 	struct btrfs_qgroup_extent_record *existing, *ret;
-	const unsigned long index = (bytenr >> fs_info->sectorsize_bits);
+	const unsigned long index = (bytenr >> fs_info->blocksize_bits);
 
 	if (!btrfs_qgroup_full_accounting(fs_info))
 		return 1;
@@ -2150,7 +2150,7 @@ int btrfs_qgroup_trace_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_qgroup_extent_record *record;
 	struct btrfs_delayed_ref_root *delayed_refs = &trans->transaction->delayed_refs;
-	const unsigned long index = (bytenr >> fs_info->sectorsize_bits);
+	const unsigned long index = (bytenr >> fs_info->blocksize_bits);
 	int ret;
 
 	if (!btrfs_qgroup_full_accounting(fs_info) || bytenr == 0 || num_bytes == 0)
@@ -3048,7 +3048,7 @@ int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans)
 	delayed_refs = &trans->transaction->delayed_refs;
 	qgroup_to_skip = delayed_refs->qgroup_to_skip;
 	xa_for_each(&delayed_refs->dirty_extents, index, record) {
-		const u64 bytenr = (((u64)index) << fs_info->sectorsize_bits);
+		const u64 bytenr = (((u64)index) << fs_info->blocksize_bits);
 
 		num_dirty_extents++;
 		trace_btrfs_qgroup_account_extents(fs_info, record, bytenr);
@@ -4317,8 +4317,8 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 	int ret;
 
 	extent_changeset_init(&changeset);
-	len = round_up(start + len, root->fs_info->sectorsize);
-	start = round_down(start, root->fs_info->sectorsize);
+	len = round_up(start + len, root->fs_info->blocksize);
+	start = round_down(start, root->fs_info->blocksize);
 
 	ULIST_ITER_INIT(&uiter);
 	while ((unode = ulist_next(&reserved->range_changed, &uiter))) {
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index e233cc79af18..2b23df1b777b 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -130,7 +130,7 @@ struct btrfs_qgroup_extent_record {
 	/*
 	 * The bytenr of the extent is given by its index in the dirty_extents
 	 * xarray of struct btrfs_delayed_ref_root left shifted by
-	 * fs_info->sectorsize_bits.
+	 * fs_info->blocksize_bits.
 	 */
 
 	u64 num_bytes;
diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
index f0824c948cb7..a5804e403a5e 100644
--- a/fs/btrfs/reflink.c
+++ b/fs/btrfs/reflink.c
@@ -61,7 +61,7 @@ static int copy_inline_to_page(struct btrfs_inode *inode,
 			       const u8 comp_type)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	const u32 block_size = fs_info->sectorsize;
+	const u32 block_size = fs_info->blocksize;
 	const u64 range_end = file_offset + block_size - 1;
 	const size_t inline_size = size - btrfs_file_extent_calc_inline_size(0);
 	char *data_start = inline_data + btrfs_file_extent_calc_inline_size(0);
@@ -178,7 +178,7 @@ static int clone_copy_inline_extent(struct inode *dst,
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(dst);
 	struct btrfs_root *root = BTRFS_I(dst)->root;
 	const u64 aligned_end = ALIGN(new_key->offset + datal,
-				      fs_info->sectorsize);
+				      fs_info->blocksize);
 	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_drop_extents_args drop_args = { 0 };
 	int ret;
@@ -511,17 +511,17 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 			ASSERT(type == BTRFS_FILE_EXTENT_INLINE);
 			/*
 			 * Inline extents always have to start at file offset 0
-			 * and can never be bigger then the sector size. We can
+			 * and can never be bigger then the block size. We can
 			 * never clone only parts of an inline extent, since all
-			 * reflink operations must start at a sector size aligned
+			 * reflink operations must start at a block size aligned
 			 * offset, and the length must be aligned too or end at
 			 * the i_size (which implies the whole inlined data).
 			 */
 			ASSERT(key.offset == 0);
-			ASSERT(datal <= fs_info->sectorsize);
+			ASSERT(datal <= fs_info->blocksize);
 			if (WARN_ON(type != BTRFS_FILE_EXTENT_INLINE) ||
 			    WARN_ON(key.offset != 0) ||
-			    WARN_ON(datal > fs_info->sectorsize)) {
+			    WARN_ON(datal > fs_info->blocksize)) {
 				ret = -EUCLEAN;
 				goto out;
 			}
@@ -554,7 +554,7 @@ static int btrfs_clone(struct inode *src, struct inode *inode,
 		BTRFS_I(inode)->last_reflink_trans = trans->transid;
 
 		last_dest_end = ALIGN(new_key.offset + datal,
-				      fs_info->sectorsize);
+				      fs_info->blocksize);
 		ret = clone_finish_inode_update(trans, inode, last_dest_end,
 						destoff, olen, no_time_update);
 		if (ret)
@@ -637,7 +637,7 @@ static int btrfs_extent_same_range(struct inode *src, u64 loff, u64 len,
 	const u64 end = dst_loff + len - 1;
 	struct extent_state *cached_state = NULL;
 	struct btrfs_fs_info *fs_info = BTRFS_I(src)->root->fs_info;
-	const u64 bs = fs_info->sectorsize;
+	const u64 bs = fs_info->blocksize;
 	int ret;
 
 	/*
@@ -707,7 +707,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 	int ret;
 	int wb_ret;
 	u64 len = olen;
-	u64 bs = fs_info->sectorsize;
+	u64 bs = fs_info->blocksize;
 	u64 end;
 
 	/*
@@ -727,7 +727,7 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
 			return ret;
 		/*
 		 * We may have truncated the last block if the inode's size is
-		 * not sector size aligned, so we need to wait for writeback to
+		 * not block size aligned, so we need to wait for writeback to
 		 * complete before proceeding further, otherwise we can race
 		 * with cloning and attempt to increment a reference to an
 		 * extent that no longer exists (writeback completed right after
@@ -777,7 +777,7 @@ static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_in = file_inode(file_in);
 	struct inode *inode_out = file_inode(file_out);
-	u64 bs = BTRFS_I(inode_out)->root->fs_info->sectorsize;
+	u64 bs = BTRFS_I(inode_out)->root->fs_info->blocksize;
 	u64 wb_len;
 	int ret;
 
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index cdd9a7b15a11..e43a351a98f2 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -905,8 +905,8 @@ int replace_file_extents(struct btrfs_trans_handle *trans,
 				end = key.offset +
 				      btrfs_file_extent_num_bytes(leaf, fi);
 				WARN_ON(!IS_ALIGNED(key.offset,
-						    fs_info->sectorsize));
-				WARN_ON(!IS_ALIGNED(end, fs_info->sectorsize));
+						    fs_info->blocksize));
+				WARN_ON(!IS_ALIGNED(end, fs_info->blocksize));
 				end--;
 				/* Take mmap lock to serialize with reflinks. */
 				if (!down_read_trylock(&inode->i_mmap_lock))
@@ -1361,7 +1361,7 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 				start = 0;
 			else {
 				start = min_key->offset;
-				WARN_ON(!IS_ALIGNED(start, fs_info->sectorsize));
+				WARN_ON(!IS_ALIGNED(start, fs_info->blocksize));
 			}
 		} else {
 			start = 0;
@@ -1376,7 +1376,7 @@ static int invalidate_extent_cache(struct btrfs_root *root,
 				if (max_key->offset == 0)
 					continue;
 				end = max_key->offset;
-				WARN_ON(!IS_ALIGNED(end, fs_info->sectorsize));
+				WARN_ON(!IS_ALIGNED(end, fs_info->blocksize));
 				end--;
 			}
 		} else {
@@ -2683,11 +2683,11 @@ static noinline_for_stack int prealloc_file_extent_cluster(struct reloc_control
 	if (!PAGE_ALIGNED(i_size)) {
 		struct address_space *mapping = inode->vfs_inode.i_mapping;
 		struct btrfs_fs_info *fs_info = inode->root->fs_info;
-		const u32 sectorsize = fs_info->sectorsize;
+		const u32 blocksize = fs_info->blocksize;
 		struct folio *folio;
 
-		ASSERT(sectorsize < PAGE_SIZE);
-		ASSERT(IS_ALIGNED(i_size, sectorsize));
+		ASSERT(blocksize < PAGE_SIZE);
+		ASSERT(IS_ALIGNED(i_size, blocksize));
 
 		/*
 		 * Subpage can't handle page with DIRTY but without UPTODATE
@@ -2936,7 +2936,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 			u64 boundary_start = cluster->boundary[*cluster_nr] -
 						offset;
 			u64 boundary_end = boundary_start +
-					   fs_info->sectorsize - 1;
+					   fs_info->blocksize - 1;
 
 			set_extent_bit(&BTRFS_I(inode)->io_tree,
 				       boundary_start, boundary_end,
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f437138fefbc..d3c83653f4d7 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1407,7 +1407,7 @@ static bool lookup_backref_cache(u64 leaf_bytenr, void *ctx,
 	struct backref_ctx *bctx = ctx;
 	struct send_ctx *sctx = bctx->sctx;
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
-	const u64 key = leaf_bytenr >> fs_info->sectorsize_bits;
+	const u64 key = leaf_bytenr >> fs_info->blocksize_bits;
 	struct btrfs_lru_cache_entry *raw_entry;
 	struct backref_cache_entry *entry;
 
@@ -1462,7 +1462,7 @@ static void store_backref_cache(u64 leaf_bytenr, const struct ulist *root_ids,
 	if (!new_entry)
 		return;
 
-	new_entry->entry.key = leaf_bytenr >> fs_info->sectorsize_bits;
+	new_entry->entry.key = leaf_bytenr >> fs_info->blocksize_bits;
 	new_entry->entry.gen = 0;
 	new_entry->num_roots = 0;
 	ULIST_ITER_INIT(&uiter);
@@ -5790,7 +5790,7 @@ static int send_extent_data(struct send_ctx *sctx, struct btrfs_path *path,
 		/*
 		 * Always operate only on ranges that are a multiple of the page
 		 * size. This is not only to prevent zeroing parts of a page in
-		 * the case of subpage sector size, but also to guarantee we evict
+		 * the case of subpage block size, but also to guarantee we evict
 		 * pages, as passing a range that is smaller than page size does
 		 * not evict the respective page (only zeroes part of its content).
 		 *
@@ -5888,11 +5888,11 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	u64 clone_src_i_size = 0;
 
 	/*
-	 * Prevent cloning from a zero offset with a length matching the sector
+	 * Prevent cloning from a zero offset with a length matching the block
 	 * size because in some scenarios this will make the receiver fail.
 	 *
 	 * For example, if in the source filesystem the extent at offset 0
-	 * has a length of sectorsize and it was written using direct IO, then
+	 * has a length of blocksize and it was written using direct IO, then
 	 * it can never be an inline extent (even if compression is enabled).
 	 * Then this extent can be cloned in the original filesystem to a non
 	 * zero file offset, but it may not be possible to clone in the
@@ -5903,7 +5903,7 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 	 * filesystem has.
 	 */
 	if (clone_root->offset == 0 &&
-	    len == sctx->send_root->fs_info->sectorsize)
+	    len == sctx->send_root->fs_info->blocksize)
 		return send_extent_data(sctx, dst_path, offset, len);
 
 	path = alloc_path_for_send();
@@ -6045,11 +6045,11 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 		if (btrfs_file_extent_disk_bytenr(leaf, ei) == disk_byte &&
 		    clone_data_offset == data_offset) {
 			const u64 src_end = clone_root->offset + clone_len;
-			const u64 sectorsize = SZ_64K;
+			const u64 blocksize = SZ_64K;
 
 			/*
 			 * We can't clone the last block, when its size is not
-			 * sector size aligned, into the middle of a file. If we
+			 * block size aligned, into the middle of a file. If we
 			 * do so, the receiver will get a failure (-EINVAL) when
 			 * trying to clone or will silently corrupt the data in
 			 * the destination file if it's on a kernel without the
@@ -6060,18 +6060,18 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 			 * So issue a clone of the aligned down range plus a
 			 * regular write for the eof block, if we hit that case.
 			 *
-			 * Also, we use the maximum possible sector size, 64K,
-			 * because we don't know what's the sector size of the
+			 * Also, we use the maximum possible block size, 64K,
+			 * because we don't know what's the block size of the
 			 * filesystem that receives the stream, so we have to
-			 * assume the largest possible sector size.
+			 * assume the largest possible block size.
 			 */
 			if (src_end == clone_src_i_size &&
-			    !IS_ALIGNED(src_end, sectorsize) &&
+			    !IS_ALIGNED(src_end, blocksize) &&
 			    offset + clone_len < sctx->cur_inode_size) {
 				u64 slen;
 
 				slen = ALIGN_DOWN(src_end - clone_root->offset,
-						  sectorsize);
+						  blocksize);
 				if (slen > 0) {
 					ret = send_clone(sctx, offset, slen,
 							 clone_root);
@@ -6096,8 +6096,8 @@ static int clone_range(struct send_ctx *sctx, struct btrfs_path *dst_path,
 			 * When using encoded writes (BTRFS_SEND_FLAG_COMPRESSED
 			 * was passed to the send ioctl), this helps avoid
 			 * sending an encoded write for an offset that is not
-			 * sector size aligned, in case the i_size of the source
-			 * inode is not sector size aligned. That will make the
+			 * block size aligned, in case the i_size of the source
+			 * inode is not block size aligned. That will make the
 			 * receiver fallback to decompression of the data and
 			 * writing it using regular buffered IO, therefore while
 			 * not incorrect, it's not optimal due decompression and
@@ -6154,7 +6154,7 @@ static int send_write_or_clone(struct send_ctx *sctx,
 	int ret = 0;
 	u64 offset = key->offset;
 	u64 end;
-	u64 bs = sctx->send_root->fs_info->sectorsize;
+	u64 bs = sctx->send_root->fs_info->blocksize;
 	struct btrfs_file_extent_item *ei;
 	u64 disk_byte;
 	u64 data_offset;
@@ -6195,7 +6195,7 @@ static int send_write_or_clone(struct send_ctx *sctx,
 		 * We do this truncate to the final i_size when we finish
 		 * processing the inode, but it's too late by then. And here we
 		 * truncate to the start offset of the range because it's always
-		 * sector size aligned while if it were the final i_size it
+		 * block size aligned while if it were the final i_size it
 		 * would result in dirtying part of a page, filling part of a
 		 * page with zeroes and then having the clone operation at the
 		 * receiver trigger IO and wait for it due to the dirty page.
@@ -6347,7 +6347,7 @@ static int is_extent_unchanged(struct send_ctx *sctx,
 		 * condition for inline extents too). This should normally not
 		 * happen but it's possible for example when we have an inline
 		 * compressed extent representing data with a size matching
-		 * the page size (currently the same as sector size).
+		 * the page size (currently the same as block size).
 		 */
 		if (right_type == BTRFS_FILE_EXTENT_INLINE) {
 			ret = 0;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index f6eaaf20229d..4a056d7ef1ca 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -718,12 +718,12 @@ bool btrfs_check_options(const struct btrfs_fs_info *info,
  */
 void btrfs_set_free_space_cache_settings(struct btrfs_fs_info *fs_info)
 {
-	if (fs_info->sectorsize < PAGE_SIZE) {
+	if (fs_info->blocksize < PAGE_SIZE) {
 		btrfs_clear_opt(fs_info->mount_opt, SPACE_CACHE);
 		if (!btrfs_test_opt(fs_info, FREE_SPACE_TREE)) {
 			btrfs_info(fs_info,
-				   "forcing free space tree for sector size %u with page size %lu",
-				   fs_info->sectorsize, PAGE_SIZE);
+				   "forcing free space tree for block size %u with page size %lu",
+				   fs_info->blocksize, PAGE_SIZE);
 			btrfs_set_opt(fs_info->mount_opt, FREE_SPACE_TREE);
 		}
 	}
@@ -1719,7 +1719,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	u64 total_used = 0;
 	u64 total_free_data = 0;
 	u64 total_free_meta = 0;
-	u32 bits = fs_info->sectorsize_bits;
+	u32 bits = fs_info->blocksize_bits;
 	__be32 *fsid = (__be32 *)fs_info->fs_devices->fsid;
 	unsigned factor = 1;
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
@@ -1803,7 +1803,7 @@ static int btrfs_statfs(struct dentry *dentry, struct kstatfs *buf)
 		buf->f_bavail = 0;
 
 	buf->f_type = BTRFS_SUPER_MAGIC;
-	buf->f_bsize = fs_info->sectorsize;
+	buf->f_bsize = fs_info->blocksize;
 	buf->f_namelen = BTRFS_NAME_LEN;
 
 	/* We treat it as constant endianness (it doesn't matter _which_)
diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 7f09b6c9cc2d..23696a842ff9 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1128,7 +1128,7 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->blocksize);
 }
 
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
@@ -1180,7 +1180,7 @@ static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return sysfs_emit(buf, "%u\n", fs_info->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->blocksize);
 }
 
 BTRFS_ATTR(, clone_alignment, btrfs_clone_alignment_show);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c8d6587688b3..995aec0e8ce3 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -672,7 +672,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
 		size = btrfs_file_extent_ram_bytes(eb, item);
 		nbytes = btrfs_file_extent_ram_bytes(eb, item);
 		extent_end = ALIGN(start + size,
-				   fs_info->sectorsize);
+				   fs_info->blocksize);
 	} else {
 		ret = 0;
 		goto out;
@@ -2489,7 +2489,7 @@ static int replay_one_buffer(struct btrfs_root *log, struct extent_buffer *eb,
 					break;
 				}
 				from = ALIGN(i_size_read(inode),
-					     root->fs_info->sectorsize);
+					     root->fs_info->blocksize);
 				drop_args.start = from;
 				drop_args.end = (u64)-1;
 				drop_args.drop_cache = true;
@@ -5232,7 +5232,7 @@ static int btrfs_log_holes(struct btrfs_trans_handle *trans,
 		u64 hole_len;
 
 		btrfs_release_path(path);
-		hole_len = ALIGN(i_size - prev_extent_end, fs_info->sectorsize);
+		hole_len = ALIGN(i_size - prev_extent_end, fs_info->blocksize);
 		ret = btrfs_insert_hole_extent(trans, root->log_root, ino,
 					       prev_extent_end, hole_len);
 		if (ret < 0)
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d32913c51d69..7e472382d44e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2830,11 +2830,11 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 
 	set_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 	device->generation = trans->transid;
-	device->io_width = fs_info->sectorsize;
-	device->io_align = fs_info->sectorsize;
-	device->sector_size = fs_info->sectorsize;
+	device->io_width = fs_info->blocksize;
+	device->io_align = fs_info->blocksize;
+	device->sector_size = fs_info->blocksize;
 	device->total_bytes =
-		round_down(bdev_nr_bytes(device->bdev), fs_info->sectorsize);
+		round_down(bdev_nr_bytes(device->bdev), fs_info->blocksize);
 	device->disk_total_bytes = device->total_bytes;
 	device->commit_total_bytes = device->total_bytes;
 	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
@@ -2878,7 +2878,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	orig_super_total_bytes = btrfs_super_total_bytes(fs_info->super_copy);
 	btrfs_set_super_total_bytes(fs_info->super_copy,
 		round_down(orig_super_total_bytes + device->total_bytes,
-			   fs_info->sectorsize));
+			   fs_info->blocksize));
 
 	orig_super_num_devices = btrfs_super_num_devices(fs_info->super_copy);
 	btrfs_set_super_num_devices(fs_info->super_copy,
@@ -3058,11 +3058,11 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state))
 		return -EACCES;
 
-	new_size = round_down(new_size, fs_info->sectorsize);
+	new_size = round_down(new_size, fs_info->blocksize);
 
 	mutex_lock(&fs_info->chunk_mutex);
 	old_total = btrfs_super_total_bytes(super_copy);
-	diff = round_down(new_size - device->total_bytes, fs_info->sectorsize);
+	diff = round_down(new_size - device->total_bytes, fs_info->blocksize);
 
 	if (new_size <= device->total_bytes ||
 	    test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
@@ -3071,7 +3071,7 @@ int btrfs_grow_device(struct btrfs_trans_handle *trans,
 	}
 
 	btrfs_set_super_total_bytes(super_copy,
-			round_down(old_total + diff, fs_info->sectorsize));
+			round_down(old_total + diff, fs_info->blocksize));
 	device->fs_devices->total_rw_bytes += diff;
 	atomic64_add(diff, &fs_info->free_chunk_space);
 
@@ -4932,9 +4932,9 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 	u64 start;
 	u64 free_diff = 0;
 
-	new_size = round_down(new_size, fs_info->sectorsize);
+	new_size = round_down(new_size, fs_info->blocksize);
 	start = new_size;
-	diff = round_down(old_size - new_size, fs_info->sectorsize);
+	diff = round_down(old_size - new_size, fs_info->blocksize);
 
 	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state))
 		return -EINVAL;
@@ -5085,7 +5085,7 @@ int btrfs_shrink_device(struct btrfs_device *device, u64 new_size)
 
 	WARN_ON(diff > old_total);
 	btrfs_set_super_total_bytes(super_copy,
-			round_down(old_total - diff, fs_info->sectorsize));
+			round_down(old_total - diff, fs_info->blocksize));
 	mutex_unlock(&fs_info->chunk_mutex);
 
 	btrfs_reserve_chunk_metadata(trans, false);
@@ -5773,7 +5773,7 @@ int btrfs_chunk_alloc_add_chunk_item(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_chunk_num_stripes(chunk, map->num_stripes);
 	btrfs_set_stack_chunk_io_align(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_io_width(chunk, BTRFS_STRIPE_LEN);
-	btrfs_set_stack_chunk_sector_size(chunk, fs_info->sectorsize);
+	btrfs_set_stack_chunk_sector_size(chunk, fs_info->blocksize);
 	btrfs_set_stack_chunk_sub_stripes(chunk, map->sub_stripes);
 
 	key.objectid = BTRFS_FIRST_CHUNK_TREE_OBJECTID;
@@ -5945,7 +5945,7 @@ unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
 				    u64 logical)
 {
 	struct btrfs_chunk_map *map;
-	unsigned long len = fs_info->sectorsize;
+	unsigned long len = fs_info->blocksize;
 
 	if (!btrfs_fs_incompat(fs_info, RAID56))
 		return len;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index abea8f2f497e..1cfde2bb7b74 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -746,7 +746,7 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
 		min3((u64)lim->max_zone_append_sectors << SECTOR_SHIFT,
 		     (u64)lim->max_sectors << SECTOR_SHIFT,
 		     (u64)lim->max_segments << PAGE_SHIFT),
-		fs_info->sectorsize);
+		fs_info->blocksize);
 	fs_info->fs_devices->chunk_alloc_policy = BTRFS_CHUNK_ALLOC_ZONED;
 	if (fs_info->max_zone_append_size < fs_info->max_extent_size)
 		fs_info->max_extent_size = fs_info->max_zone_append_size;
@@ -2160,7 +2160,7 @@ static void wait_eb_writebacks(struct btrfs_block_group *block_group)
 
 	rcu_read_lock();
 	radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
-				 block_group->start >> fs_info->sectorsize_bits) {
+				 block_group->start >> fs_info->blocksize_bits) {
 		eb = radix_tree_deref_slot(slot);
 		if (!eb)
 			continue;
@@ -2375,7 +2375,7 @@ void btrfs_zone_finish_endio(struct btrfs_fs_info *fs_info, u64 logical, u64 len
 
 	/* No MIXED_BG on zoned btrfs. */
 	if (block_group->flags & BTRFS_BLOCK_GROUP_DATA)
-		min_alloc_bytes = fs_info->sectorsize;
+		min_alloc_bytes = fs_info->blocksize;
 	else
 		min_alloc_bytes = fs_info->nodesize;
 
-- 
2.47.1


