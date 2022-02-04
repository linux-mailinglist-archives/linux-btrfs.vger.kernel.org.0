Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4931A4A91F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Feb 2022 02:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiBDBRY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Feb 2022 20:17:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:48617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231357AbiBDBRX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Feb 2022 20:17:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1643937442;
        bh=Y5jJ/HOtRkyyzjkuT/+TwJ/yXpCqV7mfLcGok8CDtDE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=NTmLpzNmuhX6qQM6OlvFlTF3hOHgaPrsBbuS8MJy8GeYgHvo2m6MeBjiNN8EijMr0
         hGC4+IN0PA6Z/mogP3V91BGKI5WSFX7Mhz3UEXHciPGtzCztF8Vd6PXSzrTO9fzhh7
         WyatDwsRrMNiXau0dPkHVnUYngtcr+AzaLy0LaQM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MrQJ5-1mTCWk0NYV-00oVk7; Fri, 04
 Feb 2022 02:17:21 +0100
Message-ID: <9409dc0c-e99d-cc61-757e-727bd54c6ffd@gmx.com>
Date:   Fri, 4 Feb 2022 09:17:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: Still seeing high autodefrag IO with kernel 5.16.5
Content-Language: en-US
To:     Benjamin Xiao <ben.r.xiao@gmail.com>, linux-btrfs@vger.kernel.org
References: <KTVQ6R.R75CGDI04ULO2@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <KTVQ6R.R75CGDI04ULO2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fRKNuZ8MlR+dcVWEDzl1G7Ii2uWdyW64F/s9dM6AX8OrzQ+6QFq
 X4aw0GcgE10xC05eiO+Sw/FqkDmJ82z2BlMryTeGtiqUCbKUtTUrB4uiXGTvHk+yX61/V4/
 nT+d5y8GjlMlaRS+zZUbBwGmjZ2R2/oZllM3U+/FgMrstOr+rABoa6WDNnBcqmdPeofallz
 BSOQ7n6bWw6z3H5J/sRZg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hJw2WlBEKn4=:fbyn2WcHWr8kVS6faYFdZg
 e1zB8WYsHt17ngqAVtCa7oIrVWbUnXpaaxZ5fPkbWQeYwK2NpK2+sHOuknVDgHIKRWAGyPw2d
 pYGx1pZY2a2Zi7Pv1II126di5KPkAgaUoGIGqdzBpnR+xsCz3LhOm4U4oX68XHoAgY+jlKFYD
 nLdnLdyWgpddfg+3KZGl3WGIuHpW+hTsMgtNl6tFc6abmFJ0b9npep0XwZrMoqj+1cPe86TmH
 +X8WGKyuC51wAI6WgVUvGayEnYVoG1kRU8W9VasKLxJ+G6CVX25LP7aHfqCZmbBAv039xP08o
 lmmE5jdiwsLOQzM2OVdLovxgvYk6hpoGw2r2x3BHKDIFAhnb48QzhO35GObsScuwtZSI2UflT
 lfPr7V8sNsZRrSVybo9RxQZh2f5qZ6cNgnY36Tz/oy5bRzG0hx1Y8U4LPzfXCCJLbu/0IrTER
 OWVefLo2jqqjdzkX39DAIPrcq+CNziIybuQyii8AaImYoIr58GadY6FGSZileqFjo72KT2eFl
 Vcp8FFp80cKgLpR42qIEjwvhot9ahDmarK4gyrPvjQ6ZnddmfmjuHfV8y76WZz/RPmTES4FGr
 svWJCim5m/r8mIz7KwehMbx3i4EIQfjL7kRdqSJQfimqzLSfHMOiRbLqsw+lZe+/spE2y1rlj
 CWtQskyToULy783aKZuExG88TZPr6okz5qfPhvGUN1qmkmiTh92PB33yACLJUvXaITLsOOS7E
 gb08JaG/ka/oQBf0wWaNzYppcoXF+onQgS1gDVKRbdd+DDgiIKdYIrJ4dFDAOua0H86XykbSQ
 CIbwug+eh7gjv39TyckDmljni5Ng48S14Y4zrOFWW/D+HZh+fCvb8G/xEbpz35Y7wmWYcrU47
 pJU5mnsOLyEZXC4YoJo2aF5pzBiPvtF540NW97CrPPrANMH7JsgXVVtmMOgP1yfS/Je1ETOn5
 BfLC4++N87E80gxdFh1ZgWZNyPbj+49WwbA5z9Tc1UsId7Gk0jcJrOzM+iokIske8TMnWWtEk
 PQEnFeefW58BbIvxRss1DHyWQ+pBA32UlcExEYrzz6UX8XCKw2H6wDuokDJ3WTi4maLhR+5YQ
 ITYf5lWTZTWJpA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/4 04:05, Benjamin Xiao wrote:
> Hello all,
>
> Even after the defrag patches that landed in 5.16.5, I am still seeing
> lots of cpu usage and disk writes to my SSD when autodefrag is enabled.
> I kinda expected slightly more IO during writes compared to 5.15, but
> what I am actually seeing is massive amounts of btrfs-cleaner i/o even
> when no programs are actively writing to the disk.
>
> I can reproduce it quite reliably on my 2TB Btrfs Steam library
> partition. In my case, I was downloading Strange Brigade, which is a
> roughly 25GB download and 33.65GB on disk. Somewhere during the
> download, iostat will start reporting disk writes around 300 MB/s, even
> though Steam itself reports disk usage of 40-45MB/s. After the download
> finishes and nothing else is being written to disk, I still see around
> 90-150MB/s worth of disk writes. Checking in iotop, I can see btrfs
> cleaner and other btrfs processes writing a lot of data.
>
> I left it running for a while to see if it was just some maintenance
> tasks that Btrfs needed to do, but it just kept going. I tried to
> reboot, but it actually prevented me from properly rebooting. After
> systemd timed out, my system finally shutdown.
>
> Here are my mount options:
> rw,relatime,compress-force=3Dzstd:2,ssd,autodefrag,space_cache=3Dv2,subv=
olid=3D5,subvol=3D/

Compression, I guess that's the reason.

 From the very beginning, btrfs defrag doesn't handle compressed extent
well.

Even if a compressed extent is already at its maximum capacity, btrfs
will still try to defrag it.

I believe the behavior is masked by other problems in older kernels thus
not that obvious.

But after rework of defrag in v5.16, this behavior is more exposed.

There are patches to address the compression related problem, but not
yet merged:

https://patchwork.kernel.org/project/linux-btrfs/list/?series=3D609387

Mind to test them to see if that's the case?

Thanks,
Qu
>
>
> I've disabled autodefrag again for now to save my SSD, but just wanted
> to say that there is still an issue. Have the defrag issues been fully
> fixed or are there more patches incoming despite what Reddit and
> Phoronix say? XD
>
> Thanks!
> Ben
>
>
