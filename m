Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CC7234429
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 12:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732576AbgGaKkn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 06:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732524AbgGaKkm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 06:40:42 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0D5C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 03:40:42 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id x19so3440972uap.11
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 03:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PomCWO1NZj5dGpKu6X1jzn/jWaZkoxUjlzsMs4hxKF0=;
        b=BKyENyf5HZHq6MlqoybB+J54Mo1cTHdX+lovBfjAXgwjmLX8RBLJROkEPgJfOApgiz
         5e2uWjIdcUmcpd9/xtaKghiOaX3U+qZcISAFesyMCMFmRg65CZqzaHuUhxxuLgtTx6/M
         SUWdg2zcjp+j5JCeV+W29oBkNnS/gRduLLA/+McJ520cXpCaPlFxe65qNvFkJx8odgz0
         99xryhLk3uJJmvC5tNDlM6pd/P8FOkWEg1iNyMIgjqjbV8PEii5HIIcK3cskwEjxGiZ0
         qJLAalwGkbX1WqM1E+xM6RJIYgwaDvrP5MZeIU7Blw+WjSOQDwh66uMpWkHq+/JAIuIf
         0msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PomCWO1NZj5dGpKu6X1jzn/jWaZkoxUjlzsMs4hxKF0=;
        b=p3QSd7OTh+9CGdiVUkoeUuEKTB1AAgRtVjpy9kJrDL6r46M+za9gdFtXh9CFa7juKG
         7fpix2j2w0X7EzDWw+iKWmMPSff8IX1afRwx3L8E1FHf8xr6+zdtySYvNc+cbSp6FSNA
         aPrF4Gb+dSk1fZIVarfQQyG2fjSR78elfXuaUVlOeWihfmwQDLnlVT5kn01CQskCjH7o
         8muZrO8D9s/lBCuu8JSXuW6BUwJEcf0muB6phQrHKule1Nj4zkQEUzZXK+RHJfZI8ei6
         B9/utjJ33ooi0ZPHdG96I5nQfa5wCMNFNTwrr9pcBYLQ8UFARYfodw+6VzcAZkr4NKtB
         EehA==
X-Gm-Message-State: AOAM531tV5qnCPHKp4Bi46Wy8hSer8QRPakynWuEnjrSf/knU0TOt+Gk
        pZrFxuO28ncUSIZIAXwC9cWEnbeMfGk1OX1MaObL3Q==
X-Google-Smtp-Source: ABdhPJyknDLCjZ94q8ARTh0tMwrMowAHsWx+3blq++/JDErzMOoknjPBBKp55KbzngEfQHKbaQTEzzW9EHQ/6vwQ7/A=
X-Received: by 2002:ab0:76d2:: with SMTP id w18mr2048234uaq.27.1596192041703;
 Fri, 31 Jul 2020 03:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200731094815.104794-1-wqu@suse.com> <CAL3q7H5NAJPs=mbuwSh3c+y5GR2+sMBiAEPcC8=P5__82LXziw@mail.gmail.com>
 <9b441c78-b919-dbe6-0fab-a89c6d011703@suse.com>
In-Reply-To: <9b441c78-b919-dbe6-0fab-a89c6d011703@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 31 Jul 2020 11:40:30 +0100
Message-ID: <CAL3q7H4asjD-9Vq-MtsJ+q3EHU9RBuF_nv1tVRQXMExGnSRbDA@mail.gmail.com>
Subject: Re: [PATCH v3] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 31, 2020 at 11:21 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2020/7/31 =E4=B8=8B=E5=8D=886:05, Filipe Manana wrote:
> > On Fri, Jul 31, 2020 at 10:49 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> The following script can lead to tons of beyond device boundary access=
:
> >>
> >>   mkfs.btrfs -f $dev -b 10G
> >>   mount $dev $mnt
> >>   trimfs $mnt
> >>   btrfs filesystem resize 1:-1G $mnt
> >>   trimfs $mnt
> >>
> >> [CAUSE]
> >> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
> >> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
> >> already trimmed.
> >>
> >> So we check device->alloc_state by finding the first range which doesn=
't
> >> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
> >>
> >> But if we shrunk the device, that bits are not cleared, thus we could
> >> easily got a range starts beyond the shrunk device size.
> >>
> >> This results the returned @start and @end are all beyond device size,
> >> then we call "end =3D min(end, device->total_bytes -1);" making @end
> >> smaller than device size.
> >>
> >> Then finally we goes "len =3D end - start + 1", totally underflow the
> >> result, and lead to the beyond-device-boundary access.
> >>
> >> [FIX]
> >> This patch will fix the problem in two ways:
> >> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
> >>   This is the root fix
> >>
> >> - Add extra safe net when trimming free device extents
> >>   We check and warn if the returned range is already beyond current
> >>   device.
> >>
> >> Link: https://github.com/kdave/btrfs-progs/issues/282
> >> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_fi=
rst_clear_extent_bit")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Add proper fixes tag
> >> - Add extra warning for beyond device end case
> >> - Add graceful exit for already trimmed case
> >> v3:
> >> - Don't return EUCLEAN for beyond boundary access
> >> - Rephrase the warning message for beyond boundary access
> >> ---
> >>  fs/btrfs/extent-tree.c | 21 +++++++++++++++++++++
> >>  fs/btrfs/volumes.c     | 12 ++++++++++++
> >>  2 files changed, 33 insertions(+)
> >>
> >> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> >> index fa7d83051587..7c5e0961c93b 100644
> >> --- a/fs/btrfs/extent-tree.c
> >> +++ b/fs/btrfs/extent-tree.c
> >> @@ -33,6 +33,7 @@
> >>  #include "delalloc-space.h"
> >>  #include "block-group.h"
> >>  #include "discard.h"
> >> +#include "rcu-string.h"
> >>
> >>  #undef SCRAMBLE_DELAYED_REFS
> >>
> >> @@ -5669,6 +5670,26 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device, u64 *trimmed)
> >>                                             &start, &end,
> >>                                             CHUNK_TRIMMED | CHUNK_ALLO=
CATED);
> >>
> >> +               /* CHUNK_* bits not cleared properly */
> >> +               if (start > device->total_bytes) {
> >> +                       WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> >> +                       btrfs_warn_in_rcu(fs_info,
> >> +"ignoring attempt to trim beyond device size: offset %llu length %llu=
 device %s device size %llu",
> >> +                                         start, end - start + 1,
> >> +                                         rcu_str_deref(device->name),
> >> +                                         device->total_bytes);
> >> +                       mutex_unlock(&fs_info->chunk_mutex);
> >> +                       ret =3D 0;
> >> +                       break;
> >> +               }
> >> +
> >> +               /* The remaining part has already been trimmed */
> >> +               if (start =3D=3D device->total_bytes) {
> >> +                       mutex_unlock(&fs_info->chunk_mutex);
> >> +                       ret =3D 0;
> >> +                       break;
> >> +               }
> >
> > Sorry I missed this earlier, but why is this a special case? Couldn't
> > this be merged into the previous check?
> > Why is an offset matching the ending of the device not considered unexp=
ected?
>
> For such example:
>                 0               1g              2g
> device 1:       |///////////////|               |
> |//| =3D Allocated space
> |  | =3D Free space.
>
> After one fstrim, [1G, 2G) get trimmed.
> So in the alloc_state we have
>                 0               1G              2G
> device 1:       |               |***************|
> |**| =3D CHUNK_TRIMMED bits set
>
> Here we just focus on the unallocated space, ignoring the block group par=
ts.
>
> Then we run fstrim again.
> We call find_first_clear_extent_bit(start =3D=3D 1G), then we got the res=
ult
> start =3D=3D 2G, end =3D U64_MAX.
>
> In that case, we got start =3D=3D device->total_bytes, and it's completel=
y
> valid.

Ok. But this can happen without shrinking the device before, and it
seems we already handle it, or is the existing handling buggy?
If it is, it should be replaced or updated.

Thanks.

>
> >
> > I also don't understand the comment, what is the remaining part?
>
> The remaining means the unallocated space from the @start of
> find_first_clear_extent_bit().
>
> Any better suggestion?
>
> Thanks,
> Qu
>
> >
> > Thanks.
> >
> >> +
> >>                 /* Ensure we skip the reserved area in the first 1M */
> >>                 start =3D max_t(u64, start, SZ_1M);
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index d7670e2a9f39..4e51ef68ea72 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *de=
vice, u64 new_size)
> >>         }
> >>
> >>         mutex_lock(&fs_info->chunk_mutex);
> >> +       /*
> >> +        * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyon=
d the
> >> +        * current device boundary.
> >> +        * This shouldn't fail, as alloc_state should only utilize tho=
se two
> >> +        * bits, thus we shouldn't alloc new memory for clearing the s=
tatus.
> >> +        *
> >> +        * So here we just do an ASSERT() to catch future behavior cha=
nge.
> >> +        */
> >> +       ret =3D clear_extent_bits(&device->alloc_state, new_size, (u64=
)-1,
> >> +                               CHUNK_TRIMMED | CHUNK_ALLOCATED);
> >> +       ASSERT(!ret);
> >> +
> >>         btrfs_device_set_disk_total_bytes(device, new_size);
> >>         if (list_empty(&device->post_commit_list))
> >>                 list_add_tail(&device->post_commit_list,
> >> --
> >> 2.28.0
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
