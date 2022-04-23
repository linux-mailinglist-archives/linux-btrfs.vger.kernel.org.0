Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F4B50C772
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Apr 2022 06:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiDWE4Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Apr 2022 00:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbiDWE4Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Apr 2022 00:56:25 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C623978937
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 21:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650689602;
        bh=2WndCZ5Gh1O58ggi/sJV8OgRtmOKSCYiHDiZHzoNWzI=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=fA+kSPuXKVjpx6PmCDORXCa7KO09uXXXVKa2/C2WYAerqYesFiyNs0a1sdXOVAfDc
         yZj2jYXwBpx59sTDry6amj0gGMFpFw73T3GxfSKjvX7iYxaq+r4ahdb21CfUhgeAO8
         91bHnjTK3AVIHN2pyCrRKRgvbqDdU6BMveTtyXGM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MmULr-1o898C3Xwf-00iRKv; Sat, 23
 Apr 2022 06:53:22 +0200
Message-ID: <fe391705-79d2-a365-27ca-fc52b260fcbf@gmx.com>
Date:   Sat, 23 Apr 2022 12:53:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: btrfs check fail
Content-Language: en-US
To:     Jat <btrfs@jat.fastmail.com>, linux-btrfs@vger.kernel.org
References: <a41c8f80-78de-49d3-a34f-2cd4109d20a0@beta.fastmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <a41c8f80-78de-49d3-a34f-2cd4109d20a0@beta.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5mLVp+IlG7FKXLbhzml+giw68b8ZJ/hkc4lCG3OpkX9h3RrhLto
 wH3VkzOk8UP7rQjUae4TgdRJ/ODAL6rH/j8Qo2Sb+yulVe7XrtoLPi/ka93U+ccMmdh94ge
 HE6zxbx+5Jk4GDcG+0H9IV+VdzXy5b/hmL45wLNA9hViLocakjU2tc7FWSkqSjf4Ito6HLO
 hR34OvY8uYeZTZP78PJgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mHYmdDRqpCY=:3pQl15B+u4Wg3tb8GXnxcv
 Z+TzXFzB+rglyVLkNEZZEcxsy+mxUbCjrNN0yLkUlbvHgGrBrFZdpItT2SvNlVB2lhfU80R43
 6gmmnimefruKJoXlkaGxJ9Vr4lw9zpP/XIp2f4DjwJozRY/d85sUdE8BtaE0U167rOIjGq+xZ
 hT6NU9O1KBip2ySVhq8b1NGvRsnakN6hmA6wLYraiXoWmmTbSbFBWbn0RRg75C/7iYMRG4Jof
 MwnvMKwBLDqZGlXOhw8Z6Mo2qPlHVHb2LF+2HWW2Nz9TIq6z27FDae+LrB4njbjTHfqPyQNDk
 o4T2kZlAnxgCz/pPIrXx037D69OhKuAgh/AoU5DMYtpzXLNPmgnw0643vuIcn+WrWyt5RJmY/
 AwomO4uR2XcHgiQM6dRcqo+8UVEtAgQPztJZPhii/efZDxgsAUvHn9uX0dEUmpxQIxB7TZQYe
 bQuJEIGImm4COlNJMzSc2TkOBZmqvQJJYMA0y7wzKLXPNm7QnqsHzz2VIZQt/GkWhX3yvCNyL
 QYVFjzTVjOIihOuBYTZGU9fnu85qTt3JZ9bCQt0F9WeVnS+9NEV5RJJ+uUWH6uvSZVLVTKP4l
 EZzIGMbXftlF3duF0U2CeuEavlwhdK0PpBSfO/mZYMN4v3UWXFNPptr7qjzyaB2r0NLGY/NZK
 J9i+nQPvDp27ApJNx3QYVLl8BOM+JQsNZxpwfCPtQJgvr2D7LmbuPbsSBaHOVjtD+yhm/bI3U
 byZFuWHONL8L0AwYg9X4tGT+ZjspIfer2dZM8UFxLz7QTEDzysa4Z1RKae4jfRxiSHArwIZrJ
 XclCuDslgqTXqkkZxs4kZzd8A8Xhp3+CgzrsGIEQHxOkmLNqEYurOr9JDoWxvnibjtdnwcPPm
 IJPQpdEcz91ClHBvdckaT/fPdfMBjz14bvnMU78k5rpsiNeCgB0isZZZ06Q3Tqm/5aXvPsbQd
 8d0MY8lNPZ3/Qh9UpRlho29q8RP8usigLwYXhC2pkmCOMpnjHKhn+VdFL94z6aJcHILrZz9+x
 v1rJ8gQcxdOZOw4rbRvl0p80t4uc+Mu9TDga0i8R6OUsWMN/qmpU+uwqMQvBufGRw0FVrRnYM
 2eOcsRZf9INZ9k=
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/23 11:56, Jat wrote:
> Hello,
> I am trying to resize a partition offline, but it fails the check.
> The output of running btrfs check manually is below, can you please advi=
se me how to resolve the issues?
>
> Here is the output from btrfs check:
> sudo btrfs check /dev/sda7
> Opening filesystem to check...
> Checking filesystem on /dev/sda7
> UUID: 4599055f-785a-4843-9f59-5b04e84fea1a
> [1/7] checking root items
> [2/7] checking extents
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated

Recommended to go v2 cache.

You can just mount it with space_cache=3Dv2.

> [4/7] checking fs roots
> root 267 inode 249749 errors 1040, bad file extent, some csum missing
> root 268 inode 466 errors 1040, bad file extent, some csum missing
> root 308 inode 249749 errors 1040, bad file extent, some csum missing
> root 313 inode 466 errors 1040, bad file extent, some csum missing

Please run "btrfs check --mode=3Dlowmem" to provide a more readable output=
.

There are several different reasons to cause the "bad file extent".

 From inline extents for non-zero offset, to compressed file extents for
NODATASUM inodes.

The later case can explain all your problems in one go, and can be
caused by older kernels.

If that's the case, you can just go copy the files to other locations
and remove the old file, and call it a day.

Thanks,
Qu

> ERROR: errors found in fs roots
> found 103264391173 bytes used, error(s) found
> total csum bytes: 93365076
> total tree bytes: 2113994752
> total fs tree bytes: 1825112064
> total extent tree bytes: 144097280
> btree space waste bytes: 432782214
> file data blocks allocated: 352758886400
>   referenced 178094907392
>
>
> Here is the requested info from Live boot environment for offline partit=
ion sizing & btrfs check...
> uname -a
> Linux manjaro 5.15.32-1-MANJARO #1 SMP PREEMPT Mon Mar 28 09:16:36 UTC 2=
022 x86_64 GNU/Linux
>
> dmesg > dmesg.log
> [Sorry, didn't capture this after running the check in live boot environ=
ment. Will capture as needed next time along with recommendation]
>
>
> Here is the requested info from within mounted environment...
> uname -a
> Linux manjaro-desktop 5.17.1-3-MANJARO #1 SMP PREEMPT Thu Mar 31 12:27:2=
4 UTC 2022 x86_64 GNU/Linux
>
> btrfs --version
> btrfs-progs v5.16.2
>
> sudo btrfs fi show
> Label: 'manjaro-kde'  uuid: 4599055f-785a-4843-9f59-5b04e84fea1a
>          Total devices 1 FS bytes used 96.19GiB
>          devid    1 size 226.34GiB used 226.34GiB path /dev/sda7
>
> btrfs fi df /
> Data, single: total=3D220.33GiB, used=3D94.92GiB
> System, single: total=3D4.00MiB, used=3D48.00KiB
> Metadata, single: total=3D6.01GiB, used=3D1.97GiB
> GlobalReserve, single: total=3D275.20MiB, used=3D0.00B
>
>
> Thank you,
> Jat
