Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B76C4EA9E1
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 10:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbiC2I6A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 04:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiC2I57 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 04:57:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960C5190B5E
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 01:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648544177; x=1680080177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wJrqRCYSAbg1LnyyBqCL8XJOy/fAnNCtxaK/xgeCWfs=;
  b=aX0OsNBxKESwe5kTkXnf5SFRVbC9OZdHGRJV/tsRzuzAGs3KupTsdx/K
   HpLtxhnlG2C2rMC+lUXyM+7UajiYTnqHJGbwDvLR/KAgI4nWGW3uCEgpK
   U/ugGzzNPvo7rl5eBqbPfZALkmJ8rGPPHZcdV5UTZJWP9vRw9V0ww6wPC
   He3Iw0FnDhgl3tuOYJ16cRChjpZiuYrOnt0Og/bsMXIiz8toCFE2//W2p
   46ZqoLsjyHQuwzB2Wvqg6EfN41falRVA7HKqCC+NKMRRFrwrPJ1rLXGJb
   duDqoDp1rFJJ5OPiL/9lkuDM+gQYNHu13bjvGMZIaa+hOs1dsQvozfRPD
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,219,1643644800"; 
   d="scan'208";a="308481652"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2022 16:56:17 +0800
IronPort-SDR: BEA8UpAOItDVdWPpD9n0uvkyabn+h8l19Dyl4N2erlWhiXBYfYrFj7ffzGij8Kr4zogNmM9I/e
 a4s7jHg5j8+fes9TGf54RVXiZloUgCd0oyd7FEAJlKyzZI0xzfcLQ5MAzxK/eH0AA3WYeFEvrR
 Xk58d3HFbfzud14dYrlcjsYwt0h1wCCo1VRHBUjU4Qy5w81oF1bCGjTHc/PqcGfFg2/6BW0UYW
 sSvNnwvGdI543wARPUu68WPf3EfIUoeespuS69D3i4OqAKcO3G+fhgU18l7BGHaAMsVe1PIDtL
 qQ7QzzUmOylCmamaZC2b/1uD
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2022 01:28:01 -0700
IronPort-SDR: +RPNHv0TDmyAcFyGkwsL7YtfQZHnCPoUXcvbaOzU3iLV5LaEJEv07HgZad551K8YBnFa5yMEhe
 mq+Ak2m7eKUx6nS15POTKSTptSps7uQkm3+HMwjaSNG4Q/GcER1stJdVB+ekWlhHvmdcH8iwAq
 rG+SpFb9jXu2NFIfkIf5ALTobNbAIH5Y1lBH6Qt4MCKGKFNC1vitVyyITQlkUfmXfWyIGfkrTx
 eSseAMaHDG7azb8LblzaxWrClsiHwttRCA17lR7uuGZxiO4X4Eo4dwb0suu/biW72F5WcJf9Dq
 aSU=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2022 01:56:17 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 2/4] btrfs: allow block group background reclaim for !zoned fs'es
Date:   Tue, 29 Mar 2022 01:56:07 -0700
Message-Id: <7243b0e2e57f2eb276f9ddbff3c772e6b3cbe956.1648543951.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1648543951.git.johannes.thumshirn@wdc.com>
References: <cover.1648543951.git.johannes.thumshirn@wdc.com>
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

From: Josef Bacik <josef@toxicpanda.com>

We have found this feature invaluable at Facebook due to how our
workload interacts with the allocator.  We have been using this in
production for months with only a single problem that has already been
fixed.  This will allow us to set a threshold for block groups to be
automatically relocated even if we don't have zoned devices.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/block-group.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 59f18a10fd5f..628741ecb97b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3208,6 +3208,31 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+static inline bool should_reclaim_block_group(struct btrfs_block_group *block_group,
+					      u64 bytes_freed)
+{
+	const struct btrfs_space_info *space_info = block_group->space_info;
+	const int reclaim_thresh = READ_ONCE(space_info->bg_reclaim_threshold);
+	const u64 new_val = block_group->used;
+	const u64 old_val = new_val + bytes_freed;
+	u64 thresh;
+
+	if (reclaim_thresh == 0)
+		return false;
+
+	thresh = div_factor_fine(block_group->length, reclaim_thresh);
+
+	/*
+	 * If we were below the threshold before don't reclaim, we are likely a
+	 * brand new block group and we don't want to relocate new block groups.
+	 */
+	if (old_val < thresh)
+		return false;
+	if (new_val >= thresh)
+		return false;
+	return true;
+}
+
 int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, bool alloc)
 {
@@ -3230,6 +3255,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	spin_unlock(&info->delalloc_root_lock);
 
 	while (total) {
+		bool reclaim;
+
 		cache = btrfs_lookup_block_group(info, bytenr);
 		if (!cache) {
 			ret = -ENOENT;
@@ -3275,6 +3302,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 					cache->space_info, num_bytes);
 			cache->space_info->bytes_used -= num_bytes;
 			cache->space_info->disk_used -= num_bytes * factor;
+
+			reclaim = should_reclaim_block_group(cache, num_bytes);
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
 
@@ -3301,6 +3330,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		if (!alloc && old_val == 0) {
 			if (!btrfs_test_opt(info, DISCARD_ASYNC))
 				btrfs_mark_bg_unused(cache);
+		} else if (!alloc && reclaim) {
+			btrfs_mark_bg_to_reclaim(cache);
 		}
 
 		btrfs_put_block_group(cache);
-- 
2.35.1

