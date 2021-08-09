Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D01463E4746
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Aug 2021 16:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbhHIONu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Aug 2021 10:13:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:60001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233274AbhHIONt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Aug 2021 10:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628518407;
        bh=2Idxd9LIt9Mgg3CcyCXpZz0N5T4+mn6qAtzT1El28l8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=iHpwVV+3I98jrdyG/E2AiwUdNodgWNzI8iFJpTLWJipWDrMLnH6irYnoGapUOoHS/
         SCJGbOMY67vRukVDfmNp5IMNZ0EhoSy/ulXUJ1qjpWdi5h9FhtO4YrgU0IQez4VMr5
         KqBSbctCa+lu2YI1qHQLhvwDj/TK/vpIT3RdLl9M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1n5kwr0GMo-00sflz; Mon, 09
 Aug 2021 16:13:27 +0200
Subject: Re: max_inline: alternative values?
To:     Serhat Sevki Dincer <jfcgauss@gmail.com>,
        linux-btrfs@vger.kernel.org
References: <CAPqC6xQcJa7y2mPWxRM7_kNtdawFgEtFtGLP0K2A_UXU0X6u8g@mail.gmail.com>
 <9073e835-41c2-bdab-8e05-dfc759c0e22f@gmx.com>
 <CAPqC6xQZvcg1XNeRGYW+1UAXrVXbWhxp4Hqq2nMMJXTvKYnT+g@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <899eb2e6-0b0c-c239-000b-94007b566477@gmx.com>
Date:   Mon, 9 Aug 2021 22:13:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPqC6xQZvcg1XNeRGYW+1UAXrVXbWhxp4Hqq2nMMJXTvKYnT+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v/GP1WGLfXpQTJZ8xib/RXTyGkXVVm1kNHGdt6v0E2iCNzRCKOC
 cjZBLnUtINBWafrUFt/+ceJq7BOEhHChvM1CTJlOxa5oEPqDfRiWCr4Aw6W9RWr7mAeoFz2
 Uv4ItadmQF95SCb0AaWAa67mWdhpV0irPAaG9udF7gIW8ebPi3QSi40egBcuA8duKlck+CA
 1MpKOvG5HXVEDQIolQ2rw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TAnt2KyClqs=:QiKIYL0S+05GTxUXdnQk89
 n01jjo9l3FEh+zyaWiCC8kF/DuTIvjFeEVmWJJg/tCoN3cBKjBRVeKhgnDILReMOUxnVXx/C4
 JMpAiKHZR42eghXCPwX1TjOQNnerXTPBsDyCn+2nTlgAALa6oA2/pVEFeCPiWg1YYf1LVIukP
 rNcnRDU5ApIIV3TCGJQLVzGmFNEspXzL8kp3erwevrEvMZuXAayFFeA8tSWB+jlquNU0e3ymH
 y5s/VWCyZXsMYE+QlfW5bcDBrpKZcTmqo8INwmaBw1E9g5mjqXBPLQUjn+GbkPmMjutMTK6VV
 jVFLTmNm+D515kjQ7sAPUIYoz1K2Br/onVwlj8GFU4OdbxwJXdEhLyv/DNNfytkroQTw5iGrj
 Q5iEIVpZd+dDFTV7B8lDl8FRyWWB//RnMzsxZy/vxviYXERz0FxfKE5N7U/jpeipmAdaVFY8p
 RmwcgSBd1/8iJV/cO9KwhmhCXjMPOMw9wndDlqesNk7AJY9QhoIMsuAcQ7Am3eGqotWFxWXPV
 h34HWwnk83maeJPPGwDxczZNKhrSDuPgkM//LzwQArG0xiqOUUX3uKouhVez6ew0DhpnJ/e7A
 Arprtj0Vtjc/YbpHIqQjpL4z7pN1s2JgWYR5oYoYfSyxZF39LZx1mKeA1yV5ma+HgMaanjAM1
 OkjsSWiYF7tu+OkCS5dF9Iaer5tY+7DjaYm7Kbu3/FUhK3tgixINbqZ7lo4YlbqUf9Ltey5uK
 wMwcaA4Gua4FoRsknDHYXwkqdVGjBFDJYPPXzOxN+S0aAmaJh6nKT2woIO+rrTo4umWUuRGJh
 yCoFTLbPl2y7sWBAJkGpWniQ4+A/O15FGWPQzoCPohhTxUg/YF/BzY5AX2/jPCQ9NywqkJzZC
 de++dbGrEmZHZRj07lB1DatykMTCW/CD0TUMWHSdbE2tfCdPG1F+QAYfOnnMIFWDdM2AVlBD9
 m3nr96T9gnabGG9+46yMdhjzckNJ8xBS89r458Fjnx3nbwpT5ou5apS6J40pM/ynAeNR5bmuu
 cWqPot+/I9PLmiMHpcfL6PxOon8GccqWBlZcv7hgPocwp3t37bwzMriyTSon4IO9Gy4M85NRO
 CvWxsSATqTrW/g6QGhUlp/dUBffsGcd5xLdQpqjizbgkjoXnKzXghMAog==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/9 =E4=B8=8B=E5=8D=888:36, Serhat Sevki Dincer wrote:
> Also, in the case of DUP metadata profile, how about duplicating
> "only" the metadata in the two blocks? The total inline data space of
> 2 * 2048/3072 =3D 4096/6144 bytes

That's not that simple.

For DUP, all metadata are doubled. This includes the metadata
header/padding.

Thus although the space usage is simply 2x, but the real space usage is
a little more complex.

> can carry unduplicated data.
> That requires I think metadata and inline data have separate crc32c sums=
.
> Is that feasible?

Inline data is considered as part of the metadata, thus it's protected
by metadata csum already.

Thanks,
Qu

>
> On Mon, Aug 9, 2021 at 3:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>
>>
>> On 2021/8/9 =E4=B8=8B=E5=8D=887:15, Serhat Sevki Dincer wrote:
>>> Hi,
>>>
>>> I was reading btrfs mount options and max_inline=3D2048 (by default)
>>> caught my attention.
>>> I could not find any benchmarks on the internet comparing different
>>> values for this parameter.
>>> The most detailed info I could find is below from May 2016, when 2048
>>> was set as default.
>>>
>>> So on a new-ish 64-bit system (amd64 or arm64) with "SSD" (memory/file
>>> blocks are 4K,
>>
>> For 64-bit arm64, there are 3 different default page size (4K, 16K and =
64K).
>> Thus it's a completely different beast, as currently btrfs don't suppor=
t
>> sectorsize other than page size.
>>
>> But we're already working on support 4K sectorsize for 64K page size,
>> the initial support will arrive at v5.15 upstream.
>>
>> Anyway, for now we will only discuss 4K sectorsize for supported system=
s
>> (amd64 or 4K page sized aarch64), with default 16K nodesize.
>>
>>
>>> metadata profile "single" by default), how would max_inline=3D2048
>>> compare to say 3072 ?
>>> Do you know/have any benchmarks comparing different values on a
>>> typical linux installation in terms of:
>>> - performance
>>> - total disk usage
>>
>> Personally speaking, I'm also very interested in such benchmark, as the
>> subpage support is coming soon, except RAID56, only inline extent
>> creation is disabled for subpage.
>>
>> Thus knowing the performance impact is really important.
>>
>> But there are more variables involved in such "benchmark".
>> Not only the inline file limit, but also things like the average file
>> size involved in the "typical" setup.
>>
>> If we can define the "typical" setup, I guess it would much easier to d=
o
>> benchmark.
>> Depends on the "typical" average file size and how concurrency the
>> operations are, the result can change.
>>
>>
>>   From what I know, inline extent size affects the following things:
>>
>> - Metadata size
>>     Obviously, but since you're mentioning SSD default, it's less a
>>     concern, as metadata is also SINGLE in that case.
>>
>>     Much larger metadata will make the already slow btrfs metadata
>>     operations even slower.
>>
>>     On the other hand it will make such inlined data more compact,
>>     as we no longer needs to pad the data to sectorsize.
>>
>>     So I'm not sure about the final result.
>>
>> - Data writeback
>>     With inline extent, we don't need to submit data writes, but inline
>>     them directly into metadata.
>>
>>     This means we don't need to things like data csum calculation, but
>>     we also need to do more metadata csum calculation.
>>
>>     Again, no obvious result again.
>>
>>
>>> What would be the "optimal" value for SSD on a typical desktop? server=
?
>>
>> I bet it's not a big deal, but would be very happy to be proven run.
>>
>> BTW, I just did a super stupid test:
>> ------
>> fill_dir()
>> {
>>           local dir=3D$1
>>           for (( i =3D 0; i < 5120 ; i++)); do
>>                   xfs_io -f -c "pwrite 0 3K" $dir/file_$i > /dev/null
>>           done
>>           sync
>> }
>>
>> dev=3D"/dev/test/test"
>> mnt=3D"/mnt/btrfs"
>>
>> umount $dev &> /dev/null
>> umount $mnt &> /dev/null
>>
>> mkfs.btrfs -f -s 4k -m single $dev
>> mount $dev $mnt -o ssd,max_inline=3D2048
>> echo "ssd,max_inline=3D2048"
>> time fill_dir $mnt
>> umount $mnt
>>
>> mkfs.btrfs -f -s 4k -m single $dev
>> mount $dev $mnt -o ssd,max_inline=3D3072
>> echo "ssd,max_inline=3D3072"
>> time fill_dir $mnt
>> umount $mnt
>> ------
>>
>> The results are:
>>
>> ssd,max_inline=3D2048
>> real    0m20.403s
>> user    0m4.076s
>> sys     0m16.607s
>>
>> ssd,max_inline=3D3072
>> real    0m20.096s
>> user    0m4.195s
>> sys     0m16.213s
>>
>>
>> Except the slow nature of btrfs metadata operations, it doesn't show
>> much difference at least for their writeback performance.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks a lot..
>>>
>>> Note:
>>> From: David Sterba <dsterba@suse.com>
>>>
>>> commit f7e98a7fff8634ae655c666dc2c9fc55a48d0a73 upstream.
>>>
>>> The current practical default is ~4k on x86_64 (the logic is more comp=
lex,
>>> simplified for brevity), the inlined files land in the metadata group =
and
>>> thus consume space that could be needed for the real metadata.
>>>
>>> The inlining brings some usability surprises:
>>>
>>> 1) total space consumption measured on various filesystems and btrfs
>>>      with DUP metadata was quite visible because of the duplicated dat=
a
>>>      within metadata
>>>
>>> 2) inlined data may exhaust the metadata, which are more precious in c=
ase
>>>      the entire device space is allocated to chunks (ie. balance canno=
t
>>>      make the space more compact)
>>>
>>> 3) performance suffers a bit as the inlined blocks are duplicate and
>>>      stored far away on the device.
>>>
>>> Proposed fix: set the default to 2048
>>>
>>> This fixes namely 1), the total filesysystem space consumption will be=
 on
>>> par with other filesystems.
>>>
>>> Partially fixes 2), more data are pushed to the data block groups.
>>>
>>> The characteristics of 3) are based on actual small file size
>>> distribution.
>>>
>>> The change is independent of the metadata blockgroup type (though it's
>>> most visible with DUP) or system page size as these parameters are not
>>> trival to find out, compared to file size.
>>>
