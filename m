Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36C243E91B
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 21:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhJ1TxK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 15:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhJ1TxK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 15:53:10 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8E3C061570
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 12:50:42 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id h20so6991210qko.13
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 12:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ndL0FrkcmSohBD4Z8A6Hb/tzMy3cy2oh3oHuqtdZplg=;
        b=afgUbPsBJoVcHcAnnLdOSSeMksAlsnuLer4RyL2l+as5NwEM1bcoFYP5R/cCfsy/+q
         JY6dSnTYKLTPmKri+/0sx+TygQ/INmZHD6UtNYeZIlVyIMxr9Pue6U3qVrQjEnqK3JkC
         I5ZpDTnC+kv56eSLDpLCXK+6RVOIl4EhVa8Rz/Ryi4+aazPbiebo2Ol4cvxMbEvGVui5
         cNegia+1rp2wZrNe0u+rafzyau7THGecesrjTyIcEJCKkI/tkNkjB7Exiaa6kl4duAKE
         53p5tKxh+Jg0HTYKp8mQ5UMoIf9/lnc2pZyY0ZgoCdZ7dacoJ0Z+NNDrVN9+3EIgoy+w
         ebiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ndL0FrkcmSohBD4Z8A6Hb/tzMy3cy2oh3oHuqtdZplg=;
        b=zSgc1ytofDNHCEc8ObHsv37Aodnpswd51lTr0dnBy/I7vKY0CFqwAzGVuyCrikZiB/
         PvAcGm+NPLSEEaCMMinAXMXkdsMmn5rLWxCD/opZgj2wPuyeONe845witujOkk9QnJyj
         BFNMXz029G5AVrDYGGwH7P2QTUTyooN0AqxtYSuExVo0bKohW1Ffj65WE6hAmTa+65Oc
         lX+1cX4kl+moj7MQDjGmnEEDBqZ5mahCK3xumoIx0viPFEVZ7r6CQ2C9zNFt6Wo6RZc4
         iJvoHzI0DEP7WroJ1RnXAxSSy38n37WJshUF1Jx/kRz5y9RcKl42tt4UY7IYtOGK1Icu
         Hcbg==
X-Gm-Message-State: AOAM530Fl3koYrv7oAREcqxl7MWMdNZnOv2rIycw/glq9d3kgKPGWpgv
        jPnilTA1w9bhDCF/YiyxU/gOl1e2O8S4YQ==
X-Google-Smtp-Source: ABdhPJxADRHwyF1EAwRmvyOh365aBW9nYwMUupmLRG8kUtlcYxl7Agqhy4Xqj12b8OkwuTOPYHNBSg==
X-Received: by 2002:a05:620a:bce:: with SMTP id s14mr5305178qki.482.1635450641557;
        Thu, 28 Oct 2021 12:50:41 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b3sm2429989qkj.76.2021.10.28.12.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 12:50:41 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 3/4] btrfs: get rid of root->orphan_cleanup_state
Date:   Thu, 28 Oct 2021 15:50:35 -0400
Message-Id: <dc82d55bbdf6448b612c49856c5499b5add1bbc5.1635450288.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1635450288.git.josef@toxicpanda.com>
References: <cover.1635450288.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we don't care about the stage of the orphan_cleanup_state,
simply replace it with a bit on ->state to make sure we don't call the
orphan cleanup every time we wander into this root.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/ctree.h   | 9 ++-------
 fs/btrfs/disk-io.c | 1 -
 fs/btrfs/inode.c   | 4 +---
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 7553e9dc5f93..01f6a40ba2dd 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -511,11 +511,6 @@ struct btrfs_discard_ctl {
 	atomic64_t discard_bytes_saved;
 };
 
-enum btrfs_orphan_cleanup_state {
-	ORPHAN_CLEANUP_STARTED	= 1,
-	ORPHAN_CLEANUP_DONE	= 2,
-};
-
 void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
 
 /* fs_info */
@@ -1110,6 +1105,8 @@ enum {
 	BTRFS_ROOT_HAS_LOG_TREE,
 	/* Qgroup flushing is in progress */
 	BTRFS_ROOT_QGROUP_FLUSHING,
+	/* We started the orphan cleanup for this root. */
+	BTRFS_ROOT_ORPHAN_CLEANUP,
 };
 
 /*
@@ -1178,8 +1175,6 @@ struct btrfs_root {
 	spinlock_t log_extents_lock[2];
 	struct list_head logged_list[2];
 
-	int orphan_cleanup_state;
-
 	spinlock_t inode_lock;
 	/* red-black tree that keeps track of in-memory inodes */
 	struct rb_root inode_tree;
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index c7254331cf38..5be0ae67ceb7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1144,7 +1144,6 @@ static void __setup_root(struct btrfs_root *root, struct btrfs_fs_info *fs_info,
 	root->node = NULL;
 	root->commit_root = NULL;
 	root->state = 0;
-	root->orphan_cleanup_state = 0;
 
 	root->last_trans = 0;
 	root->free_objectid = 0;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index c783a3e434b9..a9ebafb168b5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3475,7 +3475,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 	u64 last_objectid = 0;
 	int ret = 0, nr_unlink = 0;
 
-	if (cmpxchg(&root->orphan_cleanup_state, 0, ORPHAN_CLEANUP_STARTED))
+	if (test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP, &root->state))
 		return 0;
 
 	path = btrfs_alloc_path();
@@ -3633,8 +3633,6 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 	/* release the path since we're done with it */
 	btrfs_release_path(path);
 
-	root->orphan_cleanup_state = ORPHAN_CLEANUP_DONE;
-
 	if (test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state)) {
 		trans = btrfs_join_transaction(root);
 		if (!IS_ERR(trans))
-- 
2.26.3

