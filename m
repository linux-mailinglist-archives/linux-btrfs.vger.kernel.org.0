Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7F76D838C
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 18:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbjDEQVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 12:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjDEQVO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 12:21:14 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA72C7A91
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 09:20:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 504605C0124;
        Wed,  5 Apr 2023 12:20:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 12:20:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1680711643; x=
        1680798043; bh=rT8ps90nkz6L/i/kjjzngu3+dnvXOsBQkw2K4cCGtyM=; b=m
        zL5QYdRzDu+KCwa0ruZMwgnkM+9qZZUKnwffQLiyETJg4OsPsvlnyaAMNGKlhXIw
        pLTIAr3ZGP9GVaZJs7JU7ZBk0g++qx5qxNRRqVY1R0ZuFGzGjst1J+E9ZanmpxUK
        0jIdSZoMM01E5pf9wxw4FoV2UUO03Wu1OO7ZxGy0xKxpZkXgoY/AujMcbSBQJ0iW
        CTKVFGxRI9soC5bdYex20qLt5Fa2qjQRku+Fvhyh5o9xgyadLFhEkylv+WoB0aYZ
        AF/hojphPnITENCRvQrI39cEfe6vtUVQXKsJkSDKiek6cMUIWy4Xe3G3WNp+jFaV
        iCahpEp6RWaZxN6bxDcng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1680711643; x=1680798043; bh=r
        T8ps90nkz6L/i/kjjzngu3+dnvXOsBQkw2K4cCGtyM=; b=iBdT0MqluBsStqVve
        DBq6JD+Rr8fxIarSJVd/POt2a3jspyAmuvEE+yDAXmku3rYhDa5LOlA5y16Fnhc5
        Nin6s8YmWXBhmchSR/BAOiqnSoTUQKimWVvMeupRXDHWbsiQCCiJQr7Tmzi55f48
        /wVt4SRzi/5cRYfaeZBXZdn43S8uoMRepY8Y0XtWp1nADMSB1Vw9+0zRkaZY5Vic
        4NrhV6rLTqDSwFZQM26QA2b/BMdPLvpajD8oaDEnp/zL6eKT6aKS6Tz6h/7Mjq7X
        RPvXx0kCiU7UKtPmIY5qvu1djm6lZCLOYI2fFe+8XRnziyyCZ63sCdZBuWJg/9rO
        Y+8Fg==
X-ME-Sender: <xms:258tZEGcwARor1F_MsYMtMeajo_LlaRXJthhi_yiUcOIv23Cgvi5QQ>
    <xme:258tZNUJR8QsjywA_mG47o3H-CazChu3k8wdrU_qaNtKup9zg6_qxkcb-X9QOEJ7O
    zBRxpUgWcZzxDT9-tU>
X-ME-Received: <xmr:258tZOLl0CIsn1B-UJS7idMesKqrmEZNg6oVjqmYyMWRgf3EYImyHTo6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepfffggfekkeevveegudffuedvvedtkeevtdelvd
    efudelleegveetleekvdfhieeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:258tZGFZtq79i2J6c2v09whsIG8Hj2IEffBzUMr9xZtC7GKltq-W5w>
    <xmx:258tZKX4oPfbOgrY_ZMi4nU6EXnv054UwiRJodM4Ag5RVJQjS7eVVA>
    <xmx:258tZJO48N3Zkp_s3XA5tOEvaDe4CkrauotAvHISy_eBeDrkpKbqUQ>
    <xmx:258tZDcdrPu2OW89KUSsd2tcCeRdBKGc8pOpHiXeJ_08O-umVOoqeQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 12:20:42 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: set default discard iops_limit to 1000
Date:   Wed,  5 Apr 2023 09:20:32 -0700
Message-Id: <45f813c5fabdb32df67ba661c396c592b863ff25.1680711209.git.boris@bur.io>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680711209.git.boris@bur.io>
References: <cover.1680711209.git.boris@bur.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Previously, the default was a relatively conservative 10. This results
in a 100ms delay, so with ~300 discards in a commit, it takes the full
30s till the next commit to finish the discards. On a workstation, this
results in the disk never going idle, wasting power/battery, etc.

Set the default to 1000, which results in using the smallest possible
delay, currently, which is 1ms. This has shown to not pathologically
keep the disk busy by the original reporter.

Link: https://lore.kernel.org/linux-btrfs/ZCxKc5ZzP3Np71IC@infradead.org/T/#m6ebdeb475809ed7714b21b8143103fb7e5a966da
Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/discard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 317aeff6c1da..aef789bcff8f 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -60,7 +60,7 @@
 #define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
 #define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
 #define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
-#define BTRFS_DISCARD_MAX_IOPS		(10U)
+#define BTRFS_DISCARD_MAX_IOPS		(10000U)
 
 /* Monotonically decreasing minimum length filters after index 0 */
 static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {
-- 
2.40.0

