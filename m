Return-Path: <linux-btrfs+bounces-15532-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A75D1B07F64
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 23:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14865834FC
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jul 2025 21:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDAA1FECCD;
	Wed, 16 Jul 2025 21:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FDZ7NDuy";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="FDZ7NDuy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C1719CCF5
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752700538; cv=none; b=jaaBDUnpUTRB7IqtgzfK9ICU93l4b71P2qmY/Uo3HpXikY7j0GKJoQmw2/BGWj1ET1C3JfXJMMIC2p4tmHBtZxdR53pblEyKlLA5s91FlUzAE0kI+MlOVRqmc5FQImrz8/HFruNjw71zPRdCLDUxSCXkhZO5wxlbyZ0r7Ud1L/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752700538; c=relaxed/simple;
	bh=vgElViBMRI+IM//6tLQOOh9X4QyiZ+cyIouRXPV3Nqg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yk/u57SyqpF/Pxfr+jJAQzTzB7Z8oEceJndzQYjmxAdDeiUevZrwvPf4ANnixNac5z/H76Q+YbK1+TW6gzhSCV4jTzTABZsEE5YKcipZaeK4WnY4dOuCV12pSr3PRCEbAflReRwxUIe/xIyYJLL+0TyoiB3YfdEchuT+YsXY9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FDZ7NDuy; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=FDZ7NDuy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B45C21224
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752700523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zY8zWREecgo11hFxJJ9cyHGoDBId1jbpKu2tw9Hv88I=;
	b=FDZ7NDuyD5PHsbBzWGjMMnVsLkvzDKypaaA8ovyEQeskVpCu/JaN8sPHUgY7MKHdWvfo8O
	r14TBlctcgZBrarwgxCQ5ytunemEyVmTg7RV/wGKP4gQKGjCXczmEBBU+p/uzodDgk1wPt
	JbxFI+RwLBh04trPSKwggh0JGsRLqJc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=FDZ7NDuy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1752700523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zY8zWREecgo11hFxJJ9cyHGoDBId1jbpKu2tw9Hv88I=;
	b=FDZ7NDuyD5PHsbBzWGjMMnVsLkvzDKypaaA8ovyEQeskVpCu/JaN8sPHUgY7MKHdWvfo8O
	r14TBlctcgZBrarwgxCQ5ytunemEyVmTg7RV/wGKP4gQKGjCXczmEBBU+p/uzodDgk1wPt
	JbxFI+RwLBh04trPSKwggh0JGsRLqJc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58CF013306
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gKluA2oWeGipBwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Jul 2025 21:15:22 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: enable large data folios for data reloc inode
Date: Thu, 17 Jul 2025 06:44:59 +0930
Message-ID: <8b206cfb9e52e56f509237919271403b437c5342.1752700452.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752700452.git.wqu@suse.com>
References: <cover.1752700452.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 4B45C21224
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

For data reloc inodes, they are a special type of inodes that is not
exposed to user space, and are only utilized during data block groups
relocation.

They do not go under regular read-write operations, but have its file
extents manually created to have the same layout of a block group, then
its content is read from the original block group, and written back to
the new location which is in a new block group.

Previously all those handling are done in page unit, and commit
c2832898126f ("btrfs: make relocate_one_page() handle subpage case")
makes the handling to handle subpage blocks.

On the other hand, data reloc inodes are a perfect match for large data
folios, as each relocation cluster represents one or more data extents
that are contiguous in their logical addresses.

This patch enables large folios for data reloc inodes by:

- Remove the special handling of data reloc inodes when setting folio
  order

- Change relocate_one_folio() to return the file offset of the next
  folio
  Originally it's designed to handle fixed page sized blocks, but with
  large folios, we can handle a large folio, thus we have to return the
  end of the current folio.

- Remove the warning on folio_order()

- Use folio_size() to replace fixed PAGE_SIZE usage

- Use file_offset as iterator inside relocate_file_extent_cluster

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h |  4 ----
 fs/btrfs/relocation.c  | 24 +++++++++++++-----------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index c9f73fc3e3c8..024c7bc7cf63 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -530,10 +530,6 @@ static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
 	/* Metadata inode should not reach here. */
 	ASSERT(is_data_inode(inode));
 
-	/* For data reloc inode, it still requires page sized folio. */
-	if (unlikely(btrfs_is_data_reloc_root(inode->root)))
-		return;
-
 	/* We only allows BITS_PER_LONGS blocks for each bitmap. */
 #ifdef CONFIG_BTRFS_EXPERIMENTAL
 	mapping_set_folio_order_range(inode->vfs_inode.i_mapping, 0,
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index fa93ba40278d..60dd3971c3ae 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2772,13 +2772,15 @@ static u64 get_cluster_boundary_end(const struct file_extent_cluster *cluster,
 
 static int relocate_one_folio(struct reloc_control *rc,
 			      struct file_ra_state *ra,
-			      int *cluster_nr, pgoff_t index)
+			      int *cluster_nr, u64 *file_offset_ret)
 {
 	const struct file_extent_cluster *cluster = &rc->cluster;
 	struct inode *inode = rc->data_inode;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	const u64 orig_file_offset = *file_offset_ret;
 	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
 	const pgoff_t last_index = (cluster->end - offset) >> PAGE_SHIFT;
+	const pgoff_t index = orig_file_offset >> PAGE_SHIFT;
 	gfp_t mask = btrfs_alloc_write_mask(inode->i_mapping);
 	struct folio *folio;
 	u64 folio_start;
@@ -2811,8 +2813,6 @@ static int relocate_one_folio(struct reloc_control *rc,
 			return PTR_ERR(folio);
 	}
 
-	WARN_ON(folio_order(folio));
-
 	if (folio_test_readahead(folio) && !use_rst)
 		page_cache_async_readahead(inode->i_mapping, ra, NULL,
 					   folio, last_index + 1 - index);
@@ -2841,7 +2841,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 		goto release_folio;
 
 	folio_start = folio_pos(folio);
-	folio_end = folio_start + PAGE_SIZE - 1;
+	folio_end = folio_start + folio_size(folio) - 1;
 
 	/*
 	 * Start from the cluster, as for subpage case, the cluster can start
@@ -2889,7 +2889,8 @@ static int relocate_one_folio(struct reloc_control *rc,
 		 * EXTENT_BOUNDARY bit prevents current extent from being merged
 		 * with previous extent.
 		 */
-		if (in_range(cluster->boundary[*cluster_nr] - offset, folio_start, PAGE_SIZE)) {
+		if (in_range(cluster->boundary[*cluster_nr] - offset,
+			     folio_start, folio_size(folio))) {
 			u64 boundary_start = cluster->boundary[*cluster_nr] -
 						offset;
 			u64 boundary_end = boundary_start +
@@ -2919,6 +2920,7 @@ static int relocate_one_folio(struct reloc_control *rc,
 	btrfs_throttle(fs_info);
 	if (btrfs_should_cancel_balance(fs_info))
 		ret = -ECANCELED;
+	*file_offset_ret = folio_end + 1;
 	return ret;
 
 release_folio:
@@ -2932,8 +2934,7 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 	struct inode *inode = rc->data_inode;
 	const struct file_extent_cluster *cluster = &rc->cluster;
 	u64 offset = BTRFS_I(inode)->reloc_block_group_start;
-	pgoff_t index;
-	pgoff_t last_index;
+	u64 cur_file_offset = cluster->start - offset;
 	struct file_ra_state *ra;
 	int cluster_nr = 0;
 	int ret = 0;
@@ -2955,10 +2956,11 @@ static int relocate_file_extent_cluster(struct reloc_control *rc)
 	if (ret)
 		goto out;
 
-	last_index = (cluster->end - offset) >> PAGE_SHIFT;
-	for (index = (cluster->start - offset) >> PAGE_SHIFT;
-	     index <= last_index && !ret; index++)
-		ret = relocate_one_folio(rc, ra, &cluster_nr, index);
+	while (cur_file_offset < cluster->end - offset) {
+		ret = relocate_one_folio(rc, ra, &cluster_nr, &cur_file_offset);
+		if (ret)
+			break;
+	}
 	if (ret == 0)
 		WARN_ON(cluster_nr != cluster->nr);
 out:
-- 
2.50.0


