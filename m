Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8EF4762EF
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 21:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhLOUPM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 15:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbhLOUPL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 15:15:11 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56638C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:10 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id p19so23050361qtw.12
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 12:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=S1QAJW5kJaeoBN+e/zLqiBr9miIO3tFbI29B8OlgEic=;
        b=cpVdPv6EP4aAWGq3D5VkQozZu30gzawmQr+ABG2QNqBhAoHARwesuis0aEIRG6fZPx
         xaeVIxSOORNwC+q71Oeemj0kXw8lbDtNAIIoHxAlMw6rvAPnAFR0sXM7FBs0Ro0rtvi9
         K1udyBGB/IaJwVALRDKPfz0zE2msGv4dWqqla5oSyVQTFJKexTIm7xcdKSQHPZhisXop
         0OUUGnbJG+tTHNiFDYRUXhZhWvQmXSN7hsB+Nrb9qR7CE/uXIz2GF7pcI3Qr+DIrnAiu
         /JDQ7eLmI3pJdw3X0C9uPxrTGBD7BevSOOsw8SfuPFftRpRwvQf80EIcxov60oCGfr2E
         Cjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1QAJW5kJaeoBN+e/zLqiBr9miIO3tFbI29B8OlgEic=;
        b=tViVfCrYzAwlBjI7dXYNe8HEbGpVLjPivhhzkxQiMtaud8CKZkRcI457b3FZpK42Xz
         +AxVbY9gat4CcWQ5O+9LGMW/Yzk2aaVF/cYhWLvgt2PyaVVv/vNEP4vrCs1rY3pO5BTp
         ni35SHaYPhy/c3q6hbHvHfbEKg5Rv3sPXYhYSoywI9kZ5qWKzI4mQ5rHF5H/vo/UBqQP
         0lFyYkj2rDG8EjJVlamPRMmowgWsWhZlPmVMJlwKcDz00ZStH9cDXFuaezsy9c8GdPsR
         zWyRcjuskBlurjRydkBbd6x9pBxTuPURpSbkJ+30ij+GWeSupUvTdd1L3seua3TYbi/N
         qYrw==
X-Gm-Message-State: AOAM532+R1M0TyqNTziLGRf9VzMOzUXogTq8qo46f31McwIvPQiJzT1S
        WggD5jLWPqIMkY8Rh8QMrfxrfOyNzXVgnA==
X-Google-Smtp-Source: ABdhPJx6wGagbc3QgEFri7DHu5FGuJysvU3Vtv7PUoGX0w/P03K4aLkTXw+k+rNg8jSz/h3H9ewY5Q==
X-Received: by 2002:ac8:58c9:: with SMTP id u9mr13930983qta.583.1639599309216;
        Wed, 15 Dec 2021 12:15:09 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e17sm2231638qtw.18.2021.12.15.12.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:15:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 10/15] btrfs-progs: cache the block group with the free space tree if possible
Date:   Wed, 15 Dec 2021 15:14:48 -0500
Message-Id: <47fa41d58e7fab43362c3c98b3d93c293159f88e.1639598612.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1639598612.git.josef@toxicpanda.com>
References: <cover.1639598612.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

We currently always cache the block group based on the extent tree in
progs.  However with extent-tree-v2 we will not be able to do this, so
we need to load the free space tree.  However the free space tree is
tied into the normal free space cache, which progs doesn't use for
allocation, instead it uses an extent_io_tree.

Handle this by setting the range dirty in our extent_io_tree.  We still
need to be able to load the free space tree into the normal free space
cache stuff for fsck, so simply bail doing the normal free space cache
adding if block_group->free_space_ctl is NULL, which will be the case
unless we're checking it via check.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/extent-tree.c      | 14 ++++++++++++++
 kernel-shared/free-space-cache.c |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index 0c0d7bb9..1b4e6a02 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -102,6 +102,15 @@ static int cache_block_group(struct btrfs_root *root,
 	if (block_group->cached)
 		return 0;
 
+	if (btrfs_fs_compat_ro(root->fs_info, FREE_SPACE_TREE) &&
+	    btrfs_fs_compat_ro(root->fs_info, FREE_SPACE_TREE_VALID)) {
+		ret = load_free_space_tree(root->fs_info, block_group);
+		if (!ret) {
+			block_group->cached = 1;
+			return 0;
+		}
+	}
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -3594,9 +3603,11 @@ int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 u64 add_new_free_space(struct btrfs_block_group *block_group,
 		       struct btrfs_fs_info *info, u64 start, u64 end)
 {
+	struct extent_io_tree *free_space_cache;
 	u64 extent_start, extent_end, size, total_added = 0;
 	int ret;
 
+	free_space_cache = &info->free_space_cache;
 	while (start < end) {
 		ret = find_first_extent_bit(&info->pinned_extents, start,
 					    &extent_start, &extent_end,
@@ -3609,6 +3620,8 @@ u64 add_new_free_space(struct btrfs_block_group *block_group,
 		} else if (extent_start > start && extent_start < end) {
 			size = extent_start - start;
 			total_added += size;
+			set_extent_dirty(free_space_cache, start,
+					 start + size - 1);
 			ret = btrfs_add_free_space(block_group->free_space_ctl,
 						   start, size);
 			BUG_ON(ret); /* -ENOMEM or logic error */
@@ -3621,6 +3634,7 @@ u64 add_new_free_space(struct btrfs_block_group *block_group,
 	if (start < end) {
 		size = end - start;
 		total_added += size;
+		set_extent_dirty(free_space_cache, start, start + size - 1);
 		ret = btrfs_add_free_space(block_group->free_space_ctl, start,
 					   size);
 		BUG_ON(ret); /* -ENOMEM or logic error */
diff --git a/kernel-shared/free-space-cache.c b/kernel-shared/free-space-cache.c
index e74a61e4..11b7fa60 100644
--- a/kernel-shared/free-space-cache.c
+++ b/kernel-shared/free-space-cache.c
@@ -828,6 +828,9 @@ int btrfs_add_free_space(struct btrfs_free_space_ctl *ctl, u64 offset,
 	struct btrfs_free_space *info;
 	int ret = 0;
 
+	if (!ctl)
+		return 0;
+
 	info = calloc(1, sizeof(*info));
 	if (!info)
 		return -ENOMEM;
-- 
2.26.3

