Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AC840DA11
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Sep 2021 14:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhIPMkT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Sep 2021 08:40:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:39581 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239613AbhIPMkS (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Sep 2021 08:40:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631795936;
        bh=JoMZpanneoWaQ9MB6GN1wdPMYpGCndb+cFX5zm+YJTM=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=NDNhlsCjeqbvtDM6c032d5EdsR01MYJETn/UDKRrilldcecHU+sajARTh2uJmlhYr
         T2iiOiEON04bWLoAKfvgCtt2SPXOK7xUbCJPV3Uck70aflJ3Nat1zVgwMWyFqrU5uX
         NN+bwrpFsK8UCQIGXKQ7bMefnLnp/5OFDMLjIQwA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHnm-1mkI9l2fc2-00thJW; Thu, 16
 Sep 2021 14:38:56 +0200
Message-ID: <ca8e4d97-633c-2d1b-80b9-85a4f82229f1@gmx.com>
Date:   Thu, 16 Sep 2021 20:38:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: strangely large space_info value in dmesg
Content-Language: en-US
To:     Eli V <eliventer@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAJtFHUSy4zgyhf-4d9T+KdJp9w=UgzC2A0V=VtmaeEpcGgm1-Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAJtFHUSy4zgyhf-4d9T+KdJp9w=UgzC2A0V=VtmaeEpcGgm1-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ffspd7vdAtNGriXP0rN3Q7PJ+Zz6xCIImd9CC78ggToUCZPqiKK
 yqAZyh9Pz4uDsJ5vgv06Th7Dmt5NySPGA/1j3LyxiBD+7DjcLHFVrauuXR0LiD9iEhW+P8h
 Er8alD0vxWRHtNOQXNUvUwH2E7Ht/f07dQv8Egb/JGO5NqRY87Pqv9LV4aH3OqbIaGUuvSS
 y2iWw8XyjMVw3SM8/O8tQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:p9oinLFS9/8=:pfn8CcdHHNnCc7qKBAn6+g
 cGjIvJOVWkCumNuAtMEZavXGacfiGpsEykO4F6FW4WtGjGtesyDGTnQ6Z7l7M/C2DhnxthBxL
 tDo+BaCFqPpzy1r1MgNNLToo1Fdw7+jy4PPF9CcXYVDOLftHhajzXW0jwmBaKWt3dHp6c64y5
 jmOmoUZI++L7T1J00q/aHlk+4mPfF/CP5LsXMrfRjrHP2OB8UnIXQQrXe7r5B30rRYOPTEzhc
 UgyXO5o1O2jAlbeDqNHsEjtKDpPr+moQ/1+MJLOh/XwKo/6be3ftN/WefCFoM5ucj0DLOEPyk
 cMube5edEpCMHQjZq2zvik+081wBLAM5TAOq+rHiFdTzzkW7eUzy0NAtwFdhjahKHm4PR6+tQ
 kUuQIKCQ7hVNXWjuAetFlUICmFYthmc0yIQrMUoj7k97SMde+3pTZXAWn8Zb+GiG9hYKL3HCM
 5ZyY5AuPk6O85U+4mFJ3jgl8cO2QSin4Fl0jluA/u5V+5VoFHZrGd2KW38YsRYsO/7lYWDUCL
 O8hp7r+SF5UjQOETVrmnCJASjDe10zjgcaHAAehqp25PhMW1Dc6ZYHkqmdrUmsgQIS5mxuOmV
 QwG3qJVT7TwJcyNSQAtOH6aNZ5iBh3XdDhQfGGDjZ/QwyBgvPpQoJKZKRVtMQjIkSLVWQ5MPv
 zU/BCViNcdwpi5OGsjfXsC3n6+O4awyfgUWKucBtKhDkzAu5rKjt9gJRGwsudhI3JC1aNEza/
 Z+jcTzBJGiA7uTS6ruxnZh3eyh9mqFEcQOVMVZSORYHSv3ErjJBhcjRYHMOQ+qMCSNUfI7oys
 sgznAbqJHtRUPTdJ5u2gkHyC1it46q/9F+238Fo9IhA7ZoF6W2Uwg1UWHEwWd6dF+xrnO7T2Y
 Ab3CftfzNFztpw2PGMm5issnuV8wemOgzvvRiHHevgcb6T5CNOOPSfe3pS7nBh9+zjoadWlft
 rOrcCmm3yIdvD8k0vocdl2p+rYecd4ah49lxMwFXseVFbxnNoucu5R0/qef1zgJkAGO5zZoZg
 bcXbXimpi9d8gcAn9z8x1vbyvr3eAbUkIwz0BcpbzJIMhD39Av8N5L8WXqE4Tl2m0XCkLgb1o
 +2LKq+JGhON24c=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/16 20:32, Eli V wrote:
> I just upgraded one of my btrfs systems from 4.19 kernel to 5.10.46
> dmesg is outputing the below messages, I assume because of the
> enospc_debug mount option I've had in fstab for quite some time now.
> Didn't check all of the numbers, but the first line free value does
> seem erroneous, unless that's some sort of theoretical maximum being
> displayed. This is a fairly large filesystem at 382TB (btrfs usage
> below,) but that's a lot more free then total space:
>
> Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): space_info 4 has
> 18446743694945091584 free, is not full

This is space info dump, normally meaning you're hitting ENOSPC.

The free value has underflow, we should output it in s64 other than u64.

The free space should be -378764460032.

But if you see no problem, it means we just hit transient ENOSPC during
some operations and can allocate new space for it.

Thus it's really enospc_debug causing some debug output.

Thanks,
Qu

> [Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): space_info
> total=3D955742420992, used=3D468888780800, pinned=3D2666528768,
> reserved=3D360448000, may_use=3D862591057920, readonly=3D65536
> [Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): global_block_rsv:
> size 536870912 reserved 536870912
> [Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): trans_block_rsv:
> size 1048576 reserved 1048576
> [Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): chunk_block_rsv:
> size 0 reserved 0
> [Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): delayed_block_rsv:
> size 0 reserved 0
> [Thu Sep 16 06:17:55 2021] BTRFS info (device sdb): delayed_refs_rsv:
> size 862469488640 reserved 862052614144
>
> $ btrfs filesystem usage -T /mirror
> Overall:
>      Device size:                 382.02TiB
>      Device allocated:            380.64TiB
>      Device unallocated:            1.38TiB
>      Device missing:                  0.00B
>      Used:                        338.61TiB
>      Free (estimated):             42.52TiB      (min: 41.83TiB)
>      Free (statfs, df):            42.52TiB
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:              512.00MiB      (used: 0.00B)
>      Multiple profiles:                  no
>
>              Data      Metadata  System
> Id Path     single    RAID1     RAID1     Unallocated
> -- -------- --------- --------- --------- -----------
>   1 /dev/sdb  27.12TiB  59.01GiB         -   105.00GiB
>   2 /dev/sdc  27.15TiB  78.00GiB         -    58.00GiB
>   3 /dev/sdd  36.12TiB 101.00GiB         -   169.00GiB
>   4 /dev/sde  36.18TiB 126.00GiB         -    80.00GiB
>   5 /dev/sdf  54.15TiB 188.06GiB  64.00MiB   244.00GiB
>   6 /dev/sdg  54.05TiB 293.03GiB   8.00MiB   239.00GiB
>   7 /dev/sdh  72.05TiB 486.06GiB 104.00MiB   246.00GiB
>   8 /dev/sdi  72.07TiB 449.04GiB  32.00MiB   270.00GiB
> -- -------- --------- --------- --------- -----------
>     Total    378.90TiB 890.10GiB 104.00MiB     1.38TiB
>     Used     337.76TiB 436.91GiB  68.69MiB
>
