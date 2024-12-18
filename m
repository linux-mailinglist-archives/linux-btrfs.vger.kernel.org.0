Return-Path: <linux-btrfs+bounces-10534-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 902679F61F9
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17EF162142
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE3199939;
	Wed, 18 Dec 2024 09:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KEwVMWqf";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KEwVMWqf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AA1990C8
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514926; cv=none; b=TadLreB0ekCXfccbX82ED2W8qvjbj5LB4fjzXIUun2IYYicJEDuEg8wrwXL3beWnkQL47f83d1Lk3pFqOuzxj096rfkvqxdHjR6s+nGhIU4KdrsHrqA3WE2T/gby+vldrNeAoQk77BNSLco3T9C2Foq4tUkNQBQOxV9Y6v56iDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514926; c=relaxed/simple;
	bh=Fst+Mqm+dWDNtSkEEGdomEBCW3O5AqdB9m3Hzz6izDk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJju1Dvecv0WrMQbYjBIomU8uOl6wlxgRBZoSlWwQz/RJFIsiwtX+PvY7gZALy6ocMz5uLxRjV8Ks0xsu/VXHOfTPiZOxt9mKh0pDorZiFRJbCJrl8U46ewrE6F4EBSXXW90/yUhnIpRpFR6OGEjzgSqqmBvO2ElH97tIA+44sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KEwVMWqf; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KEwVMWqf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 328B82115F
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tObid2YugiBLL/W+L0IGj8tRiOUn9V4yCFmmlUnlSao=;
	b=KEwVMWqf8E/CJpX6dCR05wrG/oTFExsTe9/eJjLfC4DUiy9ucDQdy0T/BKNzubXjrBJcTU
	tGY2ZCRyZx79xpz/B/o2X6ZPfMUabuniWGx5ubrbJbZkrptrPHJWUfrdDsZfvW7Jq3jPXs
	pd0K9/A6KRvZv/BgN3DrADBLckownis=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=KEwVMWqf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tObid2YugiBLL/W+L0IGj8tRiOUn9V4yCFmmlUnlSao=;
	b=KEwVMWqf8E/CJpX6dCR05wrG/oTFExsTe9/eJjLfC4DUiy9ucDQdy0T/BKNzubXjrBJcTU
	tGY2ZCRyZx79xpz/B/o2X6ZPfMUabuniWGx5ubrbJbZkrptrPHJWUfrdDsZfvW7Jq3jPXs
	pd0K9/A6KRvZv/BgN3DrADBLckownis=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E601132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uOkuB+SYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:41:56 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 03/18] btrfs: migrate tree-checker.c to use block size terminology
Date: Wed, 18 Dec 2024 20:11:19 +1030
Message-ID: <33b4832760bb9b224b44e29fa6e22e05c1d9ae77.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 328B82115F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Straightforward rename from "sector" to "block", except the
btrfs_chunk_sector_size() usage, which will be kept as is.

We will keep "sector" to describe the minimal IO unit for a block
device.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tree-checker.c | 100 ++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index dfeee033f31f..7864a096f709 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -126,7 +126,7 @@ static u64 file_extent_end(struct extent_buffer *leaf,
 
 	if (btrfs_file_extent_type(leaf, extent) == BTRFS_FILE_EXTENT_INLINE) {
 		len = btrfs_file_extent_ram_bytes(leaf, extent);
-		end = ALIGN(key->offset + len, leaf->fs_info->sectorsize);
+		end = ALIGN(key->offset + len, leaf->fs_info->blocksize);
 	} else {
 		len = btrfs_file_extent_num_bytes(leaf, extent);
 		end = key->offset + len;
@@ -209,14 +209,14 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_file_extent_item *fi;
-	u32 sectorsize = fs_info->sectorsize;
+	u32 blocksize = fs_info->blocksize;
 	u32 item_size = btrfs_item_size(leaf, slot);
 	u64 extent_end;
 
-	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->offset, blocksize))) {
 		file_extent_err(leaf, slot,
 "unaligned file_offset for file extent, have %llu should be aligned to %u",
-			key->offset, sectorsize);
+			key->offset, blocksize);
 		return -EUCLEAN;
 	}
 
@@ -302,11 +302,11 @@ static int check_extent_data_item(struct extent_buffer *leaf,
 			item_size, sizeof(*fi));
 		return -EUCLEAN;
 	}
-	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_num_bytes, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, offset, sectorsize) ||
-		     CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, sectorsize)))
+	if (unlikely(CHECK_FE_ALIGNED(leaf, slot, fi, ram_bytes, blocksize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_bytenr, blocksize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, disk_num_bytes, blocksize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, offset, blocksize) ||
+		     CHECK_FE_ALIGNED(leaf, slot, fi, num_bytes, blocksize)))
 		return -EUCLEAN;
 
 	/* Catch extent end overflow */
@@ -365,7 +365,7 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			   int slot, struct btrfs_key *prev_key)
 {
 	struct btrfs_fs_info *fs_info = leaf->fs_info;
-	u32 sectorsize = fs_info->sectorsize;
+	u32 blocksize = fs_info->blocksize;
 	const u32 csumsize = fs_info->csum_size;
 
 	if (unlikely(key->objectid != BTRFS_EXTENT_CSUM_OBJECTID)) {
@@ -374,10 +374,10 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 			key->objectid, BTRFS_EXTENT_CSUM_OBJECTID);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->offset, blocksize))) {
 		generic_err(leaf, slot,
 	"unaligned key offset for csum item, have %llu should be aligned to %u",
-			key->offset, sectorsize);
+			key->offset, blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(!IS_ALIGNED(btrfs_item_size(leaf, slot), csumsize))) {
@@ -391,7 +391,7 @@ static int check_csum_item(struct extent_buffer *leaf, struct btrfs_key *key,
 		u32 prev_item_size;
 
 		prev_item_size = btrfs_item_size(leaf, slot - 1);
-		prev_csum_end = (prev_item_size / csumsize) * sectorsize;
+		prev_csum_end = (prev_item_size / csumsize) * blocksize;
 		prev_csum_end += prev_key->offset;
 		if (unlikely(prev_csum_end > key->offset)) {
 			generic_err(leaf, slot - 1,
@@ -857,20 +857,20 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
 			  num_stripes, nparity);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(logical, fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(logical, fs_info->blocksize))) {
 		chunk_err(leaf, chunk, logical,
 		"invalid chunk logical, have %llu should aligned to %u",
-			  logical, fs_info->sectorsize);
+			  logical, fs_info->blocksize);
 		return -EUCLEAN;
 	}
-	if (unlikely(btrfs_chunk_sector_size(leaf, chunk) != fs_info->sectorsize)) {
+	if (unlikely(btrfs_chunk_sector_size(leaf, chunk) != fs_info->blocksize)) {
 		chunk_err(leaf, chunk, logical,
-			  "invalid chunk sectorsize, have %u expect %u",
+			  "invalid chunk blocksize, have %u expect %u",
 			  btrfs_chunk_sector_size(leaf, chunk),
-			  fs_info->sectorsize);
+			  fs_info->blocksize);
 		return -EUCLEAN;
 	}
-	if (unlikely(!length || !IS_ALIGNED(length, fs_info->sectorsize))) {
+	if (unlikely(!length || !IS_ALIGNED(length, fs_info->blocksize))) {
 		chunk_err(leaf, chunk, logical,
 			  "invalid chunk length, have %llu", length);
 		return -EUCLEAN;
@@ -1229,10 +1229,10 @@ static int check_root_item(struct extent_buffer *leaf, struct btrfs_key *key,
 	}
 
 	/* Alignment and level check */
-	if (unlikely(!IS_ALIGNED(btrfs_root_bytenr(&ri), fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(btrfs_root_bytenr(&ri), fs_info->blocksize))) {
 		generic_err(leaf, slot,
 		"invalid root bytenr, have %llu expect to be aligned to %u",
-			    btrfs_root_bytenr(&ri), fs_info->sectorsize);
+			    btrfs_root_bytenr(&ri), fs_info->blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(btrfs_root_level(&ri) >= BTRFS_MAX_LEVEL)) {
@@ -1327,10 +1327,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	/* key->objectid is the bytenr for both key types */
-	if (unlikely(!IS_ALIGNED(key->objectid, fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->objectid, fs_info->blocksize))) {
 		generic_err(leaf, slot,
 		"invalid key objectid, have %llu expect to be aligned to %u",
-			   key->objectid, fs_info->sectorsize);
+			   key->objectid, fs_info->blocksize);
 		return -EUCLEAN;
 	}
 
@@ -1420,10 +1420,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 				   key->type, BTRFS_EXTENT_ITEM_KEY);
 			return -EUCLEAN;
 		}
-		if (unlikely(!IS_ALIGNED(key->offset, fs_info->sectorsize))) {
+		if (unlikely(!IS_ALIGNED(key->offset, fs_info->blocksize))) {
 			extent_err(leaf, slot,
 			"invalid extent length, have %llu expect aligned to %u",
-				   key->offset, fs_info->sectorsize);
+				   key->offset, fs_info->blocksize);
 			return -EUCLEAN;
 		}
 		if (unlikely(flags & BTRFS_BLOCK_FLAG_FULL_BACKREF)) {
@@ -1486,10 +1486,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 		/* Contains parent bytenr */
 		case BTRFS_SHARED_BLOCK_REF_KEY:
 			if (unlikely(!IS_ALIGNED(inline_offset,
-						 fs_info->sectorsize))) {
+						 fs_info->blocksize))) {
 				extent_err(leaf, slot,
 		"invalid tree parent bytenr, have %llu expect aligned to %u",
-					   inline_offset, fs_info->sectorsize);
+					   inline_offset, fs_info->blocksize);
 				return -EUCLEAN;
 			}
 			inline_refs++;
@@ -1521,10 +1521,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 				return -EUCLEAN;
 			}
 			if (unlikely(!IS_ALIGNED(dref_offset,
-						 fs_info->sectorsize))) {
+						 fs_info->blocksize))) {
 				extent_err(leaf, slot,
 		"invalid data ref offset, have %llu expect aligned to %u",
-					   dref_offset, fs_info->sectorsize);
+					   dref_offset, fs_info->blocksize);
 				return -EUCLEAN;
 			}
 			if (unlikely(btrfs_extent_data_ref_count(leaf, dref) == 0)) {
@@ -1538,10 +1538,10 @@ static int check_extent_item(struct extent_buffer *leaf,
 		case BTRFS_SHARED_DATA_REF_KEY:
 			sref = (struct btrfs_shared_data_ref *)(iref + 1);
 			if (unlikely(!IS_ALIGNED(inline_offset,
-						 fs_info->sectorsize))) {
+						 fs_info->blocksize))) {
 				extent_err(leaf, slot,
 		"invalid data parent bytenr, have %llu expect aligned to %u",
-					   inline_offset, fs_info->sectorsize);
+					   inline_offset, fs_info->blocksize);
 				return -EUCLEAN;
 			}
 			if (unlikely(btrfs_shared_data_ref_count(leaf, sref) == 0)) {
@@ -1641,17 +1641,17 @@ static int check_simple_keyed_refs(struct extent_buffer *leaf,
 			    expect_item_size, key->type);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->blocksize))) {
 		generic_err(leaf, slot,
 "invalid key objectid for shared block ref, have %llu expect aligned to %u",
-			    key->objectid, leaf->fs_info->sectorsize);
+			    key->objectid, leaf->fs_info->blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(key->type != BTRFS_TREE_BLOCK_REF_KEY &&
-		     !IS_ALIGNED(key->offset, leaf->fs_info->sectorsize))) {
+		     !IS_ALIGNED(key->offset, leaf->fs_info->blocksize))) {
 		extent_err(leaf, slot,
 		"invalid tree parent bytenr, have %llu expect aligned to %u",
-			   key->offset, leaf->fs_info->sectorsize);
+			   key->offset, leaf->fs_info->blocksize);
 		return -EUCLEAN;
 	}
 	return 0;
@@ -1671,10 +1671,10 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 			    sizeof(*dref), key->type);
 		return -EUCLEAN;
 	}
-	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->blocksize))) {
 		generic_err(leaf, slot,
 "invalid key objectid for shared block ref, have %llu expect aligned to %u",
-			    key->objectid, leaf->fs_info->sectorsize);
+			    key->objectid, leaf->fs_info->blocksize);
 		return -EUCLEAN;
 	}
 	for (; ptr < end; ptr += sizeof(*dref)) {
@@ -1703,10 +1703,10 @@ static int check_extent_data_ref(struct extent_buffer *leaf,
 				   root);
 			return -EUCLEAN;
 		}
-		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->sectorsize))) {
+		if (unlikely(!IS_ALIGNED(offset, leaf->fs_info->blocksize))) {
 			extent_err(leaf, slot,
 	"invalid extent data backref offset, have %llu expect aligned to %u",
-				   offset, leaf->fs_info->sectorsize);
+				   offset, leaf->fs_info->blocksize);
 			return -EUCLEAN;
 		}
 		if (unlikely(btrfs_extent_data_ref_count(leaf, dref) == 0)) {
@@ -1773,10 +1773,10 @@ static int check_inode_ref(struct extent_buffer *leaf,
 static int check_raid_stripe_extent(const struct extent_buffer *leaf,
 				    const struct btrfs_key *key, int slot)
 {
-	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->objectid, leaf->fs_info->blocksize))) {
 		generic_err(leaf, slot,
 "invalid key objectid for raid stripe extent, have %llu expect aligned to %u",
-			    key->objectid, leaf->fs_info->sectorsize);
+			    key->objectid, leaf->fs_info->blocksize);
 		return -EUCLEAN;
 	}
 
@@ -1795,7 +1795,7 @@ static int check_dev_extent_item(const struct extent_buffer *leaf,
 				 struct btrfs_key *prev_key)
 {
 	struct btrfs_dev_extent *de;
-	const u32 sectorsize = leaf->fs_info->sectorsize;
+	const u32 blocksize = leaf->fs_info->blocksize;
 
 	de = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
 	/* Basic fixed member checks. */
@@ -1816,25 +1816,25 @@ static int check_dev_extent_item(const struct extent_buffer *leaf,
 		return -EUCLEAN;
 	}
 	/* Alignment check. */
-	if (unlikely(!IS_ALIGNED(key->offset, sectorsize))) {
+	if (unlikely(!IS_ALIGNED(key->offset, blocksize))) {
 		generic_err(leaf, slot,
 			    "invalid dev extent key.offset, has %llu not aligned to %u",
-			    key->offset, sectorsize);
+			    key->offset, blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_chunk_offset(leaf, de),
-				 sectorsize))) {
+				 blocksize))) {
 		generic_err(leaf, slot,
 			    "invalid dev extent chunk offset, has %llu not aligned to %u",
 			    btrfs_dev_extent_chunk_objectid(leaf, de),
-			    sectorsize);
+			    blocksize);
 		return -EUCLEAN;
 	}
 	if (unlikely(!IS_ALIGNED(btrfs_dev_extent_length(leaf, de),
-				 sectorsize))) {
+				 blocksize))) {
 		generic_err(leaf, slot,
 			    "invalid dev extent length, has %llu not aligned to %u",
-			    btrfs_dev_extent_length(leaf, de), sectorsize);
+			    btrfs_dev_extent_length(leaf, de), blocksize);
 		return -EUCLEAN;
 	}
 	/* Overlap check with previous dev extent. */
@@ -2123,10 +2123,10 @@ enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node)
 				"invalid NULL node pointer");
 			return BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
 		}
-		if (unlikely(!IS_ALIGNED(bytenr, fs_info->sectorsize))) {
+		if (unlikely(!IS_ALIGNED(bytenr, fs_info->blocksize))) {
 			generic_err(node, slot,
 			"unaligned pointer, have %llu should be aligned to %u",
-				bytenr, fs_info->sectorsize);
+				bytenr, fs_info->blocksize);
 			return BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
 		}
 
-- 
2.47.1


