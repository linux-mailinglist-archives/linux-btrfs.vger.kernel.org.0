Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFC844B021
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Nov 2021 16:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbhKIPPG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 10:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbhKIPPF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 9 Nov 2021 10:15:05 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E255C061764
        for <linux-btrfs@vger.kernel.org>; Tue,  9 Nov 2021 07:12:19 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a24so14407947qvb.5
        for <linux-btrfs@vger.kernel.org>; Tue, 09 Nov 2021 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHbmNfnIHC0a7f8+ItbN6burv6W+Ml56asfYKkbP/gw=;
        b=Y/wzvXqBUiTCjdQ7teSY3/qCmxfQMtb5p4E2GMjjJK1Odh8m09NIdvmRvkZ6mKswCG
         ld95yQul626s8l34fkarKqt/1Bh7Q1wAhzaYm0FxafjjB1pmrZFntN1QWxfLrvhYKWV7
         2HULUEmH6hWmN6Db2dCb3yzCda8sqdUTjEs5r43Z9TxuMmYTZsiEP2EXI35MAD1QBx5l
         PQXTY+JTKWatJjThSZiIeX6EL8LjztC1KVPpv85bfKjGtDAPBSSWTE3wXY2QDwBzV/19
         YDwhyIr4PbJzA9s64ch58sb4F6/pZbQZUPdQFtbi/h690vqqB4l6dhZuZrsD9c9Cs8z1
         3ayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHbmNfnIHC0a7f8+ItbN6burv6W+Ml56asfYKkbP/gw=;
        b=zGQHmdQaw9svgg8m54Clx+ZS4GI45XPfdUbU5WxXJh3G2FWub50QAdHruqh7gb6EHz
         Z6Ughp8ROldAGlSjaDThW96P7J1+zYAu1MKXlGRwg4/PJi+0vpQPb3yD208OrWvDbJHr
         JM4xMAWtkSIkGyBUrtvG4ubBzUloIfIp8GL81fvo8xOSEO/VZmhRA1+W0Qw+hk3y9AZM
         acBgRiBEHAzxZjr2OUioHf3ImNo4hxvd7ZP8wZgAoSHdrum2O92JP2AWsUMUBdPBG5iD
         h66LvTYMGoERRJlLKcRJ15f7PFVD0p36ryDJPPt+0pQdG2aPY77iZYPDCa0ZMQ0KRd2Q
         Dx5Q==
X-Gm-Message-State: AOAM532SPuELvnixGNdHn5ZTqS/LQJUUaWzsSbzT96kGNSM+NbmKee+x
        jCGSIvq3aM054n0rd6fpZlk/zFrXtgngog==
X-Google-Smtp-Source: ABdhPJy6/tVjNyGA9unqu1tGnmwgdwpZXsplRr3eMNDlCulkPb52cMrJDbiVXuHkeoz1V0uBcR0p+A==
X-Received: by 2002:a05:6214:3004:: with SMTP id ke4mr8116295qvb.48.1636470738101;
        Tue, 09 Nov 2021 07:12:18 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id bi41sm11791219qkb.127.2021.11.09.07.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 07:12:17 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 6/7] btrfs: get rid of root->orphan_cleanup_state
Date:   Tue,  9 Nov 2021 10:12:06 -0500
Message-Id: <c1fe8f8755e3e20585650f7d0b49d2c236c387d4.1636470628.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1636470628.git.josef@toxicpanda.com>
References: <cover.1636470628.git.josef@toxicpanda.com>
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
index 5e29f3fc527d..f1dd2486dcb3 100644
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
index 847aabb30676..2fbf29b36926 100644
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
index 67c7107a79a5..ac0b55ca3e78 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3473,7 +3473,7 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 	u64 last_objectid = 0;
 	int ret = 0, nr_unlink = 0;
 
-	if (cmpxchg(&root->orphan_cleanup_state, 0, ORPHAN_CLEANUP_STARTED))
+	if (test_and_set_bit(BTRFS_ROOT_ORPHAN_CLEANUP, &root->state))
 		return 0;
 
 	path = btrfs_alloc_path();
@@ -3631,8 +3631,6 @@ int btrfs_orphan_cleanup(struct btrfs_root *root)
 	/* release the path since we're done with it */
 	btrfs_release_path(path);
 
-	root->orphan_cleanup_state = ORPHAN_CLEANUP_DONE;
-
 	if (test_bit(BTRFS_ROOT_ORPHAN_ITEM_INSERTED, &root->state)) {
 		trans = btrfs_join_transaction(root);
 		if (!IS_ERR(trans))
-- 
2.26.3

