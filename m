Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5868543E03
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiFHU5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 16:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiFHU5V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 16:57:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1187A20B14B
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 13:57:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg6so23950960ejb.0
        for <linux-btrfs@vger.kernel.org>; Wed, 08 Jun 2022 13:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yfzyol2qf3U5sPf4d3udShKvhZT0oSOCMomvSiEpNoQ=;
        b=ZmEo6bEbTQ0dK089ZDbkAd6Tz+0aiLUPHcEXKjV+2BtXyLjWSyNB3+YrsGSwszMzie
         FeNlWXRFmEKaO49aPHDPpBGOPXSHwMPSowOEf5XS9yRG8w//6sYAwxg0sEEByc5nBC30
         oQLQruhWq9g7vrnNhB3rSjGmOVyYf1Kf4fPsDL6IJYPGLektuKqf62YzIrvwsPua3zR7
         M/UhaEFDNKx3H+WASLGL/AnEVLk1dZwhUyNRSHF88fzEjnORoa4NLBw7TOIv9MJNaCDB
         bQE1wyaONNpxkhWhk28vmZ59HwqXjeENSkz0BfF4G5FcbYkSWB4nmZ4n2BpGyeNpYMgZ
         N3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yfzyol2qf3U5sPf4d3udShKvhZT0oSOCMomvSiEpNoQ=;
        b=wdPA3AXs+vz4XKax+THL/Nqsy1YSz5FLOUXiqifaLJFqCyxXGMWr6g+O9jQYDzvXDA
         qtc2rzofTiWkkT4EAGd0SF6llY65BYSnGP0IIMl9bSX2OQIhb4X4cY8EH8wmhVp8cwTO
         xJH3DkQRhhCA34hfv4RmGMmXVs5HfQYRRpREIwpsTtZDRWGYlIDft1j6Gze0s5zw2nS4
         ssG59Lhd1S/do1v3GpCz3rx0yS9fCtKBhsbnsXde0VFR4pwjBK3rOlKbHEb+AOOX6NI+
         hM59ZIOIfmxXJmYdQEPazY8X2hNmuPeJEEAug1DeuhRsmKGdRhhwJw+o5ppcUSdkUx0i
         k2CQ==
X-Gm-Message-State: AOAM533+iRQgCwW55olXsn0ZJj/CHsw9RrOpdptqqRtgL7PyDxxQZDyz
        n+6IpGNm3X6vYRvu9vZp2b3GNsfIcD16B+O884BfMKkzXE4=
X-Google-Smtp-Source: ABdhPJxFx7fMXXRZYfv6ga+etBZ9w62uRYUjljfg6dFra8UxJuwUjQDa8hdhSAkRkne6uzRTrRCQTJWoeX06T8mTv1o=
X-Received: by 2002:a17:907:6090:b0:6fa:14ca:fba8 with SMTP id
 ht16-20020a170907609000b006fa14cafba8mr33423795ejc.212.1654721836433; Wed, 08
 Jun 2022 13:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220607204406.GX22722@merlins.org> <CAEzrpqccYbdBNs6gYDzZRw17D1O6tPU=9w1vLvDVOjJeMDuazw@mail.gmail.com>
 <20220607212523.GZ22722@merlins.org> <CAEzrpqex0PRGZA3_gaoUhpPb-7cpi-gi_mo1S3F=0xxKNptpEA@mail.gmail.com>
 <20220607233734.GA22722@merlins.org> <CAEzrpqcVO99HbrhmtABUENRCm4HEsyg3+T3oK33DZFuXamwqgA@mail.gmail.com>
 <20220608000700.GB22722@merlins.org> <CAEzrpqe79F=-0T7Q3dqb62J6+kcisOjnWP+aLkkY0z+EJY-m9Q@mail.gmail.com>
 <20220608004241.GC22722@merlins.org> <CAEzrpqdq8zTBQaw_VneL4rfZn0JseUiwvtfwXQx0jq=DYBCFFw@mail.gmail.com>
 <20220608021245.GD22722@merlins.org>
In-Reply-To: <20220608021245.GD22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 8 Jun 2022 16:57:05 -0400
Message-ID: <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 7, 2022 at 10:12 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Tue, Jun 07, 2022 at 09:31:28PM -0400, Josef Bacik wrote:
> > > doing close???
> > > extent buffer leak: start 11160502779904 len 16384
> > > extent buffer leak: start 15645018308608 len 16384
> > > Init extent tree failed
> >
> > I swear first thing I'm doing after all this is updating the shared
> > code.  Try again please,
>
> It went farther:
>
> processed 163840 of 1064960 possible bytes, 15%
> Recording extents for root 5
> processed 65536 of 10960896 possible bytes, 0%
> Recording extents for root 7
> processed 16384 of 16570974208 possible bytes, 0%
> Recording extents for root 9
> processed 16384 of 16384 possible bytes, 100%
> Recording extents for root 161197
> processed 131072 of 108986368 possible bytes, 0%
> Recording extents for root 161199
> processed 196608 of 49479680 possible bytes, 0%
> Recording extents for root 161200
> processed 180224 of 254214144 possible bytes, 0%
> Recording extents for root 161889
> processed 196608 of 49446912 possible bytes, 0%
> Recording extents for root 162628
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 162632
> processed 114688 of 94633984 possible bytes, 0%
> Recording extents for root 163298
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 163302
> processed 98304 of 94633984 possible bytes, 0%
> Recording extents for root 163303
> processed 131072 of 76333056 possible bytes, 0%
> Recording extents for root 163316
> processed 98304 of 108544000 possible bytes, 0%
> Recording extents for root 163920
> processed 16384 of 108691456 possible bytes, 0%
> Recording extents for root 164620
> processed 49152 of 49463296 possible bytes, 0%
> Recording extents for root 164623
> processed 311296 of 63193088 possible bytes, 0%
> Recording extents for root 164624
> processed 933888 of 108822528 possible bytes, 0%
> Recording extents for root 164629
> processed 622592 of 108838912 possible bytes, 0%
> Recording extents for root 164631
> processed 16384 of 49430528 possible bytes, 0%
> Recording extents for root 164633
> processed 16384 of 75694080 possible bytes, 0%
> Recording extents for root 164823
> processed 131072 of 63193088 possible bytes, 0%
> Recording extents for root 18446744073709551607
> processed 16384 of 16384 possible bytes, 100%
> doing block accounting
> couldn't find a block group at bytenr 20971520 total left 180224
> cache 11106814787584 11107888529408 in range no
> cache 11108962271232 11110036013056 in range no
> cache 11110036013056 11111109754880 in range no
> (...)
> cache 15929559744512 15930633486336 in range no
> cache 15930633486336 15931707228160 in range no
> cache 15931707228160 15932780969984 in range no
> cache 15932780969984 15933854711808 in range no
> cache 15933854711808 15934928453632 in range no
> ERROR: update block group failed 20971520 180224 ret -1
> FIX BLOCK ACCOUNTING FAILED -1

Oops I think this is a system chunk, I've added some code to do the
right thing, can you give this a whirl and see if it fixes it?
Thanks,

Josef
