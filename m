Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5679E542DFC
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 12:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiFHKhg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 06:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbiFHKhS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 06:37:18 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6552C1BC7AF
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 03:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654684356;
        bh=px2mPjguQdnyKWjjUHm2xESaYF5MdK3IKx+QHWgL1Sk=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=PuyJMaXzPOLx7iHS0rR6MU7smU0w4veISpSt5ipkEIdpN4Nip21f39WyWp5e+MrXn
         HIzOQDQxh304ugMyI+K84gs2X7LbGDqCp0c19otRjbNiCq17vux1dEvGQiUA5nyhJs
         TfiWUt3GidD4RmnyKC+xvOPZZGXATAdNiSLQxei0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mel3t-1nRCnW1yhp-00aljP; Wed, 08
 Jun 2022 12:32:36 +0200
Message-ID: <a97ff3a3-7b14-e6a4-32e9-b9da8cec422e@gmx.com>
Date:   Wed, 8 Jun 2022 18:32:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: What mechanisms protect against split brain?
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, Qu Wenruo <wqu@suse.com>
Cc:     Forza <forza@tnonline.net>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <c31c664.705b352f.1810f98f3ee@tnonline.net>
 <20220608104421.3759.409509F4@e16-tech.com>
 <20220608181502.4AB1.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220608181502.4AB1.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JV/mdm1M831H1yqJOOOi/1kiY4bR4eDwZiH1C5N5WYpV6WzyiCH
 VzMhaLn7bF7uXAJMHFDzz6IpVHJsE/YiQIbxwnDYtuX/XnsmuRKY6+gSY/qpO8m5lVxvxce
 jToh+ZvcukEp16Hyk4GN8wZEjWDy70YIpr4Q8pb+iWVn0E0nNw+fvvA0AOQ9YT/9LCNMDcp
 /XmfC/iX7/yk/J+mAvvzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fID+DqcS48c=:ks2+Q0LxZ47aQ5xhpwtaeN
 9hoO/PsOfZOc6fQR+KSXJpqGwmod7mkzqt3HtbBufd/PszTSGmkkumQkuG9MELJhyVXc3qnUG
 haaHO9f0FcBKB45nawHqnc3Q+IbeLHIfa8vemguL37KqM9yDNB9gtUOW0Ryc7fMOv1kGpXnH5
 OIPkub9nlUVTrExU8PM1Z70bagM8t9LP9ZgR8Ux9YLdLOkWF7PEpjaHUQ9ce+mSa1NpD2IWuW
 Rt8kvQnbc773WO0YIXZVNn98YhJYYMXrgOcTH9TkPmMIgnNxDscMqae7CRJUHVr3PUjGcrAL9
 YZTigOuedePEEhWkNrXqmCHtZin0cCkJnQqjFPM+pBGfx/mYPjJt7IIoF5JUfRK67EUrkUO18
 wDbriOIz6/kcjqlZC7S/ROcWcd4+Xbtmvdy527352jDMyr9W5zJCWIIgjTpIHPnWIHhbU54my
 RA7kYH5E2qKlHR+memRMoTpOT9mtFgp1ggFnEq38u4/rigy98frSAgiwCeGsiWetgECfl/Rid
 HBCDJyIxN/veEyECj6i4BetSplsy8H09IUntlEJRHL486cHahT7EGiu/RUOt2xZshF8kx/cRO
 ZzwPv8pMgeQSMWv8LTYTt6ld0lWdnKWzEmLvHh3b6uKmY04gco9k99IxjBMpefTgfU/qu+ClY
 m7VxVg7dLNW+XvXhR7Dh86iSbO67Z5mmp4QwPPOP8ZNdyJ3Yrhv0ndvMKS/qrCKaOZ8Ze3HKW
 dvUOGxxg9LsC1eg/YrBfxj8OoPctAV6AXT6o5fvEzHU/lDfXdqx6lEXgel9Yxamj0bDrGOWVS
 hZvGyx2UyrgXnjT8VQksyBdVcfyobTM7k7R7rDR7/fD9YbbOQ8pOjJc/MJqH4vm2HB6eMxjGH
 tr6Tzu8xlXGMv+JDSIMfDCOW475GTs5gsgZNA+uqqCtsekjh8lhrzh2SKz3y75MnyTYmhxgIp
 /UqZN5kHPjDy66TMVbcXy92q3O2ja4esVgwt3NqAPBnSqLQ6MvdcsdfiKZ/eb9TB3Gu/dtk3b
 EL4anmJuuBiXkpG7QFEEc6amgdrpYD9/+IYAMCU9N9osDDhSVy5vP+jE1kKkhd7CicTCFS/Co
 4hWW4wHkvjVjnSojxK6jQM//W2NswvNlwLOmYmU5pVdOJPJqicRPmDDIA==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/8 18:15, Wang Yugui wrote:
> Hi, Forza, Qu Wenruo
>
> I write a script to test RAID1 split brain base on Qu's work of raid5(*1=
)
> *1: https://lore.kernel.org/linux-btrfs/53f7bace2ac75d88ace42dd811d48b79=
12647301.1654672140.git.wqu@suse.com/T/#u

No no no, that is not to address split brain, but mostly to drop cache
for recovery path to maximize the chance of recovery.

It's not designed to solve split brain problem at all, it's just one
case of such problem.

In fact, fully split brain (both have the same generation, but
experienced their own degraded mount) case can not be solved by btrfs
itself at all.

Btrfs can only solve partial split brain case (one device has higher
generation, thus btrfs can still determine which copy is the correct one).

>
> #!/bin/bash
> set -uxe -o pipefail
>
> mnt=3D/mnt/test
> dev1=3D/dev/vdb1
> dev2=3D/dev/vdb2
>
>    dmesg -C
>    mkdir -p $mnt
>
>    mkfs.btrfs -f -m raid1 -d raid1 $dev1 $dev2
>    mount $dev1 $mnt
>    xfs_io -f -c "pwrite -S 0xee 0 1M" $mnt/file1
>    sync
>    umount $mnt
>
>    btrfs dev scan -u $dev2
>    mount -o degraded $dev1 $mnt
>    #xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
>    mkdir -p $mnt/branch1; /bin/cp -R /usr/bin $mnt/branch1 #complex than=
 xfs_io
>    umount $mnt
>
>    btrfs dev scan
>    btrfs dev scan -u $dev1
>    mount -o degraded $dev2 $mnt

Your case is the full split brain case.

Not possible to solve.

In fact, if you don't do the degraded mount on dev2, btrfs is completely
fine to resilve the fs without any problem.

Thanks,
Qu
>    #xfs_io -f -c "pwrite -S 0xff 0 128M" $mnt/file2
>    mkdir -p $mnt/branch2; /bin/cp -R /usr/lib64 $mnt/branch2 #complex th=
an xfs_io
>    umount $mnt
>
>    btrfs dev scan
>    mount $dev1 $mnt # *1
>    ls $mnt
>
>    btrfs balance start --full-balance $mnt # *2
>    #btrfs scrub start -B $mnt  # *3
>    #btrfs scrub start $mnt; sleep 2; btrfs scrub status $mnt; btrfs scru=
b start -B $mnt; # *4
>
>    umount $mnt
>
> test result:
> we may fail in # *1; # *2; # *3; #*4 with different frequency.
>
> dmesg output:
> 1)
> [ 1379.124079] BTRFS error (device vdb1): tree level mismatch detected, =
bytenr=3D31866880 level expected=3D1 has=3D0
> [ 1379.127928] BTRFS error (device vdb1): tree level mismatch detected, =
bytenr=3D31866880 level expected=3D1 has=3D0
> [ 1379.132109] BTRFS error (device vdb1: state C): failed to load root c=
sum
> [ 1379.137281] BTRFS error (device vdb1: state C): open_ctree failed
>
> 2)
> [ 2950.467178] BTRFS error (device vdb1): tree first key mismatch detect=
ed, bytenr=3D32342016 parent_transid=3D9 key expected=3D(301555712,168,106=
496) has=3D(2552,96,5)
> [ 2950.471283] BTRFS error (device vdb1): tree first key mismatch detect=
ed, bytenr=3D32342016 parent_transid=3D9 key expected=3D(301555712,168,106=
496) has=3D(2552,96,5)
> [ 2950.479960] BTRFS info (device vdb1): balance: ended with status: -11=
7
>
> so RAID1 split brain case yet not supported by btrfs now.
>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/08
>
>> Hi,
>>
>> I tried some test about this case.
>>
>> After the missing RAID1 device is re-introduced,
>> 1, mount/read seem to work.
>>     checksum based error detect help.
>>     current pid based i/o patch select policy may help too.
>>         preferred_mirror =3D first + (current->pid % num_stripes);
>>
>> 2, 'btrfs scrub' failed to finish.
>>      Any advice to return to clean state?
>>
>> Best Regards
>> Wang Yugui (wangyugui@e16-tech.com)
>> 2022/06/08
>>
>>> Hi,
>>>
>>> Recently there have been some discussions, both here on the mailing li=
st and on #btrfs IRC, about the consequences of mounting one RAID1 mirror =
as degraded and then later re-introduce the missing device. But also on ha=
ving degraded mount option in fstab and kernel command line.
>>>
>>> So I wonder if Btrfs has some protective mechanisms against data loss/=
corruption if a drive is missing for a bit but later re-introduced. There =
is also the case of split brain where each mirror might be independently u=
pdated and then recombined.
>>>
>>> Is there an official recommendation to have with regards to degraded m=
ounts from kernel command line? I understand the use case as it allows the=
 system to boot even if a device goes missing or dead after a reboot.
>>>
>>> Thanks,
>>> Forza
>>
>
>
