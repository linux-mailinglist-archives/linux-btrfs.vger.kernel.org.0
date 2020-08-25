Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC8E252248
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 22:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgHYU5M (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 16:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgHYU5D (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 16:57:03 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654B5C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 13:57:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so158335qka.3
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Aug 2020 13:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJhSH3X8Kzv4xSYtpufZs8w5uHg9MhXpgcAfOaJojew=;
        b=A29ypI+qVvZ1uJabI9gG9ab4KaFnFTlxX+6SCJ+QD+tVUygmPI3qwIZLubogeQgd3K
         UbPI3uu7lmEZtJsV+W7A9sHdf0x0nrnVfYfZxfNC3gfjiHHFff2q0V5stx59Rzy8RXcY
         ozIPLuI/Qz+yyeHpmYtNqIbymTF5FYp4ZPkTHVvhvtVeVReQ/6PCk+l0H2dHDY92lsbu
         JumUMI0h+7eeocJSqvo7qPI0qEBAL3upemKNQmEofHUtFgy/XVpvDTIANa5dlcWmXMqV
         he5GKd1UwA4sjT0J+yedczlZlNnXzpb2rmhpuNC/CaU+cey8H9S3IKs2WHz16iuV1UjY
         CMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wJhSH3X8Kzv4xSYtpufZs8w5uHg9MhXpgcAfOaJojew=;
        b=Id7qfb5J94V+KMQkiuVobnqkVL6SZlnw2Oldd1U1waKjjpFOAWKen228r0SYXTJRDd
         BsjT4Eln9vfP7W/oSC+/qR0oZnN1+qxdqhveI4Pie1nlZFPdhNnqgqsq4DDjodffm+t/
         hnA7sSYhj2CqqxZ57xtJF08WSGgPGwwODz2PxkJFbtakaYJ3v3t2TD3WcgJAY8rSeujF
         3Umw+rEd4ElwyDgmgEtCtWOUeG3rjP1ONchTh+tAbizSNytrdxNNr9h7ZHQc1Clf0wKm
         +KKsAQh+Y6Mo/G5rzOQoaS3qpI8xMoo2NBzy1NOobLI2hhQZE39MjA8pcIl1d0lA3cWU
         uX5A==
X-Gm-Message-State: AOAM532joWeQzhVibQ9fWc6OS/rPlCYhRMC51G1d6r6mxezcDIbH6Pvc
        20KIuINK8uCRTJsWz00GZtCIwZbFbIj2ofJD
X-Google-Smtp-Source: ABdhPJzyzM2Mfp4hZRvrWPEVzyrL5yzssrdJ1lXNtadqo+sZdVlacErDPDFnOZLyR6DpYO5IbVncHg==
X-Received: by 2002:ae9:df85:: with SMTP id t127mr11612747qkf.265.1598389021386;
        Tue, 25 Aug 2020 13:57:01 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z2sm35882qki.67.2020.08.25.13.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:57:00 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix possible infinite loop in data async reclaim
Date:   Tue, 25 Aug 2020 16:56:59 -0400
Message-Id: <24f846bc8860cab91ca134d0a337cc290589a092.1598389008.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dave reported an issue where generic/102 would sometimes hang.  This
turned out to be because we'd get into this spot where we were no longer
making progress on data reservations because our exit condition was not
met.  The log is basically

while (!space_info->full && !list_empty(&space_info->tickets))
	flush_space(space_info, flush_state);

where flush state is our various flush states, but doesn't include
ALLOC_CHUNK_FORCE.  This is because we actually lead with allocating
chunks, and so the assumption was that once you got to the actual
flushing states you could no longer allocate chunks.  This was a stupid
assumption, because you could have deleted block groups that would be
reclaimed by a transaction commit, thus unsetting space_info->full.
This is essentially what happens with generic/102, and so sometimes
you'd get stuck in the flushing loop because we weren't allocating
chunks, but flushing space wasn't giving us what we needed to make
progress.

Fix this by adding ALLOC_CHUNK_FORCE to the end of our flushing states,
that way we will eventually bail out because we did end up with
space_info->full if we free'd a chunk previously.  Otherwise, as is the
case for this test, we'll allocate our chunk and continue on our happy
merry way.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/space-info.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 71aa9e0de61e..b733718f45d3 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1044,12 +1044,18 @@ static void btrfs_async_reclaim_metadata_space(struct work_struct *work)
  *   total_bytes_pinned < reservation we will not commit.  This is why the
  *   previous states are actually important, to make sure we know for sure
  *   whether committing the transaction will allow us to make progress.
+ *
+ * ALLOC_CHUNK_FORCE
+ *   For data we start with alloc chunk force, however we could have been full
+ *   before, and then the transaction commit could have freed new block groups,
+ *   so if we now have space to allocate do the force chunk allocation.
  */
 static const enum btrfs_flush_state data_flush_states[] = {
 	FLUSH_DELALLOC_WAIT,
 	RUN_DELAYED_IPUTS,
 	FLUSH_DELAYED_REFS,
 	COMMIT_TRANS,
+	ALLOC_CHUNK_FORCE,
 };
 
 static void btrfs_async_reclaim_data_space(struct work_struct *work)
-- 
2.24.1

