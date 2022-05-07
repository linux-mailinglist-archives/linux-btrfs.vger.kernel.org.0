Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7361751E2F0
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 May 2022 03:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445137AbiEGBT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 May 2022 21:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiEGBT5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 May 2022 21:19:57 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193886FA3F
        for <linux-btrfs@vger.kernel.org>; Fri,  6 May 2022 18:16:10 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id 3so2881600ily.2
        for <linux-btrfs@vger.kernel.org>; Fri, 06 May 2022 18:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pSSAseboc8RhCeofm3LG6BdGWYbV7Vl/MA8GY1CgGP0=;
        b=iqpSL1ygQ8EoyQ+PzmvufXVP0BB35lq5l60IRMdoXtXgoMQWDLK85ypdpAr+RTribS
         sh3FdkeW5pe+AkSNWfroO6gD5Cj75eMOovQepd6Zmp9nBrNnkdCzxm2KN3mHul8TiSec
         MHs+mAuSwQSX2yWrTYLQ/rUDquItY3b7B13sIub7EOx5Ehz6Z0olCRLr6fkEG40rfb0P
         YsgYy5fWgvT7Uj3ApvWpkaX1JiPfIPjfXQlWs2wS/wYxbtzRV+Th0051u9fojuxjyhuL
         CcYSD4MiLVs4Gflnvk7w9Tta+KnRWE/NLGJhb5lcSSTzEEBuKsNmYgfCfNgSa7BPHUFe
         66cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pSSAseboc8RhCeofm3LG6BdGWYbV7Vl/MA8GY1CgGP0=;
        b=5rauXIM8glMyu35ckmSL0b+546FAaVy+Ek9RDmq1ncDESK3ZGA3QfW8orWAbcie17q
         zCIxUQu2Y5Sq41NT+4mnEtqVeVp5jn4cV7ypjsq7/8NBYThahQIT8BJtykajDwWHjDpD
         lcL1CaZlPaBThj7maWLwlYPHjogEBdYzL/C5grwPb67keJaNctMmqXd0tQQkdXKXCo6b
         mxzFudXp2Ovd6emvxdGHw2aej+s/ha95bAyvnIQfTBslGtiDDy6z4My41Zdkdj2DBRAy
         bOmhiABnTetqoQMaOYVSZSOp/iGprZYSO5LcRaCVzNzmi2jIBC08MdOrzs5cVuFKhh6E
         g2rQ==
X-Gm-Message-State: AOAM532QrZA8gVWsbQKhmsByNu0UGG6/su4uGz4PFA0K7J5Vpf6fOpqB
        A8CFXq83YTxhjtxlrYp5uXiYkjBIKRxAt9+X2VdcWe5fJFs=
X-Google-Smtp-Source: ABdhPJwb9zpB30bShY56Mh1lqchwQJotn/ZR8BXCAbPtcElNG9yv+2OY+XA2TBQV1bxaiPOxoM96U72pMqf3JaeTlhE=
X-Received: by 2002:a92:ca0d:0:b0:2cf:3bb8:f1a5 with SMTP id
 j13-20020a92ca0d000000b002cf3bb8f1a5mr2381165ils.152.1651886169310; Fri, 06
 May 2022 18:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqfCkTAWvDJRoWj4V4SrZztkpa4jq=r_TeFK=cwR8o_BSQ@mail.gmail.com>
 <20220503012602.GT12542@merlins.org> <CAEzrpqdth9sKazxbiUhmuH7BTayzzsFGzfEDMpdd0ZOQ6C_GYw@mail.gmail.com>
 <20220503040250.GW12542@merlins.org> <CAEzrpqecGYEzA6WTNxkm5Sa_H-esXe7JzxnhEwdjhtoCCRe0Xw@mail.gmail.com>
 <20220503045553.GY12542@merlins.org> <CAEzrpqdegGAkJmdpzqeLJrFNwkfkMMWEdFxkVQnfA0DvdK5_Zg@mail.gmail.com>
 <20220503172425.GA12542@merlins.org> <20220505150821.GB1020265@merlins.org>
 <CAEzrpqfx3_BxSFPOByo5NY43pWOsQbhcCqU1+JqGAQpz+dgo7A@mail.gmail.com>
 <20220506031910.GH12542@merlins.org> <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
In-Reply-To: <CAEzrpqfHzZrMuWrMERM-m4ASsuJAsijU9tpk_e5OML8dpgMeKg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 6 May 2022 21:15:58 -0400
Message-ID: <CAEzrpqdzdimQvXyhpDomvPgDXx5Dn9QCEKQMiXofTFb3WvWUJQ@mail.gmail.com>
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

On Fri, May 6, 2022 at 8:25 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Thu, May 5, 2022 at 11:19 PM Marc MERLIN <marc@merlins.org> wrote:
> >
> > On Thu, May 05, 2022 at 11:27:32AM -0400, Josef Bacik wrote:
> > > Sorry Marc I was busy with the conference and completely misread what
> > > you did.  Cancel the btrfs check now, and then do
> > >
> > > btrfs rescue tree-recover <device> // This should succeed without
> > > doing anything but just in case
> > > btrfs rescue init-extent-tree <device> // I'm hoping this will succeed
> > > this time, if not of course tell me
> > > btrfs check --repair <device>
> >
> > Got it. Note that check --repair faile
> >
> > ./gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> > FS_INFO IS 0x55fbfe283bc0
> > JOSEF: root 9
> > Couldn't find the last root for 8
> > FS_INFO AFTER IS 0x55fbfe283bc0
> > Checking root 2 bytenr 29442048
> > Checking root 4 bytenr 15645196861440
> > Checking root 5 bytenr 13577660252160
> > Checking root 7 bytenr 15645018521600
> > Checking root 9 bytenr 15645878108160
> > Checking root 11221 bytenr 13577562996736
> > Checking root 11222 bytenr 15645261905920
> > Checking root 11223 bytenr 13576823635968
> > Checking root 11224 bytenr 13577126182912
> > Checking root 159785 bytenr 6781490577408
> > Checking root 159787 bytenr 15645908385792
> > Checking root 160494 bytenr 6781245882368
> > Checking root 160496 bytenr 11822309965824
> > Checking root 161197 bytenr 6781245865984
> > Checking root 161199 bytenr 13576850833408
> > Checking root 162628 bytenr 15645764812800
> > Checking root 162632 bytenr 6781245898752
> > Checking root 162645 bytenr 5809981095936
> > Checking root 163298 bytenr 15645124263936
> > Checking root 163302 bytenr 6781245915136
> > Checking root 163303 bytenr 15645018505216
> > Checking root 163316 bytenr 6781245931520
> > Checking root 163318 bytenr 15645980491776
> > Checking root 163916 bytenr 11822437826560
> > Checking root 163920 bytenr 11970640084992
> > Checking root 163921 bytenr 11971073802240
> > Checking root 164620 bytenr 15645434036224
> > Checking root 164624 bytenr 15645502210048
> > Checking root 164633 bytenr 15645526884352
> > Checking root 165098 bytenr 11970640101376
> > Checking root 165100 bytenr 11970733621248
> > Checking root 165198 bytenr 12511656394752
> > Checking root 165200 bytenr 12511677972480
> > Checking root 165294 bytenr 13576901328896
> > Checking root 165298 bytenr 13577133326336
> > Checking root 165299 bytenr 13577191505920
> > Checking root 18446744073709551607 bytenr 13576823717888
> > Tree recovery finished, you can run check now
> >
> >
> > The delete block bit should be automated somehow, it's quite slow and painful to do by hand (hours again here)
>
> Agreed, I'm going to wire something up now.  Thanks,
>

Ok I pushed something, hopefully it works and you don't have to touch
it anymore?  Thanks,

Josef
