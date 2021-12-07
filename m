Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06D746B209
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 05:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbhLGFAQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 00:00:16 -0500
Received: from mout.gmx.net ([212.227.17.22]:54547 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhLGFAQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 7 Dec 2021 00:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1638853005;
        bh=77zGzocR4uNDY04knfW7Lr9N4SH6krLj48lSTnNc97Q=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=CbVaQQWMCxdZkCminBmczUxW1u2Op6zhFndUydGvHiXghKcXr3qHMzB2KqvIJ5dRj
         ZM0OCg4SraFdKqyL2efbxJQJRLdZPoaBXOVnoh1cAzO1JdfcWXJVApPltCRI8Trws3
         NzhrLJoBbG4q5NpE+AK58egvjYcPfe/nqq/PUsu8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3UV8-1mtuZC2noo-000YDL; Tue, 07
 Dec 2021 05:56:45 +0100
Message-ID: <b68c9739-3c7e-7303-4b21-818b5d28bf25@gmx.com>
Date:   Tue, 7 Dec 2021 12:56:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <f001f3e81d413ea290722c38b14d95f3f1f52249.camel@scientia.org>
 <25d305e5-c75f-3d71-fc5a-c2019e49bed9@gmx.com>
 <c64be50bdc99b993b910a7ab019af8d552eeb0d4.camel@scientia.org>
 <b7b6a6a7-700e-f83d-dae6-581ed6befbef@gmx.com>
 <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: ENOSPC while df shows 826.93GiB free
In-Reply-To: <3239b2307fae4c7f9e8be9f194d5f3ef470ddb8c.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oJELPOD1TrPIHU2LAE4NZjlX05V5UORjpW119pMNSCAhFs+EEZY
 h/ZKa/NhTOvBAjPs7KFGLjYLvGEnv6JVQ5Ot13RhM45jGoJut3V9uWnCTDNmoA4PETcEcf9
 PPT1Ieu9IOA2/ryIK8mZb4g+NTCsIPi+kf5XP3rQ2ogL2miq/PfMus6XwAZRrD0YAZutLHn
 CPhMu+3agR0iJkhhLXoiw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:epxOmPzGA1A=:IZTBTpDA1mRTmgJowV62lk
 zSXuVmFvcNd0oUMu//kRY6gRtwZhyobbccAvwnXKf/hgET0FKXTdUTncBUCTpViV6Iwuu8Vf2
 gEqRPzyXpIgl/1G9ubwVUtyOhweGD5FJzzO7LQly4pH1Mg2gfeW3zDxJzuO5LG/zW21vUNzOH
 3W1/WmXEFsR/NxBtItFF6cYJ+N7Q6dRxfoc0NgWBh1JtakfpgGSbK14O4BGduXo/uGN+qtikY
 /XdOzRMHtk5PC2K4y5aHEPNkbIq4Vj2oIDHtuaL83Zr1G3pUwvA2ZIDw1yUpUVJY9MKXnkZ0R
 9IdHESCHmlPuH0XpSIZK/pxjSpi8ZroYa0qa4sxXUyTjiJXoCCDDaUYtMFHaUAaaAx2Fe5deR
 vVkBw9l6xVYMsMfYEWhTToOrKo/pSDwTCepViPk6hBeMsxXSNKYVm/rFA7Mx05kP6yWEoRMmh
 00O1T2JkLxJ+giUzqAWMZSQG4v1PBRSW9g87iMYusu2TA3gu4Rn0AMFv3j9V4UyZGWG6NJ5xh
 cl4dxeWVWOJd3sbFN+M6JxGUyCEHGCW6D39rJKtL/Tht76XDyaxbbLgThW88I9/8OJ99k+FCR
 U9hGtvPGOo3rBSKj+K7seFeieQfKbUNuI/TfuoBO0HV+nr2NFUx+qcCOqsep2Mfi7HkZIPjba
 vqcBx/6fQskQ4QzYWwbqQsy4cbglFHiOVt1wHFM9Zga1bxHfgXjCDCJVRelpgX9olbigwEGL0
 ZkDNGRZXHuzdKuZHxueMAor8Ymyv3c/db7kR/nA7PvIlYi3qcwpHn70hEOy+A8MwPmvhiKkZg
 52z6sVzTWZOX32KWH0kzjQuSKimnj2RYR/izhzqUHxWIx7HUfGFfcaMp6SemeFVBqMpIB56ng
 4fE/yLnWZH9D6+UgCHOMT71SrZDcs1esKAVSClfyAuSZLACZVQllzqLLWqSTiINwJAeyBjF6z
 sRLGzV9MZ1umsA+Ekga1th4Md/5wvZk1Fc5FlTVwcPWisVRwsGXuN7yOWWycO7muZtiZ7EwaJ
 Q8D/0vIvP7inXnwZ7d/8MltazZYxdcBP5Hjt+ycxzpe+isjscVSsiz7tr8pzytoeMqWMHVHUJ
 WUHpSlbi84Yc8M=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/7 11:44, Christoph Anton Mitterer wrote:
> On Tue, 2021-12-07 at 11:29 +0800, Qu Wenruo wrote:
>> For other regular operations, you either got ENOSPC just like all
>> other
>> fses which runs out of space, or do it without problem.
>>
>> Furthermore, balance in this case is not really the preferred way to
>> free up space, really freeing up data is the correct way to go.
>
> Well but to be honest... that makes btrfs kinda broke for that
> particular purpose.
>
>
> The software which runs on the storage and provides the data to the
> experiments does in fact make sure that the space isn't fully used (per
> default, it leave a gap of 4GB).
>
> While this gap is configurable it seems a bit odd if one would have to
> set it to ~1TB per fs... just to make sure that btrfs doesn't run out
> of space for metadata.
>
>
> And btrfs *does* show that plenty of space is left (always around 700-
> 800 GB)... so the application thinks it can happily continue to write,
> while in fact it fails (and the cannot even start anymore as it fails
> to create lock files).

That's the problem with dynamic chunk allocation, and to be honest, I
don't have any better idea how to make it work just like traditional fses.

You could consider it as something like thin-provisioned device, which
would have the same problem (reporting tons of free space, but will hang
if underlying space is used up).

>
>
> My understanding was the when not using --mixed, btrfs has block groups
> for data and metadata.
>
> And it seems here that the data block groups have several 100 GB still
> free, while - AFAIU you - the metadata block groups are already full.
>
>
>
> I also wouldn't want to regularly balance (which doesn't really seem to
> help that much so far)... cause it puts quite some IO load on the
> systems.
>
>
> So if csum data needs so much space... why can't it simply reserve e.g.
> 60 GB for metadata instead of just 17 GB?

Because all chunks are allocated on demand, if 1) your workload has
every unbalanced data/metadata usage, like this case (almost 1000:1).
2) You run out of space, then you will hit this particular problem.

>
>
>
> If I really had to reserve ~ 1TB of storage to be unused (per 16TB fs)
> just to get that working... I would need to move stuff back to ext4,
> cause that's such a big loss we couldn't justify to our funding
> agencies.

It won't matter if you reserve 1T or not for the data.

It can still go the same problem even if there are tons of unused data
space.
Fragmented data space can still cause the same problem.

>
>
> And we haven't had that issue with e.g. ext4 ... that seems to reserve
> just enough for meta, so that we could basically fill up the fs close
> to the end.

Ext4/XFS has a similar problem but much harder to hit, inode limits.

They use pre-determined inode limits (determined at mkfs time), thus you
can ran out of inodes before free space is used up.

Tools like "df" has ways to report such limits, but unfortunately for
btrfs there is no such way, but using btrfs specific tool to do that.

Thanks,
Qu

>
>
>
> Cheers,
> Chris.
>
