Return-Path: <linux-btrfs+bounces-15051-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3551CAEB96B
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 16:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C783B5622D7
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 14:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C516F2DBF7B;
	Fri, 27 Jun 2025 14:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MJrydzrm";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MJrydzrm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7A32DBF57
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033046; cv=none; b=AQFmDSPbjhf74hkuiy5QzJzDw9MZHDsbR0YGZBG0REEJcd9PTRlM63jK+7r6I5LxPXh/6TBRTObTmHRLntoP6w8MsV5TWPZrUc2NvXnKTBEIwHJSq8EJUaB/av638qT+211WFEzciMAgrYbl00dsJOEKr8+IiSvfIkr16lYtFIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033046; c=relaxed/simple;
	bh=P6tnNC1xPBKvKOnKg7Ce04rN1lntACPY+NbUm0vS4SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjpcmA7abeyS4afAm2EAzqqZ2p7VZpkYoAsrOEAnix/yJbQV/kj8UExjrV9Xnl3hl09e1EYYC+coikHZHNEEwWeuejPS2rpHq7umstif5ouMmSY90WGHVaJcYOGykA3S8z8R+9Ry0w+lXMU0vKtpNGDUfjAhWfqDiQiKZF9O1D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MJrydzrm; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MJrydzrm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CB00921175;
	Fri, 27 Jun 2025 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmsiAUfhY8iE7qCnW4cVjZLK2Blm4dNcSwCRFvPrM6U=;
	b=MJrydzrmhUUbA+Dq+elpdRc8pAAs0TtURLKWY1MpZ6W6h7Cpso1sd27dPGAzaCC31vC57X
	pJTlMK9xPuZrzNW5SEwQ3arPcpcKcWElbqusYNbiSM/cyO4gRKoga1UF/UuTrQvbROFQKG
	1OlpbGqIetrcoUTV+SsDLjtaiaWYjRg=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751033036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmsiAUfhY8iE7qCnW4cVjZLK2Blm4dNcSwCRFvPrM6U=;
	b=MJrydzrmhUUbA+Dq+elpdRc8pAAs0TtURLKWY1MpZ6W6h7Cpso1sd27dPGAzaCC31vC57X
	pJTlMK9xPuZrzNW5SEwQ3arPcpcKcWElbqusYNbiSM/cyO4gRKoga1UF/UuTrQvbROFQKG
	1OlpbGqIetrcoUTV+SsDLjtaiaWYjRg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C411913786;
	Fri, 27 Jun 2025 14:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UkDcL8ykXmj2RwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Fri, 27 Jun 2025 14:03:56 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: don't use token set/get accessors for btrfs_item members
Date: Fri, 27 Jun 2025 16:03:50 +0200
Message-ID: <da424e7848ddf493ddcaee420062d06aa3c454a4.1751032655.git.dsterba@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1751032655.git.dsterba@suse.com>
References: <cover.1751032655.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The token versions of set/get accessors will be removed, use the normal
helpers. The btrfs_item members use that interface the most but there
are no real benefits anymore.

This reduces stack consumption on x86_64 release config:

setup_items_for_insert                           -32 (144 -> 112)
__push_leaf_left                                 -32 (176 -> 144)
btrfs_extend_item                                -16 (104 -> 88)
copy_for_split                                   -32 (144 -> 112)
btrfs_del_items                                  -16 (144 -> 128)
btrfs_truncate_item                              -24 (152 -> 128)
__push_leaf_right                                -24 (168 -> 144)

and module size:

   text    data     bss     dec     hex filename
1463615  115665   16088 1595368  1857e8 pre/btrfs.ko
1463413  115665   16088 1595166  18571e post/btrfs.ko

DELTA: -202

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 51 +++++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 2997f24207195c..b8b637267d678d 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -3109,7 +3109,6 @@ static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = right->fs_info;
 	struct extent_buffer *left = path->nodes[0];
 	struct extent_buffer *upper = path->nodes[1];
-	struct btrfs_map_token token;
 	struct btrfs_disk_key disk_key;
 	int slot;
 	u32 i;
@@ -3183,13 +3182,12 @@ static noinline int __push_leaf_right(struct btrfs_trans_handle *trans,
 	copy_leaf_items(right, left, 0, left_nritems - push_items, push_items);
 
 	/* update the item pointers */
-	btrfs_init_map_token(&token, right);
 	right_nritems += push_items;
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		push_space -= btrfs_token_item_size(&token, i);
-		btrfs_set_token_item_offset(&token, i, push_space);
+		push_space -= btrfs_item_size(right, i);
+		btrfs_set_item_offset(right, i, push_space);
 	}
 
 	left_nritems -= push_items;
@@ -3332,7 +3330,6 @@ static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
 	int ret = 0;
 	u32 this_item_size;
 	u32 old_left_item_size;
-	struct btrfs_map_token token;
 
 	if (empty)
 		nr = min(right_nritems, max_slot);
@@ -3380,13 +3377,12 @@ static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
 	old_left_nritems = btrfs_header_nritems(left);
 	BUG_ON(old_left_nritems <= 0);
 
-	btrfs_init_map_token(&token, left);
 	old_left_item_size = btrfs_item_offset(left, old_left_nritems - 1);
 	for (i = old_left_nritems; i < old_left_nritems + push_items; i++) {
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset(&token, i);
-		btrfs_set_token_item_offset(&token, i,
+		ioff = btrfs_item_offset(left, i);
+		btrfs_set_item_offset(left, i,
 		      ioff - (BTRFS_LEAF_DATA_SIZE(fs_info) - old_left_item_size));
 	}
 	btrfs_set_header_nritems(left, old_left_nritems + push_items);
@@ -3407,13 +3403,12 @@ static noinline int __push_leaf_left(struct btrfs_trans_handle *trans,
 				   btrfs_header_nritems(right) - push_items);
 	}
 
-	btrfs_init_map_token(&token, right);
 	right_nritems -= push_items;
 	btrfs_set_header_nritems(right, right_nritems);
 	push_space = BTRFS_LEAF_DATA_SIZE(fs_info);
 	for (i = 0; i < right_nritems; i++) {
-		push_space = push_space - btrfs_token_item_size(&token, i);
-		btrfs_set_token_item_offset(&token, i, push_space);
+		push_space = push_space - btrfs_item_size(right, i);
+		btrfs_set_item_offset(right, i, push_space);
 	}
 
 	btrfs_mark_buffer_dirty(trans, left);
@@ -3527,7 +3522,6 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 	int i;
 	int ret;
 	struct btrfs_disk_key disk_key;
-	struct btrfs_map_token token;
 
 	nritems = nritems - mid;
 	btrfs_set_header_nritems(right, nritems);
@@ -3540,12 +3534,11 @@ static noinline int copy_for_split(struct btrfs_trans_handle *trans,
 
 	rt_data_off = BTRFS_LEAF_DATA_SIZE(fs_info) - btrfs_item_data_end(l, mid);
 
-	btrfs_init_map_token(&token, right);
 	for (i = 0; i < nritems; i++) {
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset(&token, i);
-		btrfs_set_token_item_offset(&token, i, ioff + rt_data_off);
+		ioff = btrfs_item_offset(right, i);
+		btrfs_set_item_offset(right, i, ioff + rt_data_off);
 	}
 
 	btrfs_set_header_nritems(l, mid);
@@ -4011,7 +4004,6 @@ void btrfs_truncate_item(struct btrfs_trans_handle *trans,
 	unsigned int old_size;
 	unsigned int size_diff;
 	int i;
-	struct btrfs_map_token token;
 
 	leaf = path->nodes[0];
 	slot = path->slots[0];
@@ -4034,12 +4026,11 @@ void btrfs_truncate_item(struct btrfs_trans_handle *trans,
 	 * item0..itemN ... dataN.offset..dataN.size .. data0.size
 	 */
 	/* first correct the data pointers */
-	btrfs_init_map_token(&token, leaf);
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset(&token, i);
-		btrfs_set_token_item_offset(&token, i, ioff + size_diff);
+		ioff = btrfs_item_offset(leaf, i);
+		btrfs_set_item_offset(leaf, i, ioff + size_diff);
 	}
 
 	/* shift the data */
@@ -4102,7 +4093,6 @@ void btrfs_extend_item(struct btrfs_trans_handle *trans,
 	unsigned int old_data;
 	unsigned int old_size;
 	int i;
-	struct btrfs_map_token token;
 
 	leaf = path->nodes[0];
 
@@ -4128,12 +4118,11 @@ void btrfs_extend_item(struct btrfs_trans_handle *trans,
 	 * item0..itemN ... dataN.offset..dataN.size .. data0.size
 	 */
 	/* first correct the data pointers */
-	btrfs_init_map_token(&token, leaf);
 	for (i = slot; i < nritems; i++) {
 		u32 ioff;
 
-		ioff = btrfs_token_item_offset(&token, i);
-		btrfs_set_token_item_offset(&token, i, ioff - data_size);
+		ioff = btrfs_item_offset(leaf, i);
+		btrfs_set_item_offset(leaf, i, ioff - data_size);
 	}
 
 	/* shift the data */
@@ -4173,7 +4162,6 @@ static void setup_items_for_insert(struct btrfs_trans_handle *trans,
 	struct btrfs_disk_key disk_key;
 	struct extent_buffer *leaf;
 	int slot;
-	struct btrfs_map_token token;
 	u32 total_size;
 
 	/*
@@ -4201,7 +4189,6 @@ static void setup_items_for_insert(struct btrfs_trans_handle *trans,
 		BUG();
 	}
 
-	btrfs_init_map_token(&token, leaf);
 	if (slot != nritems) {
 		unsigned int old_data = btrfs_item_data_end(leaf, slot);
 
@@ -4219,8 +4206,8 @@ static void setup_items_for_insert(struct btrfs_trans_handle *trans,
 		for (i = slot; i < nritems; i++) {
 			u32 ioff;
 
-			ioff = btrfs_token_item_offset(&token, i);
-			btrfs_set_token_item_offset(&token, i,
+			ioff = btrfs_item_offset(leaf, i);
+			btrfs_set_item_offset(leaf, i,
 						       ioff - batch->total_data_size);
 		}
 		/* shift the items */
@@ -4237,8 +4224,8 @@ static void setup_items_for_insert(struct btrfs_trans_handle *trans,
 		btrfs_cpu_key_to_disk(&disk_key, &batch->keys[i]);
 		btrfs_set_item_key(leaf, &disk_key, slot + i);
 		data_end -= batch->data_sizes[i];
-		btrfs_set_token_item_offset(&token, slot + i, data_end);
-		btrfs_set_token_item_size(&token, slot + i, batch->data_sizes[i]);
+		btrfs_set_item_offset(leaf, slot + i, data_end);
+		btrfs_set_item_size(leaf, slot + i, batch->data_sizes[i]);
 	}
 
 	btrfs_set_header_nritems(leaf, nritems + batch->nr);
@@ -4478,7 +4465,6 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 	if (slot + nr != nritems) {
 		const u32 last_off = btrfs_item_offset(leaf, slot + nr - 1);
 		const int data_end = leaf_data_end(leaf);
-		struct btrfs_map_token token;
 		u32 dsize = 0;
 		int i;
 
@@ -4488,12 +4474,11 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
 		memmove_leaf_data(leaf, data_end + dsize, data_end,
 				  last_off - data_end);
 
-		btrfs_init_map_token(&token, leaf);
 		for (i = slot + nr; i < nritems; i++) {
 			u32 ioff;
 
-			ioff = btrfs_token_item_offset(&token, i);
-			btrfs_set_token_item_offset(&token, i, ioff + dsize);
+			ioff = btrfs_item_offset(leaf, i);
+			btrfs_set_item_offset(leaf, i, ioff + dsize);
 		}
 
 		memmove_leaf_items(leaf, slot, slot + nr, nritems - slot - nr);
-- 
2.49.0


