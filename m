Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695F34E6B44
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 00:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349311AbiCXXjm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Mar 2022 19:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357478AbiCXXj3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Mar 2022 19:39:29 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F095E9E9DF
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Mar 2022 16:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648165072;
        bh=cQLcO401S2D3EVSAZs85lvXRvPl6nbFWFjEQVNCo8wA=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Gk2snIohY5EAxZs7GoKfzHLyFSEEpuAKlEwu6Hwyj/IS+A3CpHAH7EjuYijLut2Ni
         /auVSTadcdxpEmh5ZjKjxoG3j1Xeuc7NSgZUuebh88eI1C5+i5uF4Ka+nXCMq274b3
         gwJYe7BITW7o3Kak1/h30an6+bL/6h9wiqmtvx2Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N6bk4-1o8eSD2Myk-0186db; Fri, 25
 Mar 2022 00:37:52 +0100
Message-ID: <583cb8cd-95f8-30f7-5420-dd09938eb9fd@gmx.com>
Date:   Fri, 25 Mar 2022 07:37:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: failed to read block groups: Input/output error; bad tree block -
 bytenr mismatch;
Content-Language: en-US
To:     Joseph Spagnol <joseph.spagnol@programmer.net>
Cc:     linux-btrfs@vger.kernel.org
References: <trinity-58cb51fa-9b3e-4fd0-9ff7-29da0dd13e14-1647953588232@3c-app-mailcom-lxa08>
 <f1159186-c73d-5102-549d-8e343f1bca0d@gmx.com>
 <trinity-56388cba-8de1-43e3-8e32-a8f8b6d0d246-1647969466534@3c-app-mailcom-lxa08>
 <9d942b5b-f52b-b3bc-954f-710abc9ce556@gmx.com>
 <trinity-08eddd3b-de79-4a7b-8cd1-2f2ead6f7513-1648130840007@3c-app-mailcom-lxa01>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <trinity-08eddd3b-de79-4a7b-8cd1-2f2ead6f7513-1648130840007@3c-app-mailcom-lxa01>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Iw4Fby2Px/PkQQk62N1YBLc0MvFDA/9VQ9hyXfI+EkWFtIStnp
 lES94RVBGC8RkKPpFqG1hkjeO6TsS0kHC4LqMozCbsuqEmXowTdij9ntRv0MVwLF8/1b/TR
 o4ksqHiNdNj5TDyVpfHKuYjj5mJXW1q4C/+H371WNR9stPe+N3UsGrrOa6k+Fb3YxWB8pdR
 NRkdCLSGOWZ/T00asxYOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cuTM19jN4v0=:+7ewr+VWvFQWOaT0b6N79K
 /t8kEhdEXW0Zkbiq46/LAD2zhGRBX2Gx5z8AGDoOaQThsCeRQo4fuZ6hs/h/arg1KsZ4EC5tR
 wqS/sFcxrKoO8ZY9OtdhzZDvwM7gUDmSht/giELif3HTXjbPQ/TLmh7NY1ivlUDQqm3yST+yS
 +XRXKI7PgeeI+X4oCvAUI6hRyOQxw4gnUipE6mTsHJuRTX/wUsW5xhOM728BczI+a47JQpOV+
 swE6PPOdwg1pep4Kzlr9R6uaiLBVyraGKSx8CaqYaFg26/wqyVHXFOk/c3BcV1qC2pG2tRD4c
 THP60rKnm+qDj8ECet6eKxRzlCUpDVjkMYIVNrxhrvyStm5ZpaU1zN2/W1al17ACQAbANf5Bv
 PhjYDmLjm7ptt9iovb1w8/elnIyrwYwEEIHAQt99ITzNbeooLxW4yJVRX8CSSnAPFDr9s45HE
 q+D/VaTlVRCJqYiVS3xPXdosxR3cCfvvpPjb++EDPmqIISgMviprnWHH65DVMg2Sk4jO9+HR7
 o/5eXxpBBCwCnDeu+9q1lzFGkAUblNuw70H2oBrW6SBsQ7HMyNsP/P96jL7YscfdMHBVDBz8o
 ZxOFpnjgqntAvWzhNFtqfu6Gft7CB0IbLm2QMiFS+eydB+ORV+KvzMAuSu4y6ARKghR8TYUO5
 5iDVPLiLReeUVlOQES/mQMM25OfHd0WjKvyEl8by9lDFLyp7KMBV4vUxKZ5QYSg+WcMSPZMW+
 kEFOZ7Ny423/9Srbdm2tVkr8fSJ4s539BRMixieXrwAdrUGbDizgAroRIudC8tKTC65xNl0+w
 yas0y2i+bcKwexoli4JVnqOGgy4BFN/MbbH2I6AXQbEzic9Vg5QA/Drj1FUaKI09Tt/iYoY+u
 KxofOy8VzedcVevSdU7Xfy0UKxpj7Okc5CYwBY2RAGrZR4vOtNUJBWd3UlKGWkdMAlyQSC92N
 EJ6sU3Tc8ArGowXSAExAXIJQ4cMXYLqM7QtX4ts7/ncTPqKLppj8A2p7khLuc0wiYs738tsOO
 bEDm+FRS2GfnA7Y0eyjdTdzMsMfiric+3JRYCV72H/SfQ1od84l4xMcxQMBu+R7LuHq1hr3To
 81V4wsxKDl3vB8=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/24 22:07, Joseph Spagnol wrote:
> Hello again,
>
>> # uname -r
>> 5.16.11-1-default
>> # mount -t btrfs -o rescue=3Dall,ro /dev/sda4 /mnt/
>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, mi=
ssing codepage or helper program, or other error.
>
>> Dmesg please.
> Here is the dmesg
>
> [21560.215563] BTRFS info (device sda3): flagging fs with big metadata f=
eature
> [21560.215570] BTRFS info (device sda3): disk space caching is enabled
> [21560.215572] BTRFS info (device sda3): has skinny extents
> [21560.218654] BTRFS info (device sda3): bdev /dev/sda3 errs: wr 0, rd 0=
, flush 0, corrupt 3181, gen 0
> [21560.229756] BTRFS info (device sda3): enabling ssd optimizations
> [87063.535960] BTRFS info (device nvme0n1p4): qgroup scan completed (inc=
onsistency flag cleared)
> [161387.456900] BTRFS info (device sda4): flagging fs with big metadata =
feature
> [161387.456905] BTRFS info (device sda4): disk space caching is enabled
> [161387.456906] BTRFS info (device sda4): has skinny extents
> [161387.458569] BTRFS error (device sda4): bad tree block start, want 23=
235280896 have 0
> [161387.458584] BTRFS warning (device sda4): couldn't read tree root
> [161387.458847] BTRFS error (device sda4): open_ctree failed
> [161620.891324] BTRFS info (device sda4): flagging fs with big metadata =
feature
> [161620.891336] BTRFS info (device sda4): enabling all of the rescue opt=
ions
> [161620.891338] BTRFS info (device sda4): ignoring data csums
> [161620.891340] BTRFS info (device sda4): ignoring bad roots
> [161620.891342] BTRFS info (device sda4): disabling log replay at mount =
time
> [161620.891345] BTRFS info (device sda4): disk space caching is enabled
> [161620.891347] BTRFS info (device sda4): has skinny extents
> [161620.893575] BTRFS error (device sda4): bad tree block start, want 23=
235280896 have 0
> [161620.893599] BTRFS warning (device sda4): couldn't read tree root

The critical root tree has part of its tree blocks wiped out, just like
other tree blocks.

Thus rescue=3Dall can not help much.

> [161620.894212] BTRFS error (device sda4): open_ctree failed
>
>> Am not sure this can help but this btrfs partition become like this aft=
er a sudden system freeze.
>
>> Without dmesg of that incident, pretty hard to say.
> I'm not sure I am able to retrieve this, but I will try.
>
>> Did you changed the partition size without using btrfs device resize?
> On the following boot I had a disk check and it asked for a resize and I=
 executed it but it was not on the failed partition which at that moment I=
 had no clue it was failed.

So far it looks like a lot of tree blocks are wiped out.

Any more detailed history on this?

Thanks,
Qu

>
> Thanks
> Joseph
>
> Sent:=C2=A0Wednesday, March 23, 2022 at 12:39 AM
> From:=C2=A0"Qu Wenruo" <quwenruo.btrfs@gmx.com>
> To:=C2=A0"Joseph Spagnol" <joseph.spagnol@programmer.net>
> Cc:=C2=A0linux-btrfs@vger.kernel.org
> Subject:=C2=A0Re: failed to read block groups: Input/output error; bad t=
ree block - bytenr mismatch;
>
> On 2022/3/23 01:17, Joseph Spagnol wrote:
>> Hello, thanks for the quick response.
>> unfortunately the ro mount from a more recent kernel does not work as w=
ell
>>
>> # uname -r
>> 5.16.11-1-default
>> # mount -t btrfs -o rescue=3Dall,ro /dev/sda4 /mnt/
>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, mi=
ssing codepage or helper program, or other error.
>
> Dmesg please.
>
> But I guess there are more errors on the critical trees, thus it failed.
>
>>
>> Am not sure this can help but this btrfs partition become like this aft=
er a sudden system freeze.
>
> Without dmesg of that incident, pretty hard to say.
>
>>
>> Is there a possibility to check an fix the partition size?
>> I believe it could be an issue with the actual size of the partition/pa=
rtitions.
>
> Not sure what you mean here.
>
> Did you changed the partition size without using btrfs device resize?
>
> Thanks,
> Qu
>
>>
>> Sent:=C2=A0Tuesday, March 22, 2022 at 2:05 PM
>> From:=C2=A0"Qu Wenruo" <quwenruo.btrfs@gmx.com>
>> To:=C2=A0"Joseph Spagnol" <joseph.spagnol@programmer.net>, linux-btrfs@=
vger.kernel.org
>> Subject:=C2=A0Re: failed to read block groups: Input/output error; bad =
tree block - bytenr mismatch;
>>
>> On 2022/3/22 20:53, Joseph Spagnol wrote:
>>> Hello, recently one of my btrfs partitions has become unavailable and =
am not able to mount it.
>>>
>>> # mount -t btrfs /dev/sda4 /mnt/
>>> mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sda4, m=
issing codepage or helper program, or other error.
>>>
>>> # btrfs-find-root /dev/sda4
>>> Couldn't read tree root
>>> Superblock thinks the generation is 432440
>>> Superblock thinks the level is 1
>>> Well block 23235313664(gen: 432440 level: 0) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23231447040(gen: 432439 level: 1) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23229202432(gen: 432438 level: 0) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23192911872(gen: 432431 level: 1) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23177084928(gen: 432430 level: 1) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23149035520(gen: 432429 level: 1) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23124443136(gen: 432427 level: 1) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23113547776(gen: 432426 level: 1) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23080730624(gen: 432425 level: 1) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23048241152(gen: 432424 level: 1) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> Well block 23013031936(gen: 432422 level: 1) seems good, but generatio=
n/level doesn't match, want gen: 432440 level: 1
>>> .......
>>>
>>> # btrfsck -b -p /dev/sda4
>>> Opening filesystem to check...
>>> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810fa=
f8
>>> checksum verify failed on 23234035712 wanted 0x00000000 found 0x0810fa=
f8
>>> bad tree block 23234035712, bytenr mismatch, want=3D23234035712, have=
=3D0
>>
>> Some range is completely wiped out.
>> And that wiped out range is in extent tree.
>>
>>
>> There are several two theories for it:
>>
>> - Some discard related bug
>> It can be the firmware of disk, or btrfs itself.
>> Some range got wiped out even we're still needing it.
>>
>> - Some missing writes
>> The write should reach disk but didn't.
>> This means the barrier is not working.
>> In that case, disk firmware may be the problem.
>>
>>
>>> ERROR: failed to read block groups: Input/output error
>>> ERROR: cannot open file system
>>>
>>> Here are some more details;
>>> # uname -a
>>> Linux msi-b17-manjaro 5.4.184-1-MANJARO #1 SMP PREEMPT Fri Mar 11 13:5=
9:07 UTC 2022 x86_64 GNU/Linux
>>> # btrfs --version
>>> btrfs-progs v5.16.2
>>> # btrfs fi show
>>> Label: 'OLDDATA' uuid: 9bc104b4-c889-477f-aae1-4d865cdc0372
>>> Total devices 1 FS bytes used 34.20GiB
>>> devid 1 size 50.00GiB used 37.52GiB path /dev/sda3
>>> Label: 'OPENSUSE' uuid: c3632d30-a117-43ef-8993-88f1933f6676
>>> Total devices 1 FS bytes used 24.60GiB
>>> devid 1 size 150.00GiB used 31.05GiB path /dev/nvme0n1p4
>>> Label: 'DATA' uuid: 4ce61b29-8c8d-4c04-b715-96f0dda809a4
>>> Total devices 1 FS bytes used 118.67GiB
>>> devid 1 size 200.00GiB used 122.02GiB path /dev/sda4
>>> # btrfs fi df /dev/sda4
>>> ERROR: not a directory: /dev/sda4
>>> # btrfs fi df /data/
>>> ERROR: not a btrfs filesystem: /data/
>>> ## dmesg.log ##
>>> [65500.890756] BTRFS info (device sda4): flagging fs with big metadata=
 feature
>>> [65500.890766] BTRFS warning (device sda4): 'recovery' is deprecated, =
use 'usebackuproot' instead
>>> [65500.890768] BTRFS info (device sda4): trying to use backup root at =
mount time
>>> [65500.890771] BTRFS info (device sda4): disabling disk space caching
>>> [65500.890773] BTRFS info (device sda4): force clearing of disk cache
>>> [65500.890775] BTRFS info (device sda4): has skinny extents
>>> [65500.893556] BTRFS error (device sda4): bad tree block start, want 2=
3235280896 have 0
>>> [65500.893593] BTRFS warning (device sda4): failed to read tree root
>>> [65500.893852] BTRFS error (device sda4): bad tree block start, want 2=
3235280896 have 0
>>> [65500.893856] BTRFS warning (device sda4): failed to read tree root
>>> [65500.908097] BTRFS error (device sda4): bad tree block start, want 2=
3234035712 have 0
>>> [65500.908111] BTRFS error (device sda4): failed to read block groups:=
 -5
>>> [65500.963167] BTRFS error (device sda4): open_ctree failed
>>>
>>> P.S. I must say that I get the same results when I try to mount the pa=
rtition from another linux system OpenSuse tumbleweed
>>
>> There are already at least two tree blocks got wiped.
>>
>> I won't be surprised if there are more.
>>
>> For now, only data salvage can be even attempted.
>>
>> Using newer enough kernel (like from openSUSE tumbleweed), then mount
>> with -o rescue=3Dall,ro to see if it can be mounted.
>>
>> That's more or less the same as btrfs-restore, but more convenient to
>> copy things out.
>>
>> Thanks,
>> Qu
>>>
>>> Is there any way I could rebuild the tree?
>>>
>>> Thanks in advance
>>> Joseph
>>>
>>>
