Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620DA7A0A64
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Sep 2023 18:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbjINQHe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Sep 2023 12:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241581AbjINQHQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Sep 2023 12:07:16 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9061BDD;
        Thu, 14 Sep 2023 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694707632; x=1726243632;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QzXsAiN8EWNcEnSNzBlMi5nDNJGLElkV/zgsPabPAFk=;
  b=XgBoEToxR4enrl2IRlYv4XWVL1uMZU90IQ3GXQ0jJ+un9KpQxZdRtpWU
   3n5cYdwp/FDvZnI+o6aNxcz5iutgjayRBPKEFBAwJ0Gf/QNeME/u/32Xh
   t1Yj/XSqvs9rBs+mv+tLtugmMkU+WvRzAtfgwBdALHohYlEAUX+Gc03h0
   31TUt+286RLj5zpwzyoney6tl/J4BUs66t4xqzi1R/fDffHKlBY+/VKeZ
   goPaf85uHlQgwYZ+AcLaA3Gaqk5Fbvj2fowW/3xPf2115Hq6AA/EkYXsc
   B4XE6MJVyZaa3+iscQxe2hyEYbJjhSXl0vmrJDOoRX+urvwr/X6TdEjfW
   A==;
X-CSE-ConnectionGUID: UUgP3R+eQ4eMq4oF2gywXg==
X-CSE-MsgGUID: mGNLmd34SMWv39U4JO23YQ==
X-IronPort-AV: E=Sophos;i="6.02,146,1688400000"; 
   d="scan'208";a="248490543"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2023 00:07:11 +0800
IronPort-SDR: 32v1Uifsi9+m/eZCZmCDlM1oO3T2N2V3wFI160VNgGt6o2A7ik0n7CLv9qtcSCJJubIB/K1rIB
 l7EA1ac/mFyHaMlMy/RPPLJNreM9ktjvKyK5tBeV5IS29gPLFsL/oIwm9BVpH5aLZLPjPlQpd+
 kqaCvT8KU37Oage8ZEvB8oJw1aXs1jm28sBdD3K28XR/SvUZi426bCkq27vONNC20lJpqx8WGZ
 xufNnlUoaefCegD+ybiVRVQ5X4wfnLQ9aj0WZqdTgIcnp6v43PMA4EUYHMKT1+Nq1Adnm6iIem
 rlQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2023 08:14:13 -0700
IronPort-SDR: CHBOVx2lN4ewmH41rtQPbi1A1xy2WUYm04VkovTYO5ROAiNoknymasgP0RaizDozipFIC9HO1j
 Crg/AndAC/n+GRpvfuC5PKIpfXsaODoqcsb5+ON0TCPoyQl59a6N8tzbkLH15cZnPjnji5679V
 itPaEtCLDW+9j8eWxhFQBwglFtFSRACW7Zpw6oOZrsK1RudwQJgIVzMZVzqJlpq/7+E3dyxmwV
 PFQuddyKQaG0zxXmt99ois7sAPcUWGHLpdYLA56eYbuSy29EKMyAoZA8FMi0mlFkHu1OS9Z4oN
 mos=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip01.wdc.com with ESMTP; 14 Sep 2023 09:07:11 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Thu, 14 Sep 2023 09:07:01 -0700
Subject: [PATCH v9 06/11] btrfs: implement RST version of scrub
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230914-raid-stripe-tree-v9-6-15d423829637@wdc.com>
References: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
In-Reply-To: <20230914-raid-stripe-tree-v9-0-15d423829637@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694707621; l=4850;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=QzXsAiN8EWNcEnSNzBlMi5nDNJGLElkV/zgsPabPAFk=;
 b=SzYPDugH1Fsgd4op95knUECcvGBvlmxEKaO7005yZ3K/1ol/AAvJFtBTYnhsXCTlCQV5Rsr3q
 nKrMxARCMDaA0k1FDmGI6uTeu+Fqxz2S087vKtyPeX83DeOv84hNZpX
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A filesystem that uses the RAID stripe tree for logical to physical
address translation can't use the regular scrub path, that reads all
stripes and then checks if a sector is unused afterwards.

When using the RAID stripe tree, this will result in lookup errors, as the
stripe tree doesn't know the requested logical addresses.

Instead, look up stripes that are backed by the extent bitmap.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c              |  2 ++
 fs/btrfs/raid-stripe-tree.c |  8 ++++++-
 fs/btrfs/scrub.c            | 53 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h          |  1 +
 4 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index ddbe6f8d4ea2..bdb6e3effdbb 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -663,6 +663,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 	blk_status_t ret;
 	int error;
 
+	smap.is_scrub = !bbio->inode;
+
 	btrfs_bio_counter_inc_blocked(fs_info);
 	error = btrfs_map_block(fs_info, btrfs_op(bio), logical, &map_length,
 				&bioc, &smap, &mirror_num, 1);
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 697a6e1fd255..63bf62c33436 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -334,6 +334,11 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 	if (!path)
 		return -ENOMEM;
 
+	if (stripe->is_scrub) {
+		path->skip_locking = 1;
+		path->search_commit_root = 1;
+	}
+
 	ret = btrfs_search_slot(NULL, stripe_root, &stripe_key, path, 0, 0);
 	if (ret < 0)
 		goto free_path;
@@ -420,7 +425,8 @@ int btrfs_get_raid_extent_offset(struct btrfs_fs_info *fs_info,
 out:
 	if (ret > 0)
 		ret = -ENOENT;
-	if (ret && ret != -EIO) {
+	if (ret && ret != -EIO && !stripe->is_scrub) {
+
 		if (IS_ENABLED(CONFIG_BTRFS_DEBUG))
 			btrfs_print_tree(leaf, 1);
 		btrfs_err(fs_info,
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f16220ce5fba..42948b66d4be 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -23,6 +23,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "scrub.h"
+#include "raid-stripe-tree.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -1634,6 +1635,53 @@ static void scrub_reset_stripe(struct scrub_stripe *stripe)
 	}
 }
 
+static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
+					    struct scrub_stripe *stripe)
+{
+	struct btrfs_fs_info *fs_info = stripe->bg->fs_info;
+	struct btrfs_bio *bbio = NULL;
+	int mirror = stripe->mirror_num;
+	int i;
+
+	atomic_inc(&stripe->pending_io);
+
+	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors) {
+		struct page *page = scrub_stripe_get_page(stripe, i);
+		unsigned int pgoff = scrub_stripe_get_page_offset(stripe, i);
+
+		/* The current sector cannot be merged, submit the bio. */
+		if (bbio &&
+		    ((i > 0 && !test_bit(i - 1, &stripe->extent_sector_bitmap)) ||
+		     bbio->bio.bi_iter.bi_size >= BTRFS_STRIPE_LEN)) {
+			ASSERT(bbio->bio.bi_iter.bi_size);
+			atomic_inc(&stripe->pending_io);
+			btrfs_submit_bio(bbio, mirror);
+			bbio = NULL;
+		}
+
+		if (!bbio) {
+			bbio = btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,
+				fs_info, scrub_read_endio, stripe);
+			bbio->bio.bi_iter.bi_sector = (stripe->logical +
+				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
+		}
+
+		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
+	}
+
+	if (bbio) {
+		ASSERT(bbio->bio.bi_iter.bi_size);
+		atomic_inc(&stripe->pending_io);
+		btrfs_submit_bio(bbio, mirror);
+	}
+
+	if (atomic_dec_and_test(&stripe->pending_io)) {
+		wake_up(&stripe->io_wait);
+		INIT_WORK(&stripe->work, scrub_stripe_read_repair_worker);
+		queue_work(stripe->bg->fs_info->scrub_workers, &stripe->work);
+	}
+}
+
 static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 				      struct scrub_stripe *stripe)
 {
@@ -1645,6 +1693,11 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 	ASSERT(stripe->mirror_num > 0);
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
 
+	if (btrfs_need_stripe_tree_update(fs_info, stripe->bg->flags)) {
+		scrub_submit_extent_sector_read(sctx, stripe);
+		return;
+	}
+
 	bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
 			       scrub_read_endio, stripe);
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 2043aff6e966..067859de8f4c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -393,6 +393,7 @@ struct btrfs_io_stripe {
 	/* Block mapping */
 	u64 physical;
 	u64 length;
+	bool is_scrub;
 	/* For the endio handler */
 	struct btrfs_io_context *bioc;
 };

-- 
2.41.0

