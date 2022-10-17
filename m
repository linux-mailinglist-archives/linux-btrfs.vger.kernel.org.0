Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770F16016FD
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJQTJm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 15:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiJQTJd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 15:09:33 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8A1039
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:31 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h24so8010583qta.7
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 12:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kFg3IEtSsbbDTbO3WrKOnRK+RVYw74w3q6bVwfDBQU=;
        b=ODdIQMknKZLYNRoO7GtrfjF8uK4/pMQfrsa1oEdVH69R2is0D/Yc2DoGXcpdSQEvdk
         XpJU1Orxedehee+v/fOYeOLgLLMLpSbQkY/jQac4PfAxAwGwZD2Yx3clOb6+dMtu5kLW
         xHdPILD6hlL4gEoHtqyw56byengZS6MzquD0J34Jax+bOqcFEZlcFALmkzO4K1WMf+02
         wq+pbI1JxG2BJ2mcQng+MbMHpNkqDliFL+IyBAgcqZlGv6Uzi8/sn/EYu2bZuyIbwjmj
         a/DWRDrWz+JPK53Y5BxX36WKVdkWE4UO1UD8O5BqLqsqlH+z2SZtokcu4YnFMbNyfWXa
         4b4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kFg3IEtSsbbDTbO3WrKOnRK+RVYw74w3q6bVwfDBQU=;
        b=nDrJFa8sh6aDYzDzaKnNDzvTJFZES3DXmHyqgAg9FmKtf/FxQwcp5MYbSAsga4xVQe
         fpDfLdvQVyjEa4OHAuNWVtpbeMiPXr6VCrYERDj0cuLQN+jymabp1J65gZKYBdNnJ+Am
         AdPcicuT9wwQGdlqmL7MaLBkqb4hwpnQRhb/oCQ+En3Kkkxm4H3OJTHx2mSxeeulxV2R
         qkE3Qf6li6WoQKH/GnEi8/yY0q2MvWQQ+Luybk+k3tsYQYzTNfD8uMJkD4mh2UUOZv4+
         KAeltOJoaSQ8g4ZQf5YF2+CTTK+kGybomQpkb911RsfMqtHnYgbthsDGvEspOGgGPAOT
         knXQ==
X-Gm-Message-State: ACrzQf3rGt7Z9CL5kgh877l5cNHk67wAji7gP0EeSYKasRUzsv5Jbirv
        ixnesOva2D8aQMuVBOECOl2bw/fBO5grgA==
X-Google-Smtp-Source: AMsMyM6+rUyinQs2rMBfAuq9Z90rvMLr154yoao9qchNjCsCXfABc/9MxcJ2sxb4x9beKPgoam9wfw==
X-Received: by 2002:ac8:5d49:0:b0:39a:4f7:e0b2 with SMTP id g9-20020ac85d49000000b0039a04f7e0b2mr9959763qtx.119.1666033770492;
        Mon, 17 Oct 2022 12:09:30 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a29ca00b006e07228ed53sm503072qkp.18.2022.10.17.12.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:09:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 11/16] btrfs: remove fs_info::pending_changes and related code
Date:   Mon, 17 Oct 2022 15:09:08 -0400
Message-Id: <41eb60b3f7bce92765f71dd1e1658bc3ee9babcc.1666033501.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666033501.git.josef@toxicpanda.com>
References: <cover.1666033501.git.josef@toxicpanda.com>
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

Now that we're not using this code anywhere we can remove it as well as
the member from fs_info.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h       | 23 +----------------------
 fs/btrfs/disk-io.c     |  6 ------
 fs/btrfs/transaction.c | 25 -------------------------
 fs/btrfs/transaction.h |  1 -
 4 files changed, 1 insertion(+), 54 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 99c51bc29b8a..988a4c176288 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -365,11 +365,7 @@ struct btrfs_fs_info {
 	 */
 	u64 last_trans_log_full_commit;
 	unsigned long mount_opt;
-	/*
-	 * Track requests for actions that need to be done during transaction
-	 * commit (like for some mount options).
-	 */
-	unsigned long pending_changes;
+
 	unsigned long compress_type:4;
 	unsigned int compress_level;
 	u32 commit_interval;
@@ -1252,23 +1248,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-/*
- * Requests for changes that need to be done during transaction commit.
- *
- * Internal mount options that are used for special handling of the real
- * mount options (eg. cannot be set during remount and have to be set during
- * transaction commit)
- */
-
-#define BTRFS_PENDING_COMMIT			(0)
-
-#define btrfs_test_pending(info, opt)	\
-	test_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
-#define btrfs_set_pending(info, opt)	\
-	set_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
-#define btrfs_clear_pending(info, opt)	\
-	clear_bit(BTRFS_PENDING_##opt, &(info)->pending_changes)
-
 struct btrfs_map_token {
 	struct extent_buffer *eb;
 	char *kaddr;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index fb437d1246e0..e22ce4cbc59c 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3750,12 +3750,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		btrfs_set_and_info(fs_info, SSD, "enabling ssd optimizations");
 	}
 
-	/*
-	 * Mount does not set all options immediately, we can do it now and do
-	 * not have to wait for transaction commit
-	 */
-	btrfs_apply_pending_changes(fs_info);
-
 #ifdef CONFIG_BTRFS_FS_CHECK_INTEGRITY
 	if (btrfs_test_opt(fs_info, CHECK_INTEGRITY)) {
 		ret = btrfsic_mount(fs_info, fs_devices,
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index 7b6b68ab089a..37d0baaa41d8 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -2359,12 +2359,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	if (ret)
 		goto unlock_reloc;
 
-	/*
-	 * Since the transaction is done, we can apply the pending changes
-	 * before the next transaction.
-	 */
-	btrfs_apply_pending_changes(fs_info);
-
 	/* commit_fs_roots gets rid of all the tree log roots, it is now
 	 * safe to free the root of tree log roots
 	 */
@@ -2587,25 +2581,6 @@ int btrfs_clean_one_deleted_snapshot(struct btrfs_fs_info *fs_info)
 	return (ret < 0) ? 0 : 1;
 }
 
-void btrfs_apply_pending_changes(struct btrfs_fs_info *fs_info)
-{
-	unsigned long prev;
-	unsigned long bit;
-
-	prev = xchg(&fs_info->pending_changes, 0);
-	if (!prev)
-		return;
-
-	bit = 1 << BTRFS_PENDING_COMMIT;
-	if (prev & bit)
-		btrfs_debug(fs_info, "pending commit done");
-	prev &= ~bit;
-
-	if (prev)
-		btrfs_warn(fs_info,
-			"unknown pending changes left 0x%lx, ignoring", prev);
-}
-
 int __init btrfs_transaction_init(void)
 {
 	btrfs_trans_handle_cachep = kmem_cache_create("btrfs_trans_handle",
diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
index b5651c372946..cf3356cb797b 100644
--- a/fs/btrfs/transaction.h
+++ b/fs/btrfs/transaction.h
@@ -231,7 +231,6 @@ int btrfs_wait_tree_log_extents(struct btrfs_root *root, int mark);
 int btrfs_transaction_blocked(struct btrfs_fs_info *info);
 int btrfs_transaction_in_commit(struct btrfs_fs_info *info);
 void btrfs_put_transaction(struct btrfs_transaction *transaction);
-void btrfs_apply_pending_changes(struct btrfs_fs_info *fs_info);
 void btrfs_add_dropped_root(struct btrfs_trans_handle *trans,
 			    struct btrfs_root *root);
 void btrfs_trans_release_chunk_metadata(struct btrfs_trans_handle *trans);
-- 
2.26.3

