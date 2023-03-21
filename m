Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EDD6C2FFB
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 12:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCULOt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 07:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjCULOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 07:14:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BA27A94
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 04:14:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E74D3B815BD
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC03C4339B
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 11:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679397261;
        bh=NueealvMRsK3iixCbTzLOBCzyh7/6CN9fX/gFZWst6E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qs93rlAbg1dA3YO4E5bDViyEcOJdFztJ3m+JB1tKKgHD3P4kjzgZXM/SKj5/hcStH
         ll1GN9IW4EbwF8dDq+wY90NZd9bAa/wm30dJYXtqloiCLSvxWAIawdkBx9/POJ/1eP
         I91ITnVCS2wPujAww/ZFVxXXnNXNCgkv9XF7TFGHtcKvakbE4aVf0TvNNfOdHhQ4Xd
         pd8s4rxhy4Ziotc+ubfkHrGGtqD4mxBm7VTv9rrXPOQlEwMxY+IRwB7DTlZgD2Nz6T
         QEiq7ylWHHDGpGPWIzDib9CsrPGf90kWirVpv4UybcigawjOmz1jAWs/4iBv8I8vFG
         hNsN3qcyXVnQg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 19/24] btrfs: add helper to calculate space for delayed references
Date:   Tue, 21 Mar 2023 11:13:55 +0000
Message-Id: <9ed53459825f637db5e101eb4680a20487f84da3.1679326434.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1679326426.git.fdmanana@suse.com>
References: <cover.1679326426.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Instead of duplicating the logic for calculating how much space is
required for a given number of delayed references, add an inline helper
to encapsulate that logic and use it everywhere we are calculating the
space required.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/delayed-ref.c | 40 ++++------------------------------------
 fs/btrfs/delayed-ref.h | 21 +++++++++++++++++++++
 fs/btrfs/space-info.c  | 14 +-------------
 3 files changed, 26 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
index b58a7e30d37c..0b32432d7d56 100644
--- a/fs/btrfs/delayed-ref.c
+++ b/fs/btrfs/delayed-ref.c
@@ -65,20 +65,9 @@ bool btrfs_check_space_for_delayed_refs(struct btrfs_fs_info *fs_info)
 void btrfs_delayed_refs_rsv_release(struct btrfs_fs_info *fs_info, int nr)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
-	u64 num_bytes = btrfs_calc_insert_metadata_size(fs_info, nr);
+	const u64 num_bytes = btrfs_calc_delayed_ref_bytes(fs_info, nr);
 	u64 released = 0;
 
-	/*
-	 * We have to check the mount option here because we could be enabling
-	 * the free space tree for the first time and don't have the compat_ro
-	 * option set yet.
-	 *
-	 * We need extra reservations if we have the free space tree because
-	 * we'll have to modify that tree as well.
-	 */
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
-		num_bytes *= 2;
-
 	released = btrfs_block_rsv_release(fs_info, block_rsv, num_bytes, NULL);
 	if (released)
 		trace_btrfs_space_reservation(fs_info, "delayed_refs_rsv",
@@ -100,18 +89,8 @@ void btrfs_update_delayed_refs_rsv(struct btrfs_trans_handle *trans)
 	if (!trans->delayed_ref_updates)
 		return;
 
-	num_bytes = btrfs_calc_insert_metadata_size(fs_info,
-						    trans->delayed_ref_updates);
-	/*
-	 * We have to check the mount option here because we could be enabling
-	 * the free space tree for the first time and don't have the compat_ro
-	 * option set yet.
-	 *
-	 * We need extra reservations if we have the free space tree because
-	 * we'll have to modify that tree as well.
-	 */
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
-		num_bytes *= 2;
+	num_bytes = btrfs_calc_delayed_ref_bytes(fs_info,
+						 trans->delayed_ref_updates);
 
 	spin_lock(&delayed_rsv->lock);
 	delayed_rsv->size += num_bytes;
@@ -182,21 +161,10 @@ int btrfs_delayed_refs_rsv_refill(struct btrfs_fs_info *fs_info,
 				  enum btrfs_reserve_flush_enum flush)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->delayed_refs_rsv;
-	u64 limit = btrfs_calc_insert_metadata_size(fs_info, 1);
+	u64 limit = btrfs_calc_delayed_ref_bytes(fs_info, 1);
 	u64 num_bytes = 0;
 	int ret = -ENOSPC;
 
-	/*
-	 * We have to check the mount option here because we could be enabling
-	 * the free space tree for the first time and don't have the compat_ro
-	 * option set yet.
-	 *
-	 * We need extra reservations if we have the free space tree because
-	 * we'll have to modify that tree as well.
-	 */
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
-		limit *= 2;
-
 	spin_lock(&block_rsv->lock);
 	if (block_rsv->reserved < block_rsv->size) {
 		num_bytes = block_rsv->size - block_rsv->reserved;
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 6cf1adc9a01a..b54261fe509b 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -253,6 +253,27 @@ extern struct kmem_cache *btrfs_delayed_extent_op_cachep;
 int __init btrfs_delayed_ref_init(void);
 void __cold btrfs_delayed_ref_exit(void);
 
+static inline u64 btrfs_calc_delayed_ref_bytes(const struct btrfs_fs_info *fs_info,
+					       int num_delayed_refs)
+{
+	u64 num_bytes;
+
+	num_bytes = btrfs_calc_insert_metadata_size(fs_info, num_delayed_refs);
+
+	/*
+	 * We have to check the mount option here because we could be enabling
+	 * the free space tree for the first time and don't have the compat_ro
+	 * option set yet.
+	 *
+	 * We need extra reservations if we have the free space tree because
+	 * we'll have to modify that tree as well.
+	 */
+	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
+		num_bytes *= 2;
+
+	return num_bytes;
+}
+
 static inline void btrfs_init_generic_ref(struct btrfs_ref *generic_ref,
 				int action, u64 bytenr, u64 len, u64 parent)
 {
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index a2e14c410416..75e7fa337e66 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -553,21 +553,9 @@ static inline u64 calc_reclaim_items_nr(const struct btrfs_fs_info *fs_info,
 static inline u64 calc_delayed_refs_nr(const struct btrfs_fs_info *fs_info,
 				       u64 to_reclaim)
 {
-	u64 bytes;
+	const u64 bytes = btrfs_calc_delayed_ref_bytes(fs_info, 1);
 	u64 nr;
 
-	bytes = btrfs_calc_insert_metadata_size(fs_info, 1);
-	/*
-	 * We have to check the mount option here because we could be enabling
-	 * the free space tree for the first time and don't have the compat_ro
-	 * option set yet.
-	 *
-	 * We need extra reservations if we have the free space tree because
-	 * we'll have to modify that tree as well.
-	 */
-	if (btrfs_test_opt(fs_info, FREE_SPACE_TREE))
-		bytes *= 2;
-
 	nr = div64_u64(to_reclaim, bytes);
 	if (!nr)
 		nr = 1;
-- 
2.34.1

