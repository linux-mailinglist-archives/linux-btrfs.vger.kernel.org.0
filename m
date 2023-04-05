Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C9D6D8723
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 21:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjDEToU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 15:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbjDEToQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 15:44:16 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613B87685
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 12:44:14 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 80ED932008FE;
        Wed,  5 Apr 2023 15:44:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 05 Apr 2023 15:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1680723853; x=
        1680810253; bh=bE1jDVwqn/ONnmJjKgYS7CRF6GdrWbEPFz7zLVM+NmA=; b=u
        FgBSvvOf2ZXLOaAKHHbzUDGYZtbbGEu/C+NNPd5E8WOEoSS/0YKWlUM4eh9GEbc0
        F8Qe4Qfz8Qy64/f6LMxtZiqvam1fU3wQlBAuZHwhhugGtE5dpunVRajC1+bbsB4d
        LLcghmw5Ex3idZOXm6AB0e6IcrhUDkDuqEGSMcVtkK35kMnF+LpyKTvzDQn5K7o5
        eyTNy8AVWtV3SEOxZcFawuoBgQJ+rKAwk1CbkWdH2ucfr5pSviAljgJSrY00tgII
        rUX4lkPYPdL6LCCGdeUbaU/Wa4LX9xF0+bIw03czAWX2PB8/P5FtXeAU40hnJbLD
        gG5G3VYXOliRoepFjtOIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1680723853; x=1680810253; bh=b
        E1jDVwqn/ONnmJjKgYS7CRF6GdrWbEPFz7zLVM+NmA=; b=iIOJ80fcI4D8rXP5M
        nvzPTHP41W6JAh1HF01TQBd5A7rAF2zuRdIGcxjFQW3OKELubsifo2zSuYUoYQpm
        jLMDA7WQAHR6CwdL+Xei9N4g0SW12IWzuGS7yPY+JAjDUQZjsmX3lNsr24uzb/RJ
        kF5DKLC6LrhkDAB7RwVoucnIyYtkebUrCQ+bny1wPF/tVBNJhnPXgOXN4kC3A1Va
        oeVWewdaVSLk2gbIdhUz+YbwR//5H7I4aMJIGJt5tVs+DaLZae1xWGHCoo51FD/S
        6E8XeBwo3kd20jqW63dmIdf5OKlI2MAzZB6OJID/h1RAChae2JV7jKzBWRoIrZXt
        Pv7nw==
X-ME-Sender: <xms:jM8tZNRXZJ0lxfS5mkMCs8mC8KgRpui9tYqIIK6bbdY35_xRrfR6uQ>
    <xme:jM8tZGz5B0LdLbH06JipLCO-8CFH9hLu8BQVl2h1uGzXuJJEhOHun-iayI66of-TQ
    lvN6wCixITLrU_zisQ>
X-ME-Received: <xmr:jM8tZC2TbNYtSsSz2FiQD3jvkG87XZAdY4iLLMFdt20_xkEsUtVINHs9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:jM8tZFCE1NBQMDnzGCKtqUtkqDhMCwMAwz7vX5SdWhBZw_9uRrjn3w>
    <xmx:jM8tZGj6X2_gzbThIYe8c3e97ZrdrpcgBdQWzBGvh9dmH_4kEMFUwQ>
    <xmx:jM8tZJqqnS-0OcBA90meYT6WxknG_zooTpV8a-gX9mhyy80li1S3aw>
    <xmx:jc8tZOIINnTLBA54RIwIkxrrseiwz7Kryr2AVm09Odh_JHivcF0-IQ>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 15:44:12 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs: reinterpret async discard iops_limit=0 as no delay
Date:   Wed,  5 Apr 2023 12:43:59 -0700
Message-Id: <ac03a3ccafe6c5a1c5cf1883e9b88dddfb34fcfe.1680723651.git.boris@bur.io>
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

Currently, a limit of 0 results in a hardcoded metering over 6 hours.
Since the default is a set limit, I suspect no one truly depends on this
rather arbitrary setting. Repurpose it for an arguably more useful
"unlimited" mode, where the delay is 0.

Note that if block groups are too new, or go fully empty, there is still
a delay associated with those conditions. Those delays implement
heuristics for not trimming a region we are relatively likely to fully
overwrite soon.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/discard.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/discard.c b/fs/btrfs/discard.c
index 0bc526f5fcd9..c48abc817ed2 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -56,8 +56,6 @@
 #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
 #define BTRFS_DISCARD_UNUSED_DELAY	(10ULL * NSEC_PER_SEC)
 
-/* Target completion latency of discarding all discardable extents */
-#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
 #define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
 #define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
 #define BTRFS_DISCARD_MAX_IOPS		(1000U)
@@ -577,6 +575,7 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 	s32 discardable_extents;
 	s64 discardable_bytes;
 	u32 iops_limit;
+	unsigned long min_delay = BTRFS_DISCARD_MIN_DELAY_MSEC;
 	unsigned long delay;
 
 	discardable_extents = atomic_read(&discard_ctl->discardable_extents);
@@ -607,13 +606,16 @@ void btrfs_discard_calc_delay(struct btrfs_discard_ctl *discard_ctl)
 	}
 
 	iops_limit = READ_ONCE(discard_ctl->iops_limit);
-	if (iops_limit)
+
+	if (iops_limit) {
 		delay = MSEC_PER_SEC / iops_limit;
-	else
-		delay = BTRFS_DISCARD_TARGET_MSEC / discardable_extents;
+	} else {
+		/* unset iops_limit means go as fast as possible, so allow a delay of 0 */
+		delay = 0;
+		min_delay = 0;
+	}
 
-	delay = clamp(delay, BTRFS_DISCARD_MIN_DELAY_MSEC,
-		      BTRFS_DISCARD_MAX_DELAY_MSEC);
+	delay = clamp(delay, min_delay, BTRFS_DISCARD_MAX_DELAY_MSEC);
 	discard_ctl->delay_ms = delay;
 
 	spin_unlock(&discard_ctl->lock);
-- 
2.40.0

