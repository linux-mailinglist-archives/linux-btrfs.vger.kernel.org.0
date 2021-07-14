Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B413C93E9
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 00:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhGNWiP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 18:38:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:54127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229900AbhGNWiP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 18:38:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626302119;
        bh=kjQq6Li1mxKYLoktIiEGfr8MmU7gbQHf/O/96lEthj0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ELhtbP9SvCVhQ72rRaVMARlk/AHUjCjhV+RcmBeEFwGE0YtZTGzk0KR7XAuOUqW6M
         +/Y7KLPSidPYR5jZeGlGD1N33AR8LY+7H/9HuUjAjfXMfrN34kyRjp6FS+ZBvBMyNs
         o/EAlsyWQ5ufgb7gcT45OA8nkKKpV+WQkMolFeso=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK0X-1lCnLT43SD-00rIZ6; Thu, 15
 Jul 2021 00:35:19 +0200
Subject: Re: btrfs cannot be mounted or checked
To:     Zhenyu Wu <wuzy001@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
 <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
 <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com>
 <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
 <c0024688-3361-7e15-21d1-c55bc16fa83e@gmx.com>
 <CAJ9tZB-O+xphuHJ-DhpjvoFFuFAJrSpoMuurx_44s040YWBtqQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b25141f0-d4c7-05bc-05af-848b6ed26b1d@gmx.com>
Date:   Thu, 15 Jul 2021 06:35:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB-O+xphuHJ-DhpjvoFFuFAJrSpoMuurx_44s040YWBtqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UVqeDX+vgMXUE0r8Z1GcmZEybjRIfe5QnHlCDFLHszOqKNzt+rz
 v1j8ohxs4j4JxXBY3EQZrudy1wkIy4fSlNk7qJHM3ujJdnrTPAQNhHO+4LVGJjbdNfQ++B3
 NcZoWJ7nKi6QCAdFKt/CffSYSCTXgwAAyjROu+4Ca5YstZlMIqVswL5lXcJN7mM4EefSEyn
 4Uq4/DvHxtvAZOdgLOkkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G9j5YOZe1Dw=:c3CDF+gZvMuRtqQEwev/tX
 zvUY6Fwt2qwnRKxkT2+Tz0uZM4VsSZok4CQOCgPjrYpo6gGB0JDSzDovJTVCxuURIifidB11X
 0B9EsAqQNEFhQN7tipzplTeV8R4+D1TyHtlKRotoAFVCKKItUZxH13Kn8XacS/m9lVdzxPwIK
 bkDnG2pmgxywfrXgk3VhKHs5eZOKRUJFNzyo2Rd2Q1p3YLH2sogPnphLqxTNF69GXEzNpyb2R
 Deyh+mevmQbpxF80SGMORjEZ/nLtAWMY61DS30ZpPyCA6mIH9zgACjNt0oTWOXtJpiBhmF1cW
 /ylDp9Le94352m1YpfBf2KLvfuSHS03YK1gh2ctlBX7GuKdTJnS8B0goIuNedjgfx28jysrLj
 vGkDTFf23vRUYyzXSXnQnEb3eujCBBwTwWcsVXfEXni2YTUbo8cz5y6lD5SWZygdNWUz331Dr
 rSgt3IpjGxK9+EO7rmPmkXlohl1THoLvFtnAJWeTlV1kcyuyKN+mn5WPHkbUXfV8R1cTfl69H
 u/r1zbReqihpkB21G2tCgZUllSnGSCCzQ3TFnTB9eXxUMylbiscpYYvFtKSo31z/yHdEtvOW0
 WozpGyMtcOgwRDWrmVAGedOshLDwDBgBCmVJl8ry7tpxpGUE5wFBP6LMH3Wnuuwmb/L6NzhFW
 FJvstbRCCmjkqNBabMDcCHWhCVnzI/+7WujlImweQ/bQgUtLUxBLN7XiIdgj4lMc1RjiFbz1p
 GLgIPFxTfl1DzzM1vkhINCmunBIv89pnUnVspQz3b9951tRC4uSQeqDmVghWx0Vy6W5ZvlfCS
 fFoT0SmWCfZc3FZd/9OuSaPPkJzonAUh+5DQ2O6e1ETlEyc1qUKVb/9L4P7Xjf+AMDdOv09dd
 yW6V8Nk/xAwQxygTTM0SrlkdjWw9WUqm9Mcvh2ptS05HcavZ2WcwWls9edAeI3kczqu2WJhlu
 dFx3LsQsrPmamzOiPpQ7dPu3rHQG+2Nvr/gsINn2csBc3cUDctypycyt1N/eURtr4N3ozYqpv
 YRlMwY8TqoMqFaU6YSumvUdpUGEYvozTg/f3FavRn+8LAqVj15RYcODSmL9JuVjDut7accOCR
 K9BSQAQv+GCdOizAty/tj0fuDOunAUaCCPGMWJPR1luCWr2sN0+GaTi9Q==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=889:52, Zhenyu Wu wrote:
> I found btrfs-5.12 in archlinux (surprisedly)
>
> When I try to mount with ro, rescue=3Dibadroots, I will get
> ```
> wrong fs type, bad option, bad superblock on
> /dev/sda2, missing codepage or helper program, or other error.
> ```
>
> dmesg will output
> ```
> [ 1087.646701] BTRFS info (device sda2): ignoring bad roots
> [ 1087.646725] BTRFS info (device sda2): disk space caching is enabled
> [ 1087.646735] BTRFS info (device sda2): has skinny extents
> [ 1087.770464] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0, rd
> 0, flush 0, corrupt 5, gen 0
> [ 1087.834263] BTRFS critical (device sda2): corrupt leaf: root=3D2
> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, i=
nvalid
> block group used, have 1073754112 expect [0, 1073741824)
> [ 1087.834550] BTRFS error (device sda2): block=3D273006592 read time
> tree block corruption detected
> [ 1087.848452] BTRFS critical (device sda2): corrupt leaf: root=3D2
> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, i=
nvalid
> block group used, have 1073754112 expect [0, 1073741824)
> [ 1087.848762] BTRFS error (device sda2): block=3D273006592 read time
> tree block corruption detected
> [ 1087.849006] BTRFS error (device sda2): failed to read block groups: -=
5
> [ 1087.851674] BTRFS error (device sda2): open_ctree failed
> ```
> does it mean my extent tree is still intact? so I need to btrfs ins
> dump-tree, btrfs-map-logical?
> thanks!

Yep, you need to corrupt the extent tree to rescue the data, ironically.

Thanks,
Qu
>
> On 7/14/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>> On 2021/7/14 =E4=B8=8B=E5=8D=885:58, Zhenyu Wu wrote:
>>> ```
>>> [  301.533172] BTRFS info (device sda2): unrecognized rescue option
>>> 'ibadroots'
>>> [  301.533209] BTRFS error (device sda2): open_ctree failed
>>> ```
>>>
>>> Does ibadroots need a newer version of btrfs? My btrfs version is 5.10=
.1.
>>
>> Oh, that support is added in v5.11...
>>
>> You may want to grab a liveCD from some rolling release.
>>
>> But even with v5.11, it may not help much, as that option won't help if
>> your extent tree is still intact.
>>
>> You may want to use "btrfs ins dump-tree" to locate your extent tree,
>> then corrupt the extent tree root completely (using btrfs-map-logical t=
o
>> get the physical offset, then dd to destory the first 4 bytes of both
>> copy), then the option would properly work.
>>
>> Thanks,
>> Qu
>>>
>>> Thanks!
>>>
>>> On 7/14/21, Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>>
>>>> On 2021/7/14 =E4=B8=8B=E5=8D=884:49, Zhenyu Wu wrote:
>>>>> sorry for late:(
>>>>>
>>>>> I found <https://bbs.archlinux.org/viewtopic.php?id=3D233724> looks =
same
>>>>> as my situation. But in my computer (boot from live usb) `btrfs chec=
k
>>>>> --init-extent-tree` output a lot of non-ascii character (maybe becau=
se
>>>>> ansi escape code mess the terminal)
>>>>> after several days it outputs `7/7`and `killed`. The solution looks
>>>>> failed.
>>>>>
>>>>> I'm sorry because my live usb don't have smartctl :(
>>>>>
>>>>> ```
>>>>> $ hdparm -W0 /dev/sda
>>>>> /dev/sda:
>>>>>     setting drive write-caching to 0 (off)
>>>>>     write-caching =3D  0 (off)
>>>>> ```
>>>>>
>>>>> But now the btrfs partition still cannot be mounted.
>>>>>
>>>>> when I try to mount it with `usebackuproot`, it will output the same
>>>>> error message. And dmesg will output
>>>>> ```
>>>>> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
>>>>> deprecated, use 'rescue=3Dusebackuproot' instead
>>>>> [250062.064788] BTRFS info (device sda2): trying to use backup root =
at
>>>>> mount time
>>>>> [250062.064789] BTRFS info (device sda2): disk space caching is enab=
led
>>>>> [250062.064790] BTRFS info (device sda2): has skinny extents
>>>>> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0,
>>>>> rd 0, flush 0, corrupt 5, gen 0
>>>>> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D107374182=
4, invalid
>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>
>>>> Looks like a bad extent tree re-initialization, a bug in btrfs-progs
>>>> then.
>>>>
>>>> For now, you can try to mount with "ro,rescue=3Dibadroots" to see if =
it
>>>> can be mounted RO, then rescue your data.
>>>>
>>>> Thanks,
>>>> Qu
>>>>> [250062.277048] BTRFS error (device sda2): block=3D273006592 read ti=
me
>>>>> tree block corruption detected
>>>>> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D107374182=
4, invalid
>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>> [250062.291927] BTRFS error (device sda2): block=3D273006592 read ti=
me
>>>>> tree block corruption detected
>>>>> [250062.291943] BTRFS error (device sda2): failed to read block grou=
ps:
>>>>> -5
>>>>> [250062.292897] BTRFS error (device sda2): open_ctree failed
>>>>> ```
>>>>>
>>>>> If don't usebackuproot, dmesg will output the same log except the fi=
rst
>>>>> 2
>>>>> lines.
>>>>>
>>>>> Now btrfs check can check this partition:
>>>>>
>>>>> ```
>>>>> $ btrfs check /dev/sda2 2>&1|tee check.txt
>>>>> # see attachment
>>>>> ```
>>>>>
>>>>> Does my disk have any hope to be rescued?
>>>>> thanks!
>>>>>
>>>>> On 7/11/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>
>>>>>>
>>>>>> On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>>>>>> Sorry for my disturbance.
>>>>>>>> After a dirty reboot because of a computer crash, my btrfs partit=
ion
>>>>>>>> cannot be mounted. The same thing happened before, but now `btrfs
>>>>>>>> rescue zero-log` cannot work.
>>>>>>>> ```
>>>>>>>> $ uname -r
>>>>>>>> 5.10.27-gentoo-x86_64
>>>>>>>> $ btrfs rescue zero-log /dev/sda2
>>>>>>>> Clearing log on /dev/sda2, previous log_root 0, level 0
>>>>>>>> $ mount /dev/sda2 /mnt/gentoo
>>>>>>>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
>>>>>>>> /dev/sda2, missing codepage or helper program, or other error.
>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found 9617=
64
>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found 9617=
64
>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found 9617=
64
>>>>>>>> Ignoring transid failure
>>>>>>>> leaf parent key incorrect 34308096
>>>>>>>> ERROR: failed to read block groups: Operation not permitted
>>>>>>>> ERROR: cannot open file system
>>>>>>>> $ dmesg 2>&1|tee dmesg.txt
>>>>>>>> # see attachment
>>>>>>>> ```
>>>>>>>> Like `mount -o ro,usebackuproot` cannot work, too.
>>>>>>>>
>>>>>>>> Thanks for any help!
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> Hi!
>>>>>>>
>>>>>>> Parent transid failed is hard to recover from, as mentioned on
>>>>>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_=
a_.22parent_transid_verify_failed.22_error.3F
>>>>>>>
>>>>>>>
>>>>>>> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy?
>>>>>>> You
>>>>>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>>>>>
>>>>>>> One way of avoiding this error is to disable write-cache. Parent
>>>>>>> transid
>>>>>>> failed can happen when the disk re-orders writes in its write cach=
e
>>>>>>> before flushing to disk. This violates barriers, but it is
>>>>>>> unfortately
>>>>>>> common. If you have a crash, SATA bus reset or other issues,
>>>>>>> unwritten
>>>>>>> content is lost. The problem here is the re-ordering. The superblo=
ck
>>>>>>> is
>>>>>>> written out before other metadata (which is now lost due to the
>>>>>>> crash).
>>>>>>
>>>>>> To be extra accurate, all filesysmtems have taken the re-order into
>>>>>> consideration.
>>>>>> Thus we have flush (or called barrier) command to force the disk to
>>>>>> write all its cache back to disk or at least non-volatile cache.
>>>>>>
>>>>>> Combined with mandatory metadata CoW, it means, no matter what the
>>>>>> disk
>>>>>> re-order or not, we should only see either the newer data after the
>>>>>> flush, or the older data before the flush.
>>>>>>
>>>>>> But unfortunately, hardware is unreliable, sometimes even lies abou=
t
>>>>>> its
>>>>>> flush command.
>>>>>> Thus it's possible some disks, especially some cheap RAID cards, te=
nd
>>>>>> to
>>>>>> just ignore such flush commands, thus leaves the data corrupted aft=
er
>>>>>> a
>>>>>> power loss.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>>
>>>>>>> You disable write cache with "hdparm -W0 /dev/sda". It might be wo=
rth
>>>>>>> adding this to a cron-job every 5 minutes or so, as the setting is
>>>>>>> not
>>>>>>> persistent and can get reset if the disk looses power, goes to sle=
ep,
>>>>>>> etc.
>>>>>>
>>>>
>>>>
>>
