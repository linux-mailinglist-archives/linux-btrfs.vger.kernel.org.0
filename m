Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E96D838D
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Apr 2023 18:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjDEQV0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Apr 2023 12:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjDEQVU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Apr 2023 12:21:20 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6827DBA
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Apr 2023 09:20:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 014C75C012B;
        Wed,  5 Apr 2023 12:20:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Apr 2023 12:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1680711644; x=
        1680798044; bh=HU254JURtP1xtG4Q1KJZEa/md2tlKYGqk3e6rwEAqYw=; b=L
        XxlgW61Pa8CpH3kNyvbCKCX0JzbO7wsfD5aKpRueCWf9agT6Mp/JL1B+yFAOEizg
        J4BK6qQr1ecAHLU1tCOuK3Xevd7LN3A0OEOZNTGHv/ZgPUeChtJD05ZSWNOpFHoH
        pcvwHUbPGN+Q1jzENJI9XC0E170frtxONLmUBDucrBOxe6UzwHCT359DnHVXeWla
        7GUfMx1iAlivUVIqp4I/DDJpE5GhyF7/tHrx1wBuPDu88Rs7LfgcUmAJK1Tw97aq
        d9gZF0JEkHCWCKP0FOaqjvR0skoKKRciVo7/4FeBV1ziaKkUWOy5k5qsRwE7R8/j
        zc0Xu05OX3iAJeEpbJkLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1680711644; x=1680798044; bh=H
        U254JURtP1xtG4Q1KJZEa/md2tlKYGqk3e6rwEAqYw=; b=f4/62Jr9HR2hvS5Xn
        z79Pb3xMtpaAZgFKEH3MeGlT9kUNW7V70n8FaosS1uNb8qnM/L0CASQzN9gkvRc1
        Yc2T3J+OQ9qco63lrokWxxgEX16iYjgkAQkwZca93FzX/yuasl9M3SUBwbB45qoz
        Evf8VJs96VIj7jPH+0/eYJ+yWCJKIw/6EDtXPFfPzx2LGqtCx+zW+zULWk+0f6kE
        GYm58g3DmXVQBolQDBLFNj0egOnPNV8ThdAEdjkBNRS2d7uRLT0pHzrBXEt8JdaJ
        //zXyaannOegtm8M/YBvc7eavA+wryWO9eavSPsBc44t0B+f60i25A7XujI61SQK
        UA+WA==
X-ME-Sender: <xms:3J8tZBB6naSsKNlTt6JiQPYaKYlYbrFvz30e1mzw181INeQpw_2Stg>
    <xme:3J8tZPh0bUF_T7HA20nrVBQlKlkIMNJ-JNP78RWaddl-yWkKZRJnVn_Tgx4ON3-I2
    SAJX1wV9EEg1Kck0O0>
X-ME-Received: <xmr:3J8tZMn1sQ46te33WYwBM3CmU-dAJOoqQ7V2he4FIKdKf7MlEEkPLsKc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhr
    rdhioheqnecuggftrfgrthhtvghrnhepieeuffeuvdeiueejhfehiefgkeevudejjeejff
    evvdehtddufeeihfekgeeuheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepsghorhhishessghurhdrihho
X-ME-Proxy: <xmx:3J8tZLyox0x9b7Ln4Cm6Il2UfelEQsjzyIgcZQ2m8CgMWunGVS1kwg>
    <xmx:3J8tZGSEL-TbUh3sZYJ-f5Y4yo_4Ly2mrLyjqxVXWt1fg2VrS3xOLg>
    <xmx:3J8tZObSQx4grghg9trpGDVbZzkm6EytRGq5rpfhTHHy-OjDeJhHTw>
    <xmx:3J8tZP6i8vG_HeuKNtDAFB1U84-NiRBjpgLB6_0PqFMeAaJKKWPEaA>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 12:20:44 -0400 (EDT)
From:   Boris Burkov <boris@bur.io>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: reinterpret async discard iops_limit=0 as no delay
Date:   Wed,  5 Apr 2023 09:20:33 -0700
Message-Id: <b2938cfd0da3f8368f18b05b774e0f4207f8a3fe.1680711209.git.boris@bur.io>
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
index aef789bcff8f..ac419ce9ab0a 100644
--- a/fs/btrfs/discard.c
+++ b/fs/btrfs/discard.c
@@ -56,8 +56,6 @@
 #define BTRFS_DISCARD_DELAY		(120ULL * NSEC_PER_SEC)
 #define BTRFS_DISCARD_UNUSED_DELAY	(10ULL * NSEC_PER_SEC)
 
-/* Target completion latency of discarding all discardable extents */
-#define BTRFS_DISCARD_TARGET_MSEC	(6 * 60 * 60UL * MSEC_PER_SEC)
 #define BTRFS_DISCARD_MIN_DELAY_MSEC	(1UL)
 #define BTRFS_DISCARD_MAX_DELAY_MSEC	(1000UL)
 #define BTRFS_DISCARD_MAX_IOPS		(10000U)
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

