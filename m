Return-Path: <linux-btrfs+bounces-5231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 330808CCB96
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E43F8283330
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6CF13B580;
	Thu, 23 May 2024 05:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QyUnq6Ye";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r1MoORlf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9106A2F875
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440643; cv=none; b=SYVftyNbNpv2Sfeu0daZACGp1zfu1NYKlFeDIqLTpAilCzGCzwkARuBxXQbh15gvS5iN9YI/LdbkC1drKGQRKpp/x+mp6ad3rRt1v3B+j6xKO+HZ/pH4IPD/VGWIyHGtlItkvGkq/cecUnNGGWS4dIKdSvnZKAwxlPpIvZvXnFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440643; c=relaxed/simple;
	bh=MuGfHSqh/XeclYWNBS61LX0uXs+i46Bu3od9oAp1AmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPWzl+ao0w+gPfxOVF1ESaR47jkuvxr0U1OmyLpVeOyBTgDLNnTAyGnRdiSg/WuapAIwQaxHw/Grt8Ks232Di8NpXA+6n4fR6NvrcKBkylTXq8HveLcYn0x9L0uh/npUIB8JipVO0Tmt53NXhdZ+lVWFyrFIZ+jl6tuH422qbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QyUnq6Ye; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r1MoORlf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8C97220E3;
	Thu, 23 May 2024 05:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXJKNZUUx7A4Uv09Vy1IrfBg+c5q3WZllW1CYcqwExw=;
	b=QyUnq6YetrOvpiX03wbfH1WZuvUnBt5w0mrEEV03nGqOkrw1k4+mHKm3eV10FvPQSsC1mT
	HE8CKI9+rXBZwMHu7YKTjXVtkoM9AHNLGgLG2hrWfnMJVwyV7pBrAh4QLVnkRwQoXWJldA
	0iym/U2dVin7xXOn/ON1+KBIN7m4zas=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=r1MoORlf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UXJKNZUUx7A4Uv09Vy1IrfBg+c5q3WZllW1CYcqwExw=;
	b=r1MoORlfTfe7kc2mXZ67Zg1l7+yUU3DsehHHM2gSVyJU3G7UQeNCAiZsGTlRorJJWF4Flv
	AfDrA4Qmdp5MRVaYDai/ErJSLFyC0l+n8stBcLf/C980eKsXWA4Wi3bdewHDzVXuFoUov0
	8sXy0IIOWC55ymMIgxzMG2hUeoTNBAM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAC0713A6B;
	Thu, 23 May 2024 05:03:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SDK5Fz3OTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 May 2024 05:03:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v3 05/11] btrfs: remove extent_map::orig_start member
Date: Thu, 23 May 2024 14:33:24 +0930
Message-ID: <e80fde3354431b77ca18c320fa9f54147ddc0aff.1716440169.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E8C97220E3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

Since we have extent_map::offset, the old extent_map::orig_start is just
extent_map::start - extent_map::offset for non-hole/inline extents.

And since the new extent_map::offset is already verified by
validate_extent_map() meanwhile the old orig_start is not, let's
just remove the old member from all call sites.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/btrfs_inode.h            |  2 +-
 fs/btrfs/compression.c            |  2 +-
 fs/btrfs/defrag.c                 |  1 -
 fs/btrfs/extent_map.c             | 21 +-------
 fs/btrfs/extent_map.h             |  9 ----
 fs/btrfs/file-item.c              |  5 +-
 fs/btrfs/file.c                   |  3 +-
 fs/btrfs/inode.c                  | 37 +++++---------
 fs/btrfs/relocation.c             |  1 -
 fs/btrfs/tests/extent-map-tests.c |  9 ----
 fs/btrfs/tests/inode-tests.c      | 84 +++++++++++++------------------
 fs/btrfs/tree-log.c               |  2 +-
 include/trace/events/btrfs.h      |  6 +--
 13 files changed, 56 insertions(+), 126 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 9ada4185ff93..269ee9ac859e 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -529,7 +529,7 @@ struct btrfs_file_extent {
 };
 
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_start, u64 *orig_block_len,
+			      u64 *orig_block_len,
 			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
 			      bool nowait, bool strict);
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 7b4843df0752..4f6d748aa99e 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -590,7 +590,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
 				  end_bbio_compressed_read);
 
-	cb->start = em->orig_start;
+	cb->start = em->start - em->offset;
 	em_len = em->len;
 	em_start = em->start;
 
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 242c5469f4ba..025e7f853a68 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -707,7 +707,6 @@ static struct extent_map *defrag_get_extent(struct btrfs_inode *inode,
 		 */
 		if (key.offset > start) {
 			em->start = start;
-			em->orig_start = start;
 			em->block_start = EXTENT_MAP_HOLE;
 			em->disk_bytenr = EXTENT_MAP_HOLE;
 			em->disk_num_bytes = 0;
diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index b157f30ac241..91be54f79d21 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -288,9 +288,9 @@ static void dump_extent_map(struct btrfs_fs_info *fs_info,
 {
 	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
 		return;
-	btrfs_crit(fs_info, "%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu orig_start=%llu block_start=%llu block_len=%llu flags=0x%x\n",
+	btrfs_crit(fs_info, "%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu block_start=%llu block_len=%llu flags=0x%x\n",
 		prefix, em->start, em->len, em->disk_bytenr, em->disk_num_bytes,
-		em->ram_bytes, em->offset, em->orig_start, em->block_start,
+		em->ram_bytes, em->offset, em->block_start,
 		em->block_len, em->flags);
 	ASSERT(0);
 }
@@ -317,15 +317,6 @@ static void validate_extent_map(struct btrfs_fs_info *fs_info,
 			if (em->disk_num_bytes != em->block_len)
 				dump_extent_map(fs_info,
 				"mismatch disk_num_bytes/block_len", em);
-			/*
-			 * Here we only check the start/orig_start/offset for
-			 * compressed extents as that's the only case where
-			 * orig_start is utilized.
-			 */
-			if (em->orig_start != em->start - em->offset)
-				dump_extent_map(fs_info,
-				"mismatch orig_start/offset/start", em);
-
 		} else if (em->block_start != em->disk_bytenr + em->offset) {
 			dump_extent_map(fs_info,
 				"mismatch block_start/disk_bytenr/offset", em);
@@ -363,7 +354,6 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			merge = rb_entry(rb, struct extent_map, rb_node);
 		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
 			em->start = merge->start;
-			em->orig_start = merge->orig_start;
 			em->len += merge->len;
 			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
@@ -898,7 +888,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->len = start - em->start;
 
 			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-				split->orig_start = em->orig_start;
 				split->block_start = em->block_start;
 
 				if (compressed)
@@ -911,7 +900,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->offset = em->offset;
 				split->ram_bytes = em->ram_bytes;
 			} else {
-				split->orig_start = split->start;
 				split->block_len = 0;
 				split->block_start = em->block_start;
 				split->disk_bytenr = em->disk_bytenr;
@@ -948,19 +936,16 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->ram_bytes = em->ram_bytes;
 				if (compressed) {
 					split->block_len = em->block_len;
-					split->orig_start = em->orig_start;
 				} else {
 					const u64 diff = end - em->start;
 
 					split->block_len = split->len;
 					split->block_start += diff;
-					split->orig_start = em->orig_start;
 				}
 			} else {
 				split->disk_num_bytes = 0;
 				split->offset = 0;
 				split->ram_bytes = split->len;
-				split->orig_start = split->start;
 				split->block_len = 0;
 			}
 
@@ -1118,7 +1103,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->disk_bytenr = new_logical;
 	split_pre->disk_num_bytes = split_pre->len;
 	split_pre->offset = 0;
-	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = new_logical;
 	split_pre->block_len = split_pre->len;
 	split_pre->ram_bytes = split_pre->len;
@@ -1138,7 +1122,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->disk_bytenr = em->block_start + pre;
 	split_mid->disk_num_bytes = split_mid->len;
 	split_mid->offset = 0;
-	split_mid->orig_start = split_mid->start;
 	split_mid->block_start = em->block_start + pre;
 	split_mid->block_len = split_mid->len;
 	split_mid->ram_bytes = split_mid->len;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 0b1a8e409377..5ae3d56b4351 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -61,15 +61,6 @@ struct extent_map {
 	 */
 	u64 len;
 
-	/*
-	 * The file offset of the original file extent before splitting.
-	 *
-	 * This is an in-memory only member, matching
-	 * extent_map::start - btrfs_file_extent_item::offset for
-	 * regular/preallocated extents. EXTENT_MAP_HOLE otherwise.
-	 */
-	u64 orig_start;
-
 	/*
 	 * The bytenr of the full on-disk extent.
 	 *
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 1298afea9503..06d23951901c 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1293,8 +1293,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	    type == BTRFS_FILE_EXTENT_PREALLOC) {
 		em->start = extent_start;
 		em->len = btrfs_file_extent_end(path) - extent_start;
-		em->orig_start = extent_start -
-			btrfs_file_extent_offset(leaf, fi);
 		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 		if (bytenr == 0) {
 			em->block_start = EXTENT_MAP_HOLE;
@@ -1327,10 +1325,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->len = fs_info->sectorsize;
 		em->offset = 0;
 		/*
-		 * Initialize orig_start and block_len with the same values
+		 * Initialize block_len with the same values
 		 * as in inode.c:btrfs_get_extent().
 		 */
-		em->orig_start = EXTENT_MAP_HOLE;
 		em->block_len = (u64)-1;
 		extent_map_set_compression(em, compress_type);
 	} else {
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 5133c6705d74..707012fc2d43 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1104,7 +1104,7 @@ int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
 						   &cached_state);
 	}
 	ret = can_nocow_extent(&inode->vfs_inode, lockstart, &num_bytes,
-			NULL, NULL, NULL, NULL, nowait, false);
+			NULL, NULL, NULL, nowait, false);
 	if (ret <= 0)
 		btrfs_drew_write_unlock(&root->snapshot_lock);
 	else
@@ -2347,7 +2347,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->start = offset;
 		hole_em->len = end - offset;
 		hole_em->ram_bytes = hole_em->len;
-		hole_em->orig_start = offset;
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->disk_bytenr = EXTENT_MAP_HOLE;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7afcdea27782..066f14c78bc9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -138,7 +138,7 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     u64 end, struct writeback_control *wbc,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len, u64 orig_start, u64 block_start,
+				       u64 len, u64 block_start,
 				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
@@ -1209,7 +1209,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 
 	em = create_io_em(inode, start,
 			  async_extent->ram_size,	/* len */
-			  start,			/* orig_start */
 			  ins.objectid,			/* block_start */
 			  ins.offset,			/* block_len */
 			  ins.offset,			/* orig_block_len */
@@ -1453,7 +1452,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 			    &cached);
 
 		em = create_io_em(inode, start, ins.offset, /* len */
-				  start, /* orig_start */
 				  ins.objectid, /* block_start */
 				  ins.offset, /* block_len */
 				  ins.offset, /* orig_block_len */
@@ -2189,11 +2187,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
 		if (is_prealloc) {
-			u64 orig_start = found_key.offset - nocow_args.extent_offset;
 			struct extent_map *em;
 
 			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
-					  orig_start,
 					  nocow_args.disk_bytenr, /* block_start */
 					  nocow_args.num_bytes, /* block_len */
 					  nocow_args.disk_num_bytes, /* orig_block_len */
@@ -5028,7 +5024,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			}
 			hole_em->start = cur_offset;
 			hole_em->len = hole_size;
-			hole_em->orig_start = cur_offset;
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
 			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
@@ -6899,7 +6894,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto out;
 	}
 	em->start = EXTENT_MAP_HOLE;
-	em->orig_start = EXTENT_MAP_HOLE;
 	em->disk_bytenr = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
 	em->block_len = (u64)-1;
@@ -6992,7 +6986,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 		/* New extent overlaps with existing one */
 		em->start = start;
-		em->orig_start = start;
 		em->len = found_key.offset - start;
 		em->block_start = EXTENT_MAP_HOLE;
 		goto insert;
@@ -7028,7 +7021,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 not_found:
 	em->start = start;
-	em->orig_start = start;
 	em->len = len;
 	em->block_start = EXTENT_MAP_HOLE;
 insert:
@@ -7061,7 +7053,6 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
 						  const u64 len,
-						  const u64 orig_start,
 						  const u64 block_start,
 						  const u64 block_len,
 						  const u64 orig_block_len,
@@ -7073,7 +7064,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, start, len, orig_start, block_start,
+		em = create_io_em(inode, start, len, block_start,
 				  block_len, orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  file_extent, type);
@@ -7132,7 +7123,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	file_extent.ram_bytes = ins.offset;
 	file_extent.offset = 0;
 	file_extent.compression = BTRFS_COMPRESS_NONE;
-	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset, start,
+	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
 				     ins.objectid, ins.offset, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR,
 				     &file_extent);
@@ -7178,7 +7169,7 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  *	 any ordered extents.
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_start, u64 *orig_block_len,
+			      u64 *orig_block_len,
 			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
 			      bool nowait, bool strict)
 {
@@ -7265,8 +7256,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		}
 	}
 
-	if (orig_start)
-		*orig_start = key.offset - nocow_args.extent_offset;
 	if (orig_block_len)
 		*orig_block_len = nocow_args.disk_num_bytes;
 	if (file_extent)
@@ -7375,7 +7364,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len, u64 orig_start, u64 block_start,
+				       u64 len, u64 block_start,
 				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
@@ -7413,7 +7402,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		ASSERT(ram_bytes == len);
 
 		/* Since it's a new extent, we should not have any offset. */
-		ASSERT(orig_start == start);
+		ASSERT(file_extent->offset == 0);
 		break;
 	case BTRFS_ORDERED_COMPRESSED:
 		/* Must be compressed. */
@@ -7432,7 +7421,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		return ERR_PTR(-ENOMEM);
 
 	em->start = start;
-	em->orig_start = orig_start;
 	em->len = len;
 	em->block_len = block_len;
 	em->block_start = block_start;
@@ -7467,7 +7455,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	struct btrfs_file_extent file_extent;
 	struct extent_map *em = *map;
 	int type;
-	u64 block_start, orig_start, orig_block_len, ram_bytes;
+	u64 block_start, orig_block_len, ram_bytes;
 	struct btrfs_block_group *bg;
 	bool can_nocow = false;
 	bool space_reserved = false;
@@ -7494,7 +7482,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		len = min(len, em->len - (start - em->start));
 		block_start = em->block_start + (start - em->start);
 
-		if (can_nocow_extent(inode, start, &len, &orig_start,
+		if (can_nocow_extent(inode, start, &len,
 				     &orig_block_len, &ram_bytes,
 				     &file_extent, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
@@ -7522,7 +7510,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		space_reserved = true;
 
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      orig_start, block_start,
+					      block_start,
 					      len, orig_block_len,
 					      ram_bytes, type,
 					      &file_extent);
@@ -9662,7 +9650,6 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		}
 
 		em->start = cur_offset;
-		em->orig_start = cur_offset;
 		em->len = ins.offset;
 		em->block_start = ins.objectid;
 		em->disk_bytenr = ins.objectid;
@@ -10171,7 +10158,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		disk_io_size = em->block_len;
 		count = em->block_len;
 		encoded->unencoded_len = em->ram_bytes;
-		encoded->unencoded_offset = iocb->ki_pos - em->orig_start;
+		encoded->unencoded_offset = iocb->ki_pos - (em->start - em->offset);
 		ret = btrfs_encoded_io_compression_from_extent(fs_info,
 							       extent_map_compression(em));
 		if (ret < 0)
@@ -10416,7 +10403,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	file_extent.offset = encoded->unencoded_offset;
 	file_extent.compression = compression;
 	em = create_io_em(inode, start, num_bytes,
-			  start - encoded->unencoded_offset, ins.objectid,
+			  ins.objectid,
 			  ins.offset, ins.offset, ram_bytes, compression,
 			  &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
@@ -10748,7 +10735,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, NULL, false, true);
+		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, false, true);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 151ed1ebd291..21061a0b2e7c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2911,7 +2911,6 @@ static noinline_for_stack int setup_relocation_extent_mapping(struct inode *inod
 		return -ENOMEM;
 
 	em->start = start;
-	em->orig_start = start;
 	em->len = end + 1 - start;
 	em->block_len = em->len;
 	em->block_start = block_start;
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index e73ac7a0869c..65c6921ff4a2 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -99,7 +99,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 
 	em->start = SZ_16K;
-	em->orig_start = SZ_16K;
 	em->len = SZ_4K;
 	em->block_start = SZ_32K; /* avoid merging */
 	em->block_len = SZ_4K;
@@ -124,7 +123,6 @@ static int test_case_1(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	/* Add [0, 8K), should return [0, 16K) instead. */
 	em->start = start;
-	em->orig_start = start;
 	em->len = len;
 	em->block_start = start;
 	em->block_len = len;
@@ -206,7 +204,6 @@ static int test_case_2(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 
 	em->start = SZ_4K;
-	em->orig_start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
@@ -283,7 +280,6 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 
 	/* Add [4K, 8K) */
 	em->start = SZ_4K;
-	em->orig_start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
@@ -421,7 +417,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 
 	/* Add [8K, 32K) */
 	em->start = SZ_8K;
-	em->orig_start = SZ_8K;
 	em->len = 24 * SZ_1K;
 	em->block_start = SZ_16K; /* avoid merging */
 	em->block_len = 24 * SZ_1K;
@@ -445,7 +440,6 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	}
 	/* Add [0K, 32K) */
 	em->start = 0;
-	em->orig_start = 0;
 	em->len = SZ_32K;
 	em->block_start = 0;
 	em->block_len = SZ_32K;
@@ -533,7 +527,6 @@ static int add_compressed_extent(struct btrfs_inode *inode,
 	}
 
 	em->start = start;
-	em->orig_start = start;
 	em->len = len;
 	em->block_start = block_start;
 	em->block_len = SZ_4K;
@@ -758,7 +751,6 @@ static int test_case_6(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 	}
 
 	em->start = SZ_4K;
-	em->orig_start = SZ_4K;
 	em->len = SZ_4K;
 	em->block_start = SZ_16K;
 	em->block_len = SZ_16K;
@@ -840,7 +832,6 @@ static int test_case_7(struct btrfs_fs_info *fs_info, struct btrfs_inode *inode)
 
 	/* [32K, 48K), not pinned */
 	em->start = SZ_32K;
-	em->orig_start = SZ_32K;
 	em->len = SZ_16K;
 	em->block_start = SZ_32K;
 	em->block_len = SZ_16K;
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index 0895c6e06812..fc390c18ac95 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -358,9 +358,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu", em->start,
-			 em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -386,9 +385,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu", em->start,
-			 em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	disk_bytenr = em->block_start;
@@ -437,9 +435,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
-	if (em->orig_start != orig_start) {
-		test_err("wrong orig offset, want %llu, have %llu",
-			 orig_start, em->orig_start);
+	if (em->start - em->offset != orig_start) {
+		test_err("wrong offset, em->start=%llu em->offset=%llu orig_start=%llu",
+			 em->start, em->offset, orig_start);
 		goto out;
 	}
 	disk_bytenr += (em->start - orig_start);
@@ -472,9 +470,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 prealloc_only, em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu", em->start,
-			 em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -501,9 +498,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 prealloc_only, em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu", em->start,
-			 em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	disk_bytenr = em->block_start;
@@ -530,15 +526,14 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
-	if (em->orig_start != orig_start) {
-		test_err("unexpected orig offset, wanted %llu, have %llu",
-			 orig_start, em->orig_start);
+	if (em->start - em->offset != orig_start) {
+		test_err("unexpected offset, wanted %llu, have %llu",
+			 em->start - orig_start, em->offset);
 		goto out;
 	}
-	if (em->block_start != (disk_bytenr + (em->start - em->orig_start))) {
+	if (em->block_start != disk_bytenr + em->offset) {
 		test_err("unexpected block start, wanted %llu, have %llu",
-			 disk_bytenr + (em->start - em->orig_start),
-			 em->block_start);
+			 disk_bytenr + em->offset, em->block_start);
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -564,15 +559,14 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 prealloc_only, em->flags);
 		goto out;
 	}
-	if (em->orig_start != orig_start) {
-		test_err("wrong orig offset, want %llu, have %llu", orig_start,
-			 em->orig_start);
+	if (em->start - em->offset != orig_start) {
+		test_err("wrong offset, em->start=%llu em->offset=%llu orig_start=%llu",
+			 em->start, em->offset, orig_start);
 		goto out;
 	}
-	if (em->block_start != (disk_bytenr + (em->start - em->orig_start))) {
+	if (em->block_start != disk_bytenr + em->offset) {
 		test_err("unexpected block start, wanted %llu, have %llu",
-			 disk_bytenr + (em->start - em->orig_start),
-			 em->block_start);
+			 disk_bytenr + em->offset, em->block_start);
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -599,9 +593,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 compressed_only, em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu",
-			 em->start, em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	if (extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
@@ -633,9 +626,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 compressed_only, em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu",
-			 em->start, em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	if (extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
@@ -667,9 +659,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu", em->start,
-			 em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -696,9 +687,9 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 compressed_only, em->flags);
 		goto out;
 	}
-	if (em->orig_start != orig_start) {
-		test_err("wrong orig offset, want %llu, have %llu",
-			 em->start, orig_start);
+	if (em->start - em->offset != orig_start) {
+		test_err("wrong offset, em->start=%llu em->offset=%llu orig_start=%llu",
+			 em->start, em->offset, orig_start);
 		goto out;
 	}
 	if (extent_map_compression(em) != BTRFS_COMPRESS_ZLIB) {
@@ -729,9 +720,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu", em->start,
-			 em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -762,9 +752,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 			 vacancy_only, em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu", em->start,
-			 em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	offset = em->start + em->len;
@@ -789,9 +778,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		test_err("unexpected flags set, want 0 have %u", em->flags);
 		goto out;
 	}
-	if (em->orig_start != em->start) {
-		test_err("wrong orig offset, want %llu, have %llu", em->start,
-			 em->orig_start);
+	if (em->offset != 0) {
+		test_err("wrong orig offset, want 0, have %llu", em->offset);
 		goto out;
 	}
 	ret = 0;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index f237b5ed80ec..d6a3151d6c37 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4691,7 +4691,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	enum btrfs_compression_type compress_type;
-	u64 extent_offset = em->start - em->orig_start;
+	u64 extent_offset = em->offset;
 	u64 block_len;
 	int ret;
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index d2d94d7c3fb5..cbac7cd11995 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -291,7 +291,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		__field(	u64,  ino		)
 		__field(	u64,  start		)
 		__field(	u64,  len		)
-		__field(	u64,  orig_start	)
 		__field(	u64,  block_start	)
 		__field(	u64,  block_len		)
 		__field(	u32,  flags		)
@@ -303,7 +302,6 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 		__entry->ino		= btrfs_ino(inode);
 		__entry->start		= map->start;
 		__entry->len		= map->len;
-		__entry->orig_start	= map->orig_start;
 		__entry->block_start	= map->block_start;
 		__entry->block_len	= map->block_len;
 		__entry->flags		= map->flags;
@@ -311,13 +309,11 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
 	),
 
 	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu len=%llu "
-		  "orig_start=%llu block_start=%llu(%s) "
-		  "block_len=%llu flags=%s refs=%u",
+		  "block_start=%llu(%s) block_len=%llu flags=%s refs=%u",
 		  show_root_type(__entry->root_objectid),
 		  __entry->ino,
 		  __entry->start,
 		  __entry->len,
-		  __entry->orig_start,
 		  show_map_type(__entry->block_start),
 		  __entry->block_len,
 		  show_map_flags(__entry->flags),
-- 
2.45.1


