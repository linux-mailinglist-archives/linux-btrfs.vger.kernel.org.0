Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8C35FE596
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Oct 2022 00:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiJMWwT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Oct 2022 18:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMWwS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Oct 2022 18:52:18 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4014707F
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Oct 2022 15:52:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 150D53200900;
        Thu, 13 Oct 2022 18:52:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 13 Oct 2022 18:52:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1665701534; x=1665787934; bh=Gh
        hxkU8z2KgfSHPfBl5G1uonjloZ949IZtRfjjPWZDw=; b=JTIO4nLIVub0SkMJVO
        oUQpHoUfOZ+kjloXLwLZmyQ1b49eISR2kWRc6xxLWADTpwtSoDAWkPPgN8I9FJhY
        3RdkJ/g4As32YsfFJGJ1mRMS3Q7yRw1GP1g9J50Mzv6dOSh1UtMXAFWFieufMlGg
        obmV6oDx6+1DGDZkPcVZ9MWHbaWJMMGpWrZKlUIHQqC03yBWmoww3v9s13vKkYsc
        BmiAkYuA2I9BiXEgyP/di2DU+QyD2D2m46ZtNXl8uP/oUFXGpDF2rw6szQ5TUljg
        tenEBpsU2ELbTXlTXjr74rawhoOS2YDHHOpRxHj0P+V1lchpF5Bgm/5FzlN6ZKzk
        7PDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1665701534; x=1665787934; bh=GhhxkU8z2KgfS
        HPfBl5G1uonjloZ949IZtRfjjPWZDw=; b=Q8Dwyo3CPXXy/88iAqAji3NPyiL9s
        kbK/wOxtCQUukbw4JNg2zTpzXEpc7dtO9/13isWSxAL3yZlr4Ujd3LrFKvMoYBUZ
        4wdwXUmF7x/oQPFZsBxqXd9ppqMEh9fIcchYrRIk9CUft8zYdTwyUaKhQu2UyAuy
        2QvGNKqMCBPXD1DPSkJZnhwjB7QpwLo0/oiTl3QjBhvdHu0s547K28VqLN+FcDcG
        3lxspAmmYxdmGYZAZax8TKRtftmZWbWZFs/GRKiW8uNH6WeYUXAYGU3BaA6IxmDJ
        N++PQX1t+CMoMszHklnVUYAYhzq0Z+kgsw2ldpSW42rwnx/4Ovk9rlWFQ==
X-ME-Sender: <xms:npZIY8_LjA6esfMH8K29klEbT0-lWua_KY5noELL2BHwotZZADFKnw>
    <xme:npZIY0vd2F0CvVoTyj_vN5vovYsnaXVNl_-X91XiNsG-X1BYkrbptnpHaWhS458Di
    AghdUzXuwsvotyB5b0>
X-ME-Received: <xmr:npZIYyDzq87zdx3qkmWPTejXwWv2Qc5uizYhk8aF6uqqLdJA_574q0aJlYi001TfDsjsDUCNxBaU_YFjWyP5nZ9SxI5JWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhrihhs
    uceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnhepie
    euffeuvdeiueejhfehiefgkeevudejjeejffevvdehtddufeeihfekgeeuheelnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhishessg
    hurhdrihho
X-ME-Proxy: <xmx:npZIY8ewCKKytRu7RzQBD4bcw-8ZVdefUPMTU08w83MKzc69Z7QZVg>
    <xmx:npZIYxPTPZK26Wuq4HVf_xzp6mYspmuApu6lkzlTmNJMX9W3Qozasg>
    <xmx:npZIY2mNYGBCmXryfMF7OJ2b0e1n_FjwQU3KOu4K0Rjov-XfLD0-TQ>
    <xmx:npZIY_1tBIqegYx9rZPUcjnsYddEsnPgFZRsUtGepe0tEamvmMLFLw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 18:52:14 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        'Filipe Manana ' <fdmanana@kernel.org>
Subject: [PATCH v2 1/2] btrfs: skip reclaim if block_group is empty
Date:   Thu, 13 Oct 2022 15:52:09 -0700
Message-Id: <977bdffbf57cca3ee6541efa1563167d4d282b08.1665701210.git.boris@bur.io>
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

As we delete extents from a block group, at some deletion we cross below
the reclaim threshold. It is possible we are still in the middle of
deleting more extents and might soon hit 0. If the block group is empty
by the time the reclaim worker runs, we will still relocate it.

This works just fine, as relocating an empty block group ultimately
results in properly deleting it. However, we have more direct ways of
removing empty block groups in the cleaner thread. Those are either
async discard or the unused_bgs list. In fact, when we decide whether to
relocate a block group during extent deletion, we do check for emptiness
and prefer the discard/unused_bgs mechanisms when possible.

Not using relocation for this case reduces some modest overhead from
empty bg relocation:
- extra transactions
- extra metadata use/churn for creating relocation metadata
- trying to read the extent tree to look for extents (and in this case
  finding none)

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3f8b1cbbbc43..684401aa014a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1606,6 +1606,24 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
+		if (bg->used == 0) {
+			/*
+			 * It is possible that we trigger relocation on a block
+			 * group as its extents are deleted and it first goes
+			 * below the threshold, then shortly after goes empty.
+			 *
+			 * In this case, relocating it does delete it, but has
+			 * some overhead in relocation specific metadata, looking
+			 * for the non-existent extents and running some extra
+			 * transactions, which we can avoid by using one of the
+			 * other mechanisms for dealing with empty block groups.
+			 */
+			if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
+				btrfs_mark_bg_unused(bg);
+			spin_unlock(&bg->lock);
+			up_write(&space_info->groups_sem);
+			goto next;
+		}
 		spin_unlock(&bg->lock);
 
 		/* Get out fast, in case we're unmounting the filesystem */
-- 
2.38.0

