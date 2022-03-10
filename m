Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1C4D5105
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 18:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245250AbiCJR73 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Mar 2022 12:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245230AbiCJR71 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Mar 2022 12:59:27 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E65E98D0
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 09:58:25 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id 11so5262926qtt.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Mar 2022 09:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lGIrdXfDgI7/IaYeWO5Gp9h1nGp73Y+o9HAEbIa6JGM=;
        b=RvNDuBsJ0JTGQbN0VRsXpn8psuerw8ccoY/dLowogq/qfeGRpC053wlCctHlQS0cX4
         WCQAF1z5snV2IfjREebGDcpmNMoIdT/EcW4l8ZbH3he7wuzZVdbLmhDfUV6XlcYvTlqd
         J3tEOc7nd4emzQTaUZKMfdXvrFC5mCnJVTXuPTc0LSqO4M60LJy9aTIBFT0SmLGZGwR2
         e3Iz2iGW8xr1nnwzAZW/ZzNRuf2N72qQ5FGpDMIGWgDvb1tTxYbsb22fGkP1MdJBjlQ8
         hdcoJcyMbZpX3mKVW5N9KWlYlEO6tkZnkZT2G6e+dngU2k90HVktI88swvcim99nVrOp
         uGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGIrdXfDgI7/IaYeWO5Gp9h1nGp73Y+o9HAEbIa6JGM=;
        b=obB3G2710LxmxjU23fL1rOgXJIaJUQe3/i3y/tKzAFdSASU8x3uy0XFD2Cc4NkM6CS
         sBDcbwdRufKRo3c+7ojUb1G7OZ5H7UF4pgx79nA6GkoeMJQJMQG/zLlx9HXH7oBmwxp7
         bLFOz7TqEigaBBXYSn5a7G+yENRQzqQJU7M/xS6VZUfuXtHRjepHoiuPC/Adgk3oH8pV
         mEwIS0yZ7VS5KAvocOP6i7Eb6Y4v4Ap+MYwZxDjPeF5EYx/PeqV2eZLG0RP7vbFhvDOP
         J/bvZyR5s5T+9ten18608xcTCQpA/jFZ0kTfliIq/AVuBbJy6BjGdwbYlnFP83Nxi0Qy
         LaEg==
X-Gm-Message-State: AOAM532CqkO4/eIR+udBqwfKR3SsD836N5j3kz6Ek+xQczkVNffRA11Q
        ewqaKBvvr6xaIO29LV5txvR9Pr8F5H8P4jt7
X-Google-Smtp-Source: ABdhPJwJjkVVvfRjpouchOfEtZXi8F+qy2ZpKu4it8NGwq5X+dx6wVKIEChxCx6Bl7WR1/rTgBC91A==
X-Received: by 2002:a05:622a:302:b0:2e0:7aed:d653 with SMTP id q2-20020a05622a030200b002e07aedd653mr4986723qtw.492.1646935104739;
        Thu, 10 Mar 2022 09:58:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v14-20020a05622a014e00b002cf75f5b11esm3488477qtw.64.2022.03.10.09.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:58:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/3] btrfs: allow block group background reclaim for !zoned fs'es
Date:   Thu, 10 Mar 2022 12:58:19 -0500
Message-Id: <ad985b39b7652ae2ad85ecc51eacbfdb5045e1b6.1646934721.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646934721.git.josef@toxicpanda.com>
References: <cover.1646934721.git.josef@toxicpanda.com>
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

We have found this feature invaluable at Facebook due to how our
workload interacts with the allocator.  We have been using this in
production for months with only a single problem that has already been
fixed.  This will allow us to set a threshold for block groups to be
automatically relocated even if we don't have zoned devices.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index c22d287e020b..ca43daba292a 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3230,6 +3230,31 @@ int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+static inline bool should_reclaim_block_group(struct btrfs_block_group *block_group,
+					      u64 bytes_freed)
+{
+	const struct btrfs_space_info *space_info = block_group->space_info;
+	const int reclaim_thresh = READ_ONCE(space_info->bg_reclaim_threshold);
+	const u64 new_val = block_group->used;
+	const u64 old_val = new_val + bytes_freed;
+	u64 thresh;
+
+	if (reclaim_thresh == 0)
+		return false;
+
+	thresh = div_factor_fine(block_group->length, reclaim_thresh);
+
+	/*
+	 * If we were below the threshold before don't reclaim, we are likely a
+	 * brand new block group and we don't want to relocate new block groups.
+	 */
+	if (old_val < thresh)
+		return false;
+	if (new_val >= thresh)
+		return false;
+	return true;
+}
+
 int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 			     u64 bytenr, u64 num_bytes, bool alloc)
 {
@@ -3252,6 +3277,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 	spin_unlock(&info->delalloc_root_lock);
 
 	while (total) {
+		bool reclaim;
+
 		cache = btrfs_lookup_block_group(info, bytenr);
 		if (!cache) {
 			ret = -ENOENT;
@@ -3297,6 +3324,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 					cache->space_info, num_bytes);
 			cache->space_info->bytes_used -= num_bytes;
 			cache->space_info->disk_used -= num_bytes * factor;
+
+			reclaim = should_reclaim_block_group(cache, num_bytes);
 			spin_unlock(&cache->lock);
 			spin_unlock(&cache->space_info->lock);
 
@@ -3323,6 +3352,8 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
 		if (!alloc && old_val == 0) {
 			if (!btrfs_test_opt(info, DISCARD_ASYNC))
 				btrfs_mark_bg_unused(cache);
+		} else if (!alloc && reclaim) {
+			btrfs_mark_bg_to_reclaim(cache);
 		}
 
 		btrfs_put_block_group(cache);
-- 
2.26.3

