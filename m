Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD857B7D65
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Oct 2023 12:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242208AbjJDKjN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Oct 2023 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242204AbjJDKjE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Oct 2023 06:39:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E9CA1
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 03:39:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24460C433C7
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Oct 2023 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696415940;
        bh=cScWz5xNxquez9UjqSnJXQK3tbBno3wQfRCzvjfmZxg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=J0EcsdU3NxH7yHXAkYsIVmCvbTDs2U6y/MJ3uQhxgPfC2x1NfyF9an8jPOIobkhGC
         9vY3ZIHXgNo4rHxpVGRt/73WsfjY4e8rAy5lccwNROL+znn7dM+9D72z+x4wsFrQXB
         GHu2JUPbSAMX7SYNs3biUxwy2UG8sA6mX/KydtoOo7rs5wQodCmYV+IJUfQrZVx3+Y
         PmodwxfC8V3bUB6DrMZMaRinqq5rL4Gz+k+tjEitI0sWMFV+CfDhsX6h8N0jZfpaAO
         9kLDCt69cKxvA6mrJQUcNRBCLV5USXPhzrU5657321OSfV3VTOCqvcK81TCw6H1nDB
         ISH/Km51OqUWQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs: add and use helpers for reading and writing last_trans_committed
Date:   Wed,  4 Oct 2023 11:38:51 +0100
Message-Id: <d4373fd23d72cc44a3f81c344900875507ce898a.1696415673.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696415673.git.fdmanana@suse.com>
References: <cover.1696415673.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently the last_trans_committed field of struct btrfs_fs_info is
modified and read without any locking or other protection. For example
early in the fsync path, skip_inode_logging() is called which reads
fs_info->last_trans_committed, but at the same time we can have a
transaction commit completing and updating that field.

In the case of an fsync this is harmless and any data race should be
rare and at most cause an unnecessary logging of an inode.

To avoid data race warnings from tools like KCSAN and other issues such
as load and store tearing (amongst others, see [1]), create helpers to
access the last_commited_trans field of struct btrfs_fs_info using
READ_ONCE() and WRITE_ONCE(), and use these helpers everywhere.

[1] https://lwn.net/Articles/793253/

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c      |  9 +++++----
 fs/btrfs/file.c         |  2 +-
 fs/btrfs/fs.h           | 14 ++++++++++++++
 fs/btrfs/ioctl.c        |  2 +-
 fs/btrfs/scrub.c        |  2 +-
 fs/btrfs/super.c        |  7 ++++---
 fs/btrfs/transaction.c  |  6 +++---
 fs/btrfs/tree-checker.c |  2 +-
 8 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c84d32951b26..401ea09ae4b8 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -244,6 +244,7 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	struct extent_buffer *eb = bbio->private;
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	u64 found_start = btrfs_header_bytenr(eb);
+	u64 last_trans;
 	u8 result[BTRFS_CSUM_SIZE];
 	int ret;
 
@@ -281,12 +282,12 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	 * Also check the generation, the eb reached here must be newer than
 	 * last committed. Or something seriously wrong happened.
 	 */
-	if (unlikely(btrfs_header_generation(eb) <= fs_info->last_trans_committed)) {
+	last_trans = btrfs_get_last_trans_committed(fs_info);
+	if (unlikely(btrfs_header_generation(eb) <= last_trans)) {
 		ret = -EUCLEAN;
 		btrfs_err(fs_info,
 			"block=%llu bad generation, have %llu expect > %llu",
-			  eb->start, btrfs_header_generation(eb),
-			  fs_info->last_trans_committed);
+			  eb->start, btrfs_header_generation(eb), last_trans);
 		goto error;
 	}
 	write_extent_buffer(eb, result, 0, fs_info->csum_size);
@@ -2653,7 +2654,7 @@ static int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 
 		/* All successful */
 		fs_info->generation = btrfs_header_generation(tree_root->node);
-		fs_info->last_trans_committed = fs_info->generation;
+		btrfs_set_last_trans_committed(fs_info, fs_info->generation);
 		fs_info->last_reloc_trans = 0;
 
 		/* Always begin writing backup roots after the one being used */
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 723f0c70452e..92e6f224bff9 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1760,7 +1760,7 @@ static inline bool skip_inode_logging(const struct btrfs_log_ctx *ctx)
 	 * and for a fast fsync we don't wait for that, we only wait for the
 	 * writeback to complete.
 	 */
-	if (inode->last_trans <= fs_info->last_trans_committed &&
+	if (inode->last_trans <= btrfs_get_last_trans_committed(fs_info) &&
 	    (test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) ||
 	     list_empty(&ctx->ordered_extents)))
 		return true;
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index d04b729cbdf3..318df6f9d9cb 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -423,6 +423,10 @@ struct btrfs_fs_info {
 	 * Should always be updated using btrfs_set_fs_generation().
 	 */
 	u64 generation;
+	/*
+	 * Always use btrfs_get_last_trans_committed() and
+	 * btrfs_set_last_trans_committed() to read and update this field.
+	 */
 	u64 last_trans_committed;
 	/*
 	 * Generation of the last transaction used for block group relocation
@@ -833,6 +837,16 @@ static inline void btrfs_set_fs_generation(struct btrfs_fs_info *fs_info, u64 ge
 	WRITE_ONCE(fs_info->generation, gen);
 }
 
+static inline u64 btrfs_get_last_trans_committed(const struct btrfs_fs_info *fs_info)
+{
+	return READ_ONCE(fs_info->last_trans_committed);
+}
+
+static inline void btrfs_set_last_trans_committed(struct btrfs_fs_info *fs_info, u64 gen)
+{
+	WRITE_ONCE(fs_info->last_trans_committed, gen);
+}
+
 static inline void btrfs_set_last_root_drop_gen(struct btrfs_fs_info *fs_info,
 						u64 gen)
 {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7ab21283fae8..ab4ddbebeb16 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3131,7 +3131,7 @@ static noinline long btrfs_ioctl_start_sync(struct btrfs_root *root,
 			return PTR_ERR(trans);
 
 		/* No running transaction, don't bother */
-		transid = root->fs_info->last_trans_committed;
+		transid = btrfs_get_last_trans_committed(root->fs_info);
 		goto out;
 	}
 	transid = trans->transid;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index c477a14f1281..3e14f9cec19b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2769,7 +2769,7 @@ static noinline_for_stack int scrub_supers(struct scrub_ctx *sctx,
 	if (scrub_dev->fs_devices != fs_info->fs_devices)
 		gen = scrub_dev->generation;
 	else
-		gen = fs_info->last_trans_committed;
+		gen = btrfs_get_last_trans_committed(fs_info);
 
 	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
 		bytenr = btrfs_sb_offset(i);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 65883f5c488b..cc326969751f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2221,6 +2221,7 @@ static int check_dev_super(struct btrfs_device *dev)
 {
 	struct btrfs_fs_info *fs_info = dev->fs_info;
 	struct btrfs_super_block *sb;
+	u64 last_trans;
 	u16 csum_type;
 	int ret = 0;
 
@@ -2256,10 +2257,10 @@ static int check_dev_super(struct btrfs_device *dev)
 	if (ret < 0)
 		goto out;
 
-	if (btrfs_super_generation(sb) != fs_info->last_trans_committed) {
+	last_trans = btrfs_get_last_trans_committed(fs_info);
+	if (btrfs_super_generation(sb) != last_trans) {
 		btrfs_err(fs_info, "transid mismatch, has %llu expect %llu",
-			btrfs_super_generation(sb),
-			fs_info->last_trans_committed);
+			  btrfs_super_generation(sb), last_trans);
 		ret = -EUCLEAN;
 		goto out;
 	}
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f5db3a483f40..9694a3ca1739 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -980,7 +980,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 	int ret = 0;
 
 	if (transid) {
-		if (transid <= fs_info->last_trans_committed)
+		if (transid <= btrfs_get_last_trans_committed(fs_info))
 			goto out;
 
 		/* find specified transaction */
@@ -1004,7 +1004,7 @@ int btrfs_wait_for_commit(struct btrfs_fs_info *fs_info, u64 transid)
 		 * raced with btrfs_commit_transaction
 		 */
 		if (!cur_trans) {
-			if (transid > fs_info->last_trans_committed)
+			if (transid > btrfs_get_last_trans_committed(fs_info))
 				ret = -EINVAL;
 			goto out;
 		}
@@ -2587,7 +2587,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (test_bit(BTRFS_TRANS_HAVE_FREE_BGS, &cur_trans->flags))
 		btrfs_clear_space_info_full(fs_info);
 
-	fs_info->last_trans_committed = cur_trans->transid;
+	btrfs_set_last_trans_committed(fs_info, cur_trans->transid);
 	/*
 	 * We needn't acquire the lock here because there is no other task
 	 * which can change it.
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index 1f2c389b0bfa..a416cbea75d1 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -2051,7 +2051,7 @@ int btrfs_verify_level_key(struct extent_buffer *eb, int level,
 	 * So we only checks tree blocks which is read from disk, whose
 	 * generation <= fs_info->last_trans_committed.
 	 */
-	if (btrfs_header_generation(eb) > fs_info->last_trans_committed)
+	if (btrfs_header_generation(eb) > btrfs_get_last_trans_committed(fs_info))
 		return 0;
 
 	/* We have @first_key, so this @eb must have at least one item */
-- 
2.40.1

