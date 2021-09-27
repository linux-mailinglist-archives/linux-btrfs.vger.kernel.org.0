Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9662241A3DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Sep 2021 01:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbhI0XkY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 19:40:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62087 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbhI0XkX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 19:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632785925; x=1664321925;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vYgLEXU5NB9vD39azRy9fi21b84USSoCjjr7L2VCvyw=;
  b=Zedov2bPXGS6JyogyRgoFswUHYIbcwgIixBOVZqG0JGVBUB+/QpKo3Yz
   0UV8S1D8eCvickqAAC/FliXv/eiG3KS4PsXwyOA1t8Ty0QMf9VkHP4ZnI
   xwqiDBrWnmuFc7eJPVt0L5F4WoH0LVYWgd/yCcUbbkKk4G9bke/4GBqH/
   zDBmaP4RXja+9OcM5ngJM1rOSdXTNI5ocLOfG6bJG6WBMvHp10R0QcYsE
   eOOkdZTjoxTMJEM4ZYZcel1BGJpz+JxO7u4EjXsc/lKw93rxA2H3IDusp
   OX6bM6+xju0FmDkj1ngWq+1ErsARpJ+U4uQnVH9su5voQkyuhwmIgbTwj
   g==;
X-IronPort-AV: E=Sophos;i="5.85,327,1624291200"; 
   d="scan'208";a="292769717"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2021 07:38:45 +0800
IronPort-SDR: +o21eYoNS+ZNOMHcruIwuumpiehiCqdwQmbLNtsglP9q+faXWe336L44ya8SaD/gkVj+Y4mClH
 NSM2T0m60h/mG547yHqH5nDl8A7Y4GF/uec2gdSlGC0ET/7Pmt1/nN1XfrOgk08SE5eBwwYu8Z
 /sW6VxWZ9Lc6/8SQSyQy2wvOQJoCzKz88hBl1kfXdLLszI0hDO5Wwg9v0rRG+ah50pR/kZIhjm
 6v4ISQZp5kmdj6/gokTzgnIuFI2cwhoY4P99MEdX/4P11iSVFnbC8tS8pRFZF1CVs3e1Nl2n0b
 5+FS9phmTbSCJ1mygvya1veF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 16:14:50 -0700
IronPort-SDR: rz80+WOlChK2HPcomPUnONqeyMRW6gVUBgb9Miq1sAto85SsSBwTIMoa/cRpLQA3y5I/z9FHLS
 dPY5ZH7UFE29rBp6PTLhuAyBh50aQYfHubBjXg8Y9odj59vw6ZFHHSvUb/Bqf+w4uysO/Effp3
 VXn5OcwKOwrNg2smEbmtFbzM9xChZAJOntay86My1KUSctWYB/G/dt2U/ilSnUrGnGAUW3m6Xg
 7qazpRgWdelS9s5LjEdusWvt+2kzZWRhhZnJIIqUNUtqnscOg/2kf8d10FqZcibb/T8dNAzV+k
 fkA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2021 16:38:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4HJJxJ5X74z1SHvx
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Sep 2021 16:38:44 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1632785923; x=1635377924; bh=vYgLEXU5NB9vD39azRy9fi21b84USSoCjjr
        7L2VCvyw=; b=bH0N+EtQGdxYL9VpMgLl3c9hxMnxILiY93k2EN+bCjMQr39h3UE
        Whjp66RZDHIsy/+wZNDAwaT4IMWB8FNt4hdJHJ4TOIQ9/BgNI96p549N1TjEl31S
        A62TK+iPD+HD8Yy3GcQx8gQ8XFd+Gpl8v7TISgGQvL0KVnMEhVwT+GOgESBq5KQI
        2CSYCWfDySXPiBIzY8LQFO5QzPPs+V6MKluE7MxWdgcUpe0KB/PbaDNpLDG0UAIC
        yGkUlEC+MTPJzzn3J1deRaS7a1o2sLfAk6mEVhXlXNLCRNo8NXNSMQQmIbrGHtVo
        etQTVMpGna5MwKeK4/MRsH1TQKXKI/6Yjzw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QwqveipAuMqv for <linux-btrfs@vger.kernel.org>;
        Mon, 27 Sep 2021 16:38:43 -0700 (PDT)
Received: from [10.225.54.48] (jpf009086.ad.shared [10.225.54.48])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4HJJxG617bz1RvTg;
        Mon, 27 Sep 2021 16:38:42 -0700 (PDT)
Message-ID: <5464e996-a01a-3a42-a195-36d052122659@opensource.wdc.com>
Date:   Tue, 28 Sep 2021 08:38:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: Host managed SMR drive issue
Content-Language: en-US
To:     Sven Oehme <oehmes@gmail.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
References: <CALssuR00NvTHJJuoOFhw=4+fHARtBN2PLqTr4W06PT5VMagh_A@mail.gmail.com>
 <6db88069-e263-ae85-4f69-adb9ec69ee76@opensource.wdc.com>
 <CALssuR2gAEoxhDK=z0ryx30GAWiXcZ70pbUEq5mAxd-5pmsyRw@mail.gmail.com>
 <CALssuR2K8Dtr+bGSYVOQXcWomMx0VnLwUiB1ah44ngrJ5trnSw@mail.gmail.com>
 <a9764186-90ab-6ff3-7953-07f39d69ea5f@opensource.wdc.com>
 <CALssuR3A4Um8raXi1W7O74PbgbcNmummasfZrY=sPj5t6f+eWg@mail.gmail.com>
 <b010054f-ba99-6cf9-8318-267e3b4cff90@opensource.wdc.com>
 <CALssuR1sqLDkyf4iyFhJv108BePHSoMPD=r+pDfeb=mcPWNaVA@mail.gmail.com>
 <7038f4b9-a321-ef7d-1762-c0c77d666d55@opensource.wdc.com>
 <CALssuR1Fpz=wXsCY6N+6ApU-1_tBzjj_==+3s2NOws9fPReYDw@mail.gmail.com>
 <CALssuR0D9r5_rXWsL1Qt4ouFdUQdrYY_VL2KMaNJ442bqHREsQ@mail.gmail.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital
In-Reply-To: <CALssuR0D9r5_rXWsL1Qt4ouFdUQdrYY_VL2KMaNJ442bqHREsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/09/28 8:36, Sven Oehme wrote:
> I should add that the copy process starts and runs for a while, but
> then stalls. The last 2 times I started over from scratch it stalls at
> around 200 GB, so ~ 1-2 files into the copy process.

OK. So it looks like the problem starts when btrfs starts using the sequential
write only zones. We will try to recreate this.

> 
> Sven
> 
> On Mon, Sep 27, 2021 at 5:34 PM Sven Oehme <oehmes@gmail.com> wrote:
>>
>> the workload is as simple as one can imagine :
>>
>> scp -rp /space/01/ /space/20/
>> where space/01 is a ext4 filesystem with several >100gb files in it,
>> /space/20 is the btrfs destination
>>
>> its single threaded , nothing special
>>
>> Sven
>>
>> On Mon, Sep 27, 2021 at 5:31 PM Damien Le Moal
>> <damien.lemoal@opensource.wdc.com> wrote:
>>>
>>> On 2021/09/28 8:17, Sven Oehme wrote:
>>>> yes i do :
>>>>
>>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/queued
>>>> 3760
>>>
>>> Can you give more information on the workload ? How can we recreate this ?
>>>
>>>>
>>>> On Mon, Sep 27, 2021 at 5:01 PM Damien Le Moal
>>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>>
>>>>> On 2021/09/28 7:56, Sven Oehme wrote:
>>>>>> Hi,
>>>>>>
>>>>>> i tried above  :
>>>>>>
>>>>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatched
>>>>>>        0        89
>>>>>>        1        1462
>>>>>>        2        1
>>>>>>        4        574
>>>>>>        8        0
>>>>>>       16        0
>>>>>>       32+       0
>>>>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatch
>>>>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatched
>>>>>>        0        89
>>>>>>        1        1462
>>>>>>        2        1
>>>>>>        4        574
>>>>>>        8        0
>>>>>>       16        0
>>>>>>       32+       0
>>>>>> root@01:~# cat  /sys/kernel/debug/block/sdr/hctx0/dispatch_busy
>>>>>> 0
>>>>>
>>>>> Do you have the queued count too ? If there is a difference with dispatch, it
>>>>> would mean that some IOs are stuck in the stack.
>>>>>
>>>>>>
>>>>>> echo 1 > /sys/kernel/debug/block/sdr/hctx0/run
>>>>>>
>>>>>> doesn't make any progress, still no i/o to the drive
>>>>>>
>>>>>> Sven
>>>>>>
>>>>>>
>>>>>> On Mon, Sep 27, 2021 at 4:48 PM Damien Le Moal
>>>>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>>>>
>>>>>>> On 2021/09/28 7:38, Sven Oehme wrote:
>>>>>>>> i tried to repeat the test with FW19, same result :
>>>>>>>
>>>>>>> The problem is likely not rooted with the HBA fw version.
>>>>>>> How do you create the problem ? Is it an fio script you are running ?
>>>>>>>
>>>>>>>>
>>>>>>>> [Mon Sep 27 15:41:22 2021] INFO: task btrfs-transacti:4206 blocked for
>>>>>>>> more than 604 seconds.
>>>>>>>> [Mon Sep 27 15:41:22 2021]       Not tainted 5.14-test #1
>>>>>>>> [Mon Sep 27 15:41:22 2021] "echo 0 >
>>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>>> [Mon Sep 27 15:41:22 2021] task:btrfs-transacti state:D stack:    0
>>>>>>>> pid: 4206 ppid:     2 flags:0x00004000
>>>>>>>> [Mon Sep 27 15:41:22 2021] Call Trace:
>>>>>>>> [Mon Sep 27 15:41:22 2021]  __schedule+0x2fa/0x910
>>>>>>>> [Mon Sep 27 15:41:22 2021]  schedule+0x4f/0xc0
>>>>>>>> [Mon Sep 27 15:41:22 2021]  io_schedule+0x46/0x70
>>>>>>>> [Mon Sep 27 15:41:22 2021]  blk_mq_get_tag+0x11b/0x270
>>>>>>>> [Mon Sep 27 15:41:22 2021]  ? wait_woken+0x80/0x80
>>>>>>>> [Mon Sep 27 15:41:22 2021]  __blk_mq_alloc_request+0xec/0x120
>>>>>>>> [Mon Sep 27 15:41:22 2021]  blk_mq_submit_bio+0x12f/0x580
>>>>>>>> [Mon Sep 27 15:41:22 2021]  submit_bio_noacct+0x42a/0x4f0
>>>>>>>> [Mon Sep 27 15:41:22 2021]  submit_bio+0x4f/0x1b0
>>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_map_bio+0x1a3/0x4c0 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_submit_metadata_bio+0x10f/0x170 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  submit_one_bio+0x67/0x80 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  btree_write_cache_pages+0x6e8/0x770 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  btree_writepages+0x5f/0x70 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  do_writepages+0x38/0xc0
>>>>>>>> [Mon Sep 27 15:41:22 2021]  __filemap_fdatawrite_range+0xcc/0x110
>>>>>>>> [Mon Sep 27 15:41:22 2021]  filemap_fdatawrite_range+0x13/0x20
>>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_write_marked_extents+0x66/0x140 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_write_and_wait_transaction+0x49/0xd0 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  btrfs_commit_transaction+0x6b0/0xaa0 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  ? start_transaction+0xcf/0x5a0 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  transaction_kthread+0x138/0x1b0 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  kthread+0x12f/0x150
>>>>>>>> [Mon Sep 27 15:41:22 2021]  ?
>>>>>>>> btrfs_cleanup_transaction.isra.0+0x560/0x560 [btrfs]
>>>>>>>> [Mon Sep 27 15:41:22 2021]  ? __kthread_bind_mask+0x70/0x70
>>>>>>>> [Mon Sep 27 15:41:22 2021]  ret_from_fork+0x22/0x30
>>>>>>>>
>>>>>>>> if you tell me what information to collect, I am happy to do so,.
>>>>>>>
>>>>>>> The stack seems to point to a "hang" in the block layer so btrfs side waits forever.
>>>>>>>
>>>>>>> When you get the hang, can you check the queued and dispatch counters in
>>>>>>> /sys/kernel/debug/block/<your disk>/hctx0 ?
>>>>>>>
>>>>>>> Once you have the numbers, try:
>>>>>>>
>>>>>>> echo 1 > /sys/kernel/debug/block/<your disk>/hctx0/run
>>>>>>>
>>>>>>> to see if the drive gets unstuck.
>>>>>>>
>>>>>>>>
>>>>>>>> Sven
>>>>>>>>
>>>>>>>>
>>>>>>>> On Mon, Sep 27, 2021 at 11:28 AM Sven Oehme <oehmes@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I also have an  Adaptec HBA 1100-4i at FW level 4.11 (latest) , which
>>>>>>>>> according to https://ask.adaptec.com/app/answers/detail/a_id/17472 is
>>>>>>>>> supported but see the exact same hangs after a few minutes ...
>>>>>>>>>
>>>>>>>>> what i see in dmesg is :
>>>>>>>>>
>>>>>>>>> [Mon Sep 27 11:20:03 2021] INFO: task kworker/u102:6:190092 blocked
>>>>>>>>> for more than 120 seconds.
>>>>>>>>> [Mon Sep 27 11:20:03 2021]       Not tainted 5.14-test #1
>>>>>>>>> [Mon Sep 27 11:20:03 2021] "echo 0 >
>>>>>>>>> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
>>>>>>>>> [Mon Sep 27 11:20:03 2021] task:kworker/u102:6  state:D stack:    0
>>>>>>>>> pid:190092 ppid:     2 flags:0x00004000
>>>>>>>>> [Mon Sep 27 11:20:03 2021] Workqueue: btrfs-worker-high
>>>>>>>>> btrfs_work_helper [btrfs]
>>>>>>>>> [Mon Sep 27 11:20:03 2021] Call Trace:
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  __schedule+0x2fa/0x910
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  schedule+0x4f/0xc0
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  io_schedule+0x46/0x70
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  blk_mq_get_tag+0x11b/0x270
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  ? wait_woken+0x80/0x80
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  __blk_mq_alloc_request+0xec/0x120
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  blk_mq_submit_bio+0x12f/0x580
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  submit_bio_noacct+0x42a/0x4f0
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  submit_bio+0x4f/0x1b0
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  btrfs_map_bio+0x1a3/0x4c0 [btrfs]
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  run_one_async_done+0x3b/0x70 [btrfs]
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  btrfs_work_helper+0x132/0x2e0 [btrfs]
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  process_one_work+0x220/0x3c0
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  worker_thread+0x53/0x420
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  kthread+0x12f/0x150
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  ? process_one_work+0x3c0/0x3c0
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  ? __kthread_bind_mask+0x70/0x70
>>>>>>>>> [Mon Sep 27 11:20:03 2021]  ret_from_fork+0x22/0x30
>>>>>>>>>
>>>>>>>>> i will also downgrade the LSI adapter to FW 19, but i think this is
>>>>>>>>> unrelated to the FW as i can see this with 2 completely different
>>>>>>>>> HBA's and 2 completely different drives.
>>>>>>>>>
>>>>>>>>> Sven
>>>>>>>>>
>>>>>>>>> Sven
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Sun, Sep 26, 2021 at 5:19 PM Damien Le Moal
>>>>>>>>> <damien.lemoal@opensource.wdc.com> wrote:
>>>>>>>>>>
>>>>>>>>>> On 2021/09/25 3:25, Sven Oehme wrote:
>>>>>>>>>>> Hi,
>>>>>>>>>>>
>>>>>>>>>>> i am running into issues with Host Managed SMR drive testing. when i
>>>>>>>>>>> try to copy or move a file to the btrfs filesystem it just hangs. i
>>>>>>>>>>> tried multiple 5.12,5.13 as well as 5.14 all the way to 5.14.6 but the
>>>>>>>>>>> issue still persists.
>>>>>>>>>>>
>>>>>>>>>>> here is the setup :
>>>>>>>>>>>
>>>>>>>>>>> I am using btrfs-progs-v5.14.1
>>>>>>>>>>> device is a  Host Managed WDC  20TB SMR drive with firmware level C421
>>>>>>>>>>> its connected via a HBA 9400-8i Tri-Mode Storage Adapter , latest 20.0 FW
>>>>>>>>>>
>>>>>>>>>> Beware of the Broadcom FW rev 20. We found problems with it: very slow zone
>>>>>>>>>> command scheduling leading to command timeout is some cases. FW 19 does not seem
>>>>>>>>>> to have this issue. But that is likely not the cause of the problem here.
>>>>>>>>>>
>>>>>>>>>> Is there anything of interest in dmesg ? Any IO errors ?
>>>>>>>>>>
>>>>>>>>>> Naohiro, Johannes,
>>>>>>>>>>
>>>>>>>>>> Any idea ?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>> I am using the /dev/sd device direct  , no lvm or device mapper or
>>>>>>>>>>> anything else in between
>>>>>>>>>>>
>>>>>>>>>>> after a few seconds, sometimes minutes data rate to the drive drops to
>>>>>>>>>>> 0 and 1 or 2 cores on my system show 100% IO wait time, but no longer
>>>>>>>>>>> make any progress
>>>>>>>>>>>
>>>>>>>>>>> the process in question has the following stack :
>>>>>>>>>>>
>>>>>>>>>>> [ 2168.589160] task:mv              state:D stack:    0 pid: 3814
>>>>>>>>>>> ppid:  3679 flags:0x00004000
>>>>>>>>>>> [ 2168.589162] Call Trace:
>>>>>>>>>>> [ 2168.589163]  __schedule+0x2fa/0x910
>>>>>>>>>>> [ 2168.589166]  schedule+0x4f/0xc0
>>>>>>>>>>> [ 2168.589168]  schedule_timeout+0x8a/0x140
>>>>>>>>>>> [ 2168.589171]  ? __bpf_trace_tick_stop+0x10/0x10
>>>>>>>>>>> [ 2168.589173]  io_schedule_timeout+0x51/0x80
>>>>>>>>>>> [ 2168.589176]  balance_dirty_pages+0x2fa/0xe30
>>>>>>>>>>> [ 2168.589179]  ? __mod_lruvec_state+0x3a/0x50
>>>>>>>>>>> [ 2168.589182]  balance_dirty_pages_ratelimited+0x2f9/0x3c0
>>>>>>>>>>> [ 2168.589185]  btrfs_buffered_write+0x58e/0x7e0 [btrfs]
>>>>>>>>>>> [ 2168.589226]  btrfs_file_write_iter+0x138/0x3e0 [btrfs]
>>>>>>>>>>> [ 2168.589260]  ? ext4_file_read_iter+0x5b/0x180
>>>>>>>>>>> [ 2168.589262]  new_sync_write+0x114/0x1a0
>>>>>>>>>>> [ 2168.589265]  vfs_write+0x1c5/0x260
>>>>>>>>>>> [ 2168.589267]  ksys_write+0x67/0xe0
>>>>>>>>>>> [ 2168.589270]  __x64_sys_write+0x1a/0x20
>>>>>>>>>>> [ 2168.589272]  do_syscall_64+0x40/0xb0
>>>>>>>>>>> [ 2168.589275]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>>>>>>>>>>> [ 2168.589277] RIP: 0033:0x7ffff7e91c27
>>>>>>>>>>> [ 2168.589278] RSP: 002b:00007fffffffdc48 EFLAGS: 00000246 ORIG_RAX:
>>>>>>>>>>> 0000000000000001
>>>>>>>>>>> [ 2168.589280] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007ffff7e91c27
>>>>>>>>>>> [ 2168.589281] RDX: 0000000000020000 RSI: 00007ffff79bd000 RDI: 0000000000000004
>>>>>>>>>>> [ 2168.589282] RBP: 00007ffff79bd000 R08: 0000000000000000 R09: 0000000000000000
>>>>>>>>>>> [ 2168.589283] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000000004
>>>>>>>>>>> [ 2168.589284] R13: 0000000000000004 R14: 00007ffff79bd000 R15: 0000000000020000
>>>>>>>>>>>
>>>>>>>>>>> and shows up under runnable tasks :
>>>>>>>>>>>
>>>>>>>>>>> [ 2168.593562] runnable tasks:
>>>>>>>>>>> [ 2168.593562]  S            task   PID         tree-key  switches
>>>>>>>>>>> prio     wait-time             sum-exec        sum-sleep
>>>>>>>>>>> [ 2168.593563] -------------------------------------------------------------------------------------------------------------
>>>>>>>>>>> [ 2168.593565]  S        cpuhp/13    92     88923.802487        19
>>>>>>>>>>> 120         0.000000         0.292061         0.000000 2 0 /
>>>>>>>>>>> [ 2168.593571]  S  idle_inject/13    93       -11.997255         3
>>>>>>>>>>> 49         0.000000         0.005480         0.000000 2 0 /
>>>>>>>>>>> [ 2168.593577]  S    migration/13    94       814.287531       551
>>>>>>>>>>> 0         0.000000      1015.550514         0.000000 2 0 /
>>>>>>>>>>> [ 2168.593582]  S    ksoftirqd/13    95     88762.317130        44
>>>>>>>>>>> 120         0.000000         1.940252         0.000000 2 0 /
>>>>>>>>>>> [ 2168.593588]  I    kworker/13:0    96        -9.031157         5
>>>>>>>>>>> 120         0.000000         0.017423         0.000000 2 0 /
>>>>>>>>>>> [ 2168.593593]  I   kworker/13:0H    97      3570.961886         5
>>>>>>>>>>> 100         0.000000         0.034345         0.000000 2 0 /
>>>>>>>>>>> [ 2168.593603]  I    kworker/13:1   400    101650.731913       578
>>>>>>>>>>> 120         0.000000        10.110898         0.000000 2 0 /
>>>>>>>>>>> [ 2168.593611]  I   kworker/13:1H  1015    101649.600698        65
>>>>>>>>>>> 100         0.000000         1.443300         0.000000 2 0 /
>>>>>>>>>>> [ 2168.593618]  S           loop3  1994     99133.655903        70
>>>>>>>>>>> 100         0.000000         1.137468         0.000000 2 0 /
>>>>>>>>>>> [ 2168.593625]  S           snapd  3161        15.296181       166
>>>>>>>>>>> 120         0.000000        90.296991         0.000000 2 0
>>>>>>>>>>> /system.slice/snapd.service
>>>>>>>>>>> [ 2168.593631]  S           snapd  3198        10.047573        49
>>>>>>>>>>> 120         0.000000         5.646247         0.000000 2 0
>>>>>>>>>>> /system.slice/snapd.service
>>>>>>>>>>> [ 2168.593639]  S            java  2446       970.743682       301
>>>>>>>>>>> 120         0.000000       101.648659         0.000000 2 0
>>>>>>>>>>> /system.slice/stor_tomcat.service
>>>>>>>>>>> [ 2168.593645]  S C1 CompilerThre  2573      1033.157689      3636
>>>>>>>>>>> 120         0.000000       615.256247         0.000000 2 0
>>>>>>>>>>> /system.slice/stor_tomcat.service
>>>>>>>>>>> [ 2168.593654]  D              mv  3814      2263.816953    186734
>>>>>>>>>>> 120         0.000000     30087.917319         0.000000 2 0 /user.slice
>>>>>>>>>>>
>>>>>>>>>>> any idea what is going on and how to fix this ?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> thx.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> Damien Le Moal
>>>>>>>>>> Western Digital Research
>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Damien Le Moal
>>>>>>> Western Digital Research
>>>>>
>>>>>
>>>>> --
>>>>> Damien Le Moal
>>>>> Western Digital Research
>>>
>>>
>>> --
>>> Damien Le Moal
>>> Western Digital Research


-- 
Damien Le Moal
Western Digital Research
