Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F90528716
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbiEPObw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244468AbiEPObv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:31:51 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773501D30A
        for <linux-btrfs@vger.kernel.org>; Mon, 16 May 2022 07:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652711509; x=1684247509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N7IaAZK2OhkBxOuVYjm43d/ypc+u7QsecE/jcO5Z1Sk=;
  b=XklpjfSqskxks95FeQOVsDXVP+RgDcFDf8N4A03Os7hqabhOdhdqBL3M
   jCtcgGYZP3Gks3v4wJ4zKWPOrQhguO7aIfzZUXKVXEzleJa52/EfogPUK
   0h8nkUzgUuEki1KDs0S1QuCkiuAt+LJAygx15e2loGJzcFPHxV3FaIwpH
   SYzWL2vFgWlU9jd/GffYJJSLpgoifJDv9MDYWXaEJNTE3mv34BrUU5Np3
   CnLdToxxH5eWH/BQ9eSuI8RjiUBtygkQr6T6XjbzOk21bJmuKBsz/KgN8
   wln3g8MWOEBRZDQ+d7qL6dgo+PYkGI57hN5WoKNCnVinhFSibRuKU2Gib
   g==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="205309210"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:31:48 +0800
IronPort-SDR: G/QEK9wRtNVmij3XDdN/Y05g9Lbfi7Ckl64LL5MUtuyJx0o4uB9AFVOwmGn+G1g6qYr9qZKhKP
 alCVIO4gf87axStmK3/imUSpuVdOj/D4B8R7HSrXOmQ1X5W0DriZ4Z8+M5HI/BzIGo2/Z7TZ9n
 3mF4MoOlP4jA8ycW3wpL9Mz7r2b6mM1D8yCoAnVjHRVPe+3KRDoffzqnSoUdW/mbFVoNHLPYrG
 lyDo0O46emw1tVW4wPy4ne/dc85EeVU2m/epn6PO11gsPnDqaa1cqjt87E5dMhJfG2RtZPMeWi
 7OdO4vFQ5AE95PwZjfNKel28
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:57:29 -0700
IronPort-SDR: RmnJrJcV3CGzcAKEF/7zQIPWWa4O+mmmyEg6N5/Z2ORD8wkF12zypz4JzMJZ1X5+C5At7ohU3L
 b+mtRsVNzZpEQH67nekGnU/M3D/1jodqHm7oiM3q69UuaZWkZo36D5b7ec4CzUlbaMG5BO+8Ay
 tScUZL00et9sFEj+SKbBSxr9N8FBtrsRpmiZWkgCtWsHGYLZRdWw+QAzEb9d36PZ7RM8OW7awh
 lOC5Ftf7belCZtcb7vGJZBseGt39D4r4pMpnk3aA64l2EMlQpWtmHk+bDZhMeVPsdLszYeXeaL
 jZo=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2022 07:31:48 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [RFC ONLY 2/8] btrfs: move btrfs_io_context to volumes.h
Date:   Mon, 16 May 2022 07:31:37 -0700
Message-Id: <6bd71ff55e48686fc917736e686143ca7d5d2c64.1652711187.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652711187.git.johannes.thumshirn@wdc.com>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In preparation for upcoming changes, move 'struct btrfs_io_context' to
volumes.h, so we can use it outside of volumes.c

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/volumes.h | 90 +++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bd297f23d19e..894d289a3b50 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -32,6 +32,51 @@ struct btrfs_io_geometry {
 	u64 raid56_stripe_offset;
 };
 
+struct btrfs_io_stripe {
+	struct btrfs_device *dev;
+	u64 physical;
+	u64 length; /* only used for discard mappings */
+};
+
+/*
+ * Context for IO subsmission for device stripe.
+ *
+ * - Track the unfinished mirrors for mirror based profiles
+ *   Mirror based profiles are SINGLE/DUP/RAID1/RAID10.
+ *
+ * - Contain the logical -> physical mapping info
+ *   Used by submit_stripe_bio() for mapping logical bio
+ *   into physical device address.
+ *
+ * - Contain device replace info
+ *   Used by handle_ops_on_dev_replace() to copy logical bios
+ *   into the new device.
+ *
+ * - Contain RAID56 full stripe logical bytenrs
+ */
+struct btrfs_io_context {
+	refcount_t refs;
+	atomic_t stripes_pending;
+	struct btrfs_fs_info *fs_info;
+	u64 map_type; /* get from map_lookup->type */
+	bio_end_io_t *end_io;
+	struct bio *orig_bio;
+	void *private;
+	atomic_t error;
+	int max_errors;
+	int num_stripes;
+	int mirror_num;
+	int num_tgtdevs;
+	int *tgtdev_map;
+	/*
+	 * logical block numbers for the start of each stripe
+	 * The last one or two are p/q.  These are sorted,
+	 * so raid_map[0] is the start of our full stripe
+	 */
+	u64 *raid_map;
+	struct btrfs_io_stripe stripes[];
+};
+
 /*
  * Use sequence counter to get consistent device stat data on
  * 32-bit processors.
@@ -354,51 +399,6 @@ static inline void btrfs_bio_free_csum(struct btrfs_bio *bbio)
 	}
 }
 
-struct btrfs_io_stripe {
-	struct btrfs_device *dev;
-	u64 physical;
-	u64 length; /* only used for discard mappings */
-};
-
-/*
- * Context for IO subsmission for device stripe.
- *
- * - Track the unfinished mirrors for mirror based profiles
- *   Mirror based profiles are SINGLE/DUP/RAID1/RAID10.
- *
- * - Contain the logical -> physical mapping info
- *   Used by submit_stripe_bio() for mapping logical bio
- *   into physical device address.
- *
- * - Contain device replace info
- *   Used by handle_ops_on_dev_replace() to copy logical bios
- *   into the new device.
- *
- * - Contain RAID56 full stripe logical bytenrs
- */
-struct btrfs_io_context {
-	refcount_t refs;
-	atomic_t stripes_pending;
-	struct btrfs_fs_info *fs_info;
-	u64 map_type; /* get from map_lookup->type */
-	bio_end_io_t *end_io;
-	struct bio *orig_bio;
-	void *private;
-	atomic_t error;
-	int max_errors;
-	int num_stripes;
-	int mirror_num;
-	int num_tgtdevs;
-	int *tgtdev_map;
-	/*
-	 * logical block numbers for the start of each stripe
-	 * The last one or two are p/q.  These are sorted,
-	 * so raid_map[0] is the start of our full stripe
-	 */
-	u64 *raid_map;
-	struct btrfs_io_stripe stripes[];
-};
-
 struct btrfs_device_info {
 	struct btrfs_device *dev;
 	u64 dev_offset;
-- 
2.35.1

