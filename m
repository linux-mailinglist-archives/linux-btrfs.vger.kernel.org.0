Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A9B30A1B3
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Feb 2021 06:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhBAF4y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Feb 2021 00:56:54 -0500
Received: from eu-shark2.inbox.eu ([195.216.236.82]:36268 "EHLO
        eu-shark2.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhBAFvX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Feb 2021 00:51:23 -0500
Received: from eu-shark2.inbox.eu (localhost [127.0.0.1])
        by eu-shark2-out.inbox.eu (Postfix) with ESMTP id 2BA8F4588F7;
        Mon,  1 Feb 2021 07:50:01 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1612158601; bh=x8yxsOmIht9B/1h64TuNL0VifXN3MJ0u6Jowmdj+dBY=;
        h=References:From:To:Cc:Subject:In-reply-to:Date;
        b=IeQjEzWnuCGlloMzBtIhTyNu8Clwx+ilk8D589Ps/ySSoaUtEEVNIKfot/RXnKKAb
         JqkkVmtQgZakOwUezSkYkCylPB4PfQ3N+TLGKk3yrC+AdatOd+n8T2feWj+LpqR4PW
         lw10bToTbA0tRFfEZPkayL0Wzvbso1PIXgbUVEzc=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 1C2344588F3;
        Mon,  1 Feb 2021 07:50:01 +0200 (EET)
Received: from eu-shark2.inbox.eu ([127.0.0.1])
        by localhost (eu-shark2.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id vkbSg5wE_cHS; Mon,  1 Feb 2021 07:50:00 +0200 (EET)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark2-in.inbox.eu (Postfix) with ESMTP id 927DA4588E3;
        Mon,  1 Feb 2021 07:50:00 +0200 (EET)
Received: from nas (unknown [45.87.95.238])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 919DC1BE0809;
        Mon,  1 Feb 2021 07:49:56 +0200 (EET)
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <8aa09a61-aa1c-5dcd-093f-ec096a38a7b5@gmx.com>
 <CAMj6ewO229vq6=s+T7GhUegwDADv4dzhqPiM0jo10QiKujvytA@mail.gmail.com>
 <684e89f3-666f-6ae6-5aa2-a4db350c1cd4@gmx.com>
 <CAMj6ewMqXLtrBQgTJuz04v3MBZ0W95fU4pT0jP6kFhuP830TuA@mail.gmail.com>
 <218f6448-c558-2551-e058-8a69caadcb23@gmx.com>
 <CAMj6ewPR8hVYmUSoNWVk6gZvy-HyKnmtMXexAr2f4VQU_7bbUw@mail.gmail.com>
 <3b2fe3d7-1919-d236-e6bb-483593287cc5@gmx.com>
 <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com>
 <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Erik Jensen <erikjensen@rkjnsn.net>,
        Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: "bad tree block start" when trying to mount on ARM
In-reply-to: <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com>
Message-ID: <mtwofibp.fsf@damenly.su>
Date:   Mon, 01 Feb 2021 13:49:46 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: OK
X-ESPOL: 885mkI9QEjm6g1u/QXjWGXVJomoWHPGHj+q71h1YnnP5MCqCYip+XRSr7h97Nxyk
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Mon 01 Feb 2021 at 10:35, Qu Wenruo <quwenruo.btrfs@gmx.com>=20
wrote:

> On 2021/1/29 =E4=B8=8B=E5=8D=882:39, Erik Jensen wrote:
>> On Mon, Jan 25, 2021 at 8:54 PM Erik Jensen=20
>> <erikjensen@rkjnsn.net> wrote:
>>> On Wed, Jan 20, 2021 at 1:08 AM Erik Jensen=20
>>> <erikjensen@rkjnsn.net> wrote:
>>>> On Wed, Jan 20, 2021 at 12:31 AM Qu Wenruo=20
>>>> <quwenruo.btrfs@gmx.com> wrote:
>>>>> On 2021/1/20 =E4=B8=8B=E5=8D=884:21, Qu Wenruo wrote:
>>>>>> On 2021/1/19 =E4=B8=8B=E5=8D=885:28, Erik Jensen wrote:
>>>>>>> On Mon, Jan 18, 2021 at 9:22 PM Erik Jensen=20
>>>>>>> <erikjensen@rkjnsn.net>
>>>>>>> wrote:
>>>>>>>>
>>>>>>>> On Mon, Jan 18, 2021 at 4:12 AM Erik Jensen=20
>>>>>>>> <erikjensen@rkjnsn.net>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> The offending system is indeed ARMv7 (specifically a=20
>>>>>>>>> Marvell ARMADA=C2=AE
>>>>>>>>> 388), but I believe the Broadcom BCM2835 in my Raspberry=20
>>>>>>>>> Pi is
>>>>>>>>> actually ARMv6 (with hardware float support).
>>>>>>>>
>>>>>>>> Using NBD, I have verified that I receive the same error=20
>>>>>>>> when
>>>>>>>> attempting to mount the filesystem on my ARMv6 Raspberry=20
>>>>>>>> Pi:
>>>>>>>> [ 3491.339572] BTRFS info (device dm-4): disk space=20
>>>>>>>> caching is enabled
>>>>>>>> [ 3491.394584] BTRFS info (device dm-4): has skinny=20
>>>>>>>> extents
>>>>>>>> [ 3492.385095] BTRFS error (device dm-4): bad tree block=20
>>>>>>>> start, want
>>>>>>>> 26207780683776 have 3395945502747707095
>>>>>>>> [ 3492.514071] BTRFS error (device dm-4): bad tree block=20
>>>>>>>> start, want
>>>>>>>> 26207780683776 have 3395945502747707095
>>>>>>>> [ 3492.553599] BTRFS warning (device dm-4): failed to=20
>>>>>>>> read tree root
>>>>>>>> [ 3492.865368] BTRFS error (device dm-4): open_ctree=20
>>>>>>>> failed
>>>>>>>>
>>>>>>>> The Raspberry Pi is running Linux 5.4.83.
>>>>>>>>
>>>>>>>
>>>>>>> Okay, after some more testing, ARM seems to be irrelevant,=20
>>>>>>> and 32-bit
>>>>>>> is the key factor. On a whim, I booted up an i686, 5.8.14=20
>>>>>>> kernel in a
>>>>>>> VM, attached the drives via NBD, ran cryptsetup, tried to=20
>>>>>>> mount, and=E2=80=A6
>>>>>>> I got the exact same error message.
>>>>>>>
>>>>>> My educated guess is on 32bit platforms, we passed=20
>>>>>> incorrect sector into
>>>>>> bio, thus gave us garbage.
>>>>>
>>>>> To prove that, you can use bcc tool to verify it.
>>>>> biosnoop can do that:
>>>>> https://github.com/iovisor/bcc/blob/master/tools/biosnoop_example.txt
>>>>>
>>>>> Just try mount the fs with biosnoop running.
>>>>> With "btrfs ins dump-tree -t chunk <dev>", we can manually=20
>>>>> calculate the
>>>>> offset of each read to see if they matches.
>>>>> If not match, it would prove my assumption and give us a=20
>>>>> pretty good
>>>>> clue to fix.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Is this bug happening only on the fs, or any other btrfs=20
>>>>>> can also
>>>>>> trigger similar problems on 32bit platforms?
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>
>>>> I have only observed this error on this file system.=20
>>>> Additionally, the
>>>> error mounting with the NAS only started after I did a `btrfs=20
>>>> replace`
>>>> on all five 8TB drives using an x86_64 system. (Ironically, I=20
>>>> did this
>>>> with the goal of making it faster to use the filesystem on=20
>>>> the NAS by
>>>> re-encrypting the drives to use a cipher supported by my=20
>>>> NAS's crypto
>>>> accelerator.)
>>>>
>>>> Maybe this process of shuffling 40TB around caused some value=20
>>>> in the
>>>> filesystem to increment to the point that a calculation using=20
>>>> it
>>>> overflows on 32-bit systems?
>>>>
>>>> I should be able to try biosnoop later this week, and I'll=20
>>>> report back
>>>> with the results.
>>>
>>> Okay, I tried running biosnoop, but I seem to be running into=20
>>> this
>>> bug: https://github.com/iovisor/bcc/issues/3241 (That bug was=20
>>> reported
>>> for cpudist, but I'm seeing the same error when I try to run
>>> biosnoop.)
>>>
>>> Anything else I can try?
>>
>> Is it possible to add printks to retrieve the same data?
>>
> Sorry for the late reply, busying testing subpage patchset. (And
> unfortunately no much process).
>
> If bcc is not possible, you can still use ftrace events, but
> unfortunately I didn't find good enough one. (In fact, the trace=20
> events
> for block layer is pretty limited).
>
> You can try to add printk()s in function blk_account_io_done()=20
> to
> emulate what's done in function trace_req_completion() of=20
> biosnoop.
>
> The time delta is not important, we only need the device name,=20
> sector
> and length.
>

Tips: There are ftrace events called block:block_rq_issue and
block:block_rq_complete to fetch those infomation. No need to
add printk().

>
> Thanks,
> Qu

