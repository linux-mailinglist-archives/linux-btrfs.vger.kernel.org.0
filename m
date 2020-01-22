Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C9E14541F
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jan 2020 12:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAVLzZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jan 2020 06:55:25 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34036 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgAVLzZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jan 2020 06:55:25 -0500
Received: by mail-vs1-f68.google.com with SMTP id g15so3993134vsf.1
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Jan 2020 03:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SJqvp9ULPEGrvC+wKjRrdI4TiVOnvBGe6VguaFojH4M=;
        b=ZYtfdIiLJTDXmwBeOnc6oMiGzqfgDcUpL7LWzvz1u9iedOZcDE7DkO2WUGIurMbuO4
         jSMYf9nSspEE46C3h5Pf42h3nCZrZXoH24rndYPmKCDjb1lNvVz3pf3zNkFBjIA9pt9Y
         WhPebO0oCa1CJrSkl80uMls6wU7a//GYhmEUySivUG7fXSx3x+pcXd7FBtEwuI6FSOoL
         Opgj5AU0NcmPEv3f7Z1lySBed18QUimuXqs4PhGrNu6h28AQ52TxkoTXSoTUsm8voBkv
         7RkicQLFWRafVKX29M2lcYg47y5bsQpma6GLrseMtkSKeNls4ATFtnYhGqzP9D/RDC4Z
         Ykbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SJqvp9ULPEGrvC+wKjRrdI4TiVOnvBGe6VguaFojH4M=;
        b=KyMIXc9s3qwQ06LnMJxww/KQ/ZwUhNl6TQBK9BXvln6aRJmRuPVnuwhfeYR7zhvrkO
         pBVDTFDxsh8TYkZ6WV60/zKZ3wUURxUgz+S6/tKmNEaSVW84NGJNE6dQMoqa4sJ5sukp
         mVVAz5CDFS34obD+/kQLglTkDJPzVi4KpTrVF4bFZ3NytPWTc1DwoA2lqbGo/z3Uz/ZT
         Am+wvLk9gB7dVBsHeX0gMkfNBnuDiiAAqqHLk3hgLBj2wlZiVnuO3nf5YTu4gf66g649
         hh099sdCPqzBry9r/hMC0wMECb8TSB23GkZ+73gMus+GPiGzp80VRD7CypdcZatqAcqb
         l/aA==
X-Gm-Message-State: APjAAAVQ7neUSWqqnglyWzvbGaRzB2C2m4fl07gpjGBBS4kSQ08/14de
        aaYdvtU7fhqE8ab0iHqkOf0SVxQxJN7+XasZUn0=
X-Google-Smtp-Source: APXvYqx3k9Tv7SD90TQQ4lSKwtXVHwR50sltuoTIbE8yXnFemw9etBw6xVy20zg3EJkSWweGSwKIJIGWdTEEWqljgQc=
X-Received: by 2002:a05:6102:18f:: with SMTP id r15mr2155688vsq.206.1579694124112;
 Wed, 22 Jan 2020 03:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20200122083628.16331-1-wqu@suse.com> <CAL3q7H7tk6JdVpjz9xne7S4JBL8DZTKp04nTrhLTHjKeSyUtqw@mail.gmail.com>
 <6877fa2e-7ccc-2ff0-2ea0-458ea9cb8432@gmx.com>
In-Reply-To: <6877fa2e-7ccc-2ff0-2ea0-458ea9cb8432@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 22 Jan 2020 11:55:13 +0000
Message-ID: <CAL3q7H6sKnSSf+PX3cWsQoOhL8My-eBiqLGFCkLWPY4SPCNr_A@mail.gmail.com>
Subject: Re: [PATCH RFC] btrfs: scrub: Mandatory RO block group for device replace
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 22, 2020 at 10:40 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/1/22 =E4=B8=8B=E5=8D=886:05, Filipe Manana wrote:
> > On Wed, Jan 22, 2020 at 8:37 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> [BUG]
> >> btrfs/06[45] btrfs/071 could fail by finding csum error.
> >> The reproducibility is not high, around 1/20~1/100, needs to run them =
in
> >> loops.
> >>
> >> And the profile doesn't make much difference, SINGLE/SINGLE can also
> >> reproduce the problem.
> >>
> >> The bug is observable after commit b12de52896c0 ("btrfs: scrub: Don't
> >> check free space before marking a block group RO")
> >>
> >> [CAUSE]
> >> Device replace reuses scrub code to iterate existing extents.
> >>
> >> It adds scrub_write_block_to_dev_replace() to scrub_block_complete(), =
so
> >> that scrub read can write the verified data to target device.
> >>
> >> Device replace also utilizes "write duplication" to write new data to
> >> both source and target device.
> >>
> >> However those two write can conflict and may lead to data corruption:
> >> - Scrub writes old data from commit root
> >>   Both extent location and csum are fetched from commit root, which
> >>   is not always the up-to-date data.
> >>
> >> - Write duplication is always duplicating latest data
> >>
> >> This means there could be a race, that "write duplication" writes the
> >> latest data to disk, then scrub write back the old data, causing data
> >> corruption.
> >
> > Worth mentioning this is for nocow writes only then.
> > Given that the test cases that fail use fsstress and don't use nocow
> > files or -o nodatacow, the only possible case is writes into prealloc
> > extents.
> > Write duplication writes the new data and then extent iteration writes
> > zeroes (or whatever is on disk) after that.
>
> Thank you very much for the mentioning of prealloc extents, that's
> exactly the missing piece!
>
> My original assumption in fact has a hole, extents in commit tree won't
> get re-allocated as they will get pinned down, and until next trans
> won't be re-used.
> So the explaination should only work for nodatacow case, and I could not
> find a good explanation until now.
>
> And if it's prealloc extent, then it's indeed a different story.

Just mention that in the changelog and the comment, that the need to set th=
e
block group RO and wait for ongoing writes is only needed for nocow writes
(which includes both files with the nocow bit set and writes into
prealloc extents).

>
> >
> >>
> >> In theory, this should only affects data, not metadata.
> >> Metadata write back only happens when committing transaction, thus it'=
s
> >> always after scrub writes.
> >
> > No, not only when committing transaction.
> > It can happen under memory pressure, tree extents can be written
> > before. In fact, if you remember the 5.2 corruption and deadlock, the
> > deadlock case happened precisely when writeback of the btree inode was
> > triggered before a transaction commit.
> >
> >>
> >> [FIX]
> >> Make dev-replace to require mandatory RO for target block group.
> >>
> >> And to be extra safe, for dev-replace, wait for all exiting writes to
> >> finish before scrubbing the chunk.
> >>
> >> This patch will mostly revert commit 76a8efa171bf ("btrfs: Continue re=
place
> >> when set_block_ro failed").
> >> ENOSPC for dev-replace is still much better than data corruption.
> >>
> >> Reported-by: Filipe Manana <fdmanana@suse.com>
> >> Fixes: 76a8efa171bf ("btrfs: Continue replace when set_block_ro failed=
")
> >> Fixes: b12de52896c0 ("btrfs: scrub: Don't check free space before mark=
ing a block group RO")
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Not concretely confirmed, mostly through guess, thus it has RFC tag.
> >
> > Well, it's better to confirm...
> > IIRC, correctly, dev-replace does not skip copies for prealloc
> > extents, it copies what is on disk.
>
> That's true, it doesn't do backref walk to determine if it's
> preallocated or regular.
> It just gather csum, copy pages from disk, verify if there is csum, then
> copy the pages back.

Yep, I didn't had the code in front of me when I replied, but I didn't
remember dev-replace/scrub
checking extent types.

>
> So prealloc indeed looks like a very valid cause, and it can be verified
> just by disabling prealloc in fsstress.

Yes, disable fallocate and zero range operations in fsstress.
If it passes without this patch for thousands of iterations, then that
was the cause.

Thanks!

>
> Thanks again for pointing out the missing piece.
> Qu
>
> > If that's the case, then this is correct. However if it's smart and
> > skips copying prealloc extents (which is pointless), then the problem
> > must have other technical explanation.
> >
> >>
> >> My first guess is race at the dev-replace starting point, but related
> >> code is in fact very safe.
> >> ---
> >>  fs/btrfs/scrub.c | 35 ++++++++++++++++++++++++++++++++---
> >>  1 file changed, 32 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> >> index 21de630b0730..69e76a4d1258 100644
> >> --- a/fs/btrfs/scrub.c
> >> +++ b/fs/btrfs/scrub.c
> >> @@ -3472,6 +3472,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sct=
x,
> >>         struct btrfs_path *path;
> >>         struct btrfs_fs_info *fs_info =3D sctx->fs_info;
> >>         struct btrfs_root *root =3D fs_info->dev_root;
> >> +       bool is_dev_replace =3D sctx->is_dev_replace;
> >
> > Not needed, just use sctx->is_dev_replace like everywhere else.
> >
> > Thanks.
> >
> >>         u64 length;
> >>         u64 chunk_offset;
> >>         int ret =3D 0;
> >> @@ -3577,17 +3578,35 @@ int scrub_enumerate_chunks(struct scrub_ctx *s=
ctx,
> >>                  * This can easily boost the amount of SYSTEM chunks i=
f cleaner
> >>                  * thread can't be triggered fast enough, and use up a=
ll space
> >>                  * of btrfs_super_block::sys_chunk_array
> >> +                *
> >> +                *
> >> +                * On the other hand, try our best to mark block group=
 RO for
> >> +                * dev-replace case.
> >> +                *
> >> +                * Dev-replace has two types of write:
> >> +                * - Write duplication
> >> +                *   New write will be written to both target and sour=
ce device
> >> +                *   The content is always the *newest* data.
> >> +                * - Scrub write for dev-replace
> >> +                *   Scrub will write the verified data for dev-replac=
e.
> >> +                *   The data and its csum are all from *commit* root,=
 which
> >> +                *   is not the newest version.
> >> +                *
> >> +                * If scrub write happens after write duplication, we =
would
> >> +                * cause data corruption.
> >> +                * So we need to try our best to mark block group RO, =
and exit
> >> +                * out if we don't have enough space.
> >>                  */
> >> -               ret =3D btrfs_inc_block_group_ro(cache, false);
> >> +               ret =3D btrfs_inc_block_group_ro(cache, is_dev_replace=
);
> >>                 scrub_pause_off(fs_info);
> >>
> >>                 if (ret =3D=3D 0) {
> >>                         ro_set =3D 1;
> >> -               } else if (ret =3D=3D -ENOSPC) {
> >> +               } else if (ret =3D=3D -ENOSPC && !is_dev_replace) {
> >>                         /*
> >>                          * btrfs_inc_block_group_ro return -ENOSPC whe=
n it
> >>                          * failed in creating new chunk for metadata.
> >> -                        * It is not a problem for scrub/replace, beca=
use
> >> +                        * It is not a problem for scrub, because
> >>                          * metadata are always cowed, and our scrub pa=
used
> >>                          * commit_transactions.
> >>                          */
> >> @@ -3605,6 +3624,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sc=
tx,
> >>                 dev_replace->item_needs_writeback =3D 1;
> >>                 up_write(&dev_replace->rwsem);
> >>
> >> +               /*
> >> +                * Also wait for any exitings writes to prevent race b=
etween
> >> +                * write duplication and scrub writes.
> >> +                */
> >> +               if (is_dev_replace) {
> >> +                       btrfs_wait_block_group_reservations(cache);
> >> +                       btrfs_wait_nocow_writers(cache);
> >> +                       btrfs_wait_ordered_roots(fs_info, U64_MAX,
> >> +                                       cache->start, cache->length);
> >> +               }
> >>                 ret =3D scrub_chunk(sctx, scrub_dev, chunk_offset, len=
gth,
> >>                                   found_key.offset, cache);
> >>
> >> --
> >> 2.25.0
> >>
> >
> >
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
