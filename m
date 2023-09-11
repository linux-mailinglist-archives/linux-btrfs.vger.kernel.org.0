Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63279BDF3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Sep 2023 02:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355772AbjIKWB7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Sep 2023 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237469AbjIKMwi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Sep 2023 08:52:38 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89229CEB;
        Mon, 11 Sep 2023 05:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694436755; x=1725972755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SgfsEwHqQ+ql6isG68bwoNb5Engbd+pFiR0bLi/DpuM=;
  b=a34uboaSmQ34Jz4FyPTUH/HExCoTnow7o/tTdbOvcnyuoTCRtiv4wDgR
   BiqkaGpkRiTYp+ERkMUH9aRGrWhzRA2DQLV3zm1L+6sBOShE+z0EQirta
   fJHFmenyDxTckFpmkZ+Ry8sqi1KSkHnMEYrKg9gkiJ9MLP/uiGh33I+4C
   hsRlwVocG66cQ5hEw7VGKejqdMhVXv3R969nFaS7D0OJU4E0YqdUlVVA3
   4NBb6wVl+NbsGutd5IkfqhR+vx4tQ2FAw0J2U4Bx5MT7dC2+fkmLztial
   uyemMoJsOgNE1KobNBQLh/BCNDK3WceBnekl3EwfIYS5wp9Cwx2giOoWS
   A==;
X-CSE-ConnectionGUID: PBcZDTIOSVChKFl5tPSYEQ==
X-CSE-MsgGUID: Mvsx96uiQE6WXe74ZhrXLA==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="243594394"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Sep 2023 20:52:34 +0800
IronPort-SDR: eSWnZUnb2K0nMsHhNpM/M4iUVV3O1x4EQWt4g+HEZ0lN0BJGlF5B3dYLcp+NjUhXigbPREFJUH
 eLXbqRMEW7fp8DBiYxLeChM+LMdjoms2ey4EIGGzCUeTKazIdjrNMucM66MobAEscxvSbwSbfL
 qfuk/cNXJYrGdaAmS4/vyrwC8ec9VH6ujE6oIGzIzSbxqt70gJGq0Wd686ofaZO6NceLJZJxZd
 i1+G73NSd+E/VgrTeQrTolyPZyNaUa2yKNIPb8XBYH2R4MUTZUfiug2TQ1PiSiky2hSiX21XfM
 yjU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 04:59:40 -0700
IronPort-SDR: xPqOOXg2YEhy3QmJe+LzSdhGE/g+wr0Jd/5ZoG5qm/eiqKY78YGZCJmFchqNMwH4GWaim3/IGt
 x/va9oC5kV9XpewqriTTav2HLtM9N7EQCznHrf1WegrtoSTPjXEq0/PhNSySHsFFvXJExDQ99h
 Z2lqNnJc8Y3t5N/UyEB710E9NwKEU5M0gxgLM7mtXGrf4AHBYHB5AMBhTOMo3k/hyPSbOeZebN
 /uWHZUAnNq5G7MeyUXAjlBlT8fgzGuXiR1Ryp4zlM4HFEQNB3STK4KoabaI7jcCS+/ripSvQeA
 KTg=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Sep 2023 05:52:33 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Naohiro Aota <naohiro.aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/11] btrfs: implement RST version of scrub
Date:   Mon, 11 Sep 2023 05:52:07 -0700
Message-ID: <20230911-raid-stripe-tree-v8-6-647676fa852c@wdc.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
References: <20230911-raid-stripe-tree-v8-0-647676fa852c@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694436627; l=3130; i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id; bh=SgfsEwHqQ+ql6isG68bwoNb5Engbd+pFiR0bLi/DpuM=; b=EKY4ohiJyLZgwMkU/s0o/u+g9U+um3lGuU1U+aGuCCalzHbC/jCRCD+wNk8fNEmhL/gq7E+sX ASfFlegZa0lAKAGShGU1GdP2965g87ksYgNPqakDUoRmm94YyXRm61o
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519; pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 fs/btrfs/scrub.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index f16220ce5fba..5101e0a3f83e 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -23,6 +23,7 @@
 #include "accessors.h"
 #include "file-item.h"
 #include "scrub.h"
+#include "raid-stripe-tree.h"
 
 /*
  * This is only the first step towards a full-features scrub. It reads all
@@ -1634,6 +1635,56 @@ static void scrub_reset_stripe(struct scrub_stripe *stripe)
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
+		struct page *page;
+		int pgoff;
+
+		page = scrub_stripe_get_page(stripe, i);
+		pgoff = scrub_stripe_get_page_offset(stripe, i);
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
@@ -1645,6 +1696,11 @@ static void scrub_submit_initial_read(struct scrub_ctx *sctx,
 	ASSERT(stripe->mirror_num > 0);
 	ASSERT(test_bit(SCRUB_STRIPE_FLAG_INITIALIZED, &stripe->state));
 
+	if (btrfs_need_stripe_tree_update(fs_info, stripe->bg->flags)) {
+		scrub_submit_extent_sector_read(sctx, stripe);
+		return;
+	}
+
 	bbio = btrfs_bio_alloc(SCRUB_STRIPE_PAGES, REQ_OP_READ, fs_info,
 			       scrub_read_endio, stripe);
 

-- 
2.41.0

