Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95C204D0B32
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 23:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343800AbiCGWiU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 17:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245253AbiCGWiQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 17:38:16 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62C570062
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 14:37:19 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id a1so14600106qta.13
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Mar 2022 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tTL6AreS2AZI0pS4N1sF87qfcyR+46VsrJyidCGs1JI=;
        b=4HMky/vxyj2z7gl/Ut0ylHerIjGWOvdq8jSQ3cPE3nQvDq6OS1VTkTK93nzHa+wt1n
         IEeUycmaMxrr9whRPPRLvMJ16JbRsQBovwPlFQ79FZeXYuAMcC8vzRQfHsyP//kgGTuf
         5/oF7/VFEqWu+TAU50e56TkeI+H2fvJmgOqr/It7/ka6flBlOddZwueidNe1n18QWruj
         cPiSJ8KORAloUsWc3OyEgeKJjh3xeMJfMvcZPENhU9+NSK92C3FbK6kb5tnZm8QcsT2Y
         tOUZ7CSyUBO/QTgc020/2XzlrKxp8E6mXzJ9bV+AaXcSV/fQY5aHR+y0heMqq6Aj7LTi
         /qDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tTL6AreS2AZI0pS4N1sF87qfcyR+46VsrJyidCGs1JI=;
        b=PfoVq0fOucXv1bAfI0nWKzB/Dx5IBJMU4AQObmiY/4n+sMXDTDsGTh2rEIFvdqpxab
         1bB6t8+kFyYWtnVYDxGGX9CFjVBmtGsF/1mN6s9aI5SUqHPFEiQEt+J77bxHQ8h8bHxu
         MMqkg29X8Kw8VMY1+q+MlmrXVVLzd6utqcMCjOpmOx7/N1lb/1u17BUQtw0OeQcksLZa
         Z3KGQ437BOH6oxv2a0hBtVjZu79jjkMwMO6HrNh4fpqU/Ds/be2SZodCYqGsfKkx83sq
         l6kuZHwZwfEjYgQdMsqa7zcVfyIcPsHyblTkn6JzTspCC4alVgLyMd3y69H0OyandVsi
         yuRQ==
X-Gm-Message-State: AOAM532FJbVKuJhLf+4455jhOYYWbiIquFuGnXnE58EzBrLTv1nIrvKI
        pq/J1gqQO6ooi4jRRDuNQG6oSeyz8xYj1NRG
X-Google-Smtp-Source: ABdhPJwnPawoTkxBBtkA1cWQ+FoCilIP1uoFszc2bBr6AHMQ5O/5+HmytdUKlKXuHSSFAOFGkhitIw==
X-Received: by 2002:ac8:5c4f:0:b0:2e0:63a9:5197 with SMTP id j15-20020ac85c4f000000b002e063a95197mr7683522qtj.361.1646692638448;
        Mon, 07 Mar 2022 14:37:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id p4-20020a378d04000000b0047cfa3a0cffsm6764388qkd.34.2022.03.07.14.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 14:37:18 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 11/11] btrfs: selftests: run with EXTENT_TREE_V2 set as well
Date:   Mon,  7 Mar 2022 17:37:01 -0500
Message-Id: <dcdf0a46d38abd6d1c443668b32cb6ce1f54fca2.1646692474.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1646692474.git.josef@toxicpanda.com>
References: <cover.1646692474.git.josef@toxicpanda.com>
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

With the btrfs header change I wanted to validate that the math worked
out properly.  To do this I modified the tests to also test with
EXTENT_TREE_V2 set and without.  This requires passing the incompat
flags throughout the stack which is why this looks so churny.  Finally
with the flag set on the fs_info we can allocate dummy extent buffers
with the HEADER_FLAG_V2 set on them to get the correct math.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>

 with '#' will be ignored, and an empty message aborts the commit.
---
 fs/btrfs/extent_io.c                   |  2 +
 fs/btrfs/tests/btrfs-tests.c           | 77 ++++++++++++++++----------
 fs/btrfs/tests/btrfs-tests.h           | 18 +++---
 fs/btrfs/tests/extent-buffer-tests.c   | 19 ++++---
 fs/btrfs/tests/extent-io-tests.c       |  9 +--
 fs/btrfs/tests/extent-map-tests.c      |  2 +-
 fs/btrfs/tests/free-space-tests.c      |  6 +-
 fs/btrfs/tests/free-space-tree-tests.c | 21 ++++---
 fs/btrfs/tests/inode-tests.c           | 25 +++++----
 fs/btrfs/tests/qgroup-tests.c          |  5 +-
 10 files changed, 115 insertions(+), 69 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 88dc53595192..c7088c4ad305 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5961,6 +5961,8 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	btrfs_set_header_nritems(eb, 0);
 	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 	memzero_extent_buffer(eb, 0, sizeof(struct btrfs_header));
+	if (btrfs_fs_incompat(fs_info, EXTENT_TREE_V2))
+		btrfs_set_header_flag(eb, BTRFS_HEADER_FLAG_V2);
 
 	return eb;
 err:
diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
index d8e56edd6991..ad19739d677d 100644
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -113,7 +113,8 @@ static void btrfs_free_dummy_device(struct btrfs_device *dev)
 	kfree(dev);
 }
 
-struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
+struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize,
+						u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info = kzalloc(sizeof(struct btrfs_fs_info),
 						GFP_KERNEL);
@@ -142,6 +143,7 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize)
 	fs_info->sectorsize = sectorsize;
 	fs_info->sectorsize_bits = ilog2(sectorsize);
 	set_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
+	btrfs_set_super_incompat_flags(fs_info->super_copy, incompat_flags);
 
 	test_mnt->mnt_sb->s_fs_info = fs_info;
 
@@ -256,42 +258,61 @@ void btrfs_init_dummy_trans(struct btrfs_trans_handle *trans,
 	trans->fs_info = fs_info;
 }
 
+static int run_sectorsize_tests(u32 sectorsize, u32 nodesize,
+				 u64 incompat_flags)
+{
+	int ret;
+
+	pr_info("BTRFS: selftest: sectorsize: %u  nodesize: %u  incompat_flags: %llu\n",
+		sectorsize, nodesize, incompat_flags);
+	ret = btrfs_test_free_space_cache(sectorsize, nodesize, incompat_flags);
+	if (ret)
+		return ret;
+	ret = btrfs_test_extent_buffer_operations(sectorsize, nodesize,
+						  incompat_flags);
+	if (ret)
+		return ret;
+	ret = btrfs_test_extent_io(sectorsize, nodesize, incompat_flags);
+	if (ret)
+		return ret;
+	ret = btrfs_test_inodes(sectorsize, nodesize, incompat_flags);
+	if (ret)
+		return ret;
+	ret = btrfs_test_qgroups(sectorsize, nodesize, incompat_flags);
+	if (ret)
+		return ret;
+	return btrfs_test_free_space_tree(sectorsize, nodesize, incompat_flags);
+}
+
 int btrfs_run_sanity_tests(void)
 {
-	int ret, i;
+	int ret, i, c;
 	u32 sectorsize, nodesize;
 	u32 test_sectorsize[] = {
 		PAGE_SIZE,
 	};
+	u64 test_incompat_flags[] = {
+		0,
+		BTRFS_FEATURE_INCOMPAT_EXTENT_TREE_V2,
+	};
+	u64 flags;
+
 	ret = btrfs_init_test_fs();
 	if (ret)
 		return ret;
-	for (i = 0; i < ARRAY_SIZE(test_sectorsize); i++) {
-		sectorsize = test_sectorsize[i];
-		for (nodesize = sectorsize;
-		     nodesize <= BTRFS_MAX_METADATA_BLOCKSIZE;
-		     nodesize <<= 1) {
-			pr_info("BTRFS: selftest: sectorsize: %u  nodesize: %u\n",
-				sectorsize, nodesize);
-			ret = btrfs_test_free_space_cache(sectorsize, nodesize);
-			if (ret)
-				goto out;
-			ret = btrfs_test_extent_buffer_operations(sectorsize,
-				nodesize);
-			if (ret)
-				goto out;
-			ret = btrfs_test_extent_io(sectorsize, nodesize);
-			if (ret)
-				goto out;
-			ret = btrfs_test_inodes(sectorsize, nodesize);
-			if (ret)
-				goto out;
-			ret = btrfs_test_qgroups(sectorsize, nodesize);
-			if (ret)
-				goto out;
-			ret = btrfs_test_free_space_tree(sectorsize, nodesize);
-			if (ret)
-				goto out;
+
+	for (c = 0; c < ARRAY_SIZE(test_incompat_flags); c++) {
+		flags = test_incompat_flags[c];
+		for (i = 0; i < ARRAY_SIZE(test_sectorsize); i++) {
+			sectorsize = test_sectorsize[i];
+			for (nodesize = sectorsize;
+			     nodesize <= BTRFS_MAX_METADATA_BLOCKSIZE;
+			     nodesize <<= 1) {
+				ret = run_sectorsize_tests(sectorsize, nodesize,
+							   flags);
+				if (ret)
+					goto out;
+			}
 		}
 	}
 	ret = btrfs_test_extent_map();
diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
index 7a2d7ffbe30e..5d02bf83f7f3 100644
--- a/fs/btrfs/tests/btrfs-tests.h
+++ b/fs/btrfs/tests/btrfs-tests.h
@@ -30,15 +30,19 @@ extern const char *test_error[];
 struct btrfs_root;
 struct btrfs_trans_handle;
 
-int btrfs_test_extent_buffer_operations(u32 sectorsize, u32 nodesize);
-int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize);
-int btrfs_test_extent_io(u32 sectorsize, u32 nodesize);
-int btrfs_test_inodes(u32 sectorsize, u32 nodesize);
-int btrfs_test_qgroups(u32 sectorsize, u32 nodesize);
-int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize);
+int btrfs_test_extent_buffer_operations(u32 sectorsize, u32 nodesize,
+					u64 incompat_flags);
+int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize,
+				u64 incompat_flags);
+int btrfs_test_extent_io(u32 sectorsize, u32 nodesize, u64 incompat_flags);
+int btrfs_test_inodes(u32 sectorsize, u32 nodesize, u64 incompat_flags);
+int btrfs_test_qgroups(u32 sectorsize, u32 nodesize, u64 incompat_flags);
+int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize,
+			       u64 incompat_flags);
 int btrfs_test_extent_map(void);
 struct inode *btrfs_new_test_inode(void);
-struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize);
+struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 sectorsize,
+						u64 incompat_flags);
 void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info);
 void btrfs_free_dummy_root(struct btrfs_root *root);
 struct btrfs_block_group *
diff --git a/fs/btrfs/tests/extent-buffer-tests.c b/fs/btrfs/tests/extent-buffer-tests.c
index 131495ffad12..9765638120a7 100644
--- a/fs/btrfs/tests/extent-buffer-tests.c
+++ b/fs/btrfs/tests/extent-buffer-tests.c
@@ -10,7 +10,8 @@
 #include "../disk-io.h"
 #include "../transaction.h"
 
-static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
+static int test_btrfs_split_item(u32 sectorsize, u32 nodesize,
+				 u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_path *path = NULL;
@@ -28,7 +29,8 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 
 	test_msg("running btrfs_split_item tests");
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize,
+					    incompat_flags);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
@@ -211,7 +213,8 @@ static int test_btrfs_split_item(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-static int test_delete_one_dir_name(u32 sectorsize, u32 nodesize)
+static int test_delete_one_dir_name(u32 sectorsize, u32 nodesize,
+				    u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_path *path = NULL;
@@ -228,7 +231,8 @@ static int test_delete_one_dir_name(u32 sectorsize, u32 nodesize)
 
 	test_msg("running btrfs_delete_one_dir_name tests");
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize,
+					    incompat_flags);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
@@ -372,14 +376,15 @@ static int test_delete_one_dir_name(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-int btrfs_test_extent_buffer_operations(u32 sectorsize, u32 nodesize)
+int btrfs_test_extent_buffer_operations(u32 sectorsize, u32 nodesize,
+					u64 incompat_flags)
 {
 	int ret;
 
 	test_msg("running extent buffer operation tests");
-	ret = test_btrfs_split_item(sectorsize, nodesize);
+	ret = test_btrfs_split_item(sectorsize, nodesize, incompat_flags);
 	if (ret)
 		return ret;
 	test_msg("running delete dir name etests");
-	return test_delete_one_dir_name(sectorsize, nodesize);
+	return test_delete_one_dir_name(sectorsize, nodesize, incompat_flags);
 }
diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index a232b15b8021..3c181d26b431 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -426,7 +426,7 @@ static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb,
 	return 0;
 }
 
-static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
+static int test_eb_bitmaps(u32 sectorsize, u32 nodesize, u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info;
 	unsigned long *bitmap = NULL;
@@ -435,7 +435,8 @@ static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 
 	test_msg("running extent buffer bitmap tests");
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize,
+					    incompat_flags);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
@@ -591,7 +592,7 @@ static int test_find_first_clear_extent_bit(void)
 	return ret;
 }
 
-int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
+int btrfs_test_extent_io(u32 sectorsize, u32 nodesize, u64 incompat_flags)
 {
 	int ret;
 
@@ -605,7 +606,7 @@ int btrfs_test_extent_io(u32 sectorsize, u32 nodesize)
 	if (ret)
 		goto out;
 
-	ret = test_eb_bitmaps(sectorsize, nodesize);
+	ret = test_eb_bitmaps(sectorsize, nodesize, incompat_flags);
 out:
 	return ret;
 }
diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index c5b3a631bf4f..74aef02664fc 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -596,7 +596,7 @@ int btrfs_test_extent_map(void)
 	 * Note: the fs_info is not set up completely, we only need
 	 * fs_info::fsid for the tracepoint.
 	 */
-	fs_info = btrfs_alloc_dummy_fs_info(PAGE_SIZE, PAGE_SIZE);
+	fs_info = btrfs_alloc_dummy_fs_info(PAGE_SIZE, PAGE_SIZE, 0);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-space-tests.c
index 5930cdcae5cb..f703c9085543 100644
--- a/fs/btrfs/tests/free-space-tests.c
+++ b/fs/btrfs/tests/free-space-tests.c
@@ -1002,7 +1002,8 @@ static int test_bytes_index(struct btrfs_block_group *cache, u32 sectorsize)
 	return 0;
 }
 
-int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
+int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize,
+				u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_block_group *cache;
@@ -1010,7 +1011,8 @@ int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
 	int ret = -ENOMEM;
 
 	test_msg("running btrfs free space cache tests");
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize,
+					    incompat_flags);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/free-space-tree-tests.c
index 13734ed43bfc..a57261136653 100644
--- a/fs/btrfs/tests/free-space-tree-tests.c
+++ b/fs/btrfs/tests/free-space-tree-tests.c
@@ -421,7 +421,7 @@ typedef int (*test_func_t)(struct btrfs_trans_handle *,
 			   u32 alignment);
 
 static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
-		    u32 nodesize, u32 alignment)
+		    u32 nodesize, u32 alignment, u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info;
 	struct btrfs_root *root = NULL;
@@ -430,7 +430,8 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 	struct btrfs_path *path = NULL;
 	int ret;
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize,
+					    incompat_flags);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		ret = -ENOMEM;
@@ -522,12 +523,14 @@ static int run_test(test_func_t test_func, int bitmaps, u32 sectorsize,
 }
 
 static int run_test_both_formats(test_func_t test_func, u32 sectorsize,
-				 u32 nodesize, u32 alignment)
+				 u32 nodesize, u32 alignment,
+				 u64 incompat_flags)
 {
 	int test_ret = 0;
 	int ret;
 
-	ret = run_test(test_func, 0, sectorsize, nodesize, alignment);
+	ret = run_test(test_func, 0, sectorsize, nodesize, alignment,
+		       incompat_flags);
 	if (ret) {
 		test_err(
 	"%ps failed with extents, sectorsize=%u, nodesize=%u, alignment=%u",
@@ -535,7 +538,8 @@ static int run_test_both_formats(test_func_t test_func, u32 sectorsize,
 		test_ret = ret;
 	}
 
-	ret = run_test(test_func, 1, sectorsize, nodesize, alignment);
+	ret = run_test(test_func, 1, sectorsize, nodesize, alignment,
+		       incompat_flags);
 	if (ret) {
 		test_err(
 	"%ps failed with bitmaps, sectorsize=%u, nodesize=%u, alignment=%u",
@@ -546,7 +550,8 @@ static int run_test_both_formats(test_func_t test_func, u32 sectorsize,
 	return test_ret;
 }
 
-int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize)
+int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize,
+			       u64 incompat_flags)
 {
 	test_func_t tests[] = {
 		test_empty_block_group,
@@ -574,12 +579,12 @@ int btrfs_test_free_space_tree(u32 sectorsize, u32 nodesize)
 		int ret;
 
 		ret = run_test_both_formats(tests[i], sectorsize, nodesize,
-					    sectorsize);
+					    sectorsize, incompat_flags);
 		if (ret)
 			test_ret = ret;
 
 		ret = run_test_both_formats(tests[i], sectorsize, nodesize,
-					    bitmap_alignment);
+					    bitmap_alignment, incompat_flags);
 		if (ret)
 			test_ret = ret;
 	}
diff --git a/fs/btrfs/tests/inode-tests.c b/fs/btrfs/tests/inode-tests.c
index cac89c388131..df960a0f96ae 100644
--- a/fs/btrfs/tests/inode-tests.c
+++ b/fs/btrfs/tests/inode-tests.c
@@ -213,7 +213,8 @@ static unsigned long prealloc_only = 0;
 static unsigned long compressed_only = 0;
 static unsigned long vacancy_only = 0;
 
-static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
+static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize,
+					  u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct inode *inode = NULL;
@@ -232,7 +233,8 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 		return ret;
 	}
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize,
+					    incompat_flags);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		goto out;
@@ -814,7 +816,7 @@ static noinline int test_btrfs_get_extent(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-static int test_hole_first(u32 sectorsize, u32 nodesize)
+static int test_hole_first(u32 sectorsize, u32 nodesize, u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct inode *inode = NULL;
@@ -830,7 +832,8 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 		return ret;
 	}
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize,
+					    incompat_flags);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		goto out;
@@ -912,7 +915,8 @@ static int test_hole_first(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-static int test_extent_accounting(u32 sectorsize, u32 nodesize)
+static int test_extent_accounting(u32 sectorsize, u32 nodesize,
+				  u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct inode *inode = NULL;
@@ -927,7 +931,8 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 		return ret;
 	}
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize,
+					    incompat_flags);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		goto out;
@@ -1099,7 +1104,7 @@ static int test_extent_accounting(u32 sectorsize, u32 nodesize)
 	return ret;
 }
 
-int btrfs_test_inodes(u32 sectorsize, u32 nodesize)
+int btrfs_test_inodes(u32 sectorsize, u32 nodesize, u64 incompat_flags)
 {
 	int ret;
 
@@ -1108,11 +1113,11 @@ int btrfs_test_inodes(u32 sectorsize, u32 nodesize)
 	set_bit(EXTENT_FLAG_COMPRESSED, &compressed_only);
 	set_bit(EXTENT_FLAG_PREALLOC, &prealloc_only);
 
-	ret = test_btrfs_get_extent(sectorsize, nodesize);
+	ret = test_btrfs_get_extent(sectorsize, nodesize, incompat_flags);
 	if (ret)
 		return ret;
-	ret = test_hole_first(sectorsize, nodesize);
+	ret = test_hole_first(sectorsize, nodesize, incompat_flags);
 	if (ret)
 		return ret;
-	return test_extent_accounting(sectorsize, nodesize);
+	return test_extent_accounting(sectorsize, nodesize, incompat_flags);
 }
diff --git a/fs/btrfs/tests/qgroup-tests.c b/fs/btrfs/tests/qgroup-tests.c
index eee1e4459541..ef42662b2769 100644
--- a/fs/btrfs/tests/qgroup-tests.c
+++ b/fs/btrfs/tests/qgroup-tests.c
@@ -434,14 +434,15 @@ static int test_multiple_refs(struct btrfs_root *root,
 	return 0;
 }
 
-int btrfs_test_qgroups(u32 sectorsize, u32 nodesize)
+int btrfs_test_qgroups(u32 sectorsize, u32 nodesize, u64 incompat_flags)
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct btrfs_root *root;
 	struct btrfs_root *tmp_root;
 	int ret = 0;
 
-	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize,
+					    incompat_flags);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
-- 
2.26.3

