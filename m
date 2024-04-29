Return-Path: <linux-btrfs+bounces-4641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB048B65AC
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Apr 2024 00:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935FB2838D5
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 22:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9D0199E8B;
	Mon, 29 Apr 2024 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kjVPD8pm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="kjVPD8pm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F0C194C8C
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429423; cv=none; b=eU1zxCKx2iC/1hx+3Om1pFDVl6PUun9kNV3srQVYozuXgeTtienCVnw18NZJuQWqNVA+wxQH9pGzsn9ekTygiVTtQBakcNi9c28QO5z9rdjtneQsVXRpmfgEHKGT5oAgOS3ETv1kbtACyMqbeQY2eOo1KHxVAXyczjXN44nb5N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429423; c=relaxed/simple;
	bh=o8vuIHBsX7C5/Qrvt5Pti28TaNyEdY8rmdJB3jQPjUM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CC6eu6ofSAZIGwOpHqp3U1QlPoWvPGIQoFfLHhCD16hgOr85Nf4Q7eq76DY3UemmwoU2/CWNZyyRUXLXbYUwHMHi3COQ4EO6KRGINXRyLRUcFuyLcrGf8bRPfe025/aOIzgeTBhzE+tdYXExar10DFy6J/eF3pIbQgL749g3mlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kjVPD8pm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=kjVPD8pm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C88F1F78B
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8K7kHgj2WzNPvU0TcWKnOpVHOcfAbktkUBGP+FS+wY0=;
	b=kjVPD8pmdPDLk+TZZeveSti4vbGb9EdQCz96mhTG3p0wn3uNfPVXlY553dZtI2wWK2SsmR
	kokDJ3DC5ATPyy4UK9+0B9TvXiVTwvPGetlDdAqbOanOaUimuFKJBneiV4vCuu7CYPSxcg
	j9wr0vcrf1RrIL7PkaOO/ucYgLF4NoQ=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=kjVPD8pm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714429419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8K7kHgj2WzNPvU0TcWKnOpVHOcfAbktkUBGP+FS+wY0=;
	b=kjVPD8pmdPDLk+TZZeveSti4vbGb9EdQCz96mhTG3p0wn3uNfPVXlY553dZtI2wWK2SsmR
	kokDJ3DC5ATPyy4UK9+0B9TvXiVTwvPGetlDdAqbOanOaUimuFKJBneiV4vCuu7CYPSxcg
	j9wr0vcrf1RrIL7PkaOO/ucYgLF4NoQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E4A5F139DE
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8BbuI+kdMGb2GQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 22:23:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/9] btrfs: remove extent_map::orig_start member
Date: Tue, 30 Apr 2024 07:53:04 +0930
Message-ID: <6fe448d41ade8425c469aeaef964898c30335f0c.1714428940.git.wqu@suse.com>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6C88F1F78B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

Since we have extent_map::offset, the old extent_map::orig_start is just
extent_map::start - extent_map::offset for non-hole/inline extents.

And since the new extent_map::offset would be verified by
validate_extent_map() already meanwhile the old orig_start is not, let's
just remove the old member from all call sites.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/btrfs_inode.h            |  2 +-
 fs/btrfs/compression.c            |  2 +-
 fs/btrfs/defrag.c                 |  1 -
 fs/btrfs/extent_map.c             | 29 +----------
 fs/btrfs/extent_map.h             |  9 ----
 fs/btrfs/file-item.c              |  5 +-
 fs/btrfs/file.c                   |  3 +-
 fs/btrfs/inode.c                  | 37 +++++---------
 fs/btrfs/relocation.c             |  1 -
 fs/btrfs/tests/extent-map-tests.c |  9 ----
 fs/btrfs/tests/inode-tests.c      | 84 +++++++++++++------------------
 fs/btrfs/tree-log.c               |  2 +-
 include/trace/events/btrfs.h      | 14 ++----
 13 files changed, 60 insertions(+), 138 deletions(-)

diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 18678762615a..f30afce4f6ca 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -461,7 +461,7 @@ struct btrfs_file_extent {
 };
 
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_start, u64 *orig_block_len,
+			      u64 *orig_block_len,
 			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
 			      bool nowait, bool strict);
 
diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 6441e47d8a5e..a4cd0e743027 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -590,7 +590,7 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	cb = alloc_compressed_bio(inode, file_offset, REQ_OP_READ,
 				  end_bbio_comprssed_read);
 
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
index 8d0e257fc113..dc73b8a81271 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -288,9 +288,9 @@ static void dump_extent_map(const char *prefix, struct extent_map *em)
 {
 	if (!IS_ENABLED(CONFIG_BTRFS_DEBUG))
 		return;
-	pr_crit("%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu orig_start=%llu block_start=%llu block_len=%llu flags=0x%x\n",
+	pr_crit("%s, start=%llu len=%llu disk_bytenr=%llu disk_num_bytes=%llu ram_bytes=%llu offset=%llu block_start=%llu block_len=%llu flags=0x%x\n",
 		prefix, em->start, em->len, em->disk_bytenr, em->disk_num_bytes,
-		em->ram_bytes, em->offset, em->orig_start, em->block_start,
+		em->ram_bytes, em->offset, em->block_start,
 		em->block_len, em->flags);
 	ASSERT(0);
 }
@@ -316,23 +316,6 @@ static void validate_extent_map(struct extent_map *em)
 			if (em->disk_num_bytes != em->block_len)
 				dump_extent_map(
 				"mismatch disk_num_bytes/block_len", em);
-			/*
-			 * Here we only check the start/orig_start/offset for
-			 * compressed extents.
-			 * This is because em::offset is always based on the
-			 * referred data extent, which can be merged.
-			 *
-			 * In that case, @offset would no longer match
-			 * em::start - em::orig_start, and cause false alert.
-			 *
-			 * Thankfully only compressed extent read/encoded write
-			 * really bothers @orig_start, so we can skip
-			 * the check for non-compressed extents.
-			 */
-			if (em->orig_start != em->start - em->offset)
-				dump_extent_map(
-				"mismatch orig_start/offset/start", em);
-
 		} else {
 			if (em->block_start != em->disk_bytenr + em->offset)
 				dump_extent_map(
@@ -370,7 +353,6 @@ static void try_merge_map(struct btrfs_inode *inode, struct extent_map *em)
 			merge = rb_entry(rb, struct extent_map, rb_node);
 		if (rb && can_merge_extent_map(merge) && mergeable_maps(merge, em)) {
 			em->start = merge->start;
-			em->orig_start = merge->orig_start;
 			em->len += merge->len;
 			em->block_len += merge->block_len;
 			em->block_start = merge->block_start;
@@ -900,7 +882,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->len = start - em->start;
 
 			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-				split->orig_start = em->orig_start;
 				split->block_start = em->block_start;
 
 				if (compressed)
@@ -913,7 +894,6 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->offset = em->offset;
 				split->ram_bytes = em->ram_bytes;
 			} else {
-				split->orig_start = split->start;
 				split->block_len = 0;
 				split->block_start = em->block_start;
 				split->disk_bytenr = em->disk_bytenr;
@@ -950,19 +930,16 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
 
@@ -1120,7 +1097,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->disk_bytenr = new_logical;
 	split_pre->disk_num_bytes = split_pre->len;
 	split_pre->offset = 0;
-	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = new_logical;
 	split_pre->block_len = split_pre->len;
 	split_pre->disk_num_bytes = split_pre->block_len;
@@ -1141,7 +1117,6 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->disk_bytenr = em->block_start + pre;
 	split_mid->disk_num_bytes = split_mid->len;
 	split_mid->offset = 0;
-	split_mid->orig_start = split_mid->start;
 	split_mid->block_start = em->block_start + pre;
 	split_mid->block_len = split_mid->len;
 	split_mid->ram_bytes = split_mid->len;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index baccc841f657..883e78513fcd 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -62,15 +62,6 @@ struct extent_map {
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
 	 * The bytenr for of the full on-disk extent.
 	 *
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 47bd4fe0a44b..08d608f0ae5d 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1292,8 +1292,6 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	    type == BTRFS_FILE_EXTENT_PREALLOC) {
 		em->start = extent_start;
 		em->len = btrfs_file_extent_end(path) - extent_start;
-		em->orig_start = extent_start -
-			btrfs_file_extent_offset(leaf, fi);
 		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 		if (bytenr == 0) {
 			em->block_start = EXTENT_MAP_HOLE;
@@ -1326,10 +1324,9 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
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
index 8931eeee199d..be4e6acb08f3 100644
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
@@ -2334,7 +2334,6 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 		hole_em->start = offset;
 		hole_em->len = end - offset;
 		hole_em->ram_bytes = hole_em->len;
-		hole_em->orig_start = offset;
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->disk_bytenr = EXTENT_MAP_HOLE;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 09acc09ea915..e1741fdb5a91 100644
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
@@ -1169,7 +1169,6 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 
 	em = create_io_em(inode, start,
 			  async_extent->ram_size,	/* len */
-			  start,			/* orig_start */
 			  ins.objectid,			/* block_start */
 			  ins.offset,			/* block_len */
 			  ins.offset,			/* orig_block_len */
@@ -1439,7 +1438,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		file_extent.offset = 0;
 		file_extent.compression = BTRFS_COMPRESS_NONE;
 		em = create_io_em(inode, start, ins.offset, /* len */
-				  start, /* orig_start */
 				  ins.objectid, /* block_start */
 				  ins.offset, /* block_len */
 				  ins.offset, /* orig_block_len */
@@ -2162,11 +2160,9 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		nocow_end = cur_offset + nocow_args.num_bytes - 1;
 		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
 		if (is_prealloc) {
-			u64 orig_start = found_key.offset - nocow_args.extent_offset;
 			struct extent_map *em;
 
 			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
-					  orig_start,
 					  nocow_args.disk_bytenr, /* block_start */
 					  nocow_args.num_bytes, /* block_len */
 					  nocow_args.disk_num_bytes, /* orig_block_len */
@@ -4958,7 +4954,6 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 			}
 			hole_em->start = cur_offset;
 			hole_em->len = hole_size;
-			hole_em->orig_start = cur_offset;
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
 			hole_em->disk_bytenr = EXTENT_MAP_HOLE;
@@ -6821,7 +6816,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 		goto out;
 	}
 	em->start = EXTENT_MAP_HOLE;
-	em->orig_start = EXTENT_MAP_HOLE;
 	em->disk_bytenr = EXTENT_MAP_HOLE;
 	em->len = (u64)-1;
 	em->block_len = (u64)-1;
@@ -6914,7 +6908,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 
 		/* New extent overlaps with existing one */
 		em->start = start;
-		em->orig_start = start;
 		em->len = found_key.offset - start;
 		em->block_start = EXTENT_MAP_HOLE;
 		goto insert;
@@ -6950,7 +6943,6 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
 	}
 not_found:
 	em->start = start;
-	em->orig_start = start;
 	em->len = len;
 	em->block_start = EXTENT_MAP_HOLE;
 insert:
@@ -6983,7 +6975,6 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 						  struct btrfs_dio_data *dio_data,
 						  const u64 start,
 						  const u64 len,
-						  const u64 orig_start,
 						  const u64 block_start,
 						  const u64 block_len,
 						  const u64 orig_block_len,
@@ -6995,7 +6986,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, start, len, orig_start, block_start,
+		em = create_io_em(inode, start, len, block_start,
 				  block_len, orig_block_len, ram_bytes,
 				  BTRFS_COMPRESS_NONE, /* compress_type */
 				  file_extent, type);
@@ -7054,7 +7045,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
 	file_extent.ram_bytes = ins.offset;
 	file_extent.offset = 0;
 	file_extent.compression = BTRFS_COMPRESS_NONE;
-	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset, start,
+	em = btrfs_create_dio_extent(inode, dio_data, start, ins.offset,
 				     ins.objectid, ins.offset, ins.offset,
 				     ins.offset, BTRFS_ORDERED_REGULAR,
 				     &file_extent);
@@ -7100,7 +7091,7 @@ static bool btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
  *	 any ordered extents.
  */
 noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
-			      u64 *orig_start, u64 *orig_block_len,
+			      u64 *orig_block_len,
 			      u64 *ram_bytes, struct btrfs_file_extent *file_extent,
 			      bool nowait, bool strict)
 {
@@ -7187,8 +7178,6 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 		}
 	}
 
-	if (orig_start)
-		*orig_start = key.offset - nocow_args.extent_offset;
 	if (orig_block_len)
 		*orig_block_len = nocow_args.disk_num_bytes;
 	if (file_extent)
@@ -7297,7 +7286,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len, u64 orig_start, u64 block_start,
+				       u64 len, u64 block_start,
 				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
@@ -7335,7 +7324,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		ASSERT(ram_bytes == len);
 
 		/* Since it's a new extent, we should not have any offset. */
-		ASSERT(orig_start == start);
+		ASSERT(file_extent->offset == 0);
 		break;
 	case BTRFS_ORDERED_COMPRESSED:
 		/* Must be compressed. */
@@ -7354,7 +7343,6 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		return ERR_PTR(-ENOMEM);
 
 	em->start = start;
-	em->orig_start = orig_start;
 	em->len = len;
 	em->block_len = block_len;
 	em->block_start = block_start;
@@ -7389,7 +7377,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 	struct btrfs_file_extent file_extent = { 0 };
 	struct extent_map *em = *map;
 	int type;
-	u64 block_start, orig_start, orig_block_len, ram_bytes;
+	u64 block_start, orig_block_len, ram_bytes;
 	struct btrfs_block_group *bg;
 	bool can_nocow = false;
 	bool space_reserved = false;
@@ -7416,7 +7404,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		len = min(len, em->len - (start - em->start));
 		block_start = em->block_start + (start - em->start);
 
-		if (can_nocow_extent(inode, start, &len, &orig_start,
+		if (can_nocow_extent(inode, start, &len,
 				     &orig_block_len, &ram_bytes,
 				     &file_extent, false, false) == 1) {
 			bg = btrfs_inc_nocow_writers(fs_info, block_start);
@@ -7444,7 +7432,7 @@ static int btrfs_get_blocks_direct_write(struct extent_map **map,
 		space_reserved = true;
 
 		em2 = btrfs_create_dio_extent(BTRFS_I(inode), dio_data, start, len,
-					      orig_start, block_start,
+					      block_start,
 					      len, orig_block_len,
 					      ram_bytes, type,
 					      &file_extent);
@@ -9595,7 +9583,6 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		}
 
 		em->start = cur_offset;
-		em->orig_start = cur_offset;
 		em->len = ins.offset;
 		em->block_start = ins.objectid;
 		em->disk_bytenr = ins.objectid;
@@ -10104,7 +10091,7 @@ ssize_t btrfs_encoded_read(struct kiocb *iocb, struct iov_iter *iter,
 		disk_io_size = em->block_len;
 		count = em->block_len;
 		encoded->unencoded_len = em->ram_bytes;
-		encoded->unencoded_offset = iocb->ki_pos - em->orig_start;
+		encoded->unencoded_offset = iocb->ki_pos - em->start + em->offset;
 		ret = btrfs_encoded_io_compression_from_extent(fs_info,
 							       extent_map_compression(em));
 		if (ret < 0)
@@ -10347,7 +10334,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	file_extent.offset = encoded->unencoded_offset;
 	file_extent.compression = compression;
 	em = create_io_em(inode, start, num_bytes,
-			  start - encoded->unencoded_offset, ins.objectid,
+			  ins.objectid,
 			  ins.offset, ins.offset, ram_bytes, compression,
 			  &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
@@ -10679,7 +10666,7 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
 		free_extent_map(em);
 		em = NULL;
 
-		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, NULL, false, true);
+		ret = can_nocow_extent(inode, start, &len, NULL, NULL, NULL, false, true);
 		if (ret < 0) {
 			goto out;
 		} else if (ret) {
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 277b03709537..c1bd26a96cc0 100644
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
index 8c683eed9f27..bd56efe37f02 100644
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
index 0895c6e06812..1b8c39edfc18 100644
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
+		test_err("wrong offset, want %llu, have %llu",
+			 em->start - orig_start, em->offset);
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
+		test_err("wrong offset, want %llu, have %llu",
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
+		test_err("wrong offset, want %llu, have %llu",
+			 em->start - orig_start, em->offset);
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
index 83dff4b06c84..c9e8c5f96b1c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4688,7 +4688,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	struct extent_buffer *leaf;
 	struct btrfs_key key;
 	enum btrfs_compression_type compress_type;
-	u64 extent_offset = em->start - em->orig_start;
+	u64 extent_offset = em->offset;
 	u64 block_len;
 	int ret;
 
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index d2d94d7c3fb5..6dacdc1fb63e 100644
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
@@ -861,7 +857,7 @@ TRACE_EVENT(btrfs_add_block_group,
 		{ BTRFS_DROP_DELAYED_REF,   "DROP_DELAYED_REF" },	\
 		{ BTRFS_ADD_DELAYED_EXTENT, "ADD_DELAYED_EXTENT" }, 	\
 		{ BTRFS_UPDATE_DELAYED_HEAD, "UPDATE_DELAYED_HEAD" })
-			
+
 
 DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
 
@@ -873,7 +869,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_tree_ref,
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  bytenr		)
 		__field(	u64,  num_bytes		)
-		__field(	int,  action		) 
+		__field(	int,  action		)
 		__field(	u64,  parent		)
 		__field(	u64,  ref_root		)
 		__field(	int,  level		)
@@ -930,7 +926,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_data_ref,
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  bytenr		)
 		__field(	u64,  num_bytes		)
-		__field(	int,  action		) 
+		__field(	int,  action		)
 		__field(	u64,  parent		)
 		__field(	u64,  ref_root		)
 		__field(	u64,  owner		)
@@ -992,7 +988,7 @@ DECLARE_EVENT_CLASS(btrfs_delayed_ref_head,
 	TP_STRUCT__entry_btrfs(
 		__field(	u64,  bytenr		)
 		__field(	u64,  num_bytes		)
-		__field(	int,  action		) 
+		__field(	int,  action		)
 		__field(	int,  is_data		)
 	),
 
-- 
2.44.0


