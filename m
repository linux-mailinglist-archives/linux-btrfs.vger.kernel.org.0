Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98AF94D3D48
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 23:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238855AbiCIWpu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 17:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbiCIWpt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 17:45:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F77BF9FBC
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646865887;
        bh=AbGaZP+Rh2s4mV0Ihv8u6GXBQK52cq97CnaSPakZmOQ=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=J/j0wbYflkFox+x3k28SCqHI4Sk0M0Fqx0767/Gc7bxjxOTssO4SG7fP5Sy20RYs7
         YnwuELqWLtYmGxHArPQEjYro26PdMFBsjMOfoCid6YT2TF3rwnBHcHNDCMKOalyLTq
         WJkIUAgcQfcBR8eom7LtsTb2TaFmfZUT8+oLMMmg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N95iH-1oG2NF13Sh-0164RG; Wed, 09
 Mar 2022 23:44:46 +0100
Message-ID: <cc8d21c6-6bda-f296-3f3a-09b10582fde3@gmx.com>
Date:   Thu, 10 Mar 2022 06:44:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Content-Language: en-US
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
 <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com>
 <CAODFU0pEd+QTJqio6ff5nsA_c--iCLGm52t0z6YBgzJcWPxy9g@mail.gmail.com>
 <3f286144-d4c4-13f6-67d9-5928a94611af@gmx.com>
 <CAODFU0r8QqbuHdH_vG21bPacuMM+dmzMbdSq23TPHxL=R1DbgQ@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAODFU0r8QqbuHdH_vG21bPacuMM+dmzMbdSq23TPHxL=R1DbgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZOXjCuQ3fX+sm41x3+9bMLQDREhGkOwbDMThbN0R1rfBCVTI7sK
 1JQvekvAH+izSJHzvBGVB2XEum7QYSLDi2Tj17cmhSCyfdmlLsrkv8CO6R4kZSZQyJRo672
 aYhxbKqpaT4Wm2qj6wGUrpJPl7J7rDkDWWlb2QjTuY9yEJ98aqgd/+mtQ9YduTdYuzi6uQK
 KYnt/hZ3UKpLSEFvstFQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J7CR5oPpDVE=:WgRP+4su9NM2kZ5criHTAU
 fmRUIw95uapBERYQLE5dRDrFtVSW0nx0VX2qdDwuDsY31gRbEc92RMRW6dSm9sETW/W6ZzN/c
 X2D2tNVbKAENHt2ve4pJ9oIT+dpD/rN3aW5kEgSxNNEi8rodwVtS2Ro6U9cktOcmM+0pCB3Vh
 t3RRl8Mrmp24sXW5ApMz6wosQm2VlL1kB6lF/uF5o0qk/g8OU3cN+gEmfgMes0k9ldnY9Bkv4
 gkZOTm42pHiphCLTOy3ZcnjpcEfteUPNhZ0iqa7x1mcfAo4at/qLe+0XTLdGRz59hnO1bPwOM
 HBtbHjBwkS4PRfSqDxkmg+nGBci922ngNDGbJ3v/V+eal883auEK4sxiBa+EE5tE7tbxB7neY
 uyvJnOWwAoZonueu9m+94hjygMneoXUB9gqzPOxzIdDrRk6iAIppfAWazPm//MbNJrO5nCFlX
 fpuDy3AzF6Jc8nWqqQSxVvpBHKTqYtqDogEc/FqCiv+pCnJsCb5yuM5iwXWEOqTjez4mtBP5y
 Qqj7uztFcoLM64iIMZlrvsZs98Y5VaeCY+ZDI9zXsenIPmp0x7RyAVmbCFFKd842wamGx2Z31
 0Js+WdHHz/cSJKJcruBvYUSzlJ6PbEiYqdmBK/ib6LIOboGVk1tA/9gaXDORsgWMDfWw7LOKi
 Ls4P7uHi8IcNXXHI4oAv/6zrLUcHC369vx8NngK8JdnGW1RJGfg5RH4C0CcWtYP8hBZRDM/r4
 pdG86Gl42taKA+aJ7vJqslH08Hx6wInBAJBL5zLiMABKFulYbzeOeDvQwUWtd8iZvSvHPRtFz
 +YUhWD9CyRG0gc1YMXtrHkfRvUmUU3m1pGfV5WVqTj5fYYFGU79pJKwm+Plx5EdNN1MB11R7P
 BKvqNtUYVoGW7F9ek6/nyfL8UXslaCfTn4A9bSMC0E5Nh/ytafgnxshTOnWwHkMZRhF2kCaaD
 Rwo7KKukTQq4ZS30NKTNsh9gwBFcECx2odROPjwi/h0N4Mwy714ZNpI3Ekj7/sYN3grSVPYk6
 4F0BmUsHhjHQjrE+SfbyM68k8MJ8erzkpRYPSPrYRN1FEs8Ik0lSXt4cY+lEFAsj1MsOcf9yS
 sD4G/cGz5r1fjk=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/10 06:22, Jan Ziak wrote:
> On Wed, Mar 9, 2022 at 12:40 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>> On 2022/3/9 05:57, Jan Ziak wrote:
>>> On Mon, Mar 7, 2022 at 3:39 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>>>> On 2022/3/7 10:23, Jan Ziak wrote:
>>>>> BTW: "compsize file-with-million-extents" finishes in 0.2 seconds
>>>>> (uses BTRFS_IOC_TREE_SEARCH_V2 ioctl), but "filefrag
>>>>> file-with-million-extents" doesn't finish even after several minutes
>>>>> of time (uses FS_IOC_FIEMAP ioctl - manages to perform only about 5
>>>>> ioctl syscalls per second - and appears to be slowing down as the
>>>>> value of the "fm_start" ioctl argument grows; e2fsprogs version
>>>>> 1.46.5). It would be nice if filefrag was faster than just a few
>>>>> ioctls per second.
>>>>
>>>> This is mostly a race with autodefrag.
>>>>
>>>> Both are using file extent map, thus if autodefrag is still trying to
>>>> redirty the file again and again, it would definitely cause problems =
for
>>>> anything also using file extent map.
>>>
>>> It isn't caused by a race with autodefrag, but by something else.
>>> Autodefrag was turned off when I was running "filefrag
>>> file-with-million-extents".
>>>
>>> $ /usr/bin/time filefrag file-with-million-extents.sqlite
>>> Ctrl+C Command terminated by signal 2
>>> 0.000000 user, 4.327145 system, 0:04.331167 elapsed, 99% CPU
>>
>> Too many file extents will slow down the full fiemap call.
>>
>> If you use ranged fiemap, like:
>>
>>    xfs_io -c "fiemap -v 0 4k" <file>
>>
>> It should finish very quick.
>
> Unfortunately, that doesn't seem to be the case (Linux 5.16.12).
>
> xfs_io -c "fiemap -v 0 4g" completes and prints

Well, I literally mean 4k, which is ensured to be one extent.

Thanks,
Qu

>
>    ....
>    16935: [8387168..8388791]: 22237781600..22237783223  1624   0x0
>
> in 0.6 seconds.
>
> But xfs_io -c "fiemap -v 0 40g" is significantly slower, does not
> complete in a reasonable time, and makes it to 1000
>
>     ....
>    1000: [154576..154903]: 22232564688..22232565015   328   0x0
>     ....
>
> in 6.5 seconds.
>
> The NVMe device was mostly idle when running the above commands (reads
> and writes per second were close to zero).
>
> In summary: xfs_io -c "fiemap -v 0 4g" is approximately 185 times
> faster than xfs_io -c "fiemap -v 0 40g".
>
> -Jan
