Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2724131E6FA
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 08:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbhBRHbU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 02:31:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:38193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231371AbhBRH0l (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 02:26:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613633057;
        bh=Dfs7595Jbw0U43iVvvYsilJeMdvDI7/DAqbzek5FY2U=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=ObmxvTmwggLn541iwnqMHmwfwlPcwOJCRXAuGA1ifoS6utFTh547q8uDX49Ep5CRU
         lyCQ47hrHWU8UuQJViCvJTPOrqh9bVVNDG7c7hpUyjZJ9kxm1CrXvbY3WoSMRtbhre
         3Em1jSG/64AsIicVmp9pwY12XvBWIJAEaO5xIJ5M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGr8-1lM4oL1NwU-00YfsF; Thu, 18
 Feb 2021 08:24:17 +0100
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
Message-ID: <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com>
Date:   Thu, 18 Feb 2021 15:24:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4cwhT1I3IxuF1Yk0R2zCN6Aftw4CQgZkCXVBRYybYQSEx+bkQdr
 j7aUkvI4SKwVeFf9hrW9CrbQZe3WqE3+1bp5FDvLdSdkg4I2baPxhTrUOkgxUVvfrdVxxLq
 yrzo/DckzuS8AP1YRSUDYmQrBm1x369EOtpVJB+qYm9ofhsDAZ/+NDWhyAnL+rC2DdlrZHZ
 aARbTJBvWBeEOlcrgY56Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YaoVpGMKXUk=:wNkTCA5hlmpJAibNHb99jN
 JYTY64/tFaUZ3rxql1y5wNcmciWB1PMS4plf0SRsSi7juPFSqdB5KRAS+rHyK/bjbGtVUmHG4
 xGyW2aNYcRpW5N3/eA0lL3g7I62bL0eZD/KcCuDoBuYZti5U2av4Qax/j8hBP3g42qQv8HwX0
 ZwITH5Ia4w/2Vz4agXNcbZHR/QsgYmdwFWewcRddPBcygJNKoOIrgyEShGvwwOvsuKH3Ldy18
 19fNvSEgdpmAHJC9KZryT8VxX8xAovhKVpZvcfwDz9P3RhpJNLmVaavNA3MGGaoCx4kv6PYXa
 8C4LBCIx2HdkxCiQrIAKpyvWiITKDiOlQKNwUVBQ7057X4qoOtulpid0g/JWCmsRHraEbaXJ4
 7YcpiYmrKoK1b/pC/3/Snf+O2BoLUb+u8k4p1p4U5O758rXdvb9qdd14uNuDmqrkeKXRY/VGz
 AXVwe5WS5lcLWXNutCaxe7JO46VYG+++G3lESGodTkhcW7hHApp6dKRhSYWWy4pv+LlYKFPGY
 Vubw79OQaloSbVL/PoKmqoFU7VTHLEdAUliin3DVrofj6zvHmTDRaUKSc9231KmMgVpMu4fmj
 7ST7A3RrNYI5lSdKENS6RSmu2ng6rgSo0mi6OnPev+uYv6OH0jc3yfRH+aAeiJP3lRHEFOeyo
 MpCkg0r+RGzsApXF37QejQpU+yeckOR7nGAXF+7UadMJelEPUHBWN62abe1zIQJSrMntmKQZR
 mo98KNmCifGzLi1k/aWGziN2Q5cWhVgCMp4uMa3tjHfP+HUSFwxX6w4olsnTvNiH4eybcyUyH
 HJ7SCXc7SCGRwhQAoKpCYMyTl29E3jkl0SOFHXb4ZZ8Mtd+wibeYMO5P1aqLj4zfyt4vih4Ip
 sazkDCqRcq8vGCprDZvA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/18 =E4=B8=8B=E5=8D=882:59, Erik Jensen wrote:
> On Wed, Feb 17, 2021 at 10:09 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> On 2021/2/18 =E4=B8=8B=E5=8D=881:49, Erik Jensen wrote:
>>> On Wed, Feb 17, 2021 at 9:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>> Got it now.
>>>>
>>>> [  295.249182] read_extent_buffer_pages: eb->start=3D26207780683776 m=
irror=3D0
>>>> [  295.249188] __btrfs_map_block: logical=3D8615594639360 chunk
>>>> start=3D8614760677376 len=3D4294967296 type=3D0x81
>>>> [  295.249189] __btrfs_map_block: stripe[0] devid=3D3 phy=3D211873570=
8160
>>>>
>>>> Note that, the initial request is to read from 26207780683776.
>>>> But inside btrfs_map_block(), we want to read from 8615594639360.
>>>>
>>>> This is totally screwed up in a unexpected way.
>>>>
>>>> 26207780683776 =3D 0x17d5f9754000
>>>> 8615594639360  =3D 0x07d5f9754000
>>>>
>>>> See the missing leading 1, which screws up the result.
>>>>
>>>> The problem should be the logical calculation part, which doesn't do
>>>> proper u64 conversion which could cause the problem.
>>>>
>>>> Would you like to test the single line fix below?
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index b8fab44394f5..69d728f5ff9e 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -6575,7 +6575,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info
>>>> *fs_info, struct bio *bio,
>>>>     {
>>>>            struct btrfs_device *dev;
>>>>            struct bio *first_bio =3D bio;
>>>> -       u64 logical =3D bio->bi_iter.bi_sector << 9;
>>>> +       u64 logical =3D ((u64)bio->bi_iter.bi_sector) << 9;
>>>>            u64 length =3D 0;
>>>>            u64 map_length;
>>>>            int ret;
>>>
>>> So=E2=80=A6 it appears my kernel tree (Arch32's 5.10.14-arch1) already=
 has that:
>>>
>>
>> And I also noticed that since v5.2 kernel, we should already have
>> bi_sector as u64.
>>
>> So why that left shift would get higher bits missing is really strange.
>> Especially the missing part is just at the 45 bit, not 32 bit boundary.
>>
>> Then what about this diff? It goes multiplying other than using
>> dangerous left shift.
>>
>> (Also, it's recommended to still use previous debug diffs, so if it
>> doesn't work we still have a chance to know what's going wrong).
>>
>> Thanks,
>> Qu
>
> No change. I added an extra debug line in btrfs_map_bio, and get the fol=
lowing:
>
> btrfs_map_bio: bio->bi_iter.bi_sector=3D16827333280, logical=3D861559463=
9360
>
> bio->bi_iter.bi_sector is 16827333280, not 51187071648, so it looks
> like the top bit is already missing before the shift / multiplication.
>
Special thanks to Su, he points out that, page->index is still just
unsigned long, which is not ensured to be 64 bits.

Thus page_offset(page) can easily go wrong, which takes page->index and
does left shift.

Mind to test the following debug diff?

Thanks,
Qu

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4dfb3ead1175..794f97d6eda7 100644
=2D-- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -6001,6 +6001,8 @@ int read_extent_buffer_pages(struct extent_buffer
*eb, int wait, int mirror_num)
                         }

                         ClearPageError(page);
+                       pr_info("%s: eb start=3D%llu i=3D%d page_offset=3D=
%llu\n",
+                               __func__, eb->start, i, page_offset(page))=
;
                         err =3D submit_extent_page(REQ_OP_READ |
REQ_META, NULL,
                                          page, page_offset(page),
PAGE_SIZE, 0,
                                          &bio, end_bio_extent_readpage,
