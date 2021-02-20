Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A52F32037A
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 04:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBTDSR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Feb 2021 22:18:17 -0500
Received: from mout.gmx.net ([212.227.15.19]:38089 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhBTDSQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Feb 2021 22:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613791003;
        bh=emq53J/Ik22SdDfjCPcX+e9Rk5mZNzXQQfJRWt/HTyw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ve7Y62u4g/aa5g5mZK0iCY1lhL9DE8Im5zMo0xdppBChjjU7jQAqUd+7pb3KqbcV0
         H6BeOAprBiTrMcvVt/iT0kfMHnyQUYMl7qT/umNyjf7svkdefV9DjLtCEM7h55731L
         Z1wCU+zd88WdoAbrjoSGxPo6DvN18xLwTWFNdjgw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MXp5a-1lKrtG3maS-00YA3U; Sat, 20
 Feb 2021 04:16:43 +0100
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com>
 <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
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
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <707ded00-c6e1-ba27-c12a-3ed7111620d8@gmx.com>
Date:   Sat, 20 Feb 2021 11:16:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj6ewOJpH_Lo3JcL540-ACwvbFNr33XS0LixEt+wAzf-T4vag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B4mVLmULaZJl6w0x4h+PU2uKTb1kcr1EEgjWLcO1zIp9MDJwxpQ
 PZQA8bcU+g5gWp1VFHJ6Mn3Ap2iWe0EHDyqf2Uh/V/KsjNCc7s5IzbxfQ4ZgNjeTJs3lzmx
 Isf1hIKWCPC/PEhSnt7wVjEpygdXBJiljCT7Qp9kr5dK+2wqNrjqn2JxBedZm44A7gCX+6m
 6euwYfLceBh0c4GZcapgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kn0JAD68ieQ=:/A6qJrJAPmhqBuQB+q5K3m
 VH3WjjdZBUsarR52dcOYnDlmiepEXYoRTEX8obCbygD0ygUPNSPGNqi18jJ0lFpYV74qtp5kB
 SB9iRJcTnhIQPi24xL9x2SiuKFEP3nW3BE8T4QeGd47YSI8rv3wXV3jeUwG6rLokHTibrb42X
 UtT0Q9fw2oyGIZfzi9r8iCCPiZVgy+DVZUgIGG3sRflnur7G/mBThTcrb4GUOONayQ7wMImxy
 fQ4a9XC3Dtkvtzozl6ES+38DYW1CElHnXQPxomBN4W9A6z9U0xI4E3wZgSQllKcbDUC0Bc3ST
 Bha0VcHmyoMvFwA6wEnmXaM1U7GAnbstZDtkq5uZjwZfCEcDXpnixV6OqQaHYde1KNLMDWHym
 oSAqejFAPTU9iEynke4n+siOPEFBtP4UXp6sgjbLQ57gquGJ1b6uA6oT9Io5vbWwmTDwTVUQx
 hq7DFKr1tA+mOBrmVxYrSbxqQlXQwZrwdgkIkE3iWIUpqNa363JHrYAAJbZlMTHCHTXgwL5ne
 VlOX/QTnEGv8TdY7mBdR8nDBJxD9q5gHmm9Rk38Do9yE7MV+I1ItfdWb9KRKKd5XImA/u7iUB
 gtWq3Z66lFeM94CUpZcnYGmB7GGcRy0xxPj6+dM9NduOHRKWiMXP6r7MCnSqlNQsQUOgLcgmh
 XXiRr8K48O4QWZ7ZyVDOxMuvBCN2DwIlMv+vUhlqcSQ0EvP3kmgS3br5V92hue1yc9Ruv7eWW
 GVqrZ6iNaRXPoE6KGWY3ngeXyGRityP82uB+wXgG2reylonCFzB7F1fU/gqI4LSe3r1IcyEMX
 ubNe5rT9mX3oZlsr5NJkA/zM+TOOV7BtM9s9jWFvEb9n4hrrmIv3Xqe2mV2ZIZI/LQEwyYxU6
 viWiCKNefKvSm0+2Pxlw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/2/20 =E4=B8=8A=E5=8D=8810:47, Erik Jensen wrote:
> On Thu, Feb 18, 2021 at 12:59 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
>> Just send a mail to the fs-devel mail list, titled "page->index
>> limitation on 32bit system?".
>>
>> I guess your experience as a real world user would definitely bring mor=
e
>> weight to the discussion.
>>
>> Thanks,
>> Qu
>
> Given that it sounds like the issue is the metadata address space, and
> given that I surely don't actually have 16TiB of metadata on a 24TiB
> file system (indeed, Metadata, RAID1: total=3D30.00GiB, used=3D28.91GiB)=
,
> is there any way I could compact the metadata offsets into the lower
> 16TiB of the virtual metadata inode? Perhaps that could be something
> balance could be taught to do? (Obviously, the initial run of such a
> balance would have to be performed using a 64-bit system.)

Unfortunately, no.

Btrfs relies on increasing bytenr in the logical address space for
things like balance, thus we can't relocate chunks to smaller bytenr.

>
> Perhaps, on 32-bit, btrfs itself or some monitoring tool could even
> kick off such a metadata balance automatically when the offset hits
> 10TiB to hopefully avoid ever reaching 16TiB?
>
That would be worse, as each balanced block group can only go higher
bytenr, not lower, thus it will speed up the problem.

Thanks,
Qu
