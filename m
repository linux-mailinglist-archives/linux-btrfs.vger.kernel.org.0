Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771C853A050
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 11:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350199AbiFAJ1q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 05:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345424AbiFAJ1m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 05:27:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E851165A6
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654075655;
        bh=6w6XbOHJ3mUm1hjovBicYzMW87X9R9hJPtqTB3R1IqI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=H5iRYxvMGYGSPL84wesrIhsGjDPkh04Ij0+UsPgUqjxkSMlarigarv49VhvxdWgYp
         c0x4iDoA1vFYobS7FN2juXMqLClXDzAWnrqGnCfi/sWV0+396Ypg4qrsXysu/f5A2I
         HEuUUi4UOrnpsa5B4CtKVK9lDwWqw8yb5kbayYxQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mn2WF-1nU7Mn0yNb-00k5E5; Wed, 01
 Jun 2022 11:27:34 +0200
Message-ID: <5f49c12e-4655-48dd-0d73-49dc351eae15@gmx.com>
Date:   Wed, 1 Jun 2022 17:27:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH DRAFT] btrfs: RAID56J journal on-disk format draft
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220601102532.D262.409509F4@e16-tech.com>
 <49fb1216-189d-8801-d134-596284f62f1f@gmx.com>
 <20220601170741.4B12.409509F4@e16-tech.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220601170741.4B12.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZwMvJaugB8d85OocJdKjkOgT4FMchGyiClqesKkkm5bMHUIlKqI
 qDa5/e9oi88HDVEr3LYkJyul1SUeGWz/mnl0iYJRANzasSFop38VIqVGCZoBHmuj2j1RxvG
 4iOF2e8BwIx1dD/QUt8YqOSa7hyDb+2OSAHsttjQv5Cqd0svapPyRZU+ctvzBPWwWVrfwYK
 RYxdCzKFa720MhDkDIKQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qCCSKvoLI90=:uh1gXE5v19ATwFqLvwaogK
 WiVftrCzG5UsCV4lJPINJ4OYMAQf3MCRCLsXOu2/X6uaCrZjqQcIbIeswcRGzsi+DhEYbm335
 x0qHz1H6V6kS4KYws4vddjLrEYkEQ87pXESNQ7KxRkpBNNfuDIOCnLauiZqdDjRl7A2ddM7R7
 WMaTgBhqFC38rvBDpO3qq+lGObJLDfnDDh6fCvDyGlMtCu931l/eJGO6ApPjEG1xhQRZ9u+sk
 iQSutd4rc0LgC8GAdChxYiPOp9oAH151xLIKN2UJKOGGFfJfU0zPeXyD5DtvaQcOxV23btYsV
 suvcsfZHaR7B1NldfU2dX20KSg7LX9gX13NY5ZRPOtWubS9VOrPwGu6YTbw3Gs5ptxcoMoiL3
 wZSqih91KETNMsIFfAY7LxLTRXw/Twx3r5E7mPRtyCPssqLYOElBPyHDspgJEOVz474Q9ddsW
 ckqPfyddiSc8RL6zrGHgJfaMPadBDwJcdskatUMk2x70X3xYZ7dYgicYjh46WgX6ZrpMFoVii
 8UjNH4rBIzDzuAwc15Z7VWksA2VJVtthPw6xEfOGxHXBt5+v4o/nyWTLNmOeUT3KulggCpkxW
 pSBj00cZWoHZbuEYVGFO1sHciRftqRBp1awdIEiCGmGwvtOhAOIODb6i/ccugDGnUhMhmLZDX
 J36LiiRNqFNDWMDokRsZpGM0esuPaVD3tfz8komjeJx291k+j5qjRnLR2WgNl/5cSC78UtcD2
 R/srtusz+xryA2l8CdNWeootXGh+KcCIWGbgJTfcRGkmlrn8pfeRBfaCQOnccCfCJlWYM8+4K
 SWRnYi+J121bXPioVwoxGsy6hKroEdl/HzkCmAQHM6rj+SrQqWLKnhFAv1N22UF5soFCgeG2Q
 Hc9CGwfIgxJr2kwF4aHDLy0IJNxbz8KbpOis77e9u3huDVZ+E12R1dVx6rfXIV6D3xrxvxKz2
 bnOzx0eR+x+B4SvW+cZ63wAqIRNBHmMUN0Ttk9HHxY0QIUit0bykcykBIRJyBQEuOXGiIRK2t
 sT33wWbIhGnAceDfdh53tYmbaOlqI8KOHSJq05usppsUSR7RK5Ssy7LUL6WMls7fcL71qfv6f
 S1Y+xT64CgICHc0EC4K85EB36GVDEuwM0AoARIF4dCjkBbm/fLgF9Z/dg==
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/1 17:07, Wang Yugui wrote:
> Hi,
>
>> On 2022/6/1 10:25, Wang Yugui wrote:
>>> Hi,
>>>
>>>> On 2022/6/1 10:06, Wang Yugui wrote:
>>>>> Hi,
>>>>>
>>>>>> This is the draft version of the on-disk format for RAID56J journal=
.
>>>>>>
>>>>>> The overall idea is, we have the following elements:
>>>>>>
>>>>>> 1) A fixed header
>>>>>>       Recording things like if the journal is clean or dirty, and h=
ow many
>>>>>>       entries it has.
>>>>>>
>>>>>> 2) One or at most 127 entries
>>>>>>       Each entry will point to a range of data in the per-device re=
served
>>>>>>       range.
>>>>>
>>>>> Can we put this journal in a device just like 'mke2fs -O journal_dev=
'
>>>>> or 'mkfs.xfs -l logdev'?
>>>>>
>>>>> A fast & small journal device may help the performance.
>>>>
>>>> Then that lacks the ability to lose one device.
>>>>
>>>> The journal device must be there no matter what.
>>>>
>>>> Furthermore, this will still need a on-disk format change for a speci=
al type of device.
>>>
>>> If we save journal on every RAID56 HDD, it will always be very slow,
>>> because journal data is in a different place than normal data, so HDD
>>> seek is always happen?
>>>
>>> If we save journal on a device just like 'mke2fs -O journal_dev' or 'm=
kfs.xfs
>>> -l logdev', then this device just works like NVDIMM?  We may not need
>>> RAID56/RAID1 for journal data.
>>
>> That device is the single point of failure. You lost that device, write
>> hole come again.
>
> The HW RAID card have 'single point of failure'  too, such as the NVDIMM
> inside HW RAID card.
>
> but  power-lost frequency > hdd failure frequency  > NVDIMM/ssd failure
> frequency

It's a completely different level.

For btrfs RAID, we have no special treat for any disk.
And our RAID is focusing on ensuring device tolerance.

In your RAID card case, indeed the failure rate of the card is much lower.
In journal device case, how do you ensure it's still true that the
journal device missing possibility is way lower than all the other devices=
?

So this doesn't make sense, unless you introduce the journal to
something definitely not a regular disk.

I don't believe this benefit most users.
Just consider how many regular people use dedicated journal device for
XFS/EXT4 upon md/dm RAID56.

>
> so It still help a lot.
>
>> RAID56 can tolerant one or two device failures for sure.
>> Thus one point failure is against RAID56.
>>
>>
>> If one is not bothered with writehole, then they doesn't need any
>> journal at all.
>
> I though 'degraded read-only' will help more case than 'degraded
> read-write' with writehole.

I don't get what you're talking about here.

Thanks,
Qu

>
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/06/01
>
>
