Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D83F3286
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 19:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhHTRxE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 13:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbhHTRxC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 13:53:02 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA67C061575;
        Fri, 20 Aug 2021 10:52:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so1539693pjx.5;
        Fri, 20 Aug 2021 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Gb5HcaUUjNzoxlEdIwt0oiuotNKbOWBhybKn0uIYBE=;
        b=CHSZ+64z/dhipp2kjC7peGVVbBKkJsNnCsHAcFaKMTcFj5/YSjIzv//G3hfEMf8BAI
         Jg3jwc66NhGkhq5rn+GmiSo17Lg7Te53Bk+4frUWCv1PXEtoQsgI3zQfUvDlkVmHexNL
         W/QV3XNkn9rZO9aIA+yJ4pVp33TkfSzvxM3eVx6HpoNLXH9jWg+kGUiYkQIlwxmvsMY5
         xW/exZDnehAODSufHsx/ftHtmzpw5YMzmZ9dfz4V0KzaPI0eXcrqJTGBnB5sqS2gzwSt
         QZBmGXkYBqSZMX0hfQdvhHnbDGks1Q9TDQyLdTB0BSP5LQDU0whMS32NR/p/nWbO20Rt
         e5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Gb5HcaUUjNzoxlEdIwt0oiuotNKbOWBhybKn0uIYBE=;
        b=Uq14ug22Xrhb8HdWpgr84n0LGKOh5TtXJ9OFZxWKvyBt8NWCBdOEmS1yP72HrhYEBo
         1dGynCJ2ajfcUfCHYT5NVHV+eUhssuzdITI1iUmj4M+DjBb6SmQbJLggyF1XBHxtguIp
         o/uaxA71TUJBT0Dtw64FRzgkbcGDsFeUnIDjKZlI+4h5/k8rlA2Lq2KYYVMM35yK9lGJ
         rROUrxLGi9gUtOeeUUUNU3E9vyy5BRA4l+msca0ZOS8NQQcrV4DYj+/sGgysIPBzoWOq
         1yb76ud1+hUzplVp/ehqRMgUC1bhQWxzTk92UMj+FZ1TmiTG06T3zqTQh0umL5mhY8yY
         zKmw==
X-Gm-Message-State: AOAM530Yg1PBBStAVhZsHhVVEVtXm1ms0HmE7wiCJdWH1dnPZuhTSUH3
        rVIGEc1Eqch/vNEBumHKYkM=
X-Google-Smtp-Source: ABdhPJz6C+FGa9mgyW9TmLSmQDRM+ddq9D7Tx7bpb33rAW0KcRAMDkGycPFmP6bg+jUHzimX6LJYoA==
X-Received: by 2002:a17:902:d918:b029:12d:22d5:869a with SMTP id c24-20020a170902d918b029012d22d5869amr17140791plz.82.1629481944347;
        Fri, 20 Aug 2021 10:52:24 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id i6sm7632364pfa.44.2021.08.20.10.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:52:23 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH] btrfs: reset replace target device to allocation state on close
Date:   Sat, 21 Aug 2021 01:50:40 +0800
Message-Id: <20210820175040.586806-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This crash was observed with a failed assertion on device close:

  BTRFS: Transaction aborted (error -28)
  WARNING: CPU: 1 PID: 3902 at fs/btrfs/extent-tree.c:2150 btrfs_run_delayed_refs+0x1d2/0x1e0 [btrfs]
  Modules linked in: btrfs blake2b_generic libcrc32c crc32c_intel xor zstd_decompress zstd_compress xxhash lzo_compress lzo_decompress raid6_pq loop
  CPU: 1 PID: 3902 Comm: kworker/u8:4 Not tainted 5.14.0-rc5-default+ #1532
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
  Workqueue: events_unbound btrfs_async_reclaim_metadata_space [btrfs]
  RIP: 0010:btrfs_run_delayed_refs+0x1d2/0x1e0 [btrfs]
  RSP: 0018:ffffb7a5452d7d80 EFLAGS: 00010282
  RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
  RDX: 0000000000000001 RSI: ffffffffabee13c4 RDI: 00000000ffffffff
  RBP: ffff97834176a378 R08: 0000000000000001 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000001 R12: ffff97835195d388
  R13: 0000000005b08000 R14: ffff978385484000 R15: 000000000000016c
  FS:  0000000000000000(0000) GS:ffff9783bd800000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000056190d003fe8 CR3: 000000002a81e005 CR4: 0000000000170ea0
  Call Trace:
   flush_space+0x197/0x2f0 [btrfs]
   btrfs_async_reclaim_metadata_space+0x139/0x300 [btrfs]
   process_one_work+0x262/0x5e0
   worker_thread+0x4c/0x320
   ? process_one_work+0x5e0/0x5e0
   kthread+0x144/0x170
   ? set_kthread_struct+0x40/0x40
   ret_from_fork+0x1f/0x30
  irq event stamp: 19334989
  hardirqs last  enabled at (19334997): [<ffffffffab0e0c87>] console_unlock+0x2b7/0x400
  hardirqs last disabled at (19335006): [<ffffffffab0e0d0d>] console_unlock+0x33d/0x400
  softirqs last  enabled at (19334900): [<ffffffffaba0030d>] __do_softirq+0x30d/0x574
  softirqs last disabled at (19334893): [<ffffffffab0721ec>] irq_exit_rcu+0x12c/0x140
  ---[ end trace 45939e308e0dd3c7 ]---
  BTRFS: error (device vdd) in btrfs_run_delayed_refs:2150: errno=-28 No space left
  BTRFS info (device vdd): forced readonly
  BTRFS warning (device vdd): failed setting block group ro: -30
  BTRFS info (device vdd): suspending dev_replace for unmount
  assertion failed: !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state), in fs/btrfs/volumes.c:1150
  ------------[ cut here ]------------
  kernel BUG at fs/btrfs/ctree.h:3431!
  invalid opcode: 0000 [#1] PREEMPT SMP
  CPU: 1 PID: 3982 Comm: umount Tainted: G        W         5.14.0-rc5-default+ #1532
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
  RIP: 0010:assertfail.constprop.0+0x18/0x1a [btrfs]
  RSP: 0018:ffffb7a5454c7db8 EFLAGS: 00010246
  RAX: 0000000000000068 RBX: ffff978364b91c00 RCX: 0000000000000000
  RDX: 0000000000000000 RSI: ffffffffabee13c4 RDI: 00000000ffffffff
  RBP: ffff9783523a4c00 R08: 0000000000000001 R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000001 R12: ffff9783523a4d18
  R13: 0000000000000000 R14: 0000000000000004 R15: 0000000000000003
  FS:  00007f61c8f42800(0000) GS:ffff9783bd800000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000056190cffa810 CR3: 0000000030b96002 CR4: 0000000000170ea0
  Call Trace:
   btrfs_close_one_device.cold+0x11/0x55 [btrfs]
   close_fs_devices+0x44/0xb0 [btrfs]
   btrfs_close_devices+0x48/0x160 [btrfs]
   generic_shutdown_super+0x69/0x100
   kill_anon_super+0x14/0x30
   btrfs_kill_super+0x12/0x20 [btrfs]
   deactivate_locked_super+0x2c/0xa0
   cleanup_mnt+0x144/0x1b0
   task_work_run+0x59/0xa0
   exit_to_user_mode_loop+0xe7/0xf0
   exit_to_user_mode_prepare+0xaf/0xf0
   syscall_exit_to_user_mode+0x19/0x50
   do_syscall_64+0x4a/0x90
   entry_SYSCALL_64_after_hwframe+0x44/0xae

This happens when close_ctree is called while a dev_replace hasn't
completed. In close_ctree, we suspend the dev_replace, but keep the
replace target around so that we can resume the dev_replace procedure
when we mount the root again. This is the call trace:

  close_ctree():
    btrfs_dev_replace_suspend_for_unmount();
    btrfs_close_devices():
      btrfs_close_fs_devices():
        btrfs_close_one_device():
          ASSERT(!test_bit(BTRFS_DEV_STATE_REPLACE_TGT,
                 &device->dev_state));

However, since the replace target sticks around, there is a device
with BTRFS_DEV_STATE_REPLACE_TGT set on close, and we fail the
assertion in btrfs_close_one_device.

To fix this, if we come across the replace target device when
closing, we should properly reset it back to allocation state. This
fix also ensures that if a non-target device has a corrupted state and
has the BTRFS_DEV_STATE_REPLACE_TGT bit set, the assertion will still
catch the error.

Reported-by: David Sterba <dsterba@suse.com>
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 fs/btrfs/volumes.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 70f94b75f25a..a5afebb78ecf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1130,6 +1130,9 @@ static void btrfs_close_one_device(struct btrfs_device *device)
 		fs_devices->rw_devices--;
 	}
 
+	if (device->devid == BTRFS_DEV_REPLACE_DEVID)
+		clear_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
+
 	if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
 		fs_devices->missing_devices--;
 
-- 
2.25.1

