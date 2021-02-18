Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB6B31E643
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 07:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhBRGUq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 01:20:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:39301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230423AbhBRGLI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 01:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613628556;
        bh=Nl7FcU7vik+sDWsgf2IfzDEAXuEl/yMuqA+rjUS7iTE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=elPv8coGFTB9xei8Px6ZXVS6+SaD7y7f2mwTfDzhu6ktY4QZ4bOSdnjFBow4YjJqZ
         SGn8U3SWkfCqnMzQIytMtAvkkd05og6W/3gwxAR/fbcTmvxjd8lavztjTZ2YAFVAcK
         e9ScmkWDB8ty30MQVKlHt+BfsMRPQkHI+5GMhAKk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1OXZ-1lsOWW3XUx-012pDG; Thu, 18
 Feb 2021 07:09:16 +0100
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com>
 <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <c6c8cb80-455a-181b-ada5-83001d387044@gmx.com>
Date:   Thu, 18 Feb 2021 14:09:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZU4UqRiOwcWWwD2dmfE2CO97XhB3JUTPBVB65bPNy3pumcqWqcm
 6tz4t413ZNa1Jd3uS4PLobv66uhMUxHNOkkcgfxf8S3+RcsCQ7wayjGPJmAnq55KAJk+ZlX
 LIaTzYrHuyB82OXEITbERx8QO+SAIDCvuvh1mAwtXdJlKMAfMA8RWXhlaL8ISgsNyFZ+iok
 yyZGsZvR+WfcRyo/imP4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:bHPRzsBW/gM=:fTFWZ2gkF5nWFnk9wspkQB
 ZKD05qo4769VngBhsjr7Frx/U02qoauZhrmaRxjbsUNcsuBIqMttd7Km166vnGTbVVMPnM0Lp
 YFB5Fm81wRRnIc7JLs9AodwvjGpSsbyB4StTfBnY0PTV1o5s3gmjryh/pts+h16eV8g/SUitg
 wYLwjIvv+rY3eHIpe7MFnQlIlyet6BsaVKaRJD31Y8EiyE1NTZtmCH34ZqCC0cP1qcHn0n7qG
 XaiwgcYr99ve50ftwVr8ZQDvb+HFbbM3c3cBW96opmtO1iZ3LOMZ5tFkDAr3XwRlFt9aKn75B
 ixxaT1CWntRVKgcKDfupvXZe4I4Ff8aBMcwT7UsXMKFjpHMcZUvz/NbqDH+PCk5th+OMEaddk
 dGUSVWjAqvghvyhYj9yZKOh2D7A5r6ihuiDBMZiTz2uUDM0DB8hoTUT5DaTktkwIwJchTnae6
 iDGs1b3Rvc1cDU5VTvELLrt7dkDGTRW/qzH74Lz65x5em5crVvGKFHQL2QUWA2zgY0acgQhjU
 WxkPRGoBgDXc1VLT6fWoOO6wYAZVHN1CjbS/Iv1lS3XlCncHCqBB7jU1obtJT99VtAHxecZCU
 HAczU59uc+onxOJv5St9bx1PgVyg4gwg0Y59ERftANlmk7lnCihxo6uE6Bs4UOQ+o5Wh5yzJ1
 iRBfTGNWCvsKzPqUmMcOXsW0TgkR9DmH4EnjEn++JzrJ5nbMNn76pj5iAIQZCXuWdy+pxOkLE
 pEIZOrKsavLK+Q9UnJT5ZI1FaSRYGEt9/ONbJh99OxAIuo3id8FhvcdBheCBMCmIeZIGr9vhp
 QqmPfQFapV+yBaA4EAU8wPUQAChfQ2rYXoCvFe0vn2v/ld39u2wFwNpGbRIYlumxmSJX/KFg6
 j5SAgjW4FvEGXy1hJfKA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/18 =E4=B8=8B=E5=8D=881:49, Erik Jensen wrote:
> On Wed, Feb 17, 2021 at 9:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>> Got it now.
>>
>> [  295.249182] read_extent_buffer_pages: eb->start=3D26207780683776 mir=
ror=3D0
>> [  295.249188] __btrfs_map_block: logical=3D8615594639360 chunk
>> start=3D8614760677376 len=3D4294967296 type=3D0x81
>> [  295.249189] __btrfs_map_block: stripe[0] devid=3D3 phy=3D21187357081=
60
>>
>> Note that, the initial request is to read from 26207780683776.
>> But inside btrfs_map_block(), we want to read from 8615594639360.
>>
>> This is totally screwed up in a unexpected way.
>>
>> 26207780683776 =3D 0x17d5f9754000
>> 8615594639360  =3D 0x07d5f9754000
>>
>> See the missing leading 1, which screws up the result.
>>
>> The problem should be the logical calculation part, which doesn't do
>> proper u64 conversion which could cause the problem.
>>
>> Would you like to test the single line fix below?
>>
>> Thanks,
>> Qu
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index b8fab44394f5..69d728f5ff9e 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -6575,7 +6575,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info
>> *fs_info, struct bio *bio,
>>    {
>>           struct btrfs_device *dev;
>>           struct bio *first_bio =3D bio;
>> -       u64 logical =3D bio->bi_iter.bi_sector << 9;
>> +       u64 logical =3D ((u64)bio->bi_iter.bi_sector) << 9;
>>           u64 length =3D 0;
>>           u64 map_length;
>>           int ret;
>
> So=E2=80=A6 it appears my kernel tree (Arch32's 5.10.14-arch1) already h=
as that:
>

And I also noticed that since v5.2 kernel, we should already have
bi_sector as u64.

So why that left shift would get higher bits missing is really strange.
Especially the missing part is just at the 45 bit, not 32 bit boundary.

Then what about this diff? It goes multiplying other than using
dangerous left shift.

(Also, it's recommended to still use previous debug diffs, so if it
doesn't work we still have a chance to know what's going wrong).

Thanks,
Qu

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index b8fab44394f5..15cea408a51f 100644
=2D-- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6575,7 +6575,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info
*fs_info, struct bio *bio,
  {
         struct btrfs_device *dev;
         struct bio *first_bio =3D bio;
-       u64 logical =3D bio->bi_iter.bi_sector << 9;
+       u64 logical =3D bio->bi_iter.bi_sector * 512ULL;
         u64 length =3D 0;
         u64 map_length;
         int ret;



> blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bi=
o,
>                             int mirror_num)
> {
>          struct btrfs_device *dev;
>          struct bio *first_bio =3D bio;
>          u64 logical =3D (u64)bio->bi_iter.bi_sector << 9;
>          u64 length =3D 0;
>          u64 map_length;
>          int ret;
>          int dev_nr;
>          int total_devs;
>          struct btrfs_bio *bbio =3D NULL;
>
