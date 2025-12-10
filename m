Return-Path: <linux-btrfs+bounces-19614-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3949CB2004
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 06:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03BB53058FAD
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Dec 2025 05:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C712D0608;
	Wed, 10 Dec 2025 05:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iwvy8EaA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9BC224B0D
	for <linux-btrfs@vger.kernel.org>; Wed, 10 Dec 2025 05:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765345180; cv=none; b=FRI+o/12qWDuP/i5VxcIEloPNl+GexLKzPO9gBw7E+/ap0HLjG1VrwAiEgLO5lUGWIFKeaOvWS0r+7mHNjhR10L0Y/2O2Q64YUJAcQWOMnH2VjJeOgQNfl35uWs4oSW/RWJzD72M7JBgFZUhu1eyJEsfVSFVRAsFZhhL4hiwJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765345180; c=relaxed/simple;
	bh=1IpsbaKJkNIt12nUySpC5g0gtXhkPV1547xO6/6tLOE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XMUr0GOCb5y0ZMluAadKhcHoU8jpLZSdwHM8sVJxSjSIDiV1NeTks7w9ZBeESn4g3mtYmsEPFJriUsvp+ASZGZrOnyrwcyJdCeMikdTOiJwRCs5tGNmsq9MezUQUoxpVOfn17sXfcbghT6CCOFFuwawjLSMU1N99Yy0frOTtbOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iwvy8EaA; arc=none smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765345179; x=1796881179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1IpsbaKJkNIt12nUySpC5g0gtXhkPV1547xO6/6tLOE=;
  b=iwvy8EaAPjHSC2zQCLhNgWJKZgoVhlTBlnj4FuJPUTsNQYvVX+70VwvF
   ykuEAckGgxAXiT90mTS7eSNpCS4D1peufusLWE/yrnvxY5c5SjZ60s8L/
   3+WLXUghBeqzVvUIVCVO2jYDDoMPWblr1dgGnP3cuev8pkhboCBOga+88
   gEn7EjvVTQ9PoTaHM8GySUBDKV+5qcWRxbTGV8VwMfEGsHDEURk5G4SfK
   KSdwn7pgKz9nzDCdTL8rkeVJAior4CMLjdVMNN9A+arIGshYIUqBKOca1
   7QfVkb84JOAWo8clIVtEeNN6rLhwPASwZPRI1GZElSE+GiPXmvIt7bRGt
   w==;
X-CSE-ConnectionGUID: QwvUdr+1RjOL25XpV0v77Q==
X-CSE-MsgGUID: QUn/ZyG6QfGE6VlLFuia1A==
X-IronPort-AV: E=Sophos;i="6.20,263,1758556800"; 
   d="scan'208";a="137601093"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2025 13:39:38 +0800
IronPort-SDR: 6939079a_8SRyOzgmSrGgcAX8CBn4/t6rYx/Ze5szXUnac7Ajhf7a8L0
 ZrEc/JZaFo8YP1hW3YDWzbUzudFDGHpq/x6m6cw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2025 21:39:38 -0800
WDCIronportException: Internal
Received: from neo.dhcp.fujisawa.hgst.com (HELO neo.ad.shared) ([10.89.82.133])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2025 21:39:38 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: rename btrfs_create_block_group_cache to btrfs_create_block_group
Date: Wed, 10 Dec 2025 06:39:32 +0100
Message-ID: <20251210053932.149358-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct btrfs_block_group' used to be called 'struct
btrfs_block_group_cache' but got renamed to btrfs_block_group with
commit 32da5386d9a4 ("btrfs: rename btrfs_block_group_cache").

Rename btrfs_create_block_group_cache() to btrfs_create_block_group() to
reflect that change.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 08b14449fabe..a52642e88585 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2266,7 +2266,7 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 	return 0;
 }
 
-static struct btrfs_block_group *btrfs_create_block_group_cache(
+static struct btrfs_block_group *btrfs_create_block_group(
 		struct btrfs_fs_info *fs_info, u64 start)
 {
 	struct btrfs_block_group *cache;
@@ -2370,7 +2370,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 
 	ASSERT(key->type == BTRFS_BLOCK_GROUP_ITEM_KEY);
 
-	cache = btrfs_create_block_group_cache(info, key->objectid);
+	cache = btrfs_create_block_group(info, key->objectid);
 	if (!cache)
 		return -ENOMEM;
 
@@ -2491,7 +2491,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 		struct btrfs_block_group *bg;
 
 		map = rb_entry(node, struct btrfs_chunk_map, rb_node);
-		bg = btrfs_create_block_group_cache(fs_info, map->start);
+		bg = btrfs_create_block_group(fs_info, map->start);
 		if (!bg) {
 			ret = -ENOMEM;
 			break;
@@ -2886,7 +2886,7 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 
 	btrfs_set_log_full_commit(trans);
 
-	cache = btrfs_create_block_group_cache(fs_info, chunk_offset);
+	cache = btrfs_create_block_group(fs_info, chunk_offset);
 	if (!cache)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.52.0


