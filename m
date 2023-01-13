Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A57668815
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 01:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjAMAFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Jan 2023 19:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbjAMAFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Jan 2023 19:05:19 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2F4101E3
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Jan 2023 16:05:17 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 55E52320094E;
        Thu, 12 Jan 2023 19:05:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 12 Jan 2023 19:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1673568313; x=1673654713; bh=wULF3wRX50OtHFc0rNl3MEBj+
        MzI5ilKNi6E+uLSfeA=; b=T13nbT/oMylNVwkv1BUrsLJbroQfsior1ddjJHG1O
        6hBDqiGrqtJLW3jxzbJGXnao/BHVGePYk2ncNBrIMzCkdbohLngsCkHc8XDDlIB6
        PWlfiwyyS4KiL2Cagg3zFAG6+XLoxCtmogXypQRIJhyzbocqToLyOc7Ry6nLVChY
        9fKk+bZbc4Amcov4jCa56kHQtcoHVzHn64Q59AO0dKLvo8KA6mnawL3edlO9I2zM
        Zt742mp2xVKONXRzquiIniHIde5mtbXOYd031MGm6jbnIGhFJWOOI/7h4G3SZneE
        6+uZG9gd+i/X8PsoKNARInFLlDx74LOVaSptwI/zUtDRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1673568313; x=1673654713; bh=wULF3wRX50OtHFc0rNl3MEBj+MzI5ilKNi6
        E+uLSfeA=; b=aLvTsUanTpTglmtz0XuS8Kv4usy3DFGwKBx3GX2VpFe6nBC5GjC
        e0tDdobkXISQ8iqgvldvLW6to68l51CQzLDJpBU8XJhYXPRxuU7o7PBDXIh0F2n2
        KeZ+cHGUKBEkmW1uO/kliCqs3/AltNJc/TK9pZVwlN2PXBsYTLfFTLpMYcMZvw8m
        LalfCV57KkjVC471AkYITK/BMJzHa9oYJZpWsC4qe/+/zaT8FCq3b6sjSuawjDUr
        6Hox/9HNBXKtzcZGXkWWRfsv2z+uNscFXkCzJ6gSbhbkzQqVXWvZZp07uLnEiAXH
        sXCIaVaWXpwmVo7rAAadT8l8QrwqEm4QGMQ==
X-ME-Sender: <xms:OaDAYzbKxqrKjwKmb4HPFwAh9GEpb0bCLrCpy4DkNYfL4n_QPjjA8g>
    <xme:OaDAYya5DtaOx8gynWhz5rNGnAw2TtuzV1iFYw1RpyOGrr0OqmuaCDKAyp29v7f1y
    LYQlM5rEQ_-fyfKQSs>
X-ME-Received: <xmr:OaDAY19RBfnNy7fPkYUrXbdGzh6bUDZ89b7S9XrpVsOcK9oWUPH86_ak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrleejgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheq
    necuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekuddute
    efkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:OaDAY5pr1nivUBKFH4vzGKnw-lYm3Prikz0Ebyh7YrVc3xFGl37EGA>
    <xmx:OaDAY-rwMxI_tvABIVzFaLDTe_85EwZdDcRvNUQj_fyp5X976eDjSA>
    <xmx:OaDAY_RrLu-oBmPZPXO7GcEw29Lm882JJ8HQqlquCZONfMHaXqhMDw>
    <xmx:OaDAY1SbQVNd_xq-nX59FxpS2qqrW-7PiS8ClOdS8doX4cr16wIHkg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Jan 2023 19:05:13 -0500 (EST)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: hold block_group refcount during async discard
Date:   Thu, 12 Jan 2023 16:05:11 -0800
Message-Id: <07df5461bf34cf138f2f4b281a6fa6a0b389ff68.1673568238.git.boris@bur.io>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Async discard does not acquire the block group reference count while it
holds a reference on the discard list. This is generally OK, as the
paths which destroy block groups tend to try to synchronize on
cancelling async discard work. However, relying on cancelling work
requires careful analysis to be sure it is safe from races with
unpinning scheduling more work.

While I am unable to find a race with unpinning in the current code for
either the unused bgs or relocation paths, I believe we have one in an
older version of auto relocation in a Meta internal build. This suggests
that this is in fact an error prone model, and could be fragile to
future changes to these bg deletion paths.

To make this ownership more clear, add a refcount for async discard. If
work is queued for a block group, its refcount should be incremented,
and when work is completed or canceled, it should be decremented.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/discard.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index ff2e524d9937..bcfd8beca543 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -89,6 +89,8 @@ static void __add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 						      BTRFS_DISCARD_DELAY);
 		block_group->discard_state = BTRFS_DISCARD_RESET_CURSOR;
 	}
+	if (list_empty(&block_group->discard_list))
+		btrfs_get_block_group(block_group);
 
 	list_move_tail(&block_group->discard_list,
 		       get_discard_list(discard_ctl, block_group));
@@ -108,8 +110,12 @@ static void add_to_discard_list(struct btrfs_discard_ctl *discard_ctl,
 static void add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
 				       struct btrfs_block_group *block_group)
 {
+	bool queued;
+
 	spin_lock(&discard_ctl->lock);
 
+	queued = !list_empty(&block_group->discard_list);
+
 	if (!btrfs_run_discard_work(discard_ctl)) {
 		spin_unlock(&discard_ctl->lock);
 		return;
@@ -121,6 +127,8 @@ static void add_to_discard_unused_list(struct btrfs_discard_ctl *discard_ctl,
 	block_group->discard_eligible_time = (ktime_get_ns() +
 					      BTRFS_DISCARD_UNUSED_DELAY);
 	block_group->discard_state = BTRFS_DISCARD_RESET_CURSOR;
+	if (!queued)
+		btrfs_get_block_group(block_group);
 	list_add_tail(&block_group->discard_list,
 		      &discard_ctl->discard_list[BTRFS_DISCARD_INDEX_UNUSED]);
 
@@ -131,6 +139,7 @@ static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 				     struct btrfs_block_group *block_group)
 {
 	bool running = false;
+	bool queued = false;
 
 	spin_lock(&discard_ctl->lock);
 
@@ -140,7 +149,10 @@ static bool remove_from_discard_list(struct btrfs_discard_ctl *discard_ctl,
 	}
 
 	block_group->discard_eligible_time = 0;
+	queued = !list_empty(&block_group->discard_list);
 	list_del_init(&block_group->discard_list);
+	if (queued && !running)
+		btrfs_put_block_group(block_group);
 
 	spin_unlock(&discard_ctl->lock);
 
@@ -216,8 +228,10 @@ static struct btrfs_block_group *peek_discard_list(
 		    block_group->used != 0) {
 			if (btrfs_is_block_group_data_only(block_group))
 				__add_to_discard_list(discard_ctl, block_group);
-			else
+			else {
 				list_del_init(&block_group->discard_list);
+				btrfs_put_block_group(block_group);
+			}
 			goto again;
 		}
 		if (block_group->discard_state == BTRFS_DISCARD_RESET_CURSOR) {
@@ -511,6 +525,8 @@ static void btrfs_discard_workfn(struct work_struct *work)
 	spin_lock(&discard_ctl->lock);
 	discard_ctl->prev_discard = trimmed;
 	discard_ctl->prev_discard_time = now;
+	if (list_empty(&block_group->discard_list))
+		btrfs_put_block_group(block_group);
 	discard_ctl->block_group = NULL;
 	__btrfs_discard_schedule_work(discard_ctl, now, false);
 	spin_unlock(&discard_ctl->lock);
@@ -651,8 +667,12 @@ void btrfs_discard_punt_unused_bgs_list(struct btrfs_fs_info *fs_info)
 	list_for_each_entry_safe(block_group, next, &fs_info->unused_bgs,
 				 bg_list) {
 		list_del_init(&block_group->bg_list);
-		btrfs_put_block_group(block_group);
 		btrfs_discard_queue_work(&fs_info->discard_ctl, block_group);
+		/*
+		 * This put is for the get done by btrfs_mark_bg_unused.
+		 * queueing discard incremented it for discard's reference.
+		 */
+		btrfs_put_block_group(block_group);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
 }
@@ -683,6 +703,7 @@ static void btrfs_discard_purge_list(struct btrfs_discard_ctl *discard_ctl)
 			if (block_group->used == 0)
 				btrfs_mark_bg_unused(block_group);
 			spin_lock(&discard_ctl->lock);
+			btrfs_put_block_group(block_group);
 		}
 	}
 	spin_unlock(&discard_ctl->lock);
-- 
2.38.1

