Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24BCE6F2637
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Apr 2023 22:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjD2UHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 29 Apr 2023 16:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjD2UHk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 29 Apr 2023 16:07:40 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EFD2710
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:38 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-552a6357d02so15983277b3.3
        for <linux-btrfs@vger.kernel.org>; Sat, 29 Apr 2023 13:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1682798858; x=1685390858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPDkrsOcjeDNfOdNUYQnZkwQqkT1OBLvizahJeZC/q8=;
        b=4XJFfgGa2T5lcUEGLqvfeZ0CIRLLi8XxspLomxOG0F4FUxTdg5zm1utYiqr4aYK5bw
         btmr1gMA8zTBG8xZjjR1yU6pxgo9oWbkDgJyNx39ooc65axZH9LQa0tHFFZRtcKhmtVZ
         TF0KARWDTwUrMPN6CowrBkwNN3MY911Ug2K7DmG3ZpNIVSUnIB6tucb5plDSroHSqAep
         B3XlsAadNugLFiqWbhM/N6H1SyzCmhL3G6atjVs5LyFsYnjou4YE3InpXR7YD6U02Jct
         ytefOod24P0KDNVLhtKzKV+QjUmtz4EGL/SX48aL55yy5Rf/3RcpZHuybPYqlHJN/ISG
         ZIOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682798858; x=1685390858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPDkrsOcjeDNfOdNUYQnZkwQqkT1OBLvizahJeZC/q8=;
        b=h7N6IO0RbtLL0Yc2+QQC+aeaPCJjyHyuF3WJVQFXG/yatMl8VL8UqUKuVUMdtPrsUG
         ZQwi9Qtrq0S3I9aEkHkK5WPbR0WKI8NFAcJmIXis9J1O6YaIZWIhJU9sX7CGKnvS3Koh
         uYShvGtprTJVNNxVAv8/O1U0cYk22LxkecJ4Mgrge3lgpcCfIeFmU553WnA22flmvX8v
         0eqJXAlA3NGWnZYbRnoRXfKWUWKe2Zfo4NQ5ossbEP4Ky+/gMmLyEZnve1XfN9h3QQHp
         XVVg2qXfzFnSs2AorGhyLd689PxBKIBaKTCwtSxQFK9ASBlNNW16jRcRkzxe7Fnxsf41
         ZLtA==
X-Gm-Message-State: AC+VfDz/T+VpvtD/xbcU8+Nohyn2DfI+SBTEWShMugO5NGPzWkwH8y9s
        kLguwUZBwa7gpZry4YoRP4vcxcxLxaAVvonLqUfStA==
X-Google-Smtp-Source: ACHHUZ52bNvYVGxozYcq0u2e3GvuRgBgnzSlmTw7B1mom4UKWD6SF00Aa413g6bJxYFNxeHI/dhziQ==
X-Received: by 2002:a0d:d4c8:0:b0:559:f50f:64f6 with SMTP id w191-20020a0dd4c8000000b00559f50f64f6mr1739762ywd.7.1682798857738;
        Sat, 29 Apr 2023 13:07:37 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d144-20020a814f96000000b00559f1cb8444sm327219ywb.70.2023.04.29.13.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 13:07:37 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 07/12] btrfs: add __btrfs_check_node helper
Date:   Sat, 29 Apr 2023 16:07:16 -0400
Message-Id: <c78571e0ea619aefd33e2c6d1a6ac274cb15581f.1682798736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1682798736.git.josef@toxicpanda.com>
References: <cover.1682798736.git.josef@toxicpanda.com>
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

This helper returns a btrfs_tree_block_status for the various errors,
and then btrfs_check_node() will return -EUCLEAN if it gets anything
other than BTRFS_TREE_BLOCK_CLEAN which will be used by the kernel.  In
the future btrfs-progs will use this helper instead.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tree-checker.c | 29 +++++++++++++++++------------
 fs/btrfs/tree-checker.h |  1 +
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 2c330e9d123a..eb9ba48d92aa 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1846,7 +1846,7 @@ int btrfs_check_leaf(struct extent_buffer *leaf)
 }
 ALLOW_ERROR_INJECTION(btrfs_check_leaf, ERRNO);
 
-int btrfs_check_node(struct extent_buffer *node)
+enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node)
 {
 	struct btrfs_fs_info *fs_info = node->fs_info;
 	unsigned long nr = btrfs_header_nritems(node);
@@ -1854,13 +1854,12 @@ int btrfs_check_node(struct extent_buffer *node)
 	int slot;
 	int level = btrfs_header_level(node);
 	u64 bytenr;
-	int ret = 0;
 
 	if (unlikely(level <= 0 || level >= BTRFS_MAX_LEVEL)) {
 		generic_err(node, 0,
 			"invalid level for node, have %d expect [1, %d]",
 			level, BTRFS_MAX_LEVEL - 1);
-		return -EUCLEAN;
+		return BTRFS_TREE_BLOCK_INVALID_LEVEL;
 	}
 	if (unlikely(nr == 0 || nr > BTRFS_NODEPTRS_PER_BLOCK(fs_info))) {
 		btrfs_crit(fs_info,
@@ -1868,7 +1867,7 @@ int btrfs_check_node(struct extent_buffer *node)
 			   btrfs_header_owner(node), node->start,
 			   nr == 0 ? "small" : "large", nr,
 			   BTRFS_NODEPTRS_PER_BLOCK(fs_info));
-		return -EUCLEAN;
+		return BTRFS_TREE_BLOCK_INVALID_NRITEMS;
 	}
 
 	for (slot = 0; slot < nr - 1; slot++) {
@@ -1879,15 +1878,13 @@ int btrfs_check_node(struct extent_buffer *node)
 		if (unlikely(!bytenr)) {
 			generic_err(node, slot,
 				"invalid NULL node pointer");
-			ret = -EUCLEAN;
-			goto out;
+			return BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
 		}
 		if (unlikely(!IS_ALIGNED(bytenr, fs_info->sectorsize))) {
 			generic_err(node, slot,
 			"unaligned pointer, have %llu should be aligned to %u",
 				bytenr, fs_info->sectorsize);
-			ret = -EUCLEAN;
-			goto out;
+			return BTRFS_TREE_BLOCK_INVALID_BLOCKPTR;
 		}
 
 		if (unlikely(btrfs_comp_cpu_keys(&key, &next_key) >= 0)) {
@@ -1896,12 +1893,20 @@ int btrfs_check_node(struct extent_buffer *node)
 				key.objectid, key.type, key.offset,
 				next_key.objectid, next_key.type,
 				next_key.offset);
-			ret = -EUCLEAN;
-			goto out;
+			return BTRFS_TREE_BLOCK_BAD_KEY_ORDER;
 		}
 	}
-out:
-	return ret;
+	return BTRFS_TREE_BLOCK_CLEAN;
+}
+
+int btrfs_check_node(struct extent_buffer *node)
+{
+	enum btrfs_tree_block_status ret;
+
+	ret = __btrfs_check_node(node);
+	if (unlikely(ret != BTRFS_TREE_BLOCK_CLEAN))
+		return -EUCLEAN;
+	return 0;
 }
 ALLOW_ERROR_INJECTION(btrfs_check_node, ERRNO);
 
diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
index 3b8de6d36141..c0861ce1429b 100644
--- a/fs/btrfs/tree-checker.h
+++ b/fs/btrfs/tree-checker.h
@@ -58,6 +58,7 @@ enum btrfs_tree_block_status {
  * btrfs_tree_block_status return codes.
  */
 enum btrfs_tree_block_status __btrfs_check_leaf(struct extent_buffer *leaf);
+enum btrfs_tree_block_status __btrfs_check_node(struct extent_buffer *node);
 
 int btrfs_check_leaf(struct extent_buffer *leaf);
 int btrfs_check_node(struct extent_buffer *node);
-- 
2.40.0

