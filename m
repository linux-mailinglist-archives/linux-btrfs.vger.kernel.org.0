Return-Path: <linux-btrfs+bounces-256-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4887F33D0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5431D2830F5
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Nov 2023 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A65B20B;
	Tue, 21 Nov 2023 16:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LdRK/UFB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EAC1A1;
	Tue, 21 Nov 2023 08:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700584360; x=1732120360;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4x9R0AUQK9GRVyrX+VtnFLrU6NC+W4I+bSE1UwCceA4=;
  b=LdRK/UFBflkZ7wkdBupPi3NgHGOjw6tc8f6cPcnTwb3gg6Dw8a7arE55
   zFR+P7C5RrISc8cq6lF/L4Tokma2onD45zq+3IE8IcEtuwoEMDpf/3AsQ
   S/zfAi97+Oh7GVojy2uK5kB9m7bfH21XKEz+6YRdj0wJsDrYZ6dhJQ+6F
   C9nzYPWarllCg3cDtkgWY7i233XH33Y5BtU1hx4JwgVL3zRpZHRT/fAIl
   ZnYJOyh1udBmyw/juCNL4y4x8S9VaK/IvXw+2NtBsXE9Or9aKxYN2Y4dZ
   qDMBU3LRNZ0rx5OssfimMFfFpYnueF89Gu+IXPFknIa1gCnSAiZjYn20a
   w==;
X-CSE-ConnectionGUID: zoB9iurbSQyP9XntX2r2Bg==
X-CSE-MsgGUID: i+5U2UjVS2K2fnllLZb3qA==
X-IronPort-AV: E=Sophos;i="6.04,216,1695657600"; 
   d="scan'208";a="3076041"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2023 00:32:39 +0800
IronPort-SDR: TAkEFTY1z1bdNrIVPgm88VV+nzcUD0QS/+E/vnPfnzXj+RlPfJX8OVuKFuuZP3lCCipmczmcD1
 t/QeMS0q4BWzLiPw76pp+lApx2b0c9jA2s/XLZpv/jNvjVbOOeovvIobhykLgdQ9pWb0X2KryJ
 bTnTBdlAI8XLixibQWAEPyoEgZOWo6c4FQ4RZ2q9Hta2tlPx3nL5/7XmmqTuMCLQnOP+tagaD/
 30G7Auu6AjdhIsUhcodnFNF7tzuxEP8dc4370pVNMmMSgYXd2ZN++Kh1HFDoLrite0yB+EC651
 b0c=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2023 07:38:17 -0800
IronPort-SDR: GR1ZMbJhEH2SHBk4dtqaQNpLlAoNwKPwcEmFj3egwXbL6nrVNUVXKU1RjdDyhEuWBYo7sBam57
 0FLqajz9AICXWEUb7rmxVCROQB68wAulgzqAR9Y+wullZrvfa2Y34sH+9pShoejEJ3YygcWviz
 GPPLSm5QtfG938z6nZZMdWRz33kbnDShc+6c030L+tpcfJ+MoDsSfLBADSD58nNGcOF7i5Mmwd
 s2VloPU+6OSWzMVHaCPUrxwza33lVTHHmB6045tv8DjxFaPzJC5fELu0tIfzi8+oX8RgqVwur7
 mT4=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Nov 2023 08:32:39 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Tue, 21 Nov 2023 08:32:32 -0800
Subject: [PATCH 3/5] btrfs: remove now unneeded btrfs_redirty_list_add
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-josef-generic-163-v1-3-049e37185841@wdc.com>
References: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
In-Reply-To: <20231121-josef-generic-163-v1-0-049e37185841@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700584354; l=3915;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=4x9R0AUQK9GRVyrX+VtnFLrU6NC+W4I+bSE1UwCceA4=;
 b=WltesEGdCChgU2zlttMM6Os6XzuHwaithQPvnaT3s4u8tUjmDjB7YY0/3dfGrvaHQbd1da6Te
 +r2QE6li6P9BFUff+3aYvgGSt3fMdpkro4lye6FYnW/3Ml8HauQ3CcG
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we're not clearing the dirty flag off of extent_buffers in zoned mode,
all that is left of btrfs_redirty_list_add() is a memzero() and some
ASSERT()ions.

As we're also memzero()ing the buffer on write-out btrfs_redirty_list_add()
has become obsolete and can be removed.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c |  5 +----
 fs/btrfs/tree-log.c    |  1 -
 fs/btrfs/zoned.c       | 17 -----------------
 fs/btrfs/zoned.h       |  5 -----
 4 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f6cbbec539fa..6beff11e692e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3445,10 +3445,8 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 
 		if (root_id != BTRFS_TREE_LOG_OBJECTID) {
 			ret = check_ref_cleanup(trans, buf->start);
-			if (!ret) {
-				btrfs_redirty_list_add(trans->transaction, buf);
+			if (!ret)
 				goto out;
-			}
 		}
 
 		cache = btrfs_lookup_block_group(fs_info, buf->start);
@@ -3479,7 +3477,6 @@ void btrfs_free_tree_block(struct btrfs_trans_handle *trans,
 			must_pin = true;
 
 		if (must_pin || btrfs_is_zoned(fs_info)) {
-			btrfs_redirty_list_add(trans->transaction, buf);
 			pin_down_extent(trans, cache, buf->start, buf->len, 1);
 			btrfs_put_block_group(cache);
 			goto out;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 7d6729d9fd2f..bee065851185 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2575,7 +2575,6 @@ static int clean_log_buffer(struct btrfs_trans_handle *trans,
 		ret = btrfs_pin_reserved_extent(trans, eb);
 		if (ret)
 			return ret;
-		btrfs_redirty_list_add(trans->transaction, eb);
 	} else {
 		unaccount_log_buffer(eb->fs_info, eb->start);
 	}
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 117e041bdc7a..931ccc839152 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1715,23 +1715,6 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache)
 	cache->zone_unusable = unusable;
 }
 
-void btrfs_redirty_list_add(struct btrfs_transaction *trans,
-			    struct extent_buffer *eb)
-{
-	if (!btrfs_is_zoned(eb->fs_info) ||
-	    btrfs_header_flag(eb, BTRFS_HEADER_FLAG_WRITTEN))
-		return;
-
-	ASSERT(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
-	ASSERT(test_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags));
-
-	memzero_extent_buffer(eb, 0, eb->len);
-	set_bit(EXTENT_BUFFER_CANCELLED, &eb->bflags);
-	set_extent_buffer_dirty(eb);
-	set_extent_bit(&trans->dirty_pages, eb->start, eb->start + eb->len - 1,
-			EXTENT_DIRTY, NULL);
-}
-
 bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 {
 	u64 start = (bbio->bio.bi_iter.bi_sector << SECTOR_SHIFT);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index b9cec523b778..7bfe1d677310 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -59,8 +59,6 @@ int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new);
 void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
-void btrfs_redirty_list_add(struct btrfs_transaction *trans,
-			    struct extent_buffer *eb);
 bool btrfs_use_zone_append(struct btrfs_bio *bbio);
 void btrfs_record_physical_zoned(struct btrfs_bio *bbio);
 int btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
@@ -180,9 +178,6 @@ static inline int btrfs_load_block_group_zone_info(
 
 static inline void btrfs_calc_zone_unusable(struct btrfs_block_group *cache) { }
 
-static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
-					  struct extent_buffer *eb) { }
-
 static inline bool btrfs_use_zone_append(struct btrfs_bio *bbio)
 {
 	return false;

-- 
2.41.0


