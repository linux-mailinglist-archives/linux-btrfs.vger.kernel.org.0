Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C262AF52
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 00:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiKOXQS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 18:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbiKOXQE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 18:16:04 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB6864E8
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 15:16:03 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MMXUN-1odH3a3phf-00JdmO; Wed, 16
 Nov 2022 00:15:58 +0100
Message-ID: <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
Date:   Wed, 16 Nov 2022 07:15:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: block group x has wrong amount of free space
Content-Language: en-US
To:     Hendrik Friedel <hendrik@friedels.name>,
        linux-btrfs@vger.kernel.org
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qLri93RergaFz4qrdoJgkqn68+Tm6ByOp4N22pacvEL6sIDieC2
 QZ4bqwfD706KUrYfyIBxS/hrsX8N9i0BHebO5D/Z10H7gV6waLEf79eQUCixRBEfrlIxdfN
 vAtBHrtJRUxZV6dGga68LPyF61X2IW0vLqPSC07X7fwi77ozjg9BMkpObapbnPZR4WiLJkV
 jSxS+XnkAX8OpWUPi60+A==
UI-OutboundReport: notjunk:1;M01:P0:4xJhzqXnazo=;UeAANFhP+eaeOr5aHwkyld4GCke
 ZOrNr9BjCIPK7OYUgjkYqps1lySGgcOJqutu1iFVBFPLOI8nGMCDg41pC34OwER4Ny1/wKW22
 Hk0wxQY0sxCovv6xwcQyhQQDI/DQLcUEsoFcr+DSRG88v36jJBcgcDSCj+ldtyyMu0gxV6h1Q
 nFMWETIWo3W6LFrvxou4mmMOizQQl8fG7c/BA8gH1eflAYveb7l+5F3yQkq8Y0o59ku0qMrht
 h+JwABzZyHfpu7DM92UWnSkCwudHD8+ZBNsSSYkPM5+Xwyeh10UPz5RYcrbEjS9meZZCXjZGR
 UkY1anrQqgYDxTF/8jNAwWzBT+jC4aKaME107Fz3vT5X9Xkz9XQNkGLFxq30MMKh+ZhVPbRwf
 31QbChf0ZUnx3GvB3HYIclcva8fQHKZRqe2twKoR6N2QL5qDkqgrlxTwdLc29dMqE7zMsxcyP
 T+P19nE/4uj7akUeg0X/SsrucTTqKkCJaLoTNU2SJQ4R97/wElT+GgYqVLYqkhpHAgkzQuqUc
 kEqGjTwzKjQaIDh7XMytL50Xfl/h9qDSDJ2oepUTLK+u+ZV9ttXG8bUumXf7CCQqKyADyqfj8
 zuIywSGqHm8ZNBdq3c6QHEjm+aUIh+IqUIwWaGiwQ6bb5LQqYtneHNSOjQtnOeBWgyvlvmoLj
 J/1Cj+nLPt5Z6fDdzLY71ZmxnguE4eXGgSMuA8cWiuZgVgJXi1SoonchT52njGgqSIAmkOW0s
 VYoIcPR/OQJZjirBO41n+IBKzL20Tx9rJCedTFDtCfqoY/P8X/zCDG7BWOrn0OLo+AFirxsu9
 YR99dwtWGaBQ+BMPipmAvmwZCw/cmom/LZ5G5TOcm1voFwg5uy7eUoOqSo5M2gIeUl25KHChX
 1gDwjDuq36QwCbCHk13lPXy5pV5YqUD7GpmipizVFq2nr9AjzVf/1vU5CmdzeEfUNegqdNqAL
 VkDHApvkUaXBcRHeC9YEEfrfw30=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/16 06:05, Hendrik Friedel wrote:
> Hello,
> 
> I now ran btrfs check --clear-space-cache v1 /dev/sdb1
> Opening filesystem to check...
> dsChecking filesystem on /dev/sdb1
> UUID: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
> Failed to find [16500433649664, 168, 16384]

Unfortunately, this line and the kernel dmesg both shows that, your 
extent tree seems corrupted.

Thus a "btrfs check --readonly" run on that device would verify if the 
extent tree is really corrupted.

And after that, we can discuss how to continue.

Thanks,
Qu
> btrfs unable to find ref byte nr 16500433666048 parent 0 root 2  owner 0 
> offset 0
> transaction.c:195: btrfs_commit_transaction: BUG_ON `ret` triggered, 
> value -5
> btrfs(+0x456a7)[0x562c84e456a7]
> btrfs(btrfs_commit_transaction+0x26b)[0x562c84e45cf6]
> btrfs(btrfs_clear_free_space_cache+0xa4)[0x562c84e38f0b]
> btrfs(+0x5974c)[0x562c84e5974c]
> btrfs(cmd_check+0x8ca)[0x562c84e66743]
> btrfs(main+0x89)[0x562c84e13703]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f6dc5402d0a]
> btrfs(_start+0x2a)[0x562c84e1338a]
> Aborted.
> 
> I then ran mount /dev/sdb1 -o clear_cache /mnt/
> It ran without issue, but in the kernel log, I still see errors like:
> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state A) in 
> __btrfs_free_extent:3063: errno=-2 No such entry
> [Di Nov 15 22:42:18 2022] BTRFS info (device sdc1: state EA): forced 
> readonly
> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state EA) in 
> btrfs_run_delayed_refs:2141: errno=-2 No such entry
> [Di Nov 15 22:42:27 2022] BTRFS warning (device sdc1: state EA): 
> Skipping commit of aborted transaction.
> [Di Nov 15 22:42:27 2022] BTRFS: error (device sdc1: state EA) in 
> cleanup_transaction:1983: errno=-2 No such entry
> [Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): using crc32c 
> (crc32c-intel) checksum algorithm
> [Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): force clearing of 
> disk cache
> [Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): disk space caching 
> is enabled
> [Di Nov 15 22:48:28 2022] BTRFS error (device sdc1): qgroup generation 
> mismatch, marked as inconsistent
> [Di Nov 15 22:48:28 2022] BTRFS info (device sdc1): checking UUID tree
> [Di Nov 15 22:52:28 2022] INFO: task btrfs-transacti:1434591 blocked for 
> more than 120 seconds.
> 
> 
> [Di Nov 15 22:42:18 2022] CPU: 0 PID: 1408097 Comm: btrfs-transacti 
> Tainted: G            E      6.0.8 #1
> [Di Nov 15 22:42:18 2022] RIP: 0010:__btrfs_free_extent+0x6ba/0xa50 [btrfs]
> [Di Nov 15 22:42:18 2022]  ? btrfs_merge_delayed_refs+0x168/0x1a0 [btrfs]
> [Di Nov 15 22:42:18 2022]  __btrfs_run_delayed_refs+0x271/0x1070 [btrfs]
> [Di Nov 15 22:42:18 2022]  btrfs_run_delayed_refs+0x73/0x1f0 [btrfs]
> [Di Nov 15 22:42:18 2022]  btrfs_write_dirty_block_groups+0x184/0x3e0 
> [btrfs]
> [Di Nov 15 22:42:18 2022]  ? btrfs_run_delayed_refs+0x167/0x1f0 [btrfs]
> [Di Nov 15 22:42:18 2022]  commit_cowonly_roots+0x1e6/0x250 [btrfs]
> [Di Nov 15 22:42:18 2022]  btrfs_commit_transaction+0x548/0xcf0 [btrfs]
> [Di Nov 15 22:42:18 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
> [Di Nov 15 22:42:18 2022]  ? 
> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
> [Di Nov 15 22:42:18 2022] WARNING: CPU: 0 PID: 1408097 at 
> fs/btrfs/extent-tree.c:3063 __btrfs_free_extent+0x716/0xa50 [btrfs]
> 
> 
> [Di Nov 15 22:42:18 2022] CPU: 0 PID: 1408097 Comm: btrfs-transacti 
> Tainted: G        W   E      6.0.8 #1
> [Di Nov 15 22:42:18 2022] RIP: 0010:__btrfs_free_extent+0x716/0xa50 [btrfs]
> [Di Nov 15 22:42:18 2022]  ? btrfs_merge_delayed_refs+0x168/0x1a0 [btrfs]
> [Di Nov 15 22:42:18 2022]  __btrfs_run_delayed_refs+0x271/0x1070 [btrfs]
> [Di Nov 15 22:42:18 2022]  btrfs_run_delayed_refs+0x73/0x1f0 [btrfs]
> [Di Nov 15 22:42:18 2022]  btrfs_write_dirty_block_groups+0x184/0x3e0 
> [btrfs]
> [Di Nov 15 22:42:18 2022]  ? btrfs_run_delayed_refs+0x167/0x1f0 [btrfs]
> [Di Nov 15 22:42:18 2022]  commit_cowonly_roots+0x1e6/0x250 [btrfs]
> [Di Nov 15 22:42:18 2022]  btrfs_commit_transaction+0x548/0xcf0 [btrfs]
> [Di Nov 15 22:42:18 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
> [Di Nov 15 22:42:18 2022]  ? 
> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state A) in 
> __btrfs_free_extent:3063: errno=-2 No such entry
> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state EA) in 
> btrfs_run_delayed_refs:2141: errno=-2 No such entry
> [Di Nov 15 22:52:28 2022] INFO: task btrfs-transacti:1434591 blocked for 
> more than 120 seconds.
> [Di Nov 15 22:52:28 2022] task:btrfs-transacti state:D stack:    0 
> pid:1434591 ppid:     2 flags:0x00004000
> [Di Nov 15 22:52:28 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
> [Di Nov 15 22:52:28 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
> [Di Nov 15 22:52:28 2022]  ? 
> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
> [Di Nov 15 22:54:29 2022] INFO: task btrfs-transacti:1434591 blocked for 
> more than 241 seconds.
> [Di Nov 15 22:54:29 2022] task:btrfs-transacti state:D stack:    0 
> pid:1434591 ppid:     2 flags:0x00004000
> [Di Nov 15 22:54:29 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
> [Di Nov 15 22:54:29 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
> [Di Nov 15 22:54:29 2022]  ? 
> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
> [Di Nov 15 22:56:30 2022] INFO: task btrfs-transacti:1434591 blocked for 
> more than 362 seconds.
> [Di Nov 15 22:56:30 2022] task:btrfs-transacti state:D stack:    0 
> pid:1434591 ppid:     2 flags:0x00004000
> [Di Nov 15 22:56:30 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
> [Di Nov 15 22:56:30 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
> [Di Nov 15 22:56:30 2022]  ? 
> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
> [Di Nov 15 22:58:30 2022] INFO: task btrfs-transacti:1434591 blocked for 
> more than 483 seconds.
> [Di Nov 15 22:58:30 2022] task:btrfs-transacti state:D stack:    0 
> pid:1434591 ppid:     2 flags:0x00004000
> [Di Nov 15 22:58:30 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
> [Di Nov 15 22:58:30 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
> [Di Nov 15 22:58:30 2022]  ? 
> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
> 
> 
> Best regards,
> Hendrik
> 
> 
> ------ Originalnachricht ------
> Von "Hendrik Friedel" <hendrik@friedels.name>
> An linux-btrfs@vger.kernel.org
> Datum 14.11.2022 23:41:40
> Betreff block group x has wrong amount of free space
> 
>> Hello,
>>
>> I noticed very high load on my system (not CPU utilization, but load). 
>> I was able to trace it down to a slow reaction of my btrfs filesystem, 
>> whilst iotop showed very low r/w activity.
>>
>> Thus, I startet btrfs check (ro).
>> It found:
>> block group 30060743819264 has wrong amount of free space, free space 
>> cache has 45056 block group has 49152
>> failed to load free space cache for block group 30060743819264
>>
>> Now, I found sources telling me to clear the space cache. Some suggest 
>> to use the mount option, others to use btrfs check --clear-space-cache 
>> [v1 or v2].
>>
>> Can you please advice me, what the best way forward is - and how to 
>> prevent this to happen again?
>>
>> Below you find further information on my system. btrfs df cannot run 
>> currently, as btrfs check is running. I had to zip the dmesg.log that 
>> is requested in the wiki.
>> When the issue occured, I was still running linux-5.19.2 (I did not 
>> yet notice when updating the kernel).
>>
>> Best regards and thanks for your help in advance,
>> Hendrik
>>
>>
>> root@homeserver:/home/henfri#   uname -a
>> Linux homeserver 6.0.8 #1 SMP PREEMPT_DYNAMIC Sat Nov 12 14:18:32 CET 
>> 2022 x86_64 GNU/Linux
>> root@homeserver:/home/henfri#   btrfs --version
>> btrfs-progs v4.20.2
>> root@homeserver:/home/henfri#   btrfs fi show
>> Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>>         Total devices 1 FS bytes used 162.58GiB
>>         devid    1 size 198.45GiB used 198.45GiB path /dev/sda3
>>
>> Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>         Total devices 2 FS bytes used 9.87TiB
>>         devid    1 size 10.91TiB used 9.89TiB path /dev/sdc1
>>         devid    2 size 10.91TiB used 9.89TiB path /dev/sdb1
>>
>>
> 
