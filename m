Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662133C7EFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jul 2021 09:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhGNHKC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 14 Jul 2021 03:10:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:58629 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238182AbhGNHKB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 14 Jul 2021 03:10:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626246428;
        bh=lr235IpvZAfV/W9UY+toB7Kh/r0hOAIrBaVyr/e6vtE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OVgeI0RTH1s8qs74QeZJXgxs3oXx6Mh9BQUrvUQRH8UBwsuWW60J9cXAZiukWAmwo
         PnPJIzmVXGQiEmHqa9KyEC6f5DMjDEF6GBFFtENyKxEBhq3Xm4GEB0ZLHUbvHZXXMw
         1Bby+iKAfF+zceIeM3WtSvMWyxiCacmPpIQYiZSI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([45.77.180.217]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2Jt-1lYv3i1z2f-00e1W0; Wed, 14
 Jul 2021 09:07:08 +0200
Subject: Re: migrating to space_cache=2 and btrfs userspace commands
To:     DanglingPointer <danglingpointerexception@gmail.com>,
        Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <63396688-0dc7-17c5-a830-5893b030a30f@gmail.com>
 <86f0624a-cba4-58a3-0a80-460d3f12e8b3@gmx.com>
 <CAJCQCtTFkYHocpdqtS=1y-At11wz5-Kv4Tx5D-QeRg9JpEGdMA@mail.gmail.com>
 <889c88ad-f51a-5b1f-3613-0b78af77477c@gmx.com>
 <1333ad7a-941d-aead-6e5f-06e321c84feb@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <5e621c16-2582-a2e0-01c8-c4cbb82dbefd@gmx.com>
Date:   Wed, 14 Jul 2021 15:07:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1333ad7a-941d-aead-6e5f-06e321c84feb@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nKid0JXu9IhgpPnl1Xh9zYY6M05iJDv4IX1RPnL9MksLoZl/mL/
 MpZ0xWjftBcMma46g1DMnMT+8EYQdtT0uwZ+QN/L8ibQNLwA6JtuPEjyIvEyQ7ZMw81oNx4
 4AmYTAzgs0hpekCHaR4tg51LaFhjpMag4GsqMUuEqSa0SP8niYTT49D9dRRcIBS1701/q2R
 9rGd3wAh2hIDNHuHhDPUQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:NV1N1ys8yXk=:sDAC7PAk9Y67nyM+Y/LXmS
 ZVLQijyx4+Mzbo0eKBjGM5e/fYlFcPU7MVLUc/IuX0X2z2JCAeyJh5VSH0W1G3Twf9WLp0Fmj
 nGKK21TgaVp7HWxjlvzcZeY9YKReTDgw3xE9cdqfbAF46aCLQQEuzZHvvfN6M4+ZKBr5JkMtp
 eJEdw1/XbtlXgYsGP64RvA5CUSTtnrOmnLj8ZWh/aKDZrfySfsD/fABr/c7qGji3xy+caN7Ue
 rJiP18qXZQp5n3ENOVadpG9nkroHojvImUa4Oh56OzRM3wsv81//Irc2NwbGB5DBx08rIxEFp
 lyNzxh3VjAPsITHDQZvZ9JEByACSYeu+GPevf+3akp0Lu5HFYp2Wx7eLaUkdLxLw3bLS97fIR
 oJ/n9Dn/+WG/9p6BxFuR/JfvT+FgzX92FH3+08X1sx9axt74Kb18H/Dap7GDSqaLINQmrE9Nf
 wrSrIYm5xfXVwMUcNSWp+TtGpu4C2KEmBVqOeZMnMtV+bqbL2Z5Wu3cStZcNb9wooBVzkRmvp
 493phFnghbkFOTpWLX5w+Vft5+UHVEI5YZaWfaWVGEAg/s+gI543V3Wi54K7Siz7KEYB1NGXq
 aTwAih1XOCQ2X7KBp6jnJw2yMiyk6HB1fNChaz5LlNsp2oFJgvzjEMythZD+G7R1nj9z2o6h8
 9RuG+ViENlR+8KDRQrNFb6WaJDRWSyMb9Y+LPPHnSj3+Od3Kyl0jrx92cIxKOjfJ3hivMv+Tw
 yv8dVa+nB/+nPBDW169HWqBTB89O4FDqSrNH9eVEJMwDt7Ox/5WsRo+hpMoaG7gMH5N7lZyd1
 ouQIRkGT8y/uZgBnye2tULhgY9TzjtwUESFfG/GdnoPTRrIX0NWqJ/hXDMymYhOa+fmjvhsEQ
 Zx86Yv02Z7Bhz+043JTDQyauWWw3LJsTmeL/dX62KSeRJuDm8q9LDCrWc2SxEcRCLTwgWSzzk
 8f0XrUunJzF1c8/picTqsxiekylBVlzsqO9MWI/u+W3wKn/dr+Y2+LtnvTiX4564yMBxm95vo
 vUBhBffTWKO49Ox89xh6Z3DThHMmLcYJdjZifFELIZien1kgNxuPF/GBxUepkc3saOPBnV8vj
 4TnDPGzJZi93+IaIyK1gLKFhBvJ+LE+JG028JHGmHccNMA6LCijTODmHA==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/7/14 =E4=B8=8B=E5=8D=882:54, DanglingPointer wrote:
> Yep that's what I'm referring to here:
> https://btrfs.wiki.kernel.org/index.php/Manpage/btrfs(5)
>
> Thanks for the prompt respone Qu!
>
> So just to confirm, our scheduled cron jobs to scrub will still work
> with space_cache=3Dv2?

Yep. No worry.

Just to be more accurate, btrfs-progs has two parts:

- Ioctl related part
   Things like "scrub", "subvolume", "filesystem", "device" and etc are
   all ioctl related commands.
   They just call kernel ioctls to do the job.

   For those commands, they are way more independent, and seldomly get
   affected by btrfs-progs version.

- Offline read/write part
   Things like "mkfs.btrfs", "btrfs check", "btrfs-convert" are the main
   commands in this part.
   They relies on the btrfs-progs implementation on how to read/write
   btrfs.
   That's why we always recommend the latest btrfs-progs for "btrfs
   check".

Thanks,
Qu

>
>
>
> On 14/7/21 4:05 pm, Qu Wenruo wrote:
>>
>>
>> On 2021/7/14 =E4=B8=8B=E5=8D=881:44, Chris Murphy wrote:
>>> On Tue, Jul 13, 2021 at 10:59 PM Qu Wenruo <quwenruo.btrfs@gmx.com>
>>> wrote:
>>>>
>>>>
>>>>
>>>> On 2021/7/13 =E4=B8=8B=E5=8D=8811:38, DanglingPointer wrote:
>>>
>>>>> 2. If we use space_cache=3Dv2, is it indeed still the case that the
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 "btrfs" command will NOT work with the file=
system?
>>>>
>>>> Why would you think "btrfs" won't work on a btrfs?
>>>>
>>>
>>> Maybe this?
>>>
>>> man 5 btrfs, space_cache includes:
>>>
>>> =C2=A0 The btrfs(8) command currently only has read-only support for v=
2. A
>>> read-write command may be run on a v2 filesystem by clearing the
>>> cache, running the command, and then remounting with space_cache=3Dv2.
>>>
>>
>> Oh, that's only for offline tools writing into the fs, namingly "btrfs
>> check --repair" and "mkfs.btrfs -R"
>>
>> And I believe that sentence is now out-of-date after btrfs-progs v4.19,
>> which pulls all the support for write time free space tree (v2 space
>> cache).
>>
>> I'll soon send out a patch to fix that.
>>
>> Thanks,
>> Qu
