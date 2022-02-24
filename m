Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD34C300B
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Feb 2022 16:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236455AbiBXPll (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Feb 2022 10:41:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236454AbiBXPlk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Feb 2022 10:41:40 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A695723585F
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 07:41:09 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id bu6so4167536qvb.10
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Feb 2022 07:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7r4K0rZS4+PN/0Pmp82yZKqaha1AK0HPlEsr3ge8Aw=;
        b=Mzut1DVz+btJakKGWPWa80hvlk4bXj5zcTumY8Iz6v/uz9CeBCd8BmoVkYUbrPxqfe
         cIiEHnfsxkYcVEIbFUH/1Vaq/1MYEjqarf87KHewzelQdKIi4FFqS9ZdynjtZxCC3jE4
         D4V2jTFTH9dc1A6gNDASgVniQ7iYcINuqvI8O5hCR/aJjCK5Xu8sfMgOXeGV8vNI4EYr
         HalbghGXbjwMKUgdJEGlt6zmREETHf7WBSdvdqmsRy1/TPHwGOgy0gLAWoD06zPfHbUZ
         uqYc0C6g++bM3svB1WtbH/HF4+ST/YBF6HW3SJKRYCZNUWAkYMe68Ild5BFdrQ6Hvo0n
         p5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=G7r4K0rZS4+PN/0Pmp82yZKqaha1AK0HPlEsr3ge8Aw=;
        b=XDVqbhoQKz/ikP5tKuSAvU/k8Hlr9tGC9zfBzLm6xPN1Ia1XixOEvHfulzhyb66MQ1
         wd+3jq2ZDTSnioJRwilvyovAUI+WscWgiAmDmjWtZzbKF65gUHSoQqENpBu4I5M7ZDL+
         Je6p21ZDEopsVgSgPGTQbIPR8vEVZmCfq5jLLTe112V2ZYSKAjINBH5TNoSA+/gVwqzV
         PSJUaxjq4uEEhXCeffg58RAScBVklBVTwn65BfSFZ9dFdS0fSco8PhZFxwigALc93dPj
         tlKSaQvVD/10SfrVIwBZbZr0bk5pB5DmqDGHeWDriIVEJ77z45M2zaUttxJShC90a4LW
         Xtsw==
X-Gm-Message-State: AOAM531M3iEZvn+38l0IPGLWhN0GYnFQvrSZ6xjKJY0ZEv+1dNWesuVR
        fyjCiQCNDAGJGFwLYXPnIFsQR7P0WRb8iR3I
X-Google-Smtp-Source: ABdhPJyCXSBTenbHlbrBouWyis11G6PnTKKopi1lF/8xxpsiKRwcNLX6L832hRfasNN7++1qE7e9zQ==
X-Received: by 2002:a05:6214:a8a:b0:430:8fbc:6be2 with SMTP id ev10-20020a0562140a8a00b004308fbc6be2mr2402992qvb.7.1645717268440;
        Thu, 24 Feb 2022 07:41:08 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 69sm1419269qkd.91.2022.02.24.07.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:41:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: fix UAF in btrfs_drop_snapshot
Date:   Thu, 24 Feb 2022 10:41:06 -0500
Message-Id: <ae224a6030d984c20e09093e6f93a0f33e757cd3.1645717258.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is for the KASAN report for my in progress snapshot drop fix, this
should apply cleanly to the existing patch.  At this point root could
have been free'd, so we need to check if we're an unfinished drop before
we start the drop and use that variable to see if we need to wake
anybody up.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent-tree.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index e94b8f168a85..b7b49b4eb68d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -5621,6 +5621,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	int ret;
 	int level;
 	bool root_dropped = false;
+	bool unfinished_drop = false;
 
 	btrfs_debug(fs_info, "Drop subvolume %llu", root->root_key.objectid);
 
@@ -5663,6 +5664,8 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	 * already dropped.
 	 */
 	set_bit(BTRFS_ROOT_DELETING, &root->state);
+	unfinished_drop = test_bit(BTRFS_ROOT_UNFINISHED_DROP, &root->state);
+
 	if (btrfs_disk_key_objectid(&root_item->drop_progress) == 0) {
 		level = btrfs_header_level(root->node);
 		path->nodes[level] = btrfs_lock_root_node(root);
@@ -5841,7 +5844,7 @@ int btrfs_drop_snapshot(struct btrfs_root *root, int update_ref, int for_reloc)
 	 * We were an unfinished drop root, check to see if there are any
 	 * pending, and if not clear and wake up any waiters.
 	 */
-	if (!err && test_bit(BTRFS_ROOT_UNFINISHED_DROP, &root->state))
+	if (!err && unfinished_drop)
 		btrfs_maybe_wake_unfinished_drop(fs_info);
 
 	/*
-- 
2.26.3

