Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D4ABD4F8
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 00:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410721AbfIXWeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 18:34:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46750 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389629AbfIXWeq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 18:34:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id o18so3867191wrv.13
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Sep 2019 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x97pPXn8oB4WFU+HrQKieiIi8auGsNFD64BTPKk9wNE=;
        b=IiDSc/BRWZXGB37Druk9K1ijgFWhq6dEpgwKtNfxREIHk1z78rYtjLDcUj9NC/AK6z
         ZGIpVNHm1mXIB1G6j71n7OjAM+82bDYLkeKfPjNXg8AvqMYiGqQIElf1wMkDQkp3UV/E
         L8tDH/wqS1M/y5iT0Qv3oEVqMbEwBiYgP8OGjhiEXhXf/1Cx/oOIv9xGgrZXWa+kN+ZX
         LRI3kZALGVLVy7Et4xYJjeoo61tkW5xFn/NLD0dzml/vKusVt7Mu5YfbjfjYDVQfUdeh
         gttJNJYJX9F8Bt3L4O5QQS7qIy2ueWtsEsOWbipbRzMOAsMRGH29PV9Wz2ecKbnLnoq/
         BStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x97pPXn8oB4WFU+HrQKieiIi8auGsNFD64BTPKk9wNE=;
        b=OP652mPvO4Cu8ffX+jWchZ+Ob94l+9Tk36CUqCYgYn+g8iEi2V3YTuPSK02XruKCeW
         ofPGW7fhSuU1jd7nzrBIJg5U2fk0PV2DQP4eQkuUepYLimgVJMEebkqUy9nb8hEosO01
         ErgYDME6nRbuWQq2Ao7ttrrrrVaHxYDOo26xIp1FuzjkIP8rQJZ5hrwqPQYG2t9kSsmp
         lmmwP7hm2FtZeXB4r99ARgLC+faHx+6jUy8I0waR0pURDVAf5hCg49n+91Im2jHuV5Xx
         t+e0ve2cV0F5xheDVLgi3wjxxr7tjJyXzB350idnC1YadnjQwUspgy23cz/ZvngyqBGD
         c/pQ==
X-Gm-Message-State: APjAAAU5mUodkQgPupG1QAvrmMmA9GlBdY6YP5AUFsv10Ld658lolR/9
        nkvihPn0E9Qu16xJkiprxsy7Sh51EXaXnh5106Iidw==
X-Google-Smtp-Source: APXvYqx/xC4seSNgDoFji3Af0YMMfZeypTa2KAEsvSlwh/c9dO8aIybLmm2A8bsMTIoNpcbADEHiK+bhdxMBFd95XwY=
X-Received: by 2002:a5d:4241:: with SMTP id s1mr5249665wrr.101.1569364483218;
 Tue, 24 Sep 2019 15:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADyTPEwDifK+YA6-kh6F8Wpf9C0+acQjkxGBJhf1ATTpZbMSYg@mail.gmail.com>
In-Reply-To: <CADyTPEwDifK+YA6-kh6F8Wpf9C0+acQjkxGBJhf1ATTpZbMSYg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 24 Sep 2019 16:34:32 -0600
Message-ID: <CAJCQCtQM_Pn4SubsJw9t0TjF8WNoqguxVf--UYH6K82Ch8Dm9Q@mail.gmail.com>
Subject: Re: Btrfs filesystem trashed after OOM scenario
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Sep 24, 2019 at 4:04 PM Nick Bowler <nbowler@draconx.ca> wrote:
>
> Hi folks,
>
> So I had an interesting scenario that I thought I'd share in case
> anyone wants to investigate before I blow away this filesystem...
>
> Timeline:
> - Running Linux 5.2.14, I pushed this system to OOM; the oom killer
> ran and killed some userspace tasks.  At this point many of the
> remaining tasks were stuck in uninterruptible sleeps.  Not really
> worried, I turned the machine off and on again to just get everything
> back to normal.  But I guess now that everything had gone horribly
> wrong already at this point...

Yeah the kernel oomkiller is pretty much only about kernel
preservation, not user space preservation.

Recent fun presentation on oomd2, a user space oom manager.
https://cfp.all-systems-go.io/ASG2019/talk/DQX3DH/


> - Upon reboot, the system boots OK but now btrfs is throwing zillions
> of checksum errors.  After some time the filesystem is remounted
> readonly and I lose the ability to interact with the system at all, so
> it gets powered off.
>
> - Now the filesystem is unmountable.

The transid errors look like they might be caused by the 5.2 regression
https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u

Fixed since 5.2.15 and 5.3.0.

So if you're willing to blow shit up again, you can try to reproduce
with one of those.

I was also doing oomkiller blow shit up tests a few weeks ago with
these same problem kernels and never hit this bug, or any others. I
also had to do a LOT of force power offs because the system just
became totally wedged in and I had no way of estimating how long it
would be for recovery so after 30 minutes I hit the power button. Many
times. Zero corruptions. That's with a single Samsung 840 EVO in a
laptop relegated to such testing.


> # mount -o ro /dev/mapper/fucked /mnt/fucked

Haha.


> [  347.511704] BTRFS error (device dm-0): error loading props for ino
> 721 (root 1): -5
> [  347.551471] BTRFS: error (device dm-0) in
> __btrfs_prealloc_file_range:10310: errno=-5 IO failure

Might be a different bug. Not sure. But also, this is with

> [  347.551595] CPU: 3 PID: 1143 Comm: mount Not tainted 4.19.34-1-lts #1

So I don't know how an older kernel will report on the problem caused
by the 5.2 bug.


> [  347.551596] Hardware name: LENOVO 20CMCTO1WW/20CMCTO1WW, BIOS
> N10ET42W (1.21 ) 02/26/2016
> [  347.551610] RIP:
> 0010:btrfs_free_reserved_data_space_noquota+0xd0/0xe0 [btrfs]
> [  347.551612] Code: 6c 55 1b c1 48 8b 7b 08 48 83 c3 18 45 31 c9 4d
> 89 e8 4c 89 f1 4c 89 fa 4c 89 e6 e8 ca c3 af c0 48 8b 03 48 85 c0 75
> dc eb 98 <0f> 0b 31 db eb 89 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
> 00 41
> [  347.551613] RSP: 0018:ffffaafd41fef758 EFLAGS: 00010287
> [  347.551614] RAX: 0000000000000000 RBX: fffffffffffc0000 RCX: 0000000000040000
> [  347.551615] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9087abcf5600
> [  347.551616] RBP: ffff9087abcf5600 R08: 0000000000000369 R09: 0000000000000004
> [  347.551617] R10: ffff9087a02c40d8 R11: ffffffff82861eed R12: ffff90881aa2a000
> [  347.551618] R13: 0000000000040000 R14: 0000000000040000 R15: ffff9087b0299ad0
> [  347.551620] FS:  00007fa67625b780(0000) GS:ffff908825cc0000(0000)
> knlGS:0000000000000000
> [  347.551621] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  347.551622] CR2: 00007f1d33580458 CR3: 00000001aedcc006 CR4: 00000000003606e0
> [  347.551623] Call Trace:
> [  347.551638]  btrfs_free_reserved_data_space+0x4b/0x70 [btrfs]
> [  347.551656]  __btrfs_prealloc_file_range+0x388/0x450 [btrfs]
> [  347.551670]  cache_save_setup+0x1dd/0x3a0 [btrfs]
> [  347.551685]  btrfs_setup_space_cache+0x97/0xc0 [btrfs]
> [  347.551700]  commit_cowonly_roots+0xde/0x2b0 [btrfs]
> [  347.551718]  ? btrfs_qgroup_account_extents+0xbb/0x1d0 [btrfs]
> [  347.551734]  btrfs_commit_transaction+0x2ac/0x890 [btrfs]
> [  347.551752]  btrfs_recover_log_trees+0x38a/0x420 [btrfs]
> [  347.551771]  ? replay_one_dir_item+0x170/0x170 [btrfs]
> [  347.551786]  open_ctree+0x1a21/0x1b60 [btrfs]
> [  347.551798]  btrfs_mount_root+0x656/0x720 [btrfs]
> [  347.551802]  ? bitmap_find_next_zero_area_off+0x3d/0x90
> [  347.551804]  ? cpumask_next+0x16/0x20
> [  347.551807]  ? pcpu_alloc+0x1cb/0x640
> [  347.551810]  mount_fs+0x3b/0x167
> [  347.551813]  vfs_kern_mount.part.11+0x54/0x110
> [  347.551825]  btrfs_mount+0x16f/0x860 [btrfs]
> [  347.551830]  ? path_lookupat.isra.13+0xa6/0x230
> [  347.551832]  ? legitimize_path.isra.9+0x2d/0x60
> [  347.551834]  ? bitmap_find_next_zero_area_off+0x3d/0x90
> [  347.551836]  ? pcpu_alloc_area+0xe2/0x130
> [  347.551838]  ? pcpu_next_unpop+0x37/0x50
> [  347.551840]  ? cpumask_next+0x16/0x20
> [  347.551842]  ? pcpu_alloc+0x1cb/0x640
> [  347.551844]  ? mount_fs+0x3b/0x167
> [  347.551845]  mount_fs+0x3b/0x167
> [  347.551848]  vfs_kern_mount.part.11+0x54/0x110
> [  347.551850]  do_mount+0x1fb/0xc10
> [  347.551852]  ? _copy_from_user+0x37/0x60
> [  347.551854]  ? memdup_user+0x4b/0x70
> [  347.551855]  ksys_mount+0xba/0xd0
> [  347.551857]  __x64_sys_mount+0x21/0x30
> [  347.551860]  do_syscall_64+0x4e/0x100
> [  347.551862]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  347.551864] RIP: 0033:0x7fa6763e568e


I suspect corrupt tree log. You could try zeroing the log and see if
that fixes things. But realistically it suggests things weren't
committed in the proper order. Whether it's a Btrfs bug or a hardware
bug I can't tell.


> [  347.551866] Code: 48 8b 0d d5 17 0c 00 f7 d8 64 89 01 48 83 c8 ff
> c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 a5 00 00
> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a2 17 0c 00 f7 d8 64 89
> 01 48
> [  347.551867] RSP: 002b:00007ffc92d01298 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000a5
> [  347.551868] RAX: ffffffffffffffda RBX: 00005561f6fe4400 RCX: 00007fa6763e568e
> [  347.551869] RDX: 00005561f6fec000 RSI: 00005561f6fe5300 RDI: 00005561f6fe4610
> [  347.551870] RBP: 00007fa67650b1e4 R08: 0000000000000000 R09: 0000000000000000
> [  347.551871] R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> [  347.551872] R13: 0000000000000001 R14: 00005561f6fe4610 R15: 00005561f6fec000
> [  347.551874] ---[ end trace 010db75a59ca54bb ]---
> [  347.556498] BTRFS warning (device dm-0): Skipping commit of aborted
> transaction.
> [  347.556501] BTRFS: error (device dm-0) in cleanup_transaction:1846:
> errno=-5 IO failure
> [  347.557941] BTRFS error (device dm-0): pending csums is 262144
> [  347.557946] BTRFS: error (device dm-0) in btrfs_replay_log:2277:
> errno=-5 IO failure (Failed to recover log tree)
> [  347.790510] BTRFS error (device dm-0): open_ctree failed


Yeah more tree log problems. Thing is, the tree log should get
completely written out to stable media before the next super block
update gets written. And based on the complaints a lot of stuff that
should have been written out is missing.


-- 
Chris Murphy
