Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CAB30B29A
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 23:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhBAWKF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 17:10:05 -0500
Received: from a4-6.smtp-out.eu-west-1.amazonses.com ([54.240.4.6]:42865 "EHLO
        a4-6.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229530AbhBAWKA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Feb 2021 17:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=pqvuhxtqt36lwjpmqkszlz7wxaih4qwj; d=urbackup.org; t=1612217322;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=DY3AsgJwFVKw2g4Sp80OLxr+WMWr0MX6w3jmnHuNmk8=;
        b=me8WZY+vRPZ2FXE1vbCvTNbPYsuhVVxXKjcleThXkL0Lor6xN4LYRb0FAuLgV0Wd
        vQ/Y2DeZh4xxe+lu7bdLXRrrOPkoJWpS4HNdwnrM2RmgRK0mYSOL4lYQbYQKdcb28ct
        6Lzo4oTovUkduiFBVmIetgVxVTP5MtylvwWV+IQU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1612217322;
        h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=DY3AsgJwFVKw2g4Sp80OLxr+WMWr0MX6w3jmnHuNmk8=;
        b=PD4bUZKR5nxXnzeNw9JM6jiimssjclJdoCyivSdPZftK0lV4asQzIcicpQ20BeXq
        pFsqpGFH1ivmEW8pMbekhlovIcJtme9+luhpud/nSjIGD44tbK2WFXjnF2+JmgnHT21
        VELr0SvBC2fbTyh9MzzBx9UmGd8gMBLS9JDjI/KI=
Subject: Re: ENOSPC in btrfs_run_delayed_refs with 5.10.8
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102017744df8bf8-cbdaa286-cfcc-4f6f-8332-69a98b3a4073-000000@eu-west-1.amazonses.com>
 <CAJCQCtROhiK+pEnS-kdApzkzZtFU1-yOAh5Uyv9hBtpyNJ3qig@mail.gmail.com>
From:   Martin Raiber <martin@urbackup.org>
Message-ID: <010201775fa40c1a-9e433e37-ca1e-4ba8-93c5-2806bf138eb2-000000@eu-west-1.amazonses.com>
Date:   Mon, 1 Feb 2021 22:08:42 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtROhiK+pEnS-kdApzkzZtFU1-yOAh5Uyv9hBtpyNJ3qig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SES-Outgoing: 2021.02.01-54.240.4.6
Feedback-ID: 1.eu-west-1.zKMZH6MF2g3oUhhjaE2f3oQ8IBjABPbvixQzV8APwT0=:AmazonSES
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27.01.2021 22:03 Chris Murphy wrote:
> On Wed, Jan 27, 2021 at 10:27 AM Martin Raiber <martin@urbackup.org> wrote:
>> Hi,
>>
>> seems 5.10.8 still has the ENOSPC issue when compression is used (compress-force=zstd,space_cache=v2):
>>
>> Jan 27 11:02:14  kernel: [248571.569840] ------------[ cut here ]------------
>> Jan 27 11:02:14  kernel: [248571.569843] BTRFS: Transaction aborted (error -28)
>> Jan 27 11:02:14  kernel: [248571.569845] BTRFS: error (device dm-0) in add_to_free_space_tree:1039: errno=-28 No space left
>> Jan 27 11:02:14  kernel: [248571.569848] BTRFS info (device dm-0): forced readonly
>> Jan 27 11:02:14  kernel: [248571.569851] BTRFS: error (device dm-0) in add_to_free_space_tree:1039: errno=-28 No space left
>> Jan 27 11:02:14  kernel: [248571.569852] BTRFS: error (device dm-0) in __btrfs_free_extent:3270: errno=-28 No space left
>> Jan 27 11:02:14  kernel: [248571.569854] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2191: errno=-28 No space left
>> Jan 27 11:02:14  kernel: [248571.569898] WARNING: CPU: 3 PID: 21255 at fs/btrfs/free-space-tree.c:1039 add_to_free_space_tree+0xe8/0x130
>> Jan 27 11:02:14  kernel: [248571.569913] BTRFS: error (device dm-0) in __btrfs_free_extent:3270: errno=-28 No space left
>> Jan 27 11:02:14  kernel: [248571.569939] Modules linked in:
>> Jan 27 11:02:14  kernel: [248571.569966] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2191: errno=-28 No space left
>> Jan 27 11:02:14  kernel: [248571.569992]  bfq zram bcache crc64 loop dm_crypt xfs dm_mod st sr_mod cdrom nf_tables nfnetlink iptable_filter bridge stp llc intel_powerclamp coretemp k$
>> Jan 27 11:02:14  kernel: [248571.570075] CPU: 3 PID: 21255 Comm: kworker/u50:22 Tainted: G          I       5.10.8 #1
>> Jan 27 11:02:14  kernel: [248571.570076] Hardware name: Dell Inc. PowerEdge R510/0DPRKF, BIOS 1.13.0 03/02/2018
>> Jan 27 11:02:14  kernel: [248571.570079] Workqueue: events_unbound btrfs_async_reclaim_metadata_space
>> Jan 27 11:02:14  kernel: [248571.570081] RIP: 0010:add_to_free_space_tree+0xe8/0x130
>> Jan 27 11:02:14  kernel: [248571.570082] Code: 55 50 f0 48 0f ba aa 40 0a 00 00 02 72 22 83 f8 fb 74 4c 83 f8 e2 74 47 89 c6 48 c7 c7 b8 39 49 82 89 44 24 04 e8 8a 99 4a 00 <0f> 0b 8$
>> Jan 27 11:02:14  kernel: [248571.570083] RSP: 0018:ffffc90009c57b88 EFLAGS: 00010282
>> Jan 27 11:02:14  kernel: [248571.570084] RAX: 0000000000000000 RBX: 0000000000004000 RCX: 0000000000000027
>> Jan 27 11:02:14  kernel: [248571.570085] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffff888617a58b88
>> Jan 27 11:02:14  kernel: [248571.570086] RBP: ffff8889ecb874e0 R08: ffff888617a58b80 R09: 0000000000000000
>> Jan 27 11:02:14  kernel: [248571.570087] R10: 0000000000000001 R11: ffffffff822372e0 R12: 0000005741510000
>> Jan 27 11:02:14  kernel: [248571.570087] R13: ffff8884e05727e0 R14: ffff88815ae4fc00 R15: ffff88815ae4fdd8
>> Jan 27 11:02:14  kernel: [248571.570088] FS:  0000000000000000(0000) GS:ffff888617a40000(0000) knlGS:0000000000000000
>> Jan 27 11:02:14  kernel: [248571.570089] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Jan 27 11:02:14  kernel: [248571.570090] CR2: 00007eb4a3a4f00a CR3: 000000000260a005 CR4: 00000000000206e0
>> Jan 27 11:02:14  kernel: [248571.570091] Call Trace:
>> Jan 27 11:02:14  kernel: [248571.570097]  __btrfs_free_extent.isra.0+0x56a/0xa10
>> Jan 27 11:02:14  kernel: [248571.570100]  __btrfs_run_delayed_refs+0x659/0xf20
>> Jan 27 11:02:14  kernel: [248571.570102]  btrfs_run_delayed_refs+0x73/0x200
>> Jan 27 11:02:14  kernel: [248571.570103]  flush_space+0x4e8/0x5e0
>> Jan 27 11:02:14  kernel: [248571.570105]  ? btrfs_get_alloc_profile+0x66/0x1b0
>> Jan 27 11:02:14  kernel: [248571.570106]  ? btrfs_get_alloc_profile+0x66/0x1b0
>> Jan 27 11:02:14  kernel: [248571.570107]  btrfs_async_reclaim_metadata_space+0x107/0x3a0
>> Jan 27 11:02:14  kernel: [248571.570111]  process_one_work+0x1b6/0x350
>> Jan 27 11:02:14  kernel: [248571.570112]  worker_thread+0x50/0x3b0
>> Jan 27 11:02:14  kernel: [248571.570114]  ? process_one_work+0x350/0x350
>> Jan 27 11:02:14  kernel: [248571.570116]  kthread+0xfe/0x140
>> Jan 27 11:02:14  kernel: [248571.570117]  ? kthread_park+0x90/0x90
>> Jan 27 11:02:14  kernel: [248571.570120]  ret_from_fork+0x22/0x30
>> Jan 27 11:02:14  kernel: [248571.570122] ---[ end trace 568d2f30de65b1c0 ]---
>> Jan 27 11:02:14  kernel: [248571.570123] BTRFS: error (device dm-0) in add_to_free_space_tree:1039: errno=-28 No space left
>> Jan 27 11:02:14  kernel: [248571.570151] BTRFS: error (device dm-0) in __btrfs_free_extent:3270: errno=-28 No space left
>> Jan 27 11:02:14  kernel: [248571.570178] BTRFS: error (device dm-0) in btrfs_run_delayed_refs:2191: errno=-28 No space left
>>
>>
>> btrfs fi usage:
>>
>> Overall:
>>     Device size:                 931.49GiB
>>     Device allocated:            931.49GiB
>>     Device unallocated:            1.00MiB
>>     Device missing:                  0.00B
>>     Used:                        786.39GiB
>>     Free (estimated):            107.69GiB      (min: 107.69GiB)
>>     Data ratio:                       1.00
>>     Metadata ratio:                   1.00
>>     Global reserve:              512.00MiB      (used: 0.00B)
>>     Multiple profiles:                  no
>>
>> Data,single: Size:884.48GiB, Used:776.79GiB (87.82%)
>>    /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533  884.48GiB
>>
>> Metadata,single: Size:47.01GiB, Used:9.59GiB (20.41%)
>>    /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533   47.01GiB
>>
>> System,single: Size:4.00MiB, Used:144.00KiB (3.52%)
>>    /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533    4.00MiB
>>
>> Unallocated:
>>    /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533    1.00MiB
> Can you mount or remount with enospc_debug, and reproduce the problem?
> That'll include some debug info that might be helpful to a developing
> coming across this report. Also it might help:
>
> cd /sys/fs/btrfs/$UUID/allocation
> grep -R .
>
> And post that too. The $UUID is the file system UUID for this specific
> file system, as reported by blkid or lsblk -f.
>
Disabled compression, but ENOSPC still occurs (Compared with 5.4 where there is only a ENOSPC issue when compression is used). Here is the kernel log with enospc_debug:

https://gist.github.com/uroni/357b9904294898658eba9d9fca1f3a39

Machine was rebooted before I could print the allocations.

Now I'm trying if the problem goes away with space_cache=v1 (since it is __add_to_free_space_tree that fails with ENOSPC).

