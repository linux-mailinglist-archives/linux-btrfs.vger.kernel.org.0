Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C9D31E4DD
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 05:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBREEX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Feb 2021 23:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhBREEC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Feb 2021 23:04:02 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BABBC061756
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 20:03:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id g6so1164044wrs.11
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 20:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7CSuWpqbCbunOdkyQYtDz32YSSM7PZB+/pJBoHz0LYY=;
        b=L8CoU9ojjzNvpwh6RMauEh2NqGP2ZRIrRZs/PgTrlx5ijS1GOHSckNfdndKkuKTaka
         OZq48AZ9jjZEVJ3iBE75cyZiV/sI/zGcxjFn1mKXUQUvz8pp00h2andnyEy2I0PV7+Cf
         ihvu3Z5tOrjKmTufFO2ZSJdEv2W2cyVRQgrIdCKw4ppi3aavvyuTE04Ckv5GfSt7SwNq
         vJSR7IriZ6CKHY1oMA2HQ1KbdbywXJzYh2YufhTUaNKA9frHBEZzfx5OpA0BiPeznWuU
         J0Qy0zElt4wogHziF7zCGvMGMSR/bik06zkYQQzqxAchQ+Y1E4Rpxn1o1Dg49QSRSnAD
         pnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7CSuWpqbCbunOdkyQYtDz32YSSM7PZB+/pJBoHz0LYY=;
        b=TC/u5Gpf+LFgI7QgldkDhqckPeQ3kKgQeuxKUU+y8WR3/YQhBjfYWTOGp6KXrnFqNP
         KdzzGaT3Fdp7Jc8jy1qEcpXb4HTJIAumnb91lNBNEhWLCHAwQpXb+UdUw4acNe5CmGqg
         GHWiyrggdwDtzXUI2uvjrp8Ds7cHR7dz7hQj+JRbqAr1zdQl8KPUmUc6eRPPbEEy/wM8
         BBHLZlIGOVfO8AbkES+jTkmAnybzq7ZPsOt6hUhKbwFrxpEmbcIPLM/A7Plba+ovxLJt
         ob+GMwcJF5Z9g+3nMMrG3ZYyhkSx4arulfpFmQeH7NA021AkyyqY9ezCZFhRAyQ7/Y5J
         pcRA==
X-Gm-Message-State: AOAM5329oqzvAql/TF/G7PJaZjRIkqtgnyMobNv21y8wOr5H8srSO6Hg
        8qS2zwYw9HzMjFQ4qMj3Xgyksg1skpTVsAN2IAxCcPHOwITvNhXs
X-Google-Smtp-Source: ABdhPJwiOkAtBNTs7rE/5kFvEAlOh/g5Tbed9sIyRPymiCwA2GApam8qoTfUZfCq9NDqAcE/Gqbb7yAS5i1/0nxIgJs=
X-Received: by 2002:a5d:4d85:: with SMTP id b5mr16365wru.192.1613621000927;
 Wed, 17 Feb 2021 20:03:20 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <CAMj6ewNDQFzXsvF5c1=raJc11iMvMKcHH=AbkUkrNeV2e3XGVg@mail.gmail.com>
 <CAMj6ewPiEvXbtHC1auSfRag5QGtYJxwH_Hvoi2t_18uDSxzm8w@mail.gmail.com>
 <CAMj6ewNjSs-_3akOquO1Zry5RBNEPqQWf7ZKjs8JOzTA7ZGZ7w@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com> <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com> <mtwofibp.fsf@damenly.su>
 <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com> <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com> <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
In-Reply-To: <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Wed, 17 Feb 2021 20:03:09 -0800
Message-ID: <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 5:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2021/2/11 =E4=B8=8A=E5=8D=887:47, Qu Wenruo wrote:
> > On 2021/2/11 =E4=B8=8A=E5=8D=886:17, Erik Jensen wrote:
> >> On Tue, Feb 9, 2021 at 9:47 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrot=
e:
> > [...]
> >>>
> >>> Unfortunately I didn't get much useful info from the trace events.
> >>> As a lot of the values doesn't even make sense to me....
> >>>
> >>> But the chunk tree dump proves to be more useful.
> >>>
> >>> Firstly, the offending tree block doesn't even occur in chunk chunk
> >>> ranges.
> >>>
> >>> The offending tree block is 26207780683776, but the tree dump doesn't
> >>> have any range there.
> >>>
> >>> The highest chunk is at 5958289850368 + 4294967296, still one digit
> >>> lower than the expected value.
> >>>
> >>> I'm surprised we didn't even get any error for that, thus it may
> >>> indicate our chunk mapping is incorrect too.
> >>>
> >>> Would you please try the following diff on the 32bit system and repor=
t
> >>> back the dmesg?
> >>>
> >>> The diff adds the following debug output:
> >>> - when we try to read one tree block
> >>> - when a bio is mapped to read device
> >>> - when a new chunk is added to chunk tree
> >>>
> >>> Thanks,
> >>> Qu
> >>
> >> Okay, here's the dmesg output from attempting to mount the filesystem:
> >> https://gist.github.com/rkjnsn/914651efdca53c83199029de6bb61e20
> >>
> >> I captured this on my 32-bit x86 VM, as it's much faster to rebuild
> >> the kernel there than on my ARM board, and it fails with the same
> >> error.
> >>
> >
> > This is indeed much better.
> >
> > The involved things are:
> >
> > [   84.463147] read_one_chunk: chunk start=3D26207148048384 len=3D10737=
41824
> > num_stripes=3D2 type=3D0x14
> > [   84.463148] read_one_chunk:    stripe 0 phy=3D6477927415808 devid=3D=
5
> > [   84.463149] read_one_chunk:    stripe 1 phy=3D6477927415808 devid=3D=
4
> >
> > Above is the chunk for the offending tree block.
> >
> > [   84.463724] read_extent_buffer_pages: eb->start=3D26207780683776 mir=
ror=3D0
> > [   84.463731] submit_stripe_bio: rw 0 0x1000, phy=3D2118735708160
> > sector=3D4138155680 dev_id=3D3 size=3D16384
> > [   84.470793] BTRFS error (device dm-4): bad tree block start, want
> > 26207780683776 have 3395945502747707095
> >
> > But when the metadata read happens, the physical address and dev id is
> > completely insane.
> >
> > The chunk doesn't have dev 3 in it at all, but we still get the wrong
> > mapping.
> >
> > Furthermore, that physical and devid belongs to chunk 8614760677376,
> > which is raid5 data chunk.
> >
> > So there is definitely something wrong in btrfs chunk mapping on 32bit.
> >
> > I'll craft a newer debug diff for you after I pinned down which can be
> > wrong.
>
> Sorry for the delay, mostly due to lunar new year vocation.
>
> Here is the new diff, it should be applied upon previous diff.
>
> This new diff would add extra debug info inside __btrfs_map_block().
>
> BTW, you only need to rebuild btrfs module to test it, hopes this saves
> you some time.
>
> Although if I could got a small enough image to reproduce locally, it
> would be the best case...
>
> Thanks,
> Qu
> >
> > Thanks,
> > Qu

Okay, here is the output with both patches applied:
https://gist.github.com/rkjnsn/7139eaf855687c6bd4ce371f88e28a9e

I've only run into the issue on this filesystem, which is quite large,
so I'm not sure how I would even attempt to make a reduced test case.

Thanks!
