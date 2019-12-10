Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C81FE118F6D
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2019 19:00:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfLJSAu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Dec 2019 13:00:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:37262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727625AbfLJSAt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Dec 2019 13:00:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8C34AC4B;
        Tue, 10 Dec 2019 18:00:47 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2] btrfs: Add self-tests for btrfs_rmap_block
Date:   Tue, 10 Dec 2019 20:00:45 +0200
Message-Id: <20191210180045.2047-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191126160439.GI2734@twin.jikos.cz>
References: <20191126160439.GI2734@twin.jikos.cz>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is enough to exercise out of boundary address exclusion as well as
address matching.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
V2:
 * Adjusted comments about some members of struct rmap_test_vector
 * Fixed inline comments
 * Correctly handle error when initialising dummy device
 * Other minor cosmetic changes around comments/braces for single statement 'if'
 and structure initialization

 fs/btrfs/tests/extent-map-tests.c | 146 +++++++++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
index 4a7f796c9900..4878904434af 100644
--- a/fs/btrfs/tests/extent-map-tests.c
+++ b/fs/btrfs/tests/extent-map-tests.c
@@ -6,6 +6,10 @@
 #include <linux/types.h>
 #include "btrfs-tests.h"
 #include "../ctree.h"
+#include "../volumes.h"
+#include "../disk-io.h"
+#include "../block-group.h"
+

 static void free_extent_map_tree(struct extent_map_tree *em_tree)
 {
@@ -437,11 +441,144 @@ static int test_case_4(struct btrfs_fs_info *fs_info,
 	return ret;
 }

+struct rmap_test_vector {
+	u64 raid_type;
+	u64 physical_start;
+	u64 data_stripe_size;
+	u64 num_data_stripes;
+	u64 num_stripes;
+	/* Assume we won't have more than 5 physical stripes */
+	u64 data_stripe_phys_start[5];
+	int expected_mapped_addr;
+	/* Physical to logical addresses */
+	u64 mapped_logical[5];
+};
+
+static int test_rmap_block(struct btrfs_fs_info *fs_info,
+			   struct rmap_test_vector *test)
+{
+	struct extent_map *em;
+	struct map_lookup *map = NULL;
+	u64 *logical;
+	int i, out_ndaddrs, out_stripe_len;
+	int ret = -EINVAL;
+
+	em = alloc_extent_map();
+	if (!em) {
+		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		return -ENOMEM;
+	}
+
+	map = kmalloc(map_lookup_size(test->num_stripes), GFP_KERNEL);
+	if (!map) {
+		kfree(em);
+		test_std_err(TEST_ALLOC_EXTENT_MAP);
+		return -ENOMEM;
+	}
+
+	set_bit(EXTENT_FLAG_FS_MAPPING, &em->flags);
+	/* Start at 4gb logical address */
+	em->start = SZ_4G;
+	em->len = test->data_stripe_size * test->num_data_stripes;
+	em->block_len = em->len;
+	em->orig_block_len = test->data_stripe_size;
+	em->map_lookup = map;
+
+	map->num_stripes = test->num_stripes;
+	map->stripe_len = BTRFS_STRIPE_LEN;
+	map->type = test->raid_type;
+
+	for (i = 0; i < map->num_stripes; i++)
+	{
+		struct btrfs_device *dev = btrfs_alloc_dummy_device(fs_info);
+		if (!dev) {
+			test_err("ENOMEM while allocating dummy device");
+			goto out;
+		}
+		map->stripes[i].dev = dev;
+		map->stripes[i].physical = test->data_stripe_phys_start[i];
+	}
+
+	write_lock(&fs_info->mapping_tree.lock);
+	ret = add_extent_mapping(&fs_info->mapping_tree, em, 0);
+	write_unlock(&fs_info->mapping_tree.lock);
+	if (ret)
+		test_err("Error adding block group mapping to mapping tree");
+
+	ret = btrfs_rmap_block(fs_info, em->start, btrfs_sb_offset(1),
+			       &logical, &out_ndaddrs, &out_stripe_len);
+	if (ret || (out_ndaddrs == 0 && test->expected_mapped_addr)) {
+		test_err("Didn't rmap anything but expected %d",
+			 test->expected_mapped_addr);
+		goto out;
+	}
+
+	if (out_stripe_len != BTRFS_STRIPE_LEN) {
+		test_err("Calculated stripe len doesn't match");
+		goto out;
+	}
+
+	if (out_ndaddrs != test->expected_mapped_addr) {
+		for (i = 0; i < out_ndaddrs; i++)
+			test_msg("Mapped %llu", logical[i]);
+		test_err("Unexpected number of mapped addresses: %d", out_ndaddrs);
+		goto out;
+	}
+
+	for (i = 0; i < out_ndaddrs; i++) {
+		if (logical[i] != test->mapped_logical[i]) {
+			test_err("Unexpected logical address mapped");
+			goto out;
+		}
+	}
+
+	ret = 0;
+out:
+	write_lock(&fs_info->mapping_tree.lock);
+	remove_extent_mapping(&fs_info->mapping_tree, em);
+	write_unlock(&fs_info->mapping_tree.lock);
+	/* For us */
+	free_extent_map(em);
+	/* For the tree */
+	free_extent_map(em);
+	return ret;
+}
+
 int btrfs_test_extent_map(void)
 {
 	struct btrfs_fs_info *fs_info = NULL;
 	struct extent_map_tree *em_tree;
-	int ret = 0;
+	int ret = 0, i;
+	struct rmap_test_vector rmap_tests[] = {
+		{
+			/*
+			 * Tests a chunk with 2 data stripes one of which
+			 * interesects the physical address of the super block
+			 * is correctly recognised.
+			 */
+			.raid_type = BTRFS_BLOCK_GROUP_RAID1,
+			.physical_start = SZ_64M - SZ_4M,
+			.data_stripe_size = SZ_256M,
+			.num_data_stripes = 2,
+			.num_stripes = 2,
+			.data_stripe_phys_start = {SZ_64M - SZ_4M, SZ_64M - SZ_4M + SZ_256M},
+			.expected_mapped_addr = 1,
+			.mapped_logical= {SZ_4G + SZ_4M}
+		},
+		{
+			/* test that out of range physical addresses are ignored */
+
+			 /* SINGLE chunk type */
+			.raid_type = 0,
+			.physical_start = SZ_4G,
+			.data_stripe_size = SZ_256M,
+			.num_data_stripes = 1,
+			.num_stripes = 1,
+			.data_stripe_phys_start = {SZ_256M},
+			.expected_mapped_addr = 0,
+			.mapped_logical = {0}
+		}
+	};

 	test_msg("running extent_map tests");

@@ -474,6 +611,13 @@ int btrfs_test_extent_map(void)
 		goto out;
 	ret = test_case_4(fs_info, em_tree);

+	test_msg("Running rmap tests.");
+	for (i = 0; i < ARRAY_SIZE(rmap_tests); i++) {
+		ret = test_rmap_block(fs_info, &rmap_tests[i]);
+		if (ret)
+			goto out;
+	}
+
 out:
 	kfree(em_tree);
 	btrfs_free_dummy_fs_info(fs_info);
--
2.17.1

