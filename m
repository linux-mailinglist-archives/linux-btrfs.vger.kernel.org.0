Return-Path: <linux-btrfs+bounces-4710-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B38C8BA6D6
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 08:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFB21C22004
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 06:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2552313A869;
	Fri,  3 May 2024 06:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T24dy9or";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="T24dy9or"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDEB13A3FD
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716146; cv=none; b=tjRyoEVGN8Nem2HS9i6LDgR/b9kXYKhZM03Q6S72NMSwv8/domTa/ZPZ/kxaEclOgTe50hwpG7uX8JTHQv04NhWY9h3bMTO1xiwU8HpBnQSZoJ9MFpfh9X5n9Bb50FnXG6d8L0esMHELzYoC2w55BF2XMyje3p51PM43DKf36JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716146; c=relaxed/simple;
	bh=NX/Hhe9i5sPmBtdV4sS1I5elGBGSL2rNcktgJi1WJ7k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hy4q/6bPBNbrvFyaT0S7xYTD/Ul0XIWeyRF/CF3r97v+w9YYl6/6oYzcN1a4mzRpnXkCQqhgXDqm5FIiZqzBAfYAjXPEaGDEHPN4Jd9D4+HWMhBa60sltk34+vuqD3/i15qM+jtsKnJyXV6Zz3xXsMu9MW6gIErZIgQABHPJWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T24dy9or; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=T24dy9or; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E052F22884
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hwcoqkEw3iyiHOgGLy9b/Iyr4OWHQsbBrsgo6QoPbs=;
	b=T24dy9orAfiqA0vR9ZBdAFTmj2L6O5ARvmyLLqNkFBb8pR+wn1UhkpgXGBrxPKIuvwN0Cr
	kUV4YgLUG37nduuGhdl7xGUrCupP7N+K7WZ4V3ctE9a58BBBwg4jqA33Fa9834xXrgm0qx
	jbjuW0eEk0vnE0yoxSmzHQPsSPdrfCk=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8hwcoqkEw3iyiHOgGLy9b/Iyr4OWHQsbBrsgo6QoPbs=;
	b=T24dy9orAfiqA0vR9ZBdAFTmj2L6O5ARvmyLLqNkFBb8pR+wn1UhkpgXGBrxPKIuvwN0Cr
	kUV4YgLUG37nduuGhdl7xGUrCupP7N+K7WZ4V3ctE9a58BBBwg4jqA33Fa9834xXrgm0qx
	jbjuW0eEk0vnE0yoxSmzHQPsSPdrfCk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AF0013991
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qO0iLu19NGbgawAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 03 May 2024 06:02:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 10/11] btrfs: cleanup duplicated parameters related to create_io_em()
Date: Fri,  3 May 2024 15:31:45 +0930
Message-ID: <ee8e2727bfb0607f2e3b091364c131864e120439.1714707707.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Most parameters of create_io_em() can be replaced by the members with
the same name inside btrfs_file_extent.

Do a straight parameters cleanup here.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 50 +++++++++++++-----------------------------------
 1 file changed, 13 insertions(+), 37 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index eec5ecb917d8..a95dc2333972 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -138,9 +138,6 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     u64 end, struct writeback_control *wbc,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len,
-				       u64 disk_num_bytes,
-				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
 				       int type);
 
@@ -1207,12 +1204,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	file_extent.offset = 0;
 	file_extent.compression = async_extent->compress_type;
 
-	em = create_io_em(inode, start,
-			  async_extent->ram_size,	/* len */
-			  ins.offset,			/* orig_block_len */
-			  async_extent->ram_size,	/* ram_bytes */
-			  async_extent->compress_type,
-			  &file_extent,
+	em = create_io_em(inode, start, &file_extent,
 			  BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
@@ -1443,11 +1435,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		lock_extent(&inode->io_tree, start, start + ram_size - 1,
 			    &cached);
 
-		em = create_io_em(inode, start, ins.offset, /* len */
-				  ins.offset, /* orig_block_len */
-				  ram_size, /* ram_bytes */
-				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  &file_extent,
+		em = create_io_em(inode, start, &file_extent,
 				  BTRFS_ORDERED_REGULAR /* type */);
 		if (IS_ERR(em)) {
 			unlock_extent(&inode->io_tree, start,
@@ -2168,10 +2156,6 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 			struct extent_map *em;
 
 			em = create_io_em(inode, cur_offset,
-					  nocow_args.file_extent.num_bytes,
-					  nocow_args.file_extent.disk_num_bytes,
-					  nocow_args.file_extent.ram_bytes,
-					  BTRFS_COMPRESS_NONE,
 					  &nocow_args.file_extent,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
@@ -6995,10 +6979,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
 	struct btrfs_ordered_extent *ordered;
 
 	if (type != BTRFS_ORDERED_NOCOW) {
-		em = create_io_em(inode, start, len,
-				  orig_block_len, ram_bytes,
-				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  file_extent, type);
+		em = create_io_em(inode, start, file_extent, type);
 		if (IS_ERR(em))
 			goto out;
 	}
@@ -7290,9 +7271,6 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len,
-				       u64 disk_num_bytes,
-				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
 				       int type)
 {
@@ -7314,25 +7292,25 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	switch (type) {
 	case BTRFS_ORDERED_PREALLOC:
 		/* We're only referring part of a larger preallocated extent. */
-		ASSERT(len <= ram_bytes);
+		ASSERT(file_extent->num_bytes <= file_extent->ram_bytes);
 		break;
 	case BTRFS_ORDERED_REGULAR:
 		/* COW results a new extent matching our file extent size. */
-		ASSERT(disk_num_bytes == len);
-		ASSERT(ram_bytes == len);
+		ASSERT(file_extent->disk_num_bytes == file_extent->num_bytes);
+		ASSERT(file_extent->ram_bytes == file_extent->num_bytes);
 
 		/* Since it's a new extent, we should not have any offset. */
 		ASSERT(file_extent->offset == 0);
 		break;
 	case BTRFS_ORDERED_COMPRESSED:
 		/* Must be compressed. */
-		ASSERT(compress_type != BTRFS_COMPRESS_NONE);
+		ASSERT(file_extent->compression != BTRFS_COMPRESS_NONE);
 
 		/*
 		 * Encoded write can make us to refer to part of the
 		 * uncompressed extent.
 		 */
-		ASSERT(len <= ram_bytes);
+		ASSERT(file_extent->num_bytes <= file_extent->ram_bytes);
 		break;
 	}
 
@@ -7341,15 +7319,15 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		return ERR_PTR(-ENOMEM);
 
 	em->start = start;
-	em->len = len;
+	em->len = file_extent->num_bytes;
 	em->disk_bytenr = file_extent->disk_bytenr;
-	em->disk_num_bytes = disk_num_bytes;
-	em->ram_bytes = ram_bytes;
+	em->disk_num_bytes = file_extent->disk_num_bytes;
+	em->ram_bytes = file_extent->ram_bytes;
 	em->generation = -1;
 	em->offset = file_extent->offset;
 	em->flags |= EXTENT_FLAG_PINNED;
 	if (type == BTRFS_ORDERED_COMPRESSED)
-		extent_map_set_compression(em, compress_type);
+		extent_map_set_compression(em, file_extent->compression);
 
 	ret = btrfs_replace_extent_map_range(inode, em, true);
 	if (ret) {
@@ -10327,9 +10305,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
 	file_extent.ram_bytes = ram_bytes;
 	file_extent.offset = encoded->unencoded_offset;
 	file_extent.compression = compression;
-	em = create_io_em(inode, start, num_bytes,
-			  ins.offset, ram_bytes, compression,
-			  &file_extent, BTRFS_ORDERED_COMPRESSED);
+	em = create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserved;
-- 
2.45.0


