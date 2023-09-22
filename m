Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA977AAFBE
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbjIVKja (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbjIVKjY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:39:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCE5AB
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:39:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481A7C433C8
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379158;
        bh=CbQ1wCUvWqRzpR55VbFjyLCavn+pfmmk+nuAuyMwU6Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=t8IGL4w1lgv+qC1F4zzuXbCbkIifMdqfNQDhY8/gBI9WgDs18PGAtKqe/h+cjYx5m
         D7Lu7rlNypJ3RJSuI0nuJo21nnins8OiVacC881xCaqaFhDZc41dULzyWPQjFGmvsN
         9NKueTM9oVvu14Wyb1Yymg7lUWI2vGwhWFjxA5nqqyYhVt2L2njcQPmp48ZXXXuOu4
         Xi/43ct3TYZxntPpNNQy2vDyOgK6TGV6Ohb0HA4QJUJ+oeXDc5Widv7+KBgHms8ZSE
         9TQHSDEZtlTNlgzP4j968f6K66Ny++h7HLiQuqzE9lRZiUhe+JafNTJnxISbpA7UFb
         aooy+b0B/bB3Q==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/8] btrfs: collapse wait_on_state() to its caller wait_extent_bit()
Date:   Fri, 22 Sep 2023 11:39:06 +0100
Message-Id: <fdc55df022fde39acc39ae8bca91b960ad4f94c5.1695333278.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333278.git.fdmanana@suse.com>
References: <cover.1695333278.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The wait_on_state() function is very short and has a single caller, which
is wait_extent_bit(), so remove the function and put its code into the
caller.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index c939c2bc88e5..700b84fc1588 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -127,7 +127,7 @@ void extent_io_tree_release(struct extent_io_tree *tree)
 		/*
 		 * No need for a memory barrier here, as we are holding the tree
 		 * lock and we only change the waitqueue while holding that lock
-		 * (see wait_on_state()).
+		 * (see wait_extent_bit()).
 		 */
 		ASSERT(!waitqueue_active(&state->wq));
 		free_extent_state(state);
@@ -747,19 +747,6 @@ int __clear_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 
 }
 
-static void wait_on_state(struct extent_io_tree *tree,
-			  struct extent_state *state)
-		__releases(tree->lock)
-		__acquires(tree->lock)
-{
-	DEFINE_WAIT(wait);
-	prepare_to_wait(&state->wq, &wait, TASK_UNINTERRUPTIBLE);
-	spin_unlock(&tree->lock);
-	schedule();
-	spin_lock(&tree->lock);
-	finish_wait(&state->wq, &wait);
-}
-
 /*
  * Wait for one or more bits to clear on a range in the state tree.
  * The range [start, end] is inclusive.
@@ -797,9 +784,15 @@ static void wait_extent_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			goto out;
 
 		if (state->state & bits) {
+			DEFINE_WAIT(wait);
+
 			start = state->start;
 			refcount_inc(&state->refs);
-			wait_on_state(tree, state);
+			prepare_to_wait(&state->wq, &wait, TASK_UNINTERRUPTIBLE);
+			spin_unlock(&tree->lock);
+			schedule();
+			spin_lock(&tree->lock);
+			finish_wait(&state->wq, &wait);
 			free_extent_state(state);
 			goto again;
 		}
-- 
2.40.1

