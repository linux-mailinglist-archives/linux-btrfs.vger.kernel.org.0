Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2AF7491F1
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 01:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjGEXht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jul 2023 19:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjGEXhr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Jul 2023 19:37:47 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859812A
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 16:37:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 517E55C0056;
        Wed,  5 Jul 2023 19:37:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 05 Jul 2023 19:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1688600266; x=
        1688686666; bh=v3S/njawk/I7RN3zggO14cGiWt1suYABB4+95F04XLU=; b=W
        PvW73H+LSCdHmKJ24kOp79GwVnuudVTc/yBldtcSlBqHS0tOXVAW7HcXzQ05G2jK
        AsF7cryjwAOd9afDZeiMeQswEUF6I8q6LiNY52PhcbkACSUAM9qNaGu9Z3SyPHMc
        pIdbqyEUOYhW6Y6aec6Fi2G6HCPVi07ECR6Hzecn6ekSv7qnugspTsfy7p01XLGC
        1OTV68nJETckAGwCykS2wsotsJ1YZBzRjVwVkJm4uD3PGVMvZrxsQP6vsLvUB49x
        ZyhVguX6KTkGk6Kqag9sDhLQyqtowd3o18vq0wx3Kx7neKXwULwXJXrDA0L8qgmx
        GRmIekWuYiaskpyRVuDsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1688600266; x=1688686666; bh=v
        3S/njawk/I7RN3zggO14cGiWt1suYABB4+95F04XLU=; b=B6BeCjQLd83iWW7WH
        ydac7ooRthjtg+MV4uwAr2L5z2kyGCv4yATNaRdF8EPqfiyuJaVNW2tKvLIKXnVA
        l068Cg7sG6uLBAwq5pqISr5eUNak+M1sxl09uet2mf6orH61dY38WAZcUDGtYdVW
        xtVfVCVNTuAiREC9r6Gbjrbj7Kt9milpvryrLFbnGL0XYEzx0egIGuvFhtbw1jXp
        ArqytdtMs3NsNj8FcjmPMC1jYOqLepMHQal70vXk3nnYWnSbmA9hKfW6hFQx4kaN
        48YGd355tFDE6wtZU+NeeIED6BI8IKaDlH7yBy+bFRbtdC0bfippUZDcXpUL+EfL
        wrG6Q==
X-ME-Sender: <xms:yv6lZCc1zbYhmO12OZXr0XFwxVDx4FmMcbCgqQkelcOJUKwYgy_3Fw>
    <xme:yv6lZMPHCk2dVE7ChML_5ohAiRajxVW07WCwmvTgVgu_sIVb7KBEVvkSz9LZwFpY6
    uAVo7ecobfqp2kxSC0>
X-ME-Received: <xmr:yv6lZDiYNLY2EoYiF3n5qU63Clu2gelSxuYL9M4TFpBaS_p6n0Ci-3HwpqaSJ2THtxNyeg1J3hFX1881ms2--9BZwgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:yv6lZP-Lqv1gqLMQZW8o9b9QD9Mu0udpdfDWegqVaLWJQO1wglVS1w>
    <xmx:yv6lZOt5vKh7SRnAQTRIELJrFD0hcfdf5LxnxZyhbwVHBqclnkrzrg>
    <xmx:yv6lZGGnU91deAOJi2DRZorWOxjp2ots6IrwZJfuYFZY5FtyrvLEGA>
    <xmx:yv6lZE2Etxee8JDsq2u_WKlzrOjsViVg8ODm6ZRH-HXWuKXASUr1tg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jul 2023 19:37:45 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 8/8] btrfs-progs: tree-checker: handle owner ref items
Date:   Wed,  5 Jul 2023 16:36:27 -0700
Message-ID: <45586f6889c79d6e1708b2b78ee9043b15cf6dff.1688599734.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1688599734.git.boris@bur.io>
References: <cover.1688599734.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the new OWNER_REF inline items to the tree-checker extent item
checking code. We could somehow validate the root id for being a valid
fstree id, but just skipping it seems fine as well.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 kernel-shared/tree-checker.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-shared/tree-checker.c b/kernel-shared/tree-checker.c
index 107975891..2f834cf33 100644
--- a/kernel-shared/tree-checker.c
+++ b/kernel-shared/tree-checker.c
@@ -1477,6 +1477,8 @@ static int check_extent_item(struct extent_buffer *leaf,
 			}
 			inline_refs += btrfs_shared_data_ref_count(leaf, sref);
 			break;
+		case BTRFS_EXTENT_OWNER_REF_KEY:
+			break;
 		default:
 			extent_err(leaf, slot, "unknown inline ref type: %u",
 				   inline_type);
-- 
2.41.0

