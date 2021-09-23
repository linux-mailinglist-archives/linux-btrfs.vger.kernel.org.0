Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD8415574
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 04:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238906AbhIWCeX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 22:34:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:42465 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238859AbhIWCeW (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 22:34:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
        s=badeba3b8450; t=1632364370;
        bh=0lksDt0WDae2BNenjVWB1ko3ylqNSRkktIr8USv3a+A=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ham9cvfRCMfkfPHMEqlVHIbjU5P/0F9IXBnpp8tAhrduxassIRjVMMDL5cCqkvdUe
         mZ79U1fIlzRbWWC0F0dkLitk+9rn0PhnecjpNfqYQXddf15GeJ/PZKs8/W9posAoQG
         TquPQEkDmYO4nd52dbd87RXKQa9SUJw4NF8o3+dU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzhnH-1mold50R1d-00vgZk; Thu, 23
 Sep 2021 04:32:50 +0200
Message-ID: <72d66f13-6380-7fcd-3475-8152caa965c4@gmx.com>
Date:   Thu, 23 Sep 2021 10:32:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: btrfs receive fails with "failed to clone extents"
Content-Language: en-US
To:     Yuxuan Shui <yshuiv7@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com>
 <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAGqt0zy6a8+awo6ifUn4x+WxN=c6e8PnuMW5kYRodxOQ6vwU-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aD6OkeC8JjYzudTjSWG7XdjmRCR6xYLyW2OB4u7v88v+UuLercn
 n8Q9WXxr6Jtvikfb0kuGxOFy8JnDIiaDHa0qCLkmnvEpC4a7N2Tcf/Z8vgD5fOnrirMFAfG
 nLLwaoWK5ZrvrwUmXxwJbEriZTOso2jm/iVfhhXxVpszIwuxAAvfenwGI1B5bz7971CUtcg
 E4W9rIs5jQxYMZpHTXMxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tgEL0QO6bmw=:jFrkc0sInvROWmvatpX7Pp
 80gRcZpEGq2rfMPxAAMGg7jiPtICB/R0psHCo8UawGkvJ/QSjhMPItzSy4JT4WizHNK8YbFWb
 QZ2KPWnLofX2cNo2Ve2pIXN/368XHvllFXZ517y/wRhJZQ5vGjkMgTcqsXnToXgRNIrB3HUnx
 XhjgUvbMpjQY2ako+vohK8DfwF6imBnmboGrrUi4eLL35TRroW+uJxIz1YIf9CiMCkTvfOfT6
 yVTA6fCqxZ0jKu5OKAlcHe08UvaoOZbwZDDBxDEzyZIVudz1NmcZ3dFfZZWaj6nqW6LcNhJVv
 0DpylGxbeb4lyfZon3ZqGS9OE/pxVddpD85z895zAhazq8xYXo4S9apm9v+H1Grc4BkT6oxMr
 ex6CuDA15FOvoTBsgemLWsqmCbv4djat0MrIidQAVMbMrroyniol3LXKs6YWPZhVWMwZQdTng
 rwKivTb6mRy2nlBxV+TpJjQuBWADDRHvREcgIxjAXtaCmjvLeIh9iBTyFyN3HBw565kzd39Km
 fmfDwNHVyTf3UNTj3XKg8XidEQgaGtWmRgJB0UPQL0B/jCOUlRqhvhy4VI9jgb0jUV2/WVCzo
 L+EOY+LqRAQm51LEOfom0uSQ3g3fvrbO4WzlEkVl8W12z5XNdNSZCYKaBnmaiIydh+tDn6Dyq
 3sEa6gSeKRhF54A0fbDuNRTpEwfTiZri1CjIXoFMMW86wGhycsQAbTxXYZJbd3f4R9mHqq9EN
 w8s6aPeofIwGJ5kZsZSde+rQqfVYoLz0hC6fAWf9oak/AfhVokUMhG6qJR4Rg+aUFx5E11RaR
 NrhLSjGaSn+w2scQkAv7YmJGTo7R/zLwhRJ/VUsEmCx4Gq+GRYsFLrJnFBiDpoRO7+1HYvu6G
 olUM3aT6mMQqR2jMvCOMb7wlPk0JLA7P0NcLHdhLARFFPgXib8FGI1OMBqdpJamDuMJ5RAcWv
 ONLae2mgl11OLr1NaBrGdrkqJk75g8/Zzd5R2ebfHw+SuBcaAKgUndcA68Ot82bf/Kw2q3lJ3
 tkI8muou21GRRMGdrsXpe82fOqAhnMmMwWw3HXZXIHfK5v8nZg4aPCxn1IQhWJTWRQeUsDKWI
 aTSpKNEIo3Dz+w=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/23 09:40, Yuxuan Shui wrote:
> On Thu, Sep 23, 2021 at 2:34 AM Yuxuan Shui <yshuiv7@gmail.com> wrote:
>>
>> Hi,
>>
>> On Thu, Sep 23, 2021 at 12:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>>>
>>>
>>>
>>> On 2021/9/23 03:37, Yuxuan Shui wrote:
>>>> Hi,
>>>>
>>>> The problem is as the title states. Relevant logs from `btrfs receive=
 -vvv`:
>>>>
>>>>     mkfile o119493905-1537066-0
>>>>     rename o119493905-1537066-0 ->
>>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251=
c/out/include/zstd.h
>>>>     utimes shui/programs/treeusage/target/release/build/zstd-sys-506c=
8effd111251c/out/include
>>>>     clone shui/programs/treeusage/target/release/build/zstd-sys-506c8=
effd111251c/out/include/zstd.h
>>>> - source=3Dshui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-=
sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
>>>> source offset=3D0 offset=3D0 length=3D131072
>>>>     ERROR: failed to clone extents to
>>>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251=
c/out/include/zstd.h:
>>>> Invalid argument
>>>>
>>>> stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys=
-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
>>>> on the receiving end:
>>>>
>>>>     File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.=
com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
>>>>     Size: 145904 Blocks: 288 IO Block: 4096 regular file
>>>>
>>>> Looks to me the range of clone is within the boundary of the source
>>>> file. Not sure why this failed?
>>>
>>> The most common reason is, you have changed the parent subvolume from =
RO
>>> to RW, and modified the parent subvolume, then converted it back to RO=
.
>>
>> This is 100% not the case. I created these snapshots as RO right
>> before sending, and definitely haven't
>> changed them to RW ever.
>
> Besides that, I straced the btrfs command and this clone ioctl
> definitely looks valid, irregardless of whether the parent snapshot
> has been changed or not. The length looks to be aligned (128k), and
> the range is within the source file. Why did the clone fail?

The clone source must not have certain bits like NODATACOW.

If non-incremental send stream works, then it's almost certain it's the
received UUID bug we're working on.

Thanks,
Qu

>
>>
>>>
>>> Btrfs should not allow such incremental send at all.
>>>
>>> We're already working on such problem, but next time if you want to
>>> modify a RO subvolume which could be the parent subvolume of increment=
al
>>> send, please either do a snapshot then modify the snapshot, or just
>>> don't do it.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
>>>> and btrfs-progs 5.13.1
>>>>
>>
>>
>>
>> --
>>
>> Regards
>> Yuxuan Shui
>
>
>
