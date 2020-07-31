Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61B6B234433
	for <lists+linux-btrfs@lfdr.de>; Fri, 31 Jul 2020 12:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbgGaKnL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Jul 2020 06:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732431AbgGaKnK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Jul 2020 06:43:10 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F524C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 03:43:10 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q13so8568502vsn.9
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Jul 2020 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=J0suK+wYXruWpc9uuDV/cKzpFtaUjoEtO6gPFzpsJsI=;
        b=Bv3MgGcEP06IaImBJxc3F2wXoTcExVxvv0BtVE4CFjf5hxgklQWtoosT0xHBQw02uk
         NkZMf9L+wmNSNz6sjUZ3Fo5QtFfRLBJCoBtRm/6F9YwFUKx+3qBw47XHB0PpP56X0r8o
         1ThFsDq3u3BQ0sEnPIrP6W+IvBRoSyLZUYKQs1B3QwdyWEkL6HPSPrgMdv2y71STMuV4
         Me6feAbd3Wh4LVOpzB97QLKfzl/deHGpxJkDli2oGJCXqBv9bAPbWBhcKOC2OXyXRWup
         iMMVDjERcwNlZGT/+Xb0CAj4zUYLF1QTjwsLBBCEJ5UDCTnZW58r3BIRXCNynPxUyt4R
         FGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=J0suK+wYXruWpc9uuDV/cKzpFtaUjoEtO6gPFzpsJsI=;
        b=nKlg9gaUGFBitCbHy3hT3ue/xcIaM1Cc7einM+9Bd2NGS9bTWwIzdBsrVdfMpZE4HV
         zkrNaT17mo9Day2lhuuAjJiCpOzz5Yuj+MUPK0ZQOtzrhPjh/lYK8pBYu8DvwSe9eteA
         89RQDy/IhbY+urwyBN/h+jZNq8wWUwDP4Zou0ub8CLwB3PXyFFBxqHYfxwHZewkzr1ZG
         yNYBM+kJCO+Q2GxcGvrZyzd8uiH16B7itSMBJkwlLBeW+qwRpg+1L7Do9G5lOmahnZcx
         rEm39j1VkyfTO98yYMHcf99uGq2oD6Cdh80FHjv77qIPEd/lTN70ejPeMwbikruy3pEH
         nxyw==
X-Gm-Message-State: AOAM531g4SA3UKeLp3ZoeGS+vBFvopHObSRaGHxLyIR4WRB6So9Yntmz
        sqo4YnOh6Od1/PaMMNGBAwy9wj4UxKoEvjKf6U0=
X-Google-Smtp-Source: ABdhPJyoX+/LGStVQwBys31yypWy+GA79GXvGvKLYrsGw4ARkuguoCJgk3+8lxrli97mzsNKNRMVCBEZgs0jhg2LvjU=
X-Received: by 2002:a67:f5c6:: with SMTP id t6mr2597332vso.14.1596192189436;
 Fri, 31 Jul 2020 03:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200731094815.104794-1-wqu@suse.com> <CAL3q7H5NAJPs=mbuwSh3c+y5GR2+sMBiAEPcC8=P5__82LXziw@mail.gmail.com>
 <9b441c78-b919-dbe6-0fab-a89c6d011703@suse.com> <36a8de60-9f22-8bbf-39fe-e582afa448b0@suse.com>
In-Reply-To: <36a8de60-9f22-8bbf-39fe-e582afa448b0@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Fri, 31 Jul 2020 11:42:58 +0100
Message-ID: <CAL3q7H4hn2YUNK48x8m34qmwMdBOkqnn6jxepHQ0106RjXnSmQ@mail.gmail.com>
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

On Fri, Jul 31, 2020 at 11:38 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2020/7/31 =E4=B8=8B=E5=8D=886:20, Qu Wenruo wrote:
> >
> >
> > On 2020/7/31 =E4=B8=8B=E5=8D=886:05, Filipe Manana wrote:
> >> On Fri, Jul 31, 2020 at 10:49 AM Qu Wenruo <wqu@suse.com> wrote:
> >>>
> >>> [BUG]
> >>> The following script can lead to tons of beyond device boundary acces=
s:
> >>>
> >>>   mkfs.btrfs -f $dev -b 10G
> >>>   mount $dev $mnt
> >>>   trimfs $mnt
> >>>   btrfs filesystem resize 1:-1G $mnt
> >>>   trimfs $mnt
> >>>
> >>> [CAUSE]
> >>> Since commit 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to
> >>> find_first_clear_extent_bit"), we try to avoid trimming ranges that's
> >>> already trimmed.
> >>>
> >>> So we check device->alloc_state by finding the first range which does=
n't
> >>> have CHUNK_TRIMMED and CHUNK_ALLOCATED not set.
> >>>
> >>> But if we shrunk the device, that bits are not cleared, thus we could
> >>> easily got a range starts beyond the shrunk device size.
> >>>
> >>> This results the returned @start and @end are all beyond device size,
> >>> then we call "end =3D min(end, device->total_bytes -1);" making @end
> >>> smaller than device size.
> >>>
> >>> Then finally we goes "len =3D end - start + 1", totally underflow the
> >>> result, and lead to the beyond-device-boundary access.
> >>>
> >>> [FIX]
> >>> This patch will fix the problem in two ways:
> >>> - Clear CHUNK_TRIMMED | CHUNK_ALLOCATED bits when shrinking device
> >>>   This is the root fix
> >>>
> >>> - Add extra safe net when trimming free device extents
> >>>   We check and warn if the returned range is already beyond current
> >>>   device.
> >>>
> >>> Link: https://github.com/kdave/btrfs-progs/issues/282
> >>> Fixes: 929be17a9b49 ("btrfs: Switch btrfs_trim_free_extents to find_f=
irst_clear_extent_bit")
> >>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >>> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >>> ---
> >>> Changelog:
> >>> v2:
> >>> - Add proper fixes tag
> >>> - Add extra warning for beyond device end case
> >>> - Add graceful exit for already trimmed case
> >>> v3:
> >>> - Don't return EUCLEAN for beyond boundary access
> >>> - Rephrase the warning message for beyond boundary access
> >>> ---
> >>>  fs/btrfs/extent-tree.c | 21 +++++++++++++++++++++
> >>>  fs/btrfs/volumes.c     | 12 ++++++++++++
> >>>  2 files changed, 33 insertions(+)
> >>>
> >>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> >>> index fa7d83051587..7c5e0961c93b 100644
> >>> --- a/fs/btrfs/extent-tree.c
> >>> +++ b/fs/btrfs/extent-tree.c
> >>> @@ -33,6 +33,7 @@
> >>>  #include "delalloc-space.h"
> >>>  #include "block-group.h"
> >>>  #include "discard.h"
> >>> +#include "rcu-string.h"
> >>>
> >>>  #undef SCRAMBLE_DELAYED_REFS
> >>>
> >>> @@ -5669,6 +5670,26 @@ static int btrfs_trim_free_extents(struct btrf=
s_device *device, u64 *trimmed)
> >>>                                             &start, &end,
> >>>                                             CHUNK_TRIMMED | CHUNK_ALL=
OCATED);
> >>>
> >>> +               /* CHUNK_* bits not cleared properly */
> >>> +               if (start > device->total_bytes) {
> >>> +                       WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> >>> +                       btrfs_warn_in_rcu(fs_info,
> >>> +"ignoring attempt to trim beyond device size: offset %llu length %ll=
u device %s device size %llu",
> >>> +                                         start, end - start + 1,
> >>> +                                         rcu_str_deref(device->name)=
,
> >>> +                                         device->total_bytes);
> >>> +                       mutex_unlock(&fs_info->chunk_mutex);
> >>> +                       ret =3D 0;
> >>> +                       break;
> >>> +               }
> >>> +
> >>> +               /* The remaining part has already been trimmed */
> >>> +               if (start =3D=3D device->total_bytes) {
> >>> +                       mutex_unlock(&fs_info->chunk_mutex);
> >>> +                       ret =3D 0;
> >>> +                       break;
> >>> +               }
> >>
> >> Sorry I missed this earlier, but why is this a special case? Couldn't
> >> this be merged into the previous check?
> >> Why is an offset matching the ending of the device not considered unex=
pected?
> >
> > For such example:
> >               0               1g              2g
> > device 1:     |///////////////|               |
> > |//| =3D Allocated space
> > |  | =3D Free space.
> >
> > After one fstrim, [1G, 2G) get trimmed.
> > So in the alloc_state we have
> >               0               1G              2G
> > device 1:     |               |***************|
> > |**| =3D CHUNK_TRIMMED bits set
> >
> > Here we just focus on the unallocated space, ignoring the block group p=
arts.
> >
> > Then we run fstrim again.
> > We call find_first_clear_extent_bit(start =3D=3D 1G), then we got the r=
esult
> > start =3D=3D 2G, end =3D U64_MAX.
> >
> > In that case, we got start =3D=3D device->total_bytes, and it's complet=
ely
> > valid.
>
> Sorry, although this is correct, it's duplicated with the later checks:
>
>                 end =3D min(end, device->total_bytes - 1);
>
>                 len =3D end - start + 1;
>
>                 /* We didn't find any extents */
>                 if (!len) {
>                         mutex_unlock(&fs_info->chunk_mutex);
>                         ret =3D 0;
>                         break;
>                 }
>
> If we got a returned start =3D=3D device->total_bytes, then here we would
> hit len =3D=3D 0, and exit.
>
> So my (start =3D=3D device->total_bytes) is duplicated.
>
> I guess the existing one is easier to understand, thus my extra check
> should be removed.

Hit reply too soon before seeing this reply. Yes, it seems correct to
me as well.

Thanks.

>
> Thanks,
> Qu
>
> >
> >>
> >> I also don't understand the comment, what is the remaining part?
> >
> > The remaining means the unallocated space from the @start of
> > find_first_clear_extent_bit().
> >
> > Any better suggestion?
> >
> > Thanks,
> > Qu
> >
> >>
> >> Thanks.
> >>
> >>> +
> >>>                 /* Ensure we skip the reserved area in the first 1M *=
/
> >>>                 start =3D max_t(u64, start, SZ_1M);
> >>>
> >>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >>> index d7670e2a9f39..4e51ef68ea72 100644
> >>> --- a/fs/btrfs/volumes.c
> >>> +++ b/fs/btrfs/volumes.c
> >>> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *d=
evice, u64 new_size)
> >>>         }
> >>>
> >>>         mutex_lock(&fs_info->chunk_mutex);
> >>> +       /*
> >>> +        * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyo=
nd the
> >>> +        * current device boundary.
> >>> +        * This shouldn't fail, as alloc_state should only utilize th=
ose two
> >>> +        * bits, thus we shouldn't alloc new memory for clearing the =
status.
> >>> +        *
> >>> +        * So here we just do an ASSERT() to catch future behavior ch=
ange.
> >>> +        */
> >>> +       ret =3D clear_extent_bits(&device->alloc_state, new_size, (u6=
4)-1,
> >>> +                               CHUNK_TRIMMED | CHUNK_ALLOCATED);
> >>> +       ASSERT(!ret);
> >>> +
> >>>         btrfs_device_set_disk_total_bytes(device, new_size);
> >>>         if (list_empty(&device->post_commit_list))
> >>>                 list_add_tail(&device->post_commit_list,
> >>> --
> >>> 2.28.0
> >>>
> >>
> >>
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
