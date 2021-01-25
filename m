Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D09302E2E
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Jan 2021 22:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbhAYVoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Jan 2021 16:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732179AbhAYVnS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Jan 2021 16:43:18 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119B6C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 13:42:38 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id t63so1423562qkc.1
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Jan 2021 13:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3VPeS0Sg3Q8+v3wgX+8fkragpLOZtDtYWDmBB8Y/eE=;
        b=xSHDyOYX5f3rZwU9FLUQywklufhCsHaBbgpTK8ecGZartqkIqpwfIFvJELYg2MpzHm
         EAH47uHxHAZVNQsyn/l2WGeQsSM+/9lRiaXCZDrzEzj5JoFpox14gem+Cczf4gw7yztk
         wly2VBEgsj9BoTYnjnW6hQxqk0FfQTsXhDCL1fMx/87c55OuL60QawE3iupaEv8DU4EQ
         76Qra22F+iTEtHfQ65rQN8vCJRnDZBeODdaOW3ugKq8Fiomr6nMNOQK8j39MrSk2mZiI
         BHNSbDbCRFzztQaNmxbEPZpRm8WiVyRUMDstiLraCOK1i89ZhEBNCluYxVsdCrqk2MCH
         qwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I3VPeS0Sg3Q8+v3wgX+8fkragpLOZtDtYWDmBB8Y/eE=;
        b=LrcwSkLYwZ5p6fSbSO7kyUl0m2GICoDRy27DCJ986NrzKMN6zp/hmLhJNKJv+Yp1ny
         bdoxVgSnvcGso9RCl9YDeSdZYrgK0t6GiNRn/pAPwRVYmrh3v5l9UZy79BbboHYrfIA7
         ElYRdIyrfhJIrVagv7NCad0iA/8Q63XWpy/+rUTFQY2cVpE0V29wyyis6ujrRfP0xpjq
         rTkEGHnOlY6HKI4ismlWDySEqDWrV6WyDA7DiL5s9ITlaVVFCrrzyQxaG4l4bPYq9m9u
         QdOcw/8aORkagh0AVCJ4Wjhr+Q5k95s+2CeIa6pw4wh7c4HocBiAAS1uFW+ShYTq9p28
         6yIQ==
X-Gm-Message-State: AOAM530u4czRJbfco/JBRtqsLe00kVnUVxKNBuB/EHCG5G6UoaFSIrUJ
        0jrN8SHYig2OpZpo5Pc9SIBz66sV/CTHMYs9
X-Google-Smtp-Source: ABdhPJxGPjapu+ZgK+q+A3UmaoG++sjrnqArXGSLES9To0ATvdaEgQy6sX6Nbu8qIyu82o+i6WcVaw==
X-Received: by 2002:a05:620a:124c:: with SMTP id a12mr2943773qkl.372.1611610956957;
        Mon, 25 Jan 2021 13:42:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q25sm5016971qkc.23.2021.01.25.13.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:42:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     stable@vger.kernel.org
Subject: [PATCH] btrfs: avoid double put of block group when emptying cluster
Date:   Mon, 25 Jan 2021 16:42:35 -0500
Message-Id: <5ca694ff4f8cff4c0ef6896593a1f1d01fbe956d.1611610947.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In __btrfs_return_cluster_to_free_space we will bail doing the cleanup
of the cluster if the block group we passed in doesn't match the block
group on the cluster.  However we drop a reference to block_group, as
the cluster holds a reference to the block group while it's attached to
the cluster.  If cluster->block_group != block_group however then this
is an extra put, which means we'll go negative and free this block group
down the line, leading to a UAF.

Fix this by simply bailing if the block group we passed in does not
match the block group on the cluster.

CC: stable@vger.kernel.org
Fixes: fa9c0d795f7b ("Btrfs: rework allocation clustering")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/free-space-cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 0d6dcb5ff963..8be36cc6cbd8 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -2711,8 +2711,10 @@ static void __btrfs_return_cluster_to_free_space(
 	struct rb_node *node;
 
 	spin_lock(&cluster->lock);
-	if (cluster->block_group != block_group)
-		goto out;
+	if (cluster->block_group != block_group) {
+		spin_unlock(&cluster->lock);
+		return;
+	}
 
 	cluster->block_group = NULL;
 	cluster->window_start = 0;
@@ -2750,8 +2752,6 @@ static void __btrfs_return_cluster_to_free_space(
 				   entry->offset, &entry->offset_index, bitmap);
 	}
 	cluster->root = RB_ROOT;
-
-out:
 	spin_unlock(&cluster->lock);
 	btrfs_put_block_group(block_group);
 }
-- 
2.26.2

