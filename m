Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D1675BAF0
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Jul 2023 00:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGTW7J (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 Jul 2023 18:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGTW7I (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 Jul 2023 18:59:08 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE12492
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Jul 2023 15:59:07 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2BE835C00E6;
        Thu, 20 Jul 2023 18:59:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Jul 2023 18:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689893947; x=
        1689980347; bh=FPfZW8KTO1u0eOV7SXtgI+mcaKyJGD+tGIo2ZSVwOCs=; b=X
        IzxUc4dkCLVgD6EJ1U4VeUxlV6fo6Qy4nfHkHx1zVWxz3+osMk+zr18gAHzx9JSO
        Pa4JBYAuTzw+nWigXVbaVjrMAgeMsoFYI7dh2BvXRb5OZVBayO19v6RRY6/y4NsN
        /8Op4gKd7yEQ9y1yhhDf2vJbHtVDG6iMNIrGRKxccLbIQOuYD1eMmBxAy3V3rJuf
        V6MhOgumPtbqI5RdyNUUV4gTDe5cvYLNJsDLyMsbPKMfzxNXHirlMptxO4y0NX9l
        fvDSraizL3Ua9ot5dMmxg8R0oJkC1q9DdFQobDjzLkICsTZTbKAItKC7KeKuw6MQ
        iKJ3FUFgE+NNyh9YpZWLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1689893947; x=1689980347; bh=F
        PfZW8KTO1u0eOV7SXtgI+mcaKyJGD+tGIo2ZSVwOCs=; b=sXtyjHvws9lFXGvr5
        S68E6xpVT4nLBsRD+d/i1C0GzAUzMvzTlaRRhpMynIF4aRl2Dyr3mM18D5+XHibQ
        VzAR6LzQCzLPQgIMk2PVaTvbJQ/eBwDUuSI625eItq1RHkoHUTH1532K5Kycljln
        xCx98H7AmO4BhTX2kF15UVkc6DVwdHKt1OCGEYxRLAmnAA0gQogc9anV3+IdnOoE
        RZXJZ7RUTdHQ7/qKIHo9+RhqU4dpEDrypVI0BldK6q2/t/r6OARFd1jGJrMVWdiD
        nBlSFfBeR4Mpq/hBLwbT89CbcRhDzOJxVMQ5uxvTjDcPQWfUb0bartStKEEyazrZ
        +tJwA==
X-ME-Sender: <xms:O7y5ZHflkf9qXFopz-OI6fjShS_CZxPpKv7x3JEEQAbOgiFfyDkGjw>
    <xme:O7y5ZNO58ejrMoDkFvgzUphsSoN4eTpZDH_u_DRnq35t97ejH_xmuZ8ww4abtBnqh
    HtMgQYekv99b9k2GvE>
X-ME-Received: <xmr:O7y5ZAgJxJuYW2R_mmkQf8LH-XdMXEUp7mCl_cMT-QkibHo7IdouJqHlZcRGKSeb-NkFTpJfI_pcWzwoEvZnx7NUzbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:O7y5ZI902PosekwmNzC_RHWqa09wUbobFkb-goU7l0Q16dVdm72LlA>
    <xmx:O7y5ZDvf-fgCKyZrs8Bwmzob3bFqvxO8oSN6_lqwRKfAlgsDMgR-cw>
    <xmx:O7y5ZHGqPfZYVzH74ydssnXppvUcZtzfDk8GoQ9nInZF4pAHVCGAdw>
    <xmx:O7y5ZB0_VkQTIjqFW66kuD_bHMx64KNdCv7PMJVbzLOpRoQU995O9Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 18:59:06 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 8/8] btrfs-progs: tree-checker: handle owner ref items
Date:   Thu, 20 Jul 2023 15:57:24 -0700
Message-ID: <207564817d028dd21505936c8f7f25a037d89f59.1689893698.git.boris@bur.io>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689893698.git.boris@bur.io>
References: <cover.1689893698.git.boris@bur.io>
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

Add the new OWNER_REF inline items to the tree-checker extent item
checking code. We could somehow validate the root id for being a valid
fstree id, but just skipping it seems fine as well.

Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
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

