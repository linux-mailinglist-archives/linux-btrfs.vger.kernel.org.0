Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DE63EC08C
	for <lists+linux-btrfs@lfdr.de>; Sat, 14 Aug 2021 06:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhHNEdu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 14 Aug 2021 00:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhHNEdu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 14 Aug 2021 00:33:50 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E9DC061756
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Aug 2021 21:33:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x10so9631953wrt.8
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Aug 2021 21:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=05M4M0sfCKSOpPyrAFRRi5vKf49yFzKlQgaazo3ae6Q=;
        b=drpFfUUE79MkJ7DTsD6co/b5hEvVndnzdc6LfxSThrJG5Qj0VL7Tvu3RGhE8I3dUMt
         GYSH8CeBbomzbJoxVMCxuy5ivOz2gRiIsGZpHStGfwfYk5hTUV+LwLRXhoxwCvnp4kSw
         N9VAKr0Zlpk7OBaqCI+/qvTbTcd7r1lN0NOxhuTYy7TknHdkWKqgMEzmne1kSPMhhxco
         cNovYL2d/i+NlIFLg9G7pS2bdVpjFDIVI3POSvtZgxG3mAc/wKpVvpMECIDrNRS3Bz67
         d+TM8Pm2Dy2jqxL5Nbjvoi6O1bQx3333quZgs9tK8frGLiL9cDszzBeB8m3P2bnvc7Dv
         qDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=05M4M0sfCKSOpPyrAFRRi5vKf49yFzKlQgaazo3ae6Q=;
        b=dHIJ2swE3SXYXwKtDla23qdp9kfB6a2zNiTP2HDPK81UPMasPsrr/GynXWQSFefctm
         1Gl766Vwahd1/rZC2wUQhaEy00vM1WbP2cz0Nc1TbY0rD4AymGMhqCSgPnfyr0bE/+nA
         /HrAoQU20jA35HAbofVn8U5gXv7Zy6FBlq0fxNK9AywesNoH41mdg6rB6DKFNEjphizt
         gVRMB0TdVLel5/s8vqujtlBhppJQRhaIYtblZ/9oALI0/doAb8lKmBqndJCmNMIbZOUC
         puCFlfukawr3ecViwovnYhBhtwOzhPdyYqzefRbrBQhxxHSsnITltgQ9RGw+upSUhB2H
         Ypwg==
X-Gm-Message-State: AOAM532Cm3HJ2h3k8LJs7l38GgcGau+uCexdcEY2EMWiE/cJTrhkDhGc
        8NsErpnyRqYxZWXs9z5kCcoosbHVbWtfFcHII32tCOQqGt8ehCjU
X-Google-Smtp-Source: ABdhPJyGw3SOxI2sgIoceDCZ68hTpZPPH1HvGecR6ew9ac9n4oXuKPrcwAeDSf7K8u0SMkrlZ4+EBYrUKLwADwegf1o=
X-Received: by 2002:a05:6000:1b02:: with SMTP id f2mr6360601wrz.274.1628915600840;
 Fri, 13 Aug 2021 21:33:20 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 13 Aug 2021 22:33:05 -0600
Message-ID: <CAJCQCtQEp1a=sf8hO7zL5PHz-7NLjMv-A2nXGCEkNCos+nVA6Q@mail.gmail.com>
Subject: 5.14-0-rc5, splat in block_group_cache_tree_search while __btrfs_unlink_inode
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I get the following call trace about 0.6s after dnf completes an
update which I imagine deletes many files. I'll try to reproduce and
get /proc/lock_stat

[   95.674507] kernel: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
[   95.676537] kernel: turning off the locking correctness validator.
[   95.676537] kernel: Please attach the output of /proc/lock_stat to
the bug report
[   95.676538] kernel: CPU: 5 PID: 6045 Comm: systemd Not tainted
5.14.0-0.rc5.42.fc35.x86_64+debug #1
[   95.676540] kernel: Hardware name: LENOVO 20QDS3E200/20QDS3E200,
BIOS N2HET63W (1.46 ) 06/01/2021
[   95.681911] kernel: Call Trace:
[   95.681913] kernel:  dump_stack_lvl+0x57/0x72
[   95.681919] kernel:  __lock_acquire.cold+0x11/0x2b8
[   95.681923] kernel:  lock_acquire+0xc4/0x2e0
[   95.681926] kernel:  ? block_group_cache_tree_search+0x24/0x110
[   95.681929] kernel:  ? rcu_read_lock_sched_held+0x3f/0x80
[   95.681931] kernel:  ? check_ref_cleanup+0x154/0x160
[   95.681933] kernel:  ? kmem_cache_free+0x2c7/0x380
[   95.681936] kernel:  ? __mutex_unlock_slowpath+0x35/0x270
[   95.681940] kernel:  _raw_spin_lock+0x31/0x80
[   95.681941] kernel:  ? block_group_cache_tree_search+0x24/0x110
[   95.681943] kernel:  block_group_cache_tree_search+0x24/0x110
[   95.681944] kernel:  btrfs_free_tree_block+0x126/0x300
[   95.681947] kernel:  __btrfs_cow_block+0x308/0x5d0
[   95.681950] kernel:  btrfs_cow_block+0xf8/0x220
[   95.681951] kernel:  btrfs_search_slot+0x508/0x9e0
[   95.681954] kernel:  btrfs_lookup_dir_item+0x6c/0xb0
[   95.681956] kernel:  __btrfs_unlink_inode+0x9a/0x4e0
[   95.681960] kernel:  btrfs_rmdir+0xdf/0x1d0
[   95.681962] kernel:  vfs_rmdir+0x7e/0x190
[   95.681965] kernel:  do_rmdir+0x16a/0x190
[   95.681967] kernel:  do_syscall_64+0x38/0x90
[   95.681970] kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   95.681972] kernel: RIP: 0033:0x7f07bfcb3e8b
[   95.681975] kernel: Code: 73 01 c3 48 8b 0d ed ff 0c 00 f7 d8 64 89
01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 07
01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d bd ff 0c 00 f7 d8
64 89 01 48
[   95.681976] kernel: RSP: 002b:00007f07be6647a8 EFLAGS: 00000246
ORIG_RAX: 0000000000000107
[   95.681978] kernel: RAX: ffffffffffffffda RBX: 0000000000000006
RCX: 00007f07bfcb3e8b
[   95.681979] kernel: RDX: 0000000000000200 RSI: 00007f07b0000bd3
RDI: 0000000000000026
[   95.681980] kernel: RBP: 0000000000000026 R08: 0000000000000000
R09: 00007f07b0000080
[   95.681980] kernel: R10: 0000000000000078 R11: 0000000000000246
R12: 0000000000000000
[   95.681981] kernel: R13: 00007f07b0000bd3 R14: 0000000000000200
R15: 00007f07be6653f8

mount options:
/dev/nvme0n1p5 on / type btrfs
(rw,noatime,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=268,subvol=/root34)

features:
csum_type        1 (xxhash64)
num_devices        1
compat_flags        0x0
compat_ro_flags        0x3
            ( FREE_SPACE_TREE |
              FREE_SPACE_TREE_VALID )
incompat_flags        0x355
            ( MIXED_BACKREF |
              MIXED_GROUPS |
              COMPRESS_ZSTD |
              EXTENDED_IREF |
              SKINNY_METADATA |
              NO_HOLES )

Full dmesg:
https://drive.google.com/file/d/1cLuWfvM_K4E6ML44KgAbNljF16bT3nSi/view?usp=sharing

-- 
Chris Murphy
