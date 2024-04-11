Return-Path: <linux-btrfs+bounces-4168-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1328A21E6
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Apr 2024 00:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFF71C21D2A
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Apr 2024 22:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A218F47A40;
	Thu, 11 Apr 2024 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P3Q7e6g3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="P3Q7e6g3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ECA46551
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Apr 2024 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712875690; cv=none; b=kLrDI27wq0sJEBUl+seipiFOcdFaI6Viilu6Eaep9K2wZjlm4PArmy/Fpmy8JWDw8QA3VKU0IZaBGmWq0HvFTd2PS5LcQYdqQLqHB+BVl+1v5+5JpojJclJwqhmK2VEzIDGn2Rwyrbwb7el3d8fYoXDknobfCML1stisVeAVayA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712875690; c=relaxed/simple;
	bh=hfNcR26+EHmDLwEPI7n4vuY47qagCOm+/pY1F4IzfJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZ4hREadzczTUyPYKDQMX7fYeZes7Li5QwCl4FJKJm+fHrkGwdcMboLg6iBJp6+Hrc6WCJc2YCwT6UqGs/lDBAp8OmJ15r7cwQv9psd8/ArYFjZvn1VKklwrqmVsd1mNb1LN5igJhO7p5baJ+i6BkK49jubwVUdXuWaDTaiF2sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P3Q7e6g3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=P3Q7e6g3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1FAF222DC1;
	Thu, 11 Apr 2024 22:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712875686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6GbikIDj7ltmN+LEespulbvLzISpC8FYfUr5mGqEeM=;
	b=P3Q7e6g3IuhK9drSMds6IGyRBd30xVs6+ARaNpsnbdvC5d6xoZOWVm6tOJrFYzMoo3Xhz9
	Ad5bZbyhAmen2NO15lFxjblszsH+GIFeac+sQ6ajYXl0pJ+ouIUQ8S0YriWEkEo46TLveL
	3w9fQj6eh6oqKE82ZF2ETwMnDiDsZhI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712875686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6GbikIDj7ltmN+LEespulbvLzISpC8FYfUr5mGqEeM=;
	b=P3Q7e6g3IuhK9drSMds6IGyRBd30xVs6+ARaNpsnbdvC5d6xoZOWVm6tOJrFYzMoo3Xhz9
	Ad5bZbyhAmen2NO15lFxjblszsH+GIFeac+sQ6ajYXl0pJ+ouIUQ8S0YriWEkEo46TLveL
	3w9fQj6eh6oqKE82ZF2ETwMnDiDsZhI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA1481368B;
	Thu, 11 Apr 2024 22:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8GKCJaRoGGbbXAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 11 Apr 2024 22:48:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>
Subject: [PATCH v4 2/3] btrfs: simplify the inline extent map creation
Date: Fri, 12 Apr 2024 08:17:43 +0930
Message-ID: <ebc8f94613ea456e0397fc0ecd7c5fc1eb4855e7.1712875458.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712875458.git.wqu@suse.com>
References: <cover.1712875458.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]

With the tree-checker ensuring all inline file extents starts at file
offset 0 and has a length no larger than sectorsize, we can simplify the
calculation to assigned those fixes values directly.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e58fb5347e65..844439f19949 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1265,20 +1265,19 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 	struct extent_buffer *leaf = path->nodes[0];
 	const int slot = path->slots[0];
 	struct btrfs_key key;
-	u64 extent_start, extent_end;
+	u64 extent_start;
 	u64 bytenr;
 	u8 type = btrfs_file_extent_type(leaf, fi);
 	int compress_type = btrfs_file_extent_compression(leaf, fi);
 
 	btrfs_item_key_to_cpu(leaf, &key, slot);
 	extent_start = key.offset;
-	extent_end = btrfs_file_extent_end(path);
 	em->ram_bytes = btrfs_file_extent_ram_bytes(leaf, fi);
 	em->generation = btrfs_file_extent_generation(leaf, fi);
 	if (type == BTRFS_FILE_EXTENT_REG ||
 	    type == BTRFS_FILE_EXTENT_PREALLOC) {
 		em->start = extent_start;
-		em->len = extent_end - extent_start;
+		em->len = btrfs_file_extent_end(path) - extent_start;
 		em->orig_start = extent_start -
 			btrfs_file_extent_offset(leaf, fi);
 		em->orig_block_len = btrfs_file_extent_disk_num_bytes(leaf, fi);
@@ -1299,9 +1298,12 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 				em->flags |= EXTENT_FLAG_PREALLOC;
 		}
 	} else if (type == BTRFS_FILE_EXTENT_INLINE) {
+		/* Tree-checker has ensured this. */
+		ASSERT(extent_start == 0);
+
 		em->block_start = EXTENT_MAP_INLINE;
-		em->start = extent_start;
-		em->len = extent_end - extent_start;
+		em->start = 0;
+		em->len = fs_info->sectorsize;
 		/*
 		 * Initialize orig_start and block_len with the same values
 		 * as in inode.c:btrfs_get_extent().
@@ -1334,12 +1336,10 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path)
 	ASSERT(key.type == BTRFS_EXTENT_DATA_KEY);
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 
-	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
-		end = btrfs_file_extent_ram_bytes(leaf, fi);
-		end = ALIGN(key.offset + end, leaf->fs_info->sectorsize);
-	} else {
+	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE)
+		end = leaf->fs_info->sectorsize;
+	else
 		end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
-	}
 
 	return end;
 }
-- 
2.44.0


