Return-Path: <linux-btrfs+bounces-5123-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE9F8CA2EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 21:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072DF1F2208E
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 May 2024 19:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7482F139593;
	Mon, 20 May 2024 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SUdv9cp6";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="SUdv9cp6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5813956C
	for <linux-btrfs@vger.kernel.org>; Mon, 20 May 2024 19:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716234750; cv=none; b=MmYX7Veuhxy/ir+EA4fTUBtDv5n0pN9e2vdPFtU1O9TIinZZ/YnCxr7AMBLQ13QiNwg6usdMua7FK/PR5OCmExE3vQcw1LvkSe7BMorsXuMopMiKGLKc/cPKY8cFiia9VCF9pcEkOozmkCLmKqPK6ypcLFOtrK75NsMDFaEbk5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716234750; c=relaxed/simple;
	bh=xSFP6HTsslEGyni0bUYIXAJZP7yKVCHiZXgrbFVX088=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl4xYguQC4W+QD5fZuGosc6jzK2vJeBrDm/vZGN1JhMZHctHnMLMPhNgAOXBzHPvMVkB921tsOktw4lJmqsopso6CH8kbxrBz0eo/gKCM7q/CPDcZveR9S+r+SncH161NUGVIpvkWRReblyIvBBhJRk0KDONIJeWRR4T4X06Cpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SUdv9cp6; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=SUdv9cp6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 13DDB33EBE;
	Mon, 20 May 2024 19:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwy7b2KcUtkk739VeI7Ogwt7F2F7UMfsxgSe2LrbMaw=;
	b=SUdv9cp6IY+Kg9Ln1/1zEmD03SqLwVF7CPYwoSeHMVNf1cx976wgsWoPTu5C0laNtd1elE
	kAyR6FrTG+bw0EGUBf3L6vrDgawuVsm1mIwdfEMrKJn4T5BVb+mA/Mzfx2K0bg3D9loHA4
	Z2R3QpCPqa5cajWhyhTpO8yBJ0E+zi8=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=SUdv9cp6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716234747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qwy7b2KcUtkk739VeI7Ogwt7F2F7UMfsxgSe2LrbMaw=;
	b=SUdv9cp6IY+Kg9Ln1/1zEmD03SqLwVF7CPYwoSeHMVNf1cx976wgsWoPTu5C0laNtd1elE
	kAyR6FrTG+bw0EGUBf3L6vrDgawuVsm1mIwdfEMrKJn4T5BVb+mA/Mzfx2K0bg3D9loHA4
	Z2R3QpCPqa5cajWhyhTpO8yBJ0E+zi8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0DA5113A6B;
	Mon, 20 May 2024 19:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y7VVA/upS2bvRQAAD6G6ig
	(envelope-from <dsterba@suse.com>); Mon, 20 May 2024 19:52:27 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 3/6] btrfs: use for-local variabls that shadow function variables
Date: Mon, 20 May 2024 21:52:26 +0200
Message-ID: <6cebc0c327002303ed351b262396aefbf68cff1b.1716234472.git.dsterba@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1716234472.git.dsterba@suse.com>
References: <cover.1716234472.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 13DDB33EBE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

We've started to use for-loop local variables and in a few places this
shadows a function variable. Convert a few cases reported by 'make W=2'.
If applicable also change the style to post-increment, that's the
preferred one.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/qgroup.c  | 11 +++++------
 fs/btrfs/volumes.c |  9 +++------
 fs/btrfs/zoned.c   |  8 +++-----
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index fc2a7ea26354..a94a5b87b042 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3216,7 +3216,6 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 			 struct btrfs_qgroup_inherit *inherit)
 {
 	int ret = 0;
-	int i;
 	u64 *i_qgroups;
 	bool committing = false;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
@@ -3273,7 +3272,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		i_qgroups = (u64 *)(inherit + 1);
 		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
 		       2 * inherit->num_excl_copies;
-		for (i = 0; i < nums; ++i) {
+		for (int i = 0; i < nums; i++) {
 			srcgroup = find_qgroup_rb(fs_info, *i_qgroups);
 
 			/*
@@ -3300,7 +3299,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	 */
 	if (inherit) {
 		i_qgroups = (u64 *)(inherit + 1);
-		for (i = 0; i < inherit->num_qgroups; ++i, ++i_qgroups) {
+		for (int i = 0; i < inherit->num_qgroups; i++, i_qgroups++) {
 			if (*i_qgroups == 0)
 				continue;
 			ret = add_qgroup_relation_item(trans, objectid,
@@ -3386,7 +3385,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		goto unlock;
 
 	i_qgroups = (u64 *)(inherit + 1);
-	for (i = 0; i < inherit->num_qgroups; ++i) {
+	for (int i = 0; i < inherit->num_qgroups; i++) {
 		if (*i_qgroups) {
 			ret = add_relation_rb(fs_info, qlist_prealloc[i], objectid,
 					      *i_qgroups);
@@ -3406,7 +3405,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		++i_qgroups;
 	}
 
-	for (i = 0; i <  inherit->num_ref_copies; ++i, i_qgroups += 2) {
+	for (int i = 0; i < inherit->num_ref_copies; i++, i_qgroups += 2) {
 		struct btrfs_qgroup *src;
 		struct btrfs_qgroup *dst;
 
@@ -3427,7 +3426,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 		/* Manually tweaking numbers certainly needs a rescan */
 		need_rescan = true;
 	}
-	for (i = 0; i <  inherit->num_excl_copies; ++i, i_qgroups += 2) {
+	for (int i = 0; i <  inherit->num_excl_copies; i++, i_qgroups += 2) {
 		struct btrfs_qgroup *src;
 		struct btrfs_qgroup *dst;
 
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7c9d68b1ba69..3f70f727dacf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5623,8 +5623,6 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	u64 start = ctl->start;
 	u64 type = ctl->type;
 	int ret;
-	int i;
-	int j;
 
 	map = btrfs_alloc_chunk_map(ctl->num_stripes, GFP_NOFS);
 	if (!map)
@@ -5639,8 +5637,8 @@ static struct btrfs_block_group *create_chunk(struct btrfs_trans_handle *trans,
 	map->sub_stripes = ctl->sub_stripes;
 	map->num_stripes = ctl->num_stripes;
 
-	for (i = 0; i < ctl->ndevs; ++i) {
-		for (j = 0; j < ctl->dev_stripes; ++j) {
+	for (int i = 0; i < ctl->ndevs; i++) {
+		for (int j = 0; j < ctl->dev_stripes; j++) {
 			int s = i * ctl->dev_stripes + j;
 			map->stripes[s].dev = devices_info[i].dev;
 			map->stripes[s].physical = devices_info[i].dev_offset +
@@ -6618,7 +6616,6 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 	struct btrfs_chunk_map *map;
 	struct btrfs_io_geometry io_geom = { 0 };
 	u64 map_offset;
-	int i;
 	int ret = 0;
 	int num_copies;
 	struct btrfs_io_context *bioc = NULL;
@@ -6764,7 +6761,7 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
 		 * For all other non-RAID56 profiles, just copy the target
 		 * stripe into the bioc.
 		 */
-		for (i = 0; i < io_geom.num_stripes; i++) {
+		for (int i = 0; i < io_geom.num_stripes; i++) {
 			ret = set_io_stripe(fs_info, logical, length,
 					    &bioc->stripes[i], map, &io_geom);
 			if (ret < 0)
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index dde4a0a34037..e9087264f3e3 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -87,9 +87,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 	bool empty[BTRFS_NR_SB_LOG_ZONES];
 	bool full[BTRFS_NR_SB_LOG_ZONES];
 	sector_t sector;
-	int i;
 
-	for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+	for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
 		ASSERT(zones[i].type != BLK_ZONE_TYPE_CONVENTIONAL);
 		empty[i] = (zones[i].cond == BLK_ZONE_COND_EMPTY);
 		full[i] = sb_zone_is_full(&zones[i]);
@@ -121,9 +120,8 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		struct address_space *mapping = bdev->bd_inode->i_mapping;
 		struct page *page[BTRFS_NR_SB_LOG_ZONES];
 		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
-		int i;
 
-		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+		for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
 			u64 zone_end = (zones[i].start + zones[i].capacity) << SECTOR_SHIFT;
 			u64 bytenr = ALIGN_DOWN(zone_end, BTRFS_SUPER_INFO_SIZE) -
 						BTRFS_SUPER_INFO_SIZE;
@@ -144,7 +142,7 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 		else
 			sector = zones[0].start;
 
-		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++)
+		for (int i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++)
 			btrfs_release_disk_super(super[i]);
 	} else if (!full[0] && (empty[1] || full[1])) {
 		sector = zones[0].wp;
-- 
2.45.0


