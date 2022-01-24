Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACBD497913
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jan 2022 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiAXHAj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jan 2022 02:00:39 -0500
Received: from mout.gmx.net ([212.227.15.18]:42481 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235642AbiAXHAi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jan 2022 02:00:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643007629;
        bh=evXx6Tid8UahLeTyy5aGjdZzMwNYQm+dDxMLUSv6cCo=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=fz3JGfykd/syAorkylVrPd8xtCF/0p0tGm05/AoD+vb5cGQmH849sFgTV0F+0wkz0
         b4cTEoU2A179DzHd0XYtS5pnQ3BcNJR9s8RJujp4lZwunJhBb8EXujmC99okVGu4NT
         tHUINbevspc9Hm47r97G+5zP0/OswDPK4fesSw0U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvbFs-1mJVV42RtO-00sgfh; Mon, 24
 Jan 2022 08:00:29 +0100
Message-ID: <c88c1438-ebcf-a652-1940-4daa4ee53be9@gmx.com>
Date:   Mon, 24 Jan 2022 15:00:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois-Xavier_Thomas?= <fx.thomas@gmail.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <wqu@suse.com>
References: <CAEwRaO4y3PPPUdwYjNDoB9m9CLzfd3DFFk2iK1X6OyyEWG5-mg@mail.gmail.com>
 <YeVawBBE3r6hVhgs@debian9.Home> <YeWgdQ2ZvceLTIej@debian9.Home>
 <CAEwRaO5JcuHkuKs_hx9SJQ6jDr79TSorEPVEkt7BPRLfK2Rp-g@mail.gmail.com>
 <CAEwRaO7LpG+KBYRgB4MGx9td5PO6JvFWpKbyKsHDB=7LKMmAJg@mail.gmail.com>
 <CAL3q7H7UvBzw998MW1wxxBo+EPCePVikNdG-rT1Zs0Guo71beQ@mail.gmail.com>
 <CAEwRaO4PVvGOi86jvY7aBXMMgwMfP0tD3u8-8fxkgRD0wBjVQg@mail.gmail.com>
 <CAL3q7H5SGAYSFU43ceUAAowuR8RxQ6ZN_3ZyL+R-Gn07xs7w_Q@mail.gmail.com>
 <CAEwRaO6CAjfH-qtt9D9NiH2hh4KFTSL-xCvdVZr+UXKe6k=jOA@mail.gmail.com>
 <CAL3q7H7xfcUk_DXEfdsnGX8dWLDsSAPeAugoeSw3tah476xCBQ@mail.gmail.com>
 <CAEwRaO4Doi4Vk4+SU2GxE7JVV5YuqXXU_cw7DY9wQrMnr9umdA@mail.gmail.com>
 <CAL3q7H4ji1B7zn4=mP4=891XfokkVyOaaqW3dCmUH6uVGjgkjg@mail.gmail.com>
 <CAEwRaO7cA3bbYMSCoYQ2gqaeJBSes5EBok5Oon-YOm7EQ8JOhw@mail.gmail.com>
 <7802ff58-d08b-76d4-fcc7-c5d15d798b3b@gmx.com>
 <CAEwRaO58oCzY4GjU3gCSru3Gq02GvGSdkg5hPwCKMwYcZ+cM2Q@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Massive I/O usage from btrfs-cleaner after upgrading to 5.16
In-Reply-To: <CAEwRaO58oCzY4GjU3gCSru3Gq02GvGSdkg5hPwCKMwYcZ+cM2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:szH85lgt73NI4jEhpoP5VBAcel5VqQDf2xxmXaxaXX24K7HXp3k
 3mNeyHsagfB0nzQ/y7istTPBuUlRtl6FLdzZH2GbuWN85WS2XtQa0DeikozLpJqTA9UhdJJ
 liNi24g3gVW1cZi3TxZoaBDg41hHk9s68Hx4lFU2dcYu9BIb9bbHnwBavBQi3vGKij5TVl8
 G6Z37Hs3k+pwxeGB3+8rQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BhlaQpRadqQ=:M/PujuQGLqT26Os8ipYBeb
 2/MQpAL1yk9MmhIwfJCxGPuC6PvyGIrlucsVov6iO9SZU+DVLtwJ5/eIZxm8Svq5VtIC/9KwN
 AsfqOA0tFq+VTLjlKf/nGNJdbNutDGtsTmaguPg8NrhgDwL9whfLr3+hrm/LSZlrYydZmrKr1
 kJlSuvIfID+4c9hamv5wtfjMk+5caiUB017QOFjucs9tQaDWSxu6iuY94dFZdHBMwdRovR4sk
 /6Qe2shfUX12PcVIfTKzNur6gXBDtUvusAh9bCcd/AUeWgx8cA2rcclcIGh7LRSmGwbi/AEz9
 7KPtZqB3eu95OFGZe9rC1FldswLxa4eHcLEdzPJBD9SS2smuIqlOcVY/xHDTVlsCQB8t35Fz4
 Po2omDM5pT7Oq578X1L2MYKQRUaTX7mYddnuZ31jQ5dsyF77RZYVKNJF0m56VOMbAruS9gIjX
 D8M8FJQT4QDu1fC3tiTubdlJmbDkhcwuTHyLiAICwTJ1IvMi6Rq8zFGW8dOV9AC5PRLfhyvam
 nM6+ODs7g3h8qKiH/AAQIJ5tgKhygfUDNX8K4VFEPjPt6ZamB9zL3X09wep4Wz78MrXnunBeI
 25arH7UspqvCj2fQoynmjjpXnFiJUpFWqjyXww0mTPZhd8YUEu2uTIyj0+rbHcoNqkZku0J1g
 PuzxC2CL+1BO2tPjCg61B5zmoDEv59sEt0IKYZ7/3iFLWKfAuFiUH0oOIGHwb95bGsUc+tuzn
 SjeFHkPgJ5BSEcP7Mc9LarDHL6Aeb7NAQfh/fk0AgiE2Om+tWd8BKJyYL3N8F5k4pWFqkA7eP
 3Wr+vRryEiRUSl0jhw2dh830PSzujlYCSPjOJX72MAWr8fqDlUxqwLQTshUxNsrWD2aiNszDU
 FV9F18sqf/RswGfAuyVs43cUUTYrtoU0XWDfM4K+OurievTA3Ba9jxUpTp55wlgM3PHAP9MN+
 siu+P3ANF7kKs8J7t8OjD51XFiUC6qfLY06W5P1JJdxKqsUqsmeOcF9LQazzayR4bxU4TNJeL
 8XcEoAj4t2XesJg9+ouM9qs5+gACiyKXPgDT1RdA6VoWRjXFcwwIXVU3fy/PIs4vflED9haOF
 /ki/7sjZriZSLQ=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/1/23 02:20, Fran=C3=A7ois-Xavier Thomas wrote:
>> https://pastebin.com/raw/p87HX6AF
>
> The 7th patch doesn't seem to be having a noticeable improvement so far.

Mind to test the latest two patches, which still needs the first 6 patches=
:

https://patchwork.kernel.org/project/linux-btrfs/patch/20220123045242.2524=
7-1-wqu@suse.com/

https://patchwork.kernel.org/project/linux-btrfs/patch/20220124063419.4011=
4-1-wqu@suse.com/

The last one would greatly reduce IO, almost disable autodefrag, as it
will only defrag a full 256K aligned, no hole/preallocated range.

>
>> So even with more fixes, we may just end up with more IO for autodefrag=
,
>> purely because old code is not defragging as hard.
>
> That's unfortunate, but thanks for having looked into it, at least
> there's a known reason for the IO increase.

And just mentioned in that long commit message of the last RFC patch,
the defrag behavior in fact changed in v5.11 first, which reduced the IO
(if the up-to-256K cluster has any hole in it, the cluster will be
rejected).

While the even older (v5.10-) behavior will try to defrag holes, which
is even less acceptable.

My guess is, sorting by IO caused by autodefrag, the whole picture would
look like this:

v5.10 > v5.16 vanilla > v5.16 + 7 patches > v5.11~v5.15 > v5.16 + 8 patche=
s

v5.10 should be the worst, it has the most amount of IO, but wastes them
for holes/preallocated a lot.

v5.11~v5.15 reduced IO by rejecting a lot of valid cases, but still has
a small bug related to preallocated extents.
But overall, the rejected defrags causes less IO.

v5.16 vanilla is slightly better than v5.10, it skips holes properly,
but doesn't handle preallocated range just like v5.10, along with extra
bugs.

v5.16 + 7 patches, it should be the most balanced one (a little more
towards defrag though).
It can skip all hole/preallocated ranges properly, while still try its
best to defrag small extents.

v5.16 + 8 patches, the worst efficiency for defrag, thus the least
amount of IO.


 From the beginning, defrag code is not that well documented, thus
causing such "hidden" behavior.

I hope with the pain felt in v5.16, we can catch up on the testing
coverage and more defined/documented defrag behavior.

Thanks,
Qu

>
> Fran=C3=A7ois-Xavier
