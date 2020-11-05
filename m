Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A66C2A8288
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 16:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbgKEPps (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 10:45:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731495AbgKEPps (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 10:45:48 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBEECC0613D2
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 07:45:46 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id a65so1528540qkg.13
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 07:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5ZEVCZsB8BcQMqzEFVB5tNTMAaMa97cVIIYifJmf9KA=;
        b=Z2iImjtPd/zh62sJBrfAxMDGh+fd2p8HwlD2GTrA6lr2oEQoMAfMbwzRkPB6SK7798
         jGBr9dcVJKpGt+xZbSuNHcZ/z0zoAdWSUv88hB++2d7sBO+MRsuXJK4yvScSSkuDZDkn
         lzolJZ+sqtz8YAAG3CpOpHsr257j6PtrUy3fCJmT0DENQXb63dzxRODI8WrLvebWRYOv
         GTMUH7KnB6hjUqkMdZEzygk2LGxhQwxvQPMJFAVpzS0elZOxKGYPNfX979Xahq96dCJ5
         MHRcEn3sOuK538HnyeESrrGO6Of1GQzW6vPUqcX+CVNVw5zmS20m+vMDH39ry6ubm5Cs
         ZFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ZEVCZsB8BcQMqzEFVB5tNTMAaMa97cVIIYifJmf9KA=;
        b=p3mX5uLWSxYc7eSgM+Br9dfO4HR8R1o4fn9Re62s0LtL69xRq8kxbzCVhdnMU66OUT
         EFIWeC00X52aGziO8oDHWkeP4/NODfhsxzamEq1OPm5n7OocXjErQCV6ZAiHRKsIfiGM
         G+PFX6OB/WTP6Q5xaScI3UV41L7oweUpfYd5I2wm878kx1KsU+g/bwQYJNssF7K8SkLi
         hm+EiAeSpoalwfc9xXNjxXX77Sd7uKyxAVUepBkokfQfw/VIZfJC/tQHyRfl20bxBL5P
         J4v/P4+lmSAci2ELXGJgavNv/gmGkzIxaLHd0wQok/xgdd9vXROJGNz1Da9XyPWv0Ci7
         0Qpw==
X-Gm-Message-State: AOAM530L/CqkRuTyI37LQETp6guyjMGvIwP0jHXZabwQ5H+fMpTZrYZJ
        FWYUo51KPEfWSb6x6iJfF/rRkAKS2FrfLvgd
X-Google-Smtp-Source: ABdhPJxuj/HUXWn2g+nQgy6AWmHHuHhBmMB3gWRrRyOZBbOY4Xr3cDH0qiXpAQ9YaEUk8rbDmr94kQ==
X-Received: by 2002:a37:84d:: with SMTP id 74mr2616784qki.18.1604591145852;
        Thu, 05 Nov 2020 07:45:45 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id g191sm1293146qke.86.2020.11.05.07.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 07:45:45 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/14] btrfs: pass the root owner and level around for reada
Date:   Thu,  5 Nov 2020 10:45:19 -0500
Message-Id: <d9e961bc71196e5c1baa807759259231aa132b57.1604591048.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
References: <cover.1604591048.git.josef@toxicpanda.com>
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

