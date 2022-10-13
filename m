Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830E35FE597
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiJMWwV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 18:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiJMWwT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 18:52:19 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AFC3C152
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 15:52:18 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 012413200916;
        Thu, 13 Oct 2022 18:52:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 13 Oct 2022 18:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1665701537; x=1665787937; bh=eq
        aoHR37MvZZlXqPb3LN/niyVkreraYCjWUl5YjIQ1c=; b=t7VK9lWOyDnLrAP+dF
        Gy7+AC7aysFy664rGAUpn8a2cV7IQVZ+09jq9BdHzMhVS9WBiZXi8FN3jvTZRy3G
        jKtjm+AdI+tInxG8XYTzCxCV9eak4ZQv+Xiz/jKIc7lXZDBSCEKaJvuZwszckPXI
        +5V9X90gBENlLx7NIDoMk8XqRyF1V8JRKY5ZToKn0bGpMTXUa+LPNYMKNQTIUKEW
        FPK5CSSvPzsGkypdBT0TV/YYqrbBHmKci/71Csiy14Mkv6+mK7/QsuKN7ySGWYw5
        cv3GWHwmouDQw8IP3hc/XSyXGygc3GAWo+optik62lDJ8jYX+tKPSvzgihTAq4ZV
        UbLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1665701537; x=1665787937; bh=eqaoHR37MvZZl
        XqPb3LN/niyVkreraYCjWUl5YjIQ1c=; b=HNy25jnnwztX51qRMjDdH0GdZARJx
        F66QAaX/7tCiCFXd3uj6WNaqcvHtLJJj0OjUZ4+ipRNr/tbgYsg8C46fyCETUd7j
        Wfjhk13iaLtOvWljHm7dNOwMRCG+JGzSTVmT0ceOoujv5aGL7Gd1OgcYxz6eghex
        44yJaRvTBpKileDBAJFWmbKs0QBF8wobjj4NhURJEmVC9VJcok9qTxFLrIQFUFnp
        Pw01UAgC9U8KCGouc/dXa4IBWhA0tL3MNmhS7QxIUr3apsYV82PUlJn2iHLbFWmV
        XoioINTncad1fRIBu4qdsCk3RvF/5lQIpg31lOkomCgT2RmG7XatG/KfQ==
X-ME-Sender: <xms:oZZIY3orXrpPXVyYwnvv9ersqLhdxm6UAe_zNixEyqtJgaMf41Xe0Q>
    <xme:oZZIYxo7lh0NDxcxkEpdUN4USbok5puMappFyDWy8UAFcULYiKf8n5IKclAU1us8R
    cH-OSlun_dU_hh4lew>
X-ME-Received: <xmr:oZZIY0PeaJFaaa4weMxu7IGmSEPi5LMrWk6kIjKKlYKsgt9I87xyIhJJUTKktOY497i63-UcBSarYws4gK-mg1OTDSTZmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:oZZIY65A_mWfDu3Cd_q61rqOWMhQBkV1sZxZM7NfjrrPb4FpymtuQg>
    <xmx:oZZIY26iCZxMP99OPuCGVX7dR4x2gXW8q1KN5ZGFKImgk2RcoqaIUw>
    <xmx:oZZIYyiZV7pt97Xxa-uNauB9p9O79KtGTxWeffpL4PLlo9OPEZ8k3Q>
    <xmx:oZZIY8Rzb5YNAo4odK9ZAgvlRPbdknDgeemMLi1Y6IvGvc6BB5jMDg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 18:52:17 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        'Filipe Manana ' <fdmanana@kernel.org>
Subject: [PATCH v2 2/2] btrfs: re-check reclaim condition in reclaim worker
Date:   Thu, 13 Oct 2022 15:52:10 -0700
Message-Id: <5f8c37f6ebc9024ef4351ae895f3e5fdb9c67baf.1665701210.git.boris@bur.io>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <cover.1665701210.git.boris@bur.io>
References: <cover.1665701210.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I have observed the following case play out and lead to unnecessary
relocations:

1. write a file across multiple block groups
2. delete the file
3. several block groups fall below the reclaim threshold
4. reclaim the first, moving extents into the others
5. reclaim the others which are now actually very full, leading to poor
   reclaim behavior with lots of writing, allocating new block groups,
   etc.

I believe the risk of missing some reasonable reclaims is worth it
when traded off against the savings of avoiding overfull reclaims.

Going forward, it could be interesting to make the check more advanced
(zoned aware, fragmentation aware, etc...) so that it can be a really
strong signal both at extent delete and reclaim time.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 65 ++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 684401aa014a..b3e9b1bc566e 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1539,6 +1539,30 @@ static inline bool btrfs_should_reclaim(struct btrfs_fs_info *fs_info)
 	return true;
 }
 
+static inline bool should_reclaim_block_group(struct btrfs_block_group *bg, u64 bytes_freed)
+{
+	const struct btrfs_space_info *space_info = bg->space_info;
+	const int reclaim_thresh = READ_ONCE(space_info->bg_reclaim_threshold);
+	const u64 new_val = bg->used;
+	const u64 old_val = new_val + bytes_freed;
+	u64 thresh;
+
+	if (reclaim_thresh == 0)
+		return false;
+
+	thresh = div_factor_fine(bg->length, reclaim_thresh);
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
 void btrfs_reclaim_bgs_work(struct work_struct *work)
 {
 	struct btrfs_fs_info *fs_info =
@@ -1623,6 +1647,22 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			spin_unlock(&bg->lock);
 			up_write(&space_info->groups_sem);
 			goto next;
+
+		}
+		/*
+		 * The block group might no longer meet the reclaim condition by
+		 * the time we get around to reclaiming it, so to avoid
+		 * reclaiming overly full block_groups, skip reclaiming them.
+		 *
+		 * Since the decision making process also depends on the amount
+		 * being freed, pass in a fake giant value to skip that extra
+		 * check, which is more meaningful when adding to the list in
+		 * the first place.
+		 */
+		if (!should_reclaim_block_group(bg, bg->length)) {
+			spin_unlock(&bg->lock);
+			up_write(&space_info->groups_sem);
+			goto next;
 		}
 		spin_unlock(&bg->lock);
 
@@ -3241,31 +3281,6 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
-static inline bool should_reclaim_block_group(struct btrfs_block_group *bg,
-					      u64 bytes_freed)
-{
-	const struct btrfs_space_info *space_info = bg->space_info;
-	const int reclaim_thresh = READ_ONCE(space_info->bg_reclaim_threshold);
-	const u64 new_val = bg->used;
-	const u64 old_val = new_val + bytes_freed;
-	u64 thresh;
-
-	if (reclaim_thresh == 0)
-		return false;
-
-	thresh = div_factor_fine(bg->length, reclaim_thresh);
-
-	/*
-	 * If we were below the threshold before don't reclaim, we are likely a
-	 * brand new block group and we don't want to relocate new block groups.
-	 */
-	if (old_val < thresh)
-		return false;
-	if (new_val >= thresh)
-		return false;
-	return true;
-}
-
 int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, bool alloc)
 {
-- 
2.38.0

