Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69BE12DC49B
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Dec 2020 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgLPQuU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Dec 2020 11:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgLPQuU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Dec 2020 11:50:20 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F26C0617A6
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:39 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id y15so17666587qtv.5
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Dec 2020 08:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=hSgyk6WFKYPfFgTIZUe26+LsjxefCswJce9lzbwUkiA=;
        b=FCkaJs5pazo9YE2TevtrlyDEhs5UCSuHdQTMMSCjP7/T3oZ03P6hNG4lPTmHT3QXWO
         eucoF9Fr/0Glp739UhwgTSleAhy0Mf6sKuEpQrLIwcYwvLfljbjDaXOh76oVFXr8bpTW
         V+t4DKa3Rwgh5tKqLhqrkH3I6IIkZ6n22wAVJppzpBytv+mQqXnDsJvLAuaGcdB1sARj
         g8LPOaWf7+eU7huVUNnvor2OSd0YOtwO1gL/gAZOOUC4hEsfJXqLPHTFPyUt6pXRzEv1
         ltwjbnMwBnIgD1q2BruW0jOTwgJCb0I1w3nvZagIQPaJoqzb3TnMH4p6oUjGywevIgQj
         UZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSgyk6WFKYPfFgTIZUe26+LsjxefCswJce9lzbwUkiA=;
        b=o2tEP1RGn7HQXadFSayo/Nrleu/VBQZliCJLLi8G2DIPmjcdByAbGSMipKMM0MO5Jm
         yuN9wyAK8S2zKdQepDwEWFEJpo7j9aJJ68EoQEHGdVyqC21UPPZlRU+36lJZaxvvLOOL
         4TfNUhtB3f9zjmoYIEC8znj9N0g8k4FlSFckjinrOHDhhBkvDyKorGddSVc1gl8DuuJe
         NOc5qGUKuXqVX9ISmllYi/KPzQ85f+4JOwsPjdJtwvEPSxLEoIKAADOWmud7+7dkYhmF
         rlTQfXT/9R1fpNHtJDyduI0dvk3pxOb0R0YCrL6LCSiFMuvRSBhE8kczgMRGQpMSqrzu
         FyGg==
X-Gm-Message-State: AOAM532QTFq9Tf18vHp88nFne+V9RhifxmUOaI0Z8MzIH/nj9R8aqg+M
        tKjdGxxMQp3nyfLYL0PZmsmti4PvL2Vc8rrf
X-Google-Smtp-Source: ABdhPJwAwzQrzrOQaQXKCfltAP4zH2UfukJTnnJjumEKvSQ2z5L2h9K4X1ZA1XYqT92lDXjnasDJRw==
X-Received: by 2002:ac8:44d8:: with SMTP id b24mr42523179qto.339.1608137378606;
        Wed, 16 Dec 2020 08:49:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b12sm1272029qtj.12.2020.12.16.08.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 08:49:38 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 1/6] btrfs: do not block on deleted bgs mutex in the cleaner
Date:   Wed, 16 Dec 2020 11:49:29 -0500
Message-Id: <97ae17159b0c41e04630bf5449df91d0a1993f2e.1608137316.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1608137316.git.josef@toxicpanda.com>
References: <cover.1608137316.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While running some stress tests I started getting hung task messages.
This is because the delete unused bg's code has to take the
delete_unused_bgs_mutex to do it's work, which is taken by balance to
make sure we don't delete block groups while we're balancing.

The problem is a balance can take a while, and so we were getting hung
task warnings.  We don't need to block and run these things, and the
cleaner is needed to do other work, so trylock on this mutex and just
bail if we can't acquire it right away.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 52f2198d44c9..f61e275bd792 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1254,6 +1254,13 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 	if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))
 		return;
 
+	/*
+	 * Long running balances can keep us blocked here for eternity, so
+	 * simply skip deletion if we're unable to get the mutex.
+	 */
+	if (!mutex_trylock(&fs_info->delete_unused_bgs_mutex))
+		return;
+
 	spin_lock(&fs_info->unused_bgs_lock);
 	while (!list_empty(&fs_info->unused_bgs)) {
 		int trimming;
@@ -1273,8 +1280,6 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 
 		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
 
-		mutex_lock(&fs_info->delete_unused_bgs_mutex);
-
 		/* Don't want to race with allocators so take the groups_sem */
 		down_write(&space_info->groups_sem);
 
@@ -1420,11 +1425,11 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
 end_trans:
 		btrfs_end_transaction(trans);
 next:
-		mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 		btrfs_put_block_group(block_group);
 		spin_lock(&fs_info->unused_bgs_lock);
 	}
 	spin_unlock(&fs_info->unused_bgs_lock);
+	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
 	return;
 
 flip_async:
-- 
2.26.2

