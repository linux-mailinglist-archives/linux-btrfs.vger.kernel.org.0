Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD7A3F5424
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 02:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhHXAjh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 20:39:37 -0400
Received: from mout.gmx.net ([212.227.17.22]:54277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233492AbhHXAjg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 20:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629765531;
        bh=uxMyN/GcoCWVLmefhPNvhjd79bEQ9EyBIePfAD6l8RI=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=ZnBwtgwvXHTvp5XIU5c6GleHC0dDqL7sp3EibKutQoeHfgqUMYNKBJNVyrk0feTwj
         u5k43cDLJYkncF+CfF6kXCOH6gWzwTx5xuK+SmxTdELs4cMYHh/EhNkHC7J8Py67W/
         h7TzrqPtojrCg3Ge8xc3sSv4TDnDSuMWZiN8VtVQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJVHU-1mcBjG2Yie-00Jt5C; Tue, 24
 Aug 2021 02:38:51 +0200
To:     weldon@newfietech.com, linux-btrfs@vger.kernel.org
References: <005201d79860$befd1b60$3cf75220$@newfietech.com>
 <0be8ec2b-7226-f3d1-a02b-608e757bda24@gmx.com>
 <001401d7987c$7bb81ff0$73285fd0$@newfietech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: BTRFS fails mount after power failure
Message-ID: <3dd47d33-7a85-7cec-ca36-f949a3a43b8a@gmx.com>
Date:   Tue, 24 Aug 2021 08:38:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <001401d7987c$7bb81ff0$73285fd0$@newfietech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VF2xvxlg6nZrHfiMZn6JlSq30txfURb+dIY7LJc/s1e6q3fdvMW
 vFfMbGgR4thkIcZ0taB4LL1T4srUjGaHLBQUErVN6sPvVP7Wj+o82+2YBNUF/M43DYR9VD7
 H6BgEyWXt5OSijhcIJoDM0m4l3hvSZw9+/HeLfGhf2ptJUkHamHQU3h6H9oMLngXG4/PVdf
 migcO4jUYdouqjJZVqtYA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XRBDXocImPw=:iiqO8j6G8snA7JT+nfGeb/
 O65kyEM5FXWkQBL0PqYewNnGHmPPYha0lZ4VhBIZbGZHh6ZlYYBlG9yrWjYFnjQRWvzfM9oPC
 +oPPJUxF3VE9HMfqalTtnsCt7Z7UMbDj6ubGO2q2cq38W715qbG/FdsQSPW+jHpA2WgAFbaZF
 VA7PTyx7bilBlZmK+EAubGMk0yeLxAD6lET1G5s3sA85p0Izc4jyU0YQwZL2ufaDxAY/xeXvh
 6WwZEwGHUNXY14V1gndomeWpLWEfpLOq8oLrseHi3HAuScqGgdX1p/T5xmv53W6J1ThQkboyK
 sBAP9bFGy6onwsN6U+7QzY2KvPeFqulZssi9Y980O2eBMjuaJ7X2vBFPt4++Re5AGjtO+wkDK
 7wADAZKTTyjqUXMWSy/g24uImei/YYIqyzOUZlOL7p0VEfYxzhD1T57umv1a7BV+kYI8G8Lp0
 YCXuIPfzNZg3bPNbBx/wM9iMAz3q91wTuP5AyR6YC/3A5GUYxcdzDr3S9a9rfaWbS+LNnhe/9
 6zDn1JQgB9Sfce9qaMoxeM4uTBYGy4Q0Q/dKaQJn05XIFsjVzaUjZOxhg/gDreAozwq65TglA
 0HUeYVAYwNMfrzFpXTopc9kX+XLr4Nt3MHISg6+fBBwMNQL3WO+RalNXvic3fSW2oRMR+pgnN
 8qzUDsS4ICotWRP9v2EC6pLzCleMFcrj4OkdSwbR/NpDbsSwkcCzbBgYAS2YTPectwr3KICw2
 1RD1kLLLBMVTUnZD7jqU237In9To++GrCKJLwYi8ueSyJ2rsbyAVRcRTwWYgref6qI84Yerj8
 ttTOugZCOY8ugqefMureE1UrZAuyBZafgmdLb0XsD6j0nRagpwvm/jd6wuaAYUm2nSZkAL/hx
 dvT9oHpOKX5Go28/PIHDROCeBLa8LyKwCMlJCdgwIl6jXv3DBkNJsOTIdSvnFrrlj9zuYaLxp
 on7yyijmys9hgo0aGMP0R3vYzqcA4a1v+poo++ocf4cUijp+Cjb2rIg4godr3Asszs/9RcDQd
 j8tl7+20LaXEMHHPvtx+b9Wp5MVL1YNKwcgEKagq/5GOcRJWEYQQ2UaOaG2JDzaHkAHZOfMq2
 K2w1XcmK5LSWIhdWtA05jT61ni+2l/QGtVO8U2iOX2mUfAAjYEFf7MS6g==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 =E4=B8=8A=E5=8D=888:10, weldon@newfietech.com wrote:
> Thank you for the reply Qu.
>
> The hardware setup is a bit wonky in a home lab, but is as follows:
>
> Dell PowerEdge R510 Chassis
> Dell PERC H700
> 6 * 4TB SATA Disks in a RAID 5 configuration

The RAID5 is not provided by btrfs, but some hardware RAID controller?

Then we don't need to bother the btrfs RAID5 bug.

But still, this means the RAID controller or the hdd is not doing proper
flush/fua.

This means, next time your UPS went down or a kernel crash happens, you
may still hit a similar problem.

And this time, we're pretty sure it's less possible to blame btrfs code.


> ESXi 6.5 hypervisor sees storage as local DELL Disk, 18.19TB
>
> 17.66TB Provisioned as a Datastore on the hypervisor, VMFS5.
> - 14.5TB provisioned as a vmdk and presented as local disk to Ubuntu vir=
tual machine, mounted as /data (btrfs)
> - 200GB provisioned as vmdk and presented as local disk to Ubuntu virtua=
l machine, mounted as / (ext4)
>
> Happy and willing to try any suggestions you may have.
>
> root@onyx:/home# btrfs ins dump-tree /dev/sdb1

My bad, I mean "btrfs ins dump-super -fFa", but that's for the case of
btrfs RAID5 setup.

Since you're using hardware RAID5 controller, we can go direct to the
recovery part.

Your previous find-root output would be pretty helpful.

You can try btrfs-check with -r option:

# btrfs check -r 7939758882816 /dev/sdb1

To see how many errors it throws. if it had almost no error, then it has
a pretty high chance to recover the data.

You can also try other bytenr from your find-root output, but I guess
you only need to try the first 4 bytenrs.

Thanks,
Qu

> btrfs-progs v5.4.1
> parent transid verify failed on 7939752886272 wanted 120260 found 120262
> parent transid verify failed on 7939752886272 wanted 120260 found 120265
> parent transid verify failed on 7939752886272 wanted 120260 found 120265
> Ignoring transid failure
> WARNING: could not setup extent tree, skipping it
> Couldn't setup device tree
> ERROR: unable to open /dev/sdb1
> root@onyx:/home#
>
>
> Thanks in advance,
> Weldon
>
>
> -----Original Message-----
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Sent: August 23, 2021 5:55 PM
> To: weldon@newfietech.com; linux-btrfs@vger.kernel.org
> Subject: Re: BTRFS fails mount after power failure
>
>
>
> On 2021/8/24 =E4=B8=8A=E5=8D=884:52, weldon@newfietech.com wrote:
>> Good day folks,
>>
>> I awoke this morning to find that my UPS had died overnight and my
>> Ubuntu server with a 14.5TB (Raid 5) BTRFS volume went down with it.
>
> RAID5 has known write hole bug, and although that bug won't cause immedi=
ate problems, it slowly degrades the whole array with each corrupted secto=
r or unexpected power loss.
>
> This would eventually bring down the array with enough degradation.
>
>>   The machine
>> rebooted fine and the hardware reports no errors, however the BTRFS
>> volume  will no longer mount.  The OS boots fine, the 14.5TB volume is
>> for data  storage only.  gparted shows the volume/partition,  and
>> correctly reports  space used as well as total size.  I've never
>> encountered this type of issue  over the past year while using btrfs
>> and I'm not sure where to start.  A  number of google search results
>> express caution when attempting to  recover/repair, so I'm hoping for s=
ome expert advice.
>>
>> My dmesg log exceeds the 100,000 bytes restriction, so I'm unable to
>> attach it, so please ask if there's anything specific I can include oth=
erwise.
>>
>> # uname -a
>> Linux onyx 5.4.0-81-generic #91-Ubuntu SMP Thu Jul 15 19:09:17 UTC
>> 2021
>> x86_64 x86_64 x86_64 GNU/Linux
>>
>> # btrfs --version
>> btrfs-progs v5.4.1
>>
>> # btrfs fi show
>> Label: 'Data'  uuid: 7f500ee1-32b7-45a3-b1e9-deb7e1f59632
>>           Total devices 1 FS bytes used 7.17TiB
>>           devid    1 size 14.50TiB used 7.40TiB path /dev/sdb1
>>
>> # dmesg | grep sdb
>> [    2.312875] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
>> CAPACITY(16).
>> [    2.313010] sd 32:0:1:0: [sdb] 31138512896 512-byte logical blocks: =
(15.9
>> TB/14.5 TiB)
>> [    2.313062] sd 32:0:1:0: [sdb] Write Protect is off
>> [    2.313065] sd 32:0:1:0: [sdb] Mode Sense: 61 00 00 00
>> [    2.313116] sd 32:0:1:0: [sdb] Cache data unavailable
>> [    2.313119] sd 32:0:1:0: [sdb] Assuming drive cache: write through
>> [    2.333321] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
>> CAPACITY(16).
>> [    2.396761]  sdb: sdb1
>> [    2.397170] sd 32:0:1:0: [sdb] Very big device. Trying to use READ
>> CAPACITY(16).
>> [    2.397261] sd 32:0:1:0: [sdb] Attached SCSI disk
>> [    4.709963] BTRFS: device label Data devid 1 transid 120260 /dev/sdb=
1
>> [   21.849570] BTRFS info (device sdb1): disk space caching is enabled
>> [   21.849573] BTRFS info (device sdb1): has skinny extents
>> [   22.023224] BTRFS error (device sdb1): parent transid verify failed =
on
>> 7939752886272 wanted 120260 found 120262
>> [   22.047940] BTRFS error (device sdb1): parent transid verify failed =
on
>> 7939752886272 wanted 120260 found 120265
>
> This already shows some mismatch in on-disk data and recovered data from=
 parity.
>
> This shows the on-disk data and parity have drifted from each other, exa=
ctly the write hole problem.
>
> Furthermore, the disk has newer data than what we expect.
>
> What's the device model? It looks like a misbehavior, not sure if it's f=
rom the hardware, or the btrfs code.
> As RAID56 is already marked as unsafe for a while, not that much love no=
r code fix is directed to RAID56, thus both cases are possible.
>
>> [   22.047949] BTRFS warning (device sdb1): failed to read tree root
>> [   22.089003] BTRFS error (device sdb1): open_ctree failed
>>
>> root@onyx:/home/weldon# btrfs-find-root /dev/sdb1 parent transid
>> verify failed on 7939752886272 wanted 120260 found 120262 parent
>> transid verify failed on 7939752886272 wanted 120260 found 120265
>> parent transid verify failed on 7939752886272 wanted 120260 found
>> 120265 Ignoring transid failure
>> WARNING: could not setup extent tree, skipping it Couldn't setup
>> device tree Superblock thinks the generation is 120260 Superblock
>> thinks the level is 1 Well block 7939758882816(gen: 120264 level: 1)
>> seems good, but generation/level doesn't match, want gen: 120260
>> level: 1 Well block 7939747938304(gen: 120263 level: 1) seems good,
>> but generation/level doesn't match, want gen: 120260 level: 1 Well
>> block 7939756146688(gen: 120262 level: 1) seems good, but
>> generation/level doesn't match, want gen: 120260 level: 1 Well block
>> 7939751559168(gen: 120261 level: 0) seems good, but generation/level
>> doesn't match, want gen: 120260 level: 1
>>
>> *** A large selection of block references was removed due to character
>> count... if needed, I can resend with the full output.
>>
>> Well block 1316967743488(gen: 1293 level: 0) seems good, but
>> generation/level doesn't match, want gen: 120260 level: 1 Well block
>> 1316909662208(gen: 1283 level: 0) seems good, but generation/level
>> doesn't match, want gen: 120260 level: 1 Well block 1316908711936(gen:
>> 1283 level: 0) seems good, but generation/level doesn't match, want
>> gen: 120260 level: 1 root@onyx:/home#
>>
>> Any help or assistance would be greatly appreciated.  Important data
>> has been backed up, however if it's possible to recover without
>> thrashing the entire volume, that would be preferred.
>
> First thing first, don't expect too much about magically turning the fs =
back to fully functional status.
> Transid error is always tricky for btrfs.
>
>
> But for your case, I'm guessing your sdb1 does not have the latest super=
 block.
> We have newer tree roots on disk, but older super block.
>
> Maybe you would like to try "btrfs ins dump-tree" on all the involved di=
sks, and find if there is newer super blocks.
>
> Thanks,
> Qu
>>
>> Regards,
>> Weldon
>>
>
