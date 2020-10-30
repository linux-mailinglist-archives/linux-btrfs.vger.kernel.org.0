Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B162A0FE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Oct 2020 22:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgJ3VDc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Oct 2020 17:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727732AbgJ3VDc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Oct 2020 17:03:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B44C0613D2
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:31 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id h12so5180455qtu.1
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Oct 2020 14:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5ZEVCZsB8BcQMqzEFVB5tNTMAaMa97cVIIYifJmf9KA=;
        b=jEJVzNknQXURMVS5NVN7IomvuwjtRR4SsM7bR6NsEo7DBuFwhlQnCnelemDJHUgwix
         4kheoW6BFhMyCFRRhzNsVUDGKwgxuxTmZscRR9wd92Immu3SYvHgvSg3DzLrDhVJkWLe
         oXWnfFoeVZTSBL6l1TSkiWEE0JjrzdlJG4jsQDZBtXIm1KNVY/LcDpLhb7+k5UWZyGYX
         YNihSXQ25T07IIQayNM1/sVRgZxBAok7Z9gycBDKVEb0137eGrfA/LRqzxU3sgNpqptQ
         RN8D2976PoVdUUkbJ+fOSmuagpIXn05rsJWKeYj0pa1k4cuHaBw4PK2UgHdeljQE/2MN
         QNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZEVCZsB8BcQMqzEFVB5tNTMAaMa97cVIIYifJmf9KA=;
        b=ct4yLFehrrqG0N7nQ+b9e3ipyU32yyTt41saHEPWWY5es+XzTI8Pyuhx+WcPchEh6M
         1L+bsb7lLSkAt2dPdQLOJ6T9d6wZ2peaaiA1QpVn1WIKqMrbqyEz8VhYTwKhmINXYScS
         e/ji+batR3anPvHaByrD8SJsOm2udi3kMF5vJJGXd9UKFABLGPqoP4Wuo3mMQy9BEGy3
         iWVMRCDiCV515L/OLxZ/6MBy8PWgRnEta+675YKc3ELxOnydttv1A73CvsD1Cgq418dr
         DYsAfzWd4PMGCTXkdJ4/mz0AcSjox2zhlFCcPnmfdtO60Ca2ZQeg+6xTvFSnebjkbhzv
         lerQ==
X-Gm-Message-State: AOAM532W0jvsH8JiX05nHm5TGFjv2xBkR2ENSaA+YXDUfkTEVkQB1EpT
        GYAstpHE0tx+uRm93urOVJCP2Hv8QtE01GxG
X-Google-Smtp-Source: ABdhPJxy2xTTIVOm+Kl1Qh2z2I4TloTuf6WZLh8Ub9qm2g+vCiJ4kcbPQBcRl9+vr+IdO6Z+fvEnpg==
X-Received: by 2002:ac8:3975:: with SMTP id t50mr4117095qtb.53.1604091810884;
        Fri, 30 Oct 2020 14:03:30 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b8sm3304288qkn.133.2020.10.30.14.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 14:03:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/14] btrfs: pass the root owner and level around for reada
Date:   Fri, 30 Oct 2020 17:03:04 -0400
Message-Id: <2f3fa423ef57986c74b110bb6141cf17c9e44b40.1604091530.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604091530.git.josef@toxicpanda.com>
References: <cover.1604091530.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The reada infrastructure does raw reads of extent buffers, but we're
going to need to know their owner and level in order to set the lockdep
key properly, so plumb in the infrastructure that we'll need to have
this information when we start allocating extent buffers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/reada.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 6e33cb755fa5..83f4e6c53e46 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -52,6 +52,7 @@ struct reada_extctl {
 
 struct reada_extent {
 	u64			logical;
+	u64			owner_root;
 	struct btrfs_key	top;
 	struct list_head	extctl;
 	int 			refcnt;
@@ -59,6 +60,7 @@ struct reada_extent {
 	struct reada_zone	*zones[BTRFS_MAX_MIRRORS];
 	int			nzones;
 	int			scheduled;
+	int			level;
 };
 
 struct reada_zone {
@@ -87,7 +89,8 @@ static void reada_start_machine(struct btrfs_fs_info *fs_info);
 static void __reada_start_machine(struct btrfs_fs_info *fs_info);
 
 static int reada_add_block(struct reada_control *rc, u64 logical,
-			   struct btrfs_key *top, u64 generation);
+			   struct btrfs_key *top, u64 owner_root,
+			   u64 generation, int level);
 
 /* recurses */
 /* in case of err, eb might be NULL */
@@ -165,7 +168,9 @@ static void __readahead_hook(struct btrfs_fs_info *fs_info,
 			if (rec->generation == generation &&
 			    btrfs_comp_cpu_keys(&key, &rc->key_end) < 0 &&
 			    btrfs_comp_cpu_keys(&next_key, &rc->key_start) > 0)
-				reada_add_block(rc, bytenr, &next_key, n_gen);
+				reada_add_block(rc, bytenr, &next_key,
+						btrfs_header_owner(eb), n_gen,
+						btrfs_header_level(eb) - 1);
 		}
 	}
 
@@ -298,7 +303,8 @@ static struct reada_zone *reada_find_zone(struct btrfs_device *dev, u64 logical,
 
 static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 					      u64 logical,
-					      struct btrfs_key *top)
+					      struct btrfs_key *top,
+					      u64 owner_root, int level)
 {
 	int ret;
 	struct reada_extent *re = NULL;
@@ -331,6 +337,8 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 	INIT_LIST_HEAD(&re->extctl);
 	spin_lock_init(&re->lock);
 	re->refcnt = 1;
+	re->owner_root = owner_root;
+	re->level = level;
 
 	/*
 	 * map block
@@ -548,14 +556,15 @@ static void reada_control_release(struct kref *kref)
 }
 
 static int reada_add_block(struct reada_control *rc, u64 logical,
-			   struct btrfs_key *top, u64 generation)
+			   struct btrfs_key *top, u64 owner_root,
+			   u64 generation, int level)
 {
 	struct btrfs_fs_info *fs_info = rc->fs_info;
 	struct reada_extent *re;
 	struct reada_extctl *rec;
 
 	/* takes one ref */
-	re = reada_find_extent(fs_info, logical, top);
+	re = reada_find_extent(fs_info, logical, top, owner_root, level);
 	if (!re)
 		return -1;
 
@@ -947,6 +956,7 @@ struct reada_control *btrfs_reada_add(struct btrfs_root *root,
 	u64 start;
 	u64 generation;
 	int ret;
+	int level;
 	struct extent_buffer *node;
 	static struct btrfs_key max_key = {
 		.objectid = (u64)-1,
@@ -969,9 +979,11 @@ struct reada_control *btrfs_reada_add(struct btrfs_root *root,
 	node = btrfs_root_node(root);
 	start = node->start;
 	generation = btrfs_header_generation(node);
+	level = btrfs_header_level(node);
 	free_extent_buffer(node);
 
-	ret = reada_add_block(rc, start, &max_key, generation);
+	ret = reada_add_block(rc, start, &max_key,
+			      root->root_key.objectid, generation, level);
 	if (ret) {
 		kfree(rc);
 		return ERR_PTR(ret);
-- 
2.26.2

