Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC01366CD8
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbhDUNaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Apr 2021 09:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240921AbhDUNaG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Apr 2021 09:30:06 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A3C06174A
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Apr 2021 06:29:32 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q136so21780950qka.7
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Apr 2021 06:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Z8wDCMAuJXGtOnYgrJ5SSFxvWpSac6xOsyspaDCBifI=;
        b=vNeQe8iwjcGyHAX/bZUlhAr9KZcwCH3nqeo+FIp1SvhfOAYDcOSX02f3mvCC+cMlNQ
         nkkyawsfAjM3i+Sok7sD1qNXyk6ZbuKgR2+oBMYDgdeNUtA9Wvdx7vYKaLzLBiEB4gDS
         Uh3km57QClftFDLISfTBJ2i9nUoHn0ntlAP4r3U/YdLvaz6hEVs60bpu6pfm06Y+h95k
         2cMM/IlPmSliP7njdBbGIlsEzY4VSLmR/0t9Ihkbw05C4IbankLOwn2hoIWvjeTCZiIM
         iyN8cbJy6SZMRdKpqWnFhaa3LI1Tg3Q7+yKYrDGm3DZp/SlRogrZEghMOZBEo3/ZaSNN
         W6ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Z8wDCMAuJXGtOnYgrJ5SSFxvWpSac6xOsyspaDCBifI=;
        b=XBjnHW+tjnooXFG425NDFqqunTO/MOcS08GO7LvSZVCz/+tNkg2N93U+xby/C9JHBW
         voVlbrZreF+4QrQ5mChv1rnYjBBuHUVOCOdW6eG65XFwnvrYKxNkXKIoog1FcLe5WYlY
         q7DpRp5zqLQ1bddHF6o9EFxaa+DXAxut+hAANGrXHLKtvnpmvO28+Ys3dSNEDlGkiGV1
         /ufiAuZZyOxS6HWgotoQwsB3JuI8utsQh7yJhSCp5ZDPEir88fvaVpPnlT1DYLmbv0mV
         ru4Vrozr9Z5tVprqYVMiTqaXNC/GewubYyt13ar1fln017GPbNSMxl4Omof54u3VtGbM
         9MHg==
X-Gm-Message-State: AOAM530narIcGbt2M2o4Kzs8c/9ryccwFV6meqieYCsHN8KW+SBo4X8C
        1G/slqCv6RqtBywjdjCKFkmhtQlLuEajIuG8LuaP5hyR+vom8nqo
X-Google-Smtp-Source: ABdhPJyIxpFv8WUCbdSpUb+MGmm8eKKxcKlZD3j+t/lVYCldxV60a0dBzLkatRGU9RhJ5vH9qEytk7nyKalaGSnvljs=
X-Received: by 2002:a37:bb04:: with SMTP id l4mr23585712qkf.383.1619011771400;
 Wed, 21 Apr 2021 06:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210421083137.31E3.409509F4@e16-tech.com> <20210421201725.577C.409509F4@e16-tech.com>
In-Reply-To: <20210421201725.577C.409509F4@e16-tech.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 21 Apr 2021 14:29:20 +0100
Message-ID: <CAL3q7H6V+x_Pu=bxTFGsuZLHf2mh_DOcthJx7HCSYCL79rjzxw@mail.gmail.com>
Subject: Re: 'ls /mnt/scratch/' freeze(deadlock?) when run xfstest(btrfs/232)
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 21, 2021 at 2:04 PM Wang Yugui <wangyugui@e16-tech.com> wrote:
>
> Hi,
>
> This is the output of sysrq t/l command.
>
> there seems some unexpected block in the call trace of some btrfs
> threads.
>
> [72747.556262] task:kworker/u81:9   state:D stack:    0 pid:  225 ppid:  =
   2 flags:0x00004000
> [72747.556268] Workqueue: writeback wb_workfn (flush-btrfs-1142)
> [72747.556271] Call Trace:
> [72747.556273]  __schedule+0x296/0x760
> [72747.556277]  schedule+0x3c/0xa0
> [72747.556279]  io_schedule+0x12/0x40
> [72747.556284]  __lock_page+0x13c/0x280
> [72747.556287]  ? generic_file_readonly_mmap+0x70/0x70
> [72747.556325]  extent_write_cache_pages+0x22a/0x440 [btrfs]
> [72747.556331]  ? __set_page_dirty_nobuffers+0xe7/0x160
> [72747.556358]  ? set_extent_buffer_dirty+0x5e/0x80 [btrfs]
> [72747.556362]  ? update_group_capacity+0x25/0x210
> [72747.556366]  ? cpumask_next_and+0x1a/0x20
> [72747.556391]  extent_writepages+0x44/0xa0 [btrfs]
> [72747.556394]  do_writepages+0x41/0xd0
> [72747.556398]  __writeback_single_inode+0x39/0x2a0
> [72747.556403]  writeback_sb_inodes+0x1ea/0x440
> [72747.556407]  __writeback_inodes_wb+0x5f/0xc0
> [72747.556410]  wb_writeback+0x235/0x2b0
> [72747.556414]  ? get_nr_inodes+0x35/0x50
> [72747.556417]  wb_workfn+0x354/0x490
> [72747.556420]  ? newidle_balance+0x2c5/0x3e0
> [72747.556424]  process_one_work+0x1aa/0x340
> [72747.556426]  worker_thread+0x30/0x390
> [72747.556429]  ? create_worker+0x1a0/0x1a0
> [72747.556432]  kthread+0x116/0x130
> [72747.556435]  ? kthread_park+0x80/0x80
> [72747.556438]  ret_from_fork+0x1f/0x30
>
>
> [72747.566958] Workqueue: btrfs-flush_delalloc btrfs_work_helper [btrfs]
> [72747.566961] Call Trace:
> [72747.566964]  __schedule+0x296/0x760
> [72747.566968]  ? finish_wait+0x80/0x80
> [72747.566970]  schedule+0x3c/0xa0
> [72747.566995]  wait_extent_bit.constprop.68+0x13b/0x1c0 [btrfs]
> [72747.566999]  ? finish_wait+0x80/0x80
> [72747.567024]  lock_extent_bits+0x37/0x90 [btrfs]
> [72747.567047]  btrfs_invalidatepage+0x299/0x2c0 [btrfs]
> [72747.567051]  ? find_get_pages_range_tag+0x2cd/0x380
> [72747.567076]  __extent_writepage+0x203/0x320 [btrfs]
> [72747.567102]  extent_write_cache_pages+0x2bb/0x440 [btrfs]
> [72747.567106]  ? update_load_avg+0x7e/0x5f0
> [72747.567109]  ? enqueue_entity+0xf4/0x6f0
> [72747.567134]  extent_writepages+0x44/0xa0 [btrfs]
> [72747.567137]  ? enqueue_task_fair+0x93/0x6f0
> [72747.567140]  do_writepages+0x41/0xd0
> [72747.567144]  __filemap_fdatawrite_range+0xc7/0x100
> [72747.567167]  btrfs_run_delalloc_work+0x17/0x40 [btrfs]
> [72747.567195]  btrfs_work_helper+0xc2/0x300 [btrfs]
> [72747.567200]  process_one_work+0x1aa/0x340
> [72747.567202]  worker_thread+0x30/0x390
> [72747.567205]  ? create_worker+0x1a0/0x1a0
> [72747.567208]  kthread+0x116/0x130
> [72747.567211]  ? kthread_park+0x80/0x80
> [72747.567214]  ret_from_fork+0x1f/0x30
>
>
> [72747.569686] task:fsstress        state:D stack:    0 pid:841421 ppid:8=
41417 flags:0x00000000
> [72747.569689] Call Trace:
> [72747.569691]  __schedule+0x296/0x760
> [72747.569694]  schedule+0x3c/0xa0
> [72747.569721]  try_flush_qgroup+0x95/0x140 [btrfs]
> [72747.569725]  ? finish_wait+0x80/0x80
> [72747.569753]  btrfs_qgroup_reserve_data+0x34/0x50 [btrfs]
> [72747.569781]  btrfs_check_data_free_space+0x5f/0xa0 [btrfs]
> [72747.569804]  btrfs_buffered_write+0x1f7/0x7f0 [btrfs]
> [72747.569810]  ? path_lookupat.isra.48+0x97/0x140
> [72747.569833]  btrfs_file_write_iter+0x81/0x410 [btrfs]
> [72747.569836]  ? __kmalloc+0x16a/0x2c0
> [72747.569839]  do_iter_readv_writev+0x160/0x1c0
> [72747.569843]  do_iter_write+0x80/0x1b0
> [72747.569847]  vfs_writev+0x84/0x140
> [72747.569869]  ? btrfs_file_llseek+0x38/0x270 [btrfs]
> [72747.569873]  do_writev+0x65/0x100
> [72747.569876]  do_syscall_64+0x33/0x40
> [72747.569879]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
>
> [72747.569899] task:fsstress        state:D stack:    0 pid:841424 ppid:8=
41417 flags:0x00004000
> [72747.569903] Call Trace:
> [72747.569906]  __schedule+0x296/0x760
> [72747.569909]  schedule+0x3c/0xa0
> [72747.569936]  try_flush_qgroup+0x95/0x140 [btrfs]

That's the problem, qgroup flushing triggers writeback for an inode
for which we have a page dirtied and locked.
This should fix it:  https://pastebin.com/raw/U9GUZiEf

Try it out and I'll write a changelog later.
Thanks.

> [72747.569940]  ? finish_wait+0x80/0x80
> [72747.569967]  __btrfs_qgroup_reserve_meta+0x36/0x50 [btrfs]
> [72747.569989]  start_transaction+0x279/0x580 [btrfs]
> [72747.570014]  clone_copy_inline_extent+0x332/0x490 [btrfs]
> [72747.570041]  btrfs_clone+0x5b7/0x7a0 [btrfs]
> [72747.570068]  ? lock_extent_bits+0x64/0x90 [btrfs]
> [72747.570095]  btrfs_clone_files+0xfc/0x150 [btrfs]
> [72747.570122]  btrfs_remap_file_range+0x3d8/0x4a0 [btrfs]
> [72747.570126]  do_clone_file_range+0xed/0x200
> [72747.570131]  vfs_clone_file_range+0x37/0x110
> [72747.570134]  ioctl_file_clone+0x7d/0xb0
> [72747.570137]  do_vfs_ioctl+0x138/0x630
> [72747.570140]  __x64_sys_ioctl+0x62/0xc0
> [72747.570143]  do_syscall_64+0x33/0x40
> [72747.570146]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2021/04/21
>
> > Hi,
> >
> > When I run all xfstests on btrfs, it freeze(deadlock?)  on btrfs/232.
> >
> > the output of './check.
> > ....
> > btrfs/231 0s ...  0s
> > btrfs/232 34s ...
> >
> > The os is still response.
> >
> > 'ls /mnt/scratch/' freeze(deadlock?) without any output.
> >
> > 'ps -ef' output something and then freeze. see ps.txt
> > we found no OOPS info in dmesg. see dmesg.txt
> >
> > Any advice to gather more info for troubleshooting?
> > This is a server with ECC memory, and no ECC error deteced. I will keep
> > it for 24 hours for any info gather.
> >
> > The last two patches added to btrfs code are
> >  From:    fdmanana@kernel.org
> >  Date:    Tue, 20 Apr 2021 10:55:12 +0100
> >  Subject: [PATCH] btrfs: fix metadata extent leak after failure to crea=
te subvolume
> >
> >  From:    fdmanana@kernel.org
> >  Date:    Tue, 20 Apr 2021 10:55:44 +0100
> >  Subject: [PATCH] btrfs: fix race when picking most recent mod log oper=
ation for an old root
> >
> > Best Regards
> > Wang Yugui (wangyugui@e16-tech.com)
> > 2021/04/21
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
