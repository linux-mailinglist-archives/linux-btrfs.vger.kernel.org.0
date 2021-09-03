Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A507D3FFA98
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Sep 2021 08:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346599AbhICGuH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Sep 2021 02:50:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:58491 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234697AbhICGtz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Sep 2021 02:49:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630651734;
        bh=HwGi0HOkD2xJsk03iLyJvymGeH5XYMKgVWofYCqMFxA=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=bwDxzeXgbo2T9rqFu4jejDg30qeuN2cAnJmw3RXGUohTO58nkaqKmsJaUpFgvnwJ7
         2+XVuCkEgs/BZQDiZ3EMmjpTg2nYUQQdkPEQ5I5mzCPY2lJ69W83wEcKfG8hDLxMrC
         atpB1/snsUOtHmoTeVs+BdMXacVqrkYLAoxsRJcY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MYNNy-1mQywR1USw-00VLaW; Fri, 03
 Sep 2021 08:48:53 +0200
To:     Robert Wyrick <rob@wyrick.org>, linux-btrfs@vger.kernel.org
References: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: Next steps in recovery?
Message-ID: <3139b2df-438c-ba40-2565-1f760e6d1edb@gmx.com>
Date:   Fri, 3 Sep 2021 14:48:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAA_aC9-ZAdGC15HY-Q0S-N2M1OukST5BjAk9=WsD+NArCkCFUA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Now6/a+lPjTXsmeIGp1h5GYj3rwwCFhLYedWxErwMDpCqkyJZx8
 CRQnsjnhUAAJLdxNLTejjqYNxB0FZeQLQya7nsi3apEhfOz3cmF34X5bx9a5JkFUNm6UhKN
 M7ypTuMj4U8hO55FSd2oifh5oSmP5T3D9qbjrrK5x+Vin2dtEX9tPvi+4opJ+EyXEE7t63a
 8prOKPCu110nIp8rUBQqA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZA5QHrSUgLg=:FdeWYBZRmb1eA8btOFQoGl
 ldUcYyOn20hSG4vQMAPkTCa/bsg2T3ayXlaowfQSzM3mZ5Okk1PNddRTm2pnC4MKqLhQGLR5s
 M5rm0Rjbf/FEM25RqwVS248+oBWFULmSDVKwu0V1HnmKaRG1KAvIbZ+81GphCCaH/EPHBk3qH
 pYnCHybyJsft9iAZfKQvR3OJEKIEbDVk2gGcL9i6/RNeGD3C9yZi01+697yfyB2heprKcCUHQ
 L8/R6G97OVjrmakim836FD/9uNZQBAI5e1gVz1Ca5J8h8LjWEXGfRWRwmZP0lcbO54uNkRdVX
 Gp1N8wP1VdvnpIql+uhqn5lAvMnmoRBDixk87YJ6ZJ8JpzIJRUop3UpdNILSE35vqwsgPvHaR
 w8jPENy0yPbzUcTnf/Sr35S7aLefx4S3YY+FGeRrHCEdPZtYCaFIeymhPSJWqmNDHW07FMl+T
 4GOxyuJguvOP+PX1pqecrTDpkHpt2EIMak3ua86plsRqf1xABOyec+9/BtrNzKYQoi2xalrIM
 Y6rRaFb4qXBi9Eab49pC7p+j0lkAkPmZqHNgCO+ypKqBjCzyKbNJFaepLXUDEQhBwMg0gHMIY
 g4Qpjq10svfjtqWBpOOas0gWkiTPyitdW48RSk5jc114eokj68HYqPP85pAdaVuqbSaLOZ/w/
 cEZ9rxc+Wsmlr3owj03t5OVJIbETDUS+xN6l8dSSluL6p/8jouOf2ID+h0oqVZVH69qkUNKD/
 4xHITA1b3stEeMZBs+iQLOV+yuGj/SOFsnzuKTykRdiuqadW+utPEykBTJc/qxzx4nxWxLkW6
 DIApMXtJ9iP1aH2QL8P5xhWvJoEaxZNcKosD1hFbMOHlYXAXh3CXM7AkIFuJoObI7ISxT71ma
 bWuAek6Mu+a3+EdErghIbwnJdlp404O04b5Jqed0q1ySmkKr8NTkMKQ3mTwn41ZrFgbwmTwWG
 ZZP3uhSgVXrIBu6IYzd2SRtmftxJd20B24qKt8E/xaJ6vkJvxr7SYKEcxsLqnIYYOKaZanGJg
 1tt0LhspovUOg4VJSeqM5sMOkFSZ+PZdIM4QzlgBXHvNg/hoAbMYmxB58jyC9Ebc4tWcTuD1l
 Q9FbW5uHO/xdMP11A+1yHmAaAP+CDfaM226P1DRVgxBdryYrZYl/7mWhg==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/3 =E4=B8=8A=E5=8D=8810:43, Robert Wyrick wrote:
> I cannot mount my btrfs filesystem.
> $ uname -a
> Linux bigbox 5.11.0-27-generic #29~20.04.1-Ubuntu SMP Wed Aug 11
> 15:58:17 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
> $ btrfs version
> btrfs-progs v5.4.1

The tool is a little too old, thus if you're going to repair, you'd
better to update the progs.
>
> I'm seeing the following from check:
> $ btrfs check -p /dev/sda
> Opening filesystem to check...
> Checking filesystem on /dev/sda
> UUID: 75f1f45c-552e-4ae2-a56f-46e44b6647cf
> [1/7] checking root items                      (0:00:59 elapsed,
> 2649102 items checked)
> ERROR: invalid generation for extent 38179182174208, have
> 140737491486755 expect (0, 4057084]

This is a repairable problem.

We have test case for exactly the same case in tests/fsck-test/044 for it.


> [2/7] checking extents                         (0:02:17 elapsed,
> 1116143 items checked)
> ERROR: errors found in extent allocation tree or chunk allocation
> cache and super generation don't match, space cache will be invalidated
> [3/7] checking free space cache                (0:00:00 elapsed)
> [4/7] chunresolved ref dir 8348950 index 3 namelen 7 name posters
> filetype 2 errors 2, no dir index

No dir index can also be repaired.

The dir index will be added back.

> unresolved ref dir 8348950 index 3 namelen 7 name poSters filetype 2
> errors 5, no dir item, no inode ref

No dir item nor inode ref can also be repaired, but with dir item and
inode ref removed.

But the problem here looks very strange.

It's the same dir and the same index, but different name.
posters vs poSters.

'S' is 0x53 and 's' is 0x73, I'm wondering if your system had a bad
memory which caused a bitflip and the problem.

Thus I prefer to do a full memtest before running btrfs check --repair.

Thanks,
Qu

> [4/7] checking fs roots                        (0:00:42 elapsed,
> 108894 items checked)
> ERROR: errors found in fs roots
> found 15729059057664 bytes used, error(s) found
> total csum bytes: 15313288548
> total tree bytes: 18286739456
> total fs tree bytes: 1791819776
> total extent tree bytes: 229130240
> btree space waste bytes: 1018844959
> file data blocks allocated: 51587230502912
>   referenced 15627926712320
>
> I've tried everything I've found on the internet, but haven't
> attempted to repair based on the warnings...
>
> What more info do you need to help me diagnose/fix this?
>
> Thanks!
> -Rob
>
