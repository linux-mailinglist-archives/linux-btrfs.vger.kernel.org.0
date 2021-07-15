Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0323C982E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 07:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239431AbhGOFT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 01:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238195AbhGOFT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 01:19:58 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF57C061762
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 22:17:05 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id e20so1597350ual.9
        for <linux-btrfs@vger.kernel.org>; Wed, 14 Jul 2021 22:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4Lkq95i4b9q7D1xqUCjTpeEbByNWNq/9mUXtsnKgrWs=;
        b=XyuEB/ytlc0oYm1SHI8R5u55SLuPMJMxRIoKkEIBnm9H+405Y/hiu98vn2nQjvLIM1
         VFwcKpNWOPkiAV41KQD3hqJZ7kFEGZ0uRjkBpbKWAWxUkG5xVZB/2+B/gSr0sE6GgMGM
         KOw5X5CPjcuC8F2sYzNmg0hw6iGDdqmNAAIOzNNFltKb2Pq6YrJ0cicJhLQ0dRAYS0cH
         5svKmKxQf85476I8y4jm6QV9kmyMgy2+HdD96IUeC6vgX5Hagj5JLpUCRryUlXalZYEq
         GhbsAwMAvDQI1DjVsUJfuwzljVGzr3IKa+p+tk6xflBuPPIwp+mBp5EZ1O3oOKXbIprx
         4cmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4Lkq95i4b9q7D1xqUCjTpeEbByNWNq/9mUXtsnKgrWs=;
        b=jYY/A+6QYOFF4tdUvefFJHUJ6N74zlimUwpQLJSErb8SmNciVdoHAWLTtZ1/XX086z
         jOCvSdEol2Emif5aUZyiw7N6QfY1lpux2sl9SGsrwE1EISDp8xiIRYWIe7bVJ9JfL3WJ
         q1jxtL47voYauZkJZjJ6ZC/oTto+vVue2o0JVrUcKQcmCA9TckyTOohTpjvIQe9J7OSS
         Rk4K7a1hqc8DznzGxdYxSQSSsxZoWRQxOqozJc14F194nQnYq8r/64McCtJqDbMqoYhc
         WkG6mZzeMoo91Cq4H9/xZoC1h0HLyZGM4c2Au22qezfLLgZx6sKi6DPcgnwi+KfKXzPL
         NdjQ==
X-Gm-Message-State: AOAM5318TIfD9xSQSCiRMqgn2v9sKSxwrXEK8w3AzAWJIl0XvEm4SCDJ
        PTGfkMNn6CYMj6JS5vMQjn4L18NeYodouCPwfOA=
X-Google-Smtp-Source: ABdhPJxvHJ5WxD6Gmm7iwBeIZ0JGGRWvuu/MatAc9RRNjBEWWQgFSp2FSVuM6odsAZ9ipjEQyVQcF7ptEGdb5eK3N2w=
X-Received: by 2002:ab0:3146:: with SMTP id e6mr3785028uam.52.1626326224267;
 Wed, 14 Jul 2021 22:17:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:1447:0:0:0:0:0 with HTTP; Wed, 14 Jul 2021 22:17:03
 -0700 (PDT)
In-Reply-To: <b25141f0-d4c7-05bc-05af-848b6ed26b1d@gmx.com>
References: <CAJ9tZB_VHc4x3hMpjW6h_3gr5tCcdK7RpOUcAdpLuR5PVpW8EQ@mail.gmail.com>
 <110a038d-a542-dcf5-38b8-5f15ee97eb2c@tnonline.net> <2a9b53ea-fd95-5a92-34a5-3dcac304cec1@gmx.com>
 <CAJ9tZB9X=iWvUSuyE=nPJ8Chge4E_f-9o67A-d=zt4ZAnXjeCg@mail.gmail.com>
 <9e4f970a-a8c5-8b96-d0bb-d527830d0d12@suse.com> <CAJ9tZB_C+RLX0oRTKuUZv0ZxGQiWOL=1EGzM=rHD0gMhgbhGmA@mail.gmail.com>
 <c0024688-3361-7e15-21d1-c55bc16fa83e@gmx.com> <CAJ9tZB-O+xphuHJ-DhpjvoFFuFAJrSpoMuurx_44s040YWBtqQ@mail.gmail.com>
 <b25141f0-d4c7-05bc-05af-848b6ed26b1d@gmx.com>
From:   Zhenyu Wu <wuzy001@gmail.com>
Date:   Thu, 15 Jul 2021 13:17:03 +0800
Message-ID: <CAJ9tZB9V7xYVLq_PFHQ97Y3Rau-ZBjjGmaWayDtLBaj7f00xWg@mail.gmail.com>
Subject: Re: btrfs cannot be mounted or checked
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

```
$ btrfs ins dump-tree -t root /dev/sda2|grep -A3 EXTENT_TREE|grep
bytenr|tr -d '\t'|cut -d' ' -f6 > num
$ btrfs-map-logical -l `cat num` /dev/sda2|cut -d' ' -f6 > phy
$ xfs_io -f -c "pwrite `tail -n1 phy` 4" /dev/sda2
wrote 4/4 bytes at offset 499117572096
4.000000 bytes, 1 ops; 0.3517 sec (11.370161 bytes/sec and 2.8425 ops/sec)
$ xfs_io -f -c "pwrite `head -n1 phy` 4" /dev/sda2
# same as above
$ btrfs check /dev/sda2
Opening filesystem to check...
checksum verify failed on 1370128760832 wanted 0xcdcdcdcd found 0xe6568433
checksum verify failed on 1370128760832 wanted 0xcdcdcdcd found 0xe6568433
checksum verify failed on 1370128760832 wanted 0xcdcdcdcd found 0xe6568433
Csum didn't match
ERROR: could not setup extent tree
ERROR: cannot open file system
$ mount -o ro,rescue=3Dibadroots /dev/sda2 /mnt
$ findmnt /mnt
TARGET SOURCE    FSTYPE OPTIONS
/mnt   /dev/sda2 btrfs
ro,relatime,rescue=3Dignorebadroots,space_cache,subvolid=3D5,subvol=3D/
$ dmesg|grep BTRFS
[    7.166566] BTRFS: device label gentoo devid 1 transid 2375312
/dev/sda2 scanned by systemd-udevd (147)
[  990.864811] BTRFS info (device sda2): ignoring bad roots
[  990.864836] BTRFS info (device sda2): disk space caching is enabled
[  990.864849] BTRFS info (device sda2): has skinny extents
[  990.910642] BTRFS warning (device sda2): sda2 checksum verify
failed on 1370128760832 wanted 0xcdcdcdcd found 0xe6568433 level 2
[  990.920955] BTRFS warning (device sda2): sda2 checksum verify
failed on 1370128760832 wanted 0xcdcdcdcd found 0xe6568433 level 2
[  990.990469] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0, rd
0, flush 0, corrupt 5, gen 0
[  990.992263] BTRFS error (device sda2): qgroup generation mismatch,
marked as inconsistent
```

It works!
now can I boot my computer from disk not live USB?

Thanks!

On 7/15/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
> On 2021/7/14 =E4=B8=8B=E5=8D=889:52, Zhenyu Wu wrote:
>> I found btrfs-5.12 in archlinux (surprisedly)
>>
>> When I try to mount with ro, rescue=3Dibadroots, I will get
>> ```
>> wrong fs type, bad option, bad superblock on
>> /dev/sda2, missing codepage or helper program, or other error.
>> ```
>>
>> dmesg will output
>> ```
>> [ 1087.646701] BTRFS info (device sda2): ignoring bad roots
>> [ 1087.646725] BTRFS info (device sda2): disk space caching is enabled
>> [ 1087.646735] BTRFS info (device sda2): has skinny extents
>> [ 1087.770464] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0, rd
>> 0, flush 0, corrupt 5, gen 0
>> [ 1087.834263] BTRFS critical (device sda2): corrupt leaf: root=3D2
>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, i=
nvalid
>> block group used, have 1073754112 expect [0, 1073741824)
>> [ 1087.834550] BTRFS error (device sda2): block=3D273006592 read time
>> tree block corruption detected
>> [ 1087.848452] BTRFS critical (device sda2): corrupt leaf: root=3D2
>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D1073741824, i=
nvalid
>> block group used, have 1073754112 expect [0, 1073741824)
>> [ 1087.848762] BTRFS error (device sda2): block=3D273006592 read time
>> tree block corruption detected
>> [ 1087.849006] BTRFS error (device sda2): failed to read block groups: -=
5
>> [ 1087.851674] BTRFS error (device sda2): open_ctree failed
>> ```
>> does it mean my extent tree is still intact? so I need to btrfs ins
>> dump-tree, btrfs-map-logical?
>> thanks!
>
> Yep, you need to corrupt the extent tree to rescue the data, ironically.
>
> Thanks,
> Qu
>>
>> On 7/14/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>
>>>
>>> On 2021/7/14 =E4=B8=8B=E5=8D=885:58, Zhenyu Wu wrote:
>>>> ```
>>>> [  301.533172] BTRFS info (device sda2): unrecognized rescue option
>>>> 'ibadroots'
>>>> [  301.533209] BTRFS error (device sda2): open_ctree failed
>>>> ```
>>>>
>>>> Does ibadroots need a newer version of btrfs? My btrfs version is
>>>> 5.10.1.
>>>
>>> Oh, that support is added in v5.11...
>>>
>>> You may want to grab a liveCD from some rolling release.
>>>
>>> But even with v5.11, it may not help much, as that option won't help if
>>> your extent tree is still intact.
>>>
>>> You may want to use "btrfs ins dump-tree" to locate your extent tree,
>>> then corrupt the extent tree root completely (using btrfs-map-logical t=
o
>>> get the physical offset, then dd to destory the first 4 bytes of both
>>> copy), then the option would properly work.
>>>
>>> Thanks,
>>> Qu
>>>>
>>>> Thanks!
>>>>
>>>> On 7/14/21, Qu Wenruo <wqu@suse.com> wrote:
>>>>>
>>>>>
>>>>> On 2021/7/14 =E4=B8=8B=E5=8D=884:49, Zhenyu Wu wrote:
>>>>>> sorry for late:(
>>>>>>
>>>>>> I found <https://bbs.archlinux.org/viewtopic.php?id=3D233724> looks
>>>>>> same
>>>>>> as my situation. But in my computer (boot from live usb) `btrfs chec=
k
>>>>>> --init-extent-tree` output a lot of non-ascii character (maybe
>>>>>> because
>>>>>> ansi escape code mess the terminal)
>>>>>> after several days it outputs `7/7`and `killed`. The solution looks
>>>>>> failed.
>>>>>>
>>>>>> I'm sorry because my live usb don't have smartctl :(
>>>>>>
>>>>>> ```
>>>>>> $ hdparm -W0 /dev/sda
>>>>>> /dev/sda:
>>>>>>     setting drive write-caching to 0 (off)
>>>>>>     write-caching =3D  0 (off)
>>>>>> ```
>>>>>>
>>>>>> But now the btrfs partition still cannot be mounted.
>>>>>>
>>>>>> when I try to mount it with `usebackuproot`, it will output the same
>>>>>> error message. And dmesg will output
>>>>>> ```
>>>>>> [250062.064785] BTRFS warning (device sda2): 'usebackuproot' is
>>>>>> deprecated, use 'rescue=3Dusebackuproot' instead
>>>>>> [250062.064788] BTRFS info (device sda2): trying to use backup root
>>>>>> at
>>>>>> mount time
>>>>>> [250062.064789] BTRFS info (device sda2): disk space caching is
>>>>>> enabled
>>>>>> [250062.064790] BTRFS info (device sda2): has skinny extents
>>>>>> [250062.208403] BTRFS info (device sda2): bdev /dev/sda2 errs: wr 0,
>>>>>> rd 0, flush 0, corrupt 5, gen 0
>>>>>> [250062.277045] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D107374182=
4,
>>>>>> invalid
>>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>>
>>>>> Looks like a bad extent tree re-initialization, a bug in btrfs-progs
>>>>> then.
>>>>>
>>>>> For now, you can try to mount with "ro,rescue=3Dibadroots" to see if =
it
>>>>> can be mounted RO, then rescue your data.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>> [250062.277048] BTRFS error (device sda2): block=3D273006592 read ti=
me
>>>>>> tree block corruption detected
>>>>>> [250062.291924] BTRFS critical (device sda2): corrupt leaf: root=3D2
>>>>>> block=3D273006592 slot=3D17 bg_start=3D1104150528 bg_len=3D107374182=
4,
>>>>>> invalid
>>>>>> block group used, have 1073754112 expect [0, 1073741824)
>>>>>> [250062.291927] BTRFS error (device sda2): block=3D273006592 read ti=
me
>>>>>> tree block corruption detected
>>>>>> [250062.291943] BTRFS error (device sda2): failed to read block
>>>>>> groups:
>>>>>> -5
>>>>>> [250062.292897] BTRFS error (device sda2): open_ctree failed
>>>>>> ```
>>>>>>
>>>>>> If don't usebackuproot, dmesg will output the same log except the
>>>>>> first
>>>>>> 2
>>>>>> lines.
>>>>>>
>>>>>> Now btrfs check can check this partition:
>>>>>>
>>>>>> ```
>>>>>> $ btrfs check /dev/sda2 2>&1|tee check.txt
>>>>>> # see attachment
>>>>>> ```
>>>>>>
>>>>>> Does my disk have any hope to be rescued?
>>>>>> thanks!
>>>>>>
>>>>>> On 7/11/21, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2021/7/11 =E4=B8=8B=E5=8D=887:37, Forza wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 2021-07-11 10:59, Zhenyu Wu wrote:
>>>>>>>>> Sorry for my disturbance.
>>>>>>>>> After a dirty reboot because of a computer crash, my btrfs
>>>>>>>>> partition
>>>>>>>>> cannot be mounted. The same thing happened before, but now `btrfs
>>>>>>>>> rescue zero-log` cannot work.
>>>>>>>>> ```
>>>>>>>>> $ uname -r
>>>>>>>>> 5.10.27-gentoo-x86_64
>>>>>>>>> $ btrfs rescue zero-log /dev/sda2
>>>>>>>>> Clearing log on /dev/sda2, previous log_root 0, level 0
>>>>>>>>> $ mount /dev/sda2 /mnt/gentoo
>>>>>>>>> mount: /mnt/gentoo: wrong fs type, bad option, bad superblock on
>>>>>>>>> /dev/sda2, missing codepage or helper program, or other error.
>>>>>>>>> $ btrfs check /dev/sda2
>>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found
>>>>>>>>> 961764
>>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found
>>>>>>>>> 961764
>>>>>>>>> parent transid verify failed on 34308096 wanted 962175 found
>>>>>>>>> 961764
>>>>>>>>> Ignoring transid failure
>>>>>>>>> leaf parent key incorrect 34308096
>>>>>>>>> ERROR: failed to read block groups: Operation not permitted
>>>>>>>>> ERROR: cannot open file system
>>>>>>>>> $ dmesg 2>&1|tee dmesg.txt
>>>>>>>>> # see attachment
>>>>>>>>> ```
>>>>>>>>> Like `mount -o ro,usebackuproot` cannot work, too.
>>>>>>>>>
>>>>>>>>> Thanks for any help!
>>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi!
>>>>>>>>
>>>>>>>> Parent transid failed is hard to recover from, as mentioned on
>>>>>>>> https://btrfs.wiki.kernel.org/index.php/FAQ#How_do_I_recover_from_=
a_.22parent_transid_verify_failed.22_error.3F
>>>>>>>>
>>>>>>>>
>>>>>>>> I see you have "corrupt 5" sectors in dmesg. Is your disk healthy?
>>>>>>>> You
>>>>>>>> can check with "smartctl -x /dev/sda" to determine the health.
>>>>>>>>
>>>>>>>> One way of avoiding this error is to disable write-cache. Parent
>>>>>>>> transid
>>>>>>>> failed can happen when the disk re-orders writes in its write cach=
e
>>>>>>>> before flushing to disk. This violates barriers, but it is
>>>>>>>> unfortately
>>>>>>>> common. If you have a crash, SATA bus reset or other issues,
>>>>>>>> unwritten
>>>>>>>> content is lost. The problem here is the re-ordering. The
>>>>>>>> superblock
>>>>>>>> is
>>>>>>>> written out before other metadata (which is now lost due to the
>>>>>>>> crash).
>>>>>>>
>>>>>>> To be extra accurate, all filesysmtems have taken the re-order into
>>>>>>> consideration.
>>>>>>> Thus we have flush (or called barrier) command to force the disk to
>>>>>>> write all its cache back to disk or at least non-volatile cache.
>>>>>>>
>>>>>>> Combined with mandatory metadata CoW, it means, no matter what the
>>>>>>> disk
>>>>>>> re-order or not, we should only see either the newer data after the
>>>>>>> flush, or the older data before the flush.
>>>>>>>
>>>>>>> But unfortunately, hardware is unreliable, sometimes even lies abou=
t
>>>>>>> its
>>>>>>> flush command.
>>>>>>> Thus it's possible some disks, especially some cheap RAID cards,
>>>>>>> tend
>>>>>>> to
>>>>>>> just ignore such flush commands, thus leaves the data corrupted
>>>>>>> after
>>>>>>> a
>>>>>>> power loss.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>>
>>>>>>>> You disable write cache with "hdparm -W0 /dev/sda". It might be
>>>>>>>> worth
>>>>>>>> adding this to a cron-job every 5 minutes or so, as the setting is
>>>>>>>> not
>>>>>>>> persistent and can get reset if the disk looses power, goes to
>>>>>>>> sleep,
>>>>>>>> etc.
>>>>>>>
>>>>>
>>>>>
>>>
>
