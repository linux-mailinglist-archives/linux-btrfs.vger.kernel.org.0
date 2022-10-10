Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4515FA39F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Oct 2022 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJJSuE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Oct 2022 14:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiJJSuC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Oct 2022 14:50:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92AD252B5
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Oct 2022 11:49:56 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 21DCA32008FB;
        Mon, 10 Oct 2022 14:49:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 10 Oct 2022 14:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1665427793; x=1665514193; bh=YxJVV0pr/JihuCEucNkdgTxLy
        epNNA6fpZ1VIJhVkno=; b=dR13pYy4DLHbCMuWyotPgOK2sLjID5QIhSuWPnUe0
        crlbsYskDPW8/je65uunxYirmsTshKwznimIVza5WY+4SyGc1yACD3BiK9Xet+8A
        e2XxgD93lyK+pPkSIdjQtZ60oaG1TNbcdcJg1kaz5XN3YkG/R7VjNAg96Ga/Rlwx
        MpAt0U1J1Eo/IGlOdOiKj7vBupW4hxALe/QvYPlF1xvzDCCZ0bngHQMAH6EXZpZA
        BrFEsCT4hGJ97rVWfTu4kddzf5GOfPWN38lfCZDi/NFKo1XKweNWvbh//n88qEly
        tfZdrTxGDCjhseFV2XrcIr2oizZuUaRuiE5PlVoFSIHiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1665427793; x=1665514193; bh=YxJVV0pr/JihuCEucNkdgTxLyepNNA6fpZ1
        VIJhVkno=; b=Xgv6ICyWgyLWMi52YmUvvl/dBzsZvOTkErwRRwv8nPzfu3BQ80R
        Fa9ba60mJcpxWoFQPohQTGE+r2fTgw3ymgAMh0vl989rvH6fomU94emYnEPTs2+q
        Uz9c9SvisS0NMmZ7JkF8Q2xQruTzlF8nZ9pKDlj5LZwmHVamRm4FvoSIl/r+gXxz
        kaE8JNeQjX4SYROsn47kawkJ3Zb9KAmA8gn8Muq8g2TM7Uw+GZdLMnJPmd0oljfH
        GFWf4tX+ILY29PCkl5FBLSv+KHBwQDyfoR+dEg3mVqCp9Yb0ekx9p4SVItOyu5PV
        Z5SDxwv9TgF7dggwuRo+J2ythcDlK/reyLg==
X-ME-Sender: <xms:UWlEY7iOkBFjL7WoxSk9RCcugD1awX5VDh0sRkz43fkOZbBqhflYcg>
    <xme:UWlEY4AwXMRuMgmj4EyvEgpoSZzyojglMcWYyA9D1xRfqgiDdFEDrBeqz1kwgNeDG
    GGZ0CABmsC2tNFqQWQ>
X-ME-Received: <xmr:UWlEY7H-MxxhcTDcQGp1egsW6MJ84aOb-p8bKLbxdfVFdRZT03IBH8u3Am0G-6HEorEEBtHYY2LNvD_GNer5KZ3iPjoRlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeejgedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:UWlEY4TjBUeJyp_xdzIcJ6iO3ng2WWxmAiLWmrWtJGFUa1qCv0YylA>
    <xmx:UWlEY4w73vkVRWGFSjS6znaQ72L-6ezSOOVY_o4s7roY0MJKycBJdQ>
    <xmx:UWlEY-6-FdsZR5hM9oDRKjAsA7wERUoEmr4GBRnn4VNXgxIJjs4giQ>
    <xmx:UWlEY-bgxdTZDCdOkNoe23mWwl-lo3nUBIPmn5A_W1wCgOP6RrTPYw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Oct 2022 14:49:53 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: skip reclaim if block_group is empty
Date:   Mon, 10 Oct 2022 11:49:51 -0700
Message-Id: <8f825fce9d2968034da43e09a4ebc38ec19a2e49.1665427766.git.boris@bur.io>
X-Mailer: git-send-email 2.37.2
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
deleting more extents and might soon hit 0. If that occurs, we would
leave the block group on the reclaim list, not in the care of unused
deletion or async discard.

It is pointless and wasteful to relocate empty block groups, so if we do
notice that case (we might not if the reclaim worker runs *before* we
finish emptying it), don't bother with relocating the block group.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/block-group.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 11fd52657b76..c3ea627d2457 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1608,6 +1608,25 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 			up_write(&space_info->groups_sem);
 			goto next;
 		}
+		if (bg->used == 0) {
+			/*
+			 * It is possible that we trigger relocation on a block
+			 * group as its extents are deleted and it first goes
+			 * below the threshold, then shortly goes empty. In that
+			 * case, we will do relocation, even though we could
+			 * more cheaply just delete the unused block group. Try
+			 * to catch that case here, though of course it is
+			 * possible there is a delete still coming the future,
+			 * so we can't avoid needless relocation of this sort
+			 * altogether. We can at least avoid relocating empty
+			 * block groups.
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
2.37.2

