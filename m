Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B384E2DA7
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Mar 2022 17:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350882AbiCUQQK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Mar 2022 12:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351076AbiCUQQC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Mar 2022 12:16:02 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DB32FFF4
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Mar 2022 09:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647879269; x=1679415269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6oTq/znIoFntHNJj2cxflSZT1FpYRw4I6HbXx7qB18s=;
  b=f0B3Fjo8FPe2HwewLemVsrfrgLulMPmVYhBShYmgKY25LSaFL9AsUQpb
   jCocCR4DnukVe/2CZK/OBlLHcTiv1lA29RvHSfc1e4j7H2MANzI4ouvbi
   8voZa+ABYrIXeSopV3ENj7zAoQYw8/FTbJu7ollugVXw0D0QyUdOBEQxp
   cQF5Q/NBuT0xPh2RaTSl9cgLkba/TyERZbtzFVOUAW0e+nsXudMStq5hR
   OmbCTKYWPjoyXl7qwESM8J2Cin4L+Nlrtgvhawy1Ftjee7rrKcjWbsfxG
   UcrGABCftrkMwD1jAqLp01CW4iz76+XXVJ7AjQiBeJPzD+z7zd2X19aGQ
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,199,1643644800"; 
   d="scan'208";a="307836351"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Mar 2022 00:14:29 +0800
IronPort-SDR: PFPg7fm42T9pctonJgOiLaG4BN2VcOe52//1XHAgUup24p7fOkgDX7p4rAQdls2svj8lvlfE/Z
 HOY2SrX+7DMLYy5bzFGDI1HPd38FN3Bap0nDl8pQGOCdeYT2QcqAMJV8hn28DKRCB3dM4HJSRJ
 y7/YxswDUoy2/c5pceIvoVSB+f1ZfZ+L0VU6E7PX93JwtBymQOfWS/5WAXE2+tFSf5qAE3fc0j
 xVmf/PQfwqbhU9uLeK0UUWDvR7WecW2X0AJMsTLLw8jrI/QmjgAEsYfwK6Xn2hAVlEO/NVrz2i
 szguVzrHy1mpeK/3QbcDaVYP
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 08:45:29 -0700
IronPort-SDR: mr0tPSzLThJwAgGsjGX9pi8WYNfAtxcT5FTICRNSnPgVh8I0Zdc1wVd+R9nor9lkpiYimdfpEx
 kYHlqimll7+/sRWzUtr2VsvHAIjICuGRmxFrGY2yp7yUEgosNapjNPzYvlA0UvfO0HE1+8Zzct
 WUMs8ebkw0G+N7v5nwkAPk+I+iPCfiwHQkEz4VkG+Zt5xobACljt5H/ze0pwysRr47LgdrWgzR
 ni0gz9cUMFlnVt+YBZILkwB1l5hHXbma8+AlhCLso4I4RvwW7x76cbDKZI3DEvrTfXso5Lc6qv
 Hpk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Mar 2022 09:14:28 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH 2/5] btrfs: allow block group background reclaim for !zoned fs'es
Date:   Mon, 21 Mar 2022 09:14:11 -0700
Message-Id: <ef7463193e228bbb348bf8a8d587aa8b95bebf22.1647878642.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647878642.git.johannes.thumshirn@wdc.com>
References: <cover.1647878642.git.johannes.thumshirn@wdc.com>
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

