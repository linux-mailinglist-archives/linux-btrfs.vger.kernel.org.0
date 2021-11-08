Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F62449812
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Nov 2021 16:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbhKHPYX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Nov 2021 10:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhKHPYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Nov 2021 10:24:22 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB98C061570
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Nov 2021 07:21:38 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id n15so15732251qkp.12
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Nov 2021 07:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ztOl1L1lcAKw0qKwUIYFlAEk842g3gey0/OZh47KCn4=;
        b=ehyGdQzM1bO+X+g6R0OMn1ETV9Po03FJtjyH1cfh4/bXl+wXs7YolP3JSLPJYRzuzR
         eEbp13QXrkBSJP5PZQL463nJt/PVtUqS1KG2m896+dJjZ6U4V+hyYYI70abwJQJRO4Yh
         mSVY9a5vxHPm4QJ6VFJ5s+lIjG5SLoUDx3uYtnvQP/PpMw75FufVtz3hvwCBC54hpLp/
         xMPnqYmLv4KfdPUn2fAcid0DdyrGIrrQyjoF64TGnc2X/g69GGIleKgix85VHtKO7iG/
         BQIiLKbzXhYHWCRMkp3GoH1bAlsa+9ZeNFbbS1+nwBEga2oWOM+6jBXTNHGR2eWjnFQ/
         qp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ztOl1L1lcAKw0qKwUIYFlAEk842g3gey0/OZh47KCn4=;
        b=UKoIBDqMbNtVY1rj6OR98SZYaVU5HY+zY2DjkzsU5IS2yiecWBAaVSwBR6J2AlUtEi
         ECzWutLiPKKCnP4kmf2X2a5G2Zon7pz6mP/wGijPvu2MUdyGsSCU7EWIq3PSi2xwb/Ql
         Nuu9e3fal2m346MxffbXEM/O9HY06TY9k0iArmpDJVz0sC6LHAXZKoxyIRmsRZ31YIh9
         HfO5fSRXow+dwiKVv6BfzxvlDzhs+MyyE1hW1NRYSy6DZEtT4ouw473TlYr4c9AC+DB5
         T+lQ5S9Rutg5TQr4XvC1LeoZ6aAqceLuMi4+nCBHbf9D6FZ0Ugba2//Gf8UrSfUH8f6p
         BGuw==
X-Gm-Message-State: AOAM531g0pgj8+7Fb4qAyTJPSNgRT/10zBVCwtSd6hukObuvoka06njl
        8rC5UvNkucogAjGpK8LYsv4QH2neihQLoQ==
X-Google-Smtp-Source: ABdhPJwdHcWM2mN4FS0n/TKwfDBsG5WvWiq4WwgQ3+NVVWjbkJZYC+NrcziaVdBREEmmkB1A8+JqPA==
X-Received: by 2002:a05:620a:13ed:: with SMTP id h13mr273837qkl.165.1636384897332;
        Mon, 08 Nov 2021 07:21:37 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h5sm10551103qko.60.2021.11.08.07.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 07:21:36 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v2 3/4] btrfs: get rid of root->orphan_cleanup_state
Date:   Mon,  8 Nov 2021 10:21:29 -0500
Message-Id: <e109d9c316752d28986266ded203dd4f0f9fba7a.1636384774.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636384774.git.josef@toxicpanda.com>
References: <cover.1636384774.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we don't care about the stage of the orphan_cleanup_state,
simply replace it with a bit on ->state to make sure we don't call the
orphan cleanup every time we wander into this root.

Reviewed-by: Nikolay Borisov <nborisov@suse.com>
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

