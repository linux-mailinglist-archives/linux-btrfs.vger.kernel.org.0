Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE3E62BC93
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 12:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiKPLxG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Nov 2022 06:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiKPLwc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 06:52:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21145A37
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 03:41:58 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJqN-1pI0i82NxT-00nOOV; Wed, 16
 Nov 2022 12:41:56 +0100
Message-ID: <bcb7a3f2-fa48-1846-e983-2e1ed771275e@gmx.com>
Date:   Wed, 16 Nov 2022 19:41:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: block group x has wrong amount of free space
Content-Language: en-US
To:     Hendrik Friedel <hendrik@friedels.name>,
        linux-btrfs@vger.kernel.org
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
 <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
 <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2gFHfsfYq1+rOAYHgifImIjlO4jGndGMk+f0kXfwma3baA6WmAw
 YslVCFOJLApw/6mZajJIi/vpttxJD1J/dj289yrYUOkeKEYpMRer1pWnVJR21J3pSikn2ka
 DvZVGfgxWvHuJl1Hu+cIktySjIDobT6E0vTjFaBszRXnYhH/fiokDFFXaYkQNvY/ZEN+dRd
 iPOq+5ypijT41x4JCyc3A==
UI-OutboundReport: notjunk:1;M01:P0:QuL8EqwcTHY=;jVrWwNTYMtSiK8CHjnhRQjRLCT/
 tRLxeOLQjVtWEsN24TGfNFKp0H7go3jlYjW57PKI0UMNeZT5tpSKPGR+aaLmHSqOseJt7jaFp
 yz5L+CBiD1px6wwx1DgLnpCvyOgVsTBiApg8bFsYMgxaBMcvwzAQqDujFWC/WMB38AF7aqcyt
 gM6C8Poq/OxJaz264uq+xon79QnrNHl44kyh9rj3zcsWAbFscLV6BDnvzn00zYwwbQkL6UjUz
 N7iMZrDivaE1wIJuuGBZjOTUcPgTBd64MeI6TAnsCAlq984EySk8Y3Rkej/qwd3ixWh2FEzit
 PO6SIifk9eptz6k17n6r7sRr267pSukfcQd/Su0HErzx7pUApO3PL+tpKF07MTIsjXySRadUO
 UfYIa7ds1PUg4WYc6hAd18ji2tT+zGKh9WZ+J2dRKnwL4+EGYxkMB3G8xpQ4ethk+3Y6OHxDG
 jlKMhlVcrQAqgMzOmInb4nbxyhr1NziU4MCGuQU4fEg/wSt89rSiU+2Tghz98krjAbuatuPms
 7pKjWdhSytlvjNHGA7jzgEk0SCTKLRuAMKpaDOVDFckD7aluvpvTTz63MO9mcTjdenQ5buMv4
 m0ihlCcPgEQNc3BtQVjxvQY4/Ywa68fbQgGyQ0cPJH9MxuVuQPhi4dERY6ZIeK9i58iQzzl9G
 J64rSAPkgG8sxuztqslXGgdoZEgxu21+mBzKqkHVPaXKGjdpquoDJ4uk1vnyJRcnDA1dzmtK1
 rZq4IkE9+RiK3dirSmrOnGNBLffhUQvdcPpebUKnyhW9VexC+2Wog60UMkFpam9YkosgZvyKC
 BLuD/oJWXu21rdYq4u6Tk4PSn+sTufB4v+kcESO9Fbrs2paZsQo3k4ifUyldqNmyXr4Guj6R0
 DW115daDDlffocRmYuWSDPNni+g5MVv4aK6rm4FWbv8NTqhjCdXw47lsGEMknNeP/tX3qS1IT
 HC2yyCWoUBgo7uJE8RwcIcfCN4s=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/16 19:40, Hendrik Friedel wrote:
> Hello Qu,
> 
> thanks for your help. That's bad news :-(
> I ran btrfs check now, with this output:
> [1/7] checking root items
> [2/7] checking extents
> ref mismatch on [16500433387520 16384] extent item 1, found 0
> backref 16500433387520 root 2 not referenced back 0x55a783c592d0
> incorrect global backref count on 16500433387520 found 1 wanted 0
> backpointer mismatch on [16500433387520 16384]
> owner ref check failed [16500433387520 16384]
> ref mismatch on [16500433666048 16384] extent item 0, found 1
> tree backref 16500433666048 parent 2 root 2 not found in extent tree
> backpointer mismatch on [16500433666048 16384]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups
> found 10848863825921 bytes used, error(s) found
> total csum bytes: 10584151620
> total tree bytes: 14628896768
> total fs tree bytes: 1877082112
> total extent tree bytes: 897548288
> btree space waste bytes: 1633585295
> file data blocks allocated: 20692111388672
>   referenced 13014020022272
> 
> How bad is it?

Not that bad, "btrfs check --repair" should be able to fix.

After that, feel free to clear cache again and migrate to v2 cache.

Thanks,
Qu
> 
> Best regards,
> Hendrik
> 
> ------ Originalnachricht ------
> Von "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> An "Hendrik Friedel" <hendrik@friedels.name>; linux-btrfs@vger.kernel.org
> Datum 16.11.2022 00:15:55
> Betreff Re: block group x has wrong amount of free space
> 
>>
>>
>> On 2022/11/16 06:05, Hendrik Friedel wrote:
>>> Hello,
>>>
>>> I now ran btrfs check --clear-space-cache v1 /dev/sdb1
>>> Opening filesystem to check...
>>> dsChecking filesystem on /dev/sdb1
>>> UUID: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>> Failed to find [16500433649664, 168, 16384]
>>
>> Unfortunately, this line and the kernel dmesg both shows that, your 
>> extent tree seems corrupted.
>>
>> Thus a "btrfs check --readonly" run on that device would verify if the 
>> extent tree is really corrupted.
>>
>> And after that, we can discuss how to continue.
>>
>> Thanks,
>> Qu
>>> btrfs unable to find ref byte nr 16500433666048 parent 0 root 2  
>>> owner 0 offset 0
>>> transaction.c:195: btrfs_commit_transaction: BUG_ON `ret` triggered, 
>>> value -5
>>> btrfs(+0x456a7)[0x562c84e456a7]
>>> btrfs(btrfs_commit_transaction+0x26b)[0x562c84e45cf6]
>>> btrfs(btrfs_clear_free_space_cache+0xa4)[0x562c84e38f0b]
>>> btrfs(+0x5974c)[0x562c84e5974c]
>>> btrfs(cmd_check+0x8ca)[0x562c84e66743]
>>> btrfs(main+0x89)[0x562c84e13703]
>>> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f6dc5402d0a]
>>> btrfs(_start+0x2a)[0x562c84e1338a]
>>> Aborted.
>>>
>>> I then ran mount /dev/sdb1 -o clear_cache /mnt/
>>> It ran without issue, but in the kernel log, I still see errors like:
>>> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state A) in 
>>> __btrfs_free_extent:3063: errno=-2 No such entry
>>> [Di Nov 15 22:42:18 2022] BTRFS info (device sdc1: state EA): forced 
>>> readonly
>>> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state EA) in 
>>> btrfs_run_delayed_refs:2141: errno=-2 No such entry
>>> [Di Nov 15 22:42:27 2022] BTRFS warning (device sdc1: state EA): 
>>> Skipping commit of aborted transaction.
>>> [Di Nov 15 22:42:27 2022] BTRFS: error (device sdc1: state EA) in 
>>> cleanup_transaction:1983: errno=-2 No such entry
>>> [Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): using crc32c 
>>> (crc32c-intel) checksum algorithm
>>> [Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): force clearing of 
>>> disk cache
>>> [Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): disk space 
>>> caching is enabled
>>> [Di Nov 15 22:48:28 2022] BTRFS error (device sdc1): qgroup 
>>> generation mismatch, marked as inconsistent
>>> [Di Nov 15 22:48:28 2022] BTRFS info (device sdc1): checking UUID tree
>>> [Di Nov 15 22:52:28 2022] INFO: task btrfs-transacti:1434591 blocked 
>>> for more than 120 seconds.
>>>
>>>
>>> [Di Nov 15 22:42:18 2022] CPU: 0 PID: 1408097 Comm: btrfs-transacti 
>>> Tainted: G            E      6.0.8 #1
>>> [Di Nov 15 22:42:18 2022] RIP: 0010:__btrfs_free_extent+0x6ba/0xa50 
>>> [btrfs]
>>> [Di Nov 15 22:42:18 2022]  ? btrfs_merge_delayed_refs+0x168/0x1a0 
>>> [btrfs]
>>> [Di Nov 15 22:42:18 2022]  __btrfs_run_delayed_refs+0x271/0x1070 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  btrfs_run_delayed_refs+0x73/0x1f0 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  btrfs_write_dirty_block_groups+0x184/0x3e0 
>>> [btrfs]
>>> [Di Nov 15 22:42:18 2022]  ? btrfs_run_delayed_refs+0x167/0x1f0 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  commit_cowonly_roots+0x1e6/0x250 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  btrfs_commit_transaction+0x548/0xcf0 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  ? 
>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>> [Di Nov 15 22:42:18 2022] WARNING: CPU: 0 PID: 1408097 at 
>>> fs/btrfs/extent-tree.c:3063 __btrfs_free_extent+0x716/0xa50 [btrfs]
>>>
>>>
>>> [Di Nov 15 22:42:18 2022] CPU: 0 PID: 1408097 Comm: btrfs-transacti 
>>> Tainted: G        W   E      6.0.8 #1
>>> [Di Nov 15 22:42:18 2022] RIP: 0010:__btrfs_free_extent+0x716/0xa50 
>>> [btrfs]
>>> [Di Nov 15 22:42:18 2022]  ? btrfs_merge_delayed_refs+0x168/0x1a0 
>>> [btrfs]
>>> [Di Nov 15 22:42:18 2022]  __btrfs_run_delayed_refs+0x271/0x1070 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  btrfs_run_delayed_refs+0x73/0x1f0 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  btrfs_write_dirty_block_groups+0x184/0x3e0 
>>> [btrfs]
>>> [Di Nov 15 22:42:18 2022]  ? btrfs_run_delayed_refs+0x167/0x1f0 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  commit_cowonly_roots+0x1e6/0x250 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  btrfs_commit_transaction+0x548/0xcf0 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>> [Di Nov 15 22:42:18 2022]  ? 
>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state A) in 
>>> __btrfs_free_extent:3063: errno=-2 No such entry
>>> [Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state EA) in 
>>> btrfs_run_delayed_refs:2141: errno=-2 No such entry
>>> [Di Nov 15 22:52:28 2022] INFO: task btrfs-transacti:1434591 blocked 
>>> for more than 120 seconds.
>>> [Di Nov 15 22:52:28 2022] task:btrfs-transacti state:D stack:    0 
>>> pid:1434591 ppid:     2 flags:0x00004000
>>> [Di Nov 15 22:52:28 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>> [Di Nov 15 22:52:28 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>> [Di Nov 15 22:52:28 2022]  ? 
>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>> [Di Nov 15 22:54:29 2022] INFO: task btrfs-transacti:1434591 blocked 
>>> for more than 241 seconds.
>>> [Di Nov 15 22:54:29 2022] task:btrfs-transacti state:D stack:    0 
>>> pid:1434591 ppid:     2 flags:0x00004000
>>> [Di Nov 15 22:54:29 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>> [Di Nov 15 22:54:29 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>> [Di Nov 15 22:54:29 2022]  ? 
>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>> [Di Nov 15 22:56:30 2022] INFO: task btrfs-transacti:1434591 blocked 
>>> for more than 362 seconds.
>>> [Di Nov 15 22:56:30 2022] task:btrfs-transacti state:D stack:    0 
>>> pid:1434591 ppid:     2 flags:0x00004000
>>> [Di Nov 15 22:56:30 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>> [Di Nov 15 22:56:30 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>> [Di Nov 15 22:56:30 2022]  ? 
>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>> [Di Nov 15 22:58:30 2022] INFO: task btrfs-transacti:1434591 blocked 
>>> for more than 483 seconds.
>>> [Di Nov 15 22:58:30 2022] task:btrfs-transacti state:D stack:    0 
>>> pid:1434591 ppid:     2 flags:0x00004000
>>> [Di Nov 15 22:58:30 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>> [Di Nov 15 22:58:30 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>> [Di Nov 15 22:58:30 2022]  ? 
>>> btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>>
>>>
>>> Best regards,
>>> Hendrik
>>>
>>>
>>> ------ Originalnachricht ------
>>> Von "Hendrik Friedel" <hendrik@friedels.name>
>>> An linux-btrfs@vger.kernel.org
>>> Datum 14.11.2022 23:41:40
>>> Betreff block group x has wrong amount of free space
>>>
>>>> Hello,
>>>>
>>>> I noticed very high load on my system (not CPU utilization, but 
>>>> load). I was able to trace it down to a slow reaction of my btrfs 
>>>> filesystem, whilst iotop showed very low r/w activity.
>>>>
>>>> Thus, I startet btrfs check (ro).
>>>> It found:
>>>> block group 30060743819264 has wrong amount of free space, free 
>>>> space cache has 45056 block group has 49152
>>>> failed to load free space cache for block group 30060743819264
>>>>
>>>> Now, I found sources telling me to clear the space cache. Some 
>>>> suggest to use the mount option, others to use btrfs check 
>>>> --clear-space-cache [v1 or v2].
>>>>
>>>> Can you please advice me, what the best way forward is - and how to 
>>>> prevent this to happen again?
>>>>
>>>> Below you find further information on my system. btrfs df cannot run 
>>>> currently, as btrfs check is running. I had to zip the dmesg.log 
>>>> that is requested in the wiki.
>>>> When the issue occured, I was still running linux-5.19.2 (I did not 
>>>> yet notice when updating the kernel).
>>>>
>>>> Best regards and thanks for your help in advance,
>>>> Hendrik
>>>>
>>>>
>>>> root@homeserver:/home/henfri#   uname -a
>>>> Linux homeserver 6.0.8 #1 SMP PREEMPT_DYNAMIC Sat Nov 12 14:18:32 
>>>> CET 2022 x86_64 GNU/Linux
>>>> root@homeserver:/home/henfri#   btrfs --version
>>>> btrfs-progs v4.20.2
>>>> root@homeserver:/home/henfri#   btrfs fi show
>>>> Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>>>>         Total devices 1 FS bytes used 162.58GiB
>>>>         devid    1 size 198.45GiB used 198.45GiB path /dev/sda3
>>>>
>>>> Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>>>         Total devices 2 FS bytes used 9.87TiB
>>>>         devid    1 size 10.91TiB used 9.89TiB path /dev/sdc1
>>>>         devid    2 size 10.91TiB used 9.89TiB path /dev/sdb1
>>>>
>>>>
>>>
> 
