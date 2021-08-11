Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE033E97BB
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Aug 2021 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhHKShq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Aug 2021 14:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbhHKShq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Aug 2021 14:37:46 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53253C061765
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 11:37:22 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id az7so3472594qkb.5
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Aug 2021 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=NnkAERkTJDIOaISkUr96TXB5KoMU2u/0IqNwewHan38=;
        b=vfeGvDpMOLLOwRGap2q5pHZv35WV3e2ld6/JkZbg/Muve86TZEKMUIBe7Pr2sHWrNK
         46Vc4Z7/fv9SjbvqLSepeFMXf3pkEzDP9dcVZ47oQ6NVAidfmKARMCbzCVo7qKmrkLmv
         4X1+fYm5VVA9z2tfT1Z5DVrs3HbGWWqIbQ7pdiLM/lI6ZJKIvws0yxUnT6jJzHsGixZ9
         EECdY00sgBEfe/Ags4YxJnUZkc6vmbVGoTmGC2UK4wOU1983wV/s2FShkiX6NhHSpxGR
         e9g0lobB7GnyvBmnrtdvCDna0barI666J9dOlvHs+L+Dz5tXCIkyhDFIMOq1TBMFhowD
         VIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NnkAERkTJDIOaISkUr96TXB5KoMU2u/0IqNwewHan38=;
        b=sKsRcYWg4rmXYPB8VfhPnnZh2V/c/n/jaYxrHARuwEGTxM0OwiXQAl3gRdGtkaga8P
         vIk95ciyZhZjplR9OWghTQtet3uQDySl6JI+QjUlALJlimyqYZLKBjHb+BToDB1OxH9Y
         KsiN1gNNwLSiJ2MjKxqwPuqbuCJRgfPncrRMYrQWdD2XPAwDbTp5k46i7UIQ3KrZq4+m
         8wAMwdTyt9akaxN7igUoDORPtxbFF6VyoVk7oDARxxQAkkqW1BDfnoHVFBuF6GAiPIno
         qRwmpwZfdvhx6O1rk5JFRrtHVbJKeR1CRfc94p69/ddzxoBpsrUmR3Wuf2eRVeRq3u9h
         ergA==
X-Gm-Message-State: AOAM533qrMAAgoAvJf1CTvfDTlSRWOtNh0+oRxG7Tee93RAnG/gNGdwu
        AF4bscfkP4VwJ5n4umiJZyIL4wZIQH7LOw==
X-Google-Smtp-Source: ABdhPJymvRReL1XpUtE1gxNlwlYuyosNPNyuLK8qmJIHrxqsXRctomAK42Mx3i1enayZYZ2ktaXC9g==
X-Received: by 2002:a05:620a:897:: with SMTP id b23mr439712qka.88.1628707041157;
        Wed, 11 Aug 2021 11:37:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g22sm12278836qkm.33.2021.08.11.11.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:37:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/2] btrfs: do not do preemptive flushing if the majority is global rsv
Date:   Wed, 11 Aug 2021 14:37:16 -0400
Message-Id: <faca8afcd0564108b1f2fd60c4a24dacc4aa6107.1628706812.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1628706812.git.josef@toxicpanda.com>
References: <cover.1628706812.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

A common characteristic of the bug report where preemptive flushing was
going full tilt was the fact that the vast majority of the free metadata
space was used up by the global reserve.  The hard 90% threshold would
cover the majority of these cases, but to be even smarter we should take
into account how much of the outstanding reservations are covered by the
global block reserve.  If the global block reserve accounts for the vast
majority of outstanding reservations, skip preemptive flushing, as it
will likely just cause churn and pain.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=212185
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index ddb4878e94df..2fce15d58b55 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -741,6 +741,20 @@ static bool need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
 	     global_rsv_size) >= thresh)
 		return false;
 
+	used = space_info->bytes_may_use + space_info->bytes_pinned;
+
+	/* The total reservation belongs to the global rsv, don't flush. */
+	if (global_rsv_size >= used)
+		return false;
+
+	/*
+	 * 128m is 1/4 of the maximum global rsv size.  If we have less than
+	 * that devoted to other reservations then there's no sense in flushing,
+	 * we don't have a lot of things that need flushing.
+	 */
+	if ((used - global_rsv_size) <= SZ_128M)
+		return false;
+
 	/*
 	 * We have tickets queued, bail so we don't compete with the async
 	 * flushers.
-- 
2.26.3

