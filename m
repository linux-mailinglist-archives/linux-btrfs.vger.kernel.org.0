Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E796A9266
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Mar 2023 09:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjCCI2h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Mar 2023 03:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCCI2e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Mar 2023 03:28:34 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFF62DE46
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Mar 2023 00:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677832092; x=1709368092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pvMI/l+buu2WwWnyCQztCKHIK1sZgQrOn+sYWPs4pGA=;
  b=nn8Vl62s6N4RD3iI/HfQ5Zz7YFZWeg0HY92/zf6U+KqZdv17reDKXZvZ
   0jGsswZYL8MNIgS69aZLKHNPXg8kT70YJsUz37oJty8wSiMfWd2YpWK6H
   5aQNPOGK6QdGAnNrtJAGCFZBN31ZcsM8o5xb7umthTRQQ9xCgxNmtUPJK
   M6iHP+ynAVgyNmqX3mBTEeh5EhAUwUJVtbP2cYrtTPn60x/du9lLw5dXd
   Q+Ep1tI0x45BNIphRP5CQaEicsAZKQyAtALIqU2LHiFMU5LXvDwAapgN2
   zlt88HHnHaUqieRcVeFAr7kjT7HeFeP/NYuPwVpId5fQ8Q4Vc05RvUgGu
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,230,1673884800"; 
   d="scan'208";a="329040644"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2023 16:26:53 +0800
IronPort-SDR: 4iVjZI0O05aTm38aOIOsoiYCTscuBt3Omc7kIHjz06vgW3wmiOVNGe/KyCGOr/qjSCxqWHLW9K
 i9vWuXfSRSbfziKQVc4tISRMGi1k+e/RfHXRze3U7EaoUKmxkRa3C4rkwZTltEVqzL4F0duoZI
 BYJ6RGR7O9K14440ZQA//OelEQdp0nhbsTBh/a/yxu6dqHUKn3sT9W2sF8sQgjCM1Wz1U0AonP
 KujMAJYjwot60T5LhbJvfz8cdMlyaSk+41XEGm5yFIvlLIEuGhg53RifMUYB2aCX9PqXkStoim
 C94=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2023 23:43:37 -0800
IronPort-SDR: RkxUMuPrKp5QukS3vZ9xcpqxFvIJrs1aDkMQHJqfVQCFp/sEOn42M0AuDFlNw9EJcIDN/JUxzT
 XWnyuNOxq5/96WVi7FfTUJw8fZlsALeYhZ9kI11fZg11s6vgIyWANeZRgfdKiXlg7usFnDtHbp
 luhbcHoGDSH9P7jR0Ti7D88vqrrosYhPLFeFZ+BHEDCzbZMX1zzYUReyYx1HHB6FPwb3nokjTI
 DDUBlS8oEbwGofubZB53peMe9d/Dg/Ec5Hd/3oOBC/hDoYIfp9TNxPggtblUK6IPH5XdbyD8FA
 ezU=
WDCIronportException: Internal
Received: from 5cg21741p5.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.181])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Mar 2023 00:26:52 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
Subject: [RFC PATCH 2/2] btrfs: zoned: drop space_info->active_total_bytes
Date:   Fri,  3 Mar 2023 17:26:44 +0900
Message-Id: <eb0d70fbbbc266f8213eec88efdcc45b220580c3.1677831912.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677831912.git.naohiro.aota@wdc.com>
References: <cover.1677831912.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The space_info->active_total_bytes is no longer necessary as we now count
the region of newly allocated block group as zone_unusable. Drop its usage.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  6 ------
 fs/btrfs/space-info.c  | 40 +++++++++-------------------------------
 fs/btrfs/space-info.h  |  2 --
 fs/btrfs/zoned.c       |  4 ----
 4 files changed, 9 insertions(+), 43 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index fdbbf4b3ddd3..1dd88107b98f 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1175,14 +1175,8 @@ int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
 			< block_group->zone_unusable);
 		WARN_ON(block_group->space_info->disk_total
 			< block_group->length * factor);
-		WARN_ON(test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE,
-				 &block_group->runtime_flags) &&
-			block_group->space_info->active_total_bytes
-			< block_group->length);
 	}
 	block_group->space_info->total_bytes -= block_group->length;
-	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
-		block_group->space_info->active_total_bytes -= block_group->length;
 	block_group->space_info->bytes_readonly -=
 		(block_group->length - block_group->zone_unusable);
 	block_group->space_info->bytes_zone_unusable -=
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 2237685d1ed0..3eecce86f63f 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -308,8 +308,6 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 	ASSERT(found);
 	spin_lock(&found->lock);
 	found->total_bytes += block_group->length;
-	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_flags))
-		found->active_total_bytes += block_group->length;
 	found->disk_total += block_group->length * factor;
 	found->bytes_used += block_group->used;
 	found->disk_used += block_group->used * factor;
@@ -379,22 +377,6 @@ static u64 calc_available_free_space(struct btrfs_fs_info *fs_info,
 	return avail;
 }
 
-static inline u64 writable_total_bytes(struct btrfs_fs_info *fs_info,
-				       struct btrfs_space_info *space_info)
-{
-	/*
-	 * On regular filesystem, all total_bytes are always writable. On zoned
-	 * filesystem, there may be a limitation imposed by max_active_zones.
-	 * For metadata allocation, we cannot finish an existing active block
-	 * group to avoid a deadlock. Thus, we need to consider only the active
-	 * groups to be writable for metadata space.
-	 */
-	if (!btrfs_is_zoned(fs_info) || (space_info->flags & BTRFS_BLOCK_GROUP_DATA))
-		return space_info->total_bytes;
-
-	return space_info->active_total_bytes;
-}
-
 int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 			 struct btrfs_space_info *space_info, u64 bytes,
 			 enum btrfs_reserve_flush_enum flush)
@@ -413,7 +395,7 @@ int btrfs_can_overcommit(struct btrfs_fs_info *fs_info,
 	else
 		avail = calc_available_free_space(fs_info, space_info, flush);
 
-	if (used + bytes < writable_total_bytes(fs_info, space_info) + avail)
+	if (used + bytes < space_info->total_bytes + avail)
 		return 1;
 	return 0;
 }
@@ -449,7 +431,7 @@ void btrfs_try_granting_tickets(struct btrfs_fs_info *fs_info,
 		ticket = list_first_entry(head, struct reserve_ticket, list);
 
 		/* Check and see if our ticket can be satisfied now. */
-		if ((used + ticket->bytes <= writable_total_bytes(fs_info, space_info)) ||
+		if ((used + ticket->bytes <= space_info->total_bytes) ||
 		    btrfs_can_overcommit(fs_info, space_info, ticket->bytes,
 					 flush)) {
 			btrfs_space_info_update_bytes_may_use(fs_info,
@@ -829,7 +811,6 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 {
 	u64 used;
 	u64 avail;
-	u64 total;
 	u64 to_reclaim = space_info->reclaim_size;
 
 	lockdep_assert_held(&space_info->lock);
@@ -844,9 +825,8 @@ btrfs_calc_reclaim_metadata_size(struct btrfs_fs_info *fs_info,
 	 * space.  If that's the case add in our overage so we make sure to put
 	 * appropriate pressure on the flushing state machine.
 	 */
-	total = writable_total_bytes(fs_info, space_info);
-	if (total + avail < used)
-		to_reclaim += used - (total + avail);
+	if (space_info->total_bytes + avail < used)
+		to_reclaim += used - (space_info->total_bytes + avail);
 
 	return to_reclaim;
 }
@@ -856,11 +836,10 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 {
 	u64 global_rsv_size = fs_info->global_block_rsv.reserved;
 	u64 ordered, delalloc;
-	u64 total = writable_total_bytes(fs_info, space_info);
 	u64 thresh;
 	u64 used;
 
-	thresh = mult_perc(total, 90);
+	thresh = mult_perc(space_info->total_bytes, 90);
 
 	lockdep_assert_held(&space_info->lock);
 
@@ -923,8 +902,8 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 					   BTRFS_RESERVE_FLUSH_ALL);
 	used = space_info->bytes_used + space_info->bytes_reserved +
 	       space_info->bytes_readonly + global_rsv_size;
-	if (used < total)
-		thresh += total - used;
+	if (used < space_info->total_bytes)
+		thresh += space_info->total_bytes - used;
 	thresh >>= space_info->clamp;
 
 	used = space_info->bytes_pinned;
@@ -1651,7 +1630,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	 * can_overcommit() to ensure we can overcommit to continue.
 	 */
 	if (!pending_tickets &&
-	    ((used + orig_bytes <= writable_total_bytes(fs_info, space_info)) ||
+	    ((used + orig_bytes <= space_info->total_bytes) ||
 	     btrfs_can_overcommit(fs_info, space_info, orig_bytes, flush))) {
 		btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 						      orig_bytes);
@@ -1665,8 +1644,7 @@ static int __reserve_bytes(struct btrfs_fs_info *fs_info,
 	 */
 	if (ret && unlikely(flush == BTRFS_RESERVE_FLUSH_EMERGENCY)) {
 		used = btrfs_space_info_used(space_info, false);
-		if (used + orig_bytes <=
-		    writable_total_bytes(fs_info, space_info)) {
+		if (used + orig_bytes <= space_info->total_bytes) {
 			btrfs_space_info_update_bytes_may_use(fs_info, space_info,
 							      orig_bytes);
 			ret = 0;
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index fc99ea2b0c34..2033b71b18ce 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -96,8 +96,6 @@ struct btrfs_space_info {
 	u64 bytes_may_use;	/* number of bytes that may be used for
 				   delalloc/allocations */
 	u64 bytes_readonly;	/* total bytes that are read only */
-	/* Total bytes in the space, but only accounts active block groups. */
-	u64 active_total_bytes;
 	u64 bytes_zone_unusable;	/* total bytes that are unusable until
 					   resetting the device zone */
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 848d53b1f9d5..50140109a079 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2306,10 +2306,6 @@ int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
 	if (!btrfs_is_zoned(fs_info) || (space_info->flags & BTRFS_BLOCK_GROUP_DATA))
 		return 0;
 
-	/* No more block groups to activate */
-	if (space_info->active_total_bytes == space_info->total_bytes)
-		return 0;
-
 	for (;;) {
 		int ret;
 		bool need_finish = false;
-- 
2.39.2

