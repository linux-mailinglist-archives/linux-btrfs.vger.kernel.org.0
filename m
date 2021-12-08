Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CB446C87D
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Dec 2021 01:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238439AbhLHAMQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 19:12:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:57981 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233913AbhLHAMQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 19:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638922114;
        bh=UkEyGjs5MzKgDabh1ngS2WX8vEQPWntocWhkEY2pUek=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=QWMb3Tl3v7taEcwKV6nfxgF5gLSlBBAnQ7e7UcKjGWhB6bxusEwXSoy0Xvai44OoY
         29D4Uq37ucnfmGRLgOdH6hLw4BXHvmEsUkifJl8c8elTvQb6ptk/mxgpctfC6eWQzH
         BPZAtMMZ+nFAsh1OpAx/SbgMfWd3xZlKvvA4RvzU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4hvR-1mSB542cYZ-011is4; Wed, 08
 Dec 2021 01:08:34 +0100
Message-ID: <61e80a3c-f3e6-d028-c7d2-e512e6e443d7@gmx.com>
Date:   Wed, 8 Dec 2021 08:08:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>,
        David Sterba <dsterba@suse.cz>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20211207074400.63352-1-wqu@suse.com>
 <Ya8/NpvxmCCouKqg@debian9.Home>
 <e019c8d6-4d59-4559-b56a-73dd2276903c@gmx.com>
 <Ya9L2qSe+XKgtesq@debian9.Home>
 <a91e60a4-7f5a-43eb-3c10-af2416aade9f@suse.com>
 <20211207145329.GW28560@twin.jikos.cz> <20211207154048.GX28560@twin.jikos.cz>
 <CAL3q7H6uUasjNSxpfAN_oNEVQiTtMNGbsEKrvywES4fCbHcByg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC 0/2] btrfs: remove the metadata readahead mechanism
In-Reply-To: <CAL3q7H6uUasjNSxpfAN_oNEVQiTtMNGbsEKrvywES4fCbHcByg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4ymKccIXMsEzzNm9+iHFlE67CaXp3bofr/qV/HrgWd9A1WGWtZV
 mb2EnuIGRh+A0adO1SQeTmoRsVBpiHc+/qjzxUmJmtBURFoE3fGzQBepIAP/zRq3vVoUrQR
 dngOKlZxWgCXLgxTIhfD4MWX+5kM4Ky8ykMmHzmOAfShd5c0PsEiscNuOAZTvu5COiS3HYL
 zzcCh5dm+IdKajAvwT/pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:H/qNa11dH+Y=:AefZsEj3TVm61znXQ3O1+v
 N37SspbP1+YWZ3d4k/2zkRnPLmXVpwmbxlc8+pe+GIBExwiU4s51nouSqOqXNCrDwj4qUVb/Q
 ETOxaPj6717bCTehKLifZQqOCywXKvHOavtAlZskBzxr5y99W+rlVDlliA9TXOD7Dn6RL8qxn
 p9sYSQQa0LCgKnFpjnq3FS5D9Sobcj25U09RjXEwzUtdu0gwccrNrP7t0/8G0NTuWD9j4Nlnz
 5TuEHAf+7N8reBoJ7Te+b6fWFMAR9FmjABhJFlGYUtiPdGg/yTSfizVOUmtD+a04R2QaKhE7v
 aPjqIxqjCKCel6sihzCd05TIDsOF+0Td+fQ8PpD38rPwu690lF+cxAUk8AlfTD4Q1kgubd5nK
 4IePvRcaW1HZh7UH1t/6Qeh2NU/qcQZcunNkVy3Tel7Dzaf7scYgisbrLGOwf818fGVQ//qhB
 IkRl/d6f4x5XxNUQTGsiaTseWhNL7XvroDOqRKMHpDJEa2BG/QSo3NmVal2nRoKrlGezXLRpp
 kfYNo9qP2qf8/VUZd+j64Lm7UGY6IqUkviWPU841e9+T2l8aWc6V9baP881juG4N+USHYfroz
 MBpCKpgf/ZhK2dgRY3dJCsMUG6eNttNjUqOz8vSB8GdtnhDE5tHp5pPN9ufxBzMcg2WzNEbQc
 4J3bcq8CkfNUBfRg1+yvnUlOxBSI42slDbbBwPaNAsdSez0CmiV+Ms9kEdJk1SSIO6JCiDXBm
 keCpGoTnDs4ftQHBRW+DAWdcNa0omSBMdllMGHUATn3/xpaO2DQu7sjL2D8pjmn2S8JoWFuN3
 1khv3yE9zypipFKkGsUDgHMtasOrFoVv7fbGvIyjdkp54sYymD5NS8wgCjZ64fFoeiG2Yl17O
 u9/U7ZBvkZjPo3M06TQXnyQprIZdxvl6eauCnvjIquFQ8Azsg8GhEFDZEk95i14u4pRko7kD6
 HVStdMpNKYxvEUDS+AdaEmDJVduTdaXtr2E3ugUOtoq8seig7LmRuLnhwYP4u0RcvXAhYG77p
 GHt2lnTw94O+3sWfv0+/wwnKlyFYzN9GmvJDs3yteLJaHpi8KHLaGAFfaoM1VWg3S6PcvhMG5
 UHH5zC52DMrdLs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/7 23:53, Filipe Manana wrote:
> On Tue, Dec 7, 2021 at 3:41 PM David Sterba <dsterba@suse.cz> wrote:
>>
>> On Tue, Dec 07, 2021 at 03:53:29PM +0100, David Sterba wrote:
>>> On Tue, Dec 07, 2021 at 08:01:04PM +0800, Qu Wenruo wrote:
>>>> On 2021/12/7 19:56, Filipe Manana wrote:
>>>>> On Tue, Dec 07, 2021 at 07:43:49PM +0800, Qu Wenruo wrote:
>>>>>> On 2021/12/7 19:02, Filipe Manana wrote:
>>>>>>> On Tue, Dec 07, 2021 at 03:43:58PM +0800, Qu Wenruo wrote:
>>>>>>>> This is originally just my preparation for scrub refactors, but w=
hen the
>>>>>>>> readahead is involved, it won't just be a small cleanup.
>>>>>>>>
>>>>>>>> The metadata readahead code is introduced in 2011 (surprisingly, =
the
>>>>>>>> commit message even contains changelog), but now only one user fo=
r it,
>>>>>>>> and even for the only one user, the readahead mechanism can't pro=
vide
>>>>>>>> much help in fact.
>>>>>>>>
>>>>>>>> Scrub needs readahead for commit root, but the existing one can o=
nly do
>>>>>>>> current root readahead.
>>>>>>>
>>>>>>> If support for the commit root is added, is there a noticeable spe=
edup?
>>>>>>> Have you tested that?
>>>>>>
>>>>>> Will craft a benchmark for that.
>>>>>>
>>>>>> Although I don't have any HDD available for benchmark, thus would o=
nly
>>>>>> have result from SATA SSD.
>>>
>>> I'm doing some tests, in a VM on a dedicated HDD.
>>
>> There's some measurable difference:
>>
>> With readahead:
>>
>> Duration:         0:00:20
>> Total to scrub:   7.02GiB
>> Rate:             236.92MiB/s
>>
>> Duration:         0:00:48
>> Total to scrub:   12.02GiB
>> Rate:             198.02MiB/s
>>
>> Without readahead:
>>
>> Duration:         0:00:22
>> Total to scrub:   7.02GiB
>> Rate:             215.10MiB/s
>>
>> Duration:         0:00:50
>> Total to scrub:   12.02GiB
>> Rate:             190.66MiB/s
>>
>> The setup is: data/single, metadata/dup, no-holes, free-space-tree,
>> there are 8 backing devices but all reside on one HDD.
>>
>> Data generated by fio like
>>
>> fio --rw=3Drandrw --randrepeat=3D1 --size=3D3000m \
>>           --bsrange=3D512b-64k --bs_unaligned \
>>           --ioengine=3Dlibaio --fsync=3D1024 \
>>           --name=3Djob0 --name=3Djob1 \
>>
>> and scrub starts right away this. VM has 4G or memory and 4 CPUs.
>
> How about using bare metal? And was it a debug kernel, or a default
> kernel config from a distro?
> Those details often make all the difference (either for the best or
> for the worse).
>
> I'm curious to see as well the results when:
>
> 1) The reada.c code is changed to work with commit roots;

In fact I have a pretty simple patch for that already.

It's pushed to reada_commit_root branch.
(just misc-next with one patch)

>
> 2) The standard btree readahead (struct btrfs_path::reada) is used
> instead of the reada.c code.

It's already used for csum lookup, see btrfs_lookup_csums_range().

The missing extent tree part is pretty easy to do.

This is pushed to remove_reada branch.
(the patchset with one new one-line patch).

Thanks,
Qu
>
>>
>> The difference is 2 seconds, roughly 4% but the sample is not large
>> enough to be conclusive.
>
> A bit too small.
>
> Thanks.
>
