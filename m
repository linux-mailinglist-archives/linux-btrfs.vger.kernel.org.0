Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF67215819
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jul 2020 15:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgGFNOQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jul 2020 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGFNOQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 Jul 2020 09:14:16 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EE3C061794
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Jul 2020 06:14:16 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m8so12917423qvk.7
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Jul 2020 06:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kPd+wuKdPicCSKRBKJoeXOZxadBuqbmWtE9B9TN0wGI=;
        b=1SiYi4ML0Vp4Tgbl1pbUWwzxy7sj+9VSfd1SEw80aI+djUrrISzBZ7nX1MVnVNVlsf
         Uo7vkdLzIVNTanTnzPNB+R6kLSSPn3ht5RTSsIJhgDYFwWwNvENp9MDX2Tzz0RORdfj8
         4oxFnQ9aKQfwXCWHqbFiMzQ5f+3PqH3SV+cRcOgEakI+52QiiTYjEFNXudYLBa/VV0Fr
         RdeD+Aj7fCFo+LS75EnJyBGuMKjmwXMI94rY1Bj1+U8sAjcv+0WWpetv7zkWeoJEb2ZM
         OM7ju8fwfBr55MsywWbDCjN2Q31wqaldAQp6RTBhnv5kDL1aMOeCpUsSzxB2/wMuX7Kd
         68bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kPd+wuKdPicCSKRBKJoeXOZxadBuqbmWtE9B9TN0wGI=;
        b=uPnXMNcmV3z7D3irDFs4vio4t0vo2fV3ooOtKtii1mTRuNd/QPiKUbX8qvyOFlrkpD
         phf/unDvFjtaCLyt6YejOkyLEPHflsrnf8CcdyTNea4W1YH7/qqCfYjTx9zRa3k37WZ+
         7YdgcMkN3W3ocGvdUW5EYt74tGddMEogkUv5iFt1jOFVV3KjyRHwu9C+E9sxj/BF49x2
         7ImX4oAHkDcn1jCSfWXYMO9sWAD/cWbzSstnnS1OglWsmAdj5A4dYXZRW2yKT/UOSbGG
         kAYjSYRyNhDOC4a2Jx1vr+WD1X2jppyFdOHqgMFRUjvwjScbrUq2f7a6mYxtedLwx56C
         C9Ig==
X-Gm-Message-State: AOAM531CqtxLXif3hoRVsBesfoOLUapcuOBrorVq4cVTtwPaehq11XDt
        1RvI+iJWURNHyH/pCaV+plRs6Z6biEWhFg==
X-Google-Smtp-Source: ABdhPJz0UxwdY+VmF1KL1D/FaVidSNyjIcetgOZI4nMj7aa2PjVlvoEVCNwRXTU8i80hiyMqG3wQVg==
X-Received: by 2002:ad4:5148:: with SMTP id g8mr8190318qvq.173.1594041254943;
        Mon, 06 Jul 2020 06:14:14 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n64sm19497087qke.77.2020.07.06.06.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:14:14 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Filipe Manana <fdmanana@suse.com>
Subject: [PATCH 1/2][v2] btrfs: convert block group refcount to refcount_t
Date:   Mon,  6 Jul 2020 09:14:11 -0400
Message-Id: <20200706131412.28870-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We have refcount_t now with the associated library to handle refcounts,
which gives us extra debugging around reference count mistakes that may
be made.  For example it'll warn on any transition from 0->1 or 0->-1,
which is handy for noticing cases where we've messed up reference
counting.  Convert the block group ref counting from an atomic_t to
refcount_t and use the appropriate helpers.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- rename ->count to ->refs.
- updated commit message.

 fs/btrfs/block-group.c | 8 ++++----
 fs/btrfs/block-group.h | 3 +--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 3aa78952a2b7..0a67a50f448a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -118,12 +118,12 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags)
 
 void btrfs_get_block_group(struct btrfs_block_group *cache)
 {
-	atomic_inc(&cache->count);
+	refcount_inc(&cache->refs);
 }
 
 void btrfs_put_block_group(struct btrfs_block_group *cache)
 {
-	if (atomic_dec_and_test(&cache->count)) {
+	if (refcount_dec_and_test(&cache->refs)) {
 		WARN_ON(cache->pinned > 0);
 		WARN_ON(cache->reserved > 0);
 
@@ -1805,7 +1805,7 @@ static struct btrfs_block_group *btrfs_create_block_group_cache(
 
 	cache->discard_index = BTRFS_DISCARD_INDEX_UNUSED;
 
-	atomic_set(&cache->count, 1);
+	refcount_set(&cache->refs, 1);
 	spin_lock_init(&cache->lock);
 	init_rwsem(&cache->data_rwsem);
 	INIT_LIST_HEAD(&cache->list);
@@ -3428,7 +3428,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *info)
 		ASSERT(list_empty(&block_group->dirty_list));
 		ASSERT(list_empty(&block_group->io_list));
 		ASSERT(list_empty(&block_group->bg_list));
-		ASSERT(atomic_read(&block_group->count) == 1);
+		ASSERT(refcount_read(&block_group->refs) == 1);
 		btrfs_put_block_group(block_group);
 
 		spin_lock(&info->block_group_cache_lock);
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index b6ee70a039c7..adfd7583a17b 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -114,8 +114,7 @@ struct btrfs_block_group {
 	/* For block groups in the same raid type */
 	struct list_head list;
 
-	/* Usage count */
-	atomic_t count;
+	refcount_t refs;
 
 	/*
 	 * List of struct btrfs_free_clusters for this block group.
-- 
2.24.1

