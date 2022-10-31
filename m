Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40406613E4E
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Oct 2022 20:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiJaTeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Oct 2022 15:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJaTeF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Oct 2022 15:34:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426CB13DF1
        for <linux-btrfs@vger.kernel.org>; Mon, 31 Oct 2022 12:34:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EC38B1F8B5;
        Mon, 31 Oct 2022 19:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667244842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZwAmK3zDt+X97mQWPb3KyBz/OJSOdFUhO08KWdOYblw=;
        b=bGAKs3NEYNdEd1pXCb4qbCE+opMJRehhb4svFU7sS2b/44O3Q+XnZD4EOhTp6T6L7F1Fnx
        eS2itrWAoyxXUdJ1TO0Az8opQa852qsr5mm61v+y3SoAwsK10zg4AzqC3DUvQVyKu+aLg1
        VaJMWjzuokxvoNMxmm7jE9NPnrdJVcE=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id E43642C143;
        Mon, 31 Oct 2022 19:34:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id CE4E7DA79D; Mon, 31 Oct 2022 20:33:46 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 4/4] btrfs: convert btrfs_block_group::seq_zone to runtime flag
Date:   Mon, 31 Oct 2022 20:33:46 +0100
Message-Id: <0ad1f02fb8e431f6b4ddeef12a0748a69b65a6df.1667244568.git.dsterba@suse.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1667244567.git.dsterba@suse.com>
References: <cover.1667244567.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In zoned mode the sequential status of zone can be also tracked in the
runtime flags of block group.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/block-group.h | 5 ++---
 fs/btrfs/zoned.c       | 7 ++++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 4cee23c11938..a02ea76fd6cf 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -57,6 +57,8 @@ enum btrfs_block_group_flags {
 	BLOCK_GROUP_FLAG_ZONED_DATA_RELOC,
 	/* Does the block group need to be added to the free space tree? */
 	BLOCK_GROUP_FLAG_NEEDS_FREE_SPACE,
+	/* Indicate that the block group is placed on a sequential zone */
+	BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE,
 };
 
 enum btrfs_caching_type {
@@ -210,9 +212,6 @@ struct btrfs_block_group {
 	/* Lock for free space tree operations. */
 	struct mutex free_space_lock;
 
-	/* Flag indicating this block group is placed on a sequential zone */
-	bool seq_zone;
-
 	/*
 	 * Number of extents in this block group used for swap files.
 	 * All accesses protected by the spinlock 'lock'.
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 32a5aac1cccb..f805e44b11f8 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1396,7 +1396,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 	}
 
 	if (num_sequential > 0)
-		cache->seq_zone = true;
+		set_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &cache->runtime_flags);
 
 	if (num_conventional > 0) {
 		/* Zone capacity is always zone size in emulation */
@@ -1608,7 +1608,7 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 	if (!cache)
 		return false;
 
-	ret = cache->seq_zone;
+	ret = !!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &cache->runtime_flags);
 	btrfs_put_block_group(cache);
 
 	return ret;
@@ -2113,7 +2113,8 @@ static void btrfs_zone_finish_endio_workfn(struct work_struct *work)
 void btrfs_schedule_zone_finish_bg(struct btrfs_block_group *bg,
 				   struct extent_buffer *eb)
 {
-	if (!bg->seq_zone || eb->start + eb->len * 2 <= bg->start + bg->zone_capacity)
+	if (!test_bit(BLOCK_GROUP_FLAG_SEQUENTIAL_ZONE, &bg->runtime_flags) ||
+	    eb->start + eb->len * 2 <= bg->start + bg->zone_capacity)
 		return;
 
 	if (WARN_ON(bg->zone_finish_work.func == btrfs_zone_finish_endio_workfn)) {
-- 
2.37.3

