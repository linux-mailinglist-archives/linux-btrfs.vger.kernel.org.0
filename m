Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2549785AB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjHWOdw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236532AbjHWOdv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:33:51 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1732E71
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:49 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58dce1f42d6so91539417b3.0
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692801229; x=1693406029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQxLWT7p66JnlNzQqpfpCSZgtBfkKj1AYX1eK/QIzdY=;
        b=ffAxJzJvCJdyi6gpo+R4mZcyNrIetFTRDG/lX/lJta5vLFL56p3M8l0G6NI5cAtcOQ
         UAmmiJIzeyhUc6M3cqMC3HKHDhFrMf6+o4Gvb65JI8oucyeyg8lpPob+La5tyxhARu14
         o+NsJyM+IZpFKBAEH772kmb5VL5lDaTnWhLcUvk2+WhZAipdCIS3hatNZdX7vUXcLjAC
         /JJmBpD4ZVUnID5DzhxgtDC4exHe7KhYG6AkpJDItvexPoUpi3O8X8yqNTk4hnxeoVTE
         OjGUQQ04e+viENnm4jnIH6tuaVv3KQtFrxDQoTptlxeTH9A/Uu8g5RCeAarhxOjBRRYB
         n5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692801229; x=1693406029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fQxLWT7p66JnlNzQqpfpCSZgtBfkKj1AYX1eK/QIzdY=;
        b=d7uocJArUkmxy8tiAAwrrHNSYmC+iNm8TE6P1gaRmqtcYMfFGeM2YAmGVcO+9yifUO
         IVL6gnvtueGLzo9+jHaUsYAT9m1U2FfdP6FD+uH3mX9UQ6f8vH1x+eGCzuNf5hB7iSRn
         Zv1bU9LQQubIAGeLFqkSBmvKdi9q2HJlrVqFf7ZWw7WwbSYjveCelM+52Yv75UC08LaT
         8dBGw5vFCgbyYGhAXIguQyn1LOua3VFBHulLaoDHup349ApEHRSOaRQN5KKuzH5FmTB5
         8YVvYhgDSCxxa59dyAGIEYrm4oOgiLf+d/H5ytbC71I0srZYlLTKyyQH6qOtnCeOEU8m
         TxQg==
X-Gm-Message-State: AOJu0Yy1+IzOJ3vJpaZwEybg7vBWjc9qtV+TCFcjEC3MBL35I6cJdury
        sHrAcZmO2/mPeoWgiRcPAw6d/MgifjNqMhYp2xk=
X-Google-Smtp-Source: AGHT+IGzqVA0Zl1yj8cLG+TKLJXl+R5+oIrTSG19YkG4HYvBsDg4+WwmPsSlqZ35+qsWp1G2f++kmg==
X-Received: by 2002:a81:8406:0:b0:58c:5598:be97 with SMTP id u6-20020a818406000000b0058c5598be97mr11690145ywf.15.1692801228733;
        Wed, 23 Aug 2023 07:33:48 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x123-20020a818781000000b0058d856efb31sm3371445ywf.98.2023.08.23.07.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:33:48 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 34/38] btrfs-progs: use btrfs_tree_parent_check for btrfs_read_extent_buffer
Date:   Wed, 23 Aug 2023 10:33:00 -0400
Message-ID: <342ae866d3c27b426ca3cfc48efd26992eb089d5.1692800904.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1692800904.git.josef@toxicpanda.com>
References: <cover.1692800904.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In the kernel we have a control structure call btrfs_tree_parent_check
to pass around the various sanity checks we have for extent buffers.
Add this to btrfs_tree_parent_check and then update the callers.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel-shared/disk-io.c | 18 ++++++++++++++----
 kernel-shared/disk-io.h |  6 ++++--
 tune/change-csum.c      |  4 +++-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 092b54af..ef5ea391 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -332,8 +332,8 @@ int read_whole_eb(struct btrfs_fs_info *info, struct extent_buffer *eb, int mirr
 	return 0;
 }
 
-int btrfs_read_extent_buffer(struct extent_buffer *eb, u64 parent_transid,
-			     int level, struct btrfs_key *first_key)
+int btrfs_read_extent_buffer(struct extent_buffer *eb,
+			     struct btrfs_tree_parent_check *check)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	int ret;
@@ -349,7 +349,7 @@ int btrfs_read_extent_buffer(struct extent_buffer *eb, u64 parent_transid,
 		ret = read_whole_eb(fs_info, eb, mirror_num);
 		if (ret == 0 && csum_tree_block(fs_info, eb, 1) == 0 &&
 		    check_tree_block(fs_info, eb) == 0 &&
-		    verify_parent_transid(eb, parent_transid, ignore) == 0) {
+		    verify_parent_transid(eb, check->transid, ignore) == 0) {
 			if (eb->flags & EXTENT_BUFFER_BAD_TRANSID &&
 			    list_empty(&eb->recow)) {
 				list_add_tail(&eb->recow,
@@ -420,10 +420,20 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 				      u64 owner_root, u64 parent_transid,
 				      int level, struct btrfs_key *first_key)
 {
+	struct btrfs_tree_parent_check check = {
+		.owner_root = owner_root,
+		.transid = parent_transid,
+		.level = level,
+	};
 	int ret;
 	struct extent_buffer *eb;
 	u32 sectorsize = fs_info->sectorsize;
 
+	if (first_key) {
+		check.has_first_key = true;
+		memcpy(&check.first_key, first_key, sizeof(*first_key));
+	}
+
 	/*
 	 * Don't even try to create tree block for unaligned tree block
 	 * bytenr.
@@ -443,7 +453,7 @@ struct extent_buffer *read_tree_block(struct btrfs_fs_info *fs_info, u64 bytenr,
 	if (btrfs_buffer_uptodate(eb, parent_transid, 0))
 		return eb;
 
-	ret = btrfs_read_extent_buffer(eb, parent_transid, level, first_key);
+	ret = btrfs_read_extent_buffer(eb, &check);
 	if (ret) {
 		/*
 		 * We failed to read this tree block, it be should deleted right
diff --git a/kernel-shared/disk-io.h b/kernel-shared/disk-io.h
index 424b953e..78c6e8c7 100644
--- a/kernel-shared/disk-io.h
+++ b/kernel-shared/disk-io.h
@@ -23,6 +23,8 @@
 #include "kernel-shared/ctree.h"
 #include "kernel-lib/sizes.h"
 
+struct btrfs_tree_parent_check;
+
 #define BTRFS_SUPER_MIRROR_MAX	 3
 #define BTRFS_SUPER_MIRROR_SHIFT 12
 
@@ -238,8 +240,8 @@ int btrfs_global_root_insert(struct btrfs_fs_info *fs_info,
 int btrfs_find_and_setup_root(struct btrfs_root *tree_root,
 			      struct btrfs_fs_info *fs_info,
 			      u64 objectid, struct btrfs_root *root);
-int btrfs_read_extent_buffer(struct extent_buffer *eb, u64 parent_transid,
-			     int level, struct btrfs_key *first_key);
+int btrfs_read_extent_buffer(struct extent_buffer *eb,
+			     struct btrfs_tree_parent_check *check);
 
 static inline struct btrfs_root *btrfs_block_group_root(
 						struct btrfs_fs_info *fs_info)
diff --git a/tune/change-csum.c b/tune/change-csum.c
index cf895df7..f12a2832 100644
--- a/tune/change-csum.c
+++ b/tune/change-csum.c
@@ -24,6 +24,7 @@
 #include "kernel-shared/file-item.h"
 #include "kernel-shared/extent_io.h"
 #include "kernel-shared/transaction.h"
+#include "kernel-shared/tree-checker.h"
 #include "common/messages.h"
 #include "common/internal.h"
 #include "common/utils.h"
@@ -494,6 +495,7 @@ static int rewrite_tree_block_csum(struct btrfs_fs_info *fs_info, u64 logical,
 				   u16 new_csum_type)
 {
 	struct extent_buffer *eb;
+	struct btrfs_tree_parent_check check = { 0 };
 	u8 result_old[BTRFS_CSUM_SIZE];
 	u8 result_new[BTRFS_CSUM_SIZE];
 	int ret;
@@ -502,7 +504,7 @@ static int rewrite_tree_block_csum(struct btrfs_fs_info *fs_info, u64 logical,
 	if (!eb)
 		return -ENOMEM;
 
-	ret = btrfs_read_extent_buffer(eb, 0, 0, NULL);
+	ret = btrfs_read_extent_buffer(eb, &check);
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to read tree block at logical %llu: %m", logical);
-- 
2.41.0

