Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6ADD75CD0A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjGUQEV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Jul 2023 12:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjGUQEU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Jul 2023 12:04:20 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37052D50
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Jul 2023 09:04:19 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4438232000E5;
        Fri, 21 Jul 2023 12:04:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 21 Jul 2023 12:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689955458; x=
        1690041858; bh=qVHzbUJDPfPVqjeKlPkrMbSN6blvTO3VN5c1dUrHwCk=; b=U
        smN47lG6RL69iOD/VmRYiM4LF3eM58lSy67O0YDRyYp4/2YCGw/LcIUJDKPNBpVE
        nFuLCq+oPiGIEnhi4iNO4qXJ2UAXC+1VXBToVAKEkKJ/15LReXMRe9SWA9BNq1CO
        +yEr0lLnymrNkMxG/SQwU4URnCBIUTX/CjdFrQoQ7w0b/mDq8CqFMY2UZqpnTYBH
        Ml5K3Qq9J4Gqrga2xER/trR88f/74oyNXiOxuN0JaeEGoKB3sMgkGrYqGU5SNsaO
        tC41Yr9Q2UI6i2tf6FCgQm+T5OGFP/psyAEUS2ifGhGvBEzuifX4XMR0MqC3WntT
        +mRes50yvhem8KRfNj+HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689955458; x=1690041858; bh=q
        VHzbUJDPfPVqjeKlPkrMbSN6blvTO3VN5c1dUrHwCk=; b=jH5Ovvbes+tezxkzq
        DZlszXHbkYNKI1ZRkFf1JmbLg1Q6vK6vnYli0d1722TlfYwlPD6RHy1gVoKoFhw7
        vDU9QL7Wzvo3N78VBDsv3mvjiTr0JijLkdbPlTNbdKAoYOjBNuvc7byHtJ9Oe8cr
        jzVQ3uQGki/qneahRhJEUcintThxNQpoUYuiJplFEXr7CSwJNlltuwOYgzrsFiem
        BOzc2r2im/TDK4QWQtbQb6Ned/gBCAt+acygDLsfSj5qnRq3LMcqbbHxdeEekkiT
        Qvb40lE5+wnQOnBGQNcwfLQ573AXLJk7yGPw65tIIUrox0Jl5QarJPuGPOv384Cy
        t3Jwg==
X-ME-Sender: <xms:gqy6ZEZkdx-mdTr_uxv5PFz5rhYbRu5A5P6i9MhO-4dIOkdDjNGN0g>
    <xme:gqy6ZPaxaha3WPZYd5Fmiwa5LA44fnoOxzjIr8zhqiSfR82bFVq-_dwjVEYAm8AHN
    m-kbk1UQjDwuuRdRCk>
X-ME-Received: <xmr:gqy6ZO8hecEU91hjMHXbGTqvApEii8_q74UZWHsWK-RMc55Xl8byDrq1bjC8AnO5SNXWTr6aq-PhQRuav-tu3fpOaQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:gqy6ZOqYRwRCFPmJrEcIGannCb9Jv6g_XFLh5t1_dfOz9ta7MFwxKw>
    <xmx:gqy6ZPob2kVhSxgcWdg6OZoAtAb6yLFolZxjgufBiaTcWcMY-uRVfg>
    <xmx:gqy6ZMQhX8qsBEBLRQfpZuDtpjOPfTKPZA6gpIuunOY-b3BezgOtng>
    <xmx:gqy6ZOTtiK3_DTTTUTbcdRRLW6MjJpPIkGhFs8qnzgGeBQ5cxMqBkw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Jul 2023 12:04:18 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 06/20] btrfs: add simple_quota incompat feature to sysfs
Date:   Fri, 21 Jul 2023 09:02:11 -0700
Message-ID: <1e205700e4e41d5849a7cebf8f2f9df7d65db446.1689955162.git.boris@bur.io>
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

Add an entry in the features directory for the new incompat flag

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index e53614753391..f62bba0068ca 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -291,6 +291,7 @@ BTRFS_FEAT_ATTR_INCOMPAT(metadata_uuid, METADATA_UUID);
 BTRFS_FEAT_ATTR_COMPAT_RO(free_space_tree, FREE_SPACE_TREE);
 BTRFS_FEAT_ATTR_COMPAT_RO(block_group_tree, BLOCK_GROUP_TREE);
 BTRFS_FEAT_ATTR_INCOMPAT(raid1c34, RAID1C34);
+BTRFS_FEAT_ATTR_INCOMPAT(simple_quota, SIMPLE_QUOTA);
 #ifdef CONFIG_BLK_DEV_ZONED
 BTRFS_FEAT_ATTR_INCOMPAT(zoned, ZONED);
 #endif
@@ -322,6 +323,7 @@ static struct attribute *btrfs_supported_feature_attrs[] = {
 	BTRFS_FEAT_ATTR_PTR(free_space_tree),
 	BTRFS_FEAT_ATTR_PTR(raid1c34),
 	BTRFS_FEAT_ATTR_PTR(block_group_tree),
+	BTRFS_FEAT_ATTR_PTR(simple_quota),
 #ifdef CONFIG_BLK_DEV_ZONED
 	BTRFS_FEAT_ATTR_PTR(zoned),
 #endif
-- 
2.41.0

