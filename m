Return-Path: <linux-btrfs+bounces-3900-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C15897C72
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Apr 2024 01:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E283B28338C
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Apr 2024 23:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13BBB159582;
	Wed,  3 Apr 2024 23:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="ZnRUHSgj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740CE159560
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712187742; cv=none; b=MulIVCB9Lj+m0Qpd3FH2XrBJV37txG8vt+/dnfVljA0ydHFdXYOhPMTZdB+fIsga5HsvjmPfXMDxpuU8OGu01qynZxBs3ArF63pNK7kPBcgOOveqj7/E0LWDdh1pBM8nodB5E1tQgaFgVQGkl6yli/Az/mlDodik0Bg2a4/XCRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712187742; c=relaxed/simple;
	bh=zogemkn9G3NjcD1ojHA1fXkKRFyqtnX+UQ0/no6QBQ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OC1SkPSlE/pXgLdS1RJEqx9jySY6RnUUXx2kWMkec6AHupu+nI7zEOBERREeeTMIv1OMtj6KS/Ouix5iPR4PainSJwCQUS1PPWx1sJ9FlaRQO/j2MEHQu0kdIDWEhLUqgMUXt2mexgBvcxe/fPUPBhPAsXCwOJiF3C9naFS43ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=ZnRUHSgj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BB5693761D
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712187737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qRKP+IErSwsjVBuYndSHFyai3rBOnHCMS0gkgxDsPLw=;
	b=ZnRUHSgjkJbzm9XG2ZIeBnNGa8xJoY5Ag3/oApU1MyJiaGF3dzs9nOE+QMCWb9tsOSlXvW
	SwFOiezWr2xRT7E/wQIrQxiyAy1xfpFvLU2urEpiT45a4QgdQaxj9mj0eNXqdzYPPGzAMl
	ixPbk3r4i5FdhqKVp0GSSLfoXeU/cTM=
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EC6BD1331E
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Apr 2024 23:42:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mFRHK1jpDWalfQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 03 Apr 2024 23:42:16 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: simplify the inline extent map creation
Date: Thu,  4 Apr 2024 10:12:00 +1030
Message-ID: <5ed85f144e50f7a1e159ebd1748ef1e8be9c0bd2.1712187452.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712187452.git.wqu@suse.com>
References: <cover.1712187452.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO

With the tree-checker ensuring all inline file extents starts at file
offset 0 and has a length no larger than sectorsize, we can simplify the
calculation to assigned those fixes values directly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index e58fb5347e65..ad4761192d59 100644
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
@@ -1335,8 +1337,7 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path)
 	fi = btrfs_item_ptr(leaf, slot, struct btrfs_file_extent_item);
 
 	if (btrfs_file_extent_type(leaf, fi) == BTRFS_FILE_EXTENT_INLINE) {
-		end = btrfs_file_extent_ram_bytes(leaf, fi);
-		end = ALIGN(key.offset + end, leaf->fs_info->sectorsize);
+		end = leaf->fs_info->sectorsize;
 	} else {
 		end = key.offset + btrfs_file_extent_num_bytes(leaf, fi);
 	}
-- 
2.44.0


