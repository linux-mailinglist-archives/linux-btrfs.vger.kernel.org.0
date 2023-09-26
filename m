Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2EF57AED22
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Sep 2023 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjIZMpc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Sep 2023 08:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbjIZMpb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Sep 2023 08:45:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C07101
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 05:45:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58477C433C8
        for <linux-btrfs@vger.kernel.org>; Tue, 26 Sep 2023 12:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695732324;
        bh=/GrZMCYL+RDHnAmPIiItaFAXkaBvT5Cc25MvsXQ861A=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TAFOkE1ZTIWC2ZNeVcKO3B0r1p9HajiMoRX1UrPt5nXQ8LtoXKlrgTiy07KTAUawk
         qEnwBxWGg0lHiYBm4TKrlMW6xmC2kOVACw/rMOMjVVT7R24Ntu5kCNuKeQyMgLDeWX
         PTZnWWtFgdesEMDuceQfi8qsCBsEavUZAq1TZlRBNSf5Ivs5QmtZQPLGDcu+Krptn2
         LTSWxQasQdxDHlo5xoPx7r1yKaZTEq3y2vE4t8FLgY1F6GBJH5v4v3FWi3802pyaq1
         HRfu+kg8IbxWUHSW9VzJfwPggjBII7ljnUfFU1fr6nFM2K6nE2AMQ8z4MNoZTGSJVB
         jNd/dlBznLPxA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/8] btrfs: error out when COWing block using a stale transaction
Date:   Tue, 26 Sep 2023 13:45:13 +0100
Message-Id: <a678551d318d5dd9835ad9800dfb41c787654dd1.1695731841.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695731838.git.fdmanana@suse.com>
References: <cover.1695731838.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

At btrfs_cow_block() we have these checks to verify we are not using a
stale transaction (a past transaction with an unblocked state or higher),
and the only thing we do is to trigger a WARN with a message and a stack
trace. This however is a critical problem, highly unexpected and if it
happens it's most likely due to a bug, so we should error out and turn the
fs into error state so that such issue is much more easily noticed if it's
triggered.

The problem is critical because using such stale transaction will lead to
not persisting the extent buffer used for the COW operation, as allocating
a tree block adds the range of the respective extent buffer to the
->dirty_pages iotree of the transaction, and a stale transaction, in the
unlocked state or higher, will not flush dirty extent buffers anymore,
therefore resulting in not persisting the tree block and resource leaks
(not cleaning the dirty_pages iotree for example).

So do the following changes:

1) Return -EUCLEAN if we find a stale transaction;

2) Turn the fs into error state, with error -EUCLEAN, so that no
   transaction can be committed, and generate a stack trace;

3) Combine both conditions into a single if statement, as both are related
   and have the same error message;

4) Mark the check as unlikely, since this is not expected to ever happen.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/ctree.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 56d2360e597c..dff2e07ba437 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -686,14 +686,22 @@ noinline int btrfs_cow_block(struct btrfs_trans_handle *trans,
 		btrfs_err(fs_info,
 			"COW'ing blocks on a fs root that's being dropped");
 
-	if (trans->transaction != fs_info->running_transaction)
-		WARN(1, KERN_CRIT "trans %llu running %llu\n",
-		       trans->transid,
-		       fs_info->running_transaction->transid);
-
-	if (trans->transid != fs_info->generation)
-		WARN(1, KERN_CRIT "trans %llu running %llu\n",
-		       trans->transid, fs_info->generation);
+	/*
+	 * COWing must happen through a running transaction, which always
+	 * matches the current fs generation (it's a transaction with a state
+	 * less than TRANS_STATE_UNBLOCKED). If it doesn't, then turn the fs
+	 * into error state to prevent the commit of any transaction.
+	 */
+	if (unlikely(trans->transaction != fs_info->running_transaction ||
+		     trans->transid != fs_info->generation)) {
+		btrfs_handle_fs_error(fs_info, -EUCLEAN,
+"unexpected transaction when attempting to COW block %llu on root %llu, transaction %llu running transaction %llu fs generation %llu",
+				      buf->start, btrfs_root_id(root),
+				      trans->transid,
+				      fs_info->running_transaction->transid,
+				      fs_info->generation);
+		return -EUCLEAN;
+	}
 
 	if (!should_cow_block(trans, root, buf)) {
 		*cow_ret = buf;
-- 
2.40.1

