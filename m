Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2A12B202A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 17:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgKMQXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 11:23:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgKMQXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 11:23:44 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4ECC0613D1
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:44 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id g17so7045950qts.5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 08:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=nG8iZmRkdzUf4mZxqvFAgUPULwCsCayLJqk3ZbVVYpI=;
        b=qa45k/M3eKHJ7cfelpiwhBfzVlBs8FmZZRXbpLD9H1y5jqpZp43hzlsX2l8FGf0Aj2
         m76Ob6UXdENbt4QVtJn359SurBsJ0YeTL4phHQqgNv0S1/siYiFL9kYllYJWFBOtTNfX
         UjHmUaqjsb8Hlskveod4WpiCioIUYq9+TxfjFMQXfqmXPsLMWSNBtgNW7FuqsehfXQcJ
         W5n+ufiKTOg1OhezQtSrGDEp8fl77Z/SiRikFI6dRHdud0BtZUYW7mQPQc2ld0sU7N1s
         br4GU696/peT/7jVLhNjR3xZE2s3Pg/tD7Ciy9qrk+9D1DhjV2Oa+1pHnkLIwq9Kymra
         p+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nG8iZmRkdzUf4mZxqvFAgUPULwCsCayLJqk3ZbVVYpI=;
        b=AIEYy3V5jaoEz99vUPEigb6XxcbNymN3mnpPPu3EQIu4iNaKsEXlucMZ/nJ7oGLCEI
         boXj2SKGpH1Xmwpcmz5ZZ3XJdW8jmYJTT6chyDPtbmqRIlpFEPVC7a8OkVUnDuIklxz2
         ssqOuO08r7LKdhinZNaVSqe9nIjoZyAjA9FK1eDQPkLmRE6IYhGRXHKhAIPVZCCTtKGu
         ZHhB6DmPUE+bBF3Q+sDCglAqVDCC5NIE/tsfOpdFAa0zrco4XUguA0vdtkYFdhEXbXLj
         agY8f2gt46+lRH9zjpYBS9R0Ft2Ghggps7CTc4n+3pKmvQOVWiCwQZtoRea1QDgeYUyO
         KFZA==
X-Gm-Message-State: AOAM530dV39GElCkdLIPu440qBMQzEpRZe4Ww0shuLLd8+K12JrFCUxC
        hZfvXPBiTdwnAOQR/jCOOcIFFYioscX+aQ==
X-Google-Smtp-Source: ABdhPJzlFfAnUSzqi/yPymTP53KddkyH2E1zoumam6xGaVzLooLhJO+GHVrV7BdIA+rLUjjvXN53/g==
X-Received: by 2002:aed:210e:: with SMTP id 14mr2669634qtc.57.1605284618244;
        Fri, 13 Nov 2020 08:23:38 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id j202sm6765637qke.108.2020.11.13.08.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:23:37 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 02/42] btrfs: fix lockdep splat in btrfs_recover_relocation
Date:   Fri, 13 Nov 2020 11:22:52 -0500
Message-Id: <44c756daa28122f0f51f52d154c1232a09e66872.1605284383.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1605284383.git.josef@toxicpanda.com>
References: <cover.1605284383.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing the error paths of relocation I hit the following lockdep
splat

======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc2-btrfs-next-71 #1 Not tainted
------------------------------------------------------
find/324157 is trying to acquire lock:
ffff8ebc48d293a0 (btrfs-tree-01#2/3){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]

but task is already holding lock:
ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (btrfs-tree-00){++++}-{3:3}:
       lock_acquire+0xd8/0x490
       down_write_nested+0x44/0x120
       __btrfs_tree_lock+0x27/0x120 [btrfs]
       btrfs_search_slot+0x2a3/0xc50 [btrfs]
       btrfs_insert_empty_items+0x58/0xa0 [btrfs]
       insert_with_overflow+0x44/0x110 [btrfs]
       btrfs_insert_xattr_item+0xb8/0x1d0 [btrfs]
       btrfs_setxattr+0xd6/0x4c0 [btrfs]
       btrfs_setxattr_trans+0x68/0x100 [btrfs]
       __vfs_setxattr+0x66/0x80
       __vfs_setxattr_noperm+0x70/0x200
       vfs_setxattr+0x6b/0x120
       setxattr+0x125/0x240
       path_setxattr+0xba/0xd0
       __x64_sys_setxattr+0x27/0x30
       do_syscall_64+0x33/0x80
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (btrfs-tree-01#2/3){++++}-{3:3}:
       check_prev_add+0x91/0xc60
       __lock_acquire+0x1689/0x3130
       lock_acquire+0xd8/0x490
       down_read_nested+0x45/0x220
       __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
       btrfs_next_old_leaf+0x27d/0x580 [btrfs]
       btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
       iterate_dir+0x170/0x1c0
       __x64_sys_getdents64+0x83/0x140
       do_syscall_64+0x33/0x80
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-tree-00);
                               lock(btrfs-tree-01#2/3);
                               lock(btrfs-tree-00);
  lock(btrfs-tree-01#2/3);

 *** DEADLOCK ***

5 locks held by find/324157:
 #0: ffff8ebc502c6e00 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x4d/0x60
 #1: ffff8eb97f689980 (&type->i_mutex_dir_key#10){++++}-{3:3}, at: iterate_dir+0x52/0x1c0
 #2: ffff8ebaec00ca58 (btrfs-tree-02#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 #3: ffff8eb98f986f78 (btrfs-tree-01#2){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 #4: ffff8eb9932c5088 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]

stack backtrace:
CPU: 2 PID: 324157 Comm: find Not tainted 5.10.0-rc2-btrfs-next-71 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 dump_stack+0x8d/0xb5
 check_noncircular+0xff/0x110
 ? mark_lock.part.0+0x468/0xe90
 check_prev_add+0x91/0xc60
 __lock_acquire+0x1689/0x3130
 ? kvm_clock_read+0x14/0x30
 ? kvm_sched_clock_read+0x5/0x10
 lock_acquire+0xd8/0x490
 ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 down_read_nested+0x45/0x220
 ? __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 __btrfs_tree_read_lock+0x32/0x1a0 [btrfs]
 btrfs_next_old_leaf+0x27d/0x580 [btrfs]
 btrfs_real_readdir+0x1e3/0x4b0 [btrfs]
 iterate_dir+0x170/0x1c0
 __x64_sys_getdents64+0x83/0x140
 ? filldir+0x1d0/0x1d0
 do_syscall_64+0x33/0x80
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This is thankfully straightforward to fix, simply release the path
before we setup the reloc_ctl.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index bb1aa96e1233..ece8bb62fcc1 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4283,6 +4283,8 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 		btrfs_warn(fs_info,
 	"balance: cannot set exclusive op status, resume manually");
 
+	btrfs_release_path(path);
+
 	mutex_lock(&fs_info->balance_mutex);
 	BUG_ON(fs_info->balance_ctl);
 	spin_lock(&fs_info->balance_lock);
-- 
2.26.2

