Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA762BC90
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Nov 2022 12:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbiKPLwh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 16 Nov 2022 06:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiKPLvv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Nov 2022 06:51:51 -0500
Received: from sm-r-002-dus.org-dns.com (sm-r-002-dus.org-dns.com [89.107.70.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADF011C2C
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 03:40:40 -0800 (PST)
Received: from smarthost-dus.org-dns.com (localhost [127.0.0.1])
        by smarthost-dus.org-dns.com (Postfix) with ESMTP id 6DDBEA0B39
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Nov 2022 12:40:38 +0100 (CET)
Received: by smarthost-dus.org-dns.com (Postfix, from userid 1001)
        id 60AE8A0B52; Wed, 16 Nov 2022 12:40:38 +0100 (CET)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from ha01s030.org-dns.com (ha01s030.org-dns.com [62.108.32.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smarthost-dus.org-dns.com (Postfix) with ESMTPS id 24E0EA0B39;
        Wed, 16 Nov 2022 12:40:37 +0100 (CET)
Authentication-Results: ha01s030.org-dns.com;
        spf=pass (sender IP is 94.31.96.101) smtp.mailfrom=hendrik@friedels.name smtp.helo=[192.168.177.41]
Received-SPF: pass (ha01s030.org-dns.com: connection is authenticated)
From:   "Hendrik Friedel" <hendrik@friedels.name>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Subject: Re[2]: block group x has wrong amount of free space
Date:   Wed, 16 Nov 2022 11:40:35 +0000
Message-Id: <emca736322-38d8-49ca-9c93-083a5bbe946f@7b52163e.com>
In-Reply-To: <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
References: <em9da2c7f3-31bb-426b-89a3-51fd1dea8968@7b52163e.com>
 <em7df90458-9cac-4818-8a43-0d59e69a14fc@7b52163e.com>
 <ff2940de-babf-d83c-b9d0-1fe8d18909a9@gmx.com>
Reply-To: "Hendrik Friedel" <hendrik@friedels.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-PPP-Message-ID: <166859885865.15595.5933254088402526745@ha01s030.org-dns.com>
X-PPP-Vhost: friedels.name
X-POWERED-BY: wint.global - AV:CLEAN SPAM:OK
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello Qu,

thanks for your help. That's bad news :-(
I ran btrfs check now, with this output:
[1/7] checking root items
[2/7] checking extents
ref mismatch on [16500433387520 16384] extent item 1, found 0
backref 16500433387520 root 2 not referenced back 0x55a783c592d0
incorrect global backref count on 16500433387520 found 1 wanted 0
backpointer mismatch on [16500433387520 16384]
owner ref check failed [16500433387520 16384]
ref mismatch on [16500433666048 16384] extent item 0, found 1
tree backref 16500433666048 parent 2 root 2 not found in extent tree
backpointer mismatch on [16500433666048 16384]
ERROR: errors found in extent allocation tree or chunk allocation
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
found 10848863825921 bytes used, error(s) found
total csum bytes: 10584151620
total tree bytes: 14628896768
total fs tree bytes: 1877082112
total extent tree bytes: 897548288
btree space waste bytes: 1633585295
file data blocks allocated: 20692111388672
  referenced 13014020022272

How bad is it?

Best regards,
Hendrik

------ Originalnachricht ------
Von "Qu Wenruo" <quwenruo.btrfs@gmx.com>
An "Hendrik Friedel" <hendrik@friedels.name>; 
linux-btrfs@vger.kernel.org
Datum 16.11.2022 00:15:55
Betreff Re: block group x has wrong amount of free space

>
>
>On 2022/11/16 06:05, Hendrik Friedel wrote:
>>Hello,
>>
>>I now ran btrfs check --clear-space-cache v1 /dev/sdb1
>>Opening filesystem to check...
>>dsChecking filesystem on /dev/sdb1
>>UUID: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>Failed to find [16500433649664, 168, 16384]
>
>Unfortunately, this line and the kernel dmesg both shows that, your extent tree seems corrupted.
>
>Thus a "btrfs check --readonly" run on that device would verify if the extent tree is really corrupted.
>
>And after that, we can discuss how to continue.
>
>Thanks,
>Qu
>>btrfs unable to find ref byte nr 16500433666048 parent 0 root 2  owner 0 offset 0
>>transaction.c:195: btrfs_commit_transaction: BUG_ON `ret` triggered, value -5
>>btrfs(+0x456a7)[0x562c84e456a7]
>>btrfs(btrfs_commit_transaction+0x26b)[0x562c84e45cf6]
>>btrfs(btrfs_clear_free_space_cache+0xa4)[0x562c84e38f0b]
>>btrfs(+0x5974c)[0x562c84e5974c]
>>btrfs(cmd_check+0x8ca)[0x562c84e66743]
>>btrfs(main+0x89)[0x562c84e13703]
>>/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xea)[0x7f6dc5402d0a]
>>btrfs(_start+0x2a)[0x562c84e1338a]
>>Aborted.
>>
>>I then ran mount /dev/sdb1 -o clear_cache /mnt/
>>It ran without issue, but in the kernel log, I still see errors like:
>>[Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state A) in __btrfs_free_extent:3063: errno=-2 No such entry
>>[Di Nov 15 22:42:18 2022] BTRFS info (device sdc1: state EA): forced readonly
>>[Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state EA) in btrfs_run_delayed_refs:2141: errno=-2 No such entry
>>[Di Nov 15 22:42:27 2022] BTRFS warning (device sdc1: state EA): Skipping commit of aborted transaction.
>>[Di Nov 15 22:42:27 2022] BTRFS: error (device sdc1: state EA) in cleanup_transaction:1983: errno=-2 No such entry
>>[Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): using crc32c (crc32c-intel) checksum algorithm
>>[Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): force clearing of disk cache
>>[Di Nov 15 22:47:33 2022] BTRFS info (device sdc1): disk space caching is enabled
>>[Di Nov 15 22:48:28 2022] BTRFS error (device sdc1): qgroup generation mismatch, marked as inconsistent
>>[Di Nov 15 22:48:28 2022] BTRFS info (device sdc1): checking UUID tree
>>[Di Nov 15 22:52:28 2022] INFO: task btrfs-transacti:1434591 blocked for more than 120 seconds.
>>
>>
>>[Di Nov 15 22:42:18 2022] CPU: 0 PID: 1408097 Comm: btrfs-transacti Tainted: G            E      6.0.8 #1
>>[Di Nov 15 22:42:18 2022] RIP: 0010:__btrfs_free_extent+0x6ba/0xa50 [btrfs]
>>[Di Nov 15 22:42:18 2022]  ? btrfs_merge_delayed_refs+0x168/0x1a0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  __btrfs_run_delayed_refs+0x271/0x1070 [btrfs]
>>[Di Nov 15 22:42:18 2022]  btrfs_run_delayed_refs+0x73/0x1f0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  btrfs_write_dirty_block_groups+0x184/0x3e0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  ? btrfs_run_delayed_refs+0x167/0x1f0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  commit_cowonly_roots+0x1e6/0x250 [btrfs]
>>[Di Nov 15 22:42:18 2022]  btrfs_commit_transaction+0x548/0xcf0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>[Di Nov 15 22:42:18 2022] WARNING: CPU: 0 PID: 1408097 at fs/btrfs/extent-tree.c:3063 __btrfs_free_extent+0x716/0xa50 [btrfs]
>>
>>
>>[Di Nov 15 22:42:18 2022] CPU: 0 PID: 1408097 Comm: btrfs-transacti Tainted: G        W   E      6.0.8 #1
>>[Di Nov 15 22:42:18 2022] RIP: 0010:__btrfs_free_extent+0x716/0xa50 [btrfs]
>>[Di Nov 15 22:42:18 2022]  ? btrfs_merge_delayed_refs+0x168/0x1a0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  __btrfs_run_delayed_refs+0x271/0x1070 [btrfs]
>>[Di Nov 15 22:42:18 2022]  btrfs_run_delayed_refs+0x73/0x1f0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  btrfs_write_dirty_block_groups+0x184/0x3e0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  ? btrfs_run_delayed_refs+0x167/0x1f0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  commit_cowonly_roots+0x1e6/0x250 [btrfs]
>>[Di Nov 15 22:42:18 2022]  btrfs_commit_transaction+0x548/0xcf0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>[Di Nov 15 22:42:18 2022]  ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>[Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state A) in __btrfs_free_extent:3063: errno=-2 No such entry
>>[Di Nov 15 22:42:18 2022] BTRFS: error (device sdc1: state EA) in btrfs_run_delayed_refs:2141: errno=-2 No such entry
>>[Di Nov 15 22:52:28 2022] INFO: task btrfs-transacti:1434591 blocked for more than 120 seconds.
>>[Di Nov 15 22:52:28 2022] task:btrfs-transacti state:D stack:    0 pid:1434591 ppid:     2 flags:0x00004000
>>[Di Nov 15 22:52:28 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>[Di Nov 15 22:52:28 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>[Di Nov 15 22:52:28 2022]  ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>[Di Nov 15 22:54:29 2022] INFO: task btrfs-transacti:1434591 blocked for more than 241 seconds.
>>[Di Nov 15 22:54:29 2022] task:btrfs-transacti state:D stack:    0 pid:1434591 ppid:     2 flags:0x00004000
>>[Di Nov 15 22:54:29 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>[Di Nov 15 22:54:29 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>[Di Nov 15 22:54:29 2022]  ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>[Di Nov 15 22:56:30 2022] INFO: task btrfs-transacti:1434591 blocked for more than 362 seconds.
>>[Di Nov 15 22:56:30 2022] task:btrfs-transacti state:D stack:    0 pid:1434591 ppid:     2 flags:0x00004000
>>[Di Nov 15 22:56:30 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>[Di Nov 15 22:56:30 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>[Di Nov 15 22:56:30 2022]  ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>[Di Nov 15 22:58:30 2022] INFO: task btrfs-transacti:1434591 blocked for more than 483 seconds.
>>[Di Nov 15 22:58:30 2022] task:btrfs-transacti state:D stack:    0 pid:1434591 ppid:     2 flags:0x00004000
>>[Di Nov 15 22:58:30 2022]  btrfs_commit_transaction+0xb13/0xcf0 [btrfs]
>>[Di Nov 15 22:58:30 2022]  transaction_kthread+0x13d/0x1b0 [btrfs]
>>[Di Nov 15 22:58:30 2022]  ? btrfs_cleanup_transaction.isra.0+0x590/0x590 [btrfs]
>>
>>
>>Best regards,
>>Hendrik
>>
>>
>>------ Originalnachricht ------
>>Von "Hendrik Friedel" <hendrik@friedels.name>
>>An linux-btrfs@vger.kernel.org
>>Datum 14.11.2022 23:41:40
>>Betreff block group x has wrong amount of free space
>>
>>>Hello,
>>>
>>>I noticed very high load on my system (not CPU utilization, but load). I was able to trace it down to a slow reaction of my btrfs filesystem, whilst iotop showed very low r/w activity.
>>>
>>>Thus, I startet btrfs check (ro).
>>>It found:
>>>block group 30060743819264 has wrong amount of free space, free space cache has 45056 block group has 49152
>>>failed to load free space cache for block group 30060743819264
>>>
>>>Now, I found sources telling me to clear the space cache. Some suggest to use the mount option, others to use btrfs check --clear-space-cache [v1 or v2].
>>>
>>>Can you please advice me, what the best way forward is - and how to prevent this to happen again?
>>>
>>>Below you find further information on my system. btrfs df cannot run currently, as btrfs check is running. I had to zip the dmesg.log that is requested in the wiki.
>>>When the issue occured, I was still running linux-5.19.2 (I did not yet notice when updating the kernel).
>>>
>>>Best regards and thanks for your help in advance,
>>>Hendrik
>>>
>>>
>>>root@homeserver:/home/henfri#   uname -a
>>>Linux homeserver 6.0.8 #1 SMP PREEMPT_DYNAMIC Sat Nov 12 14:18:32 CET 2022 x86_64 GNU/Linux
>>>root@homeserver:/home/henfri#   btrfs --version
>>>btrfs-progs v4.20.2
>>>root@homeserver:/home/henfri#   btrfs fi show
>>>Label: none  uuid: c1534c07-d669-4f55-ae50-b87669ecb259
>>>         Total devices 1 FS bytes used 162.58GiB
>>>         devid    1 size 198.45GiB used 198.45GiB path /dev/sda3
>>>
>>>Label: 'DataPool1'  uuid: c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
>>>         Total devices 2 FS bytes used 9.87TiB
>>>         devid    1 size 10.91TiB used 9.89TiB path /dev/sdc1
>>>         devid    2 size 10.91TiB used 9.89TiB path /dev/sdb1
>>>
>>>
>>

