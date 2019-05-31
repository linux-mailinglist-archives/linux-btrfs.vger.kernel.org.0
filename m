Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955DD3133A
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 May 2019 19:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfEaRA3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 May 2019 13:00:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:59994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfEaRA3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 May 2019 13:00:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DA18BADF0
        for <linux-btrfs@vger.kernel.org>; Fri, 31 May 2019 17:00:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 259E6DA85E; Fri, 31 May 2019 19:01:20 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: tests: add locks around add_extent_mapping
Date:   Fri, 31 May 2019 19:01:20 +0200
Message-Id: <fdcf7db557426d52b7af955b08f21a45a32c84bd.1559321947.git.dsterba@suse.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559321947.git.dsterba@suse.com>
References: <cover.1559321947.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are no concerns about locking during the selftests so the locks
are not necessary, but following patches will add lockdep assertions to
add_extent_mapping so this is needed in tests too.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/tests/extent-map-tests.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 87aeabe9d610..4a7f796c9900 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -66,7 +66,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->len = SZ_16K;
 	em->block_start = 0;
 	em->block_len = SZ_16K;
+	write_lock(&em_tree->lock);
 	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [0, 16K)");
 		goto out;
@@ -85,7 +87,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->len = SZ_4K;
 	em->block_start = SZ_32K; /* avoid merging */
 	em->block_len = SZ_4K;
+	write_lock(&em_tree->lock);
 	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [16K, 20K)");
 		goto out;
@@ -104,7 +108,9 @@ static int test_case_1(struct btrfs_fs_info *fs_info,
 	em->len = len;
 	em->block_start = start;
 	em->block_len = len;
+	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	write_unlock(&em_tree->lock);
 	if (ret) {
 		test_err("case1 [%llu %llu]: ret %d", start, start + len, ret);
 		goto out;
@@ -148,7 +154,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->len = SZ_1K;
 	em->block_start = EXTENT_MAP_INLINE;
 	em->block_len = (u64)-1;
+	write_lock(&em_tree->lock);
 	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [0, 1K)");
 		goto out;
@@ -167,7 +175,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
+	write_lock(&em_tree->lock);
 	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [4K, 8K)");
 		goto out;
@@ -186,7 +196,9 @@ static int test_case_2(struct btrfs_fs_info *fs_info,
 	em->len = SZ_1K;
 	em->block_start = EXTENT_MAP_INLINE;
 	em->block_len = (u64)-1;
+	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, em->start, em->len);
+	write_unlock(&em_tree->lock);
 	if (ret) {
 		test_err("case2 [0 1K]: ret %d", ret);
 		goto out;
@@ -225,7 +237,9 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->len = SZ_4K;
 	em->block_start = SZ_4K;
 	em->block_len = SZ_4K;
+	write_lock(&em_tree->lock);
 	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [4K, 8K)");
 		goto out;
@@ -244,7 +258,9 @@ static int __test_case_3(struct btrfs_fs_info *fs_info,
 	em->len = SZ_16K;
 	em->block_start = 0;
 	em->block_len = SZ_16K;
+	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
+	write_unlock(&em_tree->lock);
 	if (ret) {
 		test_err("case3 [0x%llx 0x%llx): ret %d",
 			 start, start + len, ret);
@@ -320,7 +336,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->len = SZ_8K;
 	em->block_start = 0;
 	em->block_len = SZ_8K;
+	write_lock(&em_tree->lock);
 	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [0, 8K)");
 		goto out;
@@ -339,7 +357,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->len = 24 * SZ_1K;
 	em->block_start = SZ_16K; /* avoid merging */
 	em->block_len = 24 * SZ_1K;
+	write_lock(&em_tree->lock);
 	ret = add_extent_mapping(em_tree, em, 0);
+	write_unlock(&em_tree->lock);
 	if (ret < 0) {
 		test_err("cannot add extent range [8K, 32K)");
 		goto out;
@@ -357,7 +377,9 @@ static int __test_case_4(struct btrfs_fs_info *fs_info,
 	em->len = SZ_32K;
 	em->block_start = 0;
 	em->block_len = SZ_32K;
+	write_lock(&em_tree->lock);
 	ret = btrfs_add_extent_mapping(fs_info, em_tree, &em, start, len);
+	write_unlock(&em_tree->lock);
 	if (ret) {
 		test_err("case4 [0x%llx 0x%llx): ret %d",
 			 start, len, ret);
-- 
2.21.0

