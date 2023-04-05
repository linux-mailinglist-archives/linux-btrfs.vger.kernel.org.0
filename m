Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6702A6D8722
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 21:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjDEToO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 15:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjDEToN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 15:44:13 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB57BE59
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 12:44:11 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id E04273200437;
        Wed,  5 Apr 2023 15:44:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 05 Apr 2023 15:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1680723850; x=
        1680810250; bh=rmGIL0AcDTDb2LOU58Losv/uTenyFWn721tPNAQt+ys=; b=c
        DgMsKzw8QFOmYe8Ws9CLoiy2C5QrRcCd+f85ubfeZ0v2CsJvpUKuNqdCAmyjLSAM
        1NwfR7U93bE4LHSIvort6Xf3mlZ2fyr5JGtIJUaKkXnCpAzBsG5Mmy9ypd6Wa5tf
        wOQIrq0junfd3cN2rUbounzfFw8Iqgeb1JMgvKV73m1UOt4lNskw2WX8L4zSIl1v
        wSiEGmF0ZLKrl02FlcBw6rTCvRK8pBsEDVU5zE1gibj659J0IdN4AEbExsZxlNFr
        R601JIYovNIDL4oF/06zUoymw78iSqa6WhkI0YoDyL+BYqKa/yJNRhzAFhKyRKWA
        v6kykI5D4P2J/gMnqzqmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1680723850; x=1680810250; bh=r
        mGIL0AcDTDb2LOU58Losv/uTenyFWn721tPNAQt+ys=; b=Pv/ettvKITulmD3Co
        u6qq19npBOj81jk1o1NlVQUhWmtFWXwI8XgNhHCgR7qFDEdJ2nEIv90nwBo5YtB+
        NjWcmoU38myy8Tni1ctgT25vs1aHZCwDEdU4dbvv4z7yOluBygOi4GoZGKgoq+yW
        fy36pBaylK/P5v4T+05On+dnWSI9j+8Tf5GmiwFyKynbprkLmWYy4vO+F5aF4x9w
        TLW9F0i+FgPj0h2X5ItKdtWMnDd5i//2Y3KVzZQP3uEr7geBBzDCRIlQ0qmGS78y
        XTM7HE3+B/fisjae2YhE/alYSR1RVeR1VF3x8VX3SiKKuppxp/g6jQlSAeDQHvnO
        +4DZg==
X-ME-Sender: <xms:is8tZA6SpQoGXOiCwxOou3gKJi8-tJedCf4vcPf_qwuyVOO9B40d_g>
    <xme:is8tZB7glVrG1C0DfNWQ_7crrTYiokZcbiw4AiE-EO87SiCE1Y_sMjfzzp_6YPKYU
    W50cdgCc8flWVtsf-Q>
X-ME-Received: <xmr:is8tZPe4M9AzXlQYCGXa79XM2r_kca9FN8FhmOWSHyqHVOtEj9JAJIHB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepfffggfekkeevveegudffuedvvedtkeevtdelvd
    efudelleegveetleekvdfhieeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhrihhsse
    gsuhhrrdhioh
X-ME-Proxy: <xmx:is8tZFIXyxjz9GN49rl6zDuPFZPYt1q-jPcTRMcj9rkQZ5qCsJNmKA>
    <xmx:is8tZEJeSN3Pa4Ss9lIoe_CDVlhwrf3OFuj917uSq90_QqEALUcQKQ>
    <xmx:is8tZGwKPt5RrnmTWybqPA9Sz51fQjA6jgR0TgGxevTNYfna0mVBzQ>
    <xmx:is8tZOxdjENg-UdsD58SAoG8u_6FtHegpCRZCuCMG3GVJfOZg8zTfw>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 15:44:09 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 1/2] btrfs: set default discard iops_limit to 1000
Date:   Wed,  5 Apr 2023 12:43:58 -0700
Message-Id: <73afd4f8e96351ffe1ba0d50d4fca75873ae3c54.1680723651.git.boris@bur.io>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1680723651.git.boris@bur.io>
References: <cover.1680723651.git.boris@bur.io>
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
index 317aeff6c1da..0bc526f5fcd9 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -60,7 +60,7 @@
 #define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
 #define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
 #define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
-#define BTRFS_DISCARD_MAX_IOPS		(10U)
+#define BTRFS_DISCARD_MAX_IOPS		(1000U)
 
 /* Monotonically decreasing minimum length filters after index 0 */
 static int discard_minlen[BTRFS_NR_DISCARD_LISTS] = {
-- 
2.40.0

