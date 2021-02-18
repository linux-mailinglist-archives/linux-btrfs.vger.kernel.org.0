Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3DF31E73F
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 09:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbhBRIFF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 03:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhBRIBA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 03:01:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1122C0613D6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 23:59:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t15so1733321wrx.13
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 23:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cecSmxr0rGLsQSfeyIpHeupDBSO6tKuanQbBmxfQBwk=;
        b=CJ2bIwBqk/co+TJA+O9Wda4QlPXQb+wfPnLkPVSxAFKwrpdkySrFojjRk9Ov8DAuyR
         WthGl0kYc1JQeBnONh73Kr+/crlEEekMr7UcRndoW2XaEOzDeAOrZq6ICuF3MimeXVFS
         6htpPj+D77Ad1xBdfYqfoTCa+MoY2bP9mpjL2ce1s2tfe0pa9ePsO5sz6KkRao+7Hw9m
         /7Zm14LcrhMhMhbH1e6xGAwgsvxpVa6m1OGvZwQSxueXQHzbkbaMYwGTAmp/donzwkWd
         7V+h1tiPM6wuUE2YBMZcKhs9cxlwl8XEwhxxRkIxoALED2ACfp+Hn8rNpwZLkjX9fjLg
         YTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cecSmxr0rGLsQSfeyIpHeupDBSO6tKuanQbBmxfQBwk=;
        b=F74IOsLoETn+oyCfZeCJWwCze++dOObjbvgUk3ZnW1QX4B2FWKQOCGcBOGT4SzK1fy
         p3tFr5WPJ+T25fSjNTZpQQZbWTaa3Z7ybMlkOY7XWba+Q8ccRNb6BBkgCCbr9yNe20pk
         6oVXJ6Xio2Fw+tpfxCuwdCEwzoFN7p5wN/RXUeLRCyBqjNCaIjzr6jI2XapTQD2Mv+wh
         t5q/JVnQnT6aAKkg83zXbAkEQMpw1Im26V7PmkHpn0QF8ZXV3ArYcl24qagqoERykbh1
         aaLOujyFXcyqrO1QX/yVInr4F1H9vNVYYoE0LTjTb9TYdax+rzJdzAoVjDM9JDMGPtTD
         ik+Q==
X-Gm-Message-State: AOAM531umn9wb24gctCG7P4jDJbCWaQYaq34r2wKWN+2SSgvexZ7AvSN
        X/8/VgrXzWjx7BRtbYFZj8zKLJnwy4/7QnV7gGlsqkpIGl2IT4DU21w=
X-Google-Smtp-Source: ABdhPJyKTBdlwHo7oCBa1d9/K9/B91CZ/WBdqbMY3FocDtS3Kq2w6BydidBmahi8pMqCHAHDZpNGReBJ8OWS+oSKE88=
X-Received: by 2002:a5d:428a:: with SMTP id k10mr3108382wrq.4.1613635196516;
 Wed, 17 Feb 2021 23:59:56 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <CAMj6ewP-NK3g1xzHNF+fKt6M+_W-ec29Sq+CBtwcb1dcqc7dNA@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com> <mtwofibp.fsf@damenly.su>
 <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com> <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com> <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
 <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com> <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
 <c6c8cb80-455a-181b-ada5-83001d387044@gmx.com> <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
 <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com>
In-Reply-To: <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Wed, 17 Feb 2021 23:59:45 -0800
Message-ID: <CAMj6ewM2wr2tRrMjRk+sztH0nD7RG1J4tXKfoekg3-rqEL3RWA@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 11:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2021/2/18 =E4=B8=8B=E5=8D=882:59, Erik Jensen wrote:
> > On Wed, Feb 17, 2021 at 10:09 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
> >> On 2021/2/18 =E4=B8=8B=E5=8D=881:49, Erik Jensen wrote:
> >>> On Wed, Feb 17, 2021 at 9:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
> >>>> Got it now.
> >>>>
> >>>> [  295.249182] read_extent_buffer_pages: eb->start=3D26207780683776 =
mirror=3D0
> >>>> [  295.249188] __btrfs_map_block: logical=3D8615594639360 chunk
> >>>> start=3D8614760677376 len=3D4294967296 type=3D0x81
> >>>> [  295.249189] __btrfs_map_block: stripe[0] devid=3D3 phy=3D21187357=
08160
> >>>>
> >>>> Note that, the initial request is to read from 26207780683776.
> >>>> But inside btrfs_map_block(), we want to read from 8615594639360.
> >>>>
> >>>> This is totally screwed up in a unexpected way.
> >>>>
> >>>> 26207780683776 =3D 0x17d5f9754000
> >>>> 8615594639360  =3D 0x07d5f9754000
> >>>>
> >>>> See the missing leading 1, which screws up the result.
> >>>>
> >>>> The problem should be the logical calculation part, which doesn't do
> >>>> proper u64 conversion which could cause the problem.
> >>>>
> >>>> Would you like to test the single line fix below?
> >>>>
> >>>> Thanks,
> >>>> Qu
> >>>>
> >>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>>> index b8fab44394f5..69d728f5ff9e 100644
> >>>> --- a/fs/btrfs/volumes.c
> >>>> +++ b/fs/btrfs/volumes.c
> >>>> @@ -6575,7 +6575,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_inf=
o
> >>>> *fs_info, struct bio *bio,
> >>>>     {
> >>>>            struct btrfs_device *dev;
> >>>>            struct bio *first_bio =3D bio;
> >>>> -       u64 logical =3D bio->bi_iter.bi_sector << 9;
> >>>> +       u64 logical =3D ((u64)bio->bi_iter.bi_sector) << 9;
> >>>>            u64 length =3D 0;
> >>>>            u64 map_length;
> >>>>            int ret;
> >>>
> >>> So=E2=80=A6 it appears my kernel tree (Arch32's 5.10.14-arch1) alread=
y has that:
> >>>
> >>
> >> And I also noticed that since v5.2 kernel, we should already have
> >> bi_sector as u64.
> >>
> >> So why that left shift would get higher bits missing is really strange=
.
> >> Especially the missing part is just at the 45 bit, not 32 bit boundary=
.
> >>
> >> Then what about this diff? It goes multiplying other than using
> >> dangerous left shift.
> >>
> >> (Also, it's recommended to still use previous debug diffs, so if it
> >> doesn't work we still have a chance to know what's going wrong).
> >>
> >> Thanks,
> >> Qu
> >
> > No change. I added an extra debug line in btrfs_map_bio, and get the fo=
llowing:
> >
> > btrfs_map_bio: bio->bi_iter.bi_sector=3D16827333280, logical=3D86155946=
39360
> >
> > bio->bi_iter.bi_sector is 16827333280, not 51187071648, so it looks
> > like the top bit is already missing before the shift / multiplication.
> >
> Special thanks to Su, he points out that, page->index is still just
> unsigned long, which is not ensured to be 64 bits.
>
> Thus page_offset(page) can easily go wrong, which takes page->index and
> does left shift.
>
> Mind to test the following debug diff?
>
> Thanks,
> Qu
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 4dfb3ead1175..794f97d6eda7 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -6001,6 +6001,8 @@ int read_extent_buffer_pages(struct extent_buffer
> *eb, int wait, int mirror_num)
>                          }
>
>                          ClearPageError(page);
> +                       pr_info("%s: eb start=3D%llu i=3D%d page_offset=
=3D%llu\n",
> +                               __func__, eb->start, i, page_offset(page)=
);
>                          err =3D submit_extent_page(REQ_OP_READ |
> REQ_META, NULL,
>                                           page, page_offset(page),
> PAGE_SIZE, 0,
>                                           &bio, end_bio_extent_readpage,

Here's the new dmesg log:
https://gist.github.com/rkjnsn/5153682d5be865c13966d342ea7cbe9e

Relevant looking new lines:

[   52.903379] read_extent_buffer_pages: eb->start=3D26207780683776 mirror=
=3D0
[   52.903380] read_extent_buffer_pages: eb start=3D26207780683776 i=3D0
page_offset=3D8615594639360
[   52.903400] read_extent_buffer_pages: eb start=3D26207780683776 i=3D1
page_offset=3D8615594643456
[   52.903403] read_extent_buffer_pages: eb start=3D26207780683776 i=3D2
page_offset=3D8615594647552
[   52.903403] read_extent_buffer_pages: eb start=3D26207780683776 i=3D3
page_offset=3D8615594651648
