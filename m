Return-Path: <linux-btrfs+bounces-21797-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MlqBwzYl2m79QIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21797-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 04:42:04 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 757F31646F5
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 04:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D8293011789
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Feb 2026 03:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CF32DCC08;
	Fri, 20 Feb 2026 03:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jbqDZtWa";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jbqDZtWa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBF2DBF40
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 03:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771558921; cv=none; b=IF4TlGzivw8/WSLlJTZ0ePlHcjA9XL4y6jL4Ez01IdE1o2y1PpN37zylLS3igxEpzqiJXLMYy/EhopggbP88USxhgXTI5XvZnkpbR0zITXdeZiteOzpx17Ra4WAGw+8McoLf7stg/2e1fmMS5xK0XpsP60wPpPOY8Jcc6VeOZ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771558921; c=relaxed/simple;
	bh=0TPebbAlwGl55coZRsT0MOw9kWYBvvM/aW3XQ0DW5z4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0/VOedoIZwfO7tTs6DTlMY1zMtcs58LTox1uw9wAMZFj0yK0FCGm4OkFbfGnYhbyoxSOOzMrKi/KSbf7ZeXSw/BEO0qZjnzugWlib3Rjtvw0pJWKQkV+P5fZFdb+1HdYmXBIxW5LpPFTrvkH+UtDTBUqO7qhkBPC96UdMGai/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jbqDZtWa; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jbqDZtWa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 126413E6F4
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 03:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771558918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owsp0uTFQ/R7p3ET5Sm0jlXoNsiyL+wNVJHWFPvxp6k=;
	b=jbqDZtWaS1FUYEg8keLKpIZhetFvqY6iQoZUqsqTWFWhLAppNFnUq0Qpswngm6x8+WXsUR
	evry73KzGbnZlyvtJtetRUR25Px2n35nXdvLQiezmlhuZmqYSwk+AVzN2slwod+eP/+BNY
	jVCx1wwd0eGaAc9eymy4B1p7+JUj6lw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1771558918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=owsp0uTFQ/R7p3ET5Sm0jlXoNsiyL+wNVJHWFPvxp6k=;
	b=jbqDZtWaS1FUYEg8keLKpIZhetFvqY6iQoZUqsqTWFWhLAppNFnUq0Qpswngm6x8+WXsUR
	evry73KzGbnZlyvtJtetRUR25Px2n35nXdvLQiezmlhuZmqYSwk+AVzN2slwod+eP/+BNY
	jVCx1wwd0eGaAc9eymy4B1p7+JUj6lw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46F053EA65
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 03:41:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8FQDAwXYl2nODgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 20 Feb 2026 03:41:57 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: reduce the size of compressed_bio
Date: Fri, 20 Feb 2026 14:11:51 +1030
Message-ID: <49989e5c6c08710861a59af5d3b5148d2978e480.1771558832.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771558832.git.wqu@suse.com>
References: <cover.1771558832.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
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
	TAGGED_FROM(0.00)[bounces-21797-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 757F31646F5
X-Rspamd-Action: no action

The member compressed_bio::compressed_len can be replaced by the bio
size, as we always submit the full compressed data without any partial
read/write.

Furthermore we already have enough ASSERT()s making sure the bio size
matches the ordered extent or the extent map.

This saves 8 bytes from compressed_bio:

Before:

struct compressed_bio {
        u64                        start;                /*     0     8 */
        unsigned int               len;                  /*     8     4 */
        unsigned int               compressed_len;       /*    12     4 */
        u8                         compress_type;        /*    16     1 */
        bool                       writeback;            /*    17     1 */

        /* XXX 6 bytes hole, try to pack */

        struct btrfs_bio *         orig_bbio;            /*    24     8 */
        struct btrfs_bio           bbio __attribute__((__aligned__(8))); /*    32   304 */

        /* XXX last struct has 1 bit hole */

        /* size: 336, cachelines: 6, members: 7 */
        /* sum members: 330, holes: 1, sum holes: 6 */
        /* member types with bit holes: 1, total: 1 */
        /* forced alignments: 1 */
        /* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));

After:

 struct compressed_bio {
        u64                        start;                /*     0     8 */
        unsigned int               len;                  /*     8     4 */
        u8                         compress_type;        /*    12     1 */
        bool                       writeback;            /*    13     1 */

        /* XXX 2 bytes hole, try to pack */

        struct btrfs_bio *         orig_bbio;            /*    16     8 */
        struct btrfs_bio           bbio __attribute__((__aligned__(8))); /*    24   304 */

        /* XXX last struct has 1 bit hole */

        /* size: 328, cachelines: 6, members: 6 */
        /* sum members: 326, holes: 1, sum holes: 2 */
        /* member types with bit holes: 1, total: 1 */
        /* forced alignments: 1 */
        /* last cacheline: 8 bytes */
} __attribute__((__aligned__(8)));

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/compression.c | 2 --
 fs/btrfs/compression.h | 3 ---
 fs/btrfs/lzo.c         | 7 ++++---
 fs/btrfs/zlib.c        | 2 +-
 fs/btrfs/zstd.c        | 2 +-
 5 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index 64600b6458cb..3a33c8fa96c8 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -330,7 +330,6 @@ void btrfs_submit_compressed_write(struct btrfs_ordered_extent *ordered,
 	cb->start = ordered->file_offset;
 	cb->len = ordered->num_bytes;
 	ASSERT(cb->bbio.bio.bi_iter.bi_size == ordered->disk_num_bytes);
-	cb->compressed_len = ordered->disk_num_bytes;
 	cb->bbio.bio.bi_iter.bi_sector = ordered->disk_bytenr >> SECTOR_SHIFT;
 	cb->bbio.ordered = ordered;
 
@@ -560,7 +559,6 @@ void btrfs_submit_compressed_read(struct btrfs_bio *bbio)
 	em_start = em->start;
 
 	cb->len = bbio->bio.bi_iter.bi_size;
-	cb->compressed_len = compressed_len;
 	cb->compress_type = btrfs_extent_map_compression(em);
 	cb->orig_bbio = bbio;
 	cb->bbio.csum_search_commit_root = bbio->csum_search_commit_root;
diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
index 65b8bc4bbe0b..84600b284e1e 100644
--- a/fs/btrfs/compression.h
+++ b/fs/btrfs/compression.h
@@ -48,9 +48,6 @@ struct compressed_bio {
 	/* Number of bytes in the inode we're working on */
 	unsigned int len;
 
-	/* Number of bytes on disk */
-	unsigned int compressed_len;
-
 	/* The compression algorithm for this bio */
 	u8 compress_type;
 
diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
index 971c2ea98e18..fdcce71c2326 100644
--- a/fs/btrfs/lzo.c
+++ b/fs/btrfs/lzo.c
@@ -431,6 +431,7 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct btrfs_fs_info *fs_info = cb->bbio.inode->root->fs_info;
 	const u32 sectorsize = fs_info->sectorsize;
+	const u32 compressed_len = bio_get_size(&cb->bbio.bio);
 	struct folio_iter fi;
 	char *kaddr;
 	int ret;
@@ -460,14 +461,14 @@ int lzo_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	 * and all sectors should be used.
 	 * If this happens, it means the compressed extent is corrupted.
 	 */
-	if (unlikely(len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, cb->compressed_len) ||
-		     round_up(len_in, sectorsize) < cb->compressed_len)) {
+	if (unlikely(len_in > min_t(size_t, BTRFS_MAX_COMPRESSED, compressed_len) ||
+		     round_up(len_in, sectorsize) < compressed_len)) {
 		struct btrfs_inode *inode = cb->bbio.inode;
 
 		btrfs_err(fs_info,
 "lzo header invalid, root %llu inode %llu offset %llu lzo len %u compressed len %u",
 			  btrfs_root_id(inode->root), btrfs_ino(inode),
-			  cb->start, len_in, cb->compressed_len);
+			  cb->start, len_in, compressed_len);
 		return -EUCLEAN;
 	}
 
diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
index 0a8fcee16428..49676ad87815 100644
--- a/fs/btrfs/zlib.c
+++ b/fs/btrfs/zlib.c
@@ -349,7 +349,7 @@ int zlib_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	int wbits = MAX_WBITS;
 	char *data_in;
 	size_t total_out = 0;
-	size_t srclen = cb->compressed_len;
+	const size_t srclen = bio_get_size(&cb->bbio.bio);
 	unsigned long buf_start;
 
 	bio_first_folio(&fi, &cb->bbio.bio, 0);
diff --git a/fs/btrfs/zstd.c b/fs/btrfs/zstd.c
index c002d18666b7..3abb2b98caca 100644
--- a/fs/btrfs/zstd.c
+++ b/fs/btrfs/zstd.c
@@ -587,7 +587,7 @@ int zstd_decompress_bio(struct list_head *ws, struct compressed_bio *cb)
 	struct btrfs_fs_info *fs_info = cb_to_fs_info(cb);
 	struct workspace *workspace = list_entry(ws, struct workspace, list);
 	struct folio_iter fi;
-	size_t srclen = cb->compressed_len;
+	size_t srclen = bio_get_size(&cb->bbio.bio);
 	zstd_dstream *stream;
 	int ret = 0;
 	const u32 blocksize = fs_info->sectorsize;
-- 
2.52.0


