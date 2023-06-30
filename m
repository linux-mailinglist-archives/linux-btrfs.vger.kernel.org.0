Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6E743E33
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 17:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjF3PED (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 11:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjF3PEA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 11:04:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E6B35A6
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 08:03:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 556886176C
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44583C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688137436;
        bh=8A+aVL4XBaXDHm7/SsQO4ACo/a2zRzDLQJCeLn589mg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YVZ4Jh7GrXzeF6mBPhvkeqpuR7io+0u22IiskaTm0ohuNI255CVY/uhpApsLLiyCX
         3lF87cZ6n+33DsJNYv/UEzbofLMLEHDn3FZaae5roc19a7aw/v+DruktNSzkCrYY6U
         xBZLdakgss73mAHmBfKwiNXYXUxSl0FXiwYuVeUbVQSPkpzNi1D4IQT2aeG5IiE4FW
         ynQ13MU5/qAntowZ7kbv5REj1Y4f9O5dFYCw76jocPJpAfkh/N954FCLrJJia8L7F2
         MbSv5zyd5mPMIuveyaywyp/CT67kgZPHbdaxr23h7IcOAJvEH18pvfYAQhGcvH0JaE
         OZn4+osgLIh6Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: update documentation for add_new_free_space()
Date:   Fri, 30 Jun 2023 16:03:45 +0100
Message-Id: <1a4255419cbafe348b2297377047c06e292b821a.1688137156.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1688137155.git.fdmanana@suse.com>
References: <cover.1688137155.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The documentation for add_new_free_space() is stale and no longer correct:

1) It's no longer used only when caching a block group. It's also called
   when creating a block group (btrfs_make_block_group()), when reading
   a block group at mount time (read_one_block_group()) and when reading
   the free space tree for a block group (typically the first time we
   attempt to allocate from the block group);

2) It has nothing to do with pinned extents. It only deals with the
   excluded extents io tree, which is used to track the locations of
   super blocks in order to make sure we never add the location of a
   super block to the free space cache of a block group.

So update the documention and also add a description of the arguments
and return values.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/block-group.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index aab6667cc580..ec4c6edb556b 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -494,10 +494,17 @@ static void fragment_free_space(struct btrfs_block_group *block_group)
 #endif
 
 /*
- * This is only called by btrfs_cache_block_group, since we could have freed
- * extents we need to check the pinned_extents for any extents that can't be
- * used yet since their free space will be released as soon as the transaction
- * commits.
+ * Add a free space range to the in memory free space cache of a block group.
+ * This checks if the range contains super block locations and any such
+ * locations are not added to the free space cache.
+ *
+ * @block_group:      The target block group.
+ * @start:            Start offset of the range.
+ * @end:              End offset of the range (exclusive).
+ * @total_added_ret:  Optional pointer to return the total amound of space
+ *                    added to the block group's free space cache.
+ *
+ * Returns 0 on success or < 0 on error.
  */
 int add_new_free_space(struct btrfs_block_group *block_group, u64 start, u64 end,
 		       u64 *total_added_ret)
-- 
2.34.1

