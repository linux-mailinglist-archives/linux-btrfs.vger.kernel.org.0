Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2280C31E6FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 08:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhBRHcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 02:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhBRH1H (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 02:27:07 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C494C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 23:25:50 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b3so1679162wrj.5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 23:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=89glf+L/nDcCPzx8ixY7rvLeQR9/9JKUt+ZdbANoHlk=;
        b=miOoQoF9KX2bS/3G2m0nZ0rftbQRN7YTog5qXocdD1tNLJ4E12nBBPwvwyHUd4E6y/
         zuNRwg/ziw66R/2pNkeYGOLdq0cMAQYmHSwKg+T4lrDrFGeQw3LViTTY4i8vU05NnJkj
         FcdGARHRyTqFDUq2ELmpFDxLDwqtXN0XHJmz2rHHmnVkGzHCrTWPSGgfzUnznfogA7vD
         xbl7P0U/LKMt+XlRSn5nWbEbv/McMJSqonEWFkNcODY9XQIMeCnkku/f2PBaLdCRTYal
         olJlT5ye1Dvyij5jH6kMynWfaPo8jimSyPPQUuU7XI0/JI4DZd+4Aa7tsGoEP0ZPhWkA
         E2uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=89glf+L/nDcCPzx8ixY7rvLeQR9/9JKUt+ZdbANoHlk=;
        b=UzMchZqMX47BqyRQklaDSvfdp414NLWziSvptXI0g5dZS+7KmxtgVJvSSTnTHwi6FZ
         1Q8BAuQ41KFeIILI1k003HNU3pXOhKX7DvBc+0UbGl+8fNy0J9MOiy8cKcyZE8WrXzSL
         S63YqdGgOl5BpqYvj9gMPYmPjdOkIF97l2wzg7Y/LGewSeyXIMk845Aq4t36QNTtTIac
         Wj9dDyZQn/8xfY08ZTFtKVW6JQTKPXk43OZho7PtavOQ4CM8kff/WPtaFok5JjJj6edM
         hr/r4uu0ThN7DGcTIU5l6l3tKWrvnooO/On7TTUr4Ps1ivnL1Q4gA8lBzR4ywWOiEEy0
         n6zA==
X-Gm-Message-State: AOAM530Gpx8njwbedRS8LWdHvV6+2MAX3Z/0ZEILKD82L99a6C5Fr397
        1bLUID5QhB7IiNkpX2SQsYvzimSgNmQcOdw5yPS8cg==
X-Google-Smtp-Source: ABdhPJwPmQ9QyrAoeSEIEFA3L6FxVQhGPjgU0PIdtlv58WFwTRIeKJC90bKso5GMw9uq+M51KxGPsUpGUYtB5jnML5Q=
X-Received: by 2002:adf:f00b:: with SMTP id j11mr2887233wro.229.1613633148722;
 Wed, 17 Feb 2021 23:25:48 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <2abb2701-5dde-cd5d-dd25-084682313b11@gmx.com> <b2bbff7d-22d0-84c2-7749-ac9e27d4ab3d@gmx.com>
 <CAMj6ewOqCJTGjykDijun9_LWYELA=92HrE+KjGo-ehJTutR_+w@mail.gmail.com>
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
In-Reply-To: <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Wed, 17 Feb 2021 23:25:37 -0800
Message-ID: <CAMj6ewMRJ2bsGg7xnHR3h+fZ_UFHVb3DVhBBFcTX4D-7=SP=Eg@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 10:59 PM Erik Jensen <erikjensen@rkjnsn.net> wrote:
> On Wed, Feb 17, 2021 at 10:09 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
> > On 2021/2/18 =E4=B8=8B=E5=8D=881:49, Erik Jensen wrote:
> > > On Wed, Feb 17, 2021 at 9:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wr=
ote:
> > >> Got it now.
> > >>
> > >> [  295.249182] read_extent_buffer_pages: eb->start=3D26207780683776 =
mirror=3D0
> > >> [  295.249188] __btrfs_map_block: logical=3D8615594639360 chunk
> > >> start=3D8614760677376 len=3D4294967296 type=3D0x81
> > >> [  295.249189] __btrfs_map_block: stripe[0] devid=3D3 phy=3D21187357=
08160
> > >>
> > >> Note that, the initial request is to read from 26207780683776.
> > >> But inside btrfs_map_block(), we want to read from 8615594639360.
> > >>
> > >> This is totally screwed up in a unexpected way.
> > >>
> > >> 26207780683776 =3D 0x17d5f9754000
> > >> 8615594639360  =3D 0x07d5f9754000
> > >>
> > >> See the missing leading 1, which screws up the result.
> > >>
> > >> The problem should be the logical calculation part, which doesn't do
> > >> proper u64 conversion which could cause the problem.
> > >>
> > >> Would you like to test the single line fix below?
> > >>
> > >> Thanks,
> > >> Qu
> > >>
> > >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > >> index b8fab44394f5..69d728f5ff9e 100644
> > >> --- a/fs/btrfs/volumes.c
> > >> +++ b/fs/btrfs/volumes.c
> > >> @@ -6575,7 +6575,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_inf=
o
> > >> *fs_info, struct bio *bio,
> > >>    {
> > >>           struct btrfs_device *dev;
> > >>           struct bio *first_bio =3D bio;
> > >> -       u64 logical =3D bio->bi_iter.bi_sector << 9;
> > >> +       u64 logical =3D ((u64)bio->bi_iter.bi_sector) << 9;
> > >>           u64 length =3D 0;
> > >>           u64 map_length;
> > >>           int ret;
> > >
> > > So=E2=80=A6 it appears my kernel tree (Arch32's 5.10.14-arch1) alread=
y has that:
> > >
> >
> > And I also noticed that since v5.2 kernel, we should already have
> > bi_sector as u64.
> >
> > So why that left shift would get higher bits missing is really strange.
> > Especially the missing part is just at the 45 bit, not 32 bit boundary.
> >
> > Then what about this diff? It goes multiplying other than using
> > dangerous left shift.
> >
> > (Also, it's recommended to still use previous debug diffs, so if it
> > doesn't work we still have a chance to know what's going wrong).
> >
> > Thanks,
> > Qu
>
> No change. I added an extra debug line in btrfs_map_bio, and get the foll=
owing:
>
> btrfs_map_bio: bio->bi_iter.bi_sector=3D16827333280, logical=3D8615594639=
360
>
> bio->bi_iter.bi_sector is 16827333280, not 51187071648, so it looks
> like the top bit is already missing before the shift / multiplication.

Possibly relevant observation: if you take 26207780683776 and divide
it by 4096, you get 6398383956, which is a 33 bit number. If you
truncate that to 32 bits, and then multiply by 4096, you get
8615594639360. Not sure if 4096 would be relevant here because it's
the kernel page size, because the block device has a 4096 sector size
(both physical and logical), something else, or if it's a read
herring.
