Return-Path: <linux-btrfs+bounces-14443-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2390ACD98D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 10:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F216416F7C9
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Jun 2025 08:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79D28C2AD;
	Wed,  4 Jun 2025 08:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tN0MWZKH";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tN0MWZKH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421C215179
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025187; cv=none; b=UiDJJjdvEruY0thNlkD1OTxkTJTaYSs0uWolgIeeQ8nbcNYMMnciUrGpLP8WUtoitxRQHgn11vTh4as88NNo4tGBPVqq4CzpjFmASDBFcifgnLZVKj9iy5h1lBifSufXY/VPredsgPZ5wok+wpKor+elScc+54z2UTWQBRRQYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025187; c=relaxed/simple;
	bh=Se3gw2xFs9qrdKnsIKNWOF7LxILccwMnlDGc+lYhwGw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XvMwNaFjlc78F5+cHHKuzh5kobXNgny9gpn0BxEN59gxz/E+6v2Jdxmg6qbdsh2qXy9fNJJuvHgJdn6ruRTNnLmfvpj7x/N/uQJqUiIgw6X0awmnGdiwE8jNsGZglANm3brt9w97KVKl3Lz03S6sVM5GXn0RplV6zbl8gsY48cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tN0MWZKH; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tN0MWZKH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65CAF20732
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 08:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749025181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pywCBm/RWlf4ce1WFWH21ys9dQA2101RtMhcV1n3rU4=;
	b=tN0MWZKHfkTbYQx9xcOwZb7h5RtUp7y4vhsLzeu4EF/Qyz1xpnaN0CSolS4EKqDQLUG9pX
	oGjX9BNpC15Na9D3oP5yTH0T529FLyWTB1DJelGxLC3vqOMxRV2tGd8Hp8RtP8O/xol3Lz
	eeiFt0uSW6zEc9MSSRUAgdxSmS1nyVE=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749025181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pywCBm/RWlf4ce1WFWH21ys9dQA2101RtMhcV1n3rU4=;
	b=tN0MWZKHfkTbYQx9xcOwZb7h5RtUp7y4vhsLzeu4EF/Qyz1xpnaN0CSolS4EKqDQLUG9pX
	oGjX9BNpC15Na9D3oP5yTH0T529FLyWTB1DJelGxLC3vqOMxRV2tGd8Hp8RtP8O/xol3Lz
	eeiFt0uSW6zEc9MSSRUAgdxSmS1nyVE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A414E13A63
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Jun 2025 08:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HRXWGZwBQGhCeQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 04 Jun 2025 08:19:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: enable experimental large data folio support
Date: Wed,  4 Jun 2025 17:49:37 +0930
Message-ID: <899362450597548e37a52bba61f0157e929eb901.1749025117.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.18)[-0.894];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.78

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
Changelog:
v2:
- Fix a warning when CONFIG_BTRFS_EXPERIMENTAL is not enabled
  The @fs_info is only utilized when CONFIG_BTRFS_EXPERIMENTAL is
  enabled.
  Fix it by remove the @fs_info declaration and grab it manually
  inside the CONFIG_BTRFS_EXPERIMENTAL branch.
---
 fs/btrfs/bio.c         |  6 ------
 fs/btrfs/btrfs_inode.h | 17 +++++++++++++++++
 fs/btrfs/inode.c       |  2 ++
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index e7d436c6aec2..00d274ed2b1f 100644
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
index a79fa0726f1d..c2bd8f98a936 100644
--- a/fs/btrfs/btrfs_inode.h
+++ b/fs/btrfs/btrfs_inode.h
@@ -525,6 +525,23 @@ static inline void btrfs_update_inode_mapping_flags(struct btrfs_inode *inode)
 		mapping_set_stable_writes(inode->vfs_inode.i_mapping);
 }
 
+static inline void btrfs_set_inode_mapping_order(struct btrfs_inode *inode)
+{
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
+			ilog2(((BITS_PER_LONG << inode->root->fs_info->sectorsize_bits)
+				>> PAGE_SHIFT)));
+#endif
+}
+
 /* Array of bytes with variable length, hexadecimal format 0x1234 */
 #define CSUM_FMT				"0x%*phN"
 #define CSUM_FMT_VALUE(size, bytes)		size, bytes
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b9ce0479fcb1..a160f63c072a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3946,6 +3946,7 @@ static int btrfs_read_locked_inode(struct btrfs_inode *inode, struct btrfs_path
 	btrfs_inode_split_flags(btrfs_inode_flags(leaf, inode_item),
 				&inode->flags, &inode->ro_flags);
 	btrfs_update_inode_mapping_flags(inode);
+	btrfs_set_inode_mapping_order(inode);
 
 cache_index:
 	/*
@@ -6467,6 +6468,7 @@ int btrfs_create_new_inode(struct btrfs_trans_handle *trans,
 			BTRFS_I(inode)->flags |= BTRFS_INODE_NODATACOW |
 				BTRFS_INODE_NODATASUM;
 		btrfs_update_inode_mapping_flags(BTRFS_I(inode));
+		btrfs_set_inode_mapping_order(BTRFS_I(inode));
 	}
 
 	ret = btrfs_insert_inode_locked(inode);
-- 
2.49.0


