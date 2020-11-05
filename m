Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527DA2A8827
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Nov 2020 21:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKEUgb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Nov 2020 15:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEUgb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Nov 2020 15:36:31 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91FC0613CF
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Nov 2020 12:36:30 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id i7so2105011qti.6
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Nov 2020 12:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3aitPU02l1dLXBv1nmFuBYqVLkZR8RUjGYHS6MKKac=;
        b=KpT2YTRJSh2JbkF5PO8MOO+wzgdA0e50D55d4Z45cpuWVgq582+RQE8OcPiB3G+w/o
         xm170joWtQzlQ/5obA1FkXRmCY+pUk6XCBOlT/dvpCTmm3WFS/b0dnieojBrt7a7L4Rg
         e8Hujmeb8pul8nnw42u4jBGz1uDYtrJ7T7tYKXqt+isTUAZmW/hBn3mOV2ChlpA3rLPx
         CW+iWJiY0NOck1NmduagHuirj9V2+iaMRtdfnEcMaIhOdmpSCQrPQ8O7v2atODcCBh2l
         TB1x81RTK06BAdYAddvhqR4jBlqiwDfzHK76YlYbV3kZtKMHE26jtcWBiUNp8y3OwvAE
         KSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y3aitPU02l1dLXBv1nmFuBYqVLkZR8RUjGYHS6MKKac=;
        b=L0PfLqCC10OTeA+Rvrr+ZnDPIX+3O0DgcUCS9587kELa5t2vFDxniy+7cjpcUiguOc
         Si+Sngoc1aQCeZmd8iqV0dAqaiCVL3K/Sewxkywjnaf/P2UBu6bfL1WoHWnJOZ43AbpM
         LvvUSB5aHKMXIzW7k9F03JscaQyL4zNGrj+UBdeceUk7HcUAWpxZP7qloUrWui7BDOgJ
         vRCoKpao4EqoLmmTzK33tIJZiv2uNlILUWEM6Pt/8yQzFaZgqFclDcfQTqK2PAu4LEoe
         aVSabzvMhQn5uq20OQ3NsaZ6wA95npwZ+2RMDgpe2EfzklD95QWPfzLkZj+4Dl1w7RcC
         GeWg==
X-Gm-Message-State: AOAM533+GH3p6J59ADJ37smJOwWIXGjlMKzo5hKGzZIytRfGA3B+si21
        2tZ7DJnsrwWjjZipXL78LtU76F5zpwxucCCV
X-Google-Smtp-Source: ABdhPJzo/0pN+augUrgXE3PpXEE/+ANZNVjMCPVhFuczUbKNyA/iTdHIJ7JbB5qfCdiBDELVFJeE2Q==
X-Received: by 2002:ac8:c8c:: with SMTP id n12mr3866131qti.369.1604608588684;
        Thu, 05 Nov 2020 12:36:28 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o1sm591029qkm.102.2020.11.05.12.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 12:36:27 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] btrfs: wait on v1 cache for log replay
Date:   Thu,  5 Nov 2020 15:36:26 -0500
Message-Id: <01bacd1faab24648e9701e34318f7bfd6a1f098b.1604608527.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe reported btrfs/159 and btrfs/201 failures with the latest
misc-next, and bisected it to my change to always async the loading of
the v1 cache.  This is because when replaying the log we expect that the
free space cache will be read entirely before we start excluding space
to replay.  However this obviously changed, and thus we ended up
overwriting things that were allocated during replay.  Fix this by
exporting the helper to wait on v1 space cache and use it for this
exclusion step.  I've audited everywhere else and we are OK with all
other callers.  Anywhere that also required reading the space cache in
its entirety used btrfs_cache_block_group() with load_cache_only set,
which waits for the cache to be loaded.  We do not use that here because
we want to start caching the block group even if we aren't using the
free space inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
Dave, this can be folded into 

	btrfs: async load free space cache

and it'll be good to go.  I validated it fixed the report, just provided the
changelog to explain what happened.

 fs/btrfs/block-group.c | 2 +-
 fs/btrfs/block-group.h | 2 ++
 fs/btrfs/extent-tree.c | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index f19fabae4754..35be6dbca5e8 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -435,7 +435,7 @@ static bool space_cache_v1_done(struct btrfs_block_group *cache)
 	return ret;
 }
 
-static void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
+void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
 				struct btrfs_caching_control *caching_ctl)
 {
 	wait_event(caching_ctl->wait, space_cache_v1_done(cache));
diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index adfd7583a17b..8f74a96074f7 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -268,6 +268,8 @@ void check_system_chunk(struct btrfs_trans_handle *trans, const u64 type);
 u64 btrfs_get_alloc_profile(struct btrfs_fs_info *fs_info, u64 orig_flags);
 void btrfs_put_block_group_cache(struct btrfs_fs_info *info);
 int btrfs_free_block_groups(struct btrfs_fs_info *info);
+void btrfs_wait_space_cache_v1_finished(struct btrfs_block_group *cache,
+				struct btrfs_caching_control *caching_ctl);
 
 static inline u64 btrfs_data_alloc_profile(struct btrfs_fs_info *fs_info)
 {
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d7a68203cda0..5c82cfdb0944 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -2641,6 +2641,11 @@ static int __exclude_logged_extent(struct btrfs_fs_info *fs_info,
 		BUG_ON(!btrfs_block_group_done(block_group));
 		ret = btrfs_remove_free_space(block_group, start, num_bytes);
 	} else {
+		/*
+		 * We must wait for v1 caching to finish, otherwise we may not
+		 * remove our space.
+		 */
+		btrfs_wait_space_cache_v1_finished(block_group, caching_ctl);
 		mutex_lock(&caching_ctl->mutex);
 
 		if (start >= caching_ctl->progress) {
-- 
2.26.2

