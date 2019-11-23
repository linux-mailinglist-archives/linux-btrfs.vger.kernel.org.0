Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A386107EA6
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Nov 2019 14:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfKWNds (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Nov 2019 08:33:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfKWNdr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Nov 2019 08:33:47 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E030F20706
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Nov 2019 13:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574516026;
        bh=d8jDeTs31qsCxcoQaYDrCdz36lPK1rItsG5ADIUZFS0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ucHzEu0Ktw2NnSbWczKWWJRI9PtuKAvCZtWkLlWf96AcThbxHPB1sXkL1JfpcLrqf
         Jm1+VXLrCSo2GRySgoPQ1IfNrLjDZaPLu5Xowzgsaoc4xIgmiyfCDbvApAIiIVrMVF
         TKMmua1DqUQdLmtHw8BldcA7gAdCQuEHO6Kw1Zc8=
Received: by mail-vs1-f49.google.com with SMTP id a143so6829866vsd.9
        for <linux-btrfs@vger.kernel.org>; Sat, 23 Nov 2019 05:33:45 -0800 (PST)
X-Gm-Message-State: APjAAAU7aA8y2Av3w511An3SWz5k/kVK8LI3VNvHyi+iVWFvybZXDIAQ
        6kayLhbaAMe292LgOFh+ztNB850QpiVTM9DvgLc=
X-Google-Smtp-Source: APXvYqxkBsIkotKSI15HxLajnz+QqBIab596euqVfxumsrMahgMU1O+bn2P/Y4aioWccsSIxLXGVKIA9KHE5GGvWRt0=
X-Received: by 2002:a67:2fcf:: with SMTP id v198mr13195402vsv.14.1574516024769;
 Sat, 23 Nov 2019 05:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20191030122301.25270-1-fdmanana@kernel.org> <20191123052741.GJ22121@hungrycats.org>
In-Reply-To: <20191123052741.GJ22121@hungrycats.org>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Sat, 23 Nov 2019 13:33:33 +0000
X-Gmail-Original-Message-ID: <CAL3q7H52LYCnDdFoObCCWjrCQqLOpcPUYeD28pXtET25-ycM9w@mail.gmail.com>
Message-ID: <CAL3q7H52LYCnDdFoObCCWjrCQqLOpcPUYeD28pXtET25-ycM9w@mail.gmail.com>
Subject: Re: [PATCH] Btrfs: send, skip backreference walking for extents with
 many references
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Nov 23, 2019 at 5:29 AM Zygo Blaxell
<ce3g8jdj@umail.furryterror.org> wrote:
>
> On Wed, Oct 30, 2019 at 12:23:01PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Backreference walking, which is used by send to figure if it can issue
> > clone operations instead of write operations, can be very slow and use too
> > much memory when extents have many references. This change simply skips
> > backreference walking when an extent has more than 64 references, in which
> > case we fallback to a write operation instead of a clone operation. This
> > limit is conservative and in practice I observed no signicant slowdown
> > with up to 100 references and still low memory usage up to that limit.
> >
> > This is a temporary workaround until there are speedups in the backref
> > walking code, and as such it does not attempt to add extra interfaces or
> > knobs to tweak the threshold.
> >
> > Reported-by: Atemu <atemu.main@gmail.com>
> > Link: https://lore.kernel.org/linux-btrfs/CAE4GHgkvqVADtS4AzcQJxo0Q1jKQgKaW3JGp3SGdoinVo=C9eQ@mail.gmail.com/T/#me55dc0987f9cc2acaa54372ce0492c65782be3fa
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  fs/btrfs/send.c | 25 ++++++++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > index 123ac54af071..518ec1265a0c 100644
> > --- a/fs/btrfs/send.c
> > +++ b/fs/btrfs/send.c
> > @@ -25,6 +25,14 @@
> >  #include "compression.h"
> >
> >  /*
> > + * Maximum number of references an extent can have in order for us to attempt to
> > + * issue clone operations instead of write operations. This currently exists to
> > + * avoid hitting limitations of the backreference walking code (taking a lot of
> > + * time and using too much memory for extents with large number of references).
> > + */
> > +#define SEND_MAX_EXTENT_REFS 64
> > +
> > +/*
> >   * A fs_path is a helper to dynamically build path names with unknown size.
> >   * It reallocates the internal buffer on demand.
> >   * It allows fast adding of path elements on the right side (normal path) and
> > @@ -1302,6 +1310,7 @@ static int find_extent_clone(struct send_ctx *sctx,
> >       struct clone_root *cur_clone_root;
> >       struct btrfs_key found_key;
> >       struct btrfs_path *tmp_path;
> > +     struct btrfs_extent_item *ei;
> >       int compressed;
> >       u32 i;
> >
> > @@ -1349,7 +1358,6 @@ static int find_extent_clone(struct send_ctx *sctx,
> >       ret = extent_from_logical(fs_info, disk_byte, tmp_path,
> >                                 &found_key, &flags);
> >       up_read(&fs_info->commit_root_sem);
> > -     btrfs_release_path(tmp_path);
> >
> >       if (ret < 0)
> >               goto out;
> > @@ -1358,6 +1366,21 @@ static int find_extent_clone(struct send_ctx *sctx,
> >               goto out;
> >       }
> >
> > +     ei = btrfs_item_ptr(tmp_path->nodes[0], tmp_path->slots[0],
> > +                         struct btrfs_extent_item);
> > +     /*
> > +      * Backreference walking (iterate_extent_inodes() below) is currently
> > +      * too expensive when an extent has a large number of references, both
> > +      * in time spent and used memory. So for now just fallback to write
> > +      * operations instead of clone operations when an extent has more than
> > +      * a certain amount of references.
> > +      */
> > +     if (btrfs_extent_refs(tmp_path->nodes[0], ei) > SEND_MAX_EXTENT_REFS) {
>
> So...does this...work?

I wouldn't send it if it didn't work, at least for the case reported.

There's even a test case for this, btrfs/130 from fstests:

https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/tests/btrfs/130

It used to take several hours to complete on a test vm I use
frequently, now it completes in 1 or 2 seconds.

While that is about an extent shared only within the same file, the
same happens if the extent is reflinked to many other files (either
all part of the same subvolume or belonging to different subvolumes).

>
> I ask because I looked at this a few years ago as a way to spend less
> time doing LOGICAL_INO calls during dedupe (and especially avoid the

To give some context to those not familiar with you, you are
mentioning a user space dedupe tool that doesn't call the btrfs dedup
ioctl, and calls the clone ioctl directly, while also using the
LOGICAL_INO ioctl.

> 8-orders-of-magnitude performance degradation in the bad cases), but
> I found that it was useless: it wasn't proportional to the number of
> extents, nor was it an upper or lower bound, nor could extents be sorted
> by number of references using extent.refs as a key, nor could it predict
> the amount of time it would take for iterate_extent_inodes() to run.
> I guess I'm surprised you got a different result.
>
> If the 'refs' field is 1, the extent might have somewhere between 1
> and 3500 root/inode/offset references.

Yes, that's due to snapshotting and the way it works.
Creating a snapshot consists of COWing the root node of a tree only,
which will not increment extent references (for data extents,
referenced in leafs) if the tree has an height of 2 or more.

Example:

1) You have a subvolume tree with 2 levels (root at level 1, leafs at level 0);

2) You have a file there that refers to extent A, not shared with
anyone else, and has a reference count of 1 in the extent item at the
extent tree;

3) After you snapshot the subvolume, extent A will still have 1
reference count in its item at the extent tree.

If you do anything that changes the leaf that refers to extent A
(resulting in it being COWed), in either tree, btrfs will take care of
adding a new backreference to the extent and bump the reference count
to 2 for extent A.

If on the other hand, if the source subvolume was really small,
consisting of a single node/leaf (root at level 0), then you would get
2 references for extent A immediately after making the snapshot.

> But it's not a lower bound,
> e.g. here is an extent on a random filesystem where extent_refs is a
> big number:
>
>         item 87 key (1344172032 EXTENT_ITEM 4096) itemoff 11671 itemsize 24
>                 refs 897 gen 2668358 flags DATA
>
> LOGICAL_INO_V2 only finds 170 extent references:
>
>         # btrfs ins log 1344172032 -P . | wc -l
>         170

Pass "-s 65536", the default buffer is likely not large enough to all
inode/root numbers.

>
> Is there a good primer somewhere on how the reference counting works in
> btrfs?

Dunno. Source code, and an old paper about btrfs:

https://domino.research.ibm.com/library/cyberdig.nsf/papers/6E1C5B6A1B6EDD9885257A38006B6130/$File/rj10501.pdf

Maybe the wiki has more references.

>
> > +             ret = -ENOENT;
> > +             goto out;
> > +     }
> > +     btrfs_release_path(tmp_path);
> > +
> >       /*
> >        * Setup the clone roots.
> >        */
> > --
> > 2.11.0
> >
