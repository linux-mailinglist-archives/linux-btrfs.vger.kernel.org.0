Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB133C842C
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 14:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbhGNMDa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 08:03:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:59663 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239276AbhGNMDa (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 08:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626264036;
        bh=h0NYBGKFt9A2e9m3mSFupr2l9fAZAqhM6OVK7dLVTV8=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=LHcgOeWrGNBDX/iA8mpOBG9T8nZlDJSiuuuoyKBwzSlseNJuQ25w+VNfIoOIgSaoC
         bDBjC6RLnXrQXNVw7+FH2HUQWUueIaEOS2VEerpMq5IcBC4rZAZm9tt6mU9SsFyefr
         6PFlUafDQLArdHmnSkkeO5tGN9MmJrrJYQhaYq64=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKbkM-1ligN43Yr6-00L0P7; Wed, 14
 Jul 2021 14:00:36 +0200
To:     Zhenyu Wu <wuzy001@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org, nborisov@suse.com
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net>
 <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
 <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com>
 <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
 <c0024688-3361-7e15-21d1-c55bc16fa83e@gmx.com>
 <CAJ9tZB82FAG5jrD-JLWGLy13OEJut+YYtVtUV8AqZNqGtFJxbw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: btrfs cannot be mounted or checked
Message-ID: <744795fa-e45a-110a-103e-13caf597299a@gmx.com>
Date:   Wed, 14 Jul 2021 20:00:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJ9tZB82FAG5jrD-JLWGLy13OEJut+YYtVtUV8AqZNqGtFJxbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fJWlm1fl5y48Yiv48aUrPM8/+ar6i2Tw1vGcSxBcbXqbqKcx3Jx
 7XQnEVIcd8WMhlmaLGN0+IT8eHxLIJu/nPOms6ZXXd0mRGu6KGon2MutlAPXobGLZdVhLZK
 OdDd5RpSIAZ38Iaz7kqfmPpWWfzelRhMygvbfEChFupciaQ/IomFg9xGJKL56PU41hRifvc
 qnYtvELDX0Um/j7VuBqWg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:vzAFMJNSgSI=:Oyc2HOrNjaF5c6z8tsDIBZ
 xdWHH4RW62EotT1Gq4qNHea+6PMLwC3vqqDSqeJJN5gtoVTqXrz9k/RsFCFx6TAgTI5/U0N6Y
 qoKqzaMYLaSYvaNp1XZkevZtHEo/tt6xMWrHIgvLPdOVLOKIj4oldsGGW6jhORvXU1y0V/7fp
 MPAgud2e7NEoqMSRBHcCW/zPrZJ7f6Tq78WxUfxcWE/S07i9QDo3KjLKyf2tWg3LhBRR8uk5f
 ZKZq1uJnWGQhFxBT+0KuSKJfyBezWqXP03GXXAFnU65Ol9l7xUyeUzELj6hejGFEinevZR283
 fMWtumU6qvchbut1HEaOV6+E04iUZUy79kPeuW/X7AUSj0EydGMpGhmFCmpx236zDFQ6VIrFu
 ETvzx6hgqR6Yz0sDPTkqgq41ttB4t2iqoWFf4oQy0Q6PgGz3zwlYJDHBZKfFUDuRLtwzLUPnE
 TIsTyI5MB0H9b1SwVTweQR6HaiZem5kR60VbQQii9wdDCjyPa9joHQqQ9Eheg5U6cgowrrCWO
 85qNFk7AAud8wOOB5UhSVrzbDxSZu+txuvzLsHPdwM8VU9aOd1b8cn/PfjOoV9YplbYa4xDHP
 R4Ck467/wKFYkQpFag1JGyzvZ7KywjQoFjOAewx5ffasdGeg5Zbo04QKyG48GlIJl4q5h206C
 MhhR6aK+ITBjkZ/6xwSnTKHlwHFrGbiCsonYWBMecjkDPtou0PUdeftMscoRDu/OAPMwQ2sxs
 /u7t1I4eSdSLWYMyOmtp0mwTicwXkc6YIO47hztoKFB30EiXxcC5HqOvSnKKE3oOejs1Fz91F
 yE6NLo6KScCsTj6/4E6HPx8NucOnad8Y3DUAwJzZnKz3d+to0M7qGnIiVR7fB2J98ubS7DlBo
 90MQqErSWwM/YKqTqvbWuxABLz1/FIhOzvlF7HvKYM5SfV0NMCeYRIIRhDvfXhiCdBols+Ac3
 D/0Nxv2MlTaYC2YsiQDJCPqfj+eD0H6J+Y4FzY+oHBXCmUbxx0WfSXwAurNcd5GeyFVCiMgPG
 MMBawEC3dXw6Pq7PgVavhQ1g5XpLBQK6+EVZcBnMdMFYdO3DUretNjSAvLK1x0rghFSzpLnTd
 1Y4doDMJ5mhM4S9xdiB3OARGSlFNoZqhM1ZwLFMVk+DhorC3As/XQdQtQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=887:37, Zhenyu Wu wrote:
> sorry:( can it be specific?
> btrfs-map-logical looks like need an option, btrfs ins dump-tree is
> outputing many text, and how to locate the extent tree?
> Thanks!

Oh, sorry I should explain it more.

Here is the more detailed version.

NOTE: this only works for non-RAID5/6 metadata profiles.
RAID5/6 has extra P/Q to recovery the metadata.

- Use "btrfs ins dump-tree" to determine where the extent tree root is

   $ btrfs ins dump-tree -t root /dev/test/test | grep -A 3 EXTENT_TREE
         item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 itemsize 439
                 generation 3682 root_dirid 0 bytenr 30441472 level 1 refs=
 1
                 lastsnap 0 byte_limit 0 bytes_used 65536 flags 0x0(none)
                 uuid 00000000-0000-0000-0000-000000000000

   The bytenr "30441472" is the bytenr you need to take note of.
   (Here the number is just my example, yours will change obviously)

- Use "btrfs-map-logical" to determine the real location of the metadata

   $ btrfs-map-logical -l 30441472 /dev/test/test
   mirror 1 logical 30441472 physical 38830080 device /dev/test/test
   mirror 2 logical 30441472 physical 307265536 device /dev/test/test

   The two physical numbers, "38830080" and "307265536", are the real
   offset inside each device.

- Corrupt the metadata header of both copies

   Only 4 bytes are needed to be corrupted.

   # xfs_io -f -c "pwrite 38830080 4" /dev/test/test
   # xfs_io -f -c "pwrite 307265536 4" /dev/test/test

- Verify the corruption works:
   $ btrfs check /dev/test/test
   Opening filesystem to check...
   checksum verify failed on 30441472 wanted 0xcdcdcdcd found 0x900b6dae
   checksum verify failed on 30441472 wanted 0xcdcdcdcd found 0x900b6dae
   checksum verify failed on 30441472 wanted 0xcdcdcdcd found 0x900b6dae
   Csum didn't match
   ERROR: could not setup extent tree
   ERROR: cannot open file system

   0xcd is the default pattern of xfs_io pwrite. And the line "ERROR:
   could not setup extent tree" means extent tree is completely
   corrupted.

- Use rescue=3Dibadroots to rescue the fs

   # mount -o ro,rescue=3Dibadroots /dev/test/test /mnt/btrfs

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
