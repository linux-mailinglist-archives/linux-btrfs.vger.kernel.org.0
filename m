Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D8815BCA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Feb 2020 11:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgBMKVW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Feb 2020 05:21:22 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:33651 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKVW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Feb 2020 05:21:22 -0500
Received: by mail-vs1-f67.google.com with SMTP id n27so3585700vsa.0
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Feb 2020 02:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=ZsMVGYco0HV4JWx0XkSkCJFZz683ipi8JH8zrtLfWGk=;
        b=jitXEzcHj0IfJpsVRW8USP77URge2WndO+PpSZ9QVIDnCllDQs6C2Y9weS2SB8LkJS
         hgXh56XB6Il6/anCkaE0KqdvGfleXxKSqTyA43wdsrSuLmdzT1utg6FBhtQdcinW5n+Y
         FgDOoXSL/8Z9fsaiMlEkbQBq7eXEBn5vLQVz+n/sWNYsjvTHj8ZI3F/W9bqk2/DaZ3wr
         nP2FOolAlhq4eIsJL0Z/cWeEqNLfoqlLQkYtz6k71yymoSxvmIiQQlpq5tTOBKWo+BvQ
         gZ39OsI5VUYnNER3LdTryK/Cw1K72TZJWhC6YxMEjY3Uezkyq55LkVskEI4ByQjivV0O
         hkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=ZsMVGYco0HV4JWx0XkSkCJFZz683ipi8JH8zrtLfWGk=;
        b=UhEz1vc74P/oNts5oqR/JsWgeQrdLSM1sSLS41MRHhMpu3lgHslss18vKYkfhvTH99
         dm6yMKUAdKbwMYIKdVEhjxHLt71V3VgRKb6QFHNBKR+Fiyv+YOFpGLzXFcAJWw78sUoI
         f1HMUHNzYjZAEp+QTazxn0bS5k9ZZDDWrgffpNpNla5CdQtKy4fvg+lCU44BjQg6TNQb
         cjOa0strG2AQcHoPhi91lSMUQMsoTfAw3WU3ufOM/mZej0s9nEecy0WmQO0XDceKvNd7
         7IqHLhlBfuWnc2v641gabnx8o75gz/Mh1OHtDu0/jWafHdWTfi9W9u1s1xzRC5rnqgQO
         RKlg==
X-Gm-Message-State: APjAAAXgCRtbEEytH5rpBwTQKdZj94tMA8lCRXYWoW1wca58FKazptjN
        zCITJOxEo95HaeW+4oPAZrJaNTz0EzxKyTWzGDQ=
X-Google-Smtp-Source: APXvYqx6T2XSeGtRQ1vPsIu6xFkzEKLJFIhBZOZgsLkoxwDNNdsMS5OsSHqU3GX9/zwunciFMn3znTRKQtSbd6e+mnE=
X-Received: by 2002:a67:af11:: with SMTP id v17mr1519341vsl.99.1581589281386;
 Thu, 13 Feb 2020 02:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20200212183831.78293-1-josef@toxicpanda.com> <CAL3q7H7vUxcghnxfyVTrG0ztHZT-=9uo7H7nwRCJUzyB25CiPQ@mail.gmail.com>
 <7279d1d5-0b27-f319-0591-90750323c3a7@toxicpanda.com>
In-Reply-To: <7279d1d5-0b27-f319-0591-90750323c3a7@toxicpanda.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 13 Feb 2020 10:21:10 +0000
Message-ID: <CAL3q7H7172R2H8encxqAvpLbWUufGaRYKEGo3hpDBP55DB2YbA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add a find_contiguous_extent_bit helper and use it
 for safe isize
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Feb 12, 2020 at 7:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On 2/12/20 1:44 PM, Filipe Manana wrote:
> > On Wed, Feb 12, 2020 at 6:40 PM Josef Bacik <josef@toxicpanda.com> wrot=
e:
> >>
> >> Filipe noticed a race where we would sometimes get the wrong answer fo=
r
> >> the i_disk_size for !NO_HOLES with my patch.  That is because I expect=
ed
> >> that find_first_extent_bit() would find the contiguous range, since I'=
m
> >> only ever setting EXTENT_DIRTY.  However the way set_extent_bit() work=
s
> >> is it'll temporarily split the range, loop around and set our bits, an=
d
> >> then merge the state.  When it loops it drops the tree->lock, so there
> >> is a window where we can have two adjacent states instead of one large
> >> state.  Fix this by walking forward until we find a non-contiguous
> >> state, and set our end_ret to the end of our logically contiguous area=
.
> >> This fixes the problem without relying on specific behavior from
> >> set_extent_bit().
> >>
> >> Fixes: 79ceff7f6e5d ("btrfs: introduce per-inode file extent tree")
> >> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> >> ---
> >> Dave, I assume you'll want to fold this in to the referenced patch, if=
 not let
> >> me know and I'll rework the series to include this as a different patc=
h.
> >>
> >>   fs/btrfs/extent-io-tree.h |  2 ++
> >>   fs/btrfs/extent_io.c      | 36 ++++++++++++++++++++++++++++++++++++
> >>   fs/btrfs/file-item.c      |  4 ++--
> >>   3 files changed, 40 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
> >> index 16fd403447eb..cc3037f9765e 100644
> >> --- a/fs/btrfs/extent-io-tree.h
> >> +++ b/fs/btrfs/extent-io-tree.h
> >> @@ -223,6 +223,8 @@ int find_first_extent_bit(struct extent_io_tree *t=
ree, u64 start,
> >>                            struct extent_state **cached_state);
> >>   void find_first_clear_extent_bit(struct extent_io_tree *tree, u64 st=
art,
> >>                                   u64 *start_ret, u64 *end_ret, unsign=
ed bits);
> >> +int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start=
,
> >> +                              u64 *start_ret, u64 *end_ret, unsigned =
bits);
> >>   int extent_invalidatepage(struct extent_io_tree *tree,
> >>                            struct page *page, unsigned long offset);
> >>   bool btrfs_find_delalloc_range(struct extent_io_tree *tree, u64 *sta=
rt,
> >> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> >> index d91a48d73e8f..50bbaf1c7cf0 100644
> >> --- a/fs/btrfs/extent_io.c
> >> +++ b/fs/btrfs/extent_io.c
> >> @@ -1578,6 +1578,42 @@ int find_first_extent_bit(struct extent_io_tree=
 *tree, u64 start,
> >>          return ret;
> >>   }
> >>
> >> +/**
> >> + * find_contiguous_extent_bit: find a contiguous area of bits
> >> + * @tree - io tree to check
> >> + * @start - offset to start the search from
> >> + * @start_ret - the first offset we found with the bits set
> >> + * @end_ret - the final contiguous range of the bits that were set
> >> + *
> >> + * set_extent_bit anc clear_extent_bit can temporarily split contiguo=
us ranges
> >> + * to set bits appropriately, and then merge them again.  During this=
 time it
> >> + * will drop the tree->lock, so use this helper if you want to find t=
he actual
> >> + * contiguous area for given bits.  We will search to the first bit w=
e find, and
> >> + * then walk down the tree until we find a non-contiguous area.  The =
area
> >> + * returned will be the full contiguous area with the bits set.
> >> + */
> >> +int find_contiguous_extent_bit(struct extent_io_tree *tree, u64 start=
,
> >> +                              u64 *start_ret, u64 *end_ret, unsigned =
bits)
> >> +{
> >> +       struct extent_state *state;
> >> +       int ret =3D 1;
> >> +
> >> +       spin_lock(&tree->lock);
> >> +       state =3D find_first_extent_bit_state(tree, start, bits);
> >> +       if (state) {
> >> +               *start_ret =3D state->start;
> >> +               *end_ret =3D state->end;
> >> +               while ((state =3D next_state(state)) !=3D NULL) {
> >> +                       if (state->start > (*end_ret + 1))
> >> +                               break;
> >> +                       *end_ret =3D state->end;
> >> +               }
> >> +               ret =3D 0;
> >
> > So as long as the tree is not empty, we will always be returning 0
> > (success), right?
> > If we break from the while loop we should return with 1, but this
> > makes us return 0.
> >
>
> Yeah, that's the same behavior we have with find_first_extent_bit, that's=
 why we do
>
> if (!ret && start =3D=3D 0)
>         i_size =3D min(i_size, end + 1);
> else
>         i_size =3D 0;

Yes, never mind, evening confusion.
It's correct indeed, and it fixes the problem as well (even without my
optimization patch).

>
> Thanks,
>
> Josef



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
