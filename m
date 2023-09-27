Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D177B0B48
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Sep 2023 19:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjI0RqP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Sep 2023 13:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjI0RqO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Sep 2023 13:46:14 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B81E5
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Sep 2023 10:46:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EADD83200906;
        Wed, 27 Sep 2023 13:46:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 27 Sep 2023 13:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1695836772; x=
        1695923172; bh=juJf4adaoKEs10sartKuic/L0xAj1EhjuXtIUizOzC0=; b=H
        WVqo1bc2zEGUn1Fpu9iSuokuTZr3+y54QOZt0SjAtAJR4+rklGYgO5TGrjdcaFN5
        1KqkiBBFIKYZqpG+ENr0guRjTwriXxlA0TbZj2KesalizFMQQWgX2hQI2URxD0ko
        XWiKKDJcafMWHTSoE2JTDTyRh9HLo1gB9FU/jRNBDDVWCjljEhvh7/M4AF7BbMd7
        OTUUp1qsvF2UAj6yjuBio/yP6zJuhqAkOb5hPnwFB3cpFungVleOQtWxZ+OXXcOu
        +/YjjFaOiTi5wi2EcmCxrDK+Sl4FtYdOdXvYUQ2j3L9SJxxKE3puESEjUoNR4bri
        zPQabRk0huWzUEHgVRTxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1695836772; x=1695923172; bh=j
        uJf4adaoKEs10sartKuic/L0xAj1EhjuXtIUizOzC0=; b=gZdc8fXaZ3l/mLd0/
        WS77Zp5PYmh/8T2jDR9es0fxeLLeqPo1XHKpTQI2V8r/sRytLHX7cxkVj7/tszWK
        NhY5dbwCiRIyU6d5p3e7W2xM9dUyr5w3ZEcFtUhh8Ac4gsYRx7FlQjVvQaE6MjoC
        Fbf1YGVE5QW3LZiYNPRRlaUQivr6z/XnlqVmNJHUY7aPk9+CT4GPnFS4aXud8SXY
        3SmHDUm8U50ybMzCvgkS5oQyDLvW0QkiQfqh9ZEj/U82y4T91iGZCM8boBSoSZ/A
        4EK8N6d/727qqrmkLCUTk/G0qsKJam6OTz4flbA5Rnf3HoyDkLPGhuLM/5ffOl0v
        ljSpw==
X-ME-Sender: <xms:ZGoUZULjYpYaSsDDTypmayZdKlWMms6frYTw0krTgw9hz9fh0M3y8Q>
    <xme:ZGoUZUIrFuXAe9fmSjmu6MUYyziblRMwYUgkSTscApatVUpHgHgNCfvTnnwgwu6JA
    MVFPOB_IbQWET7p4zc>
X-ME-Received: <xmr:ZGoUZUsPholp3hz4qLwcyVDI92h5I7ACQUHRawp_q0pBGUTUVkTV16BLIDS_jzblGHkcAZChS86xJ0r5sVpooMfdGsE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtdeggdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejffevvd
    ehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:ZGoUZRZR2WfBhreiqxCmHFQXAqVrEtX_nslKAo1NMGkjzHGaSNAEJA>
    <xmx:ZGoUZbYO7YbzwMR3SU3tq9qemWFZu4fMDSTnQekl6ll6U3QJQKUCbg>
    <xmx:ZGoUZdBj1VIZ9ESztTx4y5qZ6WsbKW7vAUfTEmX18Y0fo112f2aFLg>
    <xmx:ZGoUZcCq6_AdyY5cKdHTuzgP22ybM2md-SemOSvV1wPc5SYq5s0rTw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Sep 2023 13:46:11 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 8/8] btrfs-progs: tree-checker: handle owner ref items
Date:   Wed, 27 Sep 2023 10:46:49 -0700
Message-ID: <be0468769998d0bccc6262890ec879ba26976fbd.1695836680.git.boris@bur.io>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1695836680.git.boris@bur.io>
References: <cover.1695836680.git.boris@bur.io>
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
2.42.0

