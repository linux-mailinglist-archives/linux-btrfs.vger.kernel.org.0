Return-Path: <linux-btrfs+bounces-13290-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3057A9873E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 12:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D427C442C9A
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Apr 2025 10:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61493267720;
	Wed, 23 Apr 2025 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="No9OPx16";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="No9OPx16"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D71F4C8C
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745403905; cv=none; b=nceKHKgnA23f299Cf54kc/ORs6d9hK7/DPt2DLCZZeG+43QWs+TUQOwL8SWOEiHg7GMOMo1H1J2Nv21aV2Zor9XB3fInhgrZJ8QBX958iUs8QwM9QKS+BRJ7GJB0W1qRgF6648MFNv04vvK0cYrhvjZgGluIngZkZRkLZyp/xOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745403905; c=relaxed/simple;
	bh=GXHFpcS2j9C0tNqvFx43rO1NLkKzU2tl4CnNlrVyJ9g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=I9J/vJPeOA1ZXs/6fVYXyWopDUooJkeLi9ezq4Y5ARgnem/MwyvGlDnucIaVfTCitYcNJ+FFNC0hRBXxtTkd3BBhKRXLIc8ttccXspgsXo290KeEkeYjS3ywlITab9P/F6mAHrv5gbzuHP76yGxd0uqvdTanxLVkRgf6xCgoMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=No9OPx16; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=No9OPx16; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76E452117F
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745403901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sXe66ISMmmjRomqCuyd8ZDDU1Ac/16lHgWUVCoY6ZBc=;
	b=No9OPx1621DqLF6vjCEaNKOHwjAOw4Waq2d7uHcnA6llUgEaD6UnmTlZb/tUOY/TaQc1D3
	4TZAOosABMf4LdasOC3+VWEkFj3utcwWfrXUbEv5rIi2rtxVEE4r7hhLIfvadyiFcS6fem
	Mi4HBWMiNUQCUd7CMLuaem6ajV+6uRg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1745403901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=sXe66ISMmmjRomqCuyd8ZDDU1Ac/16lHgWUVCoY6ZBc=;
	b=No9OPx1621DqLF6vjCEaNKOHwjAOw4Waq2d7uHcnA6llUgEaD6UnmTlZb/tUOY/TaQc1D3
	4TZAOosABMf4LdasOC3+VWEkFj3utcwWfrXUbEv5rIi2rtxVEE4r7hhLIfvadyiFcS6fem
	Mi4HBWMiNUQCUd7CMLuaem6ajV+6uRg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE03E13691
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 10:25:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id awNoHPy/CGiKHgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Apr 2025 10:25:00 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: enable experimental large data folio support
Date: Wed, 23 Apr 2025 19:54:42 +0930
Message-ID: <676154e5415d8d15499fb8c02b0eabbb1c6cef26.1745403878.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

With all the preparation patches already merged, it's pretty easy to
enable large data folios:

- Remove the ASSERT() on folio size in btrfs_end_repair_bio()

- Add a helper to properly set the max folio order
  Currently due to several call sites are fetching the bitmap content
  directly into an unsigned long, we can only support BITS_PER_LONG
  blocks for each bitmap.

- Call the helper when reading/creating an inode

The support has the following limits:

- No large folios for data reloc inode
  The relocation code still requires page sized folio.
  But it's not that hot nor common compared to regular buffered ios.

  Will be improved in the future.

- Requires CONFIG_BTRFS_EXPERIMENTAL

Unfortunately I do not have a physical machine for performance test, but
if everything goes like XFS/EXT4, it should mostly bring single digits
percentage performance improvement in the real world.

Although I believe there are still quite some optimizations to be done,
let's focus on testing the current large data folio support first.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/bio.c         |  6 ------
 fs/btrfs/btrfs_inode.h | 18 ++++++++++++++++++
 fs/btrfs/inode.c       |  2 ++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index a3ee9a976f6f..d60586a8d48b 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -165,12 +165,6 @@ static void btrfs_end_repair_bio(struct btrfs_bio *repair_bbio,
 	struct bio_vec *bv = bio_first_bvec_all(&repair_bbio->bio);
 	int mirror = repair_bbio->mirror_num;
 
-	/*
-	 * We can only trigger this for data bio, which doesn't support larger
-	 * folios yet.
-	 */
-	ASSERT(folio_order(page_folio(bv->bv_page)) == 0);
-
 	if (repair_bbio->bio.bi_status ||
 	    !btrfs_data_csum_ok(repair_bbio, dev, 0, bv)) {
 		bio_reset(&repair_bbio->bio, NULL, REQ_OP_READ);
diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
index a5ebd2b9e242..61fad5423b6a 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -525,6 +525,24 @@ static inline void btrfs_update_inode_mapping_flags(struct btrfs_inode *inode)
 		mapping_set_stable_writes(inode->vfs_inode.i_mapping);
 }
 
+static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
+{
+	const struct btrfs_fs_info *fs_info = inode->root->fs_info;
+
+	/* Metadata inode should not reach here. */
+	ASSERT(is_data_inode(inode));
+
+	/* For data reloc inode, it still requires page sized folio. */
+	if (unlikely(btrfs_root_id(inode->root) == BTRFS_DATA_RELOC_TREE_OBJECTID))
+		return;
+
+	/* We only allows BITS_PER_LONGS blocks for each bitmap. */
+#ifdef CONFIG_BTRFS_EXPERIMENTAL
+	mapping_set_folio_order_range(inode->vfs_inode.i_mapping, 0,
+			ilog2(((BITS_PER_LONG << fs_info->sectorsize_bits) >> PAGE_SHIFT)));
+#endif
+}
+
 /* Array of bytes with variable length, hexadecimal format 0x1234 */
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a88aa23cdbb6..538a9ec86abc 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3930,6 +3930,7 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
 				&inode->flags, &inode->ro_flags);
 	btrfs_update_inode_mapping_flags(inode);
+	btrfs_set_inode_mapping_order(inode);
 
 cache_index:
 	/*
@@ -6343,6 +6344,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
 				BTRFS_INODE_NODATASUM;
 		btrfs_update_inode_mapping_flags(BTRFS_I(inode));
+		btrfs_set_inode_mapping_order(BTRFS_I(inode));
 	}
 
 	ret = btrfs_insert_inode_locked(inode);
-- 
2.49.0


