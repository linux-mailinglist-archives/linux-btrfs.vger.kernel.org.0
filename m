Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9673C9EF5
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 14:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhGOMx6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 08:53:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:46221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhGOMx5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 08:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626353461;
        bh=+tmqeCef8X4Zm16yjuU2ucICwxrOEMTVYhxpHQDqAVY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jK2yuohJIbq84MefazDXf976Lkvcwn5SeRR+c59H7z32m3LArSSiudcy/z0LzN4x+
         9tIoRODNssUpnAKtq9rrLDiGPxmPlPuEaqOh9oT/4bWVpatDOO492PqlNHS7zIRldf
         Vk/nJwOq5JEmXYQpxaaUwWhT3P0E3okAmBX4RfdU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M5QJD-1m5Njt3YAf-001NpQ; Thu, 15
 Jul 2021 14:51:01 +0200
Subject: Re: btrfs cannot be mounted or checked
To:     Zhenyu Wu <wuzy001@gmail.com>, Qu Wenruo <wqu@suse.com>
Cc:     Forza <forza@tnonline.net>, linux-btrfs@vger.kernel.org
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
 <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
 <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com>
 <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
 <c0024688-3361-7e15-21d1-c55bc16fa83e@gmx.com>
 <CAJ9tZB-O+xphuHJ-DhpjvoFFuFAJrSpoMuurx_44s040YWBtqQ@mail.gmail.com>
 <b25141f0-d4c7-05bc-05af-848b6ed26b1d@gmx.com>
 <CAJ9tZB9V7xYVLq_PFHQ97Y3Rau-ZBjjGmaWayDtLBaj7f00xWg@mail.gmail.com>
 <8aad905d-c920-5605-bbf3-7be49daeffb9@suse.com>
 <CAJ9tZB97OG-JOKHyUX3F2oWpAB+n3X43a8+fNnEAGC00TWdW7w@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <4fe37cac-71d0-0cfe-990c-50e1137c9d02@gmx.com>
Date:   Thu, 15 Jul 2021 20:50:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB97OG-JOKHyUX3F2oWpAB+n3X43a8+fNnEAGC00TWdW7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RrfaC0FrZJkwlQMZSd4uIYu/idbXiZzVLsHTXo149bQVAN1Lnng
 9joxAtT/7AGeig8O4uHqbDPls2qOP/IU24cE24Zo2Df6qxxK7Z0OdfB23SfTVCiTloeLpL5
 UPtFaGEbaHDkT0IN1QW+gsZzLdPIh1JA5HEDFJt+w64UwJZSwBGJuKXvuzy9lnSz5vF5phJ
 dg5UM/ly3pxd9Fu4rn5kw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vs3cLxgjklE=:ww0t/ICC2Lzol3jPywd0YZ
 yeVnswB7xBNV+DXSqF+XgicjyviasLYm05RaoU7acjCTtuiOr6Yn37nQulMaQmnLLsfjm8IJl
 YXcwSPQh+ABsaVA8z/XEnHcGAmP9ts15d0weOWSsdW/s9Wm8jJu1HV8oUXOCZaZVNrpH4oNiQ
 BvD+LXH3mpwhheU85jkoHxMzuetK4TGVzGjmXseFj68b+R0HYmQNkvDlP69KqjVzKyeYnkX43
 jtTZ3NYuLA4A8LPDzluvzQnvSQvow1XOOLvhBk3qcpgUZziWR73YpEzzZoy31W4prgDpE55W4
 NHpAEPrq57ff9+p7MXhuCQzOoZl2ZkFa8/Y+Z+5f9GVoXb+MfMW20FXiNAH/yTbymI9eNBJnr
 EN8o0y9z3jUX0I7UUAs/l6sfD19O4CMSgtj2C/gE5YtVfhxxU8Sm9Yp0GoATqsa9tnRZZXxwA
 RRFhADyO/KpsOoyh7pksMCZC78nNUrAOn+9fNzTKGpMv2QS2Bgu8DL+a96Wo/D9XMp2DIulY+
 s7jSqZCggyN9aBWV+SnVZ3hPVqWAHBsO0jZD1qyqpPYrLNTg+GlXZovAkb5JAViYD54iLja4H
 8YgO0Nc5eyFV2q4N73gE92eVEeLEbODsC1j4SSMvhYaE1zJc4zmHfHJbwbQ2WqdIJL2tPwhP6
 lNYNp2ONlrZoHwag26OZV+kqn68aA4Co9GKWg72LoYkDXuATw9Jz/ClC2dTnfIM7CH88FAV8F
 sLKlcYbWT3r2J8TzezvoIyQbzf+FFWo1i3lsPq5FdVA3osTqatm3NWEOONnoaedL0HaK0zNsv
 leoMZokclTKxo4ToQ/2z2e3IPOmGCTfYiTE1h9efqqsLohssYAMKow3SCxPPZsS5jgIowydFX
 AWKUtlsHi5GaqZcLYJrtVPVnKKTU1JumVmmYaJ56bjFYe2VDpmrdswFJ9hqU9w3DHbzPq9qEK
 Weg3S8rVPAptzWE++Nvu0tL6yEmXuRdHCAM9/mzxDGAhjV0pN1LHKYKeAEFhqR3Cd8FEoOUMO
 dnIa0piIUF/zzoXC+ARiuA7sTwtLZFF6c4InVJDaEthcaClSlHuKMtjSl3mTKwiTKAY3PRzp5
 SbXbvF4yaoLPAS0Xb2tAGColTc6S5ALfAxL/PCw5WbwNJTYL0NWVUAbHw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/15 =E4=B8=8B=E5=8D=888:47, Zhenyu Wu wrote:
> Does it mean the broken disk cannot be recovered?

If you mean the fs, I'd say it may be possible to recover to fully
working stage, but that would need quite time for us developer to get a
binary dump of your fs and test on that.

If you mean the physical disk, I'd say it's already showing dangerous
sign in its smartctl, you'd better consider to replace it.

Thanks,
Qu

> Can the disk be
> continued to use? should I change a new disk or format the partition?
>
> Thanks!
>
> On 7/15/21, Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>> On 2021/7/15 =E4=B8=8B=E5=8D=881:17, Zhenyu Wu wrote:
>>> ```
>>> $ btrfs ins dump-tree -t root /dev/sda2|grep -A3 EXTENT_TREE|grep
>>> bytenr|tr -d '\t'|cut -d' ' -f6 > num
>>> $ btrfs-map-logical -l `cat num` /dev/sda2|cut -d' ' -f6 > phy
>>> $ xfs_io -f -c "pwrite `tail -n1 phy` 4" /dev/sda2
>>> wrote 4/4 bytes at offset 499117572096
>>> 4.000000 bytes, 1 ops; 0.3517 sec (11.370161 bytes/sec and 2.8425
>>> ops/sec)
>>> $ xfs_io -f -c "pwrite `head -n1 phy` 4" /dev/sda2
>>> # same as above
>>> $ btrfs check /dev/sda2
>>> Opening filesystem to check...
>>> checksum verify failed on 1370128760832 wanted 0xcdcdcdcd found
>>> 0xe6568433
>>> checksum verify failed on 1370128760832 wanted 0xcdcdcdcd found
>>> 0xe6568433
>>> checksum verify failed on 1370128760832 wanted 0xcdcdcdcd found
>>> 0xe6568433
>>> Csum didn't match
>>> ERROR: could not setup extent tree
>>> ERROR: cannot open file system
>>> $ mount -o ro,rescue=3Dibadroots /dev/sda2 /mnt
>>> $ findmnt /mnt
>>> TARGET SOURCE    FSTYPE OPTIONS
>>> /mnt   /dev/sda2 btrfs
>>> ro,relatime,rescue=3Dignorebadroots,space_cache,subvolid=3D5,subvol=3D=
/
>>> $ dmesg|grep BTRFS
>>> [    7.166566] BTRFS: device label gentoo devid 1 transid 2375312
>>> /dev/sda2 scanned by systemd-udevd (147)
>>> [  990.864811] BTRFS info (device sda2): ignoring bad roots
>>> [  990.864836] BTRFS info (device sda2): disk space caching is enabled
>>> [  990.864849] BTRFS info (device sda2): has skinny extents
>>> [  990.910642] BTRFS warning (device sda2): sda2 checksum verify
>>> failed on 1370128760832 wanted 0xcdcdcdcd found 0xe6568433 level 2
>>> [  990.920955] BTRFS warning (device sda2): sda2 checksum verify
>>> failed on 1370128760832 wanted 0xcdcdcdcd found 0xe6568433 level 2
>>> [  990.990469] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0, rd
>>> 0, flush 0, corrupt 5, gen 0
>>> [  990.992263] BTRFS error (device sda2): qgroup generation mismatch,
>>> marked as inconsistent
>>> ```
>>>
>>> It works!
>>> now can I boot my computer from disk not live USB?
>>
>> This is only RO mount, and can no longer be mounted back to RW, not to
>> mention it needs kernel newer than 5.11.
>>
>> This is mostly only for you to grab your data.
>>
>> Thanks,
>> Qu
>>>
>>> Thanks!
>>>
>>> On 7/15/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>
>>>>
>>>> On 2021/7/14 =E4=B8=8B=E5=8D=889:52, Zhenyu Wu wrote:
>>>>> I found btrfs-5.12 in archlinux (surprisedly)
>>>>>
>>>>> When I try to mount with ro, rescue=3Dibadroots, I will get
>>>>> ```
>>>>> wrong fs type, bad option, bad superblock on
>>>>> /dev/sda2, missing codepage or helper program, or other error.
>>>>> ```
>>>>>
>>>>> dmesg will output
>>>>> ```
>>>>> [ 1087.646701] BTRFS info (device sda2): ignoring bad roots
>>>>> [ 1087.646725] BTRFS info (device sda2): disk space caching is enabl=
ed
>>>>> [ 1087.646735] BTRFS info (device sda2): has skinny extents
>>>>> [ 1087.770464] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0, =
rd
>>>>> 0, flush 0, corrupt 5, gen 0
>>>>> [ 1087.834263] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D107374182=
4, invalid
>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>> [ 1087.834550] BTRFS error (device sda2): block=3D273006592 read tim=
e
>>>>> tree block corruption detected
>>>>> [ 1087.848452] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D107374182=
4, invalid
>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>> [ 1087.848762] BTRFS error (device sda2): block=3D273006592 read tim=
e
>>>>> tree block corruption detected
>>>>> [ 1087.849006] BTRFS error (device sda2): failed to read block group=
s:
>>>>> -5
>>>>> [ 1087.851674] BTRFS error (device sda2): open_ctree failed
>>>>> ```
>>>>> does it mean my extent tree is still intact? so I need to btrfs ins
>>>>> dump-tree, btrfs-map-logical?
>>>>> thanks!
>>>>
>>>> Yep, you need to corrupt the extent tree to rescue the data, ironical=
ly.
>>>>
>>>> Thanks,
>>>> Qu
>>>>>
>>>>> On 7/14/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/7/14 =E4=B8=8B=E5=8D=885:58, Zhenyu Wu wrote:
>>>>>>> ```
>>>>>>> [  301.533172] BTRFS info (device sda2): unrecognized rescue optio=
n
>>>>>>> 'ibadroots'
>>>>>>> [  301.533209] BTRFS error (device sda2): open_ctree failed
>>>>>>> ```
>>>>>>>
>>>>>>> Does ibadroots need a newer version of btrfs? My btrfs version is
>>>>>>> 5.10.1.
>>>>>>
>>>>>> Oh, that support is added in v5.11...
>>>>>>
>>>>>> You may want to grab a liveCD from some rolling release.
>>>>>>
>>>>>> But even with v5.11, it may not help much, as that option won't hel=
p
>>>>>> if
>>>>>> your extent tree is still intact.
>>>>>>
>>>>>> You may want to use "btrfs ins dump-tree" to locate your extent tre=
e,
>>>>>> then corrupt the extent tree root completely (using btrfs-map-logic=
al
>>>>>> to
>>>>>> get the physical offset, then dd to destory the first 4 bytes of bo=
th
>>>>>> copy), then the option would properly work.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>>
>>>>>>> Thanks!
>>>>>>>
>>>>>>> On 7/14/21, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2021/7/14 =E4=B8=8B=E5=8D=884:49, Zhenyu Wu wrote:
>>>>>>>>> sorry for late:(
>>>>>>>>>
>>>>>>>>> I found <https://bbs.archlinux.org/viewtopic.php?id=3D233724> lo=
oks
>>>>>>>>> same
>>>>>>>>> as my situation. But in my computer (boot from live usb) `btrfs
>>>>>>>>> check
>>>>>>>>> --init-extent-tree` output a lot of non-ascii character (maybe
>>>>>>>>> because
>>>>>>>>> ansi escape code mess the terminal)
>>>>>>>>> after several days it outputs `7/7`and `killed`. The solution lo=
oks
>>>>>>>>> failed.
>>>>>>>>>
>>>>>>>>> I'm sorry because my live usb don't have smartctl :(
>>>>>>>>>
>>>>>>>>> ```
>>>>>>>>> $ hdparm -W0 /dev/sda
>>>>>>>>> /dev/sda:
>>>>>>>>>       setting drive write-caching to 0 (off)
>>>>>>>>>       write-caching =3D  0 (off)
>>>>>>>>> ```
>>>>>>>>>
>>>>>>>>> But now the btrfs partition still cannot be mounted.
>>>>>>>>>
>>>>>>>>> when I try to mount it with `usebackuproot`, it will output the
>>>>>>>>> same
>>>>>>>>> error message. And dmesg will output
>>>>>>>>> ```
>>>>>>>>> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
>>>>>>>>> deprecated, use 'rescue=3Dusebackuproot' instead
>>>>>>>>> [250062.064788] BTRFS info (device sda2): trying to use backup r=
oot
>>>>>>>>> at
>>>>>>>>> mount time
>>>>>>>>> [250062.064789] BTRFS info (device sda2): disk space caching is
>>>>>>>>> enabled
>>>>>>>>> [250062.064790] BTRFS info (device sda2): has skinny extents
>>>>>>>>> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: w=
r
>>>>>>>>> 0,
>>>>>>>>> rd 0, flush 0, corrupt 5, gen 0
>>>>>>>>> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=
=3D2
>>>>>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D10737=
41824,
>>>>>>>>> invalid
>>>>>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>>>>>
>>>>>>>> Looks like a bad extent tree re-initialization, a bug in btrfs-pr=
ogs
>>>>>>>> then.
>>>>>>>>
>>>>>>>> For now, you can try to mount with "ro,rescue=3Dibadroots" to see=
 if
>>>>>>>> it
>>>>>>>> can be mounted RO, then rescue your data.
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Qu
>>>>>>>>> [250062.277048] BTRFS error (device sda2): block=3D273006592 rea=
d
>>>>>>>>> time
>>>>>>>>> tree block corruption detected
>>>>>>>>> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=
=3D2
>>>>>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D10737=
41824,
>>>>>>>>> invalid
>>>>>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>>>>>> [250062.291927] BTRFS error (device sda2): block=3D273006592 rea=
d
>>>>>>>>> time
>>>>>>>>> tree block corruption detected
>>>>>>>>> [250062.291943] BTRFS error (device sda2): failed to read block
>>>>>>>>> groups:
>>>>>>>>> -5
>>>>>>>>> [250062.292897] BTRFS error (device sda2): open_ctree failed
>>>>>>>>> ```
>>>>>>>>>
>>>>>>>>> If don't usebackuproot, dmesg will output the same log except th=
e
>>>>>>>>> first
>>>>>>>>> 2
>>>>>>>>> lines.
>>>>>>>>>
>>>>>>>>> Now btrfs check can check this partition:
>>>>>>>>>
>>>>>>>>> ```
>>>>>>>>> $ btrfs check /dev/sda2 2>&1|tee check.txt
>>>>>>>>> # see attachment
>>>>>>>>> ```
>>>>>>>>>
>>>>>>>>> Does my disk have any hope to be rescued?
>>>>>>>>> thanks!
>>>>>>>>>
>>>>>>>>> On 7/11/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>>>>>>>>>> Sorry for my disturbance.
>>>>>>>>>>>> After a dirty reboot because of a computer crash, my btrfs
>>>>>>>>>>>> partition
>>>>>>>>>>>> cannot be mounted. The same thing happened before, but now
>>>>>>>>>>>> `btrfs
>>>>>>>>>>>> rescue zero-log` cannot work.
>>>>>>>>>>>> ```
>>>>>>>>>>>> $ uname -r
>>>>>>>>>>>> 5.10.27-gentoo-x86_64
>>>>>>>>>>>> $ btrfs rescue zero-log /dev/sda2
>>>>>>>>>>>> Clearing log on /dev/sda2, previous log_root 0, level 0
>>>>>>>>>>>> $ mount /dev/sda2 /mnt/gentoo
>>>>>>>>>>>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock=
 on
>>>>>>>>>>>> /dev/sda2, missing codepage or helper program, or other error=
.
>>>>>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found
>>>>>>>>>>>> 961764
>>>>>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found
>>>>>>>>>>>> 961764
>>>>>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found
>>>>>>>>>>>> 961764
>>>>>>>>>>>> Ignoring transid failure
>>>>>>>>>>>> leaf parent key incorrect 34308096
>>>>>>>>>>>> ERROR: failed to read block groups: Operation not permitted
>>>>>>>>>>>> ERROR: cannot open file system
>>>>>>>>>>>> $ dmesg 2>&1|tee dmesg.txt
>>>>>>>>>>>> # see attachment
>>>>>>>>>>>> ```
>>>>>>>>>>>> Like `mount -o ro,usebackuproot` cannot work, too.
>>>>>>>>>>>>
>>>>>>>>>>>> Thanks for any help!
>>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Hi!
>>>>>>>>>>>
>>>>>>>>>>> Parent transid failed is hard to recover from, as mentioned on
>>>>>>>>>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_f=
rom_a_.22parent_transid_verify_failed.22_error.3F
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I see you have "corrupt 5" sectors in dmesg. Is your disk
>>>>>>>>>>> healthy?
>>>>>>>>>>> You
>>>>>>>>>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>>>>>>>>>
>>>>>>>>>>> One way of avoiding this error is to disable write-cache. Pare=
nt
>>>>>>>>>>> transid
>>>>>>>>>>> failed can happen when the disk re-orders writes in its write
>>>>>>>>>>> cache
>>>>>>>>>>> before flushing to disk. This violates barriers, but it is
>>>>>>>>>>> unfortately
>>>>>>>>>>> common. If you have a crash, SATA bus reset or other issues,
>>>>>>>>>>> unwritten
>>>>>>>>>>> content is lost. The problem here is the re-ordering. The
>>>>>>>>>>> superblock
>>>>>>>>>>> is
>>>>>>>>>>> written out before other metadata (which is now lost due to th=
e
>>>>>>>>>>> crash).
>>>>>>>>>>
>>>>>>>>>> To be extra accurate, all filesysmtems have taken the re-order
>>>>>>>>>> into
>>>>>>>>>> consideration.
>>>>>>>>>> Thus we have flush (or called barrier) command to force the dis=
k
>>>>>>>>>> to
>>>>>>>>>> write all its cache back to disk or at least non-volatile cache=
.
>>>>>>>>>>
>>>>>>>>>> Combined with mandatory metadata CoW, it means, no matter what =
the
>>>>>>>>>> disk
>>>>>>>>>> re-order or not, we should only see either the newer data after
>>>>>>>>>> the
>>>>>>>>>> flush, or the older data before the flush.
>>>>>>>>>>
>>>>>>>>>> But unfortunately, hardware is unreliable, sometimes even lies
>>>>>>>>>> about
>>>>>>>>>> its
>>>>>>>>>> flush command.
>>>>>>>>>> Thus it's possible some disks, especially some cheap RAID cards=
,
>>>>>>>>>> tend
>>>>>>>>>> to
>>>>>>>>>> just ignore such flush commands, thus leaves the data corrupted
>>>>>>>>>> after
>>>>>>>>>> a
>>>>>>>>>> power loss.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Qu
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> You disable write cache with "hdparm -W0 /dev/sda". It might b=
e
>>>>>>>>>>> worth
>>>>>>>>>>> adding this to a cron-job every 5 minutes or so, as the settin=
g
>>>>>>>>>>> is
>>>>>>>>>>> not
>>>>>>>>>>> persistent and can get reset if the disk looses power, goes to
>>>>>>>>>>> sleep,
>>>>>>>>>>> etc.
>>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>>
>>
>>
