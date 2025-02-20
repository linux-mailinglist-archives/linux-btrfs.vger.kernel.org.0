Return-Path: <linux-btrfs+bounces-11613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D007AA3D5C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 11:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA09175CD2
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B4C1F1536;
	Thu, 20 Feb 2025 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D4DFTQ5e";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="D4DFTQ5e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FB51F1525
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045649; cv=none; b=GCXqlnu6uYoFw/J5H6qDkE5dkyDUUq/9zfBtq8X9BAw+PXbYVlFtV2OYAb7T7QMrUaFiC9S+xxXiraF4PhSHM9bsmGm6ZNXUR23oBe74W02AJriEd3TPKwbpvjma8qmg+dNShjLoZbjKHKZBziL34b94tGCeQ0hZZlNvUjAs8mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045649; c=relaxed/simple;
	bh=Sr3OBOOGvMCOVSsrxl+OgvJhgRLucDeJF88Wrc6Jah0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bWRD0X5+TeIUS/qjElycMI4G6SnToeP9b+KkpjE4NgP00LjlqGRajS1Eth3D2fCeKyW5UDF6zZ179RBtjOcVeWON1oPvFGDcxeE75WImhewqpUhSSOf51Shqd0prBFcqB2FXz+oBVZSGOBZ4bdk/T7q9BVXNVhbsbchWQoFHNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D4DFTQ5e; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=D4DFTQ5e; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D1981F38A;
	Thu, 20 Feb 2025 10:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Jx0qfxBFh2H7XEWyByEGrTm1ixpWRs2CDkRa7azbyg=;
	b=D4DFTQ5eJo15eY2kB/9VhS+Ot8MDcLytWLjlLmH8mSGe3BQt6pvD1w9tICEQXrlzJs9vvL
	BLIyDaP67KXs1Z+r/JFTsROVN07XcOh67MW6/tdkC+XK7cgFlRmoLkukK1s/yr+QepWDij
	yXcvvY7Huw0iEk7UTbClLXc9v5YAuDw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=D4DFTQ5e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740045638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Jx0qfxBFh2H7XEWyByEGrTm1ixpWRs2CDkRa7azbyg=;
	b=D4DFTQ5eJo15eY2kB/9VhS+Ot8MDcLytWLjlLmH8mSGe3BQt6pvD1w9tICEQXrlzJs9vvL
	BLIyDaP67KXs1Z+r/JFTsROVN07XcOh67MW6/tdkC+XK7cgFlRmoLkukK1s/yr+QepWDij
	yXcvvY7Huw0iEk7UTbClLXc9v5YAuDw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81A9B13301;
	Thu, 20 Feb 2025 10:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HB2mH0b9tmc7fwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Thu, 20 Feb 2025 10:00:38 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 01/22] btrfs: pass struct btrfs_inode to can_nocow_extent()
Date: Thu, 20 Feb 2025 11:00:38 +0100
Message-ID: <7e9309e1beca9e05b8dcf55b750c0c64efe35db7.1740045551.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740045551.git.dsterba@suse.com>
References: <cover.1740045551.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8D1981F38A
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Pass a struct btrfs_inode to can_nocow_extent() as it's an internal
interface, allowing to remove some use of BTRFS_I.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h |  2 +-
 fs/btrfs/direct-io.c   |  3 ++-
 fs/btrfs/file.c        |  3 +--
 fs/btrfs/inode.c       | 18 +++++++++---------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 029fba82b81d..ca1cd600f5d2 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -532,7 +532,7 @@ int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page *page,
 			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
 bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *dev,
 			u32 bio_offset, struct bio_vec *bv);
-noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
+noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
 			      bool nowait);
 
diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
index c98db5058967..fb6df17fb55c 100644
--- a/fs/btrfs/direct-io.c
+++ b/fs/btrfs/direct-io.c
@@ -248,7 +248,8 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		len = min(len, em->len - (start - em->start));
 		block_start = extent_map_block_start(em) + (start - em->start);
 
-		if (can_nocow_extent(inode, start, &len, &file_extent, false) == 1) {
+		if (can_nocow_extent(BTRFS_I(inode), start, &len, &file_extent,
+				     false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
 			if (bg)
 				can_nocow = true;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 3603d9bbc17a..dd4b6c0c4542 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1013,8 +1013,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 		btrfs_lock_and_flush_ordered_range(inode, lockstart, lockend,
 						   &cached_state);
 	}
-	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
-			       NULL, nowait);
+	ret = can_nocow_extent(inode, lockstart, &num_bytes, NULL, nowait);
 	if (ret <= 0)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 	else
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index fdc03e84fa46..4f53f50a324b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7068,17 +7068,17 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  * NOTE: This only checks the file extents, caller is responsible to wait for
  *	 any ordered extents.
  */
-noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
+noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u64 *len,
 			      struct btrfs_file_extent *file_extent,
 			      bool nowait)
 {
-	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
+	struct btrfs_root *root = inode->root;
+	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct can_nocow_file_extent_args nocow_args = { 0 };
 	struct btrfs_path *path;
 	int ret;
 	struct extent_buffer *leaf;
-	struct btrfs_root *root = BTRFS_I(inode)->root;
-	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
+	struct extent_io_tree *io_tree = &inode->io_tree;
 	struct btrfs_file_extent_item *fi;
 	struct btrfs_key key;
 	int found_type;
@@ -7088,8 +7088,8 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		return -ENOMEM;
 	path->nowait = nowait;
 
-	ret = btrfs_lookup_file_extent(NULL, root, path,
-			btrfs_ino(BTRFS_I(inode)), offset, 0);
+	ret = btrfs_lookup_file_extent(NULL, root, path, btrfs_ino(inode),
+				       offset, 0);
 	if (ret < 0)
 		goto out;
 
@@ -7104,7 +7104,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	ret = 0;
 	leaf = path->nodes[0];
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
-	if (key.objectid != btrfs_ino(BTRFS_I(inode)) ||
+	if (key.objectid != btrfs_ino(inode) ||
 	    key.type != BTRFS_EXTENT_DATA_KEY) {
 		/* not our file or wrong item type, must cow */
 		goto out;
@@ -7125,7 +7125,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	nocow_args.end = offset + *len - 1;
 	nocow_args.free_path = true;
 
-	ret = can_nocow_file_extent(path, &key, BTRFS_I(inode), &nocow_args);
+	ret = can_nocow_file_extent(path, &key, inode, &nocow_args);
 	/* can_nocow_file_extent() has freed the path. */
 	path = NULL;
 
@@ -7141,7 +7141,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 				  nocow_args.file_extent.offset))
 		goto out;
 
-	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
+	if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
 	    found_type == BTRFS_FILE_EXTENT_PREALLOC) {
 		u64 range_end;
 
-- 
2.47.1


