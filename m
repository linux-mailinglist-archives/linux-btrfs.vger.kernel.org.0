Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF16176F489
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 23:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjHCVP1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 17:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjHCVPZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 17:15:25 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C281949FA
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 14:14:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id E32B3320051E;
        Thu,  3 Aug 2023 17:14:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 03 Aug 2023 17:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1691097290; x=1691183690; bh=Bc
        GzdI7YJuaFni4NeXkF8aJ5uLK7XWc7dX/115J6jFQ=; b=Nn56++T50XKySEjM9n
        PXiyTBx+fAe5h1ZCCmk8DueVrMAGbVjQv2TlLQMyGkhBzBgRiIHdDuhKBXCGe1+I
        WtHX2I6x13doJqxW/HZGE/T1CK3XJXXWQY3BIBauxAXDqF9hw79QYCpio8On5G58
        CyTu4epKQ2iGCrlr96xIYRKm5Bh6fpO05cAROVgNJwWBkGSBZ6FI+eqUIiw3UsPb
        MSFjTfqD2CSYHvt5AYwMD/99bshsBWbX1es5kgY1Zi/mdcLKc6j/4X2xUA6C4paX
        4F3aCL/kGhBLYTqSqYL8TAaPXlKlYFRltJAFvz4aX4UGOpBLy9WKqXuuxeBsd5io
        RVWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1691097290; x=1691183690; bh=BcGzdI7YJuaFn
        i4NeXkF8aJ5uLK7XWc7dX/115J6jFQ=; b=dRg+SoG6CzljmUChXEPv0sQK8/Fnc
        A39wdAkyM+TUgDbeQwQ9nE48/EUmA263ixNFYc0X5UKcqtPtzwj2NBQ5zDHKK3sY
        hBO6ssZXitkT8GIv9FOq8H/J9gIFDLu1f29Bj6Go10zKK8E/mDfPfSqir81N4WpY
        W3ZybHIaAH0e+YkDjXjlmKlUj5txF1OccX2n2n/RCMxpCEN3xLxhfzE3zO2EizCg
        LRdBzkhhs8S8UqNhnW0vRib4hPSzYPI6wqWYK+Ab9EboMp+rgKaopYA+l1YDzJes
        rk9rth/Gx7lU8aPEDL4v0GXr6wair118+qIUA890vqxePdSc9FyiaQ+Ng==
X-ME-Sender: <xms:yhjMZFY0Fb4ayuuXx88S5W3gkpKmN83VlAFuVUidIEypzjEr6acLvQ>
    <xme:yhjMZMaoShcisv8uto3puxZJZ9qZe-6QouOvQ5A0DCk87XoZdH4MVuM2Nign-HMZ4
    R9E1xiSFHQfD7SvZaw>
X-ME-Received: <xmr:yhjMZH8YVEBA0Ps0cYwI-61tUdiASgvYc3OgungH4NP4HUR2s7vx2TIfe1EEekrkvqBePlzPkvisqPC1uraXnjEd0j0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrkedvgdduheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehorhhi
    shcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenucggtffrrghtthgvrhhnpe
    efueelieduieefgedvffejudevgfeiffefueelfedvgeegtedtteejjedvtdetkeenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmpdhrvgguhhgrthdrtghomhdpkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    sghorhhishessghurhdrihho
X-ME-Proxy: <xmx:yhjMZDr0x-06dBFv2q8dlc6LtZnaQrrYEjnISxBChQnLmv_S5GeDow>
    <xmx:yhjMZArdSpFM4HLuCIe62H3bq3_zgn-S3RsLOGS-ysoQUoFdVOFyIw>
    <xmx:yhjMZJS1lRFDh-nixkbLRa0SGn8DAtbQSUTeKIqlrN94x8sDROieGg>
    <xmx:yhjMZHQmthkCH__nZZX__op27OxLsqhzvkO-GjNrLU8KZkp2xK5t9Q>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Aug 2023 17:14:49 -0400 (EDT)
Date:   Thu, 3 Aug 2023 14:12:58 -0700
From:   Boris Burkov <boris@bur.io>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: permanently wedged in filesystem, fs/btrfs/relocation.c:1937
 prepare_to_merge
Message-ID: <20230803211258.GA3669918@zen>
References: <a44b85f5-01b5-40d5-a067-883d9223366a@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a44b85f5-01b5-40d5-a067-883d9223366a@app.fastmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 20, 2023 at 09:42:37AM -0400, Chris Murphy wrote:
> kernel 6.3.12
> btrfs-progs 6.3.2
> 
> User reports converting from metadata single to dup, which fails midway through and goes read-only. Following a reboot the file system progressively reports no free space even though `btrfs fi us` reports plenty of unused space in all block groups (but no unallocated space).
> 
> We were able to capture some information about file system state, but ordinary filtered balance measures failed so the user reformatted.

Thank you for the report. This looks like the "usual" data
fragmentation/overallocation issue.

There are a few aspects to this:
1. Not letting data allocations use up all the unallocated space.
2. Not hitting ENOSPC until we absolutely must, should we get into that
state.
3. Beating back fragmentation and maintaining healthy unallocated space.

1. is close to intractable in general. I have some ideas for how to make
btrfs leave enough buffer, but it gets complicated on edge cases where
metadata runs away (rather than data) and I haven't had time to pursue
them.

2. is very tricky and while interesting, not the most helpful in the
short term, so I will focus on 3.

The btrfs allocator is far from perfect and despite a few measures that
attempt to prevent fragmentation, it can still happen. If you have a
system that reproduces this, you can consider using the scripts I wrote
here: https://github.com/josefbacik/fsperf/tree/master/src/frag to dump
the fragmentation level of the FS (and even visualize it) to confirm my
hypothesis. I'm happy to help you get that up and running.

Now let's suppose you do have a workload that challenges our allocator,
fragments the data block groups, and chews through all the unallocated
space. We have a lot of those at Meta, so luckily, there is some relief
available.

Fundamentally the remediation is to defragment the disk, which we do
do with data block group balancing. You can invoke this manually with:
`btrfs balance start -d<thresh> <fs>`
where <thresh> is a percentage fullness of data block_groups to target
with balancing. Lower is more conservative so you can start low and
increase it to 80 or so till you reclaim enough space. If you use that,
it's better to do it proactively periodically rather than after you get
stuck, 'cause as you saw, balances start failing with ENOSPC too.
(see point 2. above :))

Balance also has a "limit" parameter which you can use to avoid
rewriting the whole disk every time you balance if you have too high of
a threshold. Each block group is 1G, so you can use that info to pick a
good limit (and generally judge how much extra re-writing you're doing)

Alternatively, and this is what we've been doing with some success at
Meta, you can use autorelocation, which does the balancing inline in the
kernel as a block group gets space freed from it. The algorithm is a bit
naive and doesn't try too hard to account for how fragmented the block
groups are before balancing them, so it may do too much I/O. YMMV.
To try that, you can use the sysfs knob:
/sys/fs/btrfs/<uuid>/bg_reclaim_threshold

That is the percentage value a bg has to drop below on a free that puts
it on a balance list (similar to that -d<thresh> parameter). If it's 0,
no autorelocation will occur, if it's too high, you might not be hitting
that fullness on block groups to then sink below it. (e.g., if it's 75 a
free that takes you from 50->49 will not trigger a balance). At Meta, we
use 30 which is somewhat aggressive. You will know it's working when 1)
your unallocated space goes up and 2) by dmesg logs reading:
'relocating block group <offset> flags data'
showing up.

Hope that's helpful, and let me know if there is any other assistance I
can provide,
Boris

> 
> Downstream bug report
> https://bugzilla.redhat.com/show_bug.cgi?id=2224346
> 
> 
>  BTRFS info (device sda1): balance: start -mconvert=dup -sconvert=dup
>  BTRFS info (device sda1): relocating block group 83480281088 flags metadata
>  ------------[ cut here ]------------
>  BTRFS: Transaction aborted (error -28)
>  WARNING: CPU: 1 PID: 180121 at fs/btrfs/relocation.c:1937 prepare_to_merge+0x41f/0x430
>  Modules linked in: [snipped]
>  CPU: 1 PID: 180121 Comm: btrfs Not tainted 6.3.12-100.fc37.x86_64 #1
>  Hardware name: Dell Inc. Latitude E6500                  /0PP476, BIOS A29 06/04/2013
>  RIP: 0010:prepare_to_merge+0x41f/0x430
>  Code: ad e8 75 e1 04 00 eb e0 44 89 f6 48 c7 c7 b8 8e 90 ad e8 a4 07 ab ff 0f 0b eb b4 44 89 f6 48 c7 c7 b8 8e 90 ad e8 91 07 ab ff <0f> 0b eb ba e8 38 be 93 00 0f 1f 84 00 00 00 00 00 90 90 90 90 90
>  RSP: 0018:ffffb6a64b387af8 EFLAGS: 00010282
>  RAX: 0000000000000000 RBX: ffff9ac5cc749000 RCX: 0000000000000027
>  RDX: ffff9ac617d21548 RSI: 0000000000000001 RDI: ffff9ac617d21540
>  RBP: ffff9ac5004e0680 R08: 0000000000000000 R09: ffffb6a64b387988
>  R10: 0000000000000003 R11: ffffffffae146108 R12: 00000000ffffffe4
>  R13: ffff9ac50a5f7000 R14: 00000000ffffffe4 R15: ffff9ac4a3464358
>  FS:  00007f0d6fc1b900(0000) GS:ffff9ac617d00000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000c0010a9008 CR3: 000000001a196000 CR4: 00000000000406e0
>  Call Trace:
>   <TASK>
>   ? prepare_to_merge+0x41f/0x430
>   ? __warn+0x81/0x130
>   ? prepare_to_merge+0x41f/0x430
>   ? report_bug+0x171/0x1a0
>   ? prb_read_valid+0x1b/0x30
>   ? handle_bug+0x41/0x70
>   ? exc_invalid_op+0x17/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? prepare_to_merge+0x41f/0x430
>   ? prepare_to_merge+0x41f/0x430
>   relocate_block_group+0x130/0x500
>   btrfs_relocate_block_group+0x296/0x430
>   btrfs_relocate_chunk+0x3f/0x160
>   btrfs_balance+0x905/0x1390
>   ? __kmem_cache_alloc_node+0x187/0x320
>   ? btrfs_ioctl+0x2435/0x2640
>   btrfs_ioctl+0x224e/0x2640
>   ? ioctl_has_perm.constprop.0.isra.0+0xdd/0x140
>   __x64_sys_ioctl+0x94/0xd0
>   do_syscall_64+0x5f/0x90
>   ? exit_to_user_mode_prepare+0x188/0x1f0
>   ? syscall_exit_to_user_mode+0x1b/0x40
>   ? do_syscall_64+0x6b/0x90
>   ? syscall_exit_to_user_mode+0x1b/0x40
>   ? do_syscall_64+0x6b/0x90
>   ? syscall_exit_to_user_mode+0x1b/0x40
>   ? do_syscall_64+0x6b/0x90
>   ? exc_page_fault+0x74/0x170
>   entry_SYSCALL_64_after_hwframe+0x72/0xdc
>  RIP: 0033:0x7f0d6fd66d6f
>  Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 18 48 8b 44 24 18 64 48 2b 04 25 28 00 00
>  RSP: 002b:00007fff3c9bc290 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f0d6fd66d6f
>  RDX: 00007fff3c9bc390 RSI: 00000000c4009420 RDI: 0000000000000003
>  RBP: 0000000000000000 R08: 0000000000000004 R09: 0000000000000073
>  R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff3c9be3f4
>  R13: 00007fff3c9bc390 R14: 0000000000000001 R15: 0000000000000000
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
>  BTRFS info (device sda1: state A): dumping space info:
>  BTRFS info (device sda1: state A): space_info DATA has 22002716672 free, is not full
>  BTRFS info (device sda1: state A): space_info total=51514441728, used=29511708672, pinned=0, reserved=0, may_use=16384, readonly=0 zone_unusable=0
>  BTRFS info (device sda1: state A): space_info METADATA has 242122752 free, is full
>  BTRFS info (device sda1: state A): space_info total=2632974336, used=1418067968, pinned=53788672, reserved=5505024, may_use=365117440, readonly=548372480 zone_unusable=0
>  BTRFS info (device sda1: state A): space_info SYSTEM has 39829504 free, is not full
>  BTRFS info (device sda1: state A): space_info total=39845888, used=16384, pinned=0, reserved=0, may_use=0, readonly=0 zone_unusable=0
>  BTRFS info (device sda1: state A): global_block_rsv: size 107692032 reserved 107692032
>  BTRFS info (device sda1: state A): trans_block_rsv: size 0 reserved 0
>  BTRFS info (device sda1: state A): chunk_block_rsv: size 0 reserved 0
>  BTRFS info (device sda1: state A): delayed_block_rsv: size 655360 reserved 655360
>  BTRFS info (device sda1: state A): delayed_refs_rsv: size 2482503680 reserved 254541824
>  BTRFS: error (device sda1: state A) in prepare_to_merge:1937: errno=-28 No space left
>  BTRFS info (device sda1: state EA): forced readonly
>  BTRFS info (device sda1: state EA): balance: ended with status: -30
> 
> # btrfs fi usage /btrfs_root/sda1
> Overall:
>     Device size:                  50.92GiB
>     Device allocated:             50.92GiB
>     Device unallocated:            1.00MiB
>     Device missing:                  0.00B
>     Device slack:                    0.00B
>     Used:                         29.20GiB
>     Free (estimated):             20.49GiB      (min: 20.49GiB)
>     Free (statfs, df):            20.49GiB
>     Data ratio:                       1.00
>     Metadata ratio:                   1.18
>     Global reserve:              102.70MiB      (used: 0.00B)
>     Multiple profiles:                 yes      (metadata, system)
> 
> Data,single: Size:47.98GiB, Used:27.48GiB (57.29%)
>    /dev/sda1      47.98GiB
> 
> Metadata,single: Size:2.00GiB, Used:943.66MiB (46.08%)
>    /dev/sda1       2.00GiB
> 
> Metadata,DUP: Size:463.00MiB, Used:408.33MiB (88.19%)
>    /dev/sda1     926.00MiB
> 
> System,single: Size:32.00MiB, Used:0.00B (0.00%)
>    /dev/sda1      32.00MiB
> 
> System,DUP: Size:6.00MiB, Used:16.00KiB (0.26%)
>    /dev/sda1      12.00MiB
> 
> Unallocated:
>    /dev/sda1       1.00MiB
> 
> 
> sysfs
> 
> allocation/metadata/disk_used:1917665280
> allocation/metadata/bytes_pinned:0
> allocation/metadata/chunk_size:1073741824
> allocation/metadata/bytes_used:1051197440
> allocation/metadata/bg_reclaim_threshold:0
> allocation/metadata/size_classes:none 0
> allocation/metadata/size_classes:small 0
> allocation/metadata/size_classes:medium 0
> allocation/metadata/size_classes:large 0
> allocation/metadata/single/used_bytes:184729600
> allocation/metadata/single/total_bytes:2147483648
> allocation/metadata/dup/used_bytes:866467840
> allocation/metadata/dup/total_bytes:972029952
> allocation/metadata/disk_total:4091543552
> allocation/metadata/total_bytes:3119513600
> allocation/metadata/bytes_reserved:0
> allocation/metadata/bytes_readonly:1962754048
> allocation/metadata/bytes_zone_unusable:0
> allocation/metadata/bytes_may_use:105512960
> allocation/metadata/flags:4
> allocation/system/disk_used:32768
> allocation/system/bytes_pinned:0
> allocation/system/chunk_size:33554432
> allocation/system/bytes_used:16384
> allocation/system/bg_reclaim_threshold:0
> allocation/system/size_classes:none 0
> allocation/system/size_classes:small 0
> allocation/system/size_classes:medium 0
> allocation/system/size_classes:large 0
> allocation/system/dup/used_bytes:16384
> allocation/system/dup/total_bytes:67108864
> allocation/system/disk_total:134217728
> allocation/system/total_bytes:67108864
> allocation/system/bytes_reserved:0
> allocation/system/bytes_readonly:0
> allocation/system/bytes_zone_unusable:0
> allocation/system/bytes_may_use:0
> allocation/system/flags:2
> allocation/global_rsv_reserved:105512960
> allocation/data/disk_used:29451214848
> allocation/data/bytes_pinned:0
> allocation/data/chunk_size:10737418240
> allocation/data/bytes_used:29451214848
> allocation/data/bg_reclaim_threshold:0
> allocation/data/size_classes:none 5
> allocation/data/size_classes:small 32
> allocation/data/size_classes:medium 7
> allocation/data/size_classes:large 5
> allocation/data/single/used_bytes:29451214848
> allocation/data/single/total_bytes:50453282816
> allocation/data/disk_total:50453282816
> allocation/data/total_bytes:50453282816
> allocation/data/bytes_reserved:0
> allocation/data/bytes_readonly:0
> allocation/data/bytes_zone_unusable:0
> allocation/data/bytes_may_use:0
> allocation/data/flags:1
> allocation/global_rsv_size:105512960
> 
> Looks similar to this: 
> https://lore.kernel.org/lkml/000000000000a3d67705ff730522@google.com/T/
> 
> 
> 
