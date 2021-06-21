Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C073AE6E0
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 12:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFUKUI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 06:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhFUKUI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 06:20:08 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEFBC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 03:17:53 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id l2so10214918qtq.10
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 03:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=t1VjcrkFj6QJbeVVYBqTJZG/xzW3ZMtg1srKVtucrT4=;
        b=pfFYaBSyaqhFb2xjn3Qa8+xkuPONBJhdh8K23d6zJF9SKbilTG+N9SfLPH8fKpDlip
         IIpCytW61dxpdgiF4MrZ38EI+HiUQ8rl+cIWYSOOdv5S7ln2IMH0gHxcYuGt/jMK99r9
         Flxla3DuyxQpMvJVG+TFdBWKWgFtk7SDsGKv/w9yldit22tjRD0IhuiVH7Lem/kAVK6C
         pxhC5GFY+I5ReVl5KkMK6RgvNLG6H/9EhPWCvijn2GqDu1Dkqoy9soR1HSJq/zYpH+mm
         jtKedAn+IAIjXsv4kXfKcSNYzEeYnXGgSt8fi2AVsGdjjfbJ0xCf+6qq7C786ZzOiyEW
         aAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=t1VjcrkFj6QJbeVVYBqTJZG/xzW3ZMtg1srKVtucrT4=;
        b=riHwmrnk5zdzrU1n2LCDhLEnS2vTMda2w8pNaguxxtFcV3iXLim2N9dRjMiiOB+umM
         WEiqQEccwk4UxlbpmvMX0xiIsj6dVK2pzxTLn3lzBOs6ivjgKBS2/I/+zcpJ9bTGxfrD
         p5EONm4LSMHfIF7j3gp5ofhDnRh/+4IH+DA/qsPaQr2y0fLWQkw/+e93QqEr3e/yBLKX
         GL0YUgwQ9perv7mQuVHcjck2G2VfUtulSibqIk0nIKWhm9QsxJ2xMUXnetHnV9moeKc7
         A6UeOEOUJ2BuVdHZzk1PeEwmXjG/gDd67+LlAkoF9TCpRCaoVgO+FmEgJijVJWZ0IKSC
         rnvw==
X-Gm-Message-State: AOAM5325leJnno0/L7pf+XJgD3V1NDa283VtMwsGLRa/dZHZyja5IFcd
        0TqJup91rdlBPIzKWyu5evYCaotAREKzfFYlZrU=
X-Google-Smtp-Source: ABdhPJxzXWrjn04lS2YhBLcjdIGdSHSEOIakVj2VdVwG2FnrsWpDJPBOfJJYUY2o5AW/tTqmBFz2n28QjvEEja9gmak=
X-Received: by 2002:ac8:6f37:: with SMTP id i23mr23332560qtv.376.1624270672521;
 Mon, 21 Jun 2021 03:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210621015922.ewgbffxuawia7liz@naota-xeon>
In-Reply-To: <20210621015922.ewgbffxuawia7liz@naota-xeon>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 21 Jun 2021 11:17:41 +0100
Message-ID: <CAL3q7H4q2Xjf9m5Ar62BVYJFO+wZSR9yn6wN6xwdtnNfCXDTyQ@mail.gmail.com>
Subject: Re: hung_task issue by wait_event() in check_system_chunk()
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 21, 2021 at 3:03 AM Naohiro Aota <naohiro.aota@wdc.com> wrote:
>
> We recently observed a hung_task issue on our 5.13-rc* test runs
> (without any lockdep warnings!). The code is based on Linux 5.13-rc6 +
> a patch to fix unbalanced unlock in qgroup_account_snapshot() [1] +
> some debug printings. I found the cause of the issue, but I'm not sure
> how we can fix it.
>
> [1] https://lore.kernel.org/linux-btrfs/20210621012114.1884779-1-naohiro.=
aota@wdc.com/T/#u
>
> * Summary:
>
> In btrfs_chunk_alloc(), we set space_info->chunk_alloc =3D 1 before a
> chunk allocation and turn it to 0 after the allocation. We block other
> chunk allocations while space_info->chunk_alloc =3D=3D 1. So, the code
> should be forward-progress while space_info->chunk_alloc =3D=3D 1.
>
> However, commit eafa4fd0ad06 ("btrfs: fix exhaustion of the system
> chunk array due to concurrent allocations") broke the assumption. It
> introduced wait_event() to wait for an ongoing transaction which
> allocated a new chunk to finish. That waiting leads to an invisible
> circular dependency. If the thread that allocated a chunk tries to
> allocate another chunk, it cannot proceed because the wait_event()'ing
> thread set space_info->chunk_alloc =3D 1.

Indeed, thanks for reporting.

>
> We might need to set space_info->chunk_alloc =3D 0 while wait_event()?
> But then we need to recheck everything again from the start of
> btrfs_chunk_alloc()?

I think something slightly simpler might be enough.
It's a bit tricky due to the two stages chunk allocation, but it's a
necessary evil to avoid other type of deadlock.

I'll think about it a bit more and let you know, thanks.

>
> * Full analysis:
>
> # These messages are from check_system_chunk() after "trans->chunk_bytes_=
reserved +=3D thresh;"
> [  905.785876][  T722] 722 add 393216 to transaction 233
> [  905.800494][ T5063] 5063 add 393216 to transaction 233
>
> Thread 722 and 5063 reserved space for its chunk allocation metadata
> on the running transaction.
>
> [  905.806845][ T5070] BTRFS info (device nullb1): left=3D65536, need=3D3=
93216, flags=3D4
> [  905.811547][ T5070] BTRFS info (device nullb1): space_info 2 has 65536=
 free, is not full
> ...
> # This message is from check_system_chunk() before the wait_event()
> [  905.831000][ T5070] waiting for reserved 786432 trans 0 min_needed 393=
216
>
> Now thread 5070 does not have enough SYSTEM space (left=3D65536 <
> need=3D393216) for its chunk allocation. And, since other
> transaction_handle in the same transaction (transaction_handle of
> thread 722 and 5063) already reserved space for them, it now waits for
> them to free their reservation with transaction commit.
>
> [ 1108.499029][   T22] INFO: task kworker/u4:5:721 blocked for more than =
122 seconds.
>
> But, nothing progressed!
>
> So, what is happened with threads 722 and 5063?
>
> Backtrace of thread 722
>
> crash> bt 722
> PID: 722    TASK: ffff888100f80000  CPU: 0   COMMAND: "kworker/u4:6"
>  #0 [ffffc90002467160] __schedule at ffffffff8260da25
>  #1 [ffffc90002467268] preempt_schedule_common at ffffffff8260f635
>  #2 [ffffc90002467288] __cond_resched at ffffffff8260f68d
>  #3 [ffffc90002467298] btrfs_chunk_alloc at ffffffffa03cd50a [btrfs]
>  #4 [ffffc90002467330] find_free_extent at ffffffffa01adfa2 [btrfs]
>  #5 [ffffc900024674f0] btrfs_reserve_extent at ffffffffa01bf7d0 [btrfs]
>  #6 [ffffc90002467580] btrfs_alloc_tree_block at ffffffffa01c074f [btrfs]
>  #7 [ffffc90002467720] alloc_tree_block_no_bg_flush at ffffffffa018d9e5 [=
btrfs]
>  #8 [ffffc90002467780] __btrfs_cow_block at ffffffffa0194fb1 [btrfs]
>  #9 [ffffc900024678d0] btrfs_cow_block at ffffffffa01960b5 [btrfs]
> #10 [ffffc90002467950] btrfs_search_slot at ffffffffa01a15c7 [btrfs]
> #11 [ffffc90002467ac0] btrfs_remove_chunk at ffffffffa027f43c [btrfs]
> #12 [ffffc90002467c50] btrfs_relocate_chunk at ffffffffa0280503 [btrfs]
> #13 [ffffc90002467c88] btrfs_reclaim_bgs_work.cold at ffffffffa040e7b7 [b=
trfs]
> #14 [ffffc90002467c90] __kasan_check_read at ffffffff8167ebf1
> #15 [ffffc90002467d08] process_one_work at ffffffff811ae718
> #16 [ffffc90002467e40] worker_thread at ffffffff811af8de
> #17 [ffffc90002467f08] kthread at ffffffff811c0857
> #18 [ffffc90002467f50] ret_from_fork at ffffffff810034b2
>
> So, here it is. Since check_system_chunk() takes neither
> space_info->lock nor fs_info->chunk_mutex while the waiting, thread
> 722 is in busy-loop to wait for space_info->chunk_alloc =3D=3D 0.
>
>  #3 [ffffc90002467298] btrfs_chunk_alloc at ffffffffa03cd50a [btrfs]
>     /home/naota/src/linux-works/btrfs-zoned/fs/btrfs/block-group.c: 3282
>
> And, how about thread 5063?
>
> crash> bt 5063
> PID: 5063   TASK: ffff8881ca254000  CPU: 0   COMMAND: "fsstress"
>  #0 [ffffc90007d46fd8] __schedule at ffffffff8260da25
>  #1 [ffffc90007d470e0] schedule at ffffffff8260f247
>  #2 [ffffc90007d47110] rwsem_down_read_slowpath at ffffffff82619b9d
>  #3 [ffffc90007d47268] __down_read_common at ffffffff8126492c
>  #4 [ffffc90007d47318] down_read_nested at ffffffff81264da4
>  #5 [ffffc90007d47368] btrfs_read_lock_root_node at ffffffffa02b5007 [btr=
fs]
>  #6 [ffffc90007d47390] btrfs_search_slot at ffffffffa01a181b [btrfs]
>  #7 [ffffc90007d47500] _raw_spin_unlock_irqrestore at ffffffff8262349c
>  #8 [ffffc90007d47550] insert_with_overflow at ffffffffa01c74b9 [btrfs]
>  #9 [ffffc90007d47600] btrfs_insert_dir_item at ffffffffa01c7bff [btrfs]
> #10 [ffffc90007d47738] create_subvol at ffffffffa02a610b [btrfs]
> #11 [ffffc90007d47970] btrfs_mksubvol at ffffffffa02a7829 [btrfs]
> #12 [ffffc90007d47a08] _copy_from_user at ffffffff81b315ab
> #13 [ffffc90007d47a60] btrfs_ioctl_snap_create_v2 at ffffffffa02a832f [bt=
rfs]
> #14 [ffffc90007d47ab8] btrfs_ioctl at ffffffffa02ae668 [btrfs]
> #15 [ffffc90007d47d40] __x64_sys_ioctl at ffffffff8171c09f
> #16 [ffffc90007d47f38] do_syscall_64 at ffffffff82602a70
> #17 [ffffc90007d47f50] entry_SYSCALL_64_after_hwframe at ffffffff8280007c
>
> So, it's contended here:
>
>   #4 [ffffc90007d47318] down_read_nested at ffffffff81264da4
>     ffffc90007d47320: [ffff88811a30bc20:btrfs_extent_buffer] 000000000000=
0000
>     ffffc90007d47330: 0000000000000000 ffffc90007d47360
>     ffffc90007d47340: __btrfs_tree_read_lock+40 [ffff88811a30bc20:btrfs_e=
xtent_buffer]
>     ffffc90007d47350: ffffed102e902800 dffffc0000000000
>     ffffc90007d47360: ffffc90007d47388 btrfs_read_lock_root_node+71
>
> Thread 5063 is trying to read lock this extent buffer.
>
> crash> struct extent_buffer ffff88811a30bc20
> struct extent_buffer {
>   start =3D 1803321344,
> ...
>   lock_owner =3D 5065,
> ...
>
> The lock is owned by thread 5065.
>
> crash> bt 5065
> PID: 5065   TASK: ffff88812a7f0000  CPU: 1   COMMAND: "fsstress"
>  #0 [ffffc90007d66ab0] __schedule at ffffffff8260da25
>  #1 [ffffc90007d66bb8] preempt_schedule_common at ffffffff8260f635
>  #2 [ffffc90007d66bd8] __cond_resched at ffffffff8260f68d
>  #3 [ffffc90007d66be8] btrfs_chunk_alloc at ffffffffa03cd50a [btrfs]
>  #4 [ffffc90007d66c80] find_free_extent at ffffffffa01adfa2 [btrfs]
>  #5 [ffffc90007d66e40] btrfs_reserve_extent at ffffffffa01bf7d0 [btrfs]
>  #6 [ffffc90007d66ed0] btrfs_alloc_tree_block at ffffffffa01c074f [btrfs]
>  #7 [ffffc90007d67070] alloc_tree_block_no_bg_flush at ffffffffa018d9e5 [=
btrfs]
>  #8 [ffffc90007d670d0] __btrfs_cow_block at ffffffffa0194fb1 [btrfs]
>  #9 [ffffc90007d67220] btrfs_cow_block at ffffffffa01960b5 [btrfs]
> #10 [ffffc90007d672a0] btrfs_search_slot at ffffffffa01a15c7 [btrfs]
> #11 [ffffc90007d67410] btrfs_lookup_file_extent at ffffffffa01ca05e [btrf=
s]
> #12 [ffffc90007d674a8] btrfs_drop_extents at ffffffffa0233449 [btrfs]
> #13 [ffffc90007d67738] btrfs_replace_file_extents at ffffffffa023762d [bt=
rfs]
> #14 [ffffc90007d678d8] btrfs_clone at ffffffffa03d674f [btrfs]
> #15 [ffffc90007d67b20] btrfs_extent_same_range at ffffffffa03d6d38 [btrfs=
]
> #16 [ffffc90007d67b68] btrfs_remap_file_range at ffffffffa03d7b68 [btrfs]
> #17 [ffffc90007d67c60] vfs_dedupe_file_range_one at ffffffff8179f58b
> #18 [ffffc90007d67cd0] vfs_dedupe_file_range at ffffffff8179fadd
> #19 [ffffc90007d67d40] __x64_sys_ioctl at ffffffff8171c344
> #20 [ffffc90007d67f38] do_syscall_64 at ffffffff82602a70
> #21 [ffffc90007d67f50] entry_SYSCALL_64_after_hwframe at ffffffff8280007c
>
> Again! Thread 5065 is busy-looping in the same loop in
> btrfs_chunk_alloc().
>
> * How to fix it?
>
> I'm not sure how we can fix it without breaking the original intention
> of commit eafa4fd0ad06. We might need to set space_info->chunk_alloc =3D
> 0 while in the wait_event(). But then, we also need to recheck
> everything from the start of btrfs_chunk_alloc().
>
> Or, we can commit the transaction before another chunk allocation if
> its transaction_handle is waited?
>
> Thanks,



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
