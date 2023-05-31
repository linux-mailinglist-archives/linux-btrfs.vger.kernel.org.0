Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5391E718250
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 15:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbjEaNly (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 09:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236346AbjEaNlU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 09:41:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06027E77;
        Wed, 31 May 2023 06:40:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D468863B24;
        Wed, 31 May 2023 13:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD2AC433EF;
        Wed, 31 May 2023 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540448;
        bh=C6k38unQQX3+QWan7eqCiqQn8GBnj16eTEB/Ozj63Gk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCpUKy/bnNgbVffs4AYVGZcpx1DVgzn919hzimQW1wR23YqndySRLPZRcmpQjUZOc
         VKjCae4wfbXokBUdjoqSqlbft8ePSzMkV6QLDobapq74i0H3AZ+K8d+Lt3LBDeOQS/
         1lcQkJZ11WA46/wiq+E+IbZcFEpicMCN2m76N7/2GJ/erg+Mh2lcKSohjH4laSHDlI
         yaUR3rc6RcMs9EYyz49jz0E8vphJOI4OJ/Cz0JlTFNihDyrO4541I5z3lhXLHsbtGt
         oQ5et04o5ZnUhS/c8HWH3Z95DQgUCsxtSmSQe1E/68fI6SC3ZN5wxnkGyo0ilvlpss
         wwNLUemQtlQXQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 17/37] btrfs: scrub: try harder to mark RAID56 block groups read-only
Date:   Wed, 31 May 2023 09:39:59 -0400
Message-Id: <20230531134020.3383253-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134020.3383253-1-sashal@kernel.org>
References: <20230531134020.3383253-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 7561551e7ba870b9659083b95feb520fb2dacce3 ]

Currently we allow a block group not to be marked read-only for scrub.

But for RAID56 block groups if we require the block group to be
read-only, then we're allowed to use cached content from scrub stripe to
reduce unnecessary RAID56 reads.

So this patch would:

- Make btrfs_inc_block_group_ro() try harder
  During my tests, for cases like btrfs/061 and btrfs/064, we can hit
  ENOSPC from btrfs_inc_block_group_ro() calls during scrub.

  The reason is if we only have one single data chunk, and trying to
  scrub it, we won't have any space left for any newer data writes.

  But this check should be done by the caller, especially for scrub
  cases we only temporarily mark the chunk read-only.
  And newer data writes would always try to allocate a new data chunk
  when needed.

- Return error for scrub if we failed to mark a RAID56 chunk read-only

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 14 ++++++++++++--
 fs/btrfs/scrub.c       |  9 ++++++++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 5fc670c27f864..58ce5d44ce4d5 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2832,10 +2832,20 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	}
 
 	ret = inc_block_group_ro(cache, 0);
-	if (!do_chunk_alloc || ret == -ETXTBSY)
-		goto unlock_out;
 	if (!ret)
 		goto out;
+	if (ret == -ETXTBSY)
+		goto unlock_out;
+
+	/*
+	 * Skip chunk alloction if the bg is SYSTEM, this is to avoid system
+	 * chunk allocation storm to exhaust the system chunk array.  Otherwise
+	 * we still want to try our best to mark the block group read-only.
+	 */
+	if (!do_chunk_alloc && ret == -ENOSPC &&
+	    (cache->flags & BTRFS_BLOCK_GROUP_SYSTEM))
+		goto unlock_out;
+
 	alloc_flags = btrfs_get_alloc_profile(fs_info, cache->space_info->flags);
 	ret = btrfs_chunk_alloc(trans, alloc_flags, CHUNK_ALLOC_FORCE);
 	if (ret < 0)
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 69c93ae333f63..3720fd1f593d2 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4034,13 +4034,20 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		if (ret == 0) {
 			ro_set = 1;
-		} else if (ret == -ENOSPC && !sctx->is_dev_replace) {
+		} else if (ret == -ENOSPC && !sctx->is_dev_replace &&
+			   !(cache->flags & BTRFS_BLOCK_GROUP_RAID56_MASK)) {
 			/*
 			 * btrfs_inc_block_group_ro return -ENOSPC when it
 			 * failed in creating new chunk for metadata.
 			 * It is not a problem for scrub, because
 			 * metadata are always cowed, and our scrub paused
 			 * commit_transactions.
+			 *
+			 * For RAID56 chunks, we have to mark them read-only
+			 * for scrub, as later we would use our own cache
+			 * out of RAID56 realm.
+			 * Thus we want the RAID56 bg to be marked RO to
+			 * prevent RMW from screwing up out cache.
 			 */
 			ro_set = 0;
 		} else if (ret == -ETXTBSY) {
-- 
2.39.2

