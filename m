Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBDA77FF63
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Aug 2023 22:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355095AbjHQU6b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Aug 2023 16:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355093AbjHQU56 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Aug 2023 16:57:58 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F182E3589
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:56 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-58c68c79befso2506137b3.3
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Aug 2023 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1692305876; x=1692910676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjkIkgd6of4hrmXqZfl3fsYYxP4DFEWGRKCuP21YO+E=;
        b=nNs4YPAWLbGSvu5cl7e+RYDwfYcSyouPLErEFVfwifqnmCXXj51hwfm0Lw9FDgdpch
         FJxtuf679tbw+kHRKhwKg4bnC+IMYd3lG8a+fhc17pJx+sMZGPJGUmgyGOtGMW8YEDzG
         RfSpvdcAQr+66ppwwLXPpUgO8jyK6HqjjUvQXmTaNt2zethzxpO6yXylNYz5L+Ng4Dtl
         7Kg12IxF47BzasqyEOlZa89Y8bZfftKfBT2hegvrP11Wg7WHvWzV4pdBYfnj1L9kvqbK
         XVNODo8t7zn+ccMIKvG5MBYacOnJM6CqINP4E2yeEmALsZEFUCqI1dW+KSMv6hobTtR1
         6yrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692305876; x=1692910676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zjkIkgd6of4hrmXqZfl3fsYYxP4DFEWGRKCuP21YO+E=;
        b=QP2fwIz9m5GIxb/3H6QIqe1LyjcIAFf1qbx2qkUIX6+d7+5YHAvc5OEGTjiy+pNEkr
         AHIqrl00U0yzYW9SDkPBhywVT+bRMLJm4Oh1nvplHiZ72j3JPQtAAvULbPxaQmjm2eiL
         bD0wPr107N6GDGVHCv1QkQ6b4roDZibgzs3Nk3ZRzA+aZwJU1BXS6WCXfRsrSzkWxLkh
         +GBfecyc1UGBQgtfnIa14hcCYdRypqVHTD9wWHEErnERAGthH4juJ06xA1TBv1l9nmcG
         sLAHrma6j2O7hnbaPyqnsb5qUn0XscExrhRil7UFUb8IaRmkMX7lQIBVyCs+8g3m1TOG
         RLzA==
X-Gm-Message-State: AOJu0Yz5RMpSjY1gO7Vg/zHmHInnAGMGGKLN24Z8ksqnF9fLPkv3Ht7Y
        ZzVB1VlAonySWKUMXRMYFWee2HhjKw/GGagqIdoGjg==
X-Google-Smtp-Source: AGHT+IFr8CC3JuN7BKnFaxPcx9MOVkbUZl710mjLmOj+KWsbnAjpGOe/q2+CX3v+ScEt1Y6W1QiIQQ==
X-Received: by 2002:a81:83cb:0:b0:589:f4ec:4d51 with SMTP id t194-20020a8183cb000000b00589f4ec4d51mr587512ywf.3.1692305876035;
        Thu, 17 Aug 2023 13:57:56 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id q7-20020a0dce07000000b005772abf6234sm105901ywd.11.2023.08.17.13.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 13:57:55 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/4] btrfs: test invalid splitting when skipping pinned drop extent_map
Date:   Thu, 17 Aug 2023 16:57:33 -0400
Message-Id: <cb4e2f77d7ab9670223ca0d76594abb93bb1c32d.1692305624.git.josef@toxicpanda.com>
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

This reproduces the bug fixed by "btrfs: fix incorrect splitting in
btrfs_drop_extent_map_range", we were improperly calculating the range
for the split extent.  Add a test that exercises this scenario and
validates that we get the correct resulting extent_maps in our tree.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tests/extent-map-tests.c | 138 ++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 18ab03f0d029..06820a8b4d1f 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -710,6 +710,141 @@ static int test_case_6(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+/*
+ * Regression test for btrfs_drop_extent_map_range.  Calling with skip_pinned ==
+ * true would mess up the start/end calculations and subsequent splits would be
+ * incorrect.
+ */
+static int test_case_7(void)
+{
+	struct extent_map_tree *em_tree;
+	struct extent_map *em = NULL;
+	struct inode *inode = NULL;
+	int ret;
+
+	test_msg("Running btrfs_drop_extent_cache with pinned");
+
+	inode = btrfs_new_test_inode();
+	if (!inode) {
+		test_std_err(TEST_ALLOC_INODE);
+		return -ENOMEM;
+	}
+
+	em_tree = &BTRFS_I(inode)->extent_tree;
+
+	em = alloc_extent_map();
+	if (!em) {
+		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* [0, 16K), pinned */
+	em->start = 0;
+	em->len = SZ_16K;
+	em->block_start = 0;
+	em->block_len = SZ_4K;
+	set_bit(EXTENT_FLAG_PINNED, &em->flags);
+	write_lock(&em_tree->lock);
+	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
+	if (ret < 0) {
+		test_err("couldn't add extent map");
+		goto out;
+	}
+	free_extent_map(em);
+
+	em = alloc_extent_map();
+	if (!em) {
+		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* [32K, 48K), not pinned */
+	em->start = SZ_32K;
+	em->len = SZ_16K;
+	em->block_start = SZ_32K;
+	em->block_len = SZ_16K;
+	write_lock(&em_tree->lock);
+	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
+	if (ret < 0) {
+		test_err("couldn't add extent map");
+		goto out;
+	}
+	free_extent_map(em);
+
+	/*
+	 * Drop [0, 36K) This should skip the [0, 4K) extent and then split the
+	 * [32K, 48K) extent.
+	 */
+	btrfs_drop_extent_map_range(BTRFS_I(inode), 0, (36 * SZ_1K) - 1, true);
+
+	/* Make sure our extent maps look sane. */
+	ret = -EINVAL;
+
+	em = lookup_extent_mapping(em_tree, 0, SZ_16K);
+	if (!em) {
+		test_err("didn't find an em at 0 as expected");
+		goto out;
+	}
+
+	if (em->start != 0) {
+		test_err("em->start is %llu, expected 0", em->start);
+		goto out;
+	}
+
+	if (em->len != SZ_16K) {
+		test_err("em->len is %llu, expected 16K", em->len);
+		goto out;
+	}
+
+	free_extent_map(em);
+
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, SZ_16K, SZ_16K);
+	read_unlock(&em_tree->lock);
+	if (em) {
+		test_err("found an em when we weren't expecting one");
+		goto out;
+	}
+
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, SZ_32K, SZ_16K);
+	read_unlock(&em_tree->lock);
+	if (!em) {
+		test_err("didn't find an em at 32K as expected");
+		goto out;
+	}
+
+	if (em->start != (36 * SZ_1K)) {
+		test_err("em->start is %llu, expected 36K", em->start);
+		goto out;
+	}
+
+	if (em->len != (12 * SZ_1K)) {
+		test_err("em->len is %llu, expected 12K", em->len);
+		goto out;
+	}
+
+	free_extent_map(em);
+
+	read_lock(&em_tree->lock);
+	em = lookup_extent_mapping(em_tree, 48 * SZ_1K, (u64)-1);
+	read_unlock(&em_tree->lock);
+	if (em) {
+		test_err("found an unexpected em above 48K");
+		goto out;
+	}
+
+	ret = 0;
+out:
+	free_extent_map(em);
+	iput(inode);
+	return ret;
+}
+
 struct rmap_test_vector {
 	u64 raid_type;
 	u64 physical_start;
@@ -893,6 +1028,9 @@ int btrfs_test_extent_map(void)
 	if (ret)
 		goto out;
 	ret = test_case_6(fs_info, em_tree);
+	if (ret)
+		goto out;
+	ret = test_case_7();
 	if (ret)
 		goto out;
 
-- 
2.26.3

