Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1A931E79C
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 09:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBRIon (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 03:44:43 -0500
Received: from mout.gmx.net ([212.227.15.18]:39907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhBRIko (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 03:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613637521;
        bh=9DlVHF0PlM1+1sOBKqs0aoSxyHiqEgz7iocw8+KIlfI=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=SWkpm0pqFLFRIQ7sbwIVTtEghRbIkcwvMeS5RzoRRGJ8L4cOCKrX9IyytmD5bhvug
         MwztWJ54twAtG9YLHKkVveqZtzDOhvg/9iwh447PirHIxXXNpjyzqhcET69AQ0r+dC
         QSBSU3f774kS6uWgVO/k3xZUjPgapfuzGN4RrcH4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mlw3N-1lcseB1gnb-00j5LF; Thu, 18
 Feb 2021 09:38:41 +0100
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com> <mtwofibp.fsf@damenly.su>
 <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com>
 <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com>
 <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
 <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com>
 <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
 <c6c8cb80-455a-181b-ada5-83001d387044@gmx.com>
 <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
 <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com>
 <CAMj6ewM2wr2tRrMjRk+sztH0nD7RG1J4tXKfoekg3-rqEL3RWA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
Message-ID: <50599154-2ab4-2184-7562-f0758cf216eb@gmx.com>
Date:   Thu, 18 Feb 2021 16:38:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj6ewM2wr2tRrMjRk+sztH0nD7RG1J4tXKfoekg3-rqEL3RWA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UoR0V3/ZlnaWV3bGzhy355w8D5jR+sXxs7zTLu2p0KbH1dUFm/q
 S6pSAEuYe8agTcQS6oE9tNSpLaBDGTu58ayCUctizFHRjYUDSlpiBlSJL4iEIsj5QmpnmHZ
 b3fdl3bYOMqOe/bHylOAsJgfQ/l5LoW/m3EUUR51BLclKIuj+fKq8DIofY+bIiprUz3BPb4
 tiS1zQrlxpEixTDg4tFGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:FQumw/N/R6U=:o9dadxGoc1PV5eHQ4Nob5q
 DiOQtKl2ITE+K8eEt6sskB9sbvvY3EfaecnUenDl5xPpHjm9pIWOkyHWrO2BKChXaXz4RvjqQ
 N3AT/L5OO+n/7+xdGWp6NSqPb5EBDytBOooVrgeBjJAwZ/3xImQHkXRWzXB93rAmlvdxxwSyl
 1x+mHAWr7tCQAZFBIFVacxlPpfH6cDHplLhpFMR58m0iiY/Vt4twd16IzsRmvVIsVuf12Gklt
 9Eyr/TvCy9bwpanyJGG/CP3H1Nk8YDLlCsw54mqE3J+cIMO4hdiILHboCJimRK8ZZz3CL1zZU
 XKX3gKBmZHUziDOnDrLZ7KRJmvi2HEuNqzNhKLCCNGhpgx/T9km6hDWxc//te8kZc5pz5DjFP
 YIesK8HCxxGJwH2duRQD3OvfmfrJChfKS1RIaIavjelVH7vhbqbAZ1wZZjPpScNbqq3yq9sX1
 LDbnLZlklKy+QP9GnMS5m3wbmuwtFaHsKREIUaRReyMHOXCryZhPBHI5rnf1181MmBvUqPNMH
 UR+K9YQUWMKSaS9Lq6TEGYg4Em0w1YHTqSPWIuIYVYlsiJ/YS9/qmcXZA5D/ylTjl8Tu7OKea
 6uaOSqvSqYeqNQWgo3LuclzU69Ykt7ZYsDwcXN5AnExVyeaPkZZ/IV7i6J9/FuqcKunQxEMhN
 /Et1LjMap+U4WS94Y66lQmx6DIYfgXE1gffBopAPPl+jTv1YEGrynMGzumKVgUIUjx+sTm4Ss
 eFMWcDNr8k4yMEcwimOCMmAGnnx0UebkZ3l29fsgLr3e2blesXMWtoqw4qTBwXBNYfmMCjeOF
 rUzUWuhm1UQ5JTck8sYcgivQzrlUoiq1WI0fmjfKNm+u6vJzvrGxvH/SbpH6PTiP4YJSoLRCL
 QMlFP5BXayOAXKqZyPdA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/18 =E4=B8=8B=E5=8D=883:59, Erik Jensen wrote:
> On Wed, Feb 17, 2021 at 11:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> On 2021/2/18 =E4=B8=8B=E5=8D=882:59, Erik Jensen wrote:
>>> On Wed, Feb 17, 2021 at 10:09 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
>>>> On 2021/2/18 =E4=B8=8B=E5=8D=881:49, Erik Jensen wrote:
>>>>> On Wed, Feb 17, 2021 at 9:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> w=
rote:
>>>>>> Got it now.
>>>>>>
>>>>>> [  295.249182] read_extent_buffer_pages: eb->start=3D26207780683776=
 mirror=3D0
>>>>>> [  295.249188] __btrfs_map_block: logical=3D8615594639360 chunk
>>>>>> start=3D8614760677376 len=3D4294967296 type=3D0x81
>>>>>> [  295.249189] __btrfs_map_block: stripe[0] devid=3D3 phy=3D2118735=
708160
>>>>>>
>>>>>> Note that, the initial request is to read from 26207780683776.
>>>>>> But inside btrfs_map_block(), we want to read from 8615594639360.
>>>>>>
>>>>>> This is totally screwed up in a unexpected way.
>>>>>>
>>>>>> 26207780683776 =3D 0x17d5f9754000
>>>>>> 8615594639360  =3D 0x07d5f9754000
>>>>>>
>>>>>> See the missing leading 1, which screws up the result.
>>>>>>
>>>>>> The problem should be the logical calculation part, which doesn't d=
o
>>>>>> proper u64 conversion which could cause the problem.
>>>>>>
>>>>>> Would you like to test the single line fix below?
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>>> index b8fab44394f5..69d728f5ff9e 100644
>>>>>> --- a/fs/btrfs/volumes.c
>>>>>> +++ b/fs/btrfs/volumes.c
>>>>>> @@ -6575,7 +6575,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_in=
fo
>>>>>> *fs_info, struct bio *bio,
>>>>>>      {
>>>>>>             struct btrfs_device *dev;
>>>>>>             struct bio *first_bio =3D bio;
>>>>>> -       u64 logical =3D bio->bi_iter.bi_sector << 9;
>>>>>> +       u64 logical =3D ((u64)bio->bi_iter.bi_sector) << 9;
>>>>>>             u64 length =3D 0;
>>>>>>             u64 map_length;
>>>>>>             int ret;
>>>>>
>>>>> So=E2=80=A6 it appears my kernel tree (Arch32's 5.10.14-arch1) alrea=
dy has that:
>>>>>
>>>>
>>>> And I also noticed that since v5.2 kernel, we should already have
>>>> bi_sector as u64.
>>>>
>>>> So why that left shift would get higher bits missing is really strang=
e.
>>>> Especially the missing part is just at the 45 bit, not 32 bit boundar=
y.
>>>>
>>>> Then what about this diff? It goes multiplying other than using
>>>> dangerous left shift.
>>>>
>>>> (Also, it's recommended to still use previous debug diffs, so if it
>>>> doesn't work we still have a chance to know what's going wrong).
>>>>
>>>> Thanks,
>>>> Qu
>>>
>>> No change. I added an extra debug line in btrfs_map_bio, and get the f=
ollowing:
>>>
>>> btrfs_map_bio: bio->bi_iter.bi_sector=3D16827333280, logical=3D8615594=
639360
>>>
>>> bio->bi_iter.bi_sector is 16827333280, not 51187071648, so it looks
>>> like the top bit is already missing before the shift / multiplication.
>>>
>> Special thanks to Su, he points out that, page->index is still just
>> unsigned long, which is not ensured to be 64 bits.
>>
>> Thus page_offset(page) can easily go wrong, which takes page->index and
>> does left shift.
>>
>> Mind to test the following debug diff?
>>
>> Thanks,
>> Qu
>>
>> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
>> index 4dfb3ead1175..794f97d6eda7 100644
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -6001,6 +6001,8 @@ int read_extent_buffer_pages(struct extent_buffer
>> *eb, int wait, int mirror_num)
>>                           }
>>
>>                           ClearPageError(page);
>> +                       pr_info("%s: eb start=3D%llu i=3D%d page_offset=
=3D%llu\n",
>> +                               __func__, eb->start, i, page_offset(pag=
e));
>>                           err =3D submit_extent_page(REQ_OP_READ |
>> REQ_META, NULL,
>>                                            page, page_offset(page),
>> PAGE_SIZE, 0,
>>                                            &bio, end_bio_extent_readpag=
e,
>
> Here's the new dmesg log:
> https://gist.github.com/rkjnsn/5153682d5be865c13966d342ea7cbe9e
>
> Relevant looking new lines:
>
> [   52.903379] read_extent_buffer_pages: eb->start=3D26207780683776 mirr=
or=3D0
> [   52.903380] read_extent_buffer_pages: eb start=3D26207780683776 i=3D0
> page_offset=3D8615594639360
> [   52.903400] read_extent_buffer_pages: eb start=3D26207780683776 i=3D1
> page_offset=3D8615594643456
> [   52.903403] read_extent_buffer_pages: eb start=3D26207780683776 i=3D2
> page_offset=3D8615594647552
> [   52.903403] read_extent_buffer_pages: eb start=3D26207780683776 i=3D3
> page_offset=3D8615594651648
>
We got it!

The eb->start mismatch with page_offset(), this means something is wrong
with page->index.

Considering page->index is just unsigned long thus when we initialize
page->index using a real u64, we truncated some high bits.

And when we get it back to u64, the truncated bits leads to above result.

The fix would be pretty tricky and with MM guys involved, and may need a
much longer time.

I guess this is a known bug, as page->index limit means we can't handle
files over 4T on 32bit systems, even if the underlying fs can handle it
(just like what you hit).

Thanks,
Qu
