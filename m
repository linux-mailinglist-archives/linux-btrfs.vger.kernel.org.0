Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD287465339
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Dec 2021 17:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351517AbhLAQsy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Dec 2021 11:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351509AbhLAQsj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Dec 2021 11:48:39 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D25C06175E
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Dec 2021 08:45:13 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 132so31589573qkj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Dec 2021 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=43fiRHrr3XJgo8yF/6W+LY4pGEjEfDHb4fNYgG+2nrs=;
        b=z970msienhsYV2rg8aTQb5O253hLnaumsYUaxeC0efnm1BARUiWc4N74VBNwAWshd4
         JOQL+Id42cvDglYk6fItyjXwEKVo4Cut11JNCtKElQXMm3XQIwfqHqOnJS+A8wOKkTr9
         2AlwsC5P4uIM7/yTJ2KEB8Xwyg45O248j5DHxh8D+N+m7ohDKZycs8FXQPx+PggqXABM
         GGMQgiFipEE520Sc7rD83GBDl0d7R4WZvN7zoZJdaUrTtVrUHnUV1aah6oEliWD1Y4p6
         EHQCNYikteHJMTpwX+fyvOVEXM9IckRwlOfZSERmR1A9j//2uH6uAS3qbvqp4MIQpUHe
         qFfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=43fiRHrr3XJgo8yF/6W+LY4pGEjEfDHb4fNYgG+2nrs=;
        b=rNpCWgrRMDI4oOWbhxAP7Y/0+Yz1PlLYntgm8nEpIwj3GSyGZxoxP8PLcSNtK9GAV7
         vkM8OKq68sKPt+wLH2zfd+/+FN0EjmbWPCD6KOljuZh1idDpSeMQo9ZzsVKXZ6HZAtLO
         GgDxwfj7SxT+Kdp0Jfymc5MxpUQs63PiR2OcPeJ6WF4qJX3ZFa3r+oxXd8kQ+8xOZjKn
         o/vteq0I4JTSbwyXExvrheW6r9GY99zG6KvyTvzI8tJJPi9UpGuWinFLaPRpKfNdL7G7
         glgjgf4b80NrvqCzkA4emtCeXU6NE26DJa+dPI58oyjsjU/Ui50mcvXhyTWx2GdxnYMp
         85nA==
X-Gm-Message-State: AOAM533UdeAOgkkKCMcHYmm5IR2yFWHGNFb5gAJgyxt0az/0yF+euxW9
        42KzSQ0YT0kSAc++SpNY6cVsccjtdESvPw==
X-Google-Smtp-Source: ABdhPJzx6s5RH+oGfC+jwDFnvIp8SAH5uaNUX8/XpDusBY3Y9+96FKSBd2Ih840tjXN5OVlhjH/fOA==
X-Received: by 2002:a05:620a:40d1:: with SMTP id g17mr7418482qko.621.1638377112222;
        Wed, 01 Dec 2021 08:45:12 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id f34sm166432qtb.7.2021.12.01.08.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:45:11 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: include the free space tree in the global rsv minimum calculation
Date:   Wed,  1 Dec 2021 11:45:08 -0500
Message-Id: <13d6e38d365639ac7a6b982f465332a78e0a516e.1638377089.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1638377089.git.josef@toxicpanda.com>
References: <cover.1638377089.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Filipe reported a problem where generic/619 was failing with an ENOSPC
abort while running delayed refs, like the following

------------[ cut here ]------------
BTRFS: Transaction aborted (error -28)
WARNING: CPU: 3 PID: 522920 at fs/btrfs/free-space-tree.c:1049 add_to_free_space_tree+0xe5/0x110 [btrfs]
CPU: 3 PID: 522920 Comm: kworker/u16:19 Tainted: G        W         5.16.0-rc2-btrfs-next-106 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
RIP: 0010:add_to_free_space_tree+0xe5/0x110 [btrfs]
RSP: 0000:ffffa65087fb7b20 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000001000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff9131eeaa RDI: 00000000ffffffff
RBP: ffff8d62e26481b8 R08: ffffffff9ad97ce0 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000001 R12: 00000000ffffffe4
R13: ffff8d61c25fe688 R14: ffff8d61ebd88800 R15: ffff8d61ebd88a90
FS:  0000000000000000(0000) GS:ffff8d64ed400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa46a8b1000 CR3: 0000000148d18003 CR4: 0000000000370ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __btrfs_free_extent+0x516/0x950 [btrfs]
 __btrfs_run_delayed_refs+0x2b1/0x1250 [btrfs]
 btrfs_run_delayed_refs+0x86/0x210 [btrfs]
 flush_space+0x403/0x630 [btrfs]
 ? call_rcu_tasks_generic+0x50/0x80
 ? lock_release+0x223/0x4a0
 ? btrfs_get_alloc_profile+0xb5/0x290 [btrfs]
 ? do_raw_spin_unlock+0x4b/0xa0
 btrfs_async_reclaim_metadata_space+0x139/0x320 [btrfs]
 process_one_work+0x24c/0x5b0
 worker_thread+0x55/0x3c0
 ? process_one_work+0x5b0/0x5b0
 kthread+0x17c/0x1a0
 ? set_kthread_struct+0x40/0x40
 ret_from_fork+0x22/0x30

There's a couple of reasons for this, but in generic/619's case the
largest reason is because it is a very small file system, ad we do not
reserve enough space for the global reserve.

With the free space tree we now have the free space tree that we need to
modify when running delayed refs.  This means we need the global reserve
to take this into account when it calculates the minimum size it needs
to be.  This is especially important for very small file systems.

Fix this by adjusting the minimum global block rsv size math to include
the size of the free space tree when calculating the size.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-rsv.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
index 21ac60ec19f6..b3086f252ad0 100644
--- a/fs/btrfs/block-rsv.c
+++ b/fs/btrfs/block-rsv.c
@@ -352,25 +352,29 @@ void btrfs_update_global_block_rsv(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_block_rsv *block_rsv = &fs_info->global_block_rsv;
 	struct btrfs_space_info *sinfo = block_rsv->space_info;
-	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, 0);
-	struct btrfs_root *csum_root = btrfs_csum_root(fs_info, 0);
-	u64 num_bytes;
-	unsigned min_items;
+	struct btrfs_root *root, *tmp;
+	u64 num_bytes = btrfs_root_used(&fs_info->tree_root->root_item);
+	unsigned int min_items = 1;
 
 	/*
 	 * The global block rsv is based on the size of the extent tree, the
 	 * checksum tree and the root tree.  If the fs is empty we want to set
 	 * it to a minimal amount for safety.
+	 *
+	 * We also are going to need to modify the minimum of the tree root and
+	 * any global roots we could touch.
 	 */
-	num_bytes = btrfs_root_used(&extent_root->root_item) +
-		btrfs_root_used(&csum_root->root_item) +
-		btrfs_root_used(&fs_info->tree_root->root_item);
-
-	/*
-	 * We at a minimum are going to modify the csum root, the tree root, and
-	 * the extent root.
-	 */
-	min_items = 3;
+	read_lock(&fs_info->global_root_lock);
+	rbtree_postorder_for_each_entry_safe(root, tmp, &fs_info->global_root_tree,
+					     rb_node) {
+		if (root->root_key.objectid == BTRFS_EXTENT_TREE_OBJECTID ||
+		    root->root_key.objectid == BTRFS_CSUM_TREE_OBJECTID ||
+		    root->root_key.objectid == BTRFS_FREE_SPACE_TREE_OBJECTID) {
+			num_bytes += btrfs_root_used(&root->root_item);
+			min_items++;
+		}
+	}
+	read_unlock(&fs_info->global_root_lock);
 
 	/*
 	 * But we also want to reserve enough space so we can do the fallback
-- 
2.26.3

