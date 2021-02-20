Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73832320417
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 07:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhBTGDf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 01:03:35 -0500
Received: from mout.gmx.net ([212.227.17.21]:43159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhBTGDe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 01:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613800916;
        bh=v0GwFrVLqudHhxCXkyXAP6AhPujtAxJCrPCntkMD8Ec=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=A9Q8Yho1cFJmDZrqzc/QqWsUMHYukZQFHM5YVWYfCm8L/+e0MurokVroiYEB7ycXz
         IVfBsQiCMsr18PcSWyoxXRA4NHgTLhZPkGyU3fgV55zAHmY3cTvE8KlwlwUAhO5atv
         cXJedy3lxE/Ae/YS86GbW5TQgjF6w5vz03bGBDmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGhyc-1l0g9x4APS-00DkTc; Sat, 20
 Feb 2021 07:01:56 +0100
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com>
 <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
 <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com>
 <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
 <c6c8cb80-455a-181b-ada5-83001d387044@gmx.com>
 <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
 <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com>
 <CAMj6ewM2wr2tRrMjRk+sztH0nD7RG1J4tXKfoekg3-rqEL3RWA@mail.gmail.com>
 <50599154-2ab4-2184-7562-f0758cf216eb@gmx.com>
 <CAMj6ewPGbkxH-OdsRt+xKQyLUUgR3J7dV7Xcf9XMq2-E=n3-tA@mail.gmail.com>
 <b040e855-c0a6-cd75-c26a-4ed73ffeb08d@gmx.com>
 <CAMj6ewOJpH_Lo3JcL540-ACwvbFNr33XS0LixEt+wAzf-T4vag@mail.gmail.com>
 <707ded00-c6e1-ba27-c12a-3ed7111620d8@gmx.com>
 <CAMj6ewON-ADoVKRL8yhy+vYaKoxGd=YwdpZkrDRRRG_8aOMjeA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
Message-ID: <aaf9f863-9f16-704f-9682-ac52626d0acc@gmx.com>
Date:   Sat, 20 Feb 2021 14:01:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj6ewON-ADoVKRL8yhy+vYaKoxGd=YwdpZkrDRRRG_8aOMjeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KcTxlQyVKZKJK+Dribq7RXzkPopoDCj3dkMFnbpVyCi54bXjLE4
 v/IuyQv8idFrYpcNH25s1B6FZ1Ayz0jcXLcYHdzGvjeS19Kkqs5Xn5F74IONakge1c8K6Y3
 NQYHCDTpXT96hvswRubaYJLs25uFmDNRt2c/lc60CR/G/D7hDfB4IxKKgwT8b5/N2pUirUk
 J3cyHaZn9n5yHs6JoqAKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:StPAQ7gDmyE=:6grVlP6Nq9F7DXAYV0vjgo
 1aH7q8yFXXPReD1Me2ZjmozW7QLmYqn6gkI1x1Xs7gvUR6pnlw1PGzbaq9DixEQsbYka18aZ9
 FfrCiQqIpt4KQXAdr6+c7yH15cnDZW3O4Bnaw0gayL+gZFGbLd+leJ+8Jg4Z4fl7GPthkPQJ8
 gd7lgXEfzucPtRIe0epKMyzdyuePGY0Mj/Vsc86xUK6flzfib1V9i1BetBiuK+BWuepkdhvum
 tOQeGVi5tsPYPorla1rSfSVVTViW6XrR2CyUni5ZUW2W9Xo3L8JJT6iJuOupJD/y58FsfzbbT
 MY/n9nHxXN0jgfFxPWlyg3q6NfykYwYWMbg1o3g91UVODbzSt2k3IUsxBkDOiT+j+Ja9A48c/
 uT+CxIqEi4Sd8l7BKKVAs4yBikAKMyjz4L1jhHkjsyz5r47hxVxbVy2z/OLnbo8WKz2f5ouTq
 5Jww/1ecEjxueib0+aVjG5N9VpGGapM4/CilZz0B6EvMYjlMh7cIp6f4DbNplY0B/Ig34q0t9
 Cb1tfsLCY54FfTQI0X5o06Bdb6TpdkEsY5In93t/rgsp6rXyFp8V8tiH71x8AU4AhnB1Jikuf
 W9UYNMF005pOFxJl0pvmN5cwSfU0W0nW+ITlPFcRdd/ilX3QrCdGT8UZozKjL38B2G9OFcOMq
 QnClHscVqvmDybeaMm8wXvsTbgUZ2vHtvfxv+Vx2TjyDdeDHZpCg1KsmCSLiOhkiQKToCYwdT
 H3aix6GOq4idGi3lhQ7bwtryeTzZUMOG+yVDZsoAo21iiRrEdI+4ogOLA93iDhXKxWHY80E3g
 ecq1YOPj1baID1C2WugnjnTTReug6eX5kSKGCJoT8y1IzexgOjqdrFQW+lGlGAgIx22n+9Tvl
 b0XZ7GovcQBBoeTT/ykg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/20 =E4=B8=8B=E5=8D=8812:28, Erik Jensen wrote:
> On Fri, Feb 19, 2021 at 7:16 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>> On 2021/2/20 =E4=B8=8A=E5=8D=8810:47, Erik Jensen wrote:
>>> Given that it sounds like the issue is the metadata address space, and
>>> given that I surely don't actually have 16TiB of metadata on a 24TiB
>>> file system (indeed, Metadata, RAID1: total=3D30.00GiB, used=3D28.91Gi=
B),
>>> is there any way I could compact the metadata offsets into the lower
>>> 16TiB of the virtual metadata inode? Perhaps that could be something
>>> balance could be taught to do? (Obviously, the initial run of such a
>>> balance would have to be performed using a 64-bit system.)
>>
>> Unfortunately, no.
>>
>> Btrfs relies on increasing bytenr in the logical address space for
>> things like balance, thus we can't relocate chunks to smaller bytenr.
>
> That's=E2=80=A6 unfortunate. How much relies on the assumption that byte=
nr is monotonic?

IIRC mostly balance itself.

>
> Brainstorming some ideas, is compacting the address space something
> that could be done offline? E.g., maybe some two-pass process: first
> something balance-like that bumps all of the metadata up to a compact
> region of address space, starting at a new 16TiB boundary, and then a
> follow up pass that just strips the top bits off?

We need btrfs-progs support for off-line balancing.

I used to have this idea, but see very limited usage.

This would be the safest bet, but needs a lot of work, although in user
space.

>
> Or maybe once all of the bytenrs are brought within 16TiB of each
> other by balance, btrfs could just keep track of an offset that needs
> to be applied when mapping page cache indexes?

But further balance/new chunk allocation can still go beyond the limit.

This is biggest problem other fs don't need to bother.
We can dynamically allocate chunks while others can't.

>
> Or maybe btrfs could use multiple virtual inodes on 32-bit systems,
> one for each 16TiB block of address space with metadata in it? If this
> were to ever grow to need more than a handful of virtual inodes, it
> seems like a balance *would* actually help in this case by compacting
> the metadata higher in the address space, allowing the virtual inodes
> for lower in the address space to be dropped.

This may be a good idea.

But the problem of test coverage is always here.

We can spend tons of lines, but at the end it will not really be well
tested, as it's really hard
>
> Or maybe btrfs could just not use the page cache for the metadata
> inode once the offset exceeds 16TiB, and only cache at the block
> layer? This would surely hurt performance, but at least the filesystem
> could still be accessed.

I don't believe it's really possible, unless we override the XArray
thing provided by MM completely and implemented a btrfs only structure.

That's too costy.

>
> Given that this issue appears to be not due to the size of the
> filesystem, but merely how much I've used it, having the only solution
> be to copy all of the data off, reformat the drives, and then restore
> every time filesystem usage exceeds a certain thresholds is=E2=80=A6 not=
 very
> satisfying.

Yeah, definitely not a good experience.

>
> Finally, I've never done kernel dev before, but I do have some C
> experience, so if there is a solution that falls into the category of
> seeming reasonable, likely to be accepted if implemented, but being
> unlikely to get implemented given the low priority of supporting
> 32-bit systems, let me know and maybe I can carve out some time to
> give it a try.
>
BTW, if you want things like 64K page size, while still keep the 4K
sector size of your existing btrfs, then I guess you may be interested
in the recent subpage support.

Which allow btrfs to mount 4K sector size fs with 64K page size.

Unfortunately it's still WIP, but may fit your usecase, as ARM support
multiple page sizes (4K, 16K, 64K).
(Although we are only going to support 64K page for now)

Thanks,
Qu
