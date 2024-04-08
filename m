Return-Path: <linux-btrfs+bounces-4030-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C44989CE73
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619DC1C21B73
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 22:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A663C473;
	Mon,  8 Apr 2024 22:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oTz9ryWC";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="oTz9ryWC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A364E26ACE
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615647; cv=none; b=mLOVHVVCaT4Fir7QLqsT4vSM1/Y5M9keUmU2H41INLBjbezk4Aicl9BMwBYqOsYY6nceWTyjrAuHvQnizqUiL7iz6MzgSR1q01N5mHQAwHVTOXyDnRbzCQJMpxF4NfQNj+bSIlqftteFA8nkoSlZ59UDbm33mkgeFt7tbELMfdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615647; c=relaxed/simple;
	bh=cqpeNGXFpfR4O9tDOkzFGmZ/BKMRwhECJ0o4/18A8s4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0rGPPG86ESUcZ+9Sw/BYwUcHOxvSuHm6nHNT1cca/6XvdnkWyQrCIBLUSKao+jFfKjD5pbtCc+Z5sjsQGYCeusdtKwHz9KIOjl9q85duMVEPG5PAwiA+lQZ3Sp2kEOxMKqIkIWVXeMMFM/odfxflpYLnlMjfcWI9Ae4u/W7oY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oTz9ryWC; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=oTz9ryWC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 95B31205F0
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2X63Mx0PaMmf/EqwRWKX9lmDkOK5J1O3N46kdCqQbtY=;
	b=oTz9ryWCSB3rgFn+7XjBPA/LfxNUmUkLMifUQKoPhLUfphPT/oCEJdKqWoQDDdTPQcRmvn
	x2we2cUvk1CBQ3tjNfakZDvL406ClsRHtBzFwkAZjHiskUUFjUMlypW9BuuiQF9a9pxBE3
	m44ec4TTYqGO/Ne8xJh1mou36ysedGg=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=oTz9ryWC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2X63Mx0PaMmf/EqwRWKX9lmDkOK5J1O3N46kdCqQbtY=;
	b=oTz9ryWCSB3rgFn+7XjBPA/LfxNUmUkLMifUQKoPhLUfphPT/oCEJdKqWoQDDdTPQcRmvn
	x2we2cUvk1CBQ3tjNfakZDvL406ClsRHtBzFwkAZjHiskUUFjUMlypW9BuuiQF9a9pxBE3
	m44ec4TTYqGO/Ne8xJh1mou36ysedGg=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id A156E1332F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id QGQyFdlwFGaSTQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Apr 2024 22:34:01 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 2/8] btrfs: rename members of can_nocow_file_extent_args
Date: Tue,  9 Apr 2024 08:03:41 +0930
Message-ID: <5780c450b3b5a642773bf3981bcfd49d1a6080b0.1712614770.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712614770.git.wqu@suse.com>
References: <cover.1712614770.git.wqu@suse.com>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 95B31205F0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

The structure can_nocow_file_extent_args is utilized to provide the
needed info for a NOCOW writes.

However some of its members are pretty confusing.
For example, @disk_bytenr is not btrfs_file_extent_item::disk_bytenr,
but with extra offset, thus it works more like extent_map::block_start.

This patch would:

- Rename members directly fetched from btrfs_file_extent_item
  The new name would have "orig_" prefix, with the same member name from
  btrfs_file_extent_item.

- For the old @disk_bytenr, rename it to @block_start
  As it's directly passed into create_io_em() as @block_start.

- Add extra comments explaining those members

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 51 ++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2e0156943c7c..4d207c3b38d9 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1847,11 +1847,20 @@ struct can_nocow_file_extent_args {
 	 */
 	bool free_path;
 
-	/* Output fields. Only set when can_nocow_file_extent() returns 1. */
+	/*
+	 * Output fields. Only set when can_nocow_file_extent() returns 1.
+	 *
+	 * @block_start:	The bytenr of the new nocow write should be at.
+	 * @orig_disk_bytenr:	The original data extent's disk_bytenr.
+	 * @orig_disk_num_bytes:The original data extent's disk_num_bytes.
+	 * @orig_offset:	The original offset inside the old data extent.
+	 *			Caller should calculate their own
+	 *			btrfs_file_extent_item::offset base on this.
+	 */
 
-	u64 disk_bytenr;
-	u64 disk_num_bytes;
-	u64 extent_offset;
+	u64 block_start;
+	u64 orig_disk_num_bytes;
+	u64 orig_offset;
 	/* Number of bytes that can be written to in NOCOW mode. */
 	u64 num_bytes;
 };
@@ -1887,9 +1896,9 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 		goto out;
 
 	/* Can't access these fields unless we know it's not an inline extent. */
-	args->disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
-	args->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
-	args->extent_offset = btrfs_file_extent_offset(leaf, fi);
+	args->block_start = btrfs_file_extent_disk_bytenr(leaf, fi);
+	args->orig_disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
+	args->orig_offset = btrfs_file_extent_offset(leaf, fi);
 
 	if (!(inode->flags & BTRFS_INODE_NODATACOW) &&
 	    extent_type == BTRFS_FILE_EXTENT_REG)
@@ -1906,7 +1915,7 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 		goto out;
 
 	/* An explicit hole, must COW. */
-	if (args->disk_bytenr == 0)
+	if (args->block_start == 0)
 		goto out;
 
 	/* Compressed/encrypted/encoded extents must be COWed. */
@@ -1925,8 +1934,8 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	btrfs_release_path(path);
 
 	ret = btrfs_cross_ref_exist(root, btrfs_ino(inode),
-				    key->offset - args->extent_offset,
-				    args->disk_bytenr, args->strict, path);
+				    key->offset - args->orig_offset,
+				    args->block_start, args->strict, path);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
 		goto out;
@@ -1947,15 +1956,15 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	    atomic_read(&root->snapshot_force_cow))
 		goto out;
 
-	args->disk_bytenr += args->extent_offset;
-	args->disk_bytenr += args->start - key->offset;
+	args->block_start += args->orig_offset;
+	args->block_start += args->start - key->offset;
 	args->num_bytes = min(args->end + 1, extent_end) - args->start;
 
 	/*
 	 * Force COW if csums exist in the range. This ensures that csums for a
 	 * given extent are either valid or do not exist.
 	 */
-	ret = csum_exist_in_range(root->fs_info, args->disk_bytenr, args->num_bytes,
+	ret = csum_exist_in_range(root->fs_info, args->block_start, args->num_bytes,
 				  nowait);
 	WARN_ON_ONCE(ret > 0 && is_freespace_inode);
 	if (ret != 0)
@@ -2112,7 +2121,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			goto must_cow;
 
 		ret = 0;
-		nocow_bg = btrfs_inc_nocow_writers(fs_info, nocow_args.disk_bytenr);
+		nocow_bg = btrfs_inc_nocow_writers(fs_info, nocow_args.block_start);
 		if (!nocow_bg) {
 must_cow:
 			/*
@@ -2151,14 +2160,14 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		nocow_end = cur_offset + nocow_args.num_bytes - 1;
 		is_prealloc = extent_type == BTRFS_FILE_EXTENT_PREALLOC;
 		if (is_prealloc) {
-			u64 orig_start = found_key.offset - nocow_args.extent_offset;
+			u64 orig_start = found_key.offset - nocow_args.orig_offset;
 			struct extent_map *em;
 
 			em = create_io_em(inode, cur_offset, nocow_args.num_bytes,
 					  orig_start,
-					  nocow_args.disk_bytenr, /* block_start */
+					  nocow_args.block_start, /* block_start */
 					  nocow_args.num_bytes, /* block_len */
-					  nocow_args.disk_num_bytes, /* orig_block_len */
+					  nocow_args.orig_disk_num_bytes, /* orig_block_len */
 					  ram_bytes, BTRFS_COMPRESS_NONE,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
@@ -2171,7 +2180,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 		ordered = btrfs_alloc_ordered_extent(inode, cur_offset,
 				nocow_args.num_bytes, nocow_args.num_bytes,
-				nocow_args.disk_bytenr, nocow_args.num_bytes, 0,
+				nocow_args.block_start, nocow_args.num_bytes, 0,
 				is_prealloc
 				? (1 << BTRFS_ORDERED_PREALLOC)
 				: (1 << BTRFS_ORDERED_NOCOW),
@@ -7189,7 +7198,7 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	}
 
 	ret = 0;
-	if (btrfs_extent_readonly(fs_info, nocow_args.disk_bytenr))
+	if (btrfs_extent_readonly(fs_info, nocow_args.block_start))
 		goto out;
 
 	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATACOW) &&
@@ -7206,9 +7215,9 @@ noinline int can_nocow_extent(struct inode *inode, u64 offset, u64 *len,
 	}
 
 	if (orig_start)
-		*orig_start = key.offset - nocow_args.extent_offset;
+		*orig_start = key.offset - nocow_args.orig_offset;
 	if (orig_block_len)
-		*orig_block_len = nocow_args.disk_num_bytes;
+		*orig_block_len = nocow_args.orig_disk_num_bytes;
 
 	*len = nocow_args.num_bytes;
 	ret = 1;
-- 
2.44.0


