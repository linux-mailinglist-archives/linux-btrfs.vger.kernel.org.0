Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27041456517
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Nov 2021 22:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhKRVg1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Nov 2021 16:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKRVg0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Nov 2021 16:36:26 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3AFC061574
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 13:33:25 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id t34so7548158qtc.7
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Nov 2021 13:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=f4jyXgfM8lPvGYL4c4AYMJViECWcoqGj3xJt1WObU4c=;
        b=oJKBiRHwEE6wk+Ks7zdGckX2nmadFJ+SsG+wqkOucslQv/lSrWDscFnCM+9oaN0kNM
         dleroVet12D65VH4tPv16W5Y7w3hWDf67JcmFkrQdvkL075+TNkpCISujruhWVbqHJUa
         eFwVrvF/pCdZNjSqIvdh97gmApshqhVJfCGvRKOosHmeJEBf0LaX0ft0zjGhAdrDMoEd
         DfWu5Y3gS/pX9UNLjJqn+s/khkeVSZdWxDGV9te++3ii3yFsmTGVjQFewcrBPqkANefz
         zgc1A6gTMl1FmDwWqmTaDcg/PaqAIi60Yl37jRuHPrmISy4jSdcpJJKsXOX/nmDfKxrM
         C4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f4jyXgfM8lPvGYL4c4AYMJViECWcoqGj3xJt1WObU4c=;
        b=q6ZgOD5jU3mq75M27HRmpWDGE0w5oe5My6eU9dIS7EeC4e6iNv8W9syFmVtFiHMoxU
         gIK8DtlOCTwBS5SxW6XU92KWaBbIZ8F8uVSy4kbZ9Si9qfync35aU8w5mQYiVBfsMIEJ
         gK0JwJaYBOMNhngVg/rBFx0/JkNzk0kThKlI1WSHoG9P5Grb+wBhvKgPHlGYiec7IOj9
         HWnk2ULfcri/PgPIUB7KfQ1bZGlqhFFuQVGsr+QtNFzVVRdX7DWXYl6xiO3fDCsJJR3p
         W1zKUBcKiIz9t2CxQCfi4qDDJ04ZemVn0BDH8vqP9b+CZUKzlw54w5vNxOeN2oh/rUcp
         GMUw==
X-Gm-Message-State: AOAM530wHedQ1aCmqqvCfIj1Kdu7IoWnBCtUsgYV522HQ24VnfwUpJn7
        Km8k5NKVjvhJmp0AC/dcPHiZL1Qa4BDMdg==
X-Google-Smtp-Source: ABdhPJxvxMVxbVWn1hul+DbMaaM5tlMCXITmgwLiHSRqEH4EVPUfttbGWPgvM0Hixoh14GbR1FwZIg==
X-Received: by 2002:a05:622a:198a:: with SMTP id u10mr796248qtc.36.1637271204671;
        Thu, 18 Nov 2021 13:33:24 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u185sm519987qkd.48.2021.11.18.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 13:33:24 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v5 3/3] btrfs: add self test for bytes_index free space cache
Date:   Thu, 18 Nov 2021 16:33:16 -0500
Message-Id: <956267dd73ab8a77ed7b194bac36ee3dc34d1cb8.1637271014.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1637271014.git.josef@toxicpanda.com>
References: <cover.1637271014.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I noticed a few corner cases when looking at my bytes_index patch for
obvious bugs, so add a bunch of tests to validate proper behavior of the
bytes_index tree.  A couple of basic tests to make sure it puts things
in the correct order, and then more complicated tests to make sure it
re-arranges bitmap entries properly and does the right thing when we try
to make allocations.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/tests/free-space-tests.c | 181 ++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)

diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
index 8f05c1eb833f..6f922cea8ff8 100644
--- a/fs/btrfs/tests/free-space-tests.c
+++ b/fs/btrfs/tests/free-space-tests.c
@@ -824,6 +824,184 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
 	return 0;
 }
 
+static bool bytes_index_use_bitmap(struct btrfs_free_space_ctl *ctl,
+				   struct btrfs_free_space *info)
+{
+	return true;
+}
+
+static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
+{
+	const struct btrfs_free_space_op test_free_space_ops = {
+		.use_bitmap = bytes_index_use_bitmap,
+	};
+	const struct btrfs_free_space_op *orig_free_space_ops;
+	struct btrfs_free_space_ctl *ctl = cache->free_space_ctl;
+	struct btrfs_free_space *entry;
+	struct rb_node *n;
+	u64 offset, max_extent_size, bytes;
+	int ret, i;
+
+	test_msg("running bytes index tests");
+
+	/* First just validate that it does everything in order. */
+	offset = 0;
+	for (i = 0; i < 10; i++) {
+		bytes = (i + 1) * SZ_1M;
+		ret = test_add_free_space_entry(cache, offset, bytes, 0);
+		if (ret) {
+			test_err("couldn't add extent entry %d\n", ret);
+			return ret;
+		}
+		offset += bytes + sectorsize;
+	}
+
+	for (n = rb_first_cached(&ctl->free_space_bytes), i = 9; n;
+	     n = rb_next(n), i--) {
+		entry = rb_entry(n, struct btrfs_free_space, bytes_index);
+		bytes = (i + 1) * SZ_1M;
+		if (entry->bytes != bytes) {
+			test_err("invalid bytes index order, found %llu expected %llu",
+				 entry->bytes, bytes);
+			return -EINVAL;
+		}
+	}
+
+	/* Now validate bitmaps do the correct thing. */
+	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	for (i = 0; i < 2; i++) {
+		offset = i * BITS_PER_BITMAP * sectorsize;
+		bytes = (i + 1) * SZ_1M;
+		ret = test_add_free_space_entry(cache, offset, bytes, 1);
+		if (ret) {
+			test_err("couldn't add bitmap entry");
+			return ret;
+		}
+	}
+
+	for (n = rb_first_cached(&ctl->free_space_bytes), i = 1; n;
+	     n = rb_next(n), i--) {
+		entry = rb_entry(n, struct btrfs_free_space, bytes_index);
+		bytes = (i + 1) * SZ_1M;
+		if (entry->bytes != bytes) {
+			test_err("invalid bytes index order, found %llu expected %llu",
+				 entry->bytes, bytes);
+			return -EINVAL;
+		}
+	}
+
+	/* Now validate bitmaps with different ->max_extent_size. */
+	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	orig_free_space_ops = cache->free_space_ctl->op;
+	cache->free_space_ctl->op = &test_free_space_ops;
+
+	ret = test_add_free_space_entry(cache, 0, sectorsize, 1);
+	if (ret) {
+		test_err("couldn't add bitmap entry");
+		return ret;
+	}
+
+	offset = BITS_PER_BITMAP * sectorsize;
+	ret = test_add_free_space_entry(cache, offset, sectorsize, 1);
+	if (ret) {
+		test_err("couldn't add bitmap_entry");
+		return ret;
+	}
+
+	/*
+	 * Now set a bunch of sectorsize extents in the first entry so it's
+	 * ->bytes is large.
+	 */
+	for (i = 2; i < 20; i += 2) {
+		offset = sectorsize * i;
+		ret = btrfs_add_free_space(cache, offset, sectorsize);
+		if (ret) {
+			test_err("error populating sparse bitmap %d", ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Now set a contiguous extent in the second bitmap so its
+	 * ->max_extent_size is larger than the first bitmaps.
+	 */
+	offset = (BITS_PER_BITMAP * sectorsize) + sectorsize;
+	ret = btrfs_add_free_space(cache, offset, sectorsize);
+	if (ret) {
+		test_err("error adding contiguous extent %d", ret);
+		return ret;
+	}
+
+	/*
+	 * Since we don't set ->max_extent_size unless we search everything
+	 * should be indexed on bytes.
+	 */
+	entry = rb_entry(rb_first_cached(&ctl->free_space_bytes),
+			 struct btrfs_free_space, bytes_index);
+	if (entry->bytes != (10 * sectorsize)) {
+		test_err("error, wrong entry in the first slot in bytes_index");
+		return -EINVAL;
+	}
+
+	max_extent_size = 0;
+	offset = btrfs_find_space_for_alloc(cache, cache->start, sectorsize * 3,
+					    0, &max_extent_size);
+	if (offset != 0) {
+		test_err("found space to alloc even though we don't have enough space");
+		return -EINVAL;
+	}
+
+	if (max_extent_size != (2 * sectorsize)) {
+		test_err("got the wrong max_extent size %llu expected %llu",
+			 max_extent_size, (unsigned long long)(2 * sectorsize));
+		return -EINVAL;
+	}
+
+	/*
+	 * The search should have re-arranged the bytes index to use the
+	 * ->max_extent_size, validate it's now what we expect it to be.
+	 */
+	entry = rb_entry(rb_first_cached(&ctl->free_space_bytes),
+			 struct btrfs_free_space, bytes_index);
+	if (entry->bytes != (2 * sectorsize)) {
+		test_err("error, the bytes index wasn't recalculated properly");
+		return -EINVAL;
+	}
+
+	/* Add another sectorsize to re-arrange the tree back to ->bytes. */
+	offset = (BITS_PER_BITMAP * sectorsize) - sectorsize;
+	ret = btrfs_add_free_space(cache, offset, sectorsize);
+	if (ret) {
+		test_err("error adding extent to the sparse entry %d", ret);
+		return ret;
+	}
+
+	entry = rb_entry(rb_first_cached(&ctl->free_space_bytes),
+			 struct btrfs_free_space, bytes_index);
+	if (entry->bytes != (11 * sectorsize)) {
+		test_err("error, wrong entry in the first slot in bytes_index");
+		return -EINVAL;
+	}
+
+	/*
+	 * Now make sure we find our correct entry after searching that will
+	 * result in a re-arranging of the tree.
+	 */
+	max_extent_size = 0;
+	offset = btrfs_find_space_for_alloc(cache, cache->start, sectorsize * 2,
+					    0, &max_extent_size);
+	if (offset != (BITS_PER_BITMAP * sectorsize)) {
+		test_err("error, found %llu instead of %llu for our alloc",
+			 offset,
+			 (unsigned long long)(BITS_PER_BITMAP * sectorsize));
+		return -EINVAL;
+	}
+
+	cache->free_space_ctl->op = orig_free_space_ops;
+	__btrfs_remove_free_space_cache(cache->free_space_ctl);
+	return 0;
+}
+
 int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info;
@@ -871,6 +1049,9 @@ int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 		goto out;
 
 	ret = test_steal_space_from_bitmap_to_extent(cache, sectorsize);
+	if (ret)
+		goto out;
+	ret = test_bytes_index(cache, sectorsize);
 out:
 	btrfs_free_dummy_block_group(cache);
 	btrfs_free_dummy_root(root);
-- 
2.26.3

