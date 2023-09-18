Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033797A4D4B
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Sep 2023 17:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjIRPs2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Sep 2023 11:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjIRPs1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Sep 2023 11:48:27 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF8EE7F;
        Mon, 18 Sep 2023 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1695051924; x=1726587924;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fQE6cYQTb7uEo6MPqo5w53bNOJZDe0ReEYNCQa7qqK0=;
  b=dj4aIh7cOBNX9/B/67QFuV9QI6tZ/MLTqykMPEBwymQclas54O+gZkQ/
   Hs2uDnj3Oe6OcMZkSFKniGrmZcxdnwvYKu9gMcJoEQ65+BfPTUdKu5fka
   ns99rH8ayeixreIcU2uG1nX1sOHMUQIVG2rO6saTP3vlhtQNYWeuUySsC
   ntv1AQUwQcsghCXCy5eU1shKTCG2RkIPJA/HTkr/kseiFH9mBRGf/sfRF
   LULMreQ+FC7CZeFdNwukdewDJ3fmDFBYpKOCahszJdF0u3/B7N4uzcVIo
   M5HzNfv88De1y0DGwKJrXHdgV/PgDvekHUZM+6hpUhKyEiTE9UMIHB3He
   g==;
X-CSE-ConnectionGUID: bYCu7FojQz2C3LXV5E01NA==
X-CSE-MsgGUID: Jsf4kmMURdCGC9Lfjh8kWA==
X-IronPort-AV: E=Sophos;i="6.02,156,1688400000"; 
   d="scan'208";a="242446876"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2023 22:14:40 +0800
IronPort-SDR: CZL9P2IOib8kKyMNF8KdaY13Uoxi3zGnMA6b4ZZJUkQiQDXy7DjPTyziJzZodt6kVIDVUe57LZ
 jk8amtJF6jl6hjauhNbi80ITqBiZhiQHvGAlCLHCO5m15LGI9QHvfUcDuB0xmwvwewLMHcJSu7
 CAwYhMQGbxILE6xGXskE9Qx6d0RR6+KzK36ZLCK5xYUersqSEFd7tlH4N8FY2m+HMHSRUSY++O
 wM31es4w7QRFiDvVrtbz0bsJbN9api+FQ9QnCJ0KWVMmajAkZEeDtBVYGDvRgse+6MXlaaGO1d
 nBY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Sep 2023 06:21:37 -0700
IronPort-SDR: 5TDNxe3i1yZJkY3LXwz/2hJ6fkynl70Mk7Z8Cn/pS7b7c3n2140f5iQQX08bNnMAV3KTIAQSnD
 VEqyVXHmrrDJtjcy3Km4CRJ16f3wZW0dbbPGuCjJoKus8x38lsahok+EJwNwdJR0I8G29pJDWT
 Fq3aH/eyY7fOTOleZY5qFDfAsPh7RTzOWBIwdkU3OdAY6B14rSfFF6BfsRtZapMYy9kzx2u5+J
 WRBMAmONz+eYRhrPu2LyAt1N4JlgONIqLL0utBzQFvL/BiqkPlNFehAbK4E19k6vtSxfwxVtxn
 6rQ=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Sep 2023 07:14:39 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
Date:   Mon, 18 Sep 2023 07:14:32 -0700
Subject: [PATCH 3/4] btrfs: rename ordered_enmtry in btrfs_io_context
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-rst-updates-v1-3-17686dc06859@wdc.com>
References: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
In-Reply-To: <20230918-rst-updates-v1-0-17686dc06859@wdc.com>
To:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Qu Wenru <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695046476; l=4045;
 i=johannes.thumshirn@wdc.com; s=20230613; h=from:subject:message-id;
 bh=fQE6cYQTb7uEo6MPqo5w53bNOJZDe0ReEYNCQa7qqK0=;
 b=+/a05AvEaTYcyS3A7GhxaWi/TMosXPDU0WnXZkuQZ9q7eD4MBxhOivfkRqpzAz8wG008He9UN
 p8eK82/D+smA1kHjMfBeD+VOUFD3OqtPB/8qZEEKzW8DTSRnh62Iw95
X-Developer-Key: i=johannes.thumshirn@wdc.com; a=ed25519;
 pk=TGmHKs78FdPi+QhrViEvjKIGwReUGCfa+3LEnGoR2KM=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Rename the 'ordered_entry' member of 'struct btrfs_io_context' to
'rst_ordered_entry' to make it clear, it is only there for updates to the
raid-stripe-tree.

Cc: Qu Wenru <wqu@suse.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/bio.c              |  3 ++-
 fs/btrfs/raid-stripe-tree.c | 18 +++++++++---------
 fs/btrfs/volumes.h          |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
index 4c234024beae..d0a029c859e1 100644
--- a/fs/btrfs/bio.c
+++ b/fs/btrfs/bio.c
@@ -708,7 +708,8 @@ static bool btrfs_submit_chunk(struct btrfs_bio *bbio, int mirror_num)
 			 * can't happen until after the last submission.
 			 */
 			btrfs_get_bioc(bioc);
-			list_add_tail(&bioc->ordered_entry, &bbio->ordered->bioc_list);
+			list_add_tail(&bioc->rst_ordered_entry,
+				      &bbio->ordered->bioc_list);
 		}
 
 		/*
diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
index 0c0e620ed8b9..1bf84258dbfa 100644
--- a/fs/btrfs/raid-stripe-tree.c
+++ b/fs/btrfs/raid-stripe-tree.c
@@ -132,7 +132,7 @@ static int btrfs_insert_mirrored_raid_extents(struct btrfs_trans_handle *trans,
 	struct btrfs_io_context *bioc;
 	int ret;
 
-	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
+	list_for_each_entry(bioc, &ordered->bioc_list, rst_ordered_entry) {
 		ret = btrfs_insert_one_raid_extent(trans, num_stripes, bioc);
 		if (ret)
 			return ret;
@@ -167,12 +167,12 @@ static int btrfs_insert_striped_mirrored_raid_extents(
 
 	rbioc->map_type = map_type;
 	rbioc->logical = list_first_entry(&ordered->bioc_list, typeof(*rbioc),
-					  ordered_entry)->logical;
+					  rst_ordered_entry)->logical;
 
 	stripe_end = rbioc->logical;
 	prev_end = stripe_end;
 	i = 0;
-	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
+	list_for_each_entry(bioc, &ordered->bioc_list, rst_ordered_entry) {
 		rbioc->size += bioc->size;
 		for (int j = 0; j < substripes; j++) {
 			int stripe = i + j;
@@ -201,7 +201,7 @@ static int btrfs_insert_striped_mirrored_raid_extents(
 	}
 
 	if (left) {
-		bioc = list_prev_entry(bioc, ordered_entry);
+		bioc = list_prev_entry(bioc, rst_ordered_entry);
 		ret = btrfs_insert_one_raid_extent(trans, substripes, bioc);
 	}
 
@@ -225,10 +225,10 @@ static int btrfs_insert_striped_raid_extents(struct btrfs_trans_handle *trans,
 		return -ENOMEM;
 	rbioc->map_type = map_type;
 	rbioc->logical = list_first_entry(&ordered->bioc_list, typeof(*rbioc),
-					  ordered_entry)->logical;
+					  rst_ordered_entry)->logical;
 
 	i = 0;
-	list_for_each_entry(bioc, &ordered->bioc_list, ordered_entry) {
+	list_for_each_entry(bioc, &ordered->bioc_list, rst_ordered_entry) {
 		rbioc->size += bioc->size;
 		rbioc->stripes[i].dev = bioc->stripes[0].dev;
 		rbioc->stripes[i].physical = bioc->stripes[0].physical;
@@ -266,7 +266,7 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 		return 0;
 
 	map_type = list_first_entry(&ordered_extent->bioc_list, typeof(*bioc),
-				    ordered_entry)->map_type;
+				    rst_ordered_entry)->map_type;
 
 	switch (map_type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
 	case BTRFS_BLOCK_GROUP_DUP:
@@ -291,8 +291,8 @@ int btrfs_insert_raid_extent(struct btrfs_trans_handle *trans,
 
 	while (!list_empty(&ordered_extent->bioc_list)) {
 		bioc = list_first_entry(&ordered_extent->bioc_list,
-					typeof(*bioc), ordered_entry);
-		list_del(&bioc->ordered_entry);
+					typeof(*bioc), rst_ordered_entry);
+		list_del(&bioc->rst_ordered_entry);
 		btrfs_put_bioc(bioc);
 	}
 
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 54549e34a306..b511d17c6717 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -432,7 +432,7 @@ struct btrfs_io_context {
 
 	u64 logical;
 	u64 size;
-	struct list_head ordered_entry;
+	struct list_head rst_ordered_entry;
 
 	/*
 	 * The total number of stripes, including the extra duplicated

-- 
2.41.0

