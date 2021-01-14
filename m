Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56852F6A6A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jan 2021 20:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbhANTDf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jan 2021 14:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhANTDf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jan 2021 14:03:35 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDC8C0613C1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:55 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id v126so9292414qkd.11
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jan 2021 11:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5lBcsVSQe8zbkNB8rPvqQ0cdziK2TSe40j+jI9StjhI=;
        b=EInvVC6Ob3QpOhXjZjbZ4BILEO3fynckCh9uQqdxc8nFugHnbuwpyzwChMWVAPu09u
         XjtnDEcLcS1HrDsOER6t1fgSCWniwKDX3oWIjZuAySwpZnL9TqHDVJU+phSe+iPEHX8c
         NLMs0MMCQeVlei9hAgY8wlxbKoqQnqRfoOhrlRfrkhnEr9JmStvmVgZ3FfPct0zATnVX
         cxHEnXsuBfng/WSMxNzsCHjWl76Ip+KO+KL6yV6wPKGK6D3B1GldshmqMl70Ebd2dFHv
         mv1B4Ywz/iYZv9+LjR/mXF80W0NQCJOcWlU+cF6qLFmTxh1d1krxY9N48QhKIqZi0H7O
         3bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lBcsVSQe8zbkNB8rPvqQ0cdziK2TSe40j+jI9StjhI=;
        b=crByix80XnBMPtMab8GkWH8RkpeQE51WhFjWeI6Mg1U8J6eSSAqK1a4uAPAzn2oEXq
         H1Ih8MhzkfIEmhyM2GsDwg0wQfv+KezcHHowP+MNSWXRRO12eFCnxF51it80gCxlZCSD
         EpP8q0RjRIbAOmvDhRjb+XgGEPj9ECVu+7D+AJub5oRQ9r1SawyVs/AdpkpRWPe2PKft
         Exth6F42sEa+tI2J1rlTF4aY520EaP5xPIWdJKt1I5wKqKvdACBmmUMIkl8A+ak/Sciy
         PgNeqwrNNuOM2gdd0P6sTGFASdFRCHeoPGawynHPAO876lcWKm7PqhDelzOlrDZoNU9d
         IYBA==
X-Gm-Message-State: AOAM533+2hC5ZlrRRT/ZqwKaUdRb15PRqngg0M/eaycKm6i7VpZeFx0M
        VH5Pjmf2yLS/E4ZUUryB0Wsh6HidqwXe+kcm
X-Google-Smtp-Source: ABdhPJxmJEPxOz8E/dCWgS+R3o4Cyibi4AdPzav0X81ZeS3AZmtaAhO2zJmbYttOz6yFOVQwWEts2Q==
X-Received: by 2002:a37:a747:: with SMTP id q68mr8700917qke.352.1610650972712;
        Thu, 14 Jan 2021 11:02:52 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o29sm3415225qtl.7.2021.01.14.11.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:02:52 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/5] btrfs: splice remaining dirty_bg's onto the transaction dirty bg list
Date:   Thu, 14 Jan 2021 14:02:43 -0500
Message-Id: <b7495cd02ea95c2d4a0859beec708723c018586e.1610650736.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1610650736.git.josef@toxicpanda.com>
References: <cover.1610650736.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While doing error injection testing with my relocation patches I hit the
following ASSERT()

assertion failed: list_empty(&block_group->dirty_list), in fs/btrfs/block-group.c:3356
------------[ cut here ]------------
kernel BUG at fs/btrfs/ctree.h:3357!
invalid opcode: 0000 [#1] SMP NOPTI
CPU: 0 PID: 24351 Comm: umount Tainted: G        W         5.10.0-rc3+ #193
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
RIP: 0010:assertfail.constprop.0+0x18/0x1a
RSP: 0018:ffffa09b019c7e00 EFLAGS: 00010282
RAX: 0000000000000056 RBX: ffff8f6492c18000 RCX: 0000000000000000
RDX: ffff8f64fbc27c60 RSI: ffff8f64fbc19050 RDI: ffff8f64fbc19050
RBP: ffff8f6483bbdc00 R08: 0000000000000000 R09: 0000000000000000
R10: ffffa09b019c7c38 R11: ffffffff85d70928 R12: ffff8f6492c18100
R13: ffff8f6492c18148 R14: ffff8f6483bbdd70 R15: dead000000000100
FS:  00007fbfda4cdc40(0000) GS:ffff8f64fbc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfda666fd0 CR3: 000000013cf66002 CR4: 0000000000370ef0
Call Trace:
 btrfs_free_block_groups.cold+0x55/0x55
 close_ctree+0x2c5/0x306
 ? fsnotify_destroy_marks+0x14/0x100
 generic_shutdown_super+0x6c/0x100
 kill_anon_super+0x14/0x30
 btrfs_kill_super+0x12/0x20
 deactivate_locked_super+0x36/0xa0
 cleanup_mnt+0x12d/0x190
 task_work_run+0x5c/0xa0
 exit_to_user_mode_prepare+0x1b1/0x1d0
 syscall_exit_to_user_mode+0x54/0x280
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This happened because I injected an error in btrfs_cow_block() while
running the dirty block groups.  When we run the dirty block groups, we
splice the list onto a local list to process.  However if an error
occurs, we only cleanup the transactions dirty block group list, not any
pending block groups we have on our locally spliced list.

In fact if we fail to allocate a path in this function we'll also fail
to clean up the splice list.

Fix this by splicing the list back onto the transaction dirty block
group list so that the block groups are cleaned up.  Then add a 'out'
label and have the error conditions jump to out so that the errors are
handled properly.  This also has the side-effect of fixing a problem
where we would clear 'ret' on error because we unconditionally ran
btrfs_run_delayed_refs().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 0886e81e5540..73632782d0cd 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -2556,8 +2556,10 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 
 	if (!path) {
 		path = btrfs_alloc_path();
-		if (!path)
-			return -ENOMEM;
+		if (!path) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	}
 
 	/*
@@ -2651,16 +2653,14 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 			btrfs_put_block_group(cache);
 		if (drop_reserve)
 			btrfs_delayed_refs_rsv_release(fs_info, 1);
-
-		if (ret)
-			break;
-
 		/*
 		 * Avoid blocking other tasks for too long. It might even save
 		 * us from writing caches for block groups that are going to be
 		 * removed.
 		 */
 		mutex_unlock(&trans->transaction->cache_write_mutex);
+		if (ret)
+			goto out;
 		mutex_lock(&trans->transaction->cache_write_mutex);
 	}
 	mutex_unlock(&trans->transaction->cache_write_mutex);
@@ -2684,7 +2684,12 @@ int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
 			goto again;
 		}
 		spin_unlock(&cur_trans->dirty_bgs_lock);
-	} else if (ret < 0) {
+	}
+out:
+	if (ret < 0) {
+		spin_lock(&cur_trans->dirty_bgs_lock);
+		list_splice_init(&dirty, &cur_trans->dirty_bgs);
+		spin_unlock(&cur_trans->dirty_bgs_lock);
 		btrfs_cleanup_dirty_bgs(cur_trans, fs_info);
 	}
 
-- 
2.26.2

