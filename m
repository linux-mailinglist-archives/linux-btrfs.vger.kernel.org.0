Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9364AA80B
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 11:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359465AbiBEKTf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 5 Feb 2022 05:19:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:42161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbiBEKTe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 5 Feb 2022 05:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644056367;
        bh=ROqLd1uDXJE75olHXtpOvFirKefXWAM8DPMJ3KVGxWE=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=XIPIZfJ6RHeuY7AUwt35aK5W1GWL91AdJmDLYRpxW6kYA6Hfhunap3ZN88AgjS7Jh
         TSSSQN1gbjqPIWu0ivZKyLZfycvUUltZcoHX89gw6Gex2c3RTudphgqecVfGBAnqCc
         N85i9PvFtTCQ+ABPcFyJJBZvNtcgQ2DIsBt/Q7M0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQkK-1mLBN81ufA-00vPdN; Sat, 05
 Feb 2022 11:19:27 +0100
Message-ID: <b6b4e3a6-3291-2d7c-ac07-75bd3b44c9dc@gmx.com>
Date:   Sat, 5 Feb 2022 18:19:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-US
To:     =?UTF-8?Q?Fran=c3=a7ois-Xavier_Thomas?= <fx.thomas@gmail.com>,
        Qu Wenruo <wqu@suse.com>
Cc:     Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220125065057.35863-1-wqu@suse.com>
 <Ye/S15/clpSOG3y6@debian9.Home>
 <791ca198-d4d0-91b3-ed9b-63cc19c78437@gmx.com>
 <92236445-440d-b1c0-bd76-b8001facd334@gmx.com>
 <CAEwRaO6xT_utSgyHuRhEK+C6Y8uvLABJw5FS=TitsMVxODo1OQ@mail.gmail.com>
 <CAEwRaO6qcxr7ArAhkL-s=yRyNxmupFSVZL_w5ffHXagPQbiAgg@mail.gmail.com>
 <e67bb761-c4bf-b929-0bee-650f425248ac@gmx.com>
 <6f76b518-b509-dd45-11bd-c75aa78a5898@gmx.com>
 <CAEwRaO4Fo6k2-UjtJaAKjnP79a02C2eQsjoju41HXOzNP9nL-w@mail.gmail.com>
 <CAEwRaO69PQKC1Hn=vWt92BNk8ZQwtz4t9dW4uHYJpGGqYkmjNA@mail.gmail.com>
 <4fdf158c-203e-6def-27e1-8a003775693c@suse.com>
 <CAEwRaO4H_KTRBn8adNr0b_Ob_9-yYZhW=R7B1C+J=uDzL=NdWg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [POC for v5.15 0/2] btrfs: defrag: what if v5.15 is doing proper
 defrag
In-Reply-To: <CAEwRaO4H_KTRBn8adNr0b_Ob_9-yYZhW=R7B1C+J=uDzL=NdWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gNrQx73GaCmjEEEirGkm1l2Tb1xOIVQJOwGBFrZxKZkyXQDnTy6
 O+5VaJqM+AM3aFuZ2RtwjLFYumxj2UafvU7hlzpLyCRPMYS21Rkmo99G2gNP3LVWDoK3Xlo
 lkkJF/EG4PPBqv5wSnPsmlclC6DG86GEL4vMmk/seHctC2c6ew1KWKPQXy66vk+17jzZx++
 bbKWufErc8TfQr0RSuScg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:GSjvp6iwerg=:o5tXNa8jlDSWUU7WRO+Hxf
 3HdQpPrfZ9Uo6fv008+OJ8JxktsyUaW+1ERjxXTOt7lb/xMRlG6M1J6J3grtEB5Q169PF6dOt
 pCXI9ziA4cFIftbb7HyjnL4VYMMpgCgCmaeNc9EM1WNz9uPkiwwHK9wzhzJhd/IniPAh4fpJf
 kgEkAvh+2AN9ZHzfG6+0Jghb+izTLYkzzEI52lYALxN5ClAwvQM4sJprc4wJzwRBPv6oiRn0/
 bKIVCh1uinCHdhj3QNl/JCNAcWX6wjZJc5pLKnhwvrm9AJ4IPeqsKJsy+EkJ6EoR62qIU6LD9
 KJhPRd5YZElpHJhfu7xrz0RSRm64EDDRWOfiRtpe+oZNuJSW4lviqy5VKK5STMLZFtHE2WCjn
 gD3FM2jy+zKvPhQV0VXP/9z0vKGE0sjh7LyiAo+QBFe3lMocu7M0B7z4iksYYzHr5wZypDifo
 DVcia8/QICr7UB3NuEhKsPgWDQ5Zwi2tFcMWzrvCa0fJunDH/tN6RnQZ89YvBNS4kjNeLAdk3
 Fs6Y+yvkWfcnjDYZXu+6bgqavxf90hYIxGWhliUj4sRxjDWEYhoDmkFe0q0YnSlPkBmxBaOKR
 QnbqM4NxXusBXwb7w7P+uVCoTuJnoq1i7zd8/LnyGtItIVoOlO7CQes7uCuK1DAad9gDQ1ISb
 J1VqThvcq1uCshcHTriNN1Pz8wm59+lyB0CuoJ2Tc5EHlQQaoe4TsyIrYwAhtHXgibIsDiiGT
 ARPkhpduvjPmLO2CNp+z557nETmFjxUuiNPAKigAgObQujke49+AxUJgNK6tWVd+xwIKk28MZ
 lyoEs2OqU6U6kgbF0OUexuZNfAtTKDSKRzriAVSxC6WYcr7KnR1fSMY4k4whv1MuFLsdSQJy6
 UKHEFsIGq92f1zktVkjEaLFT7vE9iH8v/RVNIvLFfY7QSQbe4QrySoKicB2I9FmJGYXa9SJDB
 o43Das+e9VpAol9B0Cj8rBX85AOmsOw1haQzx6uW6CYWBkLJKs/Yd1ACWYDdQX+3OudINwD9/
 bmBzcZPr/e1RO3pSmQH7p//yhFPg8kviJevIGUHVqOX9UOcVQ3pZSh9GEbWpOD0yKTnGK/Iis
 CnHmfDs8GrPn6e45/EOXuXTRdYL18iocOIz2kE596/Ocs9YxEeCQyhFWBHreO3F2kndoDtwP9
 9TI6AjC80RWls0R+bybDWi4+Qv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/4 19:05, Fran=C3=A7ois-Xavier Thomas wrote:
>> But one thing to mention is, the color scheme is little weird to me.
>
> Good point, here's a custom graph with just the write rate, that
> should be easier to read than the default graph with everything:
> https://i.imgur.com/vlRPOFr.png
>
> Waiting for your next update then. In the mean time are there other
> statistics I should collect that would make this easier to debug?

Here is my branch:

https://github.com/adam900710/linux/tree/autodefrag_fixes

This branch contains the following fixes which are not yet in misc-next
  branch:

("btrfs: defrag: bring back the old file extent search behavior")

   This addresses several problems exposed by Filipe, all related to the
   btrfs_get_extent() call which get heavily used in v5.16.

   Unfortunately, I don't yet have good idea on how to craft a pinpoint
   test case for it.

   Thus I'm not that confident whether this is the last piece.

("btrfs: populate extent_map::generation when reading from disk")

   And this problem is already there at least from v5.15.
   Thankfully it doesn't affect the autodefrag behavior yet.

("btrfs: defrag: allow defrag_one_cluster() to skip large extent which
is not a target")
("btrfs: defrag: make btrfs_defrag_file() to report accurate number of
defragged sectors")
("btrfs: defrag: use btrfs_defrag_ctrl to replace
btrfs_ioctl_defrag_range_args for btrfs_defrag_file()")
("btrfs: defrag: introduce btrfs_defrag_ctrl structure for later usage")
("btrfs: uapi: introduce BTRFS_DEFRAG_RANGE_MASK for later sanity check")

   This series has been sent the list, and is mostly a pure optimization
   to skip large extents faster, should not change the data write IO
   though.

("btrfs: defrag: remove an ambiguous condition for rejection")
("btrfs: defrag: don't defrag extents which is already at its max capacity=
")
("btrfs: defrag: don't try to merge regular extents with preallocated
extents")

   This series has been sent to the list, and is to address the old bad
   behavior around preallocated extents.

The base is misc-next branch from David, which is further based on
v5.17-rc2.

Thanks,
Qu


>
> Thanks,
> Fran=C3=A7ois-Xavier
