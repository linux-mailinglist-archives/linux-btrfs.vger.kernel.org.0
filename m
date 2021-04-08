Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB153358BE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Apr 2021 20:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhDHSDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Apr 2021 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbhDHSDM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Apr 2021 14:03:12 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B5C061760
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Apr 2021 11:03:00 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id h7so2131657qtx.3
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Apr 2021 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PUPMjvX3so2GHtyTxUOFsY1H8HIuXlJj8VIq3YbzSFo=;
        b=GyylE/y/TeiTcEV0utxFXTQ8ILqX9jaVa/J5o1w4tiK0Vec8DidwlkeRuSj/yyOv5n
         JGVhtAxFpQrGK+1jEYQ81AtMGWM/aXetvK2/4gjCf+LcNCYQZguvre9da4sCs3TwYppF
         I1aPNzf675vXSVSbGKamWrCNKQMCK0GI3gy+q7KLevjBHeZWEKK7nFs6KVO7tC50bInV
         CRwn7PiRgB/iJrCYMlPru7PkcyUnjbenkPA8TkCBYHVfaziYsvjGFJnmEGGS0j/QkFnM
         cGQmKQcKNE1SFHjTT08JACFeIKDkKQzTHyURZp79eIFol9DQ5uEbdEKuGL1OIq47wIjj
         nLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PUPMjvX3so2GHtyTxUOFsY1H8HIuXlJj8VIq3YbzSFo=;
        b=ctwB/uRo8tmGiQJNKnBZFoBKgZMLxvW98cdsRHwYJ7tcyARIC+IA81j3cCDP5lDhRK
         7cvou+PKnlSITRxdatUmq8JuccQ3eRPYh+R2j6+ofPUhDWHdrVrNpEl7HhADs2xMHrGo
         XF0onhS0A/0Zq1WBT65/98x+KI3fQ4+26bhWMa8y2V14G+MCrdN8EPJl3jVoP/nbDhAI
         RA/89eZPP5hN/jEowX6ltfevW7INNOFFRoRh5/MxC4GDGRm2bte3gEoIViVhuFLKxRcl
         J5S46qdUIh+v3H8tg7UHm3eeQHSDoKsWlxNSSltNvKHmJYq8y0pIdtsm1HDhNuYDvJ+O
         0HRQ==
X-Gm-Message-State: AOAM530GCsC0xRM6Pp1P6DYUzRn3OnJAbf9fXemDZBZ7OISIr0bjXraQ
        jC7itQ68o8SQPMVulcBVyC+Ey7zoL7lapw==
X-Google-Smtp-Source: ABdhPJxG2oRdhYZ2+C/Rahgb4duPWuDDGVMquTXVRFy+a6jRbPXU5iIYhIFRoB/UwcwXUagXxl4tQg==
X-Received: by 2002:a05:622a:28a:: with SMTP id z10mr2758380qtw.361.1617904979394;
        Thu, 08 Apr 2021 11:02:59 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11c1::11cc? ([2620:10d:c091:480::1:a6d7])
        by smtp.gmail.com with ESMTPSA id i25sm29834qka.38.2021.04.08.11.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Apr 2021 11:02:58 -0700 (PDT)
Subject: Re: ENOSPC in btrfs_run_delayed_refs with 5.10.8
To:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <0102017744df8bf8-cbdaa286-cfcc-4f6f-8332-69a98b3a4073-000000@eu-west-1.amazonses.com>
 <CAJCQCtROhiK+pEnS-kdApzkzZtFU1-yOAh5Uyv9hBtpyNJ3qig@mail.gmail.com>
 <010201775fa40c1a-9e433e37-ca1e-4ba8-93c5-2806bf138eb2-000000@eu-west-1.amazonses.com>
 <0102017822710f26-6311e3d1-c659-4c63-a4f6-ea5913a2290f-000000@eu-west-1.amazonses.com>
 <01020178b23f5d07-a1361e3a-6d78-4de6-90bc-4244c38aad89-000000@eu-west-1.amazonses.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1f13a3e1-1cbb-31c2-5a1c-384d7de68f4c@toxicpanda.com>
Date:   Thu, 8 Apr 2021 14:02:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <01020178b23f5d07-a1361e3a-6d78-4de6-90bc-4244c38aad89-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/8/21 12:10 PM, Martin Raiber wrote:
> On 11.03.2021 18:58 Martin Raiber wrote:
>> On 01.02.2021 23:08 Martin Raiber wrote:
>>> On 27.01.2021 22:03 Chris Murphy wrote:
>>>> On Wed, Jan 27, 2021 at 10:27 AM Martin Raiber <martin@urbackup.org> wrote:
>>>>> Hi,
>>>>>
>>>>> seems 5.10.8 still has the ENOSPC issue when compression is used 
>>>>> (compress-force=zstd,space_cache=v2):
>>>>>
>>>>> Jan 27 11:02:14  kernel: [248571.569840] ------------[ cut here ]------------
>>>>> Jan 27 11:02:14  kernel: [248571.569843] BTRFS: Transaction aborted (error 
>>>>> -28)
>>>>> Jan 27 11:02:14  kernel: [248571.569845] BTRFS: error (device dm-0) in 
>>>>> add_to_free_space_tree:1039: errno=-28 No space left
>>>>> Jan 27 11:02:14  kernel: [248571.569848] BTRFS info (device dm-0): forced 
>>>>> readonly
>>>>> Jan 27 11:02:14  kernel: [248571.569851] BTRFS: error (device dm-0) in 
>>>>> add_to_free_space_tree:1039: errno=-28 No space left
>>>>> Jan 27 11:02:14  kernel: [248571.569852] BTRFS: error (device dm-0) in 
>>>>> __btrfs_free_extent:3270: errno=-28 No space left
>>>>> Jan 27 11:02:14  kernel: [248571.569854] BTRFS: error (device dm-0) in 
>>>>> btrfs_run_delayed_refs:2191: errno=-28 No space left
>>>>> Jan 27 11:02:14  kernel: [248571.569898] WARNING: CPU: 3 PID: 21255 at 
>>>>> fs/btrfs/free-space-tree.c:1039 add_to_free_space_tree+0xe8/0x130
>>>>> Jan 27 11:02:14  kernel: [248571.569913] BTRFS: error (device dm-0) in 
>>>>> __btrfs_free_extent:3270: errno=-28 No space left
>>>>> Jan 27 11:02:14  kernel: [248571.569939] Modules linked in:
>>>>> Jan 27 11:02:14  kernel: [248571.569966] BTRFS: error (device dm-0) in 
>>>>> btrfs_run_delayed_refs:2191: errno=-28 No space left
>>>>> Jan 27 11:02:14  kernel: [248571.569992]  bfq zram bcache crc64 loop 
>>>>> dm_crypt xfs dm_mod st sr_mod cdrom nf_tables nfnetlink iptable_filter 
>>>>> bridge stp llc intel_powerclamp coretemp k$
>>>>> Jan 27 11:02:14  kernel: [248571.570075] CPU: 3 PID: 21255 Comm: 
>>>>> kworker/u50:22 Tainted: G          I       5.10.8 #1
>>>>> Jan 27 11:02:14  kernel: [248571.570076] Hardware name: Dell Inc. PowerEdge 
>>>>> R510/0DPRKF, BIOS 1.13.0 03/02/2018
>>>>> Jan 27 11:02:14  kernel: [248571.570079] Workqueue: events_unbound 
>>>>> btrfs_async_reclaim_metadata_space
>>>>> Jan 27 11:02:14  kernel: [248571.570081] RIP: 
>>>>> 0010:add_to_free_space_tree+0xe8/0x130
>>>>> Jan 27 11:02:14  kernel: [248571.570082] Code: 55 50 f0 48 0f ba aa 40 0a 
>>>>> 00 00 02 72 22 83 f8 fb 74 4c 83 f8 e2 74 47 89 c6 48 c7 c7 b8 39 49 82 89 
>>>>> 44 24 04 e8 8a 99 4a 00 <0f> 0b 8$
>>>>> Jan 27 11:02:14  kernel: [248571.570083] RSP: 0018:ffffc90009c57b88 EFLAGS: 
>>>>> 00010282
>>>>> Jan 27 11:02:14  kernel: [248571.570084] RAX: 0000000000000000 RBX: 
>>>>> 0000000000004000 RCX: 0000000000000027
>>>>> Jan 27 11:02:14  kernel: [248571.570085] RDX: 0000000000000027 RSI: 
>>>>> 0000000000000004 RDI: ffff888617a58b88
>>>>> Jan 27 11:02:14  kernel: [248571.570086] RBP: ffff8889ecb874e0 R08: 
>>>>> ffff888617a58b80 R09: 0000000000000000
>>>>> Jan 27 11:02:14  kernel: [248571.570087] R10: 0000000000000001 R11: 
>>>>> ffffffff822372e0 R12: 0000005741510000
>>>>> Jan 27 11:02:14  kernel: [248571.570087] R13: ffff8884e05727e0 R14: 
>>>>> ffff88815ae4fc00 R15: ffff88815ae4fdd8
>>>>> Jan 27 11:02:14  kernel: [248571.570088] FS:  0000000000000000(0000) 
>>>>> GS:ffff888617a40000(0000) knlGS:0000000000000000
>>>>> Jan 27 11:02:14  kernel: [248571.570089] CS:  0010 DS: 0000 ES: 0000 CR0: 
>>>>> 0000000080050033
>>>>> Jan 27 11:02:14  kernel: [248571.570090] CR2: 00007eb4a3a4f00a CR3: 
>>>>> 000000000260a005 CR4: 00000000000206e0
>>>>> Jan 27 11:02:14  kernel: [248571.570091] Call Trace:
>>>>> Jan 27 11:02:14  kernel: [248571.570097]  
>>>>> __btrfs_free_extent.isra.0+0x56a/0xa10
>>>>> Jan 27 11:02:14  kernel: [248571.570100]  __btrfs_run_delayed_refs+0x659/0xf20
>>>>> Jan 27 11:02:14  kernel: [248571.570102]  btrfs_run_delayed_refs+0x73/0x200
>>>>> Jan 27 11:02:14  kernel: [248571.570103]  flush_space+0x4e8/0x5e0
>>>>> Jan 27 11:02:14  kernel: [248571.570105]  ? btrfs_get_alloc_profile+0x66/0x1b0
>>>>> Jan 27 11:02:14  kernel: [248571.570106]  ? btrfs_get_alloc_profile+0x66/0x1b0
>>>>> Jan 27 11:02:14  kernel: [248571.570107]  
>>>>> btrfs_async_reclaim_metadata_space+0x107/0x3a0
>>>>> Jan 27 11:02:14  kernel: [248571.570111]  process_one_work+0x1b6/0x350
>>>>> Jan 27 11:02:14  kernel: [248571.570112]  worker_thread+0x50/0x3b0
>>>>> Jan 27 11:02:14  kernel: [248571.570114]  ? process_one_work+0x350/0x350
>>>>> Jan 27 11:02:14  kernel: [248571.570116]  kthread+0xfe/0x140
>>>>> Jan 27 11:02:14  kernel: [248571.570117]  ? kthread_park+0x90/0x90
>>>>> Jan 27 11:02:14  kernel: [248571.570120]  ret_from_fork+0x22/0x30
>>>>> Jan 27 11:02:14  kernel: [248571.570122] ---[ end trace 568d2f30de65b1c0 ]---
>>>>> Jan 27 11:02:14  kernel: [248571.570123] BTRFS: error (device dm-0) in 
>>>>> add_to_free_space_tree:1039: errno=-28 No space left
>>>>> Jan 27 11:02:14  kernel: [248571.570151] BTRFS: error (device dm-0) in 
>>>>> __btrfs_free_extent:3270: errno=-28 No space left
>>>>> Jan 27 11:02:14  kernel: [248571.570178] BTRFS: error (device dm-0) in 
>>>>> btrfs_run_delayed_refs:2191: errno=-28 No space left
>>>>>
>>>>>
>>>>> btrfs fi usage:
>>>>>
>>>>> Overall:
>>>>>      Device size:                 931.49GiB
>>>>>      Device allocated:            931.49GiB
>>>>>      Device unallocated:            1.00MiB
>>>>>      Device missing:                  0.00B
>>>>>      Used:                        786.39GiB
>>>>>      Free (estimated):            107.69GiB      (min: 107.69GiB)
>>>>>      Data ratio:                       1.00
>>>>>      Metadata ratio:                   1.00
>>>>>      Global reserve:              512.00MiB      (used: 0.00B)
>>>>>      Multiple profiles:                  no
>>>>>
>>>>> Data,single: Size:884.48GiB, Used:776.79GiB (87.82%)
>>>>>     /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533  884.48GiB
>>>>>
>>>>> Metadata,single: Size:47.01GiB, Used:9.59GiB (20.41%)
>>>>>     /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533   47.01GiB
>>>>>
>>>>> System,single: Size:4.00MiB, Used:144.00KiB (3.52%)
>>>>>     /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533    4.00MiB
>>>>>
>>>>> Unallocated:
>>>>>     /dev/mapper/LUKS-RC-a6414fd731ce4f878af44c3987bce533    1.00MiB
>>>> Can you mount or remount with enospc_debug, and reproduce the problem?
>>>> That'll include some debug info that might be helpful to a developing
>>>> coming across this report. Also it might help:
>>>>
>>>> cd /sys/fs/btrfs/$UUID/allocation
>>>> grep -R .
>>>>
>>>> And post that too. The $UUID is the file system UUID for this specific
>>>> file system, as reported by blkid or lsblk -f.
>>>>
>>> Disabled compression, but ENOSPC still occurs (Compared with 5.4 where there 
>>> is only a ENOSPC issue when compression is used). Here is the kernel log with 
>>> enospc_debug:
>>>
>>> https://gist.github.com/uroni/357b9904294898658eba9d9fca1f3a39
>>>
>>> Machine was rebooted before I could print the allocations.
>>>
>>> Now I'm trying if the problem goes away with space_cache=v1 (since it is 
>>> __add_to_free_space_tree that fails with ENOSPC).
>>>
>> Disabling space cache helped with this server (no errors since). But I got 
>> this without space cache on another server:
>>
>> Mar  5 22:42:24  kernel: [284818.567487] ------------[ cut here ]------------
>> Mar  5 22:42:24  kernel: [284818.567491] BTRFS: error (device dm-0) in 
>> btrfs_run_delayed_refs:2191: errno=-28 No space left
>> Mar  5 22:42:24  kernel: [284818.567493] BTRFS: Transaction aborted (error -28)
>> Mar  5 22:42:24  kernel: [284818.567525] BTRFS info (device dm-0): forced 
>> readonly
>> Mar  5 22:42:24  kernel: [284818.567539] WARNING: CPU: 3 PID: 1798217 at 
>> fs/btrfs/extent-tree.c:2191 btrfs_run_delayed_refs+0x1aa/0x200
>> Mar  5 22:42:24  kernel: [284818.567540] Modules linked in: zram bcache crc64 
>> loop dm_crypt bfq xfs dm_mod st sr_mod cdrom intel_powerclamp coretemp 
>> kvm_intel dcdbas snd_pcm mgag200 snd_timer kvm snd drm_kms_helper soundcore 
>> iTCO_wdt $
>> Mar  5 22:42:24  kernel: [284818.567593] CPU: 3 PID: 1798217 Comm: 
>> kworker/u50:21 Tainted: G          I       5.10.16 #1
>> Mar  5 22:42:24  kernel: [284818.567594] Hardware name: Dell Inc. PowerEdge 
>> R510/0DPRKF, BIOS 1.13.0 03/02/2018
>> Mar  5 22:42:24  kernel: [284818.567597] Workqueue: events_unbound 
>> btrfs_async_reclaim_metadata_space
>> Mar  5 22:42:24  kernel: [284818.567599] RIP: 
>> 0010:btrfs_run_delayed_refs+0x1aa/0x200
>> Mar  5 22:42:24  kernel: [284818.567601] Code: 54 24 50 f0 48 0f ba aa 40 0a 
>> 00 00 02 72 20 83 f8 fb 74 3c 83 f8 e2 74 37 89 c6 48 c7 c7 38 37 49 82 89 04 
>> 24 e8 d8 2a 54 00 <0f> 0b 8b 04 24 89 c1 ba 8f 08 00 00 4c 89 e7 89 04 24 48 c7$
>> Mar  5 22:42:24  kernel: [284818.567602] RSP: 0018:ffffc90009d8fd80 EFLAGS: 
>> 00010282
>> Mar  5 22:42:24  kernel: [284818.567603] RAX: 0000000000000000 RBX: 
>> 00000000001f3e50 RCX: 0000000000000027
>> Mar  5 22:42:24  kernel: [284818.567604] RDX: 0000000000000027 RSI: 
>> 00000000ffff7fff RDI: ffff888617a58b88
>> Mar  5 22:42:24  kernel: [284818.567605] RBP: ffff88806a99a378 R08: 
>> ffff888617a58b80 R09: ffffc90009d8fb98
>> Mar  5 22:42:24  kernel: [284818.567605] R10: 0000000000000001 R11: 
>> 0000000000000001 R12: ffff888471f4f7b8
>> Mar  5 22:42:24  kernel: [284818.567606] R13: ffff888471f4f7b8 R14: 
>> ffff8886375fc400 R15: 0000000000000004
>> Mar  5 22:42:24  kernel: [284818.567607] FS:  0000000000000000(0000) 
>> GS:ffff888617a40000(0000) knlGS:0000000000000000
>> Mar  5 22:42:24  kernel: [284818.567608] CS:  0010 DS: 0000 ES: 0000 CR0: 
>> 0000000080050033
>> Mar  5 22:42:24  kernel: [284818.567609] CR2: 00007e8f683bf020 CR3: 
>> 000000000260a002 CR4: 00000000000206e0
>> Mar  5 22:42:24  kernel: [284818.567610] Call Trace:
>> Mar  5 22:42:24  kernel: [284818.567617]  flush_space+0x4e8/0x5e0
>> Mar  5 22:42:24  kernel: [284818.567619]  ? btrfs_get_alloc_profile+0x66/0x1b0
>> Mar  5 22:42:24  kernel: [284818.567620]  ? btrfs_get_alloc_profile+0x66/0x1b0
>> Mar  5 22:42:24  kernel: [284818.567622]  
>> btrfs_async_reclaim_metadata_space+0x107/0x3a0
>> Mar  5 22:42:24  kernel: [284818.567625]  process_one_work+0x1b6/0x350
>> Mar  5 22:42:24  kernel: [284818.567627]  worker_thread+0x50/0x3b0
>> Mar  5 22:42:24  kernel: [284818.567628]  ? process_one_work+0x350/0x350
>> Mar  5 22:42:24  kernel: [284818.567630]  kthread+0xfe/0x140
>> Mar  5 22:42:24  kernel: [284818.567631]  ? kthread_park+0x90/0x90
>> Mar  5 22:42:24  kernel: [284818.567634]  ret_from_fork+0x22/0x30
>> Mar  5 22:42:24  kernel: [284818.567636] ---[ end trace 4430fcd335eaeecc ]---
>> Mar  5 22:42:24  kernel: [284818.567638] BTRFS: error (device dm-0) in 
>> btrfs_run_delayed_refs:2191: errno=-28 No space left
>>
> As a work-around I was trying following:
> 
> --- a/fs/btrfs/ctree.h  2021-03-23 13:04:15.533914931 +0100
> +++ b/fs/btrfs/ctree.h  2021-03-23 13:04:56.871092396 +0100
> @@ -2535,7 +2535,7 @@
>   static inline u64 btrfs_calc_insert_metadata_size(struct btrfs_fs_info *fs_info,
>                                                    unsigned num_items)
>   {
> -       return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
> +       return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 4 * num_items;
>   }
> 
>   /*
> @@ -2545,7 +2545,7 @@
>   static inline u64 btrfs_calc_metadata_size(struct btrfs_fs_info *fs_info,
>                                                   unsigned num_items)
>   {
> -       return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * num_items;
> +       return (u64)fs_info->nodesize * BTRFS_MAX_LEVEL * 2 * num_items;
>   }
> 
> and I guess it helps some. It took two weeks till it ran into ENOSPC->ro. Does 
> anyone have an idea what further work-arounds to try (or double the reserved 
> metadata again ;) )?
> 

Hey Martin,

I swear this is on my radar, I'm going to get to it as soon as I work through my 
backlog.  For now this is a reasonable enough solution.  Thanks,

Josef
