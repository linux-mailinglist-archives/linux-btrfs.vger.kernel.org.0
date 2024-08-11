Return-Path: <linux-btrfs+bounces-7093-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4D894E02A
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 07:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35EFB210F2
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Aug 2024 05:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28311AAC4;
	Sun, 11 Aug 2024 05:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X1L2DMpj";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="X1L2DMpj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE81B7F4
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723355446; cv=none; b=cEKT6rVOb7ViGh4r9fx6nykWT1G+be22Q2coNIZe45lK4MY071roO9Ook5nSOMFj/jPTmhithYKafXFyK5ZE+P2foCr4+w53ZkaFt2Fsd5iYC5Md+xjNjYQRG/TshsuRIWaaSLa0IVIrAL3QBB10Aq99PLb0RBBr21ryHgCLZrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723355446; c=relaxed/simple;
	bh=dNvV+cH+QzIOK0PD5qzhDT5SCfFAZUewWeT6+cLa7Bk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=EtIK3Z89wzXfWKzbEMoeCSa2wdoTokmKVErBefMvwlStbh+bpCBFhI6DMNNMoJbZIIyjxr1gGYdJ1VP4ryLsdN82jLzCgSzHtFKPD6FxVtQNkqeSJm9ZzzDX4nPUGW65vfGFCtaBfsT4uB6Z11GIYzBsy8pXS5z2Z3dpN0I2usk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X1L2DMpj; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=X1L2DMpj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A64522255
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 05:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723355435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RpntmiFUVw5y4plWKpMJiRjYChbWXSd50lzZ/9krEDY=;
	b=X1L2DMpjkP+OE6Jg1X/7bA3w4+efXcpU2X3WUg0n+DJBluvD1ECsx/cCW+odliooNHcBBd
	JaTQ/6JmYZoKj1C6CDDqZ3YNG4phuALrlQf0ASEdDwGJK5iJk5dUlHAFUEJ+8DMKxOUyHb
	ZGanNMy+aZz6u8FIAnNPRA/Y4ra5WgQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1723355435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=RpntmiFUVw5y4plWKpMJiRjYChbWXSd50lzZ/9krEDY=;
	b=X1L2DMpjkP+OE6Jg1X/7bA3w4+efXcpU2X3WUg0n+DJBluvD1ECsx/cCW+odliooNHcBBd
	JaTQ/6JmYZoKj1C6CDDqZ3YNG4phuALrlQf0ASEdDwGJK5iJk5dUlHAFUEJ+8DMKxOUyHb
	ZGanNMy+aZz6u8FIAnNPRA/Y4ra5WgQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 712011398B
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 05:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9qWrCipRuGagNwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2024 05:50:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: tree-checker: add btrfs dev extent checks
Date: Sun, 11 Aug 2024 15:20:08 +0930
Message-ID: <eb543cde2378cc111b0b8359ef94ff0dbd51ee58.1723355397.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.2
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
	TO_DN_NONE(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

[REPORT]
There is a corruption report that btrfs refuse to mount a fs that has
overlapping dev extents:

 BTRFS error (device sdc): dev extent devid 4 physical offset
14263979671552 overlap with previous dev extent end 14263980982272
 BTRFS error (device sdc): failed to verify dev extents against chunks: -117
 BTRFS error (device sdc): open_ctree failed

[CAUSE]
The cause is very obvious, there is a bad dev extent item with incorrect
length.
Although we are not 100% sure of the cause before getting the dev tree
dump, I'm already surprised that we do not have any checks on dev tree.

Currently we only do the dev-extent verification at mount time, but if the
corruption is caused by memory bitflip, we really want to catch it before
writing the corruption to the storage.

Furthermore the dev extent items has the following key definition:

	(<device id> DEV_EXTENT <physical offset>)

Thus we can not just rely on the generic key order check to make sure
there is no overlapping.

[ENHANCEMENT]
Introduce dedicated dev extent checks, including:

- Fixed member checks
  * chunk_tree should always be BTRFS_CHUNK_TREE_OBJECTID (3)
  * chunk_objectid should always be
    BTRFS_FIRST_CHUNK_CHUNK_TREE_OBJECTID (256)

- Alignment checks
  * chunk_offset should be aligned to sectorsize
  * length should be aligned to sectorsize
  * key.offset should be aligned to sectorsize

- Overlap checks
  If the previous key is also a dev-extent item, with the same
  device id, make sure we do not overlap with the previous dev extent.

Reported: Stefan N <stefannnau@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/CA+W5K0rSO3koYTo=nzxxTm1-Pdu1HYgVxEpgJ=aGc7d=E8mGEg@mail.gmail.com/
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 69 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index a825fa598e3c..3e8fbedfe04d 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1763,6 +1763,72 @@ static int check_raid_stripe_extent(const struct extent_buffer *leaf,
 	return 0;
 }
 
+static int check_dev_extent_item(const struct extent_buffer *leaf,
+				 const struct btrfs_key *key,
+				 int slot,
+				 struct btrfs_key *prev_key)
+{
+	struct btrfs_dev_extent *de;
+	const u32 sectorsize = leaf->fs_info->sectorsize;
+
+	de = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
+	/* Basic fixed member checks. */
+	if (unlikely(btrfs_dev_extent_chunk_tree(leaf, de) !=
+		     BTRFS_CHUNK_TREE_OBJECTID)) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk tree id, has %llu expect %llu",
+			    btrfs_dev_extent_chunk_tree(leaf, de),
+			    BTRFS_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	if (unlikely(btrfs_dev_extent_chunk_objectid(leaf, de) !=
+		     BTRFS_FIRST_CHUNK_TREE_OBJECTID)) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk objectid, has %llu expect %llu",
+			    btrfs_dev_extent_chunk_objectid(leaf, de),
+			    BTRFS_FIRST_CHUNK_TREE_OBJECTID);
+		return -EUCLEAN;
+	}
+	/* Alignment check. */
+	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent key.offset, has %llu not aligned to %u",
+			    key->offset, sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_chunk_offset(leaf, de),
+				 sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent chunk offset, has %llu not aligned to %u",
+			    btrfs_dev_extent_chunk_objectid(leaf, de),
+			    sectorsize);
+		return -EUCLEAN;
+	}
+	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_length(leaf, de),
+				 sectorsize))) {
+		generic_err(leaf, slot,
+			    "invalid dev extent length, has %llu not aligned to %u",
+			    btrfs_dev_extent_length(leaf, de), sectorsize);
+		return -EUCLEAN;
+	}
+	/* Overlap check with previous dev extent. */
+	if (slot && prev_key->objectid == key->objectid &&
+	    prev_key->type == key->type) {
+		struct btrfs_dev_extent *prev_de;
+		u64 prev_len;
+
+		prev_de = btrfs_item_ptr(leaf, slot - 1, struct btrfs_dev_extent);
+		prev_len = btrfs_dev_extent_length(leaf, prev_de);
+		if (unlikely(prev_key->offset + prev_len > key->offset)) {
+			generic_err(leaf, slot,
+		"dev extent overlap, prev offset %llu len %llu current offset %llu",
+				    prev_key->objectid, prev_len, key->offset);
+			return -EUCLEAN;
+		}
+	}
+	return 0;
+}
+
 /*
  * Common point to switch the item-specific validation.
  */
@@ -1799,6 +1865,9 @@ static enum btrfs_tree_block_status check_leaf_item(struct extent_buffer *leaf,
 	case BTRFS_DEV_ITEM_KEY:
 		ret = check_dev_item(leaf, key, slot);
 		break;
+	case BTRFS_DEV_EXTENT_KEY:
+		ret = check_dev_extent_item(leaf, key, slot, prev_key);
+		break;
 	case BTRFS_INODE_ITEM_KEY:
 		ret = check_inode_item(leaf, key, slot);
 		break;
-- 
2.45.2


