Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9525E65A87C
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Jan 2023 01:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjAAAih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 31 Dec 2022 19:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjAAAig (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 31 Dec 2022 19:38:36 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386E76274
        for <linux-btrfs@vger.kernel.org>; Sat, 31 Dec 2022 16:38:34 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9MpS-1ohtA33ZES-015Hb1 for
 <linux-btrfs@vger.kernel.org>; Sun, 01 Jan 2023 01:38:32 +0100
Message-ID: <d13c2454-b642-2db7-371e-b669fdf24279@gmx.com>
Date:   Sun, 1 Jan 2023 08:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <CACsxjPaFgBMRkeEgbHcGwM7czSrjtakX9hSKXQq7RL2wJZYYCA@mail.gmail.com>
 <CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Buggy behaviour after replacing failed disk in RAID1
In-Reply-To: <CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:n/hZvAbZ8yshfhszrplLVWxZ1cJI3WxhB2B4Qf1NerjrxE/fxhm
 LzrT0I1SiaVwLvKFCxg07S/kgpijaRy1T8OqvkJ6HiOvw4olvT9j2Az1iC/zpKCjYLx+RWc
 UjhC5ZQtdsjVGH0yP1vphQzndOPHo4VNz5/ne4VUYM6ZtDo49/siqd4vAA9nc8utQ7w8oKq
 7LwfnpyaEiSMatcp8unZA==
UI-OutboundReport: notjunk:1;M01:P0:Ya75rZqh47o=;6AD2X67imOPO18J1KR2M93gVgmZ
 ByeTZ9rJGYesefou1aIGtCEBylJnvkWKiCy70aNIqAmlidYVbes1W+pbMCibOLVYBlDYdX4tV
 khWgwJ9c/cHY+jSB5/gVgTg2xU667AVWQpqGS1D3DUEVV2rnsyN/eB2/lxk2h2zqUBHK4hUGL
 q2ZEsqECelFn5PSm1e4gGZkK7cmcX62hijPO6xQcjmLuxZww7HkiBggHC/CmKcqM/y11hRNsd
 6L0u4w1UXG+7gCcARTla6oIfBMZ8sen7dGzcHyWiFa4HZLqVu5qHgCA4++YgHmh9DYU0MUYul
 jJHSYjIafKVAG59MGlAspMvNfCANNCi8DGefNLuZ+UppYhhNnuSENh3c1pC/sT8M5sz/mrF/r
 K5JqUGnSeYFNFUCAwDWieo90QFTPsB5XOosp5nzO7/lz018DpJRIUmcnS013SAvCYzqkbG+ru
 LmaTVMs3WsX9pzvvghQYyS1WnIXqu7W+Nkfpf2f8chhAckvgfFubxPFd0xTEsxsXx5VNs6Aci
 io4D1pD/2XyyCkUDOq90sopTwtMo1mkJyIE+h8aA4Chd3/bMOaAxCj+y6Db5/g3ewOnTiWiKd
 w9mYeIL4vKXSnzIYWI4u58bXjy2OJadWZMCL460UK0WjxmZ3sHxfN7JHTKoaXh6XA+Kv1jEn4
 TLNTyLTtgvVOTzKJ7tKBJg54o2NR/Lx03pk0+9UYsf1phvURw3APCq1CyamZv+9B+grgWyYfO
 qidAX9qv+i1dTYHzd/82jp3rFCYzGRXjQP9h7QMeNTZvd5h7K1/Q3xMCp4M5q6+h3yJMAhcWE
 keB+GQjCm4LzeE+nAPjmtjJ3G/Cb5zYLCmFiX9DZXBabW0077X2LQ7C8cdnmyUUZ4ZtQElO8p
 97iVHZi+a3zzkV7f01+L0n1SN8fpkPvoTWvyNglJA/ESSIZSLwKNBvetB8ReYda28tA7TcpZN
 cKocFuxbAhGEftu7AF+qzVF7nKg=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/1 08:05, 小太 wrote:
> dmesg (with spammed similar lines removed): See attachment
> uname -a: Linux home.kota.moe 6.0.0-5-amd64 #1 SMP PREEMPT_DYNAMIC
> Debian 6.0.10-2 (2022-12-01) x86_64 GNU/Linux
> btrfs --version: btrfs-progs v6.1
> 
> Recently one of my disks in my BTRFS RAID1 array failed, so I
> disconnected it from the system:
> 
>> kota@home:~$ sudo btrfs fi show
>> Label: none  uuid: b7e4da98-b885-4e70-b0a4-510fb77fa744
>>      Total devices 3 FS bytes used 1.47TiB
>>      devid    1 size 0 used 0 path /dev/sda1 MISSING
>>      devid    2 size 1.82TiB used 956.00GiB path /dev/sdc1
>>      devid    3 size 1.82TiB used 1.35TiB path /dev/sdb1

Weirdly, the dmesg is not showing devid 1 missing, in fact, it still 
shows the devices is there, just tons of IO errors (ata4, sd 3:0:0:0)

I guess that has something to do with the BUG_ON() you hit.

> 
> I then connected a new disk, and started a btrfs replace:
> 
>> kota@home:~$ sudo btrfs replace start 1 /dev/sdd1 /media/Data
>> kota@home:~$ sudo btrfs fi show
>> Label: none  uuid: b7e4da98-b885-4e70-b0a4-510fb77fa744
>>      Total devices 4 FS bytes used 1.47TiB
>>      devid    0 size 1.36TiB used 925.03GiB path /dev/sdd1
>>      devid    1 size 0 used 0 path /dev/sda1 MISSING
>>      devid    2 size 1.82TiB used 956.00GiB path /dev/sdc1
>>      devid    3 size 1.82TiB used 1.35TiB path /dev/sdb1
>> kota@home:~$ sudo btrfs replace status /media/Data
>> Started on 31.Dec 22:03:20, finished on  1.Jan 02:30:26, 0 write errs, 0 uncorr. read errs
> 
> 
> This operation spammed my dmesg with lines all looking like the following:
> 
>> [1762170.345526] BTRFS error (device sda1): fixed up error at logical 6863996235776 on dev /dev/sda1
>> ...
>> [1762174.289119] btrfs_dev_stat_inc_and_print: 91111 callbacks suppressed
>> [1762174.289123] BTRFS error (device sda1): bdev /dev/sda1 errs: wr 4147, rd 220063627, flush 0, corrupt 0, gen 0
>> ...
>> [1762175.320807] scrub_handle_errored_block: 91075 callbacks suppressed
>> [1762175.320850] BTRFS warning (device sda1): i/o error at logical 6909072957440 on dev /dev/sda1, physical 1395819732992, root 257, inode 452632, offset 1293344768, length 4096, links 1 (path: phoronix-test-suite/config/installed-tests/pts/unigine-super-1.0.7/Unigine_Superposition-1.0.run)
>> ...
>> [1762175.348848] scrub_handle_errored_block: 91080 callbacks suppressed
>> [1762175.348851] BTRFS error (device sda1): fixed up error at logical 6909075079168 on dev /dev/sda1
>> ...
>> [1762176.154002] BTRFS warning (device sda1): lost page write due to IO error on /dev/sda1 (-5)
>> ...
>> [1762176.172957] BTRFS error (device sda1): error writing primary super block to device 1
>>
>> [1762176.196418] BTRFS info (device sda1): dev_replace from /dev/sda1 (devid 1) to /dev/sdd1 finished

In fact it didn't finished.

Several BUG_ON() triggered before it, mostly crashing the fs.

The BUG_ON() itself happens for the IO repair path, which would 
writeback the repaired contents back the corrupted disk.

The problem is the writeback target, it looks like at the writeback 
time, we have already finished the replace, causing the mirror_num mismatch.

Normally this would be avoided if the target device is completely 
missing, but in your case, the corrupted disk is still accessible to 
kernel, causing the problem.

> 
> 
> Once it finished, I wanted to check the filesystem and do a scrub:
> 
>> kota@home:~$ sudo btrfs fi show
>> Label: none  uuid: b7e4da98-b885-4e70-b0a4-510fb77fa744
>>      Total devices 4 FS bytes used 1.47TiB
>>      devid    0 size 0 used 0 path /dev/sda1 MISSING
>>      devid    1 size 1.36TiB used 925.03GiB path /dev/sdd1
>>      devid    2 size 1.82TiB used 956.03GiB path /dev/sdc1
>>      devid    3 size 1.82TiB used 1.35TiB path /dev/sdb1
>> kota@home:~$ sudo btrfs fi df /media/Data
>> Data, RAID1: total=1.59TiB, used=1.46TiB
>> System, RAID1: total=64.00MiB, used=272.00KiB
>> Metadata, RAID1: total=5.00GiB, used=3.42GiB
>> GlobalReserve, single: total=512.00MiB, used=0.00B
>> kota@home:~$ sudo btrfs device delete missing /media/Data
>> ERROR: unable to start device remove, another exclusive operation 'device replace' in progress
>> kota@home:~$ sudo btrfs scrub start /media/Data
> 
> At this point, the command froze and has been stuck in uninterruptible
> sleep ever since (and no further lines in dmesg either).
> "btrfs device stats" and "btrfs scrub status" also hang in
> uninterruptible sleep as well.
> And I notice the original "btrfs replace" command seems to be still running?
> 
>> kota@home:~$ ps aux | grep btrfs
>> root     3626272  0.5  0.0   7044  2312 ?        Ds    2022   3:56 btrfs replace start 1 /dev/sdd1 /media/Data
>> root     3832422  0.0  0.0   4948  1408 pts/4    D+   09:54   0:00 btrfs scrub start /media/Data
>> root     3832891  0.0  0.0   4948  1412 pts/7    D+   09:56   0:00 btrfs scrub status /media/Data
>> root     3832943  0.0  0.0   4948  1452 pts/9    D+   09:56   0:00 btrfs device stats /media/Data
> 
> And all (non-cached) accesses to the filesystem (such as ls -l) also
> hang similarly.

That's caused by the kernel panic.

> 
> Given that this is a "reliable" RAID1 setup where a disk dropping dead
> shouldn't cause problems, BTRFS failing like this sounds like a bug to
> me.

As explained, the unreliable disk itself seems to be cause.

If you initially removed the hard disk completely, btrfs then can handle 
it well.
(Sure, this is a bug in btrfs and we should be able to fix it).

> What's going on here, and how should I recover from this?

Since btrfs module crashed, you have to reset the system.

And if you're going to reset the system, please remove the offending 
disk (sda) completely.

Then at next bootup, the fs can not be mounted without "-o degraded".

And at next mount, btrfs may or may not resume the replace.
If btrfs didn't resume the replace, it means the previous replace finished.
If btrfs did resume the replace, let it finish first.

Then run a scrub to fix any corrupted sectors which didn't properly get 
repaired during replace.

Thanks,
Qu

> I haven't tried remounting or restarting the system yet since this
> isn't a critical filesystem for me, and it might help debug the issue.
