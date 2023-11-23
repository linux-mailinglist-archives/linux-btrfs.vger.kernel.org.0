Return-Path: <linux-btrfs+bounces-325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4F27F634F
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 16:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB46C1C20EAE
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Nov 2023 15:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783C3D98C;
	Thu, 23 Nov 2023 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qKFFCrTM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F352119BB;
	Thu, 23 Nov 2023 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700754515; x=1732290515;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HOPXPFmYGX+fut8IJwT4SBFWWVBiLfZukFL078WjfiM=;
  b=qKFFCrTMJLAKNXOmg0w5aPJH2wDR+rZv96RtSmvUdSKoCTpf4K3sxCTb
   N56NUx1BSx/BxKGFYWn0NEsAhFs8Co1/HSZKbeH7GWIB4rFYnpIlci6s5
   0RwA0I6T+bZx0NgkUqJFIlfvp39gSum6fjkW+SZQHiqD90YwQ/2G1xUH0
   l7POyvid6je/vwT51eTjoy6MDG6t/wEjCQRCjWXZCTVtAr0UUv3V9pdVy
   dR294BHPq5g7R+X52/3ItB+AqNY9At9YPmDfgdOQgfDefMRgQC7y2c5na
   mdS6U6dLuCkisany3NiTciKMKXnx1nZMPj5idXIWOgwplFaq351IL51KN
   A==;
X-CSE-ConnectionGUID: 8g76Me+lSqOa0UHTWNox7Q==
X-CSE-MsgGUID: /rJcyYQkQZqGU36K81u0Gw==
X-IronPort-AV: E=Sophos;i="6.04,222,1695657600"; 
   d="scan'208";a="3212875"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Nov 2023 23:47:29 +0800
IronPort-SDR: ZexTaF7uWBJhCRTveBwUZshhKEJRzyspGrgwZ/RoueqGaCSCiGl4WJpjF/0Wl4wpZqb/8Arlke
 u1dY0QXPs5Q0PadUskqNEmrEMSUedrW89wjAg3CftAkFjESm8uqxSlehg6FBKom96ML5DaaN47
 RommXjoTZtNO5DTFndIuhUZKgbCcyYrmHlNbms0fQnZOvB2mkOI4L/3vMuRuG3yLKC7PiiFvY9
 1hV3mHEv+O8acLKkUN75fO8a2Skg96wAcdFgjYbBIbSY2aEAv2WIrffBBkA9msx6S0KEIW+ipK
 LB4=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 06:53:05 -0800
IronPort-SDR: 4gWleuQO67fJvwyIVA88tf4O/Dey0Do5vlLfrzVDp4ztY/53HAoG2L8RaKoQxUVteukOjOgPdq
 DCbLRrxrCQvUsureKTV+gWqCwjns5hE0RgH1/SASaw1gH1aBGywdS37zYofD4E742Ca+WGHWq9
 EKyFBVJhrZUyd43GcPQuLyicvfI2Ry629Xf51wSq1oeYCBCkJUVZpa/t9KZnmTTZTPUelYqibm
 pMibdUG4OCvbeaQ7VjyiDVsuXi31QlFnukDnDHbWzkI6dFU4BintgX/FXx2swREqYXattKcIUC
 GaI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Nov 2023 07:47:28 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date: Thu, 23 Nov 2023 07:47:17 -0800
Subject: [PATCH v2 3/5] btrfs: remove now unneeded btrfs_redirty_list_add
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231123-josef-generic-163-v2-3-ed1a79a8e51e@wdc.com>
References: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
In-Reply-To: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
To: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Christoph Hellwig <hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700754443; l=4017;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=HOPXPFmYGX+fut8IJwT4SBFWWVBiLfZukFL078WjfiM=;
 b=PpgMqJdGC4GG6UrKRlG1b2nMBMiBzQ6QtGHv2seNaU/eGKxs5GbMloS7B2MAK46bcY6JpFTNy
 Fqvz3MSciDQAV0XVoIzaESI4b1cgrRxj0mAuuPC+6aYNMGb7N3BAyiZ
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=

Now that we're not clearing the dirty flag off of extent_buffers in zoned mode,
all that is left of btrfs_redirty_list_add() is a memzero() and some
ASSERT()ions.

As we're also memzero()ing the buffer on write-out btrfs_redirty_list_add()
has become obsolete and can be removed.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent-tree.c |  5 +----
 fs/btrfs/tree-log.c    |  1 -
 fs/btrfs/zoned.c       | 17 -----------------
 fs/btrfs/zoned.h       |  5 -----
 4 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2d8379d34a24..4044102271e9 100644
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
index ed8e002b33e7..931ccc839152 100644
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
-	ASSERT(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
-
-	memzero_extent_buffer(eb, 0, eb->len);
-	set_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags);
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


