Return-Path: <linux-btrfs+bounces-22282-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NLoA0kArmnF+gEAu9opvQ
	(envelope-from <linux-btrfs+bounces-22282-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:03:37 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F99232998
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Mar 2026 00:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6F8F2300D69D
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Mar 2026 23:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342BC2737F8;
	Sun,  8 Mar 2026 23:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gjKgYYRl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gjKgYYRl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E638C352C22
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773011013; cv=none; b=T94i6zyyXy2FtZctB+GfzE2Q1686uyI71BOMvQoLBtFc9dtBCHk6iYrTDHDKld6Zo0q6A0SO/U9k6VEqSSvKs4CLF+VgXskFm9q/hoGDJ0OXYH2vmGAjXvjYEyuITOdSAyTbgTneXsAgPTWtSROlO8tApSKEXU+rOPtl2qP8NtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773011013; c=relaxed/simple;
	bh=XV4lrRPFsmTaCQ18JwA0V3MMQaq6VaQfAt/zyWHRZMk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klA6s8f6H8IthAn+sg90MuincbSDJUHzlhHcs0mqSE7xREKUxwGlZEGdlGWf8TeOoots7yB5ShogpR1vrp86gNI6XjoUUb7o4xGs/bvcLHAE2Repr928TxqcBHsTlSyeOa321VhBsElcYqF3dR/YWpnJmFBqbxArEYaLGAcb38Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gjKgYYRl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gjKgYYRl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92FC45BE07
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773010999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ0ATv+06J6Oquz7DQpRXin6dHkUnjnW2LANbvDrv2g=;
	b=gjKgYYRlkHfGKGE0dscyQgEWyfymvw/6GxK7ce0NbO9kkTk/4lEAh8sNzr3QE3zIWCYWfn
	mxNhtt9wkYmukv7ULQpFSxUkw46spfh3hEEyJsb0WIKuWVsTSKyqGJP61XU9fuoU8ccQle
	EAdRJqwUa0lahg8TNJiHDop/9zkImsE=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=gjKgYYRl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1773010999; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yJ0ATv+06J6Oquz7DQpRXin6dHkUnjnW2LANbvDrv2g=;
	b=gjKgYYRlkHfGKGE0dscyQgEWyfymvw/6GxK7ce0NbO9kkTk/4lEAh8sNzr3QE3zIWCYWfn
	mxNhtt9wkYmukv7ULQpFSxUkw46spfh3hEEyJsb0WIKuWVsTSKyqGJP61XU9fuoU8ccQle
	EAdRJqwUa0lahg8TNJiHDop/9zkImsE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0F623EBA8
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Mar 2026 23:03:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6MKUJDYArmkNbgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 08 Mar 2026 23:03:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH PoC 1/6] btrfs: add skeleton for delayed btrfs bio
Date: Mon,  9 Mar 2026 09:32:50 +1030
Message-ID: <1232ca9d86c3ea312ce3a9a2688c601b332051e9.1773009120.git.wqu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1773009120.git.wqu@suse.com>
References: <cover.1773009120.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 64F99232998
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_FROM(0.00)[bounces-22282-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.995];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,suse.com:mid]
X-Rspamd-Action: no action

The objective of such new delayed btrfs bio infrastructure is to allow
compressed write to go the regular extent_writepage_io() path, without
going through the async submission path.

This will make it easier to align our write path to iomap.

The core ideas of delayed btrfs bio are:

- A place holder ordered extent created at delalloc time
  No space is reserved at that time.

- A delayed extent map created at delalloc time
  It will have a special disk_bytenr (-4) to indicate the range is
  delayed.

- Delayed btrfs bio will be limited to BTRFS_MAX_COMPRESSED size

- Btrfs bio assembly mostly follows the regular path
  There are several small exceptions:
  * btrfs_bio_is_contig() needs to handle delayed disk_bytenr/bbio
  * New bbio needs to have its is_delayed flag set if disk_bytenr
    is EXTENT_MAP_DELAYED

- Real ordered extent will be created at bbio submission time
  This part is not implemented in this patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c         |  1 +
 fs/btrfs/bio.h         |  3 +++
 fs/btrfs/btrfs_inode.h |  3 +++
 fs/btrfs/extent_io.c   | 29 +++++++++++++++++++++++++----
 fs/btrfs/extent_map.h  |  9 ++++++++-
 fs/btrfs/inode.c       | 41 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 2a2a21aec817..513cf2eeff4d 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -900,6 +900,7 @@ void btrfs_submit_bbio(struct btrfs_bio *bbio, int mirror_num)
 {
 	/* If bbio->inode is not populated, its file_offset must be 0. */
 	ASSERT(bbio->inode || bbio->file_offset == 0);
+	ASSERT(!bbio->is_delayed);
 
 	assert_bbio_alignment(bbio);
 
diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
index 303ed6c7103d..49ebdc7ce6e6 100644
--- a/fs/btrfs/bio.h
+++ b/fs/btrfs/bio.h
@@ -99,6 +99,9 @@ struct btrfs_bio {
 	/* Whether the bio is written using zone append. */
 	bool can_use_append:1;
 
+	/* If the bio is delayed (aka, no backing OE). */
+	bool is_delayed:1;
+
 	/*
 	 * This member must come last, bio_alloc_bioset will allocate enough
 	 * bytes for entire btrfs_bio but relies on bio being last.
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index 55c272fe5d92..080ede55b1d6 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -669,5 +669,8 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
 struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
 				      const struct btrfs_file_extent *file_extent,
 				      int type);
+struct extent_map *btrfs_create_delayed_em(struct btrfs_inode *inode,
+					   u64 start, u32 length);
+void btrfs_submit_delayed_write(struct btrfs_bio *bbio);
 
 #endif
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 33b1afbee0a6..5fdc78915046 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -180,12 +180,16 @@ static void submit_one_bio(struct btrfs_bio_ctrl *bio_ctrl)
 
 	/* Caller should ensure the bio has at least some range added */
 	ASSERT(bbio->bio.bi_iter.bi_size);
-
+	/* Delayed bbio is only for write. */
+	if (bbio->is_delayed)
+		ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
 	bio_set_csum_search_commit_root(bio_ctrl);
 
 	if (btrfs_op(&bbio->bio) == BTRFS_MAP_READ &&
 	    bio_ctrl->compress_type != BTRFS_COMPRESS_NONE)
 		btrfs_submit_compressed_read(bbio);
+	else if (bbio->is_delayed)
+		btrfs_submit_delayed_write(bbio);
 	else
 		btrfs_submit_bbio(bbio, 0);
 
@@ -723,6 +727,14 @@ static bool btrfs_bio_is_contig(struct btrfs_bio_ctrl *bio_ctrl,
 	struct bio *bio = &bio_ctrl->bbio->bio;
 	const sector_t sector = disk_bytenr >> SECTOR_SHIFT;
 
+	/* One is delayed bbio and one is not, definitely not contig. */
+	if (bio_ctrl->bbio->is_delayed != (disk_bytenr == EXTENT_MAP_DELAYED))
+		return false;
+
+	/* For delayed bbio, only need to check if the file range is contig. */
+	if (bio_ctrl->bbio->is_delayed)
+		return bio_ctrl->next_file_offset == file_offset;
+
 	if (bio_ctrl->compress_type != BTRFS_COMPRESS_NONE) {
 		/*
 		 * For compression, all IO should have its logical bytenr set
@@ -748,7 +760,13 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 
 	bbio = btrfs_bio_alloc(BIO_MAX_VECS, bio_ctrl->opf, inode,
 			       file_offset, bio_ctrl->end_io_func, NULL);
-	bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+	if (disk_bytenr == EXTENT_MAP_DELAYED) {
+		bbio->is_delayed = true;
+		bbio->bio.bi_iter.bi_sector = 0;
+	} else {
+		bbio->is_delayed = false;
+		bbio->bio.bi_iter.bi_sector = disk_bytenr >> SECTOR_SHIFT;
+	}
 	bbio->bio.bi_write_hint = inode->vfs_inode.i_write_hint;
 	bio_ctrl->bbio = bbio;
 	bio_ctrl->len_to_oe_boundary = U32_MAX;
@@ -762,7 +780,7 @@ static void alloc_new_bio(struct btrfs_inode *inode,
 		if (ordered) {
 			bio_ctrl->len_to_oe_boundary = min_t(u32, U32_MAX,
 					ordered->file_offset +
-					ordered->disk_num_bytes - file_offset);
+					ordered->num_bytes - file_offset);
 			bbio->ordered = ordered;
 		}
 
@@ -1688,7 +1706,10 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	ASSERT(IS_ALIGNED(em->len, sectorsize));
 
 	block_start = btrfs_extent_map_block_start(em);
-	disk_bytenr = btrfs_extent_map_block_start(em) + extent_offset;
+	if (block_start == EXTENT_MAP_DELAYED)
+		disk_bytenr = block_start;
+	else
+		disk_bytenr = block_start + extent_offset;
 
 	ASSERT(!btrfs_extent_map_is_compressed(em));
 	ASSERT(block_start != EXTENT_MAP_HOLE);
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 6f685f3c9327..e45e9f96443a 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -13,7 +13,8 @@
 struct btrfs_inode;
 struct btrfs_fs_info;
 
-#define EXTENT_MAP_LAST_BYTE ((u64)-4)
+#define EXTENT_MAP_LAST_BYTE ((u64)-5)
+#define EXTENT_MAP_DELAYED ((u64)-4)
 #define EXTENT_MAP_HOLE ((u64)-3)
 #define EXTENT_MAP_INLINE ((u64)-2)
 
@@ -30,6 +31,12 @@ enum {
 	ENUM_BIT(EXTENT_FLAG_LOGGING),
 	/* This em is merged from two or more physically adjacent ems */
 	ENUM_BIT(EXTENT_FLAG_MERGED),
+	/*
+	 * This real on-disk extent allocation is delayed until bio submission.
+	 * For now it's only a place holder with EXTENT_MAP_DELAYED as
+	 * its disk_bytenr.
+	 */
+	ENUM_BIT(EXTENT_FLAG_DELAYED),
 };
 
 /*
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index acfef903ac8b..0551b8e755ed 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7552,6 +7552,47 @@ struct extent_map *btrfs_create_io_em(struct btrfs_inode *inode, u64 start,
 	return em;
 }
 
+struct extent_map *btrfs_create_delayed_em(struct btrfs_inode *inode,
+					   u64 start, u32 length)
+{
+	struct extent_map *em;
+	int ret;
+
+	em = btrfs_alloc_extent_map();
+	if (!em)
+		return ERR_PTR(-ENOMEM);
+
+	em->start = start;
+	em->len = length;
+	em->disk_bytenr = EXTENT_MAP_DELAYED;
+	em->disk_num_bytes = 0;
+	em->ram_bytes = 0;
+	em->generation = -1;
+	em->offset = 0;
+	em->flags = EXTENT_FLAG_DELAYED | EXTENT_FLAG_PINNED;
+
+	ret = btrfs_replace_extent_map_range(inode, em, true);
+	if (ret) {
+		btrfs_free_extent_map(em);
+		return ERR_PTR(ret);
+	}
+
+	/* em got 2 refs now, callers needs to do btrfs_free_extent_map once. */
+	return em;
+}
+
+void btrfs_submit_delayed_write(struct btrfs_bio *bbio)
+{
+	ASSERT(bbio->is_delayed);
+
+	/*
+	 * Not yet implemented, and should not hit this path as we have no
+	 * caller to create delayed extent map.
+	 */
+	ASSERT(0);
+	bio_put(&bbio->bio);
+}
+
 /*
  * For release_folio() and invalidate_folio() we have a race window where
  * folio_end_writeback() is called but the subpage spinlock is not yet released.
-- 
2.53.0


