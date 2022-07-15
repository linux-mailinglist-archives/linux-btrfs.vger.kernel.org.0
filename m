Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92E015767A6
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Jul 2022 21:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiGOTpi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 15 Jul 2022 15:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiGOTph (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 15 Jul 2022 15:45:37 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7158C63935
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:36 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id kh20so4433114qvb.5
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Jul 2022 12:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=dCKjzeRLOYLMFmhiCIGIrTLm9nKcs6CkJtFyBmnwN74=;
        b=L6KlJeZkTx4uQQrsQH1pxZgty/vAmwB6ADbibjZx3o3Hbl/t3KgP2lhIvYa0EWgPaq
         6HWKe/wcqGoUlK1u2Fw7T8hMno+WD273NZA7kZl2V1BW8hpw72ddYmYVUvKTvTrkWVFa
         fU2LNEpCcYYbL+n3thPR9EEdP/JoK8M3Xh/FYbTwA5ojOBaCVqhES76KHxarSPdk/gzD
         EtN2dErNMqJ1DdR2TwuxOmxgCYlgbVScARiZeqzA0F6shsFl5LdYlR6NM+a7Trk+QWES
         TOMGOoSQ5mhcxQCFR6VygnOq6jz0bg/htv49m8DCVYZt/2vdNzTG8rKvAxWalXqBWmfI
         eCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dCKjzeRLOYLMFmhiCIGIrTLm9nKcs6CkJtFyBmnwN74=;
        b=tA7Z0QwaPA6h4KJd8LWEwwfxRQDrNZSj5Z/CpGnVLM4JR4aF3kzmHD4XgA2ObniZW8
         3fLSYWWiYqrt8B1360Mbl2Our7R7Pq0gEcblrdrukGS60BPrd5k5ctFbaALLLKofGQj9
         F1L8xgrs3k6PtKUSPdVOOxliEEh0UfYfROQ1aYsjftBWB+NY9wC5a/8FQkBK1VnQqSV+
         rsnJqdronKw8XSCLwsIAjGTxbUAx8jINdFipz9AxHJ1N+MgWshNPWDKrwCUBTID+q79X
         wyLRRPLdjXqn+LwUV3EJxPUHqvJ1Qsytkk2XzoEpfEHe6eb/aOniCreYSeRb80fMk4Ew
         +UsA==
X-Gm-Message-State: AJIora9C+QAqCqC1ZwdcLHbiIk/Vg4IA2JYs2AVPfsOPveO7XRiTwPNv
        KYKE916pLY+QTO+YrOmET88XbN6txAbFhw==
X-Google-Smtp-Source: AGRyM1sMlVw7hzHMGwofyghbjdZuQosKxnh/u6mm/8+ozaq0awEKPzNMrzKL+UNVPsgzjh1QM5jvvA==
X-Received: by 2002:a05:6214:500b:b0:473:561f:1295 with SMTP id jo11-20020a056214500b00b00473561f1295mr13450094qvb.23.1657914335242;
        Fri, 15 Jul 2022 12:45:35 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006b568bdd7d5sm4304780qko.71.2022.07.15.12.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:45:34 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 3/9] btrfs: handle space_info setting of bg in btrfs_add_bg_to_space_info
Date:   Fri, 15 Jul 2022 15:45:23 -0400
Message-Id: <f23fc4f261b7f033f5eac74d48f36c489f1cf289.1657914198.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1657914198.git.josef@toxicpanda.com>
References: <cover.1657914198.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We previously had the pattern of

btrfs_update_space_info(all, the, bg, fields, &space_info);
link_block_group(bg);
bg->space_info = space_info;

Now that we're passing the bg into btrfs_add_bg_to_space_info we can do
the linking in that function, transforming this to simply

btrfs_add_bg_to_space_info(fs_info, bg);

and put the link_block_group() and bg->space_info assignment directly in
btrfs_add_bg_to_space_info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 26 +++-----------------------
 fs/btrfs/space-info.c  | 13 +++++++++----
 fs/btrfs/space-info.h  |  3 +--
 3 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 36bacf215c22..5669e3cd25c0 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1905,16 +1905,6 @@ static int exclude_super_stripes(struct btrfs_block_group *cache)
 	return 0;
 }
 
-static void link_block_group(struct btrfs_block_group *cache)
-{
-	struct btrfs_space_info *space_info = cache->space_info;
-	int index = btrfs_bg_flags_to_raid_index(cache->flags);
-
-	down_write(&space_info->groups_sem);
-	list_add_tail(&cache->list, &space_info->block_groups[index]);
-	up_write(&space_info->groups_sem);
-}
-
 static struct btrfs_block_group *btrfs_create_block_group_cache(
 		struct btrfs_fs_info *fs_info, u64 start)
 {
@@ -2017,7 +2007,6 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 				int need_clear)
 {
 	struct btrfs_block_group *cache;
-	struct btrfs_space_info *space_info;
 	const bool mixed = btrfs_fs_incompat(info, MIXED_GROUPS);
 	int ret;
 
@@ -2110,11 +2099,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 		goto error;
 	}
 	trace_btrfs_add_block_group(info, cache, 0);
-	btrfs_add_bg_to_space_info(info, cache, &space_info);
-
-	cache->space_info = space_info;
-
-	link_block_group(cache);
+	btrfs_add_bg_to_space_info(info, cache);
 
 	set_avail_alloc_bits(info, cache->flags);
 	if (btrfs_chunk_writeable(info, cache->start)) {
@@ -2138,7 +2123,6 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 {
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
-	struct btrfs_space_info *space_info;
 	struct rb_node *node;
 	int ret = 0;
 
@@ -2179,9 +2163,7 @@ static int fill_dummy_bgs(struct btrfs_fs_info *fs_info)
 			break;
 		}
 
-		btrfs_add_bg_to_space_info(fs_info, bg, &space_info);
-		bg->space_info = space_info;
-		link_block_group(bg);
+		btrfs_add_bg_to_space_info(fs_info, bg);
 
 		set_avail_alloc_bits(fs_info, bg->flags);
 	}
@@ -2559,11 +2541,9 @@ struct btrfs_block_group *btrfs_make_block_group(struct btrfs_trans_handle *tran
 	 * the rbtree, update the space info's counters.
 	 */
 	trace_btrfs_add_block_group(fs_info, cache, 1);
-	btrfs_add_bg_to_space_info(fs_info, cache, &cache->space_info);
+	btrfs_add_bg_to_space_info(fs_info, cache);
 	btrfs_update_global_block_rsv(fs_info);
 
-	link_block_group(cache);
-
 	list_add_tail(&cache->bg_list, &trans->new_bgs);
 	trans->delayed_ref_updates++;
 	btrfs_update_delayed_refs_rsv(trans);
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a9433d19d827..f89aa49f53d4 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -294,11 +294,10 @@ int btrfs_init_space_info(struct btrfs_fs_info *fs_info)
 }
 
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
-				struct btrfs_block_group *block_group,
-				struct btrfs_space_info **space_info)
+				struct btrfs_block_group *block_group)
 {
 	struct btrfs_space_info *found;
-	int factor;
+	int factor, index;
 
 	factor = btrfs_bg_type_to_factor(block_group->flags);
 
@@ -317,7 +316,13 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
 		found->full = 0;
 	btrfs_try_granting_tickets(info, found);
 	spin_unlock(&found->lock);
-	*space_info = found;
+
+	block_group->space_info = found;
+
+	index = btrfs_bg_flags_to_raid_index(block_group->flags);
+	down_write(&found->groups_sem);
+	list_add_tail(&block_group->list, &found->block_groups[index]);
+	up_write(&found->groups_sem);
 }
 
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
index 101e83828ee5..2039096803ed 100644
--- a/fs/btrfs/space-info.h
+++ b/fs/btrfs/space-info.h
@@ -124,8 +124,7 @@ DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
 
 int btrfs_init_space_info(struct btrfs_fs_info *fs_info);
 void btrfs_add_bg_to_space_info(struct btrfs_fs_info *info,
-				struct btrfs_block_group *block_group,
-				struct btrfs_space_info **space_info);
+				struct btrfs_block_group *block_group);
 void btrfs_update_space_info_chunk_size(struct btrfs_space_info *space_info,
 					u64 chunk_size);
 struct btrfs_space_info *btrfs_find_space_info(struct btrfs_fs_info *info,
-- 
2.26.3

