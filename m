Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B08F71B7
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2019 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfKKKRX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Nov 2019 05:17:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:35679 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbfKKKRX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Nov 2019 05:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573467442;
        bh=lh2CwvtVH1E9Y+EzLaO767lZmI3giNwCJDu2LQfRFvY=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=fmMsWOZaAQlu5fW+cXDfRXq8+QPk2SKzg8g4dO71ywz0sjbQIsAdeFREqEqtr6elA
         3JIuMOxvLAOInzpU9dAkbOdixWtc+Fifi9yfNcGYC8dIfbvII4FHxscDeWghK1l+4J
         dTI0JsFkpPDUIrKD8lqLOpoa0D2Qk1tCOT8POpzY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.167] ([34.92.246.95]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MDhlV-1ieFEM05rz-00Apsr; Mon, 11
 Nov 2019 11:17:21 +0100
Subject: Re: [PATCH 1/2] btrfs-progs: add comments of block group lookup
 functions
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191111084226.475957-1-Damenly_Su@gmx.com>
 <97915605-5df1-ab83-ca98-3133b0648df9@gmx.com>
 <bf2131c4-c780-a66f-8963-452082438375@gmx.com>
 <9840c8eb-9fc9-972c-8b0a-1907228d7a2c@gmx.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <ceecb3e5-09eb-1978-1bc2-2cb636ee7a98@gmx.com>
Date:   Mon, 11 Nov 2019 18:17:17 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <9840c8eb-9fc9-972c-8b0a-1907228d7a2c@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bn/WVYuYrv5k1Il8UmqpVICLCxG6x+kTGWE6X7M3ORPQOD+f3IY
 RudJ0GO/M83IjAXBhdhylQ4+RjZ9rsFuCDtS2slY3RgSAbXi9WCUEr2osH601IoCuAFy4pI
 SkpqbascxD3JXiHLHKsMNc34A9tENtOCeIQ96JyWqbtKL6/mAWu/hwawRsQdqzp6xI/fjDp
 dRZOEChhBMBRRtfwcY7UA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LWn5ZGy2u7g=:PFgty4m71gWRrVemt2GW2m
 HTP8JxURyYMVy0fVMCS2VbwxaCRfR0ryDiXOvitu1LwvrojsVUSceSNJEkqMjIN1d/rJ0JK3H
 MPOYlEpOX41zrror8nNys9uns7fEIqGgKKaDr4JffJkmQksxoftPSMsEhACksohfcd0qTd9ms
 V4cNbTyLGHR0AlNxi1a+OLQCgAuDDeipil9elIhUkCGFMATuVS/HCLx1NVQ5rrG92UJ4WsF4r
 xJWZWsYL3y29CRYnwSdMGgsWAfRzn3Rw7uv+91BMPvx9m+LlC5mqCWfGioLVzPeIYCAnJ/nz3
 Pd+cA4elyULCCPsikvHuA2cZeLELrew6p1XfJkwYHBG0iBPWmPoPslfgdu1ay3ggtrzOd56CM
 UlYKGv0DFlagGDsN/uvUz3VTTlh/jYpGmqcpR9wXRxu06o+Z1XcezUQbngb2P/UPlZ1bHREhw
 zH6vtxs/1ikR54eOzEH7ynZiVWh97akAweI5Kg1q/fqz4vbgrXbb7h/DSPGT1UfJAV5fBoDNE
 QPwDK9AiJQQEy4sp5RK+0nhqP0hpLCYNgVJS+3BR9kfti/bLT1rQ6JSr5OPHACALNwt5hyEOw
 3W5rQ5BuYtJj8GypK1nWAFNIqS4V5AyXaVkphmhVqF6ts+dU0CRWK6L55HSVsxW0lLe0AlRip
 9/yoVTBHfN9QzXJ4bnJyf68ORMLRVVPHfQVehCWUGZZAr/hOR1LcUH6WXz2Zid5H5X+LEAkVh
 F151dTlJPgG9c+I5MADG7GHWnZPhXia15WXur5jYecdUqElD5maDKktucgrntvF6P2Ia1+FBJ
 1fQ9A0juPiJPl0uGr7BbY9h+0yBMfP5akYXWMkmSYTcWkLhMq811LaTVApnE4uYdvNQ4J2Zw6
 R44iB4A+01Ia8zka5F4cjEJtQgbKTJUGldbHZLmgzbVWNv04leZQTUU1EXJY1qafQcOqw66fD
 OK1sfaNa448csQk0xAKG6ZesJVyFFz+4qSDgg/pDl0STgHQuiz9SFVin/R/7H1ZKyH3mQrtfq
 +IE8ndzIjtc94MNkArCt3+dcolWn33xi+ZBJLhLSpSZM3mTa5BhludGwmbe3eEf4hesw/RTiX
 n3rOUOVBCdz5YCvh8Y9i5INpSYVRDIz1ptYFjrW8vSCQJq+oCcuQf8MBxcqRhB9qZX9hntl4R
 xVsL42axIDsbk9ALMyT4JgtBIdt4VhI2XP0yGVR5SSFyaaBIe2I8GgBJItN1F8ASD8uPjThWf
 GBeLR03f8Ve8Xjr9cJt3KraHNURzoneJKVrNzivk+gfp7w/Az83OUbOrWRjY=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/11/11 6:03 PM, Qu Wenruo wrote:
>
>
> On 2019/11/11 =E4=B8=8B=E5=8D=885:49, Su Yue wrote:
>>
>>
>> On 2019/11/11 5:28 PM, Qu Wenruo wrote:
>>>
>>>
>>> On 2019/11/11 =E4=B8=8B=E5=8D=884:42, damenly.su@gmail.com wrote:
>>>> From: Su Yue <Damenly_Su@gmx.com>
>>>>
>>>> The progs side function btrfs_lookup_first_block_group() calls
>>>> find_first_extent_bit() to find block group which contains bytenr
>>>> or after the bytenr. This behavior differs from kernel code, so
>>>> add the comments.
>>>>
>>>> Add the coments of btrfs_lookup_block_group() too, this one works
>>>> like kernel side.
>>>>
>>>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>>>> ---
>>>>  =C2=A0 extent-tree.c | 6 ++++++
>>>>  =C2=A0 1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/extent-tree.c b/extent-tree.c
>>>> index d67e4098351f..f690ae999f37 100644
>>>> --- a/extent-tree.c
>>>> +++ b/extent-tree.c
>>>> @@ -164,6 +164,9 @@ err:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>  =C2=A0 }
>>>>
>>>> +/*
>>>> + * Return the block group that contains or after bytenr
>>>> + */
>>>
>>> What about "Return the block group thart starts at or after @bytenr" ?
>>>
>>
>> That's what documented in kernel already.
>> The thing I try to express is "contains".
>> For such a block group marked as B[n, m).
>> btrfs_lookup_first_block_group(x) (x > n && x < m). Kernel code will
>> return the block group next to B. However, progs side will return the
>> block group B.
>
> "Contains" indeed covers your example.
> But the "after @bytenr" part looks strange to me.
>
> Did you mean if @bytenr is not covered by any block group, then the next
> block group starts after @bytenr is returned?
>
Yes, that's precisely what I mean.

Thanks.
> Then the comment is good.
>
> Thanks,
> Qu
>
>>
>> Thanks.
>>> Thanks,
>>> Qu
>>>
>>>>  =C2=A0 struct btrfs_block_group_cache *btrfs_lookup_first_block_grou=
p(struct
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_fs_info *info=
,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 bytenr)
>>>> @@ -193,6 +196,9 @@ struct btrfs_block_group_cache
>>>> *btrfs_lookup_first_block_group(struct
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return block_group;
>>>>  =C2=A0 }
>>>>
>>>> +/*
>>>> + * Return the block group that contains the given bytenr
>>>> + */
>>>>  =C2=A0 struct btrfs_block_group_cache *btrfs_lookup_block_group(stru=
ct
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_fs_info *info,
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 bytenr)
>>>>
>>>
>
