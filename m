Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56925EAF85
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Sep 2022 20:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIZSVI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Sep 2022 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiIZSUx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Sep 2022 14:20:53 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D331E6C762
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Sep 2022 11:15:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 653755C0183;
        Mon, 26 Sep 2022 14:15:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 26 Sep 2022 14:15:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1664216124; x=1664302524; bh=uyJOGFq9LBeDOZzRwyZsEBwtj
        3XGRu0dq9xMas3/QkA=; b=vLMwSmcz0IoMjHpPpoOpd4S+HusWfOXd06I9EHg3a
        gs3SwPCGPwbhfqnibOER3EtfwAnm0HM1YpBUEr5DTCtIrS5s//6TF6raaKAegqER
        KZUd4ycTlGpxkwzitPu/GkdWu0hyG1A+Fci94SQ72x+MNtDuM9psssfuYLBwXoDw
        T8nkz22/sx/t+s52iVxxgvpJwvznsmfLrAx3qbzEwLOmq9h1GYO5R3DHjjtniDyI
        yzM3NEdE71O9EWyM7dxR3IdaTJQSbbJ5wLTmTy2uws/DADNZpbHVI52HLTBbrKv5
        dYx76j2ElLzZLBgLDFbhYhscRc2py2hzIiSIEGqNseQOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1664216124; x=1664302524; bh=uyJOGFq9LBeDOZzRwyZsEBwtj3XGRu0dq9x
        Mas3/QkA=; b=S715HBP67BSifVr706S5bkSb+fVJXi+3eUZJMszc5oJlpx3OqVG
        Uety3pymqx3mo8EGZ2GDT3gueGPS7nWv9Y1QZNQ8bzI48gHWjxcUA+1On0ww5PCB
        Gae3PWFIAd+or00kIpwNchkVVQXLx71kBMueOdOk04weCJOlN12gcLm7twic+nwP
        KIO/PF19jlfriRtKWpdYmAmzTWAW9HRS4aCgOhuu6il9jxbnLqJje1p1FSsSc9r0
        dx8xO9j7Q1J2CSUkolmDF5UsN9PgRwf3/tP6uOhkCE+adElI+dX1/gk4glP12i5A
        ADkq4Y/XmTlugU7y2ef0IamL7KClfqEqBMA==
X-ME-Sender: <xms:POwxY7gv0Rc0_wj4k71GYBS2irAIrdieGouOXB1xC-6z1lGC6pj8CQ>
    <xme:POwxY4C9hup6JG055GE1Kr3ne9SojFixSlexYh6roVWf3OWrUAxF6aAHvd9m4lOa9
    InJ5faahcXRcbQdZyI>
X-ME-Received: <xmr:POwxY7EHAJONRRG45hlG-hSrbcD-qrUzq9JDb3yw4a_ML8aGkxn6VrtZ3okt-uaxfEmcTM0ByQlBHiSoiiBQyC2vBHZDXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepudeitdelueeijeefleffveelieefgfejjeeigeekud
    duteefkefffeethfdvjeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:POwxY4S4-3dfj-EbSZnLpJUIoyqy-jlS7z64bWMsvY8ow-7n6RelDw>
    <xmx:POwxY4zs5wvwGWcwcJVdV5QZPz1uYJo-cX1q3Jw5tIAz-CUIyLMlHw>
    <xmx:POwxY-4bPGqBL0LjcI1ErgQQ_pqZZCUwytIoeDqBPTuHCeFm8glRWw>
    <xmx:POwxY-YJqiv9hWUK_Up7OMvbkDEX6NqOUjLZs1qD42eKJSNoBI1Hew>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Sep 2022 14:15:23 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: send: gate SEND_A_MAX and SEND_C_MAX V3
Date:   Mon, 26 Sep 2022 11:15:22 -0700
Message-Id: <6c87faf8a6ff6172019faed9988adb9fb99689b4.1664216021.git.boris@bur.io>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We haven't finalized send stream v3 yet, so gate setting the max command
values behind CONFIG_BTRFS_DEBUG.

In my testing, and judging from the code, this is a cosmetic change;
verity send commands are still produced (and processed by a compatible
btrfs-progs), even with CONFIG_BTRFS_DEBUG=n set.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/send.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/btrfs/send.h b/fs/btrfs/send.h
index 0a4537775e0c..23661b37ea64 100644
--- a/fs/btrfs/send.h
+++ b/fs/btrfs/send.h
@@ -94,9 +94,13 @@ enum btrfs_send_cmd {
 
 	/* Version 3 */
 	BTRFS_SEND_C_ENABLE_VERITY	= 26,
+#ifndef CONFIG_BTRFS_DEBUG
+	BTRFS_SEND_C_MAX		= 25,
+#else
 	BTRFS_SEND_C_MAX_V3		= 26,
 	/* End */
 	BTRFS_SEND_C_MAX		= 26,
+#endif
 };
 
 /* attributes in send stream */
@@ -168,9 +172,14 @@ enum {
 	BTRFS_SEND_A_VERITY_BLOCK_SIZE	= 33,
 	BTRFS_SEND_A_VERITY_SALT_DATA	= 34,
 	BTRFS_SEND_A_VERITY_SIG_DATA	= 35,
+
+#ifndef CONFIG_BTRFS_DEBUG
+	__BTRFS_SEND_A_MAX		= 31,
+#else
 	BTRFS_SEND_A_MAX_V3		= 35,
 
 	__BTRFS_SEND_A_MAX		= 35,
+#endif
 };
 
 long btrfs_ioctl_send(struct inode *inode, struct btrfs_ioctl_send_args *arg);
-- 
2.37.2

