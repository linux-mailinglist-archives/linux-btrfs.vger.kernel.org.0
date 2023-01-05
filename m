Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54A65E5B0
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 07:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjAEGoY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 01:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjAEGoX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 01:44:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0AE4BD75
        for <linux-btrfs@vger.kernel.org>; Wed,  4 Jan 2023 22:44:21 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKbkC-1pVxpm34t2-00Kz0W; Thu, 05
 Jan 2023 07:44:19 +0100
Message-ID: <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com>
Date:   Thu, 5 Jan 2023 14:44:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Robert LeBlanc <robert@leblancnet.us>, linux-btrfs@vger.kernel.org
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: File system can't mount
In-Reply-To: <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:exgq/xOMS2lCZywyQMsUxb06elhTidlICnbdCH27ALd0+BkDh3B
 Dq0ak0QQw3CoD+ZeiZkvJNv2GVfXU0kCj+S4zLy6/uQBNWdYharAdx8x+bJ4HL+AKhVZtf7
 L0b/akRXNNFadlNtWIkFPvZIaiV7xIEbed8MqRifHgLejxDUgoDyycuaEYDMArvpuX+tf8y
 8VgQvvHJgZd9ooU5eAY3A==
UI-OutboundReport: notjunk:1;M01:P0:XYM7HZExfww=;a/GfSGDmPO47OzGi8zyy6U1re1t
 JaR8w27ECbq1eOgC8qWo7WJnvk53Tc66/iXntceQfw7CcPpYzvtZMWfbB/GI3nKCZZunI1akd
 8q1duO/hWQZu539FXy1iAYwZHwSKao347PmoXu24N9t0M2B7J94a1I843MD5L5ug4JAsFK7w/
 F+uwgRpDpzzc+SElg4EJGvpv6khTtVfwpTWsdW8bZi5srfAFHHCk8lbBWRmM1lmyQESl3mvYs
 vvOWkqE+5no7Ih8qRQEb8FSHz9WwwkbvH5PFZgoWfqyTuZGLRAqwLHiXj++Wl9yLRoDtZ9Fa4
 8wyUTSljxswVu6z+0WIPRXbnfrtmA01cWaplXbLTAOnt/bD0VMMcGG27hHR7xrQDEUfbnRqqY
 H+JMTRy6vKFrn3P95gnvApu38GU3e7QirLJ8aCDIulzS2DxpY/p8P+8gfDlCxW0S3fqzyZq3P
 mX700w0imV9mzKJkpJTThkpxfsQYD1myRj22+K5t62FKQHu0PneH+9T+ofXAQFCKEU0WCTmrR
 FgSkkKiQbsKEIJR322Lqsgbg6Mu5IP26YsO8F/mviQidG8p2SDjphVxf+1QS17bHVMg/ia8+A
 ipZzJQH19WnTWIK5a9ywkegbbWYB2iQIyUGAEDQfi6WIUYT1lCITVAC6gwhiEwG4O0LvVesjL
 7tll1byoYEzRN6UL/Uy1JXE5urxqI1bC+gulB1IrxtuY+FZv0JNlgl78SbgPBQPB3eyQcj6/h
 KyeTAf5nZtS+s6HAwKFlo8Z///zaJwe++ByIThLq+Fc6Dje5eYo+xjVdQEWNeMhD8PmbALVh7
 MU0h0EyuyrejrPw1ewgK1tSqkeoqKQCZ5z9K6CTaVKhV9rRXia6eKeU+pPrmlXaIEL08Lxjfb
 EUMl4n5ysSawsz7RCbBCb5LXu66ltNRDwTAWoskGsgG+b9azvXEnUTwGFLt8YeGDaLM/i8xxx
 YHzio0F2tppLirdyxxg850243Os=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/5 13:24, Robert LeBlanc wrote:
> On Wed, Jan 4, 2023 at 10:11 PM Robert LeBlanc <robert@leblancnet.us> wrote:
>>
>> I may have run into a new bug (I can't find anything in my Google
>> search other than a patch that exposes the issue). I had to recreate
>> my BTRFS file system about a year ago when I hit a bug in an earlier
>> kernel. I was able to pull a good snapshot from my backups (and mount
>> the old filesystem in read-only to get my media subvolume) and it had
>> been running great for at least a year. My file system went offline
>> today and just would not mount. I downloaded the latest btrfs-progs
>> from git to see if it could handle it better, but no luck. This is a
>> RAID-1 with 4 drives and the metadata is also RAID-1, but it looks
>> like both copies of the metadata are corrupted the same way which is
>> really odd and the drives show no errors. I tried taking the first
>> drive that it complained about offline and tried to mount with `-o
>> degraded` but it couldn't bring up the filesystem. It would be nice to
>> try and recover this as I have a subvolume with my media server that
>> isn't backed up because of the size, but the critical stuff is backed
>> up.
>>
>> Here is the `btrfs check` output:
>> ```
>> #:~/code/btrfs-progs$ sudo ./btrfs check /dev/mapper/1EV13X7B
>> Opening filesystem to check...
>> Checking filesystem on /dev/mapper/1EV13X7B
>> UUID: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
>> [1/7] checking root items
>> [2/7] checking extents
>> WARNING: tree block [12462950961152, 12462950977536) is not nodesize
>> aligned, may cause problem for 64K page system
>> ERROR: add_tree_backref failed (extent items tree block): File exists
>> ERROR: add_tree_backref failed (non-leaf block): File exists
>> tree backref 12462950957056 root 7 not found in extent tree
>> incorrect global backref count on 12462950957056 found 1 wanted 0
>> backpointer mismatch on [12462950957056 1]
>> extent item 12462950961152 has multiple extent items
>> ref mismatch on [12462950961152 16384] extent item 1, found 2
>> backref 12462950961152 root 7 not referenced back 0x56292931ae60
>> incorrect global backref count on 12462950961152 found 1 wanted 2
>> backpointer mismatch on [12462950961152 16384]
>> owner ref check failed [12462950961152 16384]
>> bad metadata [12462950961152, 12462950977536) crossing stripe boundary
>> data backref 12493662797824 root 13278 owner 193642 offset 0 num_refs
>> 0 not found in extent tree
>> incorrect local backref count on 12493662797824 root 13278 owner
>> 193642 offset 0 found 1 wanted 0 back 0x562920287070
>> incorrect local backref count on 12493662797824 root 17592186057694
>> owner 193642 offset 0 found 0 wanted 1 back 0x562929472ba0
>> backref disk bytenr does not match extent record,
>> bytenr=12493662797824, ref bytenr=0
>> backpointer mismatch on [12493662797824 24576]
>> ERROR: errors found in extent allocation tree or chunk allocation
>> [3/7] checking free space cache
>> there is no free space entry for 12462950957056-12462950961152
>> cache appears valid but isn't 12461878018048
>> [4/7] checking fs roots
>> [5/7] checking only csums items (without verifying data)
>> [6/7] checking root refs
>> [7/7] checking quota groups skipped (not enabled on this FS)
>> found 13920420491265 bytes used, error(s) found
>> total csum bytes: 13555483180
>> total tree bytes: 17152835584
>> total fs tree bytes: 1858191360
>> total extent tree bytes: 563019776
>> btree space waste bytes: 1424108973
>> file data blocks allocated: 28183758581760
>> referenced 19476700778496
>>
>> #:~/code/btrfs-progs$ git rev-parse HEAD
>> 1169f4ee63d900b25d9828a539cee4f59f8e9ad7
>> ```
>>
>> dmesg output:
>> ```
>> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): using crc32c
>> (crc32c-intel) checksum algorithm
>> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): allowing degraded mounts
>> [Wed Jan  4 19:52:39 2023] BTRFS info (device dm-5): disk space
>> caching is enabled
>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>> /dev/mapper/8HJK8KGH errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>> /dev/mapper/8HHW90DY errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>> /dev/mapper/1EV13X7B errs: wr 0, rd 0, flush 0, corrupt 18, gen 2
>> [Wed Jan  4 19:52:41 2023] BTRFS info (device dm-5): bdev
>> /dev/mapper/K1KLMBZN errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
>> [Wed Jan  4 19:52:41 2023] BTRFS critical (device dm-5): corrupt leaf:
>> block=45382409060352 slot=31 extent bytenr=12462950973440 len=16384
>> previous extent [12462950961152 169 0] overlaps current extent
>> [12462950973440 169 0]
>> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): read time tree
>> block corruption detected on logical 45382409060352 mirror 2
>> [Wed Jan  4 19:52:41 2023] BTRFS critical (device dm-5): corrupt leaf:
>> block=45382409060352 slot=31 extent bytenr=12462950973440 len=16384
>> previous extent [12462950961152 169 0] overlaps current extent
>> [12462950973440 169 0]

Sometimes I have to say, tree-checker is more to-the-point than btrfs-check.

It's very plain that one metadata backref item overlaps with the 
previous one.

Which can be very problematic (the content of tree block overlapping is 
not a good thing at all).

>> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): read time tree
>> block corruption detected on logical 45382409060352 mirror 1
>> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): failed to read
>> block groups: -5
>> [Wed Jan  4 19:52:41 2023] BTRFS error (device dm-5): open_ctree failed
>> ```
>>
>> Linux leblanc 6.0.0-6-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.0.12-1
>> (2022-12-09) x86_64 GNU/Linux
>>
>> #~/code/btrfs-progs$ sudo ./btrfs filesystem show /dev/mapper/1EV13X7B
>> Label: 'storage2'  uuid: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
>>         Total devices 4 FS bytes used 12.66TiB
>>         devid    3 size 10.91TiB used 9.10TiB path /dev/mapper/8HJK8KGH
>>         devid    4 size 10.91TiB used 9.10TiB path /dev/mapper/8HHW90DY
>>         devid    5 size 5.46TiB used 3.65TiB path /dev/mapper/1EV13X7B
>>         devid    6 size 5.46TiB used 3.65TiB path /dev/mapper/K1KLMBZN
>>
>> Let me know what would be useful, I've been using BTRFS since the
>> early days and want to help it get better.
> 
> As a test I booted back into the previous kernel and was able to mount
> the file system "just fine". My guess is that the patch I found
> uncovered a ticking time bomb.

That's mostly right, newer kernel has way more sanity checks to prevent 
any obvious bad data sneaking in.

Thus that's why older kernel just ignore it and continue mounting.

> Is there a way to fix it?

For the repair, it may be a little dangerous.

Thus before doing any repair, it's recommended to backup critical data 
first.
But considering how large the array is, I totally understand it can be 
hard...

Firstly, you can go "btrfs check --repair", since your fs only has 
several extent tree problems, it can be repaired.
But please use the latest btrfs-progs.

Thanks,
Qu
> 
> Linux leblanc 5.18.0-4-amd64 #1 SMP PREEMPT_DYNAMIC Debian 5.18.16-1
> (2022-08-10) x86_64 GNU/Linux
> 
> [Wed Jan  4 22:18:14 2023] BTRFS info (device dm-4): flagging fs with
> big metadata feature
> [Wed Jan  4 22:18:14 2023] BTRFS info (device dm-4): disk space
> caching is enabled
> [Wed Jan  4 22:18:14 2023] BTRFS info (device dm-4): has skinny extents
> [Wed Jan  4 22:18:15 2023] BTRFS info (device dm-4): bdev
> /dev/mapper/8HJK8KGH errs: wr 0, rd 0, flush 0, corrupt 4, gen 0
> [Wed Jan  4 22:18:15 2023] BTRFS info (device dm-4): bdev
> /dev/mapper/8HHW90DY errs: wr 0, rd 0, flush 0, corrupt 7, gen 0
> [Wed Jan  4 22:18:15 2023] BTRFS info (device dm-4): bdev
> /dev/mapper/1EV13X7B errs: wr 0, rd 0, flush 0, corrupt 18, gen 2
> [Wed Jan  4 22:18:15 2023] BTRFS info (device dm-4): bdev
> /dev/mapper/K1KLMBZN errs: wr 0, rd 0, flush 0, corrupt 8, gen 0
> [Wed Jan  4 22:19:35 2023] BTRFS info (device dm-4: state M): disk
> space caching is enabled
> 
> # btrfs filesystem show /mnt/storage
> Label: 'storage2'  uuid: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
>         Total devices 4 FS bytes used 12.66TiB
>         devid    3 size 10.91TiB used 9.10TiB path /dev/mapper/8HJK8KGH
>         devid    4 size 10.91TiB used 9.10TiB path /dev/mapper/8HHW90DY
>         devid    5 size 5.46TiB used 3.65TiB path /dev/mapper/1EV13X7B
>         devid    6 size 5.46TiB used 3.65TiB path /dev/mapper/K1KLMBZN
> 
> I'm going to kick off a scrub as I never got notification from my cron
> job that runs on the first that it completed.
> 
> Thank you,
> Robert LeBlanc
> ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
