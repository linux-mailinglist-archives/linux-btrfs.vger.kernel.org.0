Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 110C3211440
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jul 2020 22:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgGAUWW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jul 2020 16:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgGAUWW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jul 2020 16:22:22 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54809C08C5C1
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jul 2020 13:22:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z2so19519319qts.5
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jul 2020 13:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oe88R6rqbSmyYtr0233SQXb2lRGdY8cnxs3q04w3ctU=;
        b=uFRSE5GY260twrnfZVTR8KkqFCtkfalRY9kbns8JeDnXsU5UFmpoig9T6AABvDCD33
         /OcT3BaA85rmHISqvZ/0MeUC0Mx0IRBjogxuofr/ORPQTdhn4gB55e42lHQAkwJlPkAk
         Jvi9ebWc2bTQbil5qXx4PLwPUVzenRLdQMv3WW7fhDHAnQQyZ76mpNchNo12pBCnJI3P
         lxl/UW3mWxhcdzkVq6GDeUL2zpPQGNnjW6uqnGp2UJx0K+NmV9p1lfewPl/hH5BrRpX+
         gbbLRlQ0ImhGnkkWBEmcitHK0kqOkPSpEW/BurHTNtqcmtwB9uZeDjuh0JqEA2nrtDRM
         dMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oe88R6rqbSmyYtr0233SQXb2lRGdY8cnxs3q04w3ctU=;
        b=fJdUtU+nLCB966oz1dIshXvr7jTgBNFEwh6yN40rgId1QeM0z3OvoLrhBRhVyundaT
         7pyBJaEzySGVlLYnzwFaTxgdmoZwco0+wyfftAanzqiLTkibcPmV6Pdl6uAGF/JsmH3b
         UQJ7a9C0O0Tk5HfWDjy+hnvaYzOACjEFA+qdoGy50tC2fFcopt7Sl+VgkLjc7i1nGETD
         HaKjH2z9YFLQ+oR86SdgU0d10UdmHbwjmGs/iAYRG/FDPxWPUOiwie8dYLxLyiR5ZT6h
         yB24CLmResE101HmVkDRH2OaxgXTrGhoCbXTEl0zopizZT7eriZUIb6Q5CFd7XWCx02d
         6HiQ==
X-Gm-Message-State: AOAM531IyTqjyIsfvIbCccbqSee6piWCeqJ52Ta3FC3P/IkcUcgT61ib
        jEAm2BzTiPEcxdWrirr/TQsxhI8gDAvy5w==
X-Google-Smtp-Source: ABdhPJywSc6bzRD4OWPzEZ+INBJWnRw5rIonMA1lxSH9aIM49U4Y3KrSM5O+0ZJybjeIFhbE0RhCjg==
X-Received: by 2002:ac8:6742:: with SMTP id n2mr28518725qtp.362.1593634941095;
        Wed, 01 Jul 2020 13:22:21 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g5sm7300180qta.46.2020.07.01.13.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 13:22:20 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: convert block group refcount to refcount_t
Date:   Wed,  1 Jul 2020 16:22:18 -0400
Message-Id: <20200701202219.11984-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was experimenting with some new allocator changes and I noticed that I
was getting a UAF with the block groups.  In order to help figure this
out I converted the block group to use the refcount_t infrastructure.
This is a generally good idea anyway, so kill the atomic and use
refcount_t so we can get the benefit of loud complaints when refcounting
goes wrong.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 8 ++++----
 fs/btrfs/block-group.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 09b796a081dd..7c0075413b08 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -118,12 +118,12 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
 
 void btrfs_get_block_group(struct btrfs_block_group *cache)
 {
-	atomic_inc(&cache->count);
+	refcount_inc(&cache->count);
 }
 
 void btrfs_put_block_group(struct btrfs_block_group *cache)
 {
-	if (atomic_dec_and_test(&cache->count)) {
+	if (refcount_dec_and_test(&cache->count)) {
 		WARN_ON(cache->pinned > 0);
 		WARN_ON(cache->reserved > 0);
 
@@ -1805,7 +1805,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 
 	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
 
-	atomic_set(&cache->count, 1);
+	refcount_set(&cache->count, 1);
 	spin_lock_init(&cache->lock);
 	init_rwsem(&cache->data_rwsem);
 	INIT_LIST_HEAD(&cache->list);
@@ -3427,7 +3427,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		ASSERT(list_empty(&block_group->dirty_list));
 		ASSERT(list_empty(&block_group->io_list));
 		ASSERT(list_empty(&block_group->bg_list));
-		ASSERT(atomic_read(&block_group->count) == 1);
+		ASSERT(refcount_read(&block_group->count) == 1);
 		btrfs_put_block_group(block_group);
 
 		spin_lock(&info->block_group_cache_lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index b6ee70a039c7..705e48050163 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -115,7 +115,7 @@ struct btrfs_block_group {
 	struct list_head list;
 
 	/* Usage count */
-	atomic_t count;
+	refcount_t count;
 
 	/*
 	 * List of struct btrfs_free_clusters for this block group.
-- 
2.24.1

