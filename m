Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C43EAFF59
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2019 16:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbfIKO5O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 11 Sep 2019 10:57:14 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:33465 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfIKO5O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 11 Sep 2019 10:57:14 -0400
Received: by mail-vk1-f195.google.com with SMTP id q186so4414572vkb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2019 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PD2KVz2mqCf8bFQ8vEqyrLZ7qEkcZHdBCSPD7Be49vM=;
        b=G65n9udtVQ6KLKuYYBF6wuHO/CKOKL40nK1AArtGfS1/Ogq16Yj9FWrJCzp9wZYGqD
         OBoxuzXdBPv88Tt7g8v6U7Y0KR5ieFLZRmBDkD7kz1mGYSm5PECO5ynBj73HS89s+SbT
         2r8ST+MoEYOGcMzrNSIIVzbIMAauh8z8mYXRv/Nx1+WePYCVhKPIG/rPAXL3F7kIOa+c
         dZNyZFg0M8DS0bAbU7n+Ltr8UPDOozHtv0ejVYSRb7kcYkQJrJVrU+pK8WIOg/6H0G9S
         9+4SZehqbJYG9nbHI3SXJUKbQmJ8sX1wiLm8Teq0HXSD6e3EAncuvnIsg+RlbcnGV34P
         qgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PD2KVz2mqCf8bFQ8vEqyrLZ7qEkcZHdBCSPD7Be49vM=;
        b=KL9YUvHZNllnilLp9/RoPFPmrA38QyjXaI0NVHQNV4acAu0Bkw2+BmQhFZaE6YsOZ9
         QSTIJoQmPBhsShRujqbiLiljN1RwyX2W48vs1jHrmqyurNur+pwFjERBuZVmvOs3O3zJ
         ll7e7u8mrnlLUc8AecFiRSftT1DLSufLheCqqAOe0HCAMKWP/qdfn12GEIlIFTUhU+pJ
         t7gCjexL7Vo3KVXcLAvKjdzCuzyOCSixG8lHsexhJ8f4u9tTWnnYPlGgDVWuDveqGE07
         Xw+8a288dQF9JGlrQiX4qFaMQK31aodSGhps6P9+u2xtgvU5rJOtcmmMufkDyLA8K/s7
         XiyQ==
X-Gm-Message-State: APjAAAWvrH4ilFvjWnPw3Hf51JzP2YR5hFw22DvYbh/ikm0bV1tHqPwe
        IBGFalhpPGqfocniMkB11dTwaBVVpmm5u0G4z8A=
X-Google-Smtp-Source: APXvYqw6Tpvf3x2Li9qt5PHUgoqY6afQMg5wjJPyqc/TxfrOBPZr54O5BUeLRgpHlyZlBrBJAS1B1v5TBhKyT2fBVlw=
X-Received: by 2002:a1f:f2cd:: with SMTP id q196mr17034800vkh.31.1568213831994;
 Wed, 11 Sep 2019 07:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <GpO.2yos.3WGDOLpx6t}.1TUDYM@seznam.cz>
In-Reply-To: <GpO.2yos.3WGDOLpx6t}.1TUDYM@seznam.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 11 Sep 2019 15:57:01 +0100
Message-ID: <CAL3q7H7HxFH6fenOUh_KY65_d7hLPrtjfH6EVr+2CKUDEY6PHg@mail.gmail.com>
Subject: Re: task btrfs-transacti:1752 blocked for more than 122 seconds.
To:     Zdenek Sojka <zsojka@seznam.cz>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 11, 2019 at 12:25 PM Zdenek Sojka <zsojka@seznam.cz> wrote:
>
> Hello,
>
> I am getting task hangups from time to time, mostly when doing fstrim or =
dedupe while there is other IO ongoing. The following error triggered while=
 I was doing a fstrim, but it might be unrelated.
>
> When this hangup happens, I am unable to reboot the computer normally; ta=
sks are stuck, and at least some further changes done to the FS are not vis=
ible after (hard) reboot (sysrq+REISUB).
>
> The related dmesg log follows. Hope it helps with btrfs development. I am=
 running with lock debugging enabled. Please let me know if I can provide m=
ore information. I will post output of sysrq+w next time this triggers.
>
>
> Best regards,
> Zdenek Sojka
>
>
>
> [49887.347053] INFO: task btrfs-transacti:1752 blocked for more than 122 =
seconds.
> [49887.347059]       Not tainted 5.2.13-gentoo #2
> [49887.347060] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [49887.347062] btrfs-transacti D    0  1752      2 0x80004000
> [49887.347064] Call Trace:
> [49887.347069]  ? __schedule+0x265/0x830
> [49887.347071]  ? bit_wait+0x50/0x50
> [49887.347072]  ? bit_wait+0x50/0x50
> [49887.347074]  schedule+0x24/0x90
> [49887.347075]  io_schedule+0x3c/0x60
> [49887.347077]  bit_wait_io+0x8/0x50
> [49887.347079]  __wait_on_bit+0x6c/0x80
> [49887.347081]  ? __lock_release.isra.29+0x155/0x2d0
> [49887.347083]  out_of_line_wait_on_bit+0x7b/0x80
> [49887.347084]  ? var_wake_function+0x20/0x20
> [49887.347087]  lock_extent_buffer_for_io+0x28c/0x390
> [49887.347089]  btree_write_cache_pages+0x18e/0x340
> [49887.347091]  do_writepages+0x29/0xb0
> [49887.347093]  ? kmem_cache_free+0x132/0x160
> [49887.347095]  ? convert_extent_bit+0x544/0x680
> [49887.347097]  filemap_fdatawrite_range+0x70/0x90
> [49887.347099]  btrfs_write_marked_extents+0x53/0x120
> [49887.347100]  btrfs_write_and_wait_transaction.isra.4+0x38/0xa0
> [49887.347102]  btrfs_commit_transaction+0x6bb/0x990

It's a regression introduced in 5.2
Fix just sent: https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fd=
manana@kernel.org/T/#u

Thanks.

> [49887.347103]  ? start_transaction+0x33e/0x500
> [49887.347105]  transaction_kthread+0x139/0x15c
> [49887.347106]  kthread+0x147/0x160
> [49887.347108]  ? open_ctree+0x1ee0/0x1ee0
> [49887.347109]  ? __kthread_create_on_node+0x160/0x160
> [49887.347111]  ret_from_fork+0x24/0x30
> [49887.347144] INFO: task mozStorage #2:3504 blocked for more than 122 se=
conds.
> [49887.347145]       Not tainted 5.2.13-gentoo #2
> [49887.347146] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [49887.347147] mozStorage #2   D    0  3504      1 0x00004000
> [49887.347149] Call Trace:
> [49887.347151]  ? __schedule+0x265/0x830
> [49887.347153]  ? btrfs_log_inode_parent+0x382/0xc10
> [49887.347154]  schedule+0x24/0x90
> [49887.347156]  schedule_preempt_disabled+0x5/0x10
> [49887.347158]  __mutex_lock+0x2be/0x8f0
> [49887.347159]  ? btrfs_log_inode_parent+0xb6/0xc10
> [49887.347161]  ? btrfs_log_inode_parent+0x382/0xc10
> [49887.347162]  btrfs_log_inode_parent+0x382/0xc10
> [49887.347164]  ? sched_clock+0x5/0x10
> [49887.347165]  ? sched_clock_cpu+0xc/0xb0
> [49887.347167]  ? __lock_release.isra.29+0x155/0x2d0
> [49887.347169]  ? dget_parent+0x6c/0x270
> [49887.347170]  btrfs_log_dentry_safe+0x45/0x60
> [49887.347172]  btrfs_sync_file+0x1cc/0x410
> [49887.347174]  __x64_sys_fsync+0x51/0xa0
> [49887.347175]  ? lockdep_hardirqs_on+0xef/0x180
> [49887.347177]  do_syscall_64+0x55/0x1c0
> [49887.347179]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [49887.347180] RIP: 0033:0x7f15a181e707
> [49887.347184] Code: Bad RIP value.
> [49887.347185] RSP: 002b:00007f15798fe750 EFLAGS: 00000293 ORIG_RAX: 0000=
00000000004a
> [49887.347187] RAX: ffffffffffffffda RBX: 0000000000000024 RCX: 00007f15a=
181e707
> [49887.347188] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
0000024
> [49887.347189] RBP: 00007f1595e33088 R08: 00007ffd825ca0b0 R09: 00007ffd8=
25ca080
> [49887.347190] R10: 000000000097760e R11: 0000000000000293 R12: 00007f155=
680d3c0
> [49887.347191] R13: 0000000000000010 R14: 00007f158c5e2ed0 R15: 00007f157=
98fe938
> [49887.347197] INFO: task ThreadPoolForeg:24214 blocked for more than 122=
 seconds.
> [49887.347199]       Not tainted 5.2.13-gentoo #2
> [49887.347200] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [49887.347201] ThreadPoolForeg D    0 24214   3614 0x00004000
> [49887.347202] Call Trace:
> [49887.347204]  ? __schedule+0x265/0x830
> [49887.347206]  ? btrfs_log_inode_parent+0xe3/0xc10
> [49887.347207]  schedule+0x24/0x90
> [49887.347209]  schedule_preempt_disabled+0x5/0x10
> [49887.347210]  __mutex_lock+0x2be/0x8f0
> [49887.347212]  ? btrfs_log_inode_parent+0xb6/0xc10
> [49887.347213]  ? btrfs_log_inode_parent+0xe3/0xc10
> [49887.347214]  btrfs_log_inode_parent+0xe3/0xc10
> [49887.347216]  ? sched_clock+0x5/0x10
> [49887.347217]  ? sched_clock_cpu+0xc/0xb0
> [49887.347219]  ? __lock_release.isra.29+0x155/0x2d0
> [49887.347220]  ? dget_parent+0x6c/0x270
> [49887.347222]  btrfs_log_dentry_safe+0x45/0x60
> [49887.347223]  btrfs_sync_file+0x1cc/0x410
> [49887.347224]  __x64_sys_fdatasync+0x41/0x80
> [49887.347226]  ? lockdep_hardirqs_on+0xef/0x180
> [49887.347227]  do_syscall_64+0x55/0x1c0
> [49887.347229]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [49887.347230] RIP: 0033:0x7f32114fbd97
> [49887.347232] Code: Bad RIP value.
> [49887.347233] RSP: 002b:00007f320a9e9f60 EFLAGS: 00000293 ORIG_RAX: 0000=
00000000004b
> [49887.347234] RAX: ffffffffffffffda RBX: 00000000000000ac RCX: 00007f321=
14fbd97
> [49887.347236] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
00000ac
> [49887.347237] RBP: 00007f320a9e9fa0 R08: 0000000000000008 R09: 000000000=
00005c0
> [49887.347238] R10: 0000000000001000 R11: 0000000000000293 R12: 000000000=
0000000
> [49887.347239] R13: 0000000000000000 R14: 0000000000001000 R15: 000000000=
0000000
> [49887.347317]
>                Showing all locks held in the system:
> [49887.347322] 1 lock held by khungtaskd/52:
> [49887.347323]  #0: 00000000c1b69c21 (rcu_read_lock){....}, at: debug_sho=
w_all_locks+0x15/0x169
> [49887.347334] 2 locks held by btrfs-transacti/1752:
> [49887.347335]  #0: 0000000053aca418 (&fs_info->transaction_kthread_mutex=
){+.+.}, at: transaction_kthread+0x43/0x15c
> [49887.347338]  #1: 000000002ab92d01 (&fs_info->tree_log_mutex){+.+.}, at=
: btrfs_commit_transaction+0x44b/0x990
> [49887.347359] 5 locks held by mozStorage #2/3504:
> [49887.347360]  #0: 000000000d2e416a (&sb->s_type->i_mutex_key#7){+.+.}, =
at: btrfs_sync_file+0xd5/0x410
> [49887.347363]  #1: 000000005a0ab1ef (&ei->dio_sem){+.+.}, at: btrfs_sync=
_file+0xf4/0x410
> [49887.347365]  #2: 00000000cf98f4aa (sb_internal){.+.+}, at: start_trans=
action+0x3a8/0x500
> [49887.347368]  #3: 00000000229971f0 (&root->log_mutex){+.+.}, at: btrfs_=
log_inode_parent+0xe3/0xc10
> [49887.347371]  #4: 000000002ab92d01 (&fs_info->tree_log_mutex){+.+.}, at=
: btrfs_log_inode_parent+0x382/0xc10
> [49887.347376] 4 locks held by ThreadPoolForeg/24214:
> [49887.347377]  #0: 00000000fe52cdd5 (&sb->s_type->i_mutex_key#7){+.+.}, =
at: btrfs_sync_file+0xd5/0x410
> [49887.347379]  #1: 000000005d7ce368 (&ei->dio_sem){+.+.}, at: btrfs_sync=
_file+0xf4/0x410
> [49887.347381]  #2: 00000000cf98f4aa (sb_internal){.+.+}, at: start_trans=
action+0x3a8/0x500
> [49887.347384]  #3: 00000000229971f0 (&root->log_mutex){+.+.}, at: btrfs_=
log_inode_parent+0xe3/0xc10
>
> [49887.347426] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> [50010.227100] INFO: task btrfs-transacti:1752 blocked for more than 245 =
seconds.
> [50010.227102]       Not tainted 5.2.13-gentoo #2
> [50010.227103] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [50010.227105] btrfs-transacti D    0  1752      2 0x80004000
> [50010.227107] Call Trace:
> [50010.227112]  ? __schedule+0x265/0x830
> [50010.227114]  ? bit_wait+0x50/0x50
> [50010.227115]  ? bit_wait+0x50/0x50
> [50010.227117]  schedule+0x24/0x90
> [50010.227119]  io_schedule+0x3c/0x60
> [50010.227120]  bit_wait_io+0x8/0x50
> [50010.227122]  __wait_on_bit+0x6c/0x80
> [50010.227124]  ? __lock_release.isra.29+0x155/0x2d0
> [50010.227126]  out_of_line_wait_on_bit+0x7b/0x80
> [50010.227128]  ? var_wake_function+0x20/0x20
> [50010.227130]  lock_extent_buffer_for_io+0x28c/0x390
> [50010.227132]  btree_write_cache_pages+0x18e/0x340
> [50010.227134]  do_writepages+0x29/0xb0
> [50010.227136]  ? kmem_cache_free+0x132/0x160
> [50010.227138]  ? convert_extent_bit+0x544/0x680
> [50010.227140]  filemap_fdatawrite_range+0x70/0x90
> [50010.227142]  btrfs_write_marked_extents+0x53/0x120
> [50010.227144]  btrfs_write_and_wait_transaction.isra.4+0x38/0xa0
> [50010.227145]  btrfs_commit_transaction+0x6bb/0x990
> [50010.227147]  ? start_transaction+0x33e/0x500
> [50010.227148]  transaction_kthread+0x139/0x15c
> [50010.227150]  kthread+0x147/0x160
> [50010.227151]  ? open_ctree+0x1ee0/0x1ee0
> [50010.227153]  ? __kthread_create_on_node+0x160/0x160
> [50010.227154]  ret_from_fork+0x24/0x30
> [50010.227190] INFO: task mozStorage #2:3504 blocked for more than 245 se=
conds.
> [50010.227191]       Not tainted 5.2.13-gentoo #2
> [50010.227192] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [50010.227194] mozStorage #2   D    0  3504      1 0x00004000
> [50010.227195] Call Trace:
> [50010.227198]  ? __schedule+0x265/0x830
> [50010.227199]  ? btrfs_log_inode_parent+0x382/0xc10
> [50010.227201]  schedule+0x24/0x90
> [50010.227203]  schedule_preempt_disabled+0x5/0x10
> [50010.227204]  __mutex_lock+0x2be/0x8f0
> [50010.227206]  ? btrfs_log_inode_parent+0xb6/0xc10
> [50010.227207]  ? btrfs_log_inode_parent+0x382/0xc10
> [50010.227208]  btrfs_log_inode_parent+0x382/0xc10
> [50010.227211]  ? sched_clock+0x5/0x10
> [50010.227213]  ? sched_clock_cpu+0xc/0xb0
> [50010.227214]  ? __lock_release.isra.29+0x155/0x2d0
> [50010.227216]  ? dget_parent+0x6c/0x270
> [50010.227218]  btrfs_log_dentry_safe+0x45/0x60
> [50010.227219]  btrfs_sync_file+0x1cc/0x410
> [50010.227221]  __x64_sys_fsync+0x51/0xa0
> [50010.227222]  ? lockdep_hardirqs_on+0xef/0x180
> [50010.227224]  do_syscall_64+0x55/0x1c0
> [50010.227226]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [50010.227228] RIP: 0033:0x7f15a181e707
> [50010.227231] Code: Bad RIP value.
> [50010.227232] RSP: 002b:00007f15798fe750 EFLAGS: 00000293 ORIG_RAX: 0000=
00000000004a
> [50010.227234] RAX: ffffffffffffffda RBX: 0000000000000024 RCX: 00007f15a=
181e707
> [50010.227235] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
0000024
> [50010.227236] RBP: 00007f1595e33088 R08: 00007ffd825ca0b0 R09: 00007ffd8=
25ca080
> [50010.227237] R10: 000000000097760e R11: 0000000000000293 R12: 00007f155=
680d3c0
> [50010.227238] R13: 0000000000000010 R14: 00007f158c5e2ed0 R15: 00007f157=
98fe938
> [50010.227245] INFO: task ThreadPoolForeg:24214 blocked for more than 245=
 seconds.
> [50010.227246]       Not tainted 5.2.13-gentoo #2
> [50010.227247] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [50010.227248] ThreadPoolForeg D    0 24214   3614 0x00004000
> [50010.227250] Call Trace:
> [50010.227252]  ? __schedule+0x265/0x830
> [50010.227253]  ? btrfs_log_inode_parent+0xe3/0xc10
> [50010.227255]  schedule+0x24/0x90
> [50010.227257]  schedule_preempt_disabled+0x5/0x10
> [50010.227258]  __mutex_lock+0x2be/0x8f0
> [50010.227259]  ? btrfs_log_inode_parent+0xb6/0xc10
> [50010.227261]  ? btrfs_log_inode_parent+0xe3/0xc10
> [50010.227262]  btrfs_log_inode_parent+0xe3/0xc10
> [50010.227263]  ? sched_clock+0x5/0x10
> [50010.227265]  ? sched_clock_cpu+0xc/0xb0
> [50010.227266]  ? __lock_release.isra.29+0x155/0x2d0
> [50010.227268]  ? dget_parent+0x6c/0x270
> [50010.227269]  btrfs_log_dentry_safe+0x45/0x60
> [50010.227270]  btrfs_sync_file+0x1cc/0x410
> [50010.227272]  __x64_sys_fdatasync+0x41/0x80
> [50010.227273]  ? lockdep_hardirqs_on+0xef/0x180
> [50010.227275]  do_syscall_64+0x55/0x1c0
> [50010.227276]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [50010.227277] RIP: 0033:0x7f32114fbd97
> [50010.227279] Code: Bad RIP value.
> [50010.227280] RSP: 002b:00007f320a9e9f60 EFLAGS: 00000293 ORIG_RAX: 0000=
00000000004b
> [50010.227282] RAX: ffffffffffffffda RBX: 00000000000000ac RCX: 00007f321=
14fbd97
> [50010.227283] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
00000ac
> [50010.227284] RBP: 00007f320a9e9fa0 R08: 0000000000000008 R09: 000000000=
00005c0
> [50010.227285] R10: 0000000000001000 R11: 0000000000000293 R12: 000000000=
0000000
> [50010.227286] R13: 0000000000000000 R14: 0000000000001000 R15: 000000000=
0000000
> [50010.227364]
>                Showing all locks held in the system:
> [50010.227369] 1 lock held by khungtaskd/52:
> [50010.227370]  #0: 00000000c1b69c21 (rcu_read_lock){....}, at: debug_sho=
w_all_locks+0x15/0x169
> [50010.227380] 2 locks held by btrfs-transacti/1752:
> [50010.227381]  #0: 0000000053aca418 (&fs_info->transaction_kthread_mutex=
){+.+.}, at: transaction_kthread+0x43/0x15c
> [50010.227384]  #1: 000000002ab92d01 (&fs_info->tree_log_mutex){+.+.}, at=
: btrfs_commit_transaction+0x44b/0x990
> [50010.227403] 5 locks held by mozStorage #2/3504:
> [50010.227404]  #0: 000000000d2e416a (&sb->s_type->i_mutex_key#7){+.+.}, =
at: btrfs_sync_file+0xd5/0x410
> [50010.227408]  #1: 000000005a0ab1ef (&ei->dio_sem){+.+.}, at: btrfs_sync=
_file+0xf4/0x410
> [50010.227411]  #2: 00000000cf98f4aa (sb_internal){.+.+}, at: start_trans=
action+0x3a8/0x500
> [50010.227415]  #3: 00000000229971f0 (&root->log_mutex){+.+.}, at: btrfs_=
log_inode_parent+0xe3/0xc10
> [50010.227419]  #4: 000000002ab92d01 (&fs_info->tree_log_mutex){+.+.}, at=
: btrfs_log_inode_parent+0x382/0xc10
> [50010.227424] 4 locks held by ThreadPoolForeg/10938:
> [50010.227425]  #0: 000000005904b6af (&sb->s_type->i_mutex_key#7){+.+.}, =
at: btrfs_sync_file+0xd5/0x410
> [50010.227428]  #1: 0000000052d60a14 (&ei->dio_sem){+.+.}, at: btrfs_sync=
_file+0xf4/0x410
> [50010.227430]  #2: 00000000cf98f4aa (sb_internal){.+.+}, at: start_trans=
action+0x3a8/0x500
> [50010.227432]  #3: 00000000229971f0 (&root->log_mutex){+.+.}, at: btrfs_=
log_inode_parent+0xe3/0xc10
> [50010.227435] 4 locks held by ThreadPoolForeg/24214:
> [50010.227436]  #0: 00000000fe52cdd5 (&sb->s_type->i_mutex_key#7){+.+.}, =
at: btrfs_sync_file+0xd5/0x410
> [50010.227439]  #1: 000000005d7ce368 (&ei->dio_sem){+.+.}, at: btrfs_sync=
_file+0xf4/0x410
> [50010.227441]  #2: 00000000cf98f4aa (sb_internal){.+.+}, at: start_trans=
action+0x3a8/0x500
> [50010.227443]  #3: 00000000229971f0 (&root->log_mutex){+.+.}, at: btrfs_=
log_inode_parent+0xe3/0xc10
> [50010.227485] 2 locks held by riscv64-unknown/25333:
> [50010.227487] 1 lock held by riscv64-unknown/25348:
>
> [50010.227489] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> [50133.107067] INFO: task btrfs-transacti:1752 blocked for more than 368 =
seconds.
> [50133.107071]       Not tainted 5.2.13-gentoo #2
> [50133.107073] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [50133.107076] btrfs-transacti D    0  1752      2 0x80004000
> [50133.107079] Call Trace:
> [50133.107086]  ? __schedule+0x265/0x830
> [50133.107088]  ? bit_wait+0x50/0x50
> [50133.107090]  ? bit_wait+0x50/0x50
> [50133.107093]  schedule+0x24/0x90
> [50133.107096]  io_schedule+0x3c/0x60
> [50133.107098]  bit_wait_io+0x8/0x50
> [50133.107101]  __wait_on_bit+0x6c/0x80
> [50133.107103]  ? __lock_release.isra.29+0x155/0x2d0
> [50133.107106]  out_of_line_wait_on_bit+0x7b/0x80
> [50133.107109]  ? var_wake_function+0x20/0x20
> [50133.107113]  lock_extent_buffer_for_io+0x28c/0x390
> [50133.107117]  btree_write_cache_pages+0x18e/0x340
> [50133.107120]  do_writepages+0x29/0xb0
> [50133.107123]  ? kmem_cache_free+0x132/0x160
> [50133.107126]  ? convert_extent_bit+0x544/0x680
> [50133.107129]  filemap_fdatawrite_range+0x70/0x90
> [50133.107132]  btrfs_write_marked_extents+0x53/0x120
> [50133.107134]  btrfs_write_and_wait_transaction.isra.4+0x38/0xa0
> [50133.107137]  btrfs_commit_transaction+0x6bb/0x990
> [50133.107139]  ? start_transaction+0x33e/0x500
> [50133.107141]  transaction_kthread+0x139/0x15c
> [50133.107144]  kthread+0x147/0x160
> [50133.107146]  ? open_ctree+0x1ee0/0x1ee0
> [50133.107149]  ? __kthread_create_on_node+0x160/0x160
> [50133.107152]  ret_from_fork+0x24/0x30
> [50133.107198] INFO: task mozStorage #2:3504 blocked for more than 368 se=
conds.
> [50133.107200]       Not tainted 5.2.13-gentoo #2
> [50133.107202] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [50133.107203] mozStorage #2   D    0  3504      1 0x00004000
> [50133.107206] Call Trace:
> [50133.107210]  ? __schedule+0x265/0x830
> [50133.107212]  ? btrfs_log_inode_parent+0x382/0xc10
> [50133.107215]  schedule+0x24/0x90
> [50133.107218]  schedule_preempt_disabled+0x5/0x10
> [50133.107220]  __mutex_lock+0x2be/0x8f0
> [50133.107222]  ? btrfs_log_inode_parent+0xb6/0xc10
> [50133.107224]  ? btrfs_log_inode_parent+0x382/0xc10
> [50133.107226]  btrfs_log_inode_parent+0x382/0xc10
> [50133.107229]  ? sched_clock+0x5/0x10
> [50133.107232]  ? sched_clock_cpu+0xc/0xb0
> [50133.107234]  ? __lock_release.isra.29+0x155/0x2d0
> [50133.107237]  ? dget_parent+0x6c/0x270
> [50133.107240]  btrfs_log_dentry_safe+0x45/0x60
> [50133.107243]  btrfs_sync_file+0x1cc/0x410
> [50133.107246]  __x64_sys_fsync+0x51/0xa0
> [50133.107249]  ? lockdep_hardirqs_on+0xef/0x180
> [50133.107252]  do_syscall_64+0x55/0x1c0
> [50133.107254]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [50133.107257] RIP: 0033:0x7f15a181e707
> [50133.107261] Code: Bad RIP value.
> [50133.107263] RSP: 002b:00007f15798fe750 EFLAGS: 00000293 ORIG_RAX: 0000=
00000000004a
> [50133.107266] RAX: ffffffffffffffda RBX: 0000000000000024 RCX: 00007f15a=
181e707
> [50133.107268] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
0000024
> [50133.107269] RBP: 00007f1595e33088 R08: 00007ffd825ca0b0 R09: 00007ffd8=
25ca080
> [50133.107271] R10: 000000000097760e R11: 0000000000000293 R12: 00007f155=
680d3c0
> [50133.107272] R13: 0000000000000010 R14: 00007f158c5e2ed0 R15: 00007f157=
98fe938
> [50133.107279] INFO: task ThreadPoolForeg:10938 blocked for more than 122=
 seconds.
> [50133.107281]       Not tainted 5.2.13-gentoo #2
> [50133.107282] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [50133.107284] ThreadPoolForeg D    0 10938      1 0x00004000
> [50133.107286] Call Trace:
> [50133.107290]  ? __schedule+0x265/0x830
> [50133.107292]  ? btrfs_log_inode_parent+0xe3/0xc10
> [50133.107294]  schedule+0x24/0x90
> [50133.107297]  schedule_preempt_disabled+0x5/0x10
> [50133.107299]  __mutex_lock+0x2be/0x8f0
> [50133.107302]  ? sched_clock+0x5/0x10
> [50133.107304]  ? sched_clock_cpu+0xc/0xb0
> [50133.107306]  ? btrfs_log_inode_parent+0xb6/0xc10
> [50133.107309]  ? btrfs_log_inode_parent+0xe3/0xc10
> [50133.107310]  btrfs_log_inode_parent+0xe3/0xc10
> [50133.107313]  ? sched_clock+0x5/0x10
> [50133.107315]  ? sched_clock_cpu+0xc/0xb0
> [50133.107317]  ? __lock_release.isra.29+0x155/0x2d0
> [50133.107319]  ? dget_parent+0x6c/0x270
> [50133.107321]  btrfs_log_dentry_safe+0x45/0x60
> [50133.107324]  btrfs_sync_file+0x1cc/0x410
> [50133.107326]  __x64_sys_fdatasync+0x41/0x80
> [50133.107329]  ? lockdep_hardirqs_on+0xef/0x180
> [50133.107331]  do_syscall_64+0x55/0x1c0
> [50133.107333]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [50133.107335] RIP: 0033:0x7f9d48a38d97
> [50133.107338] Code: Bad RIP value.
> [50133.107339] RSP: 002b:00007f9d344732d0 EFLAGS: 00000293 ORIG_RAX: 0000=
00000000004b
> [50133.107342] RAX: ffffffffffffffda RBX: 000000000000011a RCX: 00007f9d4=
8a38d97
> [50133.107343] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000=
000011a
> [50133.107345] RBP: 00007f9d34473350 R08: 0000000000000000 R09: 00007ffd7=
11f8080
> [50133.107347] R10: 00000000009879d2 R11: 0000000000000293 R12: 00007f9d3=
4473310
> [50133.107348] R13: 00007f9d344732f0 R14: 000020d38bece438 R15: 000000000=
0000000
> [50133.107351] INFO: task ThreadPoolForeg:24214 blocked for more than 368=
 seconds.
> [50133.107353]       Not tainted 5.2.13-gentoo #2
> [50133.107354] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [50133.107356] ThreadPoolForeg D    0 24214   3614 0x00004000
> [50133.107358] Call Trace:
> [50133.107361]  ? __schedule+0x265/0x830
> [50133.107363]  ? btrfs_log_inode_parent+0xe3/0xc10
> [50133.107366]  schedule+0x24/0x90
> [50133.107368]  schedule_preempt_disabled+0x5/0x10
> [50133.107370]  __mutex_lock+0x2be/0x8f0
> [50133.107372]  ? btrfs_log_inode_parent+0xb6/0xc10
> [50133.107374]  ? btrfs_log_inode_parent+0xe3/0xc10
> [50133.107376]  btrfs_log_inode_parent+0xe3/0xc10
> [50133.107379]  ? sched_clock+0x5/0x10
> [50133.107381]  ? sched_clock_cpu+0xc/0xb0
> [50133.107383]  ? __lock_release.isra.29+0x155/0x2d0
> [50133.107385]  ? dget_parent+0x6c/0x270
> [50133.107388]  btrfs_log_dentry_safe+0x45/0x60
> [50133.107390]  btrfs_sync_file+0x1cc/0x410
> [50133.107391]  __x64_sys_fdatasync+0x41/0x80
> [50133.107393]  ? lockdep_hardirqs_on+0xef/0x180
> [50133.107395]  do_syscall_64+0x55/0x1c0
> [50133.107397]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [50133.107400] RIP: 0033:0x7f32114fbd97
> [50133.107402] Code: Bad RIP value.
> [50133.107404] RSP: 002b:00007f320a9e9f60 EFLAGS: 00000293 ORIG_RAX: 0000=
00000000004b
> [50133.107406] RAX: ffffffffffffffda RBX: 00000000000000ac RCX: 00007f321=
14fbd97
> [50133.107407] RDX: 0000000000000000 RSI: 0000000000000002 RDI: 000000000=
00000ac
> [50133.107409] RBP: 00007f320a9e9fa0 R08: 0000000000000008 R09: 000000000=
00005c0
> [50133.107411] R10: 0000000000001000 R11: 0000000000000293 R12: 000000000=
0000000
> [50133.107413] R13: 0000000000000000 R14: 0000000000001000 R15: 000000000=
0000000
> [50133.107496]
>                Showing all locks held in the system:
> [50133.107503] 1 lock held by khungtaskd/52:
> [50133.107504]  #0: 00000000c1b69c21 (rcu_read_lock){....}, at: debug_sho=
w_all_locks+0x15/0x169
> [50133.107519] 2 locks held by btrfs-transacti/1752:
> [50133.107520]  #0: 0000000053aca418 (&fs_info->transaction_kthread_mutex=
){+.+.}, at: transaction_kthread+0x43/0x15c
> [50133.107525]  #1: 000000002ab92d01 (&fs_info->tree_log_mutex){+.+.}, at=
: btrfs_commit_transaction+0x44b/0x990
> [50133.107557] 7 locks held by Cache2 I/O/3476:
> [50133.107559]  #0: 000000003db3d26c (sb_writers#3){.+.+}, at: mnt_want_w=
rite+0x17/0x80
> [50133.107564]  #1: 000000002a2f5930 (&type->s_vfs_rename_key){+.+.}, at:=
 lock_rename+0x2a/0x100
> [50133.107569]  #2: 000000001a0603f5 (&type->i_mutex_dir_key#3/1){+.+.}, =
at: lock_rename+0xc1/0x100
> [50133.107574]  #3: 000000004bfe85ee (&type->i_mutex_dir_key#3/5){+.+.}, =
at: lock_rename+0xd6/0x100
> [50133.107579]  #4: 00000000a68a154b (&sb->s_type->i_mutex_key#7/4){+.+.}=
, at: vfs_rename+0x422/0x8b0
> [50133.107583]  #5: 00000000cf98f4aa (sb_internal){.+.+}, at: start_trans=
action+0x3a8/0x500
> [50133.107587]  #6: 00000000229971f0 (&root->log_mutex){+.+.}, at: btrfs_=
pin_log_trans+0x16/0x30
> [50133.107594] 5 locks held by mozStorage #2/3504:
> [50133.107595]  #0: 000000000d2e416a (&sb->s_type->i_mutex_key#7){+.+.}, =
at: btrfs_sync_file+0xd5/0x410
> [50133.107599]  #1: 000000005a0ab1ef (&ei->dio_sem){+.+.}, at: btrfs_sync=
_file+0xf4/0x410
> [50133.107603]  #2: 00000000cf98f4aa (sb_internal){.+.+}, at: start_trans=
action+0x3a8/0x500
> [50133.107607]  #3: 00000000229971f0 (&root->log_mutex){+.+.}, at: btrfs_=
log_inode_parent+0xe3/0xc10
> [50133.107611]  #4: 000000002ab92d01 (&fs_info->tree_log_mutex){+.+.}, at=
: btrfs_log_inode_parent+0x382/0xc10
> [50133.107617] 4 locks held by ThreadPoolForeg/10938:
> [50133.107618]  #0: 000000005904b6af (&sb->s_type->i_mutex_key#7){+.+.}, =
at: btrfs_sync_file+0xd5/0x410
> [50133.107622]  #1: 0000000052d60a14 (&ei->dio_sem){+.+.}, at: btrfs_sync=
_file+0xf4/0x410
> [50133.107625]  #2: 00000000cf98f4aa (sb_internal){.+.+}, at: start_trans=
action+0x3a8/0x500
> [50133.107628]  #3: 00000000229971f0 (&root->log_mutex){+.+.}, at: btrfs_=
log_inode_parent+0xe3/0xc10
> [50133.107633] 4 locks held by ThreadPoolForeg/24214:
> [50133.107634]  #0: 00000000fe52cdd5 (&sb->s_type->i_mutex_key#7){+.+.}, =
at: btrfs_sync_file+0xd5/0x410
> [50133.107638]  #1: 000000005d7ce368 (&ei->dio_sem){+.+.}, at: btrfs_sync=
_file+0xf4/0x410
> [50133.107642]  #2: 00000000cf98f4aa (sb_internal){.+.+}, at: start_trans=
action+0x3a8/0x500
> [50133.107646]  #3: 00000000229971f0 (&root->log_mutex){+.+.}, at: btrfs_=
log_inode_parent+0xe3/0xc10
> [50133.107701] no locks held by riscv64-unknown/19546.
>
> [50133.107705] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
