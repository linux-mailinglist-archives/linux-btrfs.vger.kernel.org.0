Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66C910B4A0
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 18:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfK0Rhr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Nov 2019 12:37:47 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40182 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfK0Rhq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Nov 2019 12:37:46 -0500
Received: by mail-ua1-f65.google.com with SMTP id p18so7260618uar.7
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2019 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=CCNJk9wlQ1ikfMfqT/Ey0AwrKfcrVZrOfP6ehHvCO/o=;
        b=M89tAn+v47MBvrBxs7LsZ1/DUvJWUeVuEuSJA68+DtzhNnuQ5AtP//VYOA+d4ToGtk
         MiZJla0o45MHuLw01k5Q06oAchW3b0zpSKxMnnFJv8ZfIv7joglFeImKazn3lG8qo2LL
         VhbcXxTS/LNtx9wHIIJra+AY3iuXosGgYxG5cJERILCXqIPFaQB3hKjx3j1jTB9K1ryz
         ebXHt0yG6kpuc+I98qEzxJ8RsoMVFa0xP6MzGY4+hB7sG5ICUO/0DHYLa1UctpOCM2sm
         4PYdPeh6uNVTIFYzT8aoDDSxsUBnT2WMc0yaDfKGoXqNSqRhHBSQdNJincim1tloSYu0
         pJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=CCNJk9wlQ1ikfMfqT/Ey0AwrKfcrVZrOfP6ehHvCO/o=;
        b=MPuX0Uq6HaN+5/nfyFMm8Jtkkh79VisWmw5/KoKon5hy44gdcz8vKdlMickSqMt1sO
         I0xYY/xIaFKPVJGSzYYISkPv0IhZXtCeWXYqffqaGNFo3pLTLgh9EF3+FnVzvuRFeeWL
         Exi9fC490MWjMTBD7jOpZ9BYNbpgtFN5ttg7aIrTF4sTvRMH8CWbpkRevdgJp5UxTv1+
         WcVfH7Ph3pY0u2kJGwW1qaQXx1sKkkF2LW7LFM+dSfMzT98pO0PKPOpwkD3bisQykEAG
         RbwtKwTbPlwxvKdFuzmfBWFyK+Y1K15z7QLeutLXmeX6kLGxM96wyBufEWKlOusG+HzG
         BAKw==
X-Gm-Message-State: APjAAAXYYUvS1M6f0ft8EjDTLnHP6oV4qjgQEWR22Ny4qRxRV/cOObMc
        20Hjbj6VxBkYEM6Dpk9vW1iAoX++pgNxmJu6YXk=
X-Google-Smtp-Source: APXvYqype32ShJ6i3oAy/ZOjKO50eHNqpinw4t32M5nztWnr1Ipr8UQsnoZkz/E+laLMCM1Klh+HbzXdfjJKtA8T3Y8=
X-Received: by 2002:ab0:13c4:: with SMTP id n4mr3609239uae.123.1574876265493;
 Wed, 27 Nov 2019 09:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20191121120331.29070-1-nborisov@suse.com> <20191121120331.29070-2-nborisov@suse.com>
 <20191127160600.GU2734@twin.jikos.cz>
In-Reply-To: <20191127160600.GU2734@twin.jikos.cz>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 27 Nov 2019 17:37:34 +0000
Message-ID: <CAL3q7H4U2V4jqh6PsOFZb6nNpBQbzrF+gm49j9iYNop5vSf5uw@mail.gmail.com>
Subject: Re: [PATCH 1/3] btrfs: Don't discard unwritten extents
To:     dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe David Borba Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 27, 2019 at 4:08 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Nov 21, 2019 at 02:03:29PM +0200, Nikolay Borisov wrote:
> > --- a/fs/btrfs/extent-tree.c
> > +++ b/fs/btrfs/extent-tree.c
> > @@ -4169,8 +4169,6 @@ static int __btrfs_free_reserved_extent(struct bt=
rfs_fs_info *fs_info,
> >               if (ret)
> >                       goto out;
> >       } else {
> > -             if (btrfs_test_opt(fs_info, DISCARD))
> > -                     ret =3D btrfs_discard_extent(fs_info, start, len,=
 NULL);
> >               btrfs_add_free_space(cache, start, len);
> >               btrfs_free_reserved_bytes(cache, len, delalloc);
> >               trace_btrfs_reserved_extent_free(fs_info, start, len);
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 0ac0f5b33003..5d80fe030e79 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3250,10 +3250,15 @@ static int btrfs_finish_ordered_io(struct btrfs=
_ordered_extent *ordered_extent)
> >               if ((ret || !logical_len) &&
> >                   clear_reserved_extent &&
> >                   !test_bit(BTRFS_ORDERED_NOCOW, &ordered_extent->flags=
) &&
> > -                 !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->fl=
ags))
> > +                 !test_bit(BTRFS_ORDERED_PREALLOC, &ordered_extent->fl=
ags)) {
> >                       btrfs_free_reserved_extent(fs_info,
> >                                                  ordered_extent->start,
> >                                                  ordered_extent->disk_l=
en, 1);
> > +                     if (ret && btrfs_test_opt(fs_info, DISCARD))
> > +                             btrfs_discard_extent(fs_info,
> > +                             ordered_extent->start, ordered_extent->di=
sk_len,
> > +                             NULL);
>
> This brings back vague memories of misplaced discard (in
> finish_ordered_io), that was quite hard to catch. I can't find the fix
> though. Filipe, is it the same issue?

It's different (as you identified already in another reply).
Even though this is rarely hit on a healthy system, it looks fine to me.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

thanks



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
