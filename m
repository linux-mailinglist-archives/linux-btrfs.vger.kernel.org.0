Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D605B90C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 01:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiINXFE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 19:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiINXFA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 19:05:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E1113CCB
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:04:57 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id y2so9577760qkl.11
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 16:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=elbwdiugwDNmnfD9IJQXpsoDFQkYkBw7C+z9JZrCvqg=;
        b=UwBct/kQ3gUHDWg/6DSTG0lu9NlxP3k5D6VV8f7TOfItyrwbaGHw6yJQu5hW6u6Blg
         Oma/bG96L1qGuHy7Pv6JTP3iZgc8mA9LJ5ZX8puB4vZs2qd30bZzh5jezCQg+5imKmK+
         7GGHpZBlVrIygM1PMUKxh5Qhi49yVokCKhhzf0AZSm41c7Q5BOdWGgtZ9XRgWLeWppTl
         K50ZGey6yHOkuUv8YaVG8uAjgcjcTrP/gl53dBKXfxz5XwfRuHu9n+v7G9SpprSroWp6
         tfYJEJSN505kmPesf2GsgoKcLp022SFVS+Ev38aOF9oNWHNCxyjNe6SfmIh2k5tzDBPg
         Tibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=elbwdiugwDNmnfD9IJQXpsoDFQkYkBw7C+z9JZrCvqg=;
        b=BdbQUhGrSBhP2ST8uHabE26WGBzvP9JPmO00RHorD1E0gyPe1zv2MFVM891T+g7N64
         d/Ygu1lIojKe4Bcz7fV9LeaFnVAoVP1S0i3m3xBIUC2qlF7eum0unmH1ECn3/XgEHt92
         AiiNQ7E70qPTvvJNYNL+Kb9aCMDJ9s0XAsRYI5EP0U3yLltlopIA2rrV75viUZLI3RTt
         uVHu4t1PMwRaREW7SLnJtT6lBG1P5KTItEehhVksp33VuNPIP+ucZGJxlIUbmRlYEfa8
         hwO7PPNXASWCJh4J0dTF+eba5iXJ7m9Pt+6VLFKt3jUenIvcuQBaSA3Ugo4/IePy9mle
         ovqQ==
X-Gm-Message-State: ACgBeo1Eg1c4Hs6UZlR24WlGIPSq3izCwUm7eR5qFxfKjMJWGdUOmS4e
        NMW0mcftKV5A4+4Oh2sF56Rxu97Xa8Bg8Q==
X-Google-Smtp-Source: AA6agR53rgdiU+0YmMLLjetG9SGEYrPc4UBRpdDyENNJj9s2UMpnpHsWIZwWGwXWBfsPXUXhpv9Vbg==
X-Received: by 2002:a05:620a:2891:b0:6bc:5c73:9728 with SMTP id j17-20020a05620a289100b006bc5c739728mr27979319qkp.178.1663196695933;
        Wed, 14 Sep 2022 16:04:55 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bs14-20020a05620a470e00b006b58d8f6181sm2761480qkb.72.2022.09.14.16.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 16:04:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 02/15] btrfs: move btrfs_full_stripe_locks_tree into block-group.h
Date:   Wed, 14 Sep 2022 19:04:38 -0400
Message-Id: <6f4bd25183fd8844b5592259971ed4e060d9018c.1663196541.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663196541.git.josef@toxicpanda.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
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

This is actually embedded in struct btrfs_block_group, so move this
definition to block-group.h, and then open-code the init of the tree
where we init the rest of the block group instead of using a helper.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c |  3 ++-
 fs/btrfs/block-group.h |  8 ++++++++
 fs/btrfs/ctree.h       | 14 --------------
 3 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 20da92ae5c6b..e21382a13fe4 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1940,7 +1940,8 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 	btrfs_init_free_space_ctl(cache, cache->free_space_ctl);
 	atomic_set(&cache->frozen, 0);
 	mutex_init(&cache->free_space_lock);
-	btrfs_init_full_stripe_locks_tree(&cache->full_stripe_locks_root);
+	cache->full_stripe_locks_root.root = RB_ROOT;
+	mutex_init(&cache->full_stripe_locks_root.lock);
 
 	return cache;
 }
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 558fa0a21fb4..6c970a486b68 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -76,6 +76,14 @@ struct btrfs_caching_control {
 /* Once caching_thread() finds this much free space, it will wake up waiters. */
 #define CACHING_CTL_WAKE_UP SZ_2M
 
+/*
+ * Tree to record all locked full stripes of a RAID5/6 block group
+ */
+struct btrfs_full_stripe_locks_tree {
+	struct rb_root root;
+	struct mutex lock;
+};
+
 struct btrfs_block_group {
 	struct btrfs_fs_info *fs_info;
 	struct inode *inode;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 725c187d5c4b..12d626e78182 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -180,14 +180,6 @@ struct btrfs_free_cluster {
 	struct list_head block_group_list;
 };
 
-/*
- * Tree to record all locked full stripes of a RAID5/6 block group
- */
-struct btrfs_full_stripe_locks_tree {
-	struct rb_root root;
-	struct mutex lock;
-};
-
 /* Discard control. */
 /*
  * Async discard uses multiple lists to differentiate the discard filter
@@ -1944,12 +1936,6 @@ int btrfs_scrub_cancel(struct btrfs_fs_info *info);
 int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
-static inline void btrfs_init_full_stripe_locks_tree(
-			struct btrfs_full_stripe_locks_tree *locks_root)
-{
-	locks_root->root = RB_ROOT;
-	mutex_init(&locks_root->lock);
-}
 
 /* dev-replace.c */
 void btrfs_bio_counter_inc_blocked(struct btrfs_fs_info *fs_info);
-- 
2.26.3

