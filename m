Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3282D6BAF76
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Mar 2023 12:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjCOLon (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Mar 2023 07:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjCOLol (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Mar 2023 07:44:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE156A68
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Mar 2023 04:44:38 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pcPYZ-0003nb-EQ; Wed, 15 Mar 2023 12:44:35 +0100
Message-ID: <5f0b44bb-e06e-bc47-b688-d9cfb5b490d3@leemhuis.info>
Date:   Wed, 15 Mar 2023 12:44:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Content-Language: en-US, de-DE
To:     Sergei Trofimovich <slyich@gmail.com>,
        Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <Y/+n1wS/4XAH7X1p@nz>
 <94cf49d0-fa2d-cc2c-240e-222706d69eb3@oracle.com>
 <20230302105406.2cd367f7@nz>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230302105406.2cd367f7@nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1678880678;89743985;
X-HE-SMSGID: 1pcPYZ-0003nb-EQ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

I added this to the tracking, but it seems nothing happened for nearly
two weeks.

Sergei, did you find a workaround that works for you? Or is this
something that other people might run into as well and thus better
should be fixed?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 02.03.23 11:54, Sergei Trofimovich wrote:
> On Thu, 2 Mar 2023 17:12:27 +0800
> Anand Jain <anand.jain@oracle.com> wrote:
> 
>> On 3/2/23 03:30, Sergei Trofimovich wrote:
>>> Hi btrfs maintainers!
>>>
>>> Tl;DR:
>>>
>>>    After 63a7cb13071842 "btrfs: auto enable discard=async when possible" I
>>>    see constant DISCARD storm towards my NVME device be it idle or not.
>>>
>>>    No storm: v6.1 and older
>>>    Has storm: v6.2 and newer
>>>
>>> More words:
>>>
>>> After upgrade from 6.1 to 6.2 I noticed that Disk led on my desktop
>>> started flashing incessantly regardless of present or absent workload.
>>>
>>> I think I confirmed the storm with `perf`: led flashes align with output
>>> of:
>>>
>>>      # perf ftrace -a -T 'nvme_setup*' | cat
>>>
>>>      kworker/6:1H-298     [006]   2569.645201: nvme_setup_cmd <-nvme_queue_rq
>>>      kworker/6:1H-298     [006]   2569.645205: nvme_setup_discard <-nvme_setup_cmd
>>>      kworker/6:1H-298     [006]   2569.749198: nvme_setup_cmd <-nvme_queue_rq
>>>      kworker/6:1H-298     [006]   2569.749202: nvme_setup_discard <-nvme_setup_cmd
>>>      kworker/6:1H-298     [006]   2569.853204: nvme_setup_cmd <-nvme_queue_rq
>>>      kworker/6:1H-298     [006]   2569.853209: nvme_setup_discard <-nvme_setup_cmd
>>>      kworker/6:1H-298     [006]   2569.958198: nvme_setup_cmd <-nvme_queue_rq
>>>      kworker/6:1H-298     [006]   2569.958202: nvme_setup_discard <-nvme_setup_cmd
>>>
>>> `iotop` shows no read/write IO at all (expected).
>>>
>>> I was able to bisect it down to this commit:
>>>
>>>    $ git bisect good
>>>    63a7cb13071842966c1ce931edacbc23573aada5 is the first bad commit
>>>    commit 63a7cb13071842966c1ce931edacbc23573aada5
>>>    Author: David Sterba <dsterba@suse.com>
>>>    Date:   Tue Jul 26 20:54:10 2022 +0200
>>>
>>>      btrfs: auto enable discard=async when possible
>>>
>>>      There's a request to automatically enable async discard for capable
>>>      devices. We can do that, the async mode is designed to wait for larger
>>>      freed extents and is not intrusive, with limits to iops, kbps or latency.
>>>
>>>      The status and tunables will be exported in /sys/fs/btrfs/FSID/discard .
>>>
>>>      The automatic selection is done if there's at least one discard capable
>>>      device in the filesystem (not capable devices are skipped). Mounting
>>>      with any other discard option will honor that option, notably mounting
>>>      with nodiscard will keep it disabled.
>>>
>>>      Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/
>>>      Reviewed-by: Boris Burkov <boris@bur.io>
>>>      Signed-off-by: David Sterba <dsterba@suse.com>
>>>
>>>     fs/btrfs/ctree.h   |  1 +
>>>     fs/btrfs/disk-io.c | 14 ++++++++++++++
>>>     fs/btrfs/super.c   |  2 ++
>>>     fs/btrfs/volumes.c |  3 +++
>>>     fs/btrfs/volumes.h |  2 ++
>>>     5 files changed, 22 insertions(+)
>>>
>>> Is this storm a known issue? I did not dig too much into the patch. But
>>> glancing at it this bit looks slightly off:
>>>
>>>      +       if (bdev_max_discard_sectors(bdev))
>>>      +               fs_devices->discardable = true;
>>>
>>> Is it expected that there is no `= false` assignment?
>>>
>>> This is the list of `btrfs` filesystems I have:
>>>
>>>    $ cat /proc/mounts | fgrep btrfs
>>>    /dev/nvme0n1p3 / btrfs rw,noatime,compress=zstd:3,ssd,space_cache,subvolid=848,subvol=/nixos 0 0
>>>    /dev/sda3 /mnt/archive btrfs rw,noatime,compress=zstd:3,space_cache,subvolid=5,subvol=/ 0 0
>>>    # skipped bind mounts
>>>   
>>
>>
>>
>>> The device is:
>>>
>>>    $ lspci | fgrep -i Solid
>>>    01:00.0 Non-Volatile memory controller: ADATA Technology Co., Ltd. XPG SX8200 Pro PCIe Gen3x4 M.2 2280 Solid State Drive (rev 03)  
>>
>>
>>   It is a SSD device with NVME interface, that needs regular discard.
>>   Why not try tune io intensity using
>>
>>   /sys/fs/btrfs/<uuid>/discard
>>
>>   options?
>>
>>   Maybe not all discardable sectors are not issued at once. It is a good
>>   idea to try with a fresh mkfs (which runs discard at mkfs) to see if
>>   discard is being issued even if there are no fs activities.
> 
> Ah, thank you Anand! I poked a bit more in `perf ftrace` and I think I
> see a "slow" pass through the discard backlog:
> 
>     /sys/fs/btrfs/<UUID>/discard$  cat iops_limit
>     10
> 
> Twice a minute I get a short burst of file creates/deletes that produces
> a bit of free space in many block groups. That enqueues hundreds of work
> items.
> 
>     $ sudo perf ftrace -a -T 'btrfs_discard_workfn' -T 'btrfs_issue_discard' -T 'btrfs_discard_queue_work'
>      btrfs-transacti-407     [011]  42800.424027: btrfs_discard_queue_work <-__btrfs_add_free_space
>      btrfs-transacti-407     [011]  42800.424070: btrfs_discard_queue_work <-__btrfs_add_free_space
>      ...
>      btrfs-transacti-407     [011]  42800.425053: btrfs_discard_queue_work <-__btrfs_add_free_space
>      btrfs-transacti-407     [011]  42800.425055: btrfs_discard_queue_work <-__btrfs_add_free_space
> 
> 193 entries of btrfs_discard_queue_work.
> It took 1ms to enqueue all of the work into the workqueue.
>     
>      kworker/u64:1-2379115 [000]  42800.487010: btrfs_discard_workfn <-process_one_work
>      kworker/u64:1-2379115 [000]  42800.487028: btrfs_issue_discard <-btrfs_discard_extent
>      kworker/u64:1-2379115 [005]  42800.594010: btrfs_discard_workfn <-process_one_work
>      kworker/u64:1-2379115 [005]  42800.594031: btrfs_issue_discard <-btrfs_discard_extent
>      ...
>      kworker/u64:15-2396822 [007]  42830.441487: btrfs_discard_workfn <-process_one_work
>      kworker/u64:15-2396822 [007]  42830.441502: btrfs_issue_discard <-btrfs_discard_extent
>      kworker/u64:15-2396822 [000]  42830.546497: btrfs_discard_workfn <-process_one_work
>      kworker/u64:15-2396822 [000]  42830.546524: btrfs_issue_discard <-btrfs_discard_extent
> 
> 286 pairs of btrfs_discard_workfn / btrfs_issue_discard.
> Each pair takes 10ms to process, which seems to match iops_limit=10.
> That means I can get about 300 discards per second max.
> 
>      btrfs-transacti-407     [002]  42830.634216: btrfs_discard_queue_work <-__btrfs_add_free_space
>      btrfs-transacti-407     [002]  42830.634228: btrfs_discard_queue_work <-__btrfs_add_free_space
>      ...
> 
> Next transaction started 30 seconds later, which is a default commit
> interval.
> 
> My file system is of 512GB size. My guess I get about one discard entry
> per block group on each 
> 
> Does my system keeps up with scheduled discard backlog? Can I peek at
> workqueue size?
> 
> Is iops_limit=10 a reasonable default for discard=async? It feels like
> for larger file systems it will not be enough even for this idle state.
> 
