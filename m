Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365AF604A23
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Oct 2022 16:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJSO6U (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Oct 2022 10:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiJSO5k (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Oct 2022 10:57:40 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2EBE733F3
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:17 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id hh9so11781419qtb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Oct 2022 07:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wL/x9FbReLlMgY+J+Pzc5NYJWZaHAKHXdkey1oXXW8=;
        b=1BA8YXx2bKP8r336uCBImcd8/4h4qhgPRKe2RvyFu/D7bFQisD4xaCiWp5K/h4/nB/
         ehqcnjw2wrHqpE5Wofph8ZZ6cLgb1SyRsIRhgqcrqM/tNDo4lVEfbTx6Fj/28MZ0xbtt
         veBXvMFZPf4+6XwlipxeqKFRFtGW/LHFTn+10Hbv0svRMM1JGyW6ejRJ/2JR4xjjMrKj
         6RFGmBBq6fcsW/HiE6ofambfP4alBUxdxR9poKEep+D0JoSuclYyXCTAqrZmD94XOEal
         dVGToqnW8n14zlzbp3FW55tVEnN2KhBr5zhbwX9m2DrlP+fUF2e7lHqj4kUvGCpvMLAc
         MWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wL/x9FbReLlMgY+J+Pzc5NYJWZaHAKHXdkey1oXXW8=;
        b=LSMJc3S6gKi4vxvd6ucfPeKXwySHlJObpcHyS9H029Xdkv6OT8+Mg+5VIZXicBQcSJ
         JU1p7anVRqQysPAfHYAUD54rbBjupz8tak/cxu1ZcpzsRljLk1tzyIjvt9SDeShbHoNN
         DqX72cU9pbyRegRwmE0fOxLtUtIdyDrQfMFjEFKZW6p8AiTVMg1PMg1Xhkp6BsxNn5AQ
         J1FGzqv57U4g7CDsD/geWCk6Qm4slRJUKH7KyHvHHlUQIvbC10AIRe86VcOwcpecSerB
         xpHTxql6qPTK2xOXObA8sUcDjlLn+zcMCUKyitlFiFAvUxBAW5FEvVbIKar5HxyaR0Lo
         5BSA==
X-Gm-Message-State: ACrzQf2BrdX2bVTK4eA2bmqsZOExyUNE/k7S/hQIeU4j/qzq5m2vGzvR
        HS2eR0jIiYFPg6bxjbJvxJpNbQYHnQZYlg==
X-Google-Smtp-Source: AMsMyM7Rl9KmMSY8UEkCDVbjYUGfVeigUOdgfSL6mNiZ2ASQ7dfEm2HIii1nq79sXYvUhZFAp6VtJQ==
X-Received: by 2002:ac8:578b:0:b0:39c:f006:3563 with SMTP id v11-20020ac8578b000000b0039cf0063563mr6602999qta.636.1666191076729;
        Wed, 19 Oct 2022 07:51:16 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id l12-20020a37f90c000000b006cbc6e1478csm5035291qkj.57.2022.10.19.07.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 07:51:16 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 10/15] btrfs: remove fs_info::pending_changes and related code
Date:   Wed, 19 Oct 2022 10:50:56 -0400
Message-Id: <dd2d57bb9c440c765be0b7f34622351283edefdc.1666190849.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1666190849.git.josef@toxicpanda.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
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

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

