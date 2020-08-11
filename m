Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2A2419A2
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 12:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgHKKYn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 06:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728378AbgHKKYm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 06:24:42 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ECAC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 03:24:42 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id b26so5699069vsa.13
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 03:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=icW+PHrXRojPM1KykIIauxgGBCV4SL2HCHCrAnQGwQM=;
        b=hgACvuBAbI8KzCYbqW5qiJP86z+x+aCVIscYa7gAlMqyDn+RxvjGibkEyovUrWEXCw
         3XI4RbOTEQGerfkIVFUCuRVwqMBYB3MUmWsWGAWtr/JUQM2qMjT+CuK7GfywktBqyLf7
         T+4fz+uBbuJuSUY2RnPKicK7HZWAd+HVVT3SIRj5REbi4skotoW5Fg2coRv99WJavuxD
         I3/ETl5+PbfCcY76r26B6zA+JACWe+0TuEWZSdBdHj8LV9lgT5lyKZYLP0fEMbKRHqyd
         6EPXMevkYl5PeR4gLb7j9FU0U+SP54o55UQ/TanwOwfk4+6fs5/ljzdsvfkq5NVgvv1j
         8cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=icW+PHrXRojPM1KykIIauxgGBCV4SL2HCHCrAnQGwQM=;
        b=Epu6Eh6djW5CWrEcOGqgzKv55gbCKpPTx0XMHGCGF5AubP7P+96GwxA46MnRWStm33
         5v01DRaBscdA7JdLNQpzsJ+DceaQP4SqzvFAgMYFI2vTGKhLrNfzjomR2IE1mfaJiL9T
         EptjQQcQHINm4//O9MjJIiLLVs+fZYd/4bXyMJKzLqtbc+YRtCNy20mTmvrZOGc659P9
         EJsq7f8try27E1X7Ca8YDRvBApSz0ZWkhP55KcaUzqpFw3LcTwIecP5AG8I2IiuWtV/M
         7nfwB7zDQRVVjosejy98akdkypf5107WhPPXO+3zgmjSJuzGaYu1Q/m7h+pIN0FKZNOF
         CRJQ==
X-Gm-Message-State: AOAM530BSbMSxkA7xsMxHc0qLmQc2vgj2efNOhsdqRoJRG9ufmydtbaJ
        wrXRTr3OnknSSEbwmQzxrqUHIJ2r1v0kLsWS618=
X-Google-Smtp-Source: ABdhPJzAqQmYoFQKgdQuVPlQEc6Cqk9sgSTvdUg3tok4un8ZD/e+/GbS//i6bZh9wutHIfX4RG1Q9+gGjaDsSkVz2wM=
X-Received: by 2002:a67:e40a:: with SMTP id d10mr21630024vsf.95.1597141480190;
 Tue, 11 Aug 2020 03:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200731112911.115665-1-wqu@suse.com> <5cda2c95-e407-8b11-e206-20c4aac5d48b@suse.com>
 <269982fa-0174-5816-3a23-37912737abc9@suse.com>
In-Reply-To: <269982fa-0174-5816-3a23-37912737abc9@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 11 Aug 2020 11:24:29 +0100
Message-ID: <CAL3q7H7pKrurKVafXQ3+AsHtkWGEKdGa9NiyO_HBUy1MyzJFEw@mail.gmail.com>
Subject: Re: [PATCH v4] btrfs: trim: fix underflow in trim length to prevent
 access beyond device boundary
To:     Qu Wenruo <wqu@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Aug 11, 2020 at 9:48 AM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2020/8/11 =E4=B8=8B=E5=8D=884:41, Nikolay Borisov wrote:
> >
> >
> > On 31.07.20 =D0=B3. 14:29 =D1=87., Qu Wenruo wrote:
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
> >> v4:
> >> - Remove one duplicated check on exiting the trim loop
> >> ---
> >>  fs/btrfs/extent-tree.c | 14 ++++++++++++++
> >>  fs/btrfs/volumes.c     | 12 ++++++++++++
> >>  2 files changed, 26 insertions(+)
> >>
> >> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> >> index fa7d83051587..6b1b5dfba4b3 100644
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
> >> @@ -5669,6 +5670,19 @@ static int btrfs_trim_free_extents(struct btrfs=
_device *device, u64 *trimmed)
> >>                                          &start, &end,
> >>                                          CHUNK_TRIMMED | CHUNK_ALLOCAT=
ED);
> >>
> >> +            /* CHUNK_* bits not cleared properly */
> >> +            if (start > device->total_bytes) {
> >> +                    WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> >> +                    btrfs_warn_in_rcu(fs_info,
> >> +"ignoring attempt to trim beyond device size: offset %llu length %llu=
 device %s device size %llu",
> >> +                                      start, end - start + 1,
> >> +                                      rcu_str_deref(device->name),
> >> +                                      device->total_bytes);
> >> +                    mutex_unlock(&fs_info->chunk_mutex);
> >> +                    ret =3D 0;
> >> +                    break;
> >> +            }
> >
> > Isn't this a NOOP, because the latter chunk ensures we can never cross
> > device->total_bytes. Since this is a purely defensive mechanism and
> > following this patch we *should* never have CHUNK_* bits set beyond
> > device->total_bytes I'd say make this an ASSERT(). Otherwise you force
> > people to pay the cost of the check for every trim ...
>
> I'm fine with the ASSERT() idea.
>
> But on the other hand, we really don't know how things can go wrong, and
> such graceful exit makes us way easier to expose and fix bugs when it
> happens in a production system.
>
> So currently I'm 50-50 on change it to ASSERT().

Typical non-debug kernels provided by at least some distros (looking
at debian) don't have btrfs asserts enabled by default.
So such a type of bug can lead to losing any data a user might have
stored beyond the new size boundary.
And if they are enabled, it results in a crash / BUG_ON(). So I'm
strongly for the warning and skipping trim requests beyond the fs
size.

Thanks.

>
> Thanks,
> Qu
>
> >
> >
> >> +
> >>              /* Ensure we skip the reserved area in the first 1M */
> >>              start =3D max_t(u64, start, SZ_1M);
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index d7670e2a9f39..4e51ef68ea72 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -4720,6 +4720,18 @@ int btrfs_shrink_device(struct btrfs_device *de=
vice, u64 new_size)
> >>      }
> >>
> >>      mutex_lock(&fs_info->chunk_mutex);
> >> +    /*
> >> +     * Also clear any CHUNK_TRIMMED and CHUNK_ALLOCATED bits beyond t=
he
> >> +     * current device boundary.
> >> +     * This shouldn't fail, as alloc_state should only utilize those =
two
> >> +     * bits, thus we shouldn't alloc new memory for clearing the stat=
us.
> >> +     *
> >> +     * So here we just do an ASSERT() to catch future behavior change=
.
> >> +     */
> >> +    ret =3D clear_extent_bits(&device->alloc_state, new_size, (u64)-1=
,
> >> +                            CHUNK_TRIMMED | CHUNK_ALLOCATED);
> >> +    ASSERT(!ret);
> >
> > I agree with this part.
> >
> >> +
> >>      btrfs_device_set_disk_total_bytes(device, new_size);
> >>      if (list_empty(&device->post_commit_list))
> >>              list_add_tail(&device->post_commit_list,
> >>
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
