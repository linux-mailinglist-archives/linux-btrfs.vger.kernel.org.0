Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8D675CD05
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjGUQEI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjGUQEG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:06 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B8A2D47
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4C11A32000E5;
        Fri, 21 Jul 2023 12:04:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 21 Jul 2023 12:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955444; x=
        1690041844; bh=FA2ij8OqublvACzxe7mIgdfXV8I9eHgXi7D+L0QbFO4=; b=n
        ETrnHmLFa4umWgh7OC5ZqLkNZdgOdaYuRVWqGOu+Ld9h6MA0AiqNIiqd1V7DSV0D
        3jfJ80l6wkNAyxc30kdsrpq4HvGQUVY8ov81nnCrgsQfPQDSYUnsPM9TCznWpxPZ
        8Z93mLGv6ZID1PmRDjwm6HIlp3PFayZc+kneY7rgOqWIa3RJ6gTeSWZUlhYZ/W0j
        ff2gzfR4xlpKRF0R94Vf9KFAYkm+51ZOwtegAgrUirmg7rh6hMww2FHaMHBywaUg
        8ruPsdHsLodnvYa8kBB6DtPtVMYI2ax/hOuESPBnTXztpOlN08BM3wxkTlfx2dTH
        4rZd/YTmak9wyRCcIgB4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955444; x=1690041844; bh=F
        A2ij8OqublvACzxe7mIgdfXV8I9eHgXi7D+L0QbFO4=; b=3HL4nFUP/HaiCutFU
        8DGi3gDB61cQZaf6UOD4ayMG6VO8geyrr7P+fFUFYGbsYYmcML3QcSx/ARa93qfm
        B4/lMu1ADcBp33+9BKgFbwevLNF50+LJ2Iw6Fmq3IwBwYdRA4hKYM0t1qr/Nzca2
        sCNU/sJgYzjHdePdSn0jZqcC//wibswr9xiySRQafHa8c7hiZmNiHbDyfIQ7dJfl
        jxzRhGDd0bVCiyN1lGW2Q2qt89fnqcBxr8J3mDHUyyQf/88+WudV/R9vwVU56/PT
        wImB0L16fhytd5igH6UwjrNl1v2hKMvIjT17obVkpGpclxBhHeZgm+C47X/lp1Nb
        tOD4A==
X-ME-Sender: <xms:dKy6ZMxV-1mDexNESr8TFVBAtcdBjcuPN_fo129FwPKLfpE5oaMbVg>
    <xme:dKy6ZATsHmdSGblstqLwRh5NoLu0qxq6iXTKyImZVAvFc0tEbI3LyKoOOUPnsdilm
    k4AxKcKphXi54rdH-E>
X-ME-Received: <xmr:dKy6ZOVtRrPh8E-umkAP2w0FLu7AlNHEKu36a6uIcmAWHrs1yNbCyJhMF_793nvwiliOqQpiJ4F7RrTRr2UpkQZi4jU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:dKy6ZKj0t8XXuB6zhlymDZajrMelsAZcNNbvluO6_9xQnMhX2RAUoQ>
    <xmx:dKy6ZODfReyKot1mJOGsJJEvTJN5rs79cWTXcoy1RJGaYcW8fhhXBA>
    <xmx:dKy6ZLIuSoSVNL5e1y2pOEWkHkHKFa9vQFGHYAKDFDWnTw9yrXZang>
    <xmx:dKy6ZJqCux-Yt0xQfDL8QZP4wTiR7MoQR_14D-K2RowmGW1ACTum9A>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:04 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 01/20] btrfs: free qgroup rsv on io failure
Date:   Fri, 21 Jul 2023 09:02:06 -0700
Message-ID: <a260b7a8e02aa9deca066f9dcc53b2ba028f6d42.1689955162.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689955162.git.boris@bur.io>
References: <cover.1689955162.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we do a write whose bio suffers an error, we will never reclaim the
qgroup reserved space for it. We allocate the space in the write_iter
codepath, then release the reservation as we allocate the ordered
extent, but we only create a delayed ref if the ordered extent finishes.
If it has an error, we simply leak the rsv. This is apparent in running
any error injecting (dmerror) fstests like btrfs/146 or btrfs/160. Such
tests fail due to dmesg on umount complaining about the leaked qgroup
data space.

When we clean up other aspects of space on failed ordered_extents, also
free the qgroup rsv.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ebe70ed96f25..6daaa4fd69f2 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3358,6 +3358,13 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 			btrfs_free_reserved_extent(fs_info,
 					ordered_extent->disk_bytenr,
 					ordered_extent->disk_num_bytes, 1);
+			/*
+			 * Actually free the qgroup rsv which was released when
+			 * the ordered extent was created.
+			 */
+			btrfs_qgroup_free_refroot(fs_info, inode->root->root_key.objectid,
+						  ordered_extent->qgroup_rsv,
+						  BTRFS_QGROUP_RSV_DATA);
 		}
 	}
 
-- 
2.41.0

