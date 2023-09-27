Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A367D7B026F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 13:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjI0LJf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 07:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjI0LJe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 07:09:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E4BF3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 04:09:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF3EC433C9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 11:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695812973;
        bh=q7yQ6e2JXCB4C5QiIheTP+2bbdAPtmpuWgT6Rqkt5Ig=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MYFPmjWLa1JbeLKoqX9BqC4GI2QyYCvDtfixALl9sR9BG5vJskp6KE/NXjE7+urUO
         GRIbfhLRNfjgUMwpgIM9eBE8So1cpexNOfkD09/y4VbTySfKh0gt89tU3yhBGDPA2D
         idqTMONoQfdcqJ9vkjhvgzwCbhXAVXTtxBL3/iQ/mVFPXJWEodPwhvoxpPTGuh66Te
         bU83jHfSJL5I2QyzQuoN7BvmEkAIYkquNFQr/fU3JyPxO8KQEcF0/iJAV5Ic8FrxSk
         TxyHmKTkOOyM5hu1NpFZam2HNB49RKpKoQfgaq56DtZA743eGacVihLDtK8tXM+XFk
         0udsE5vjRNesw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/8] btrfs: error out when COWing block using a stale transaction
Date:   Wed, 27 Sep 2023 12:09:21 +0100
Message-Id: <d4915befa17ac6ae67831877116f5c4b8002c099.1695812791.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695812791.git.fdmanana@suse.com>
References: <cover.1695812791.git.fdmanana@suse.com>
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
index 56d2360e597c..29b887ffe682 100644
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
+		btrfs_abort_transaction(trans, -EUCLEAN);
+		btrfs_crit(fs_info,
+"unexpected transaction when attempting to COW block %llu on root %llu, transaction %llu running transaction %llu fs generation %llu",
+			   buf->start, btrfs_root_id(root), trans->transid,
+			   fs_info->running_transaction->transid,
+			   fs_info->generation);
+		return -EUCLEAN;
+	}
 
 	if (!should_cow_block(trans, root, buf)) {
 		*cow_ret = buf;
-- 
2.40.1

