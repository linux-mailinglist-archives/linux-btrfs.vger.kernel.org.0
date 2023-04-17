Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138626E54DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Apr 2023 00:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjDQW4p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Apr 2023 18:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDQW4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Apr 2023 18:56:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECCA2D63
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Apr 2023 15:56:42 -0700 (PDT)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8hVB-1pjt4z0sPh-004fyS; Tue, 18
 Apr 2023 00:56:40 +0200
Message-ID: <61025b77-2057-5a90-032b-f36ffa85deb4@gmx.com>
Date:   Tue, 18 Apr 2023 06:56:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: btrfs-transaction stalls
Content-Language: en-US
To:     Christian Kujau <lists@nerdbynature.de>,
        linux-btrfs@vger.kernel.org
References: <837c4ca9-7694-4633-50b8-57547e120444@nerdbynature.de>
 <8a3f47c0-5b0f-a6c8-d1c4-714e3251b9eb@nerdbynature.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <8a3f47c0-5b0f-a6c8-d1c4-714e3251b9eb@nerdbynature.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Rjbrj9bjB3JYnASV229n3lU24AkMPO5DSmM5inoYLNxSxqR7UEI
 YslnNTx49775fXB14l6STruiLwzcw/tXpb4wuC4P5xwwF56H1IHXHsRc/2fp1MHm7NNQsRQ
 xFcIsvUw5Dwe2PlkDeAZNIkxCkph5jXjEqMSOIbs6I9mKCMhwDBbojhTtWp5DSNjnE0EEbe
 Nm2XMVi3BDfGJTVycN72Q==
UI-OutboundReport: notjunk:1;M01:P0:bjxRKv4xBIY=;ctJP3RXOsGmu8mT3M4H4NCiSfT7
 FoCJ8MjRgHbRi0YqJBSdaqDallfpY87MWldimd8JJBQ7OfsBn3umTO3ZyL/KECLhl8qO2kAUe
 OqgQrKIH+aQcg/ri9opaL6LTwijRXnGJfpD3mSOL41znT7U1Dg8f6mMCsanMAsElXNcpjvIcS
 7CFu0xtqLNlzqWqauv1leogd6Hn9FHaSw9zEdK4AY7o2Kwqzx92rfvo8rT+L5tVpXR1xv8G6O
 mCAR0d8zbWmrQ1phfGzSAIZ7lzmel/Yl1x1CervBJcNdMWKtMpMouhbUkpM8ZaeQq4h6AM2oz
 IgS9liV3/5FGEjMvKC3ACAmW83y0OZzCf0ldsu8HTgWsSJXL6WAr5kI4nktJHs/6+fPQfPSRb
 JghjpPcQnqJYAxR9tft4BfkVVC+VSOO2ZoVzMsKdvmwQJY6NB6wi9doHrTBGWGb1cx/vNxF0q
 fxdiOp94ak+82O9jsqee245N8yT//3kxf8rj/fiSYqTUsW7c9/FkAHFXL3saJGUEobfk/SxoY
 7nm1kLfpq1tYdf73+EoiMtPRNQKJzsBVEhkiJw2UFubTvNBVMZTmgFSnTir6xH/+Wy7HlGLl9
 5Tz4YjVEA5xXxElPkhbON2UEQObbLNGsbDO3MvhS9xhDjB/9oxbglmO6A8uWZwLvIJsHp3OON
 FOvIZ1uzHxuVgKHLE1K5lOa+/vyD2/2drO/BBbP/rxPVl6+mPEdLqOpqmCvWyM+ITV+Hbck0j
 vRQQIW5D/gpTdEzOKpcbWQCN6kMzNbgQ0zMDyeYeYlO9IX2zIWbwWDm7d2/aGLOoAn/ZKlcwm
 39QdG8d68C7DzQhOVLSgnBWl4YiyuaodpshMZOs1MIJ2GKA/wxn6B07vlQ+HaSwGOa6iQtRR4
 jJYvlkapFuN3IZDDpCF4YjnrR/mWrNLBBeKbze2k31M0glRLUHQnEyMaMADPJ7GB9uES4Y40x
 H7gyveZQ/q3SsxqBMba/HMpFBHE=
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/4/18 05:30, Christian Kujau wrote:
> On Thu, 2 Mar 2023, Christian Kujau wrote:
>> this Fedora 37 workstation (always running the latest distribution kernel,
>> 6.1.14-200 right now) has been installed 2 years ago but lately I noticed
>> some strange stalls when working: browser windows no longer react,
>> sometimes even the Gnome "oh, this window does not respond, do you want to
>> kill it?" popup comes up, and the system feels very unresponsive.
> 
> No dice. Even after another full re-balance, the problem is back, and even
> worse. Now with 6.2.10-200.fc37.x86_64:
> 
> $ sudo iotop-c -o
> Total DISK READ:    0.00 B/s
> Total DISK WRITE:  10.18 K/s
> Current DISK READ:  0.00 B/s
> Current DISK WRITE: 0.00 B/s
> TID PRIO USER DISK READ DISK WRITE SWAPIN IO GRAPH[IO]▽ COMMAN
>   784 be/4 root 0.00 B/s 0.00 B/s 0.00% 96.05% btrfs-transaction
> 
> For some reason btrfs-transaction keeps the disk busy at almost 100%, with
> no real disk I/O going on, system load goes up to ~140. A few (maybe 10
> minutes later) the system recovers and sync(1) comes back too.
> 
> Any ideas on how to debug this?

Disable qgroup, or don't delete large shared subvolumes, or use the 
latest /sys/fs/btrfs/<UUID>/qgroups/drop_subtree_threshold file to make 
qgroup to automatically skip such large snapshot drop.

Thanks,
Qu
> 
> Thanks,
> Christian.
> 
> 
>> The system load applet is still working and shows very high I/O wait
>> times, and I wait ~60 seconds and the system recovers and works again.
>> And while all this happened rarely in the past, I notice it more often
>> lately.
>>
>> Some specs: Thinkpad T470, with a single Crucial NVMe 1 TB disk installed.
>> I opted for full-disk-encryption and so the rootfs is (compressed) Btrfs
>> on-top a LUKS2 dm-crypt device. I'm not using snapshots.
>>
>> I ran a full btrfs-balance some time ago, but I can't say it helped much.
>> If recommended, I can run another one of course.
>>
>> Whenever these stalls happen, and I manage to fire up iotop-c, I can see
>> "btrfs-transaction" at the very top, utilizing 100% of the disk's IO, but
>> not generating _that_ much of I/O traffic (the encrypted disk can do ~250
>> MB/s read). With even more luck I manage to run "perf record" during these
>> stalls ("cd /tmp" before, so it can record to tmpfs, because of the
>> stall), and while I can see "btrfs-transaction" in there, I don't see it
>> in the top-10. Or maybe I'm to stupid to use perf report:
>>
>>    https://nerdbynature.de/bits/6.1.14-200/perf_1.data.xz
>>
>> This all can even be reproduced somewhat reliably: I was writing above how
>> fast the disk is, and wanted to test _write_ speed as well:
>>
>>   $ pv < /dev/zero > /foo
>>   [wait....1.7GB/s.., cool...ok, let's stop after 9GB or so...]
>>   ^C
>>   $ rm -f /foo
>>
>> And all that comes back instantly. But then running "/bin/sync" afterwards
>> took 8 minutes (!) until the command came back, and I can see the I/O wait
>> again in the system load applet in my window manager. This time I could
>> no longer start iotop-c, but "perf record" recorded something, if you want
>> to have a look:
>>
>>   https://nerdbynature.de/bits/6.1.14-200/perf_2.data.xz
>>
>> Some Btrfs infos below. Does anybody have an idea what's going on? Or how
>> to debug this? Disable compression? Run another btrfs-balance? fsck?
>>
>> Thank you,
>> Christian.
>>
>> $ mount | grep btrfs
>> /dev/mapper/luks-root on / type btrfs (rw,relatime,seclabel,compress=zstd:3,ssd,discard,space_cache=v2,subvolid=5,subvol=/)
>>
>> $ df -h /
>> Filesystem             Size  Used Avail Use% Mounted on
>> /dev/mapper/luks-root  250G  162G   88G  66% /
>>
>> $ btrfs filesystem df /
>> Data, single: total=164.00GiB, used=159.79GiB
>> System, single: total=32.00MiB, used=48.00KiB
>> Metadata, single: total=3.00GiB, used=1.73GiB
>> GlobalReserve, single: total=329.44MiB, used=0.00B
>>
>> $ sudo btrfs filesystem usage -T /
>> Overall:
>>      Device size:                 249.98GiB
>>      Device allocated:            167.03GiB
>>      Device unallocated:           82.95GiB
>>      Device missing:                  0.00B
>>      Device slack:                    0.00B
>>      Used:                        161.53GiB
>>      Free (estimated):             87.16GiB      (min: 87.16GiB)
>>      Free (statfs, df):            87.16GiB
>>      Data ratio:                       1.00
>>      Metadata ratio:                   1.00
>>      Global reserve:              329.44MiB      (used: 0.00B)
>>      Multiple profiles:                  no
>>
>>                           Data      Metadata System
>> Id Path                  single    single   single   Unallocated Total     Slack
>> -- --------------------- --------- -------- -------- ----------- --------- ----
>>   1 /dev/mapper/luks-root 164.00GiB  3.00GiB 32.00MiB    82.95GiB 249.98GiB -
>> -- --------------------- --------- -------- -------- ----------- --------- ----
>>     Total                 164.00GiB  3.00GiB 32.00MiB    82.95GiB 249.98GiB 0.00B
>>     Used                  159.79GiB  1.73GiB 48.00KiB
>>
>>
>> $ sudo compsize -x /
>> Processed 1263684 files, 1173537 regular extents (1252947 refs), 612785 inline.
>> Type       Perc     Disk Usage   Uncompressed Referenced
>> TOTAL       82%      160G         193G         199G
>> none       100%      144G         144G         145G
>> zlib        33%       14K          43K          43K
>> zstd        32%       15G          48G          53G
>> prealloc   100%       66M          66M          72M
>>
>> -- 
>> BOFH excuse #227:
>>
>> Fatal error right in front of screen
>>
> 
