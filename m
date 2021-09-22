Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F7F4153DC
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 01:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhIVX0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 19:26:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:50971 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231259AbhIVX0U (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 19:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
        s=badeba3b8450; t=1632353088;
        bh=S3Hv1oH4wy8/QgrFOjZntTf3QYT8Exj30txctSFEBLE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=cXXIwIVridpxByvG+It2+Z/f4tduAfQKnsiVT5FaIxQfDHkEvOvmxo36JUtfJkFCs
         E+nApcfNYJXCQEI/RysfobZDjl8ZZk+xSOq0+ndEhqxeFTk1hGDwcK46VnhRmLj7Qi
         HChVx0oas1Xw0N8e0jyyN7urwdN5c6n+j9d9co50=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MsHs0-1mhxMj0UQ6-00thkT; Thu, 23
 Sep 2021 01:24:47 +0200
Message-ID: <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com>
Date:   Thu, 23 Sep 2021 07:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: btrfs receive fails with "failed to clone extents"
Content-Language: en-US
To:     Yuxuan Shui <yshuiv7@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/y4OttYBVgH47v1B42rWSMZReActhlwDGyFkRsQLC54oNGryIOy
 bxCtSB5CpqE+WK8+lI944W+CBvkQqjk90AUzi4Qw/jGHDpRoy8rRlWSfrw6LpYxqjKOanyR
 1J/3HhXSv+dQ0vPIL5HHb/iMGn3ifaPnnLcN5t3LX/4aWdXp1sN+22Swpl5vjixBaYR6m/g
 GGCG06tmnoXyyeEo5er0g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lqDFFesAy9U=:+y5IL2el5I2tjU/B5cIPyG
 dp7jpgvUvqrFucrACXFLLNl7OQ8S0gILZQpF5narHYr3H5GlMljgiy2ni0RUrx7Sr4DyaZBrj
 GYvOfAD3JkSnoOY6hBm66ysRTc/z8nssd7kn5PyaH4upNoYHen25ZM3Na5FqpY21HR17zn5NY
 fp+FYlgw0fQJG/rRRogDauJ0DzkRlkDoSfbPASq6gP2KBq0tBafEO+NQ49EEXes8AawbBCtYM
 far6eW+GjEtDo2uHxWJyFDUklteQgqi9OvuPJopCepb27y1cGeg+GNaAPhUYx47tTfZJA+4ES
 O1fQlF2nmQ0/OfNQ4r0eMbCeALwFuYByHMIJHG2GuH20wWyfQCuhGbafPCL+4a0eWI2OAtlMA
 ASyEnLEEPNxCpsvKr1bLOj8ga0Ig/JBXjqZUqjo7kIYVT9O/O+lVwTHtN/WN0E1ufRInthnLm
 E+mp2FkQjAf8hpFoUsGo0DSfgxykEfI1P2tN4j6JI1BfoDfXkLl7tIsXbHyW9xgM0IHoytCp/
 mOsqSMkAuEscBsafRJslvE1zpdW4CrgPRTW1DNMZIENdVMpYESnLAdPyB6Vi9A8KhffYOOU1X
 y5HYFnMp5BfbcQaSY8ycbYX77N+3KQuPCus5TL2BY+qVonhRB9v/onxVPykPVw4tmoOSrIiPN
 6uXCcNI2ecpCN+0JE63HiLPjipQ84S8F7pOijPou1UwGvHd2s5covJ1W+3dy0QTOuG0ESjUuR
 HVYIt0d1X26GWXtCwUNJC934uGj9VU6Rtw0uaBY/lfxkBXAm3/OVKWIwKDup7R0mJFD5HyHJ+
 2mzLJkDmTSgcmmJpYrlNRlcZilk6NqkDtx0De9Dluvpjq9leXPbp1jk30uKVu4aN0HfzyMwDD
 wTq3dUZvfYWNWwYF7M5JapjkqruPso0fz1eiVBzAAzzH4X39He3fkbap4Fe5j10Wvz+KYKM/z
 UWovr+wIgD/yl2hSpB2cBq22LmRofXRmvtxNd3VRNW3JzlZLS3pZZje70a8YtpJ/j4xhAIihL
 Ak/Vfc/0BdNq/5grhkTXmMmF/Opmnary0aZiq0WiMOjXaLL5x32GFL13zYOMiV1kkP2QJW1qj
 HJvi2IEgKOuQU4=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/23 03:37, Yuxuan Shui wrote:
> Hi,
>
> The problem is as the title states. Relevant logs from `btrfs receive -v=
vv`:
>
>    mkfile o119493905-1537066-0
>    rename o119493905-1537066-0 ->
> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/o=
ut/include/zstd.h
>    utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8eff=
d111251c/out/include
>    clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd=
111251c/out/include/zstd.h
> - source=3Dshui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys=
-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> source offset=3D0 offset=3D0 length=3D131072
>    ERROR: failed to clone extents to
> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/o=
ut/include/zstd.h:
> Invalid argument
>
> stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.=
6.1+zstd.1.5.0/zstd/lib/zstd.h,
> on the receiving end:
>
>    File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-=
1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
>    Size: 145904 Blocks: 288 IO Block: 4096 regular file
>
> Looks to me the range of clone is within the boundary of the source
> file. Not sure why this failed?

The most common reason is, you have changed the parent subvolume from RO
to RW, and modified the parent subvolume, then converted it back to RO.

Btrfs should not allow such incremental send at all.

We're already working on such problem, but next time if you want to
modify a RO subvolume which could be the parent subvolume of incremental
send, please either do a snapshot then modify the snapshot, or just
don't do it.

Thanks,
Qu

>
> Sending end has 5.14.6 and btrfs-progs 5.14, receiving end has 5.14.6
> and btrfs-progs 5.13.1
>
