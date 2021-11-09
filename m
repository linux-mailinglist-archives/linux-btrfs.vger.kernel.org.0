Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19EA644B980
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 00:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhKJACU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 9 Nov 2021 19:02:20 -0500
Received: from mout.gmx.net ([212.227.17.22]:34817 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhKJACU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 9 Nov 2021 19:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636502372;
        bh=t2SdFWDcZHYub+DmRNNeIBOBrpjzTwhFThOC5FDlqfA=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=WFPz0RMcRSXaa+hPJ6IsIAYn00h/4cjHMhveEgK+lkvi1QoN2syvqSGpeKFkRloBl
         0Zee4qPtNeaKr8nDwRnfqlMdKt/jWKf3uA4mV2u6GFYs+q1EN7gvctw/GtXO85EM03
         z0Rz7Op+coDuv7Zh/XNoYLqqkTzlSZfftnkyoqfU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M6ll8-1mnMBZ1sLu-008HLh; Wed, 10
 Nov 2021 00:59:32 +0100
Message-ID: <6b48c313-0c86-d96e-a575-5f1d87d38b03@gmx.com>
Date:   Wed, 10 Nov 2021 07:59:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        Thiago Ramon <thiagoramon@gmail.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAO1Y9wqaEkE1XLjtFj0siLD4JMqTmJZfWJFNcQ26DOu7iir3Bg@mail.gmail.com>
 <4f247bfd-95d6-484b-73a6-3829aa4931c0@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Serious issues with scrub and raid56
In-Reply-To: <4f247bfd-95d6-484b-73a6-3829aa4931c0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SBEZVm0I1Y+d0bCOaw6tunSbFcQn9I428K9nyeu2WkVbKEsAZcv
 X7hBbTT6CJxgHvYoGsbtlIgdXjNJp3ZBCzUziyt5uH1Kf3TePICK2uxtubaORV0I45+/U4F
 Ar4/iydyp4aj3X4l83KC/3xeOikAcKcVE6+Nn7jPq63zYYFlsr/cbhDaV4K9UjWp9ObEifw
 8nxbeWaAPdxFSvP6UQHRw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D10bgRBZEdo=:u7O7bli0sDDNJMqkmnuRnb
 AnzuBbfsb9DxRswm208/4bfvFTBemFTF9B5vrrixs4ldPyWmIHLeoXknw6AjdCwlxeD4b9Abr
 sc+n4u9z746Iz+FC/U7NyTERANQpaJ26vG3nMlOGx+rMIN9cVP37UjutvUVviHzj1p4wb9sst
 bjWN9LPIMq2YSeVIrIw/yVjXwa1w+yLx3T5+IjhN0VxbE7BAJdlHy22nTrqABj3aQ8/rKH0CI
 ZsdyMWzNhieSYPpnvY76d+H6Yezez7HoNkO0iSSngxglPWoGn/FAXQVyVVcna70CYfgfZ2qIR
 yhCnTmlH+Ln9ccHFyAqD3UTG2KEftofu0LNbfsAyaAlJWe6/0zUMj2qjtvFSvq317E+qsEgLa
 nXNHal6PnizNQsbBTD3pjbACA6qQzU4TO5U9UgwCt5WHNis3SX/RVqK21qsZehg+hRZhIqjqj
 I91iHT9buQStZSXHFOrSY4MK/1ixWtXnkVx3A3friM+h1NEPKMU8tmKssWrUPTc9w5qqSFCn+
 FsCuA886vB6gNzYxs8DSX+6EtQj5qFqgdCnS9g5aZI36ONsqaNrISkdzhzQ1Suw5tCpn2/P+r
 5NyV9riEQ7u03hx85meBAXA5UUvS12WMT1TEsvbSjTcaOHqTNZc592Gez590FLJRq9mNXvIFc
 rFbUvV0ERhf/gBrKN/xMog/qyggiEKtZ4KFCNeTlmQMnfVlOJVvt12722AAe3YwADaXHhaxLH
 YL4YuaZFg4XjrMn9R62E80x52OhjO9jta9TwrIS1TMd3DBy+FvEuwdEod0lfFOsm7dj4J/wZm
 oXEyevCYlflSBCmNOChhgAEkvSHh2YN7/BQy4l9zM4fqm5sfhzw4BONpnFYCkrtsV0syycE4q
 sn2tqpE/eesoN9OrX5RPjFwIaeHGZFbvd0R1AktpNUzSRFvKidVB5i8J5RYY27ZmHH/pw3HI6
 JxqPerWg2EvN79brTVHW5T9Dxr9X0cRfgxHnjYCtbXReDxsCte9QMCzBza748TxKjBX2eNJFf
 21CI538uAG/zvsTz64QJklFl1OJxxeedxVvXWcY1DvE9z+MsUnlsMv94Szg6zse7H5vTfNDEN
 D7e2LIzMQt5v0s=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/11/9 21:25, DanglingPointer wrote:
> Why has no one offered to help Thiago Ramon with his problem?=C2=A0 Or a=
t the
> very least give some advice.
>
> What's in the road-map for once and for all fixing/sorting out RAID56?
> Surely there is a significant amount of Small-Medium-Businesses and home
> users that are interested in the RAID56 use-case!=C2=A0 Why don't those
> responsible for BTRFS do several sprints to sort it out in a kernel
> release?
>
>
> On 6/8/21 8:40 am, Thiago Ramon wrote:
>> I've been discussing this in IRC at #btrfs for a while now, but I've
>> done enough testing that it's past time I've brought it to the list.
>>
>> First the problems, then I'll give some background on my configuration:
>>
>> 1 - The current scrub procedure completely ignores p/q stripes unless
>> the data csum has problems and it's trying to recover them. This means
>> scrub is completely useless for recovering from bitrot on the p/q
>> stripes, and given enough time/bad luck, even a single device loss can
>> bring down raid5/6. This is not really a bug, more of a design
>> oversight that I'm surprised nobody mentioned/noticed so far.

Nope, just do a very basic tests:

# mkfs.btrfs  -f -d raid5 /dev/test/scratch[12] -R space-cache-tree
# mount /dev/test/scratch1 /mnt/btrfs
# xfs_io -f -c "pwrite 0 64k" /mnt/btrfs/file
# umount /mnt/btrfs/

# btrfs ins dump-tree -t 5 /dev/test/scratch1 | grep EXTENT_DATA -A 3

And grab the bytenr, 298844160 in my case.

# btrfs-map-logical -l 298844160 /dev/test/scratch1
mirror 1 logical 298844160 physical 298844160 device
/dev/mapper/test-scratch1
mirror 2 logical 298844160 physical 277872640 device
/dev/mapper/test-scratch2

The first mirror is the data stripe, while the send stripe is parity.

Verify the content of both mirror:

$ od -x -j 298844160 -N 65536 /dev/mapper/test-scratch1
2164000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
*
2164200000

$ od -x -j 277872640 -N 65536 /dev/mapper/test-scratch2
2044000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
*
2044200000

All correct.

Then corrupted the parity manually:

$ xfs_io -f -c "pwrite -S 0x00 277872640 64K" /dev/test/scratch2

Now mount and scrub:

# mount /dev/test/scratch1 /mnt/btrfs/
# btrfs scrub start -B /mnt/btrfs/

Although it will report no errors found, but that's because all reported
error are for logical bytenr, but parity has no logical bytenr, as it's
hidden to logical address space.

But after scrub, you can re-check the parity manually:

$ od -x -j 277872640 -N 65536 /dev/mapper/test-scratch2
2044000000 cdcd cdcd cdcd cdcd cdcd cdcd cdcd cdcd
*
2044200000

It's back to correct values.

Thanks,
Qu
>>
>> 2 - Some weird condition is causing scrub to miss csum errors. I
>> currently have 156 files (out of about 30M) with unrecoverable csum
>> errors (found by checking every file), after scrubbing every disk in
>> the array twice, the last pass which didn't detect any corruption.
>> Those files were damaged from deleting and overwriting other
>> uncorrectable files that were sharing the stripes with them, and now
>> have the p/q stripes consistent with the csum errors. I've tried
>> replicating this situation on a test fs and scrub worked fine, so it's
>> something else. The scrubs have an unusually high number of
>> no_csum/csum_discards, so I imagine it's something related to that,
>> though I can query the csums of the files without any problems through
>> the python btrfs library. Any ideas on what I could try to diagnose
>> what's going on are welcome.
>>
>> I have a raid1c4 metadata and raid6 data array with 12 8TB disks,
>> currently running kernel 5.12.12, and in the last few months I had 2
>> (not simultaneous) disk hardware failures. First disk died while I was
>> scrubbing it after it started showing errors, the replace had some
>> rebuild failures and afterwards I've had scrub recovering errors all
>> over the disks. I have since replaced memory and a SAS controller on
>> the machine, but I don't know if either had any issues or it was just
>> accumulated errors on the disks (I wasn't scrubbing the disks). I left
>> about 1k uncorrectable files linger for too long, and got hit by
>> another disk failure, which caused another ~1.5k=C2=A0 files to get
>> uncorrectably damaged, mostly files nearby the previous damaged ones
>> (which had been deleted/overwritten by then, and possibly helped
>> corrupt their neighbors).
>> Scrubbing the disks after deleting that last batch of files still
>> uncovered a few more uncorrectable files, but after deleting those
>> (~4) the uncorrectable csum errors stopped showing up. Last round of
>> scrubs repaired a bit over 100 csum errors, but the 156 files
>> mentioned above remain, and undetectable by scrub. I haven't seen any
>> corrected reads in dmesg while scanning the files, so I think I
>> probably won't damage anything else after cleaning up this last batch
>> of files, but I might just fix their csums instead, and do a data
>> rebalance afterwards to rebuild the possibly damaged p/q stripes that
>> scrub isn't checking. But before that I'd like to try to find out why
>> scrub is failing to see those.
>>
>> Thanks,
>> Thiago Ramon
