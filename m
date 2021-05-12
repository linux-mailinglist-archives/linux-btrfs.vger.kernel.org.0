Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B45337BF24
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 May 2021 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbhELODE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 May 2021 10:03:04 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:27795 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhELODC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 May 2021 10:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620828113; x=1652364113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnr+huO5U6ze2I8PbbZBLg/scjYOpDQaHL7pVLjXnnM=;
  b=eFY9oiQiNT6T1MBC7wvoz68mEcn1LqFH/qEVp+oys5tpJgqm83axAtnb
   nzMsMCbMkWYJBByUNt/L61tSdURvFhRzKpB6PCC8nsJXkv5E9SmxQ0t3Q
   vyBvF7J19fBYmsqiU5XR8d83kh2W6DHVO6mlRzKU/vJ+j2x9QY6w3cV/d
   +IscZY/VryShgxGm4/z3CIZ7oRvh66pvPkIrJ3qm/VPcfW1iqyOdo8rH+
   LcWp5OzhqTj9j+4V5FrpUrXQB5TLYJQxD4LYktl5xjnAO+HzpJzhSyBCo
   SeR4E9tI79vT+XT4GnFhTdHJ2TSk9mliuKnfsWReiS95J7rlMmMZPdBN5
   w==;
IronPort-SDR: ATAJFcoJlbVJ1H+fDXogKae+TmSBpAC1Z3baPycBIbR7iJgEoR9MRZ7kQKEr7LqoMWRikIA+wZ
 2r7VKARlj26L35iukMqgDjWwWt0CIk0M6oHqtkBjUnqKbAQUsUaow3xG6BDMU5uQr0511wM+08
 pbNZXdlqSgPRr82N9ikDlaSQT+rWqqAWAJ6+8x2/YQyJBECsLfpy6Y8eCT5NvAUNcaRU4djSrE
 xka1iMRH30DpgUuhKUPsDJ1qdpiXneKWkK8j+9L6tlxBlQfWImT04A4NlFOoVdGQJs2Ls8J2BV
 ejE=
X-IronPort-AV: E=Sophos;i="5.82,293,1613404800"; 
   d="scan'208";a="167902772"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2021 22:01:52 +0800
IronPort-SDR: KCChzNk92Q0nDgnVUJAoDdGim4lVtMcNBZV/SQZ9p2abPQOcOmVrPckHipUb/BWrrgm62wPoXh
 0KFPl+dFKcx+VDte5b04OI0VU3ttHnDqiSrdAIRCwEYAFnezWX8HawSWanK3C5HP6Zns1Qo1C2
 1rwyn+EyI/ha05Y5rDRvNxhIRz99kbQKr3jIpcMlD/ynuUHydwH3bAd4qd2U5pIFmHySDMXRkD
 kCkPkz4YJxneQO7gyd0UFwzr9myNw63UfkOO2FD/r2OfYXoI43zVE/WkvPLSuPXUO9Toc3F7xv
 1pCcjvKAlU6yFQdZOVohQb5F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2021 06:40:27 -0700
IronPort-SDR: bB9BYF41kS6ZNcPjYORBG9wHARBxB3R6+FIfrvzKOxzmJ4Oj8a16Pfdoq2YfiBECoOJjkir6E+
 BNGYP6bUym3dxmcjzha4RIj8Oy6RqmpnIUhwTjlYivXxzVWEQSXvex+jk+GBY4Sez/pJz19XPw
 L2KAacXbrHKO5OIxeHUEy68lty40EC1DBllXAaSx01cp8Byq07R+JGwXtfuPxCIIH3UGB4IxoV
 3Y0YeXEbycxMYkex7px/MHiyEnGWsN/xxHL4hc6uMyDKXoy0iKwcdHUzt4ydMfr1QZlg4Legn4
 QHI=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 May 2021 07:01:53 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: zoned: pass start block to btrfs_use_zone_append
Date:   Wed, 12 May 2021 23:01:39 +0900
Message-Id: <337436d98896ae85a82125d6fbc09f5ee966fe11.1620824721.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1620824721.git.johannes.thumshirn@wdc.com>
References: <cover.1620824721.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_use_zone_append only needs the passed in extent_map's block_start
member, so there's no need to pass in the full extent map.

This also enables the use of btrfs_use_zone_append in places where we only
have a start byte but no extent_map.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/inode.c     | 2 +-
 fs/btrfs/zoned.c     | 4 ++--
 fs/btrfs/zoned.h     | 5 ++---
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0ce419512ed4..74ba2e1a3927 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3753,7 +3753,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		/* Note that em_end from extent_map_end() is exclusive */
 		iosize = min(em_end, end + 1) - cur;
 
-		if (btrfs_use_zone_append(inode, em))
+		if (btrfs_use_zone_append(inode, em->block_start))
 			opf = REQ_OP_ZONE_APPEND;
 
 		free_extent_map(em);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c6164ae16e2a..33f14573f2ec 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7786,7 +7786,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
-	if (write && btrfs_use_zone_append(BTRFS_I(inode), em))
+	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
 		iomap->flags |= IOMAP_F_ZONE_APPEND;
 
 	free_extent_map(em);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c41373a92476..b9d5579a578d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1296,7 +1296,7 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	spin_unlock(&trans->releasing_ebs_lock);
 }
 
-bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
+bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_block_group *cache;
@@ -1311,7 +1311,7 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
 	if (!is_data_inode(&inode->vfs_inode))
 		return false;
 
-	cache = btrfs_lookup_block_group(fs_info, em->block_start);
+	cache = btrfs_lookup_block_group(fs_info, start);
 	ASSERT(cache);
 	if (!cache)
 		return false;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 5e41a74a9cb2..e55d32595c2c 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -53,7 +53,7 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
-bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em);
+bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start);
 void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
 				 struct bio *bio);
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
@@ -152,8 +152,7 @@ static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 
-static inline bool btrfs_use_zone_append(struct btrfs_inode *inode,
-					 struct extent_map *em)
+static inline bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 {
 	return false;
 }
-- 
2.31.1

