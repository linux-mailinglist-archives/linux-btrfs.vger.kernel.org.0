Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C5A75BAD3
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjGTWzC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjGTWzB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:55:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930F2269D
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:54:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 17D3D5C0195;
        Thu, 20 Jul 2023 18:54:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 20 Jul 2023 18:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893676; x=
        1689980076; bh=qVHzbUJDPfPVqjeKlPkrMbSN6blvTO3VN5c1dUrHwCk=; b=Q
        qJ6Dbi7cTIGrj4D1Bb1F6MOhjqS10BvWGFNbGBjIR/h7Zg+k6YZI4JymSh5JkZxo
        vnLd6qNear3tN/9f5fTDMORnvHJm14WGE8inQuHYhrV0h0uN+5kMkeu1Qgp0HsD9
        cjZU6Fj9UZahMW2lXNIIU4NoqfM/CqBsDFPECUPTPtpIHjPrA2fzJQBKxMyFrHIU
        GoA1Ncu0lD0XoHN43TCDHLicl7vqwVTVJgDD1bSuacD7+4x/SWQnhybFsJ+ehKjK
        DcX65OqtdOEhKoK6yozMrATG88jdRkOY9/9bfQOWzFQysCY+Wa4IUEHtzMSxQ6HX
        hbzNOgr3OruKU3KnZ2dvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893676; x=1689980076; bh=q
        VHzbUJDPfPVqjeKlPkrMbSN6blvTO3VN5c1dUrHwCk=; b=wEJqwaoJc5xQ2JGlG
        d2tZyEMXj1WsQOt9J26zbklD++nXLZXt+swyg4cw79zXJ3ldtL7GxGuZc6NB2TOP
        Lfn9Ule2/PbPPqnEVuc+8FeXPPjqANJdYC91vYi7fVDrG0KAtRu2Z9zWSuCBoCMZ
        cQarybsIrOejUZTp/TQBsUdqJa+eV7Lp1Ji632KHcbICyedFWOGMOUBjGbdnIJ/U
        17MN+nRPY30B5vSHqR/CdlOhOwzu6j2Njdp7gtaffCQxhb/8GU05Y+O3vDmDP7Ws
        lHOESndx1ArORsDiPZc7L82V3NJiZUrZu5ZlxVkweg/zHOHSLgIEwoI6tHi6+Pmq
        X1i5A==
X-ME-Sender: <xms:K7u5ZF6aweB-I_GDGDfZZqqxmThyanIfjo9Q_JMYh8b2T3vSx1rE5Q>
    <xme:K7u5ZC5Kvb39qRUb2rLHpCAb68de_rJ67MYKohqhbeQc8Z3Axj24QLbYtM-xF06Hq
    RcniM0JYqMaaxO5MoM>
X-ME-Received: <xmr:K7u5ZMdBBhhGMM-HpT7uOxZ7jEiuz1R0NOT2rCCK0uCGMmJn0Kfc__CfQXwi0rFoNcbOrpHvy79QqDaHYNzaZkPmzaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:K7u5ZOI3GlT6n3fo2Ob2pofCFPedtl6ZifZZW8RYGRN_o320vUYivw>
    <xmx:K7u5ZJKb-hlE6QVoILpwKCgg9ZxXLvfHjzzoZnUDiUPs0_p9L-fQhQ>
    <xmx:K7u5ZHwF-L5dcj4Vtxsl3gbsfFKc5uxvdhP76O1OJ9lIclZmo9Mr7w>
    <xmx:LLu5ZLwwuT7hCoAGmRD83AlNdohnbbg7pUpnihRNVgrn5JIsVinsGA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:54:35 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 06/20] btrfs: add simple_quota incompat feature to sysfs
Date:   Thu, 20 Jul 2023 15:52:34 -0700
Message-ID: <1e205700e4e41d5849a7cebf8f2f9df7d65db446.1689893021.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893021.git.boris@bur.io>
References: <cover.1689893021.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

