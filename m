Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34A673AFB4
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Jun 2023 07:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjFWFFs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Jun 2023 01:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjFWFFq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Jun 2023 01:05:46 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70D1189
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 22:05:44 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6b45803edfcso252618a34.3
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Jun 2023 22:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1687496744; x=1690088744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKa5877sw5OgDtxpT1nWvhRvaVoxbBvExefxBEEH6wM=;
        b=0nO/Wxkd/+KIshIwI6twUTs5wutdg16YJ3HFilQ4qPtT9+hnOKll/FkUtjnOXuh5L3
         cClvIaB4YeckCqG33hEsVTCaq5j6EuX4KJkFQHO5vZ3osqT8pmtoiORiNWcIMtOJxx/g
         bvFAu7kbejpsl3dv9t74IpCiF30U6tJgnpz/iw6HYjVMK7bRKTxiJzXkuLBe5XNEEreM
         gEX6BFRjtDGD/PES6jEHocXVLk5Ta9t5IMpoU+gZ9fjMLVYLWcybFTPbBhdWAh457rOt
         Lywn53Pz64ubNulWp6bDjypmfSRZx9MO4YO2jaMoZAqN8gjVhcqE43TllHGNkXi9o9Oz
         5sIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687496744; x=1690088744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKa5877sw5OgDtxpT1nWvhRvaVoxbBvExefxBEEH6wM=;
        b=JkrZ33ddUUzm+Ljz/Uv+1lsmDfdCFeH1f+suuDTH2hXKYbLwVdcWelcUkVvk4cWSwA
         IqZAKc4ORwWHoUETQxHgvhIRJyPiJTTartqKvs6G56QHzhY6jAV9HLW9uQzbN0QUJeu5
         F5b4nLpe/rB3NjtHt0HKXcAj1b+9cOQpw7TX1EaODvWiqOXYwFNTnS7qsm2TAHGZjjKB
         4Zx6orOiqPXV+5GgkUw1ci5k0NnmnNLSIBQ0tpbFCFHuicMImfyrgDt31RdkVDy+8QfF
         6/UQJix4md1Pxvz+M/AFge326xytbROyChb0VFiAIL/8X8eSYjPjZv8xxU6rCmZAPfXN
         NcRg==
X-Gm-Message-State: AC+VfDwMe7vOcKS5yaGGRsC23WaskQruI6ChuNgf1X8KYclDqtJvth39
        zZ96S54Ud8hiUS+7JPDOSCFdFI7RlKYnbayeeamcag==
X-Google-Smtp-Source: ACHHUZ7PfA1kmsfWzmpyMPbJeX+cD9O/4qQHUbxoTDtGPJdkorGgcxbcYmmGnrmlShnuW8vC3vmxwg==
X-Received: by 2002:a05:6830:164e:b0:6b5:e38a:a1d3 with SMTP id h14-20020a056830164e00b006b5e38aa1d3mr5431324otr.13.1687496743790;
        Thu, 22 Jun 2023 22:05:43 -0700 (PDT)
Received: from localhost ([207.225.234.150])
        by smtp.gmail.com with ESMTPSA id b21-20020a63e715000000b0054a15146f53sm5540506pgi.13.2023.06.22.22.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 22:05:42 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     syzbot+c0f3acf145cb465426d5@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: fix race between balance and cancel/pause
Date:   Fri, 23 Jun 2023 01:05:41 -0400
Message-Id: <9cdf58c2f045863e98a52d7f9d5102ba12b87f07.1687496547.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.40.1
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

Syzbot reported a panic that looks like this

assertion failed: fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE_PAUSED, in fs/btrfs/ioctl.c:465
------------[ cut here ]------------
kernel BUG at fs/btrfs/messages.c:259!
RIP: 0010:btrfs_assertfail+0x2c/0x30 fs/btrfs/messages.c:259
Call Trace:
 <TASK>
 btrfs_exclop_balance fs/btrfs/ioctl.c:465 [inline]
 btrfs_ioctl_balance fs/btrfs/ioctl.c:3564 [inline]
 btrfs_ioctl+0x531e/0x5b30 fs/btrfs/ioctl.c:4632
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The reproducer is running a balance and a cancel or pause in parallel.  The way
balance finishes is a bit wonky, if we were paused we need to save the
balance_ctl in the fs_info, but clear it otherwise and cleanup.  However
we rely on the return values being specific errors, or having a cancel
request or no pause request.  If balance completes and returns 0, but we
have a pause or cancel request we won't do the appropriate cleanup, and
then the next time we try to start a balance we'll trip this ASSERT.

The error handling is just wrong here, we always want to clean up,
unless we got -ECANCELLED and we set the appropriate pause flag in the
exclusive op.  With this patch the reproducer ran for an hour without
tripping, previously it would trip in less than a few minutes.

Reported-by: syzbot+c0f3acf145cb465426d5@syzkaller.appspotmail.com
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a536d0e0e055..90d25b2a6fd1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4081,14 +4081,6 @@ static int alloc_profile_is_valid(u64 flags, int extended)
 	return has_single_bit_set(flags);
 }
 
-static inline int balance_need_close(struct btrfs_fs_info *fs_info)
-{
-	/* cancel requested || normal exit path */
-	return atomic_read(&fs_info->balance_cancel_req) ||
-		(atomic_read(&fs_info->balance_pause_req) == 0 &&
-		 atomic_read(&fs_info->balance_cancel_req) == 0);
-}
-
 /*
  * Validate target profile against allowed profiles and return true if it's OK.
  * Otherwise print the error message and return false.
@@ -4278,6 +4270,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	u64 num_devices;
 	unsigned seq;
 	bool reducing_redundancy;
+	bool paused = false;
 	int i;
 
 	if (btrfs_fs_closing(fs_info) ||
@@ -4408,6 +4401,7 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 	if (ret == -ECANCELED && atomic_read(&fs_info->balance_pause_req)) {
 		btrfs_info(fs_info, "balance: paused");
 		btrfs_exclop_balance(fs_info, BTRFS_EXCLOP_BALANCE_PAUSED);
+		paused = true;
 	}
 	/*
 	 * Balance can be canceled by:
@@ -4436,8 +4430,8 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 		btrfs_update_ioctl_balance_args(fs_info, bargs);
 	}
 
-	if ((ret && ret != -ECANCELED && ret != -ENOSPC) ||
-	    balance_need_close(fs_info)) {
+	/* We didn't pause, we can clean everything up. */
+	if (!paused) {
 		reset_balance_state(fs_info);
 		btrfs_exclop_finish(fs_info);
 	}
-- 
2.40.1

