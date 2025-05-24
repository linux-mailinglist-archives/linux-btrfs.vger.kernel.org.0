Return-Path: <linux-btrfs+bounces-14200-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E4AC2D05
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57FD7A243A6
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F230191F95;
	Sat, 24 May 2025 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QbPOKcL2";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QbPOKcL2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9542E18C933
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052530; cv=none; b=mW8vXckPtZeYKSL7HBQYWaDMMgo7XIoZwRZkK/jMuCdVSwG69q/WY5bIUDF2+mOZ3UJD0VI0gY70hBQMpoo3AjnXYokTOGL5/7z6TuVSLDiIdJ3JZVj2nqINz7OfO4bv/hAdvmSUquW2qRrWwO9EEhEoll1yua6MNhgOSucWM2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052530; c=relaxed/simple;
	bh=/2ePOiqjF1WOtcQatmL4/azzCKb+P8vBR3h6vs4BeCM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dZOld+9HU2I7DnM+wrAVlaeiA5iMlG5+nRen+0IGXv11nQt8bBI7Bn7kY0lXZ+WlcIXxSbILqNz+u4Rh36U/uywFM1lDFDLcZ1sH1f9UoSckLqELe6DZz4se2jNdV2x5v4iqeuWJyKKwpmJWa2ZaJ2NA5Pg+QaOHXG+piU2nqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QbPOKcL2; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QbPOKcL2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6E461FCDA
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xx80GXRcztwizY3AV1uJELdLJ83rjh4xsKHCeUtu+k=;
	b=QbPOKcL2omFzaKJRUz6WAdChnvZlt2UpMdZGarLd1nYdAhei6NgSF1GrCAsWCuZ4SzV2rn
	GRgpvjFnW3QYBC5JQA0rx6TPaYcnWOX6TYjANdFJuOYkydWZa97y8oElMx6sEAL3ekre2n
	WJKvQx3PTAGnaQijiZX0RccY0j0/eNI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=QbPOKcL2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Xx80GXRcztwizY3AV1uJELdLJ83rjh4xsKHCeUtu+k=;
	b=QbPOKcL2omFzaKJRUz6WAdChnvZlt2UpMdZGarLd1nYdAhei6NgSF1GrCAsWCuZ4SzV2rn
	GRgpvjFnW3QYBC5JQA0rx6TPaYcnWOX6TYjANdFJuOYkydWZa97y8oElMx6sEAL3ekre2n
	WJKvQx3PTAGnaQijiZX0RccY0j0/eNI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B3A91373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGEhMCYqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:38 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/9] btrfs-progs: convert: simplify insert_temp_dev_extent()
Date: Sat, 24 May 2025 11:38:10 +0930
Message-ID: <59d1ea308e5a6f003447cb3f27ac22cd3e8b5914.1748049973.git.wqu@suse.com>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: C6E461FCDA
X-Spam-Level: 
X-Spam-Flag: NO

This function requires parameters @slot and @itemoff to record where the
next item should land.

But this is overkilled, as after inserting an item, the temporary extent
buffer will have its header nritems and the item pointer updated.

We can use that header nritems and item pointer to get where the next
item should land.

This removes the external counter to record @slot and @itemoff.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/common.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index b21ad4c8fa7b..a9d3b395b37b 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -459,28 +459,29 @@ out:
 }
 
 static void insert_temp_dev_extent(struct extent_buffer *buf,
-				   int *slot, u32 *itemoff, u64 start, u64 len)
+				   struct btrfs_mkfs_config *cfg, u64 start, u64 len)
 {
 	struct btrfs_dev_extent *dev_extent;
 	struct btrfs_disk_key disk_key;
+	u32 slot = btrfs_header_nritems(buf);
+	u32 itemoff = get_item_offset(buf, cfg);
 
-	btrfs_set_header_nritems(buf, *slot + 1);
-	(*itemoff) -= sizeof(*dev_extent);
+	btrfs_set_header_nritems(buf, slot + 1);
+	itemoff -= sizeof(*dev_extent);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_DEV_EXTENT_KEY);
 	btrfs_set_disk_key_objectid(&disk_key, 1);
 	btrfs_set_disk_key_offset(&disk_key, start);
-	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, *slot, *itemoff);
-	btrfs_set_item_size(buf, *slot, sizeof(*dev_extent));
+	btrfs_set_item_key(buf, &disk_key, slot);
+	btrfs_set_item_offset(buf, slot, itemoff);
+	btrfs_set_item_size(buf, slot, sizeof(*dev_extent));
 
-	dev_extent = btrfs_item_ptr(buf, *slot, struct btrfs_dev_extent);
+	dev_extent = btrfs_item_ptr(buf, slot, struct btrfs_dev_extent);
 	btrfs_set_dev_extent_chunk_objectid(buf, dev_extent,
 					    BTRFS_FIRST_CHUNK_TREE_OBJECTID);
 	btrfs_set_dev_extent_length(buf, dev_extent, len);
 	btrfs_set_dev_extent_chunk_offset(buf, dev_extent, start);
 	btrfs_set_dev_extent_chunk_tree(buf, dev_extent,
 					BTRFS_CHUNK_TREE_OBJECTID);
-	(*slot)++;
 }
 
 static int setup_temp_dev_tree(int fd, struct btrfs_mkfs_config *cfg,
@@ -488,8 +489,6 @@ static int setup_temp_dev_tree(int fd, struct btrfs_mkfs_config *cfg,
 			       u64 dev_bytenr)
 {
 	struct extent_buffer *buf = NULL;
-	u32 itemoff = cfg->leaf_data_size;
-	int slot = 0;
 	int ret;
 
 	/* Must ensure SYS chunk starts before META chunk */
@@ -505,9 +504,9 @@ static int setup_temp_dev_tree(int fd, struct btrfs_mkfs_config *cfg,
 				       BTRFS_DEV_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
-	insert_temp_dev_extent(buf, &slot, &itemoff, sys_chunk_start,
+	insert_temp_dev_extent(buf, cfg, sys_chunk_start,
 			       BTRFS_MKFS_SYSTEM_GROUP_SIZE);
-	insert_temp_dev_extent(buf, &slot, &itemoff, meta_chunk_start,
+	insert_temp_dev_extent(buf, cfg, meta_chunk_start,
 			       BTRFS_CONVERT_META_GROUP_SIZE);
 	ret = write_temp_extent_buffer(fd, buf, dev_bytenr, cfg);
 out:
-- 
2.49.0


