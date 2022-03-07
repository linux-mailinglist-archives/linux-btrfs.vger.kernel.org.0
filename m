Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9B44D0AB6
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343651AbiCGWOd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbiCGWOc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:14:32 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F65577B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:13:37 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id s15so14585974qtk.10
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+T/Sq7dklmBe/an9Co68+zQqVlEeSuZw0gmAdfw7Ud0=;
        b=tYwpPBenavgZAqDKEaJq3KnOE3wObuskCumRRt5aBF0WC3vVWgECYkmvLTcE91JPSX
         gfl7pGFh9kJAhyginG19Cdc/1gGG1yc8yEKmsaERz1sLegD9mGW1B3DFzb7x9rwAcHlH
         WK8z49mbNGyMB84+fgGv1vPxBfnZ3yiVEYkzBECsnTk5T/SkgkloabAPFRJxfO81TUZA
         n/4JRDeDIdQDLyqLFKzb0GUDyIz3Drgm6C7AROqqrJfQNHRfL7arhU1YgoP3Qm2aQfj0
         8BiHAV0VP014bj14eG6k9boK+flLfWyoz+jz+9OR9KQGPG4iN0vodPgKlWvixczJ92pV
         2zYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+T/Sq7dklmBe/an9Co68+zQqVlEeSuZw0gmAdfw7Ud0=;
        b=hH9BYiTCLNQrNn7ec6KxGV+4syXIO1Fmwnc2qs4JGvF985aXkRrZZSTq/LjgCOLVE1
         hh44HsOwqOJ2hWRbbhX64qWW/15pQ44speJcB1cL5rQ0m+ncyxgYE2vLiBBJ5qVGg0zu
         iu7dM0lvw0KjNu/u5cMXI/MalFbayVpy20br4vOacxOr0MebEjdCEI49gRCq4fik+F1y
         IIW1U/u8MB4NuB1xFHi7SpKdH3nP+VrGAVTY7+kq5nIM4XllvqrZ6EAl9cIIOiYwZTTc
         1qt8W9SZeO9Fsvp0Uc5GS3RUCnxRHxywOLCNEGjeUvlw9hMnc3sAKqlkmWHI6UBgfuil
         /cJg==
X-Gm-Message-State: AOAM532WsugsYBzmg60H/m3XWl/pMhvKN7wO0AgRUsiReYePhk8Khn2M
        Fv03DK2g2aMiRJbdpA6jnMWqyuQgZwT3Xnvl
X-Google-Smtp-Source: ABdhPJxsHt7GuFZbDctFmlwLuagOv2qKFd7Ao7uwqEusKrxR3G7ECi+5Tg6MGC0KkestvCT2TsboJw==
X-Received: by 2002:ac8:7f04:0:b0:2e0:6859:5131 with SMTP id f4-20020ac87f04000000b002e068595131mr4966344qtk.126.1646691216792;
        Mon, 07 Mar 2022 14:13:36 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y11-20020a05622a004b00b002dea2052d7dsm9497102qtw.12.2022.03.07.14.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:13:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 10/15] btrfs-progs: cache the block group with the free space tree if possible
Date:   Mon,  7 Mar 2022 17:13:15 -0500
Message-Id: <0ac9066c7f43f109fe3d2b47f6d95fd1b8745b8a.1646691128.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646691128.git.josef@toxicpanda.com>
References: <cover.1646691128.git.josef@toxicpanda.com>
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
index 61c53ad2..8921dd07 100644
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

