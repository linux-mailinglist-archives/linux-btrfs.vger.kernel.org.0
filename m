Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDC22D2F6F
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 17:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbgLHQYv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 11:24:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgLHQYt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 11:24:49 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D353C061794
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 08:24:09 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id z188so16421725qke.9
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 08:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MBAVyNUqf/0LMFLeiGY+TpoYSaKveLLXpRtIg0JpiI=;
        b=egdYZHRJk9WNe5kc1p1Bsn8j7Ib1oBep0v14CKbEV2hFMNRo8e39+M+MAPQCzk4YDa
         /hMakPIdDIhZEylnmIxfVmnYKCOV47z/o2h8TO/+X/u39/SGVlbUwVIjlGvwaTWcj7SW
         bgeAgdvWI/Ct13bpAY/W1mTP0PJSTJo6RzOlzxieApuXKl2WWE3B3Ox/AmdTc/HLXNH9
         Aa8jLbUovufJIhc97xlMLm0BZMdguv/XfvyUUe1tlxNPG5P+g54rmCzdv9GBV3WIo7Dv
         0QBf5DBDVfB9+tWMmUOJ1nIjnY2uXTaS8Ur1IQz5GccTVbVu4d1PR4kyP/BT5piRTIMj
         1HFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3MBAVyNUqf/0LMFLeiGY+TpoYSaKveLLXpRtIg0JpiI=;
        b=Edj/6ujSiTIgDRRHMOrC9si3RtQ68VwiyMyurJAVsjIRP/Xw+iRP7bJKdNPNpSEMdz
         mZY3HmqMDGmtm//HraGqoPQh66i68WeZqt9gNuJcv25+Xz/LFPk3659TUCYMfSHqMXi8
         bwNXmiL2k9rXOFEkQyxm8R2ocNIZ+IYXoU7Oa35cYSeASKcRY4fkGZyc91whcRlgwGa5
         lY4vIMw1wlY7r+QEpi+JKdwUJbTze3BSlOMxal+0Zf7dVrnh4ONAhS0G/T8HXFRiN4Nu
         8YtKS4aBozfpyw94Smh+7vxxeLOxXLTbKsXwoRDNSAm0MFDQaV5DsYUI8UYKC/2f4opf
         AoWw==
X-Gm-Message-State: AOAM530se9YdT6clGkGzQuN/nkxnXT/qQOrNey0GvcgydjqKsuYVccmx
        TU26pgN8m6bNMIe/2NdDDQXiqTbGEVXWq4U2
X-Google-Smtp-Source: ABdhPJxk6CyPZefzxnytVL77hdk2iYFKZQB8Hs+BMrF1DHEWWIMYPXY5CwQVYpGeCXo5nbmdKZiYfQ==
X-Received: by 2002:a37:6697:: with SMTP id a145mr29807391qkc.296.1607444647969;
        Tue, 08 Dec 2020 08:24:07 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u72sm15225753qka.15.2020.12.08.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 08:24:07 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Cc:     Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 03/52] btrfs: fix lockdep splat in btrfs_recover_relocation
Date:   Tue,  8 Dec 2020 11:23:10 -0500
Message-Id: <921347f2c777c0e213cb80cb00c6c3487c2f4907.1607444471.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607444471.git.josef@toxicpanda.com>
References: <cover.1607444471.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

While testing the error paths of relocation I hit the following lockdep
splat

======================================================
WARNING: possible circular locking dependency detected
5.10.0-rc6+ #217 Not tainted
------------------------------------------------------
mount/779 is trying to acquire lock:
ffffa0e676945418 (&fs_info->balance_mutex){+.+.}-{3:3}, at: btrfs_recover_balance+0x2f0/0x340

but task is already holding lock:
ffffa0e60ee31da8 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x27/0x100

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (btrfs-root-00){++++}-{3:3}:
       down_read_nested+0x43/0x130
       __btrfs_tree_read_lock+0x27/0x100
       btrfs_read_lock_root_node+0x31/0x40
       btrfs_search_slot+0x462/0x8f0
       btrfs_update_root+0x55/0x2b0
       btrfs_drop_snapshot+0x398/0x750
       clean_dirty_subvols+0xdf/0x120
       btrfs_recover_relocation+0x534/0x5a0
       btrfs_start_pre_rw_mount+0xcb/0x170
       open_ctree+0x151f/0x1726
       btrfs_mount_root.cold+0x12/0xea
       legacy_get_tree+0x30/0x50
       vfs_get_tree+0x28/0xc0
       vfs_kern_mount.part.0+0x71/0xb0
       btrfs_mount+0x10d/0x380
       legacy_get_tree+0x30/0x50
       vfs_get_tree+0x28/0xc0
       path_mount+0x433/0xc10
       __x64_sys_mount+0xe3/0x120
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (sb_internal#2){.+.+}-{0:0}:
       start_transaction+0x444/0x700
       insert_balance_item.isra.0+0x37/0x320
       btrfs_balance+0x354/0xf40
       btrfs_ioctl_balance+0x2cf/0x380
       __x64_sys_ioctl+0x83/0xb0
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&fs_info->balance_mutex){+.+.}-{3:3}:
       __lock_acquire+0x1120/0x1e10
       lock_acquire+0x116/0x370
       __mutex_lock+0x7e/0x7b0
       btrfs_recover_balance+0x2f0/0x340
       open_ctree+0x1095/0x1726
       btrfs_mount_root.cold+0x12/0xea
       legacy_get_tree+0x30/0x50
       vfs_get_tree+0x28/0xc0
       vfs_kern_mount.part.0+0x71/0xb0
       btrfs_mount+0x10d/0x380
       legacy_get_tree+0x30/0x50
       vfs_get_tree+0x28/0xc0
       path_mount+0x433/0xc10
       __x64_sys_mount+0xe3/0x120
       do_syscall_64+0x33/0x40
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &fs_info->balance_mutex --> sb_internal#2 --> btrfs-root-00

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(btrfs-root-00);
                               lock(sb_internal#2);
                               lock(btrfs-root-00);
  lock(&fs_info->balance_mutex);

 *** DEADLOCK ***

2 locks held by mount/779:
 #0: ffffa0e60dc040e0 (&type->s_umount_key#47/1){+.+.}-{3:3}, at: alloc_super+0xb5/0x380
 #1: ffffa0e60ee31da8 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x27/0x100

stack backtrace:
CPU: 0 PID: 779 Comm: mount Not tainted 5.10.0-rc6+ #217
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
Call Trace:
 dump_stack+0x8b/0xb0
 check_noncircular+0xcf/0xf0
 ? trace_call_bpf+0x139/0x260
 __lock_acquire+0x1120/0x1e10
 lock_acquire+0x116/0x370
 ? btrfs_recover_balance+0x2f0/0x340
 __mutex_lock+0x7e/0x7b0
 ? btrfs_recover_balance+0x2f0/0x340
 ? btrfs_recover_balance+0x2f0/0x340
 ? rcu_read_lock_sched_held+0x3f/0x80
 ? kmem_cache_alloc_trace+0x2c4/0x2f0
 ? btrfs_get_64+0x5e/0x100
 btrfs_recover_balance+0x2f0/0x340
 open_ctree+0x1095/0x1726
 btrfs_mount_root.cold+0x12/0xea
 ? rcu_read_lock_sched_held+0x3f/0x80
 legacy_get_tree+0x30/0x50
 vfs_get_tree+0x28/0xc0
 vfs_kern_mount.part.0+0x71/0xb0
 btrfs_mount+0x10d/0x380
 ? __kmalloc_track_caller+0x2f2/0x320
 legacy_get_tree+0x30/0x50
 vfs_get_tree+0x28/0xc0
 ? capable+0x3a/0x60
 path_mount+0x433/0xc10
 __x64_sys_mount+0xe3/0x120
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

This is thankfully straightforward to fix, simply release the path
before we setup the reloc_ctl.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 7930e1c78c45..49ba941f0314 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4318,6 +4318,8 @@ int btrfs_recover_balance(struct btrfs_fs_info *fs_info)
 		btrfs_warn(fs_info,
 	"balance: cannot set exclusive op status, resume manually");
 
+	btrfs_release_path(path);
+
 	mutex_lock(&fs_info->balance_mutex);
 	BUG_ON(fs_info->balance_ctl);
 	spin_lock(&fs_info->balance_lock);
-- 
2.26.2

