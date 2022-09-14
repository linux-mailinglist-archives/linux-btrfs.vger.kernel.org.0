Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF15B8E14
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Sep 2022 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiINRSx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Sep 2022 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiINRSm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Sep 2022 13:18:42 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8AD8286D
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:41 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id d17so10616466qko.13
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Sep 2022 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=MARa4EToxKQa2zCvYsWTp24r1ajNvIFzXN+686FAKgI=;
        b=L6lq9pSEbiVFs3HEKsY2WkrnofpazNuhPRIss/uR/Sp16xP0lQqxSWYW6qQsszMiBS
         7MJ0RhTSwHt7yQAMyFz9TjraktVC4S70E4fPMAJC2EG/EnYTnhcKoAegfMxyD2a2wwPy
         t/m/40cpXzfufTBn9Xrn1FKeJa9dI+cOLW9Oh50Ame4JZDkHPeAc2/GdEUhwCwQJPYJ3
         pow6G+mtly5N+tpQYWd1Bsvc3r7VR0FjR07t69bwmj4WNM+yKWSLFeLwWNNANlmrQqCw
         KdEGJ8RPNCyakn5Su3waJXkPWTI6+pDxmOviLvqtZC2PxP5YTfiPejdMZ2fIy41pbrvB
         OJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MARa4EToxKQa2zCvYsWTp24r1ajNvIFzXN+686FAKgI=;
        b=PkvRukBn2xTQUuR8KquR37L2OmDaXREiliwqlZ/X0VdH0BZF04RzXOobDBcHP4+2Lh
         remX9Pnpkp4vYFcSwAeo05vW2AxIJEcMvEJj2GUfsVS2hnzk4SEXCROXIkspD8DfroJt
         LlBw2c0/ZwmJPSfyTk3Y7rmZNQzexR/gGq59qkhdwEgkejikNfNZAXP/bd5o08kIY0Xs
         ed3SVjymAh65uFEYLp3A5Vq9HqFkZ/oQO0e6iKVlBbiLlo+9LBO6iqJdMbciab6TI5OA
         mkKqM7xSf00AKdAEhWhMwP71OD7LSjJEUCbc9PqKNTrZz3ozb29QIDduN7zSx0AOPRv0
         FuFw==
X-Gm-Message-State: ACgBeo3VVkfAa6XlK3MigOg7vbtki6AEbGQ7pZwwcuHtOs6nwj5LODYr
        ks8kky/F0KQhd8kZP6lMuQZ6HkRJGoJlPA==
X-Google-Smtp-Source: AA6agR6K/txIzun7piY80+piENY39U3jGoClZY19yFFC/fU6Ed77qIY5YLUBv6FVEzFBUXE3oUiMrA==
X-Received: by 2002:a05:620a:13d8:b0:6cd:ef36:4034 with SMTP id g24-20020a05620a13d800b006cdef364034mr17287262qkl.561.1663175919872;
        Wed, 14 Sep 2022 10:18:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i6-20020a05622a08c600b0034035e73be0sm1924583qte.4.2022.09.14.10.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 10:18:39 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 12/16] btrfs: remove fs_info::pending_changes and related code
Date:   Wed, 14 Sep 2022 13:18:17 -0400
Message-Id: <8bffbf3b43fb56ce03776e779f4d166e42d9b297.1663175597.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1663175597.git.josef@toxicpanda.com>
References: <cover.1663175597.git.josef@toxicpanda.com>
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
index 8decad27a6c5..f44c744fe7a2 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -410,11 +410,7 @@ struct btrfs_fs_info {
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
@@ -1235,23 +1231,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
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
index f103bf712f75..719c00757579 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3702,12 +3702,6 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
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

