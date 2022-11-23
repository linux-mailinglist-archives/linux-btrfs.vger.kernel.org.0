Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C081636D55
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Nov 2022 23:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiKWWia (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Nov 2022 17:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiKWWiB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Nov 2022 17:38:01 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0914E10FF
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:58 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id d7so13485899qkk.3
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Nov 2022 14:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tMV+EvVW/9gxm7EbfBgQRdnBIwmlJ4bs05kZBZaXF4M=;
        b=IYdUtg8jKczxGTIxji1Zw/jOWMevrb6Vq4dJ1iWf3WZT//PD58uT9BOhiyFjqKg9SS
         28G+Chdv+jnzWIvNNEpYenWR/zhQtedrolGHSV2OPbwl42Y0qdz8SPNxax8+r4rCc+AG
         BKyR1W9Nfr1TC6OVAvgCJIfUAQ+jr3LOAcBzp+gaJVWmnWKxUiNhMEYz/BKN7eaaM9XA
         9ZV3o0wjmlgVcR7rCFlbUKdVSdAMkzBA3Rwdik4CPo3QZcAHaULKjp/HfLPfIvuHeBC4
         PXJO5EU+DTzM28sAXW2f8UTmB77hic+jSjEZYIu9lwbOtKs4vbJacD6zm6UNEAGP7NCl
         +fPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMV+EvVW/9gxm7EbfBgQRdnBIwmlJ4bs05kZBZaXF4M=;
        b=Z0qGGtBUMvxqGU5NOIK6RuShOawB/b2xaWigBdy5Z0HuSeMOqnn5DBaO4FWtqgczx/
         pwjlGYNQ4vfFoGFgg+Fx3pW7r72qLPKfRwupC6Mrx/dkaJ7ShNU4tWCqYRlsyOIK/GCp
         ajiXBeXQgvWSSd0/Q1LVuBguv3W8+ZrE5GVKyc/MDcImJwMlqNtJgtGXDs5uzOJ7246x
         4NWPEbDBr2x7flU0azqpUp/2wJq9vCVXChKhTeXBl23Ln1yqpNDtwDNyLe55uReAQnBv
         c//lsUO6CF7XtY5GY3em0WQZwujUhh2USbeEz02HqPPLLv24rNj8BN7WSO9p40Qh6Ymf
         alhg==
X-Gm-Message-State: ANoB5pn1avlfMXIa5JqdkAGbnzbUk1vVJyPfT5c7kKt+DkuV1uRw7km+
        roK984XThB3+9iUnQCIvyWcfqPd7xRjQFg==
X-Google-Smtp-Source: AA0mqf6j+gLsoPQZk7S7hGpn6J0Qssd+52M4WyAgFXnHOdQAy+b5LI1PIaNTdyE40/eNczRGNCvxyQ==
X-Received: by 2002:a05:620a:215c:b0:6fa:937f:61d4 with SMTP id m28-20020a05620a215c00b006fa937f61d4mr12649245qkm.280.1669243077659;
        Wed, 23 Nov 2022 14:37:57 -0800 (PST)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id z26-20020ac875da000000b003a622111f2csm9982724qtq.86.2022.11.23.14.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 14:37:57 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v3 14/29] btrfs-progs: make the find extent buffer helpers take fs_info
Date:   Wed, 23 Nov 2022 17:37:22 -0500
Message-Id: <7473bfae6a54af4d74b0993556df96a4dd8508d1.1669242804.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1669242804.git.josef@toxicpanda.com>
References: <cover.1669242804.git.josef@toxicpanda.com>
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

This is a cleanup patch to make syncing the btrfs kernel code into
btrfs-progs easier.  In btrfs-progs we have an extra cache in the
extent_io_tree that's exclusively used for the extent buffer tracking.
In order to untangle this dependency start passing around the fs_info to
search for extent_buffers, and then have the helpers use the appropriate
structure to find the extent buffer.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c     | 3 +--
 kernel-shared/extent_io.c   | 6 ++++--
 kernel-shared/extent_io.h   | 4 ++--
 kernel-shared/transaction.c | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 776758e9..ad4d0f4c 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -227,8 +227,7 @@ static int csum_tree_block(struct btrfs_fs_info *fs_info,
 struct extent_buffer *btrfs_find_tree_block(struct btrfs_fs_info *fs_info,
 					    u64 bytenr, u32 blocksize)
 {
-	return find_extent_buffer(&fs_info->extent_cache,
-				  bytenr, blocksize);
+	return find_extent_buffer(fs_info, bytenr, blocksize);
 }
 
 struct extent_buffer* btrfs_find_create_tree_block(
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index f112983a..bdfb2de6 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -682,9 +682,10 @@ void free_extent_buffer_nocache(struct extent_buffer *eb)
 	free_extent_buffer_internal(eb, 1);
 }
 
-struct extent_buffer *find_extent_buffer(struct extent_io_tree *tree,
+struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 					 u64 bytenr, u32 blocksize)
 {
+	struct extent_io_tree *tree = &fs_info->extent_cache;
 	struct extent_buffer *eb = NULL;
 	struct cache_extent *cache;
 
@@ -698,9 +699,10 @@ struct extent_buffer *find_extent_buffer(struct extent_io_tree *tree,
 	return eb;
 }
 
-struct extent_buffer *find_first_extent_buffer(struct extent_io_tree *tree,
+struct extent_buffer *find_first_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start)
 {
+	struct extent_io_tree *tree = &fs_info->extent_cache;
 	struct extent_buffer *eb = NULL;
 	struct cache_extent *cache;
 
diff --git a/kernel-shared/extent_io.h b/kernel-shared/extent_io.h
index ccdf768c..e4ae2dcd 100644
--- a/kernel-shared/extent_io.h
+++ b/kernel-shared/extent_io.h
@@ -129,9 +129,9 @@ static inline int extent_buffer_uptodate(struct extent_buffer *eb)
 
 int set_state_private(struct extent_io_tree *tree, u64 start, u64 xprivate);
 int get_state_private(struct extent_io_tree *tree, u64 start, u64 *xprivate);
-struct extent_buffer *find_extent_buffer(struct extent_io_tree *tree,
+struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 					 u64 bytenr, u32 blocksize);
-struct extent_buffer *find_first_extent_buffer(struct extent_io_tree *tree,
+struct extent_buffer *find_first_extent_buffer(struct btrfs_fs_info *fs_info,
 					       u64 start);
 struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 bytenr, u32 blocksize);
diff --git a/kernel-shared/transaction.c b/kernel-shared/transaction.c
index 28b16848..c50abfca 100644
--- a/kernel-shared/transaction.c
+++ b/kernel-shared/transaction.c
@@ -150,7 +150,7 @@ again:
 			goto again;
 
 		while(start <= end) {
-			eb = find_first_extent_buffer(tree, start);
+			eb = find_first_extent_buffer(fs_info, start);
 			BUG_ON(!eb || eb->start != start);
 			ret = write_tree_block(trans, fs_info, eb);
 			if (ret < 0) {
@@ -180,7 +180,7 @@ cleanup:
 			break;
 
 		while (start <= end) {
-			eb = find_first_extent_buffer(tree, start);
+			eb = find_first_extent_buffer(fs_info, start);
 			BUG_ON(!eb || eb->start != start);
 			start += eb->len;
 			clear_extent_buffer_dirty(eb);
-- 
2.26.3

