Return-Path: <linux-btrfs+bounces-14203-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDAEAC2D07
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3C31BA6F4F
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5066C7E9;
	Sat, 24 May 2025 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BfTHegpR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="BfTHegpR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48B214885B
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052538; cv=none; b=L28YF7l4U3Kz9Y/+CrlskVzZctcwVNLf2MpZcgLAomk49v95Po45sHW3AW9+kj27FxG+n9KKF2IpRx1iqScbzl/FgNfXLYGMiBc0jumW4pRRe0SyFNjqGOb9T6LjZnYMt9NF5IiO21Jg7kuaGbXe0iOPnqEC8Ty9SFkq6eNzZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052538; c=relaxed/simple;
	bh=GxPC20Lm7lcB3VxTZXjnUdXZSV8+G8KiDtT/BFUQ6JQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwzkn0qFUcq9DQRJBAX332Xof3DYmJ+Jm5z8mLkuaA1fh/VILY6U6JfxzRLijVRW/qBuI0B7WwbC20hhmguYRoXho1LKf7b2Lq8N/5rAKtK6fJoRcPp5aYEccuF3iBL5Ps9WPje4S/1CdFcanTVUHBPZ7M8i6iHe2hxO2HzFr7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BfTHegpR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=BfTHegpR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60FD521CC4
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0iEqyBERT3GiB9G/uJVcrkbYLxml1dsl1yY5WOFKC0=;
	b=BfTHegpRprReYWJC3wGr1e/88MGhk6/UaqQuoXOk8JM5YaWKDwzEt+YezXcH9lDjDhY4Fs
	MCggoune23kuc36g2RsraARLXzvWWUQmDhUr6qtN6DSTDidDnzphWXzCwM1aNfetsHp/sB
	pGAHAbWOAT8akLvWjupvlyUzdnqvjVo=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P0iEqyBERT3GiB9G/uJVcrkbYLxml1dsl1yY5WOFKC0=;
	b=BfTHegpRprReYWJC3wGr1e/88MGhk6/UaqQuoXOk8JM5YaWKDwzEt+YezXcH9lDjDhY4Fs
	MCggoune23kuc36g2RsraARLXzvWWUQmDhUr6qtN6DSTDidDnzphWXzCwM1aNfetsHp/sB
	pGAHAbWOAT8akLvWjupvlyUzdnqvjVo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A31C41373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ULm5GSQqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/9] btrfs-progs: convert: simplify insert_temp_root_item()
Date: Sat, 24 May 2025 11:38:08 +0930
Message-ID: <a9bf712930ea59e070d15407a40540bd250d2763.1748049973.git.wqu@suse.com>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

The function requires parameters @slot and @itemoff to record where the
next item should land.

But this is overkilled, as after inserting an item, the temporary extent
buffer will have its header nritems and the item pointer updated.

We can use that header nritems and item pointer to get where the next
item should land.

This removes the external counter to record @slot and @itemoff.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/common.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index 0b567da2312e..df68b696f8f5 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -189,17 +189,29 @@ static int setup_temp_extent_buffer(struct extent_buffer *buf,
 	return 0;
 }
 
+static u32 get_item_offset(const struct extent_buffer *eb,
+			   const struct btrfs_mkfs_config *cfg)
+{
+	u32 slot = btrfs_header_nritems(eb);
+
+	if (slot)
+		return btrfs_item_offset(eb, slot - 1);
+	else
+		return cfg->leaf_data_size;
+}
+
 static void insert_temp_root_item(struct extent_buffer *buf,
 				  struct btrfs_mkfs_config *cfg,
-				  int *slot, u32 *itemoff, u64 objectid,
-				  u64 bytenr)
+				  u64 objectid, u64 bytenr)
 {
 	struct btrfs_root_item root_item;
 	struct btrfs_inode_item *inode_item;
 	struct btrfs_disk_key disk_key;
+	u32 slot = btrfs_header_nritems(buf);
+	u32 itemoff = get_item_offset(buf, cfg);
 
-	btrfs_set_header_nritems(buf, *slot + 1);
-	(*itemoff) -= sizeof(root_item);
+	btrfs_set_header_nritems(buf, slot + 1);
+	itemoff -= sizeof(root_item);
 	memset(&root_item, 0, sizeof(root_item));
 	inode_item = &root_item.inode;
 	btrfs_set_stack_inode_generation(inode_item, 1);
@@ -217,13 +229,12 @@ static void insert_temp_root_item(struct extent_buffer *buf,
 	btrfs_set_disk_key_objectid(&disk_key, objectid);
 	btrfs_set_disk_key_offset(&disk_key, 0);
 
-	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, *slot, *itemoff);
-	btrfs_set_item_size(buf, *slot, sizeof(root_item));
+	btrfs_set_item_key(buf, &disk_key, slot);
+	btrfs_set_item_offset(buf, slot, itemoff);
+	btrfs_set_item_size(buf, slot, sizeof(root_item));
 	write_extent_buffer(buf, &root_item,
-			    btrfs_item_ptr_offset(buf, *slot),
+			    btrfs_item_ptr_offset(buf, slot),
 			    sizeof(root_item));
-	(*slot)++;
 }
 
 /*
@@ -252,8 +263,6 @@ static int setup_temp_root_tree(int fd, struct btrfs_mkfs_config *cfg,
 				u64 dev_bytenr, u64 fs_bytenr, u64 csum_bytenr)
 {
 	struct extent_buffer *buf = NULL;
-	u32 itemoff = cfg->leaf_data_size;
-	int slot = 0;
 	int ret;
 
 	/*
@@ -271,14 +280,10 @@ static int setup_temp_root_tree(int fd, struct btrfs_mkfs_config *cfg,
 	if (ret < 0)
 		goto out;
 
-	insert_temp_root_item(buf, cfg, &slot, &itemoff,
-			      BTRFS_EXTENT_TREE_OBJECTID, extent_bytenr);
-	insert_temp_root_item(buf, cfg, &slot, &itemoff,
-			      BTRFS_DEV_TREE_OBJECTID, dev_bytenr);
-	insert_temp_root_item(buf, cfg, &slot, &itemoff,
-			      BTRFS_FS_TREE_OBJECTID, fs_bytenr);
-	insert_temp_root_item(buf, cfg, &slot, &itemoff,
-			      BTRFS_CSUM_TREE_OBJECTID, csum_bytenr);
+	insert_temp_root_item(buf, cfg, BTRFS_EXTENT_TREE_OBJECTID, extent_bytenr);
+	insert_temp_root_item(buf, cfg, BTRFS_DEV_TREE_OBJECTID, dev_bytenr);
+	insert_temp_root_item(buf, cfg, BTRFS_FS_TREE_OBJECTID, fs_bytenr);
+	insert_temp_root_item(buf, cfg, BTRFS_CSUM_TREE_OBJECTID, csum_bytenr);
 
 	ret = write_temp_extent_buffer(fd, buf, root_bytenr, cfg);
 out:
-- 
2.49.0


