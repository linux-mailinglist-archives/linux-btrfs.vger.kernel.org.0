Return-Path: <linux-btrfs+bounces-5236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E428CCB9C
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF271F22EBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773AC13B299;
	Thu, 23 May 2024 05:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sTRyximz";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sTRyximz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B013B582
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440650; cv=none; b=g3GVlw5aH/bCfuXIuPTaaRrs02sc9Ea/6I+5MVU9a/kZPLz9iDerWlWJKWZlfPru9QGdvHYddbyHgAkrALJ6TLOkIdPyPPRjRvwXM8iMarXG8zHujIp4fnCa52I4V+rfVRwDDHe7bUmWqanEvM1I7xlJ900mrLNrcqkdlEjKcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440650; c=relaxed/simple;
	bh=rp1BTGeZUey9B9FTqgFZYGKRRfIwBNrvcRBiXAC484E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJ+mbZikv35VQsnK2r7d8GDporMzRykqix2ObNZKzqPcszh+i83nuGl+9PdyEaoulej9+qYw1z+95FMJu4DY9tMc4cxnsjL3QFMcCww3EZ7ZtBnTdKdu7FUa4Ia8fGWSY3aJLR9hfqqumelFdGp6sq5205xI6KtkzPHljj1kvV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sTRyximz; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sTRyximz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 346B9220E4
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5E8OMD7AHJTU9SX0vJ5yTFwYclps6zJkCJePiOeZcI=;
	b=sTRyximzYggMYWq9iCJtX9AgMRn8829g2jShS63pqO51dc/QRiY/ioq9ynJ9biw3rOVTJt
	uAHt6CUDPpVDcNrraQg/dD5T6A9BQzDm0TQgbMAic/m+gVGf7qy0EcQfyKpBwElG8FniBl
	rTlQBTRliN9HnKILWs2n6JATdDUy9fc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=sTRyximz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5E8OMD7AHJTU9SX0vJ5yTFwYclps6zJkCJePiOeZcI=;
	b=sTRyximzYggMYWq9iCJtX9AgMRn8829g2jShS63pqO51dc/QRiY/ioq9ynJ9biw3rOVTJt
	uAHt6CUDPpVDcNrraQg/dD5T6A9BQzDm0TQgbMAic/m+gVGf7qy0EcQfyKpBwElG8FniBl
	rTlQBTRliN9HnKILWs2n6JATdDUy9fc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49E5413A6B
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gExmO0XOTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:04:05 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 10/11] btrfs: cleanup duplicated parameters related to create_io_em()
Date: Thu, 23 May 2024 14:33:29 +0930
Message-ID: <42f1829b1246d7a5f19fc6964acea928efdd829d.1716440169.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: 346B9220E4
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.com:dkim];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:email]

Most parameters of create_io_em() can be replaced by the members with
the same name inside btrfs_file_extent.

Do a straight parameters cleanup here.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 55 ++++++++++++------------------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 35f03149b777..ecafaa181201 100644
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
 
@@ -1207,13 +1204,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
 	file_extent.offset = 0;
 	file_extent.compression = async_extent->compress_type;
 
-	em = create_io_em(inode, start,
-			  async_extent->ram_size,	/* len */
-			  ins.offset,			/* orig_block_len */
-			  async_extent->ram_size,	/* ram_bytes */
-			  async_extent->compress_type,
-			  &file_extent,
-			  BTRFS_ORDERED_COMPRESSED);
+	em = create_io_em(inode, start, &file_extent, BTRFS_ORDERED_COMPRESSED);
 	if (IS_ERR(em)) {
 		ret = PTR_ERR(em);
 		goto out_free_reserve;
@@ -1443,12 +1434,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		lock_extent(&inode->io_tree, start, start + ram_size - 1,
 			    &cached);
 
-		em = create_io_em(inode, start, ins.offset, /* len */
-				  ins.offset, /* orig_block_len */
-				  ram_size, /* ram_bytes */
-				  BTRFS_COMPRESS_NONE, /* compress_type */
-				  &file_extent,
-				  BTRFS_ORDERED_REGULAR /* type */);
+		em = create_io_em(inode, start, &file_extent, BTRFS_ORDERED_REGULAR);
 		if (IS_ERR(em)) {
 			unlock_extent(&inode->io_tree, start,
 				      start + ram_size - 1, &cached);
@@ -2165,12 +2151,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		if (is_prealloc) {
 			struct extent_map *em;
 
-			em = create_io_em(inode, cur_offset,
-					  nocow_args.file_extent.num_bytes,
-					  nocow_args.file_extent.disk_num_bytes,
-					  nocow_args.file_extent.ram_bytes,
-					  BTRFS_COMPRESS_NONE,
-					  &nocow_args.file_extent,
+			em = create_io_em(inode, cur_offset, &nocow_args.file_extent,
 					  BTRFS_ORDERED_PREALLOC);
 			if (IS_ERR(em)) {
 				unlock_extent(&inode->io_tree, cur_offset,
@@ -7033,10 +7014,7 @@ static struct extent_map *btrfs_create_dio_extent(struct btrfs_inode *inode,
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
@@ -7328,9 +7306,6 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
-				       u64 len,
-				       u64 disk_num_bytes,
-				       u64 ram_bytes, int compress_type,
 				       struct btrfs_file_extent *file_extent,
 				       int type)
 {
@@ -7352,25 +7327,25 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
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
 
@@ -7379,15 +7354,15 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
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
@@ -10354,9 +10329,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
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
2.45.1


