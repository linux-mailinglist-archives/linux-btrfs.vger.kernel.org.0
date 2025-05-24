Return-Path: <linux-btrfs+bounces-14198-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1AEAC2D03
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1500AA2418A
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A52714885B;
	Sat, 24 May 2025 02:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lj6j2BXR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="lj6j2BXR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A477E9
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052523; cv=none; b=laMSeyw05n6bvyz4nuofBe1+IxBSvs1vwmuunakZollR3AC/VdnYoJWrCeGCpMk9qPuXlX2jFpLghYAfWrSU25hDPE/K2RzCiIIBf5um88dQJzMuiSD/ibAXXktIa3He8cVVRzU2z3CdPof2c2GpXxtkX5TyXeUq+vu/rsmjw2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052523; c=relaxed/simple;
	bh=DTFGTkCuV458PzZSkfvlpKmROjDn3NV5IpP9NUh6moQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyhUgUfZ2kaWKK01X8dDnbPI+H1JnfnVn3nY3/So66L3g2GZaEaajh8GdXIQ5Q3I5+hZlQZQXYt1HdIMIU8hZ/NKfqv53apMtkw0Tn5PwUu+Q0p6ip2D8TumyodIPc7+9jNRVnDBfCBMoCVzED+vmWPAPF/HiZjlfd9zAF6YLfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lj6j2BXR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=lj6j2BXR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F8E61F896
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8J4BHnGvSIonXSxSJ3/0lGSY3hra5otbSxwOgmKQj44=;
	b=lj6j2BXRVW3xub7R1eXSsgqxuhKpfc/E8uf5R9O4N709yBs2P8Mv6GxrbTM9JirQcs1ip3
	iNblwResKmIPwVoCyVLHuNIL/kQoY6/pBa/yLZ9qHOHT+u0Ca6yanSk1RRsbdceKl7KvEB
	ccnmn/KdA3o2eZZZ1L3qVACPiHx+U7w=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8J4BHnGvSIonXSxSJ3/0lGSY3hra5otbSxwOgmKQj44=;
	b=lj6j2BXRVW3xub7R1eXSsgqxuhKpfc/E8uf5R9O4N709yBs2P8Mv6GxrbTM9JirQcs1ip3
	iNblwResKmIPwVoCyVLHuNIL/kQoY6/pBa/yLZ9qHOHT+u0Ca6yanSk1RRsbdceKl7KvEB
	ccnmn/KdA3o2eZZZ1L3qVACPiHx+U7w=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D158F1373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YHXxJCUqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:37 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/9] btrfs-progs: convert: simplify insert_temp_dev_item() and insert_temp_chunk_item()
Date: Sat, 24 May 2025 11:38:09 +0930
Message-ID: <d4bd363b270e930b3e2bec96c781a2ddf1d4ac67.1748049973.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748049973.git.wqu@suse.com>
References: <cover.1748049973.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

These functions require parameters @slot and @itemoff to record where the
next item should land.

But this is overkilled, as after inserting an item, the temporary extent
buffer will have its header nritems and the item pointer updated.

We can use that header nritems and item pointer to get where the next
item should land.

This removes the external counter to record @slot and @itemoff.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/common.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index df68b696f8f5..b21ad4c8fa7b 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -292,14 +292,15 @@ out:
 }
 
 static int insert_temp_dev_item(int fd, struct extent_buffer *buf,
-				struct btrfs_mkfs_config *cfg,
-				int *slot, u32 *itemoff)
+				struct btrfs_mkfs_config *cfg)
 {
 	struct btrfs_disk_key disk_key;
 	struct btrfs_dev_item *dev_item;
 	unsigned char dev_uuid[BTRFS_UUID_SIZE];
 	unsigned char fsid[BTRFS_FSID_SIZE];
 	struct btrfs_super_block super;
+	u32 slot = btrfs_header_nritems(buf);
+	u32 itemoff = get_item_offset(buf, cfg);
 	int ret;
 
 	ret = pread(fd, &super, BTRFS_SUPER_INFO_SIZE, cfg->super_bytenr);
@@ -308,17 +309,17 @@ static int insert_temp_dev_item(int fd, struct extent_buffer *buf,
 		goto out;
 	}
 
-	btrfs_set_header_nritems(buf, *slot + 1);
-	(*itemoff) -= sizeof(*dev_item);
+	btrfs_set_header_nritems(buf, slot + 1);
+	itemoff -= sizeof(*dev_item);
 	/* setup device item 1, 0 is for replace case */
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_ITEM_KEY);
 	btrfs_set_disk_key_objectid(&disk_key, BTRFS_DEV_ITEMS_OBJECTID);
 	btrfs_set_disk_key_offset(&disk_key, 1);
-	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, *slot, *itemoff);
-	btrfs_set_item_size(buf, *slot, sizeof(*dev_item));
+	btrfs_set_item_key(buf, &disk_key, slot);
+	btrfs_set_item_offset(buf, slot, itemoff);
+	btrfs_set_item_size(buf, slot, sizeof(*dev_item));
 
-	dev_item = btrfs_item_ptr(buf, *slot, struct btrfs_dev_item);
+	dev_item = btrfs_item_ptr(buf, slot, struct btrfs_dev_item);
 	/* Generate device uuid */
 	uuid_generate(dev_uuid);
 	write_extent_buffer(buf, dev_uuid,
@@ -346,19 +347,19 @@ static int insert_temp_dev_item(int fd, struct extent_buffer *buf,
 	read_extent_buffer(buf, &super.dev_item, (unsigned long)dev_item,
 			   sizeof(*dev_item));
 	ret = write_temp_super(fd, &super, cfg->super_bytenr);
-	(*slot)++;
 out:
 	return ret;
 }
 
 static int insert_temp_chunk_item(int fd, struct extent_buffer *buf,
 				  struct btrfs_mkfs_config *cfg,
-				  int *slot, u32 *itemoff, u64 start, u64 len,
-				  u64 type)
+				  u64 start, u64 len, u64 type)
 {
 	struct btrfs_chunk *chunk;
 	struct btrfs_disk_key disk_key;
 	struct btrfs_super_block sb;
+	u32 slot = btrfs_header_nritems(buf);
+	u32 itemoff = get_item_offset(buf, cfg);
 	int ret = 0;
 
 	ret = pread(fd, &sb, BTRFS_SUPER_INFO_SIZE, cfg->super_bytenr);
@@ -367,16 +368,16 @@ static int insert_temp_chunk_item(int fd, struct extent_buffer *buf,
 		return ret;
 	}
 
-	btrfs_set_header_nritems(buf, *slot + 1);
-	(*itemoff) -= btrfs_chunk_item_size(1);
+	btrfs_set_header_nritems(buf, slot + 1);
+	itemoff -= btrfs_chunk_item_size(1);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_CHUNK_ITEM_KEY);
 	btrfs_set_disk_key_objectid(&disk_key, BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	btrfs_set_disk_key_offset(&disk_key, start);
-	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, *slot, *itemoff);
-	btrfs_set_item_size(buf, *slot, btrfs_chunk_item_size(1));
+	btrfs_set_item_key(buf, &disk_key, slot);
+	btrfs_set_item_offset(buf, slot, itemoff);
+	btrfs_set_item_size(buf, slot, btrfs_chunk_item_size(1));
 
-	chunk = btrfs_item_ptr(buf, *slot, struct btrfs_chunk);
+	chunk = btrfs_item_ptr(buf, slot, struct btrfs_chunk);
 	btrfs_set_chunk_length(buf, chunk, len);
 	btrfs_set_chunk_owner(buf, chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_chunk_stripe_len(buf, chunk, BTRFS_STRIPE_LEN);
@@ -392,7 +393,6 @@ static int insert_temp_chunk_item(int fd, struct extent_buffer *buf,
 	write_extent_buffer(buf, sb.dev_item.uuid,
 			    (unsigned long)btrfs_stripe_dev_uuid_nr(chunk, 0),
 			    BTRFS_UUID_SIZE);
-	(*slot)++;
 
 	/*
 	 * If it's system chunk, also copy it to super block.
@@ -422,8 +422,6 @@ static int setup_temp_chunk_tree(int fd, struct btrfs_mkfs_config *cfg,
 				 u64 chunk_bytenr)
 {
 	struct extent_buffer *buf = NULL;
-	u32 itemoff = cfg->leaf_data_size;
-	int slot = 0;
 	int ret;
 
 	/* Must ensure SYS chunk starts before META chunk */
@@ -440,17 +438,15 @@ static int setup_temp_chunk_tree(int fd, struct btrfs_mkfs_config *cfg,
 	if (ret < 0)
 		goto out;
 
-	ret = insert_temp_dev_item(fd, buf, cfg, &slot, &itemoff);
+	ret = insert_temp_dev_item(fd, buf, cfg);
 	if (ret < 0)
 		goto out;
-	ret = insert_temp_chunk_item(fd, buf, cfg, &slot, &itemoff,
-				     sys_chunk_start,
+	ret = insert_temp_chunk_item(fd, buf, cfg, sys_chunk_start,
 				     BTRFS_MKFS_SYSTEM_GROUP_SIZE,
 				     BTRFS_BLOCK_GROUP_SYSTEM);
 	if (ret < 0)
 		goto out;
-	ret = insert_temp_chunk_item(fd, buf, cfg, &slot, &itemoff,
-				     meta_chunk_start,
+	ret = insert_temp_chunk_item(fd, buf, cfg, meta_chunk_start,
 				     BTRFS_CONVERT_META_GROUP_SIZE,
 				     BTRFS_BLOCK_GROUP_METADATA);
 	if (ret < 0)
-- 
2.49.0


