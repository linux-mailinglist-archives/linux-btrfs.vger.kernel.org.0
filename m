Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423DB77FF62
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 22:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355092AbjHQU6a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 16:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355086AbjHQU54 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 16:57:56 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AA630F6
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:54 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58cbdf3eecaso2689027b3.0
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692305874; x=1692910674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=89qlipFYPHBP3W+xLufglLgFiGWCyiW+0/tCA16wQAA=;
        b=TUASaqeo16AxmCxJQbcuyg/omEPjrWwkeRpIeZL35gNm5/CptsnlUPGy4IsCC8wWcu
         B43kZxa9zhKKbZA8ABVn5WVrtGTqGOY5OR+fSKqeOnj641/yexrm4pnWN6/l09LrEErn
         yGlkusU9+rocZmZKkfSNNoU950O/UYnI872watHg4c9dr19okz/b7mYR3iEbcnyLbpKQ
         CV7sInUjuy/Ch00qhv0eZsRl/tSlIOx4Q9sgq3vU9lDbIiP4tfNeKNZnl4h1QqoSIj2b
         Z6NcPnzulCjDK8eY/kjGRiXI+rrUoCSmc/Ao8p5Zd/bVFiYgiqZrduilhOQFA91TjP9r
         hPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305874; x=1692910674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=89qlipFYPHBP3W+xLufglLgFiGWCyiW+0/tCA16wQAA=;
        b=KO28aQjM9H5UcRwGnV0ZHdzaMLOfWD45MQnfUeVPFKHQySk8hs4msMklOB6Dqkl+sq
         0+URKv9hv+sw1URgDWPIoXgIzu3kcARV0k2r0aZjAqIdADPMGbLcSLI1/0zhefp0vHUy
         zMBQ62JO2U68vKDi2Y+MuI/W3eK6M4CRwxsUdIQS3k5CG0R9E/2dFE3FlxoA1yReJMqZ
         4XsMH+umuSLdOFb803EeFnZ3wXqvFosq20512BeIu7L/HBt0vOiGUdWWeGHmlzJeGNFf
         6UElAc2dDrWKWFMg21Olivd7Jh9/1dp3dQokPWKIvtg4KgBWOcgmB/v2EKR4lojqm1ma
         ge+w==
X-Gm-Message-State: AOJu0YySYOXVLRaxmlRkkiCadtOj/pPp3WX+u2r14x5XzBG+QwYdzjWP
        z83OH1m9CK+IZZB7Lay7vm3xwbrhgUbfNloPgMN9BA==
X-Google-Smtp-Source: AGHT+IHQP2rNWdzMfzakx/+2mtxPNq693T8By7xhaSd4leBmomrl/ilXqkXdcSfeEuawdgB0Gfa9tA==
X-Received: by 2002:a81:658b:0:b0:565:ba4e:84fc with SMTP id z133-20020a81658b000000b00565ba4e84fcmr424724ywb.50.1692305874019;
        Thu, 17 Aug 2023 13:57:54 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d3-20020a81ab43000000b00573898fb12bsm99823ywk.82.2023.08.17.13.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:57:53 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] btrfs: add extent_map tests for dropping with odd layouts
Date:   Thu, 17 Aug 2023 16:57:31 -0400
Message-Id: <bfdfeb73fec4d1352992fb9d6027eaabe9723d6d.1692305624.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1692305624.git.josef@toxicpanda.com>
References: <cover.1692305624.git.josef@toxicpanda.com>
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

While investigating weird problems with the extent_map I wrote a self
test testing the various edge cases of btrfs_drop_extent_map_range.
This can split in different ways and behaves different in each case, so
test the various edge cases to make sure everything is functioning
properly.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tests/extent-map-tests.c | 219 ++++++++++++++++++++++++++++++
 1 file changed, 219 insertions(+)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index ed0f36ae5346..d5f5e48ab55c 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include "btrfs-tests.h"
 #include "../ctree.h"
+#include "../btrfs_inode.h"
 #include "../volumes.h"
 #include "../disk-io.h"
 #include "../block-group.h"
@@ -442,6 +443,219 @@ static int test_case_4(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int add_compressed_extent(struct extent_map_tree *em_tree,
+				 const u64 start, const u64 len,
+				 const u64 block_start)
+{
+	struct extent_map *em;
+	int ret;
+
+	em = alloc_extent_map();
+	if (!em) {
+		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		return -ENOMEM;
+	}
+
+	em->start = start;
+	em->len = len;
+	em->block_start = block_start;
+	em->block_len = SZ_4K;
+	set_bit(EXTENT_FLAG_COMPRESSED, &em->flags);
+	write_lock(&em_tree->lock);
+	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
+	free_extent_map(em);
+	if (ret < 0) {
+		test_err("cannot add extent map [%llu, %llu)", start,
+			 start + len);
+		return ret;
+	}
+
+	return 0;
+}
+
+struct extent_range {
+	u64 start;
+	u64 len;
+};
+
+/* The valid states of the tree after every drop, as described below. */
+struct extent_range valid_ranges[][7] = {
+	{
+	  { .start = 0,			.len = SZ_8K },		/* [0, 8K) */
+	  { .start = SZ_4K * 3,		.len = SZ_4K * 3},	/* [12k, 24k) */
+	  { .start = SZ_4K * 6,		.len = SZ_4K * 3},	/* [24k, 36k) */
+	  { .start = SZ_32K + SZ_4K,	.len = SZ_4K},		/* [36k, 40k) */
+	  { .start = SZ_4K * 10,	.len = SZ_4K * 6},	/* [40k, 64k) */
+	},
+	{
+	  { .start = 0,			.len = SZ_8K },		/* [0, 8K) */
+	  { .start = SZ_4K * 5,		.len = SZ_4K},		/* [20k, 24k) */
+	  { .start = SZ_4K * 6,		.len = SZ_4K * 3},	/* [24k, 36k) */
+	  { .start = SZ_32K + SZ_4K,	.len = SZ_4K},		/* [36k, 40k) */
+	  { .start = SZ_4K * 10,	.len = SZ_4K * 6},	/* [40k, 64k) */
+	},
+	{
+	  { .start = 0,			.len = SZ_8K },		/* [0, 8K) */
+	  { .start = SZ_4K * 5,		.len = SZ_4K},		/* [20k, 24k) */
+	  { .start = SZ_4K * 6,		.len = SZ_4K},		/* [24k, 28k) */
+	  { .start = SZ_32K,		.len = SZ_4K},		/* [32k, 36k) */
+	  { .start = SZ_32K + SZ_4K,	.len = SZ_4K},		/* [36k, 40k) */
+	  { .start = SZ_4K * 10,	.len = SZ_4K * 6},	/* [40k, 64k) */
+	},
+	{
+	  { .start = 0,			.len = SZ_8K},		/* [0, 8K) */
+	  { .start = SZ_4K * 5,		.len = SZ_4K},		/* [20k, 24k) */
+	  { .start = SZ_4K * 6,		.len = SZ_4K},		/* [24k, 28k) */
+	}
+};
+
+static int validate_range(struct extent_map_tree *em_tree, int index)
+{
+	struct rb_node *n;
+	int i;
+
+	for (i = 0, n = rb_first_cached(&em_tree->map);
+	     valid_ranges[index][i].len && n; i++, n = rb_next(n)) {
+		struct extent_map *entry = rb_entry(n, struct extent_map, rb_node);
+
+		if (entry->start != valid_ranges[index][i].start) {
+			test_err("mapping has start %llu expected %llu",
+				 entry->start, valid_ranges[index][i].start);
+			return -EINVAL;
+		}
+
+		if (entry->len != valid_ranges[index][i].len) {
+			test_err("mapping has len %llu expected %llu",
+				 entry->len, valid_ranges[index][i].len);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * We exited because we don't have any more entries in the extent_map
+	 * but we still expect more valid entries.
+	 */
+	if (valid_ranges[index][i].len) {
+		test_err("missing an entry");
+		return -EINVAL;
+	}
+
+	/* We exited the loop but still have entries in the extent map. */
+	if (n) {
+		test_err("we have a left over entry in the extent map we didn't expect");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Test scenario:
+ *
+ * Test the various edge cases of btrfs_drop_extent_map_range, create the
+ * following ranges
+ *
+ * [0, 12k)[12k, 24k)[24k, 36k)[36k, 40k)[40k,64k)
+ *
+ * And then we'll drop:
+ *
+ * [8k, 12k) - test the single front split
+ * [12k, 20k) - test the single back split
+ * [28k, 32k) - test the double split
+ * [32k, 64k) - test whole em dropping
+ *
+ * They'll have the EXTENT_FLAG_COMPRESSED flag set to keep the em tree from
+ * merging the em's.
+ */
+static int test_case_5(void)
+{
+	struct extent_map_tree *em_tree;
+	struct inode *inode = NULL;
+	u64 start, end;
+	int ret;
+
+	test_msg("Running btrfs_drop_extent_map_range tests");
+
+	inode = btrfs_new_test_inode();
+	if (!inode) {
+		test_std_err(TEST_ALLOC_INODE);
+		return -ENOMEM;
+	}
+
+	em_tree = &BTRFS_I(inode)->extent_tree;
+
+	/* [0, 12k) */
+	ret = add_compressed_extent(em_tree, 0, SZ_4K * 3, 0);
+	if (ret) {
+		test_err("cannot add extent range [0, 12K)");
+		goto out;
+	}
+
+	/* [12k, 24k) */
+	ret = add_compressed_extent(em_tree, SZ_4K * 3, SZ_4K * 3, SZ_4K);
+	if (ret) {
+		test_err("cannot add extent range [12k, 24k)");
+		goto out;
+	}
+
+	/* [24k, 36k) */
+	ret = add_compressed_extent(em_tree, SZ_4K * 6, SZ_4K * 3, SZ_8K);
+	if (ret) {
+		test_err("cannot add extent range [12k, 24k)");
+		goto out;
+	}
+
+	/* [36k, 40k) */
+	ret = add_compressed_extent(em_tree, SZ_32K + SZ_4K, SZ_4K, SZ_4K * 3);
+	if (ret) {
+		test_err("cannot add extent range [12k, 24k)");
+		goto out;
+	}
+
+	/* [40k, 64k) */
+	ret = add_compressed_extent(em_tree, SZ_4K * 10, SZ_4K * 6, SZ_16K);
+	if (ret) {
+		test_err("cannot add extent range [12k, 24k)");
+		goto out;
+	}
+
+	/* Drop [8k, 12k) */
+	start = SZ_8K;
+	end = (3 * SZ_4K) - 1;
+	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
+	ret = validate_range(&BTRFS_I(inode)->extent_tree, 0);
+	if (ret)
+		goto out;
+
+	/* Drop [12k, 20k) */
+	start = SZ_4K * 3;
+	end = SZ_16K + SZ_4K - 1;
+	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
+	ret = validate_range(&BTRFS_I(inode)->extent_tree, 1);
+	if (ret)
+		goto out;
+
+	/* Drop [28k, 32k) */
+	start = SZ_32K - SZ_4K;
+	end = SZ_32K - 1;
+	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
+	ret = validate_range(&BTRFS_I(inode)->extent_tree, 2);
+	if (ret)
+		goto out;
+
+	/* Drop [32k, 64k) */
+	start = SZ_32K;
+	end = SZ_64K - 1;
+	btrfs_drop_extent_map_range(BTRFS_I(inode), start, end, false);
+	ret = validate_range(&BTRFS_I(inode)->extent_tree, 3);
+	if (ret)
+		goto out;
+out:
+	iput(inode);
+	return ret;
+}
+
 struct rmap_test_vector {
 	u64 raid_type;
 	u64 physical_start;
@@ -619,6 +833,11 @@ int btrfs_test_extent_map(void)
 	if (ret)
 		goto out;
 	ret = test_case_4(fs_info, em_tree);
+	if (ret)
+		goto out;
+	ret = test_case_5();
+	if (ret)
+		goto out;
 
 	test_msg("running rmap tests");
 	for (i = 0; i < ARRAY_SIZE(rmap_tests); i++) {
-- 
2.26.3

