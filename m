Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC8758CEE8
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Aug 2022 22:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbiHHUKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Aug 2022 16:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244088AbiHHUKe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Aug 2022 16:10:34 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75212E1C
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Aug 2022 13:10:33 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id y11so7168636qvn.3
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Aug 2022 13:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1a/PTqmQnrbO2Qwrjvlx/7P+OEnBwxH8oZcG0PeC+Tg=;
        b=bQk9FnGiTRY/0lX4+v112/65Wq1m1sj325NLmK6kMzz8zJKwQ8EgvNYu576l7X8jRK
         NvAgCLJ7C80VQ498sc4I+dnbcZPozOyTEZ/xLeVGi1ujJ318OXr3Bh/+6Dfx9e+vsiAf
         ok0kokWb6gsXXmSjBYMUVfYkdYFPxfKfXllAbjc+Ka554BOx2UWQY3k/55AuPmSj11VZ
         phSoueGR5i+RV7+KeZ5LKyWLofnZRYrj4TF8trpubn3ExWEm4r/oj9njFzwrjDo4yikf
         Fm8O8TevgIodXbw5cueAIEPXz0B99kLoYbp1biFROVYCay4f93OI93UrKzb6XHuTJHK4
         KyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1a/PTqmQnrbO2Qwrjvlx/7P+OEnBwxH8oZcG0PeC+Tg=;
        b=PsywLPbELJmUQtvOM2WtT8qjVZ452TXHSqAeBPeOA73cXCjlOEx7F5e4AV7tIHgtnC
         CmkZHLPm19pj7n+BsDOjJx0qBNqfwKdat7Fp8TCPpzqnI9YaqrUMciARBdNktRDIHg79
         Ohqe5ybqSKLDtH+Rh0/trDlZJas7OA9dOUqPwaNZ85CRNnYgOXRA5S8MiqtHLDkSE0UB
         lnzGzY05l7kj4tRj+QBNT8LamEXluOpWNVmSUHkSHIQ0qFEGcBn6WfT+UfzZyghiZnYU
         nC+zPGZS7+lzH8J54qirYENMX/dL3q2Hhr0YnHxxOVnqFYSH8+qbxhWxNEyr1rapNDqG
         NXnQ==
X-Gm-Message-State: ACgBeo2gQ5saT2/i7KF8+kFFIEy5HcaO/CmS5QTBTEnYE+GSC2ypudYC
        pjM65cMh4/bwSBZyiitFQqqb9L6GajJiVA==
X-Google-Smtp-Source: AA6agR7QaCMCq5OlCQEijGrIqKcEomJc+xQbhu41HU7rXOntmypIxYIN1jZTEkTJrxNYOgYjD6kFwQ==
X-Received: by 2002:ad4:5aec:0:b0:474:79af:12bb with SMTP id c12-20020ad45aec000000b0047479af12bbmr17380618qvh.45.1659989432211;
        Mon, 08 Aug 2022 13:10:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j26-20020ac8551a000000b00342f917444csm2652892qtq.85.2022.08.08.13.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 13:10:30 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/2] btrfs: call __btrfs_remove_free_space_cache_locked on cache load failure
Date:   Mon,  8 Aug 2022 16:10:26 -0400
Message-Id: <e1cde76ba6cf7b14d6f38310113588d6486d5a00.1659989333.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1659989333.git.josef@toxicpanda.com>
References: <cover.1659989333.git.josef@toxicpanda.com>
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
---
 fs/btrfs/free-space-cache.c | 55 +++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 81d9fe33672f..ca9b190f3b80 100644
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
@@ -878,7 +897,14 @@ static int __load_free_space_cache(struct btrfs_root *root, struct inode *inode,
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
 
@@ -1014,7 +1040,13 @@ int load_free_space_cache(struct btrfs_block_group *block_group)
 		if (ret == 0)
 			ret = 1;
 	} else {
-		__btrfs_remove_free_space_cache(&tmp_ctl);
+		/*
+		 * We need to call the _locked variant so we don't try to update
+		 * the discard counters.
+		 */
+		spin_lock(&ctl->tree_lock);
+		__btrfs_remove_free_space_cache_locked(&tmp_ctl);
+		spin_unlock(&ctl->tree_lock);
 		btrfs_warn(fs_info,
 			   "block group %llu has wrong amount of free space",
 			   block_group->start);
@@ -2978,25 +3010,6 @@ static void __btrfs_return_cluster_to_free_space(
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
2.26.3

