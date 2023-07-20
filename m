Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B2975B88F
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jul 2023 22:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGTUM3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 16:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGTUM0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 16:12:26 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5E32706
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 13:12:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-403a0d7afafso9175271cf.1
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689883944; x=1690488744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xn3BA+RG7or9vpEE8yBA/c0E6nv8+kjWIrDLe08avnY=;
        b=IkoGaOSA5KPEb4aWm43LBrRPLT9t9aZh0kmAfdMWVplG7rgUrMBtBfiCeBRJ1LGYwM
         q+I3DQxU6mtd5LpLFaOURsb3sUQGWJPUERE0g8EFYT4Itbzxl6Y2H7OV/S3ZZ/pqUdRo
         2qIONrpejZuSanIgHanxXKdReidXJ19wMDt/IHnt/m7+1dhYlDpjXcz+8gpI1a5EAVH4
         SnfiPdBHmNDK1yTzzZUsulJL2PlwveFAO74gTSLL/wBuU71fJGI60hI/q2vHbQiiwyeR
         YJ2dx37AOY7tzlt1W3OeUYgeHcLK9zRmmEzMwWXOdLdWNVFUOFXz4x5aL/6FzhLDq6y+
         qIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883944; x=1690488744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xn3BA+RG7or9vpEE8yBA/c0E6nv8+kjWIrDLe08avnY=;
        b=f5Qcfn8rgEINMYnN3cvKybLgr2Oum6gg7j4gbjv/sg6uvUxC8LwLU3wh1cEraFBVM5
         oh+IJ0krdK5wnzcIsXxaXrMiXT48fkq7pmTLVluLEr1xG1khQZrjvVbGwDYEyY3tzMst
         0xaxy6RymZ1o6QopLnDdypd8Q/P0vB8BdxcMe7wnVGpyAym0pNj7BwtWrVNXn8982Jrf
         ynMlnklQty1tnVAWznVEsfJ3xIkAt4LerLot4E75z755/1nGcOm+pDXyENnfFUr/bIZO
         c1YRBi/FtQDGQjy10VlhOci4sBm3ct3RG6v5uCxaLpErRRwy0mLeByH6u8pMgCLgX56j
         kCaA==
X-Gm-Message-State: ABy/qLZVtLqsJI55HYrb1zqQQsMU7T/sGyDxj9TC5vAS8v8zs66qpTgU
        OQ8ELy11bRI/2YDHw17JRYJtcZT/8CTWwfJnGM/oVQ==
X-Google-Smtp-Source: APBJJlHuU+7a6AqY8LyeNOtLS4YHf+vZAChO16hpNTJXAoKhjJE9f2QPBmpzn1N7ssQ6+p9C6Swj4g==
X-Received: by 2002:ac8:580a:0:b0:403:b4da:6f65 with SMTP id g10-20020ac8580a000000b00403b4da6f65mr148764qtg.39.1689883943455;
        Thu, 20 Jul 2023 13:12:23 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id j6-20020ac86646000000b004032d9209a0sm677093qtp.50.2023.07.20.13.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 13:12:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/3] btrfs: wait for block groups to finish caching during allocation
Date:   Thu, 20 Jul 2023 16:12:14 -0400
Message-ID: <bd295f0e2277e34008b4aa5648527d0394472de1.1689883754.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689883754.git.josef@toxicpanda.com>
References: <cover.1689883754.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Recently we've been having mysterious hangs while running generic/475 on
the CI system.  This turned out to be something like this

Task 1
dmsetup suspend --nolockfs
-> __dm_suspend
 -> dm_wait_for_completion
  -> dm_wait_for_bios_completion
   -> Unable to complete because of IO's on a plug in Task 2

Task 2
wb_workfn
-> wb_writeback
 -> blk_start_plug
  -> writeback_sb_inodes
   -> Infinite loop unable to make an allocation

Task 3
cache_block_group
->read_extent_buffer_pages
 ->Waiting for IO to complete that can't be submitted because Task 1
   suspended the DM device

The problem here is that we need Task 2 to be scheduled completely for
the blk plug to flush.  Normally this would happen, we normally wait for
the block group caching to finish (Task 3), and this schedule would
result in the block plug flushing.

However if there's enough free space available from the current caching
to satisfy the allocation we won't actually wait for the caching to
complete.  This check however just checks that we have enough space, not
that we can make the allocation.  In this particular case we were trying
to allocate 9mib, and we had 10mib of free space, but we didn't have
9mib of contiguous space to allocate, and thus the allocation failed and
we looped.

We specifically don't cycle through the FFE loop until we stop finding
cached block groups because we don't want to allocate new block groups
just because we're caching, so we short circuit the normal loop once we
hit LOOP_CACHING_WAIT and we found a caching block group.

This is normally fine, except in this particular case where the caching
thread can't make progress because the dm device has been suspended.

Fix this by adding another LOOP state that specifically waits for the
block group to be completely cached before proceeding.  This allows us
to drop this particular optimization, and will give us the proper
scheduling needed to finish the plug.

The alternative here was to simply flush the plug if we need_resched(),
but this is actually a sort of bad behavior from us where we assume that
if the block group has enough free space to match our allocation we'll
actually be successful.  It is a good enough check for a quick pass to
avoid the latency of a full wait, but free space != contiguous free
space, so waiting is more appropriate.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 04ceb9d25d3e..2850bd411a0e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3331,6 +3331,7 @@ int btrfs_free_extent(struct btrfs_trans_handle *trans, struct btrfs_ref *ref)
 enum btrfs_loop_type {
 	LOOP_CACHING_NOWAIT,
 	LOOP_CACHING_WAIT,
+	LOOP_CACHING_DONE,
 	LOOP_UNSET_SIZE_CLASS,
 	LOOP_ALLOC_CHUNK,
 	LOOP_WRONG_SIZE_CLASS,
@@ -3920,9 +3921,6 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 		return 0;
 	}
 
-	if (ffe_ctl->loop >= LOOP_CACHING_WAIT && ffe_ctl->have_caching_bg)
-		return 1;
-
 	ffe_ctl->index++;
 	if (ffe_ctl->index < BTRFS_NR_RAID_TYPES)
 		return 1;
@@ -3931,6 +3929,8 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	 * LOOP_CACHING_NOWAIT, search partially cached block groups, kicking
 	 *			caching kthreads as we move along
 	 * LOOP_CACHING_WAIT, search everything, and wait if our bg is caching
+	 * LOOP_CACHING_DONE, search everything, wait for the caching to
+	 *			completely finish
 	 * LOOP_UNSET_SIZE_CLASS, allow unset size class
 	 * LOOP_ALLOC_CHUNK, force a chunk allocation and try again
 	 * LOOP_NO_EMPTY_SIZE, set empty_size and empty_cluster to 0 and try
@@ -3939,13 +3939,13 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	if (ffe_ctl->loop < LOOP_NO_EMPTY_SIZE) {
 		ffe_ctl->index = 0;
 		/*
-		 * We want to skip the LOOP_CACHING_WAIT step if we don't have
+		 * We want to skip the LOOP_CACHING_* steps if we don't have
 		 * any uncached bgs and we've already done a full search
 		 * through.
 		 */
 		if (ffe_ctl->loop == LOOP_CACHING_NOWAIT &&
 		    (!ffe_ctl->orig_have_caching_bg && full_search))
-			ffe_ctl->loop++;
+			ffe_ctl->loop = LOOP_CACHING_DONE;
 		ffe_ctl->loop++;
 
 		if (ffe_ctl->loop == LOOP_ALLOC_CHUNK) {
@@ -4269,8 +4269,11 @@ static noinline int find_free_extent(struct btrfs_root *root,
 		trace_find_free_extent_have_block_group(root, ffe_ctl, block_group);
 		ffe_ctl->cached = btrfs_block_group_done(block_group);
 		if (unlikely(!ffe_ctl->cached)) {
-			ffe_ctl->have_caching_bg = true;
-			ret = btrfs_cache_block_group(block_group, false);
+			bool wait = ffe_ctl->loop == LOOP_CACHING_DONE;
+
+			if (!wait)
+				ffe_ctl->have_caching_bg = true;
+			ret = btrfs_cache_block_group(block_group, wait);
 
 			/*
 			 * If we get ENOMEM here or something else we want to
@@ -4285,6 +4288,9 @@ static noinline int find_free_extent(struct btrfs_root *root,
 				ret = 0;
 				goto loop;
 			}
+
+			if (wait)
+				ffe_ctl->cached = btrfs_block_group_done(block_group);
 			ret = 0;
 		}
 
-- 
2.41.0

