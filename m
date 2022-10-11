Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46CEF5FB56F
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Oct 2022 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiJKOyL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Oct 2022 10:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJKOxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Oct 2022 10:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDA29A9E5;
        Tue, 11 Oct 2022 07:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C14B611B1;
        Tue, 11 Oct 2022 14:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BCBC433D7;
        Tue, 11 Oct 2022 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665499870;
        bh=TQ1Dc96/cVm2pB1sol884Sqey428Yj6pK/JcwcJ4Rlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pVEc0sGAXMqcywnX6H2ewfsGkImUYI2fVjkqBYRsMrqFI910kRCd72OchCaa4HTSO
         2eYfFgYEHwKXy42vp6px58TnRTkZqfM3VMbvgEEjzS1sQpm8FCSBsibKyMUAFfS65z
         bYFqPHW9bPeVojYeC4TYDFfZ4DzYRkiMs4DmcKJMjRXjGfAbM5ZyRqicqfHt5XlNa5
         TSEfedadX57a3VwoZtGuTf49xxGFGQ3koG3t7I5FLK+iyt6w7HWvuh/y0opnqi3V4Y
         HYQrmCBAkLSGItz1t4+VMbdgCnhjh0Klv6TTksIji31A/e5IbQLW0UKdYrnGRaC1cX
         s5YhP7fS9VgsA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.0 35/46] btrfs: call __btrfs_remove_free_space_cache_locked on cache load failure
Date:   Tue, 11 Oct 2022 10:50:03 -0400
Message-Id: <20221011145015.1622882-35-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221011145015.1622882-1-sashal@kernel.org>
References: <20221011145015.1622882-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 8a1ae2781dee9fc21ca82db682d37bea4bd074ad ]

Now that lockdep is staying enabled through our entire CI runs I started
seeing the following stack in generic/475

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2171864 at fs/btrfs/discard.c:604 btrfs_discard_update_discardable+0x98/0xb0
CPU: 1 PID: 2171864 Comm: kworker/u4:0 Not tainted 5.19.0-rc8+ #789
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Workqueue: btrfs-cache btrfs_work_helper
RIP: 0010:btrfs_discard_update_discardable+0x98/0xb0
RSP: 0018:ffffb857c2f7bad0 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff8c85c605c200 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff86807c5b RDI: ffffffff868a831e
RBP: ffff8c85c4c54000 R08: 0000000000000000 R09: 0000000000000000
R10: ffff8c85c66932f0 R11: 0000000000000001 R12: ffff8c85c3899010
R13: ffff8c85d5be4f40 R14: ffff8c85c4c54000 R15: ffff8c86114bfa80
FS:  0000000000000000(0000) GS:ffff8c863bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2e7f168160 CR3: 000000010289a004 CR4: 0000000000370ee0
Call Trace:

 __btrfs_remove_free_space_cache+0x27/0x30
 load_free_space_cache+0xad2/0xaf0
 caching_thread+0x40b/0x650
 ? lock_release+0x137/0x2d0
 btrfs_work_helper+0xf2/0x3e0
 ? lock_is_held_type+0xe2/0x140
 process_one_work+0x271/0x590
 ? process_one_work+0x590/0x590
 worker_thread+0x52/0x3b0
 ? process_one_work+0x590/0x590
 kthread+0xf0/0x120
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30

This is the code

        ctl = block_group->free_space_ctl;
        discard_ctl = &block_group->fs_info->discard_ctl;

        lockdep_assert_held(&ctl->tree_lock);

We have a temporary free space ctl for loading the free space cache in
order to avoid having allocations happening while we're loading the
cache.  When we hit an error we free it all up, however this also calls
btrfs_discard_update_discardable, which requires
block_group->free_space_ctl->tree_lock to be held.  However this is our
temporary ctl so this lock isn't held.  Fix this by calling
__btrfs_remove_free_space_cache_locked instead so that we only clean up
the entries and do not mess with the discardable stats.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/free-space-cache.c | 53 +++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 835071fa39a9..2f88053cfc5e 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -48,6 +48,25 @@ static void bitmap_clear_bits(struct btrfs_free_space_ctl *ctl,
 			      struct btrfs_free_space *info, u64 offset,
 			      u64 bytes, bool update_stats);
 
+static void __btrfs_remove_free_space_cache_locked(
+				struct btrfs_free_space_ctl *ctl)
+{
+	struct btrfs_free_space *info;
+	struct rb_node *node;
+
+	while ((node = rb_last(&ctl->free_space_offset)) != NULL) {
+		info = rb_entry(node, struct btrfs_free_space, offset_index);
+		if (!info->bitmap) {
+			unlink_free_space(ctl, info, true);
+			kmem_cache_free(btrfs_free_space_cachep, info);
+		} else {
+			free_bitmap(ctl, info);
+		}
+
+		cond_resched_lock(&ctl->tree_lock);
+	}
+}
+
 static struct inode *__lookup_free_space_inode(struct btrfs_root *root,
 					       struct btrfs_path *path,
 					       u64 offset)
@@ -881,7 +900,14 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
 	return ret;
 free_cache:
 	io_ctl_drop_pages(&io_ctl);
-	__btrfs_remove_free_space_cache(ctl);
+
+	/*
+	 * We need to call the _locked variant so we don't try to update the
+	 * discard counters.
+	 */
+	spin_lock(&ctl->tree_lock);
+	__btrfs_remove_free_space_cache_locked(ctl);
+	spin_unlock(&ctl->tree_lock);
 	goto out;
 }
 
@@ -1017,7 +1043,13 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 		if (ret == 0)
 			ret = 1;
 	} else {
+		/*
+		 * We need to call the _locked variant so we don't try to update
+		 * the discard counters.
+		 */
+		spin_lock(&tmp_ctl.tree_lock);
 		__btrfs_remove_free_space_cache(&tmp_ctl);
+		spin_unlock(&tmp_ctl.tree_lock);
 		btrfs_warn(fs_info,
 			   "block group %llu has wrong amount of free space",
 			   block_group->start);
@@ -2980,25 +3012,6 @@ static void __btrfs_return_cluster_to_free_space(
 	btrfs_put_block_group(block_group);
 }
 
-static void __btrfs_remove_free_space_cache_locked(
-				struct btrfs_free_space_ctl *ctl)
-{
-	struct btrfs_free_space *info;
-	struct rb_node *node;
-
-	while ((node = rb_last(&ctl->free_space_offset)) != NULL) {
-		info = rb_entry(node, struct btrfs_free_space, offset_index);
-		if (!info->bitmap) {
-			unlink_free_space(ctl, info, true);
-			kmem_cache_free(btrfs_free_space_cachep, info);
-		} else {
-			free_bitmap(ctl, info);
-		}
-
-		cond_resched_lock(&ctl->tree_lock);
-	}
-}
-
 void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl)
 {
 	spin_lock(&ctl->tree_lock);
-- 
2.35.1

