Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 918A4E16C8
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 11:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390958AbfJWJ4O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 05:56:14 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41674 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390938AbfJWJ4N (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 05:56:13 -0400
Received: by mail-vs1-f66.google.com with SMTP id l2so13354981vsr.8
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 02:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=RY3FTVDlQrGEpX5dxJYXb8LhWRadtAQbl2QoQN1IjIY=;
        b=YYcAN3i83rsuyKB3Fb13Ls88ioVs8TUth7+tcgLFh9v5pCUHmHuLVWvASlMk2Lp5ES
         teBAuTBjqanNd0jjIXgnUTzApC3cQuVSeo8WDMG0MnEi1yPRt1wfc5colVlpq5hYpUwH
         qBYrYBwQIGxwQsaIx5KDhaencCuthL4Pi1PeshEia0Dpo5Y7rW999N3RTqUfQjI8yXWe
         KSU4xnNP7Cj6gKvjKOrP6puMeDtTTS+RMvLeTOdfdYuhlv9GIKpA7db9BTmYgsD5C09n
         WB9P6eK2/wHENyHgVr32Ff5KAcZJqlLOr1ucQ2/+ihfMcAZuyHvbaqPTjlalqkifr+Tw
         be8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=RY3FTVDlQrGEpX5dxJYXb8LhWRadtAQbl2QoQN1IjIY=;
        b=FzmzxyUssEoWDO9GaYQIViQlnIPdYwT/kAa0db6ag+496ivgGbTNh0QdH2zKWBpuVX
         dzyc/AOooW2bmYCc71ps48VSc2lsWX182kxtcm/CZn46IpV7oKR/AKs9QrIPPWaVbcC+
         2kfccfqwMDhDX2+/R/ZUgQgawsq9MIYIy6tkzCwUUjz0dwog9e3YzEAvFqgwFeva5fhp
         2+51OKL5cdvQPwnxxE8ooDi2dCq9FM6VlLWuyHnuSHoXEsoYRu/6rH7qFge7l3cdwf1k
         A2QZz3mxH/HzpQDIQlsfgoHjmD3fT2fCSZmw2T2lzjExIfe/BQ/ZFHPMBdzwUdkwmyc9
         vNtQ==
X-Gm-Message-State: APjAAAUrOqHJqEAJDHuZEDQj9+GX9QYRz92Jm0TjKqrkE78aJgQ4P8+J
        ylMCQSL6oOWFyo1LPUemuOPDdbAdLI2exzTjtfPfyA==
X-Google-Smtp-Source: APXvYqxnM42hZHt9cnfaGlo/+MOYnMeocLKQpFSI73jiFGpO3njj0HX08jqtD+gwQOgPrCKF/czS8SqBY5tAeGVxBXA=
X-Received: by 2002:a67:fe8f:: with SMTP id b15mr3412097vsr.90.1571824572319;
 Wed, 23 Oct 2019 02:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20191023085037.14838-1-wqu@suse.com> <20191023085037.14838-2-wqu@suse.com>
 <CAL3q7H5V0fapMLnznQhHuG8f1myhAdiy42WsUFr-6ryjV7orEQ@mail.gmail.com> <f1c6306c-fc02-1713-589a-bba9a63c25d8@gmx.com>
In-Reply-To: <f1c6306c-fc02-1713-589a-bba9a63c25d8@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 23 Oct 2019 10:56:01 +0100
Message-ID: <CAL3q7H4jYao3bNVzVZvUk54Y2-9-PRKBD=pwUk4Vo1OFK5PWvQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] btrfs: volumes: Return the mapped length for discard
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 23, 2019 at 10:51 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/10/23 =E4=B8=8B=E5=8D=885:47, Filipe Manana wrote:
> > On Wed, Oct 23, 2019 at 9:53 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >
> > Hi Qu,
> >
> >> For btrfs_map_block(), if we pass @op =3D=3D BTRFS_MAP_DISCARD, the @l=
ength
> >> parameter will not be updated to reflect the real mapped length.
> >>
> >> This means for discard operation, we won't know how many bytes are
> >> really mapped.
> >
> > Ok, and what's the consequence? The changelog should really say what
> > is the problem, what the bug is.
> > The cover letter and the second patch explain what problems are being
> > solved, but not this change.
>
> The problem is, no consequence at all, until the 2nd patch is taken in
> to consideration.
>
> This patch itself doesn't make any sense, just a plain dependency for
> the 2nd patch.
>
> I guess it's better to fold these two patches into one patch?

I wouldn't mind about that.
Or, if you keep them separate, just mention in the changelog that it's
used by another change to fix the problem of a range spanning two or
more block groups getting partially trimmed only.

Thanks.

>
> >
> >>
> >> Fix this by changing assigning the mapped range length to @length
> >> pointer, so btrfs_map_block() for BTRFS_MAP_DISCARD also return mapped
> >> length.
> >>
> >> During the change, also do a minor modification to make the length
> >> calculation a little more straightforward.
> >> Instead of previously calculated @offset, use "em->end - bytenr" to
> >> calculate the actually mapped length.
> >
> > I really don't like much mixing a cleanup with a fix. I would prefer
> > two separate patches, no matter how small or trivial it is.
>
> Sure.
>
> Thanks,
> Qu
>
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >
> > Other than that, it looks good to me.
> > Thanks.
> >
> >> ---
> >>  fs/btrfs/volumes.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> >> index cdd7af424033..f66bd0d03f44 100644
> >> --- a/fs/btrfs/volumes.c
> >> +++ b/fs/btrfs/volumes.c
> >> @@ -5578,12 +5578,13 @@ void btrfs_put_bbio(struct btrfs_bio *bbio)
> >>   * replace.
> >>   */
> >>  static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_inf=
o,
> >> -                                        u64 logical, u64 length,
> >> +                                        u64 logical, u64 *length_ret,
> >>                                          struct btrfs_bio **bbio_ret)
> >>  {
> >>         struct extent_map *em;
> >>         struct map_lookup *map;
> >>         struct btrfs_bio *bbio;
> >> +       u64 length =3D *length_ret;
> >>         u64 offset;
> >>         u64 stripe_nr;
> >>         u64 stripe_nr_end;
> >> @@ -5616,7 +5617,8 @@ static int __btrfs_map_block_for_discard(struct =
btrfs_fs_info *fs_info,
> >>         }
> >>
> >>         offset =3D logical - em->start;
> >> -       length =3D min_t(u64, em->len - offset, length);
> >> +       length =3D min_t(u64, em->start + em->len - logical, length);
> >> +       *length_ret =3D length;
> >>
> >>         stripe_len =3D map->stripe_len;
> >>         /*
> >> @@ -6031,7 +6033,7 @@ static int __btrfs_map_block(struct btrfs_fs_inf=
o *fs_info,
> >>
> >>         if (op =3D=3D BTRFS_MAP_DISCARD)
> >>                 return __btrfs_map_block_for_discard(fs_info, logical,
> >> -                                                    *length, bbio_ret=
);
> >> +                                                    length, bbio_ret)=
;
> >>
> >>         ret =3D btrfs_get_io_geometry(fs_info, op, logical, *length, &=
geom);
> >>         if (ret < 0)
> >> --
> >> 2.23.0
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
