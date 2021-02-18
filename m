Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4685731E60D
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 06:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhBRFyD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 00:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhBRFtp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 00:49:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B8DC0613D6
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 21:49:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id x4so1817512wmi.3
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Feb 2021 21:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b2clD7dVTgG3UlxgJZgdqd/a8GCGFQ1f1fl1Nv+7PLY=;
        b=WXThLTJRZeTd3bpZtMcGVVXwRjYkMnaFl6QrQqS6sxLCGcSWYK/+grbsT5ErIPbLFa
         943IEvgRzC1OEZbFTBTBoTRNpXdPki4kutmvK/IdeyB8Dwr2m14agu32WNDBu3cxsU+o
         zOV2E6xSaVmTsa9eogcLfGtawrQixvfAtGvFhwBgiRu1jKkhaQPhB1mu5Z5JRGE4KgG+
         5NY2kw1G/RaO1R8Irlb+h+h5LGX9iLboA+Bo/29F6Vw4mRx3EJp35r1PDv4uqQh4iIT9
         xVFD/M/xQ9eoPNFHsTdbYGwCRXuRu/j1vMkRV8XqbU+kieTWTgKxdm73KRR8E7SWmL2m
         MgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b2clD7dVTgG3UlxgJZgdqd/a8GCGFQ1f1fl1Nv+7PLY=;
        b=Fap5300in6D9xekyZ79xl69g4g8zS9XARHxtEOtTM5HQbmXv5y39I3Us84hLreI9tj
         fMDNVIBqrBbhAPHwap3s5NB5Z+6r41pP4KWLtO7GhoFnUxIxSZBkPw5vPU5ktxw9t1fq
         7w/sGk04jR7xYQWU/YQIKUo0erOqUH3MMBmanR9hh4rl908DubRqG005NvWZwD9oOC60
         Brb3VSYhX1Lt7S+Q+6FTJkuzcSpp70xj9VK07IhOpArmhXicMYVlqu5qNQ8YPKEUME2h
         j9QsTVH/a4N5uHPi0oktBA2F06XYT47WcRgc/sNzZTg1VSxucajwA9q0Bk0MszWlGcrh
         TNgg==
X-Gm-Message-State: AOAM533OXCH3dmzYcl1x90QpEW/5+r2b/OSXcDvyWwlsZp5QEbO6Acb3
        pHOsfI8We/z9IdJt3NoJ7eOcLv/7KrTERxOrmCEETTk+pdtlrkeIPbY=
X-Google-Smtp-Source: ABdhPJyEGpRwFd9IhLEk1VQg2EGxBCk7D6EgkDBJyxiZKmmaw9vDPmcS6/96SdSbDGgsH44xrcLVOFNGvML0pUscYI8=
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr1995451wmg.12.1613627367664;
 Wed, 17 Feb 2021 21:49:27 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
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
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com> <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com>
In-Reply-To: <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Wed, 17 Feb 2021 21:49:16 -0800
Message-ID: <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 17, 2021 at 9:24 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> Got it now.
>
> [  295.249182] read_extent_buffer_pages: eb->start=3D26207780683776 mirro=
r=3D0
> [  295.249188] __btrfs_map_block: logical=3D8615594639360 chunk
> start=3D8614760677376 len=3D4294967296 type=3D0x81
> [  295.249189] __btrfs_map_block: stripe[0] devid=3D3 phy=3D2118735708160
>
> Note that, the initial request is to read from 26207780683776.
> But inside btrfs_map_block(), we want to read from 8615594639360.
>
> This is totally screwed up in a unexpected way.
>
> 26207780683776 =3D 0x17d5f9754000
> 8615594639360  =3D 0x07d5f9754000
>
> See the missing leading 1, which screws up the result.
>
> The problem should be the logical calculation part, which doesn't do
> proper u64 conversion which could cause the problem.
>
> Would you like to test the single line fix below?
>
> Thanks,
> Qu
>
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index b8fab44394f5..69d728f5ff9e 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6575,7 +6575,7 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info
> *fs_info, struct bio *bio,
>   {
>          struct btrfs_device *dev;
>          struct bio *first_bio =3D bio;
> -       u64 logical =3D bio->bi_iter.bi_sector << 9;
> +       u64 logical =3D ((u64)bio->bi_iter.bi_sector) << 9;
>          u64 length =3D 0;
>          u64 map_length;
>          int ret;

So=E2=80=A6 it appears my kernel tree (Arch32's 5.10.14-arch1) already has =
that:

blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
                           int mirror_num)
{
        struct btrfs_device *dev;
        struct bio *first_bio =3D bio;
        u64 logical =3D (u64)bio->bi_iter.bi_sector << 9;
        u64 length =3D 0;
        u64 map_length;
        int ret;
        int dev_nr;
        int total_devs;
        struct btrfs_bio *bbio =3D NULL;
