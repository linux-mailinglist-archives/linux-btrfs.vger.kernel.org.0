Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1153BA204
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Jul 2021 16:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhGBOPk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Jul 2021 10:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbhGBOPk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Jul 2021 10:15:40 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC0EC061762
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Jul 2021 07:13:08 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id d2so4707269qvh.2
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Jul 2021 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=wZJJGM8IX/ILGXZMo5Kh6q+GDuwwX1UqTGeVuBjYR0Q=;
        b=szSq4FpKzANtdL2yg15aeA/Ybr0mjZHY2FU2VQeSALGfQrNswmSrfGpVWv0JCwrT12
         3VBiSi6oQYml3bnKqw3IipCZBYvKdqCdNmrJGX5+2DynS8ILD6DwmWbR3vTdRfnKXJh+
         XjiAoWlGvJNFN/zEejX/LPnEGakmmh3ZpDcRdDrBclfL3H5AiA04NWakACrmNhJlm6cb
         E+/Ljs0KD/HaNaf8U/MwbLi9DPm6GZM2iDzWQnilAc0IDvexyt9B45Ygh2Lby3qcNJTJ
         8O9/pCqILG76aLdygeEBm9maNbLzrO8r49W2hTIhtT5ldLhGGwF9xrOjvr/7tkuw7tA9
         fG9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=wZJJGM8IX/ILGXZMo5Kh6q+GDuwwX1UqTGeVuBjYR0Q=;
        b=cml6NOyWA797H3oGQBHj0V6eIdd3IBc2Dq555xOHd7ap4c092DKOm20TYte1KX1v/7
         V4j8mQwV0tRAC1OPqKhChV+yn6l3b502uRd+AOoUXa3bk+v8TimuBICA4iXc/qFxivE+
         iH8oM0CaKYiWpR5m/b+bykee1ku8bADU31x4OHWGxSTA8Sy2a+Xjw5uR6yQgPqW1ya0c
         nXLGQ34mEiJg85r5cpeNWUd+w//EuBGnP33wST2cf/RfTy/xgj7YC/0jvV1KH0R83dF9
         0gqRGUzBmrfjNyTKDpPGovYQ3hbZdX3yL/dbaQrEmphuskX0WpunUSLIKrFKkvRtgv/E
         st0w==
X-Gm-Message-State: AOAM532m7lw7kCJmu9e+USgnvibGbvTaqRbTKkkQqrDSi7i3A04ZchYf
        ju8ZvPHGigr0NtY2bm4mMA40eWj11yXWik94VvJovD58Bhuz8A==
X-Google-Smtp-Source: ABdhPJy7UhBj4muf0GwFwj/79yaPJY99SYUMVzutlL0G0M+ecr8h388JVb/93sD+Ue0opV6Jrvk1mSnnWT1aEeqyY7c=
X-Received: by 2002:ad4:5227:: with SMTP id r7mr5459014qvq.41.1625235187242;
 Fri, 02 Jul 2021 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210702124813.29764-1-nborisov@suse.com> <PH0PR04MB741661FC90F8B379EC1E5AEA9B1F9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB741661FC90F8B379EC1E5AEA9B1F9@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 2 Jul 2021 15:12:56 +0100
Message-ID: <CAL3q7H5VFtoMkPi9aWErDcWeeWMdsY-2btzfEELrCiizk_mSZw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Make btrfs_finish_chunk_alloc private to block-group.c
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 2, 2021 at 2:21 PM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 02/07/2021 14:48, Nikolay Borisov wrote:
> > One of the final things that must be done to add a new chunk is
> > allocating its device extents and inserting them in the extent tree.
> > This is currently done in btrfs_finish_chunk_alloc whose name isn't ver=
y
> > informative. What's more this functino is only used in block-group.c bu=
                      function ~^                                 but ~^
>
> > is defined as public. There isn't anything special about it that would
> > warrant it being defined in volumes.c.
> >
> > Just move btrfs_finish_chunk_alloc and alloc_chunk_dev_extent to
> > block-group.c, make the former static and it to alloc_chunk_dev_extents=
.
>                                    rename ~^
>
>
> > The new name is a lot more explicit about the purpose of the function.

I find the new name confusing as well.

alloc_chunk_dev_extents() suggests it's allocating device extents, but
it's not, all it does is insert the device extent items into the
devices btree.
Allocation of extents happened in phase 1, through btrfs_alloc_chunk().

Thanks.

> >
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> >
> > ---
> >  fs/btrfs/block-group.c | 98 +++++++++++++++++++++++++++++++++++++++++-
> >  fs/btrfs/volumes.c     | 92 ---------------------------------------
> >  fs/btrfs/volumes.h     |  2 -
> >  3 files changed, 96 insertions(+), 96 deletions(-)
> >
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index c557327b4545..2e133ee61d83 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -2236,6 +2236,100 @@ static int insert_block_group_item(struct btrfs=
_trans_handle *trans,
> >       return btrfs_insert_item(trans, root, &key, &bgi, sizeof(bgi));
> >  }
> >
> > +
>
> double newline
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
