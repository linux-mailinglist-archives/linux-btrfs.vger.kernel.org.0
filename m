Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5243058EA
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Jan 2021 11:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhA0K4W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Jan 2021 05:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236136AbhA0Kx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Jan 2021 05:53:59 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD60C061756
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 02:53:18 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id e15so1019533qte.9
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Jan 2021 02:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=SFbCblXIHhLkzyuu3Diys43MRjETKihw3ZxCoHmXWpo=;
        b=U52xiF4Mt+gFISSZrUy0AEKpVl1lPUGqj7Lec11KcsvKqg3hQK4yMvxyGKqe9T8Lwe
         cKASwuILbQBQo2G7siNihrUCBOTPG4/MCZntXK27jqw5WE4ezbpMDbr9Y05jKOLgaotw
         3qtrmBLmWzhgSem07VnyyogHaw9hSQr/QqR2BW+q7b93CFIiDvJ/ng/LefiJYAfC6hJA
         pjwx0Aoz8XquW9TQ+T7jr5abV7MsMHCSPYrFPYWYLCkV0YRiG8DwO8lw2UTKTgeLYdPE
         2e3IcLJQLF6K1Yp7B1iSOBjunX+IaLexRJpDiNT5rtbzmSxvrdE0CZMgXkZR0H/P4O6s
         G29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=SFbCblXIHhLkzyuu3Diys43MRjETKihw3ZxCoHmXWpo=;
        b=bJ3oIRl4utabxtZLAXMRKXfsn5KLVd1vfeHZh2NibmaNKE7SmfkbhiJvT1fnQquSkW
         KV4Pq0kBp0CEwKjWQUJNIGwJubO7uqjaY7ElvdQSXmEzChWOxY23O/tSYveWbgiYDoV/
         PgrvYIv7dB45AFvJm+GC2iR16Ictl+j31M23JIkUjZCzzce3GoWSM8HtV6iWAiPykUX/
         eSdsB+nXnTcagzHRGxEgQIu6kI6IWItajxJo9TrF+HJd3nZrGCvwCBWFU9Ej1qermTHL
         oa/GPwtvxkZ1TvTC37r/gbUnSk9Jo59t+u30wR4F6c44ayKWznWoojQPd/XcUrMpTifw
         Oflg==
X-Gm-Message-State: AOAM532g4pk/zE3ieceUoFJTH62cScvmTsx8AmFEODDcLd0hSIFKAUzW
        clpx9s68if5tAN7eHm5jWD/css+eZg4gJUmYK36W0Brg
X-Google-Smtp-Source: ABdhPJxvRMKNNEOg9qmqtdrOiwA7SIpZXMHT7kr3XFCZO0y2in6S7h26YSNqTBttWcnnyRYwCrnZGtUCdcPz5AMG/Tk=
X-Received: by 2002:aed:2f01:: with SMTP id l1mr9242272qtd.21.1611744797861;
 Wed, 27 Jan 2021 02:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20210125194210.24071-1-roman.anasal@bdsu.de> <20210125194210.24071-4-roman.anasal@bdsu.de>
 <CAL3q7H79meSfikTKvTujQzA_SRb3bfF9ajYtWSVTfu0+pLE8wQ@mail.gmail.com> <24207f5b9cea6a9a82739ecc5f62678ea6749663.camel@bdsu.de>
In-Reply-To: <24207f5b9cea6a9a82739ecc5f62678ea6749663.camel@bdsu.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 27 Jan 2021 10:53:06 +0000
Message-ID: <CAL3q7H6Dtqr3816KSeitCvYqnO0ZY6PNceMFAOtARah+XrRFFA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] btrfs: send: fix invalid commands for inodes with
 changed rdev but same gen
To:     "Roman Anasal | BDSU" <roman.anasal@bdsu.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jan 26, 2021 at 7:19 PM Roman Anasal | BDSU
<roman.anasal@bdsu.de> wrote:
>
> Am Montag, den 25.01.2021, 20:51 +0000 schrieb Filipe Manana:
> > On Mon, Jan 25, 2021 at 7:51 PM Roman Anasal <roman.anasal@bdsu.de>
> > wrote:
> > > This is analogous to the preceding patch ("btrfs: send: fix invalid
> > > commands for inodes with changed type but same gen") but for
> > > changed
> > > rdev:
> > >
> > > When doing an incremental send, if a new inode has the same number
> > > as an
> > > inode in the parent subvolume, was created with the same generation
> > > but
> > > has differing rdev it will not be detected as changed and thus not
> > > recreated. This will lead to incorrect results on the receiver
> > > where the
> > > inode will keep the rdev of the inode in the parent subvolume or
> > > even
> > > fail when also the ref is unchanged.
> > >
> > > This case does not happen when doing incremental sends with
> > > snapshots
> > > that are kept read-only by the user all the time, but it may happen
> > > if
> > > - a snapshot was modified in the same transaction as its parent
> > > after it
> > >   was created
> > > - the subvol used as parent was created independently from the sent
> > > subvol
> > >
> > > Example reproducers:
> > >
> > >   # case 1: same ino at same path
> > >   btrfs subvolume create subvol1
> > >   btrfs subvolume create subvol2
> > >   mknod subvol1/a c 1 3
> > >   mknod subvol2/a c 1 5
> > >   btrfs property set subvol1 ro true
> > >   btrfs property set subvol2 ro true
> > >   btrfs send -p subvol1 subvol2 | btrfs receive --dump
> > >
> > > The produced tree state here is:
> > >   |-- subvol1
> > >   |   `-- a         (ino 257, c 1,3)
> > >   |
> > >   `-- subvol2
> > >       `-- a         (ino 257, c 1,5)
> > >
> > > Where subvol1/a and subvol2/a are character devices with differing
> > > minor
> > > numbers but same inode number and same generation.
> > >
> > > Example output of the receive command:
> > >   At subvol subvol2
> > >   snapshot        ./subvol2                       uuid=3D7513941c-
> > > 4ef7-f847-b05e-4fdfe003af7b transid=3D9 parent_uuid=3Db66f015b-c226-
> > > 2548-9e39-048c7fdbec99 parent_transid=3D9
> > >   utimes          ./subvol2/                      atime=3D2021-01-
> > > 25T17:14:36+0000 mtime=3D2021-01-25T17:14:36+0000 ctime=3D2021-01-
> > > 25T17:14:36+0000
> > >   link            ./subvol2/a                     dest=3Da
> > >   unlink          ./subvol2/a
> > >   utimes          ./subvol2/                      atime=3D2021-01-
> > > 25T17:14:36+0000 mtime=3D2021-01-25T17:14:36+0000 ctime=3D2021-01-
> > > 25T17:14:36+0000
> > >   utimes          ./subvol2/a                     atime=3D2021-01-
> > > 25T17:14:36+0000 mtime=3D2021-01-25T17:14:36+0000 ctime=3D2021-01-
> > > 25T17:14:36+0000
> > >
> > > =3D> the `link` command causes the receiver to fail with:
> > >    ERROR: link a -> a failed: File exists
> > >
> > > Second example:
> > >   # case 2: same ino at different path
> > >   btrfs subvolume create subvol1
> > >   btrfs subvolume create subvol2
> > >   mknod subvol1/a c 1 3
> > >   mknod subvol2/b c 1 5
> > >   btrfs property set subvol1 ro true
> > >   btrfs property set subvol2 ro true
> > >   btrfs send -p subvol1 subvol2 | btrfs receive --dump
> >
> > As I've told you before for the v1 patchset from a week or two ago,
> > this is not a supported scenario for incremental sends.
> > Incremental sends are meant to be used on RO snapshots of the same
> > subvolume, and those snapshots must never be changed after they were
> > created.
> >
> > Incremental sends were simply not designed for these cases, and can
> > never be guaranteed to work with such cases.
> >
> > The bug is not having incremental sends fail right away, with an
> > explicit error message, when the send and parent roots aren't RO
> > snapshots of the same subvolume.
>
> I am sorry, I didn't want to anger you or to appear to be just stubborn
> by posting this.
>
> As I wrote in the cover letter I am aware that this is not a supported
> use case and I understand that that makes the patches likely to be
> rejected.

Ok, now I got the cover letter and the remaining v2 patches.
Vger has been having some lag this week, only got the mails during the
last evening.

Thanks.

> As said the reason I _wrote_ the patches was simply to learn more about
> the btrfs code and its internals and see if I would be able to
> understand it enough. The reason I _submitted_ them was just to
> document what I found out so others could have a look into it and just
> in case it maybe useful at a later time.
>
> I also don't want to claim that these will add full support for sending
> unrelated roots - they don't! They only handle those very specific edge
> cases I found, which are currently _possible_, although still not
> supported.
>
> I took a deeper look into the rest to see if it could be supported:
> the comparing algorithm actually works fine, even with completely
> unrelated subvolumes (i.e. btrfs_compare_trees, changed_cb,
> changed_inode etc.), but the processing of the changes (i.e.
> process_recorded_refs etc.) is heavily based on (ino, gen) as
> identifying handle, which can not be changed without the high risk of
> regression - just as you said in your earlier comments - since side
> effects of any changes are hard to see or understand without a very
> deep understanding of the whole code; which is why I didn't even try to
> touch that parts.
>
> I apologize if I appeared to be stubborn or ignorant of your feedback!
> That really wasn't my intent.
>
>
> > > The produced tree state here is:
> > >   |-- subvol1
> > >   |   `-- a         (ino 257, c 1,3)
> > >   |
> > >   `-- subvol2
> > >       `-- b         (ino 257, c 1,5)
> > >
> > > Where subvol1/a and subvol2/b are character devices with differing
> > > minor
> > > numbers but same inode number and same generation.
> > >
> > > Example output of the receive command:
> > >   At subvol subvol2
> > >   snapshot        ./subvol2                       uuid=3D1c175819-
> > > 8b97-0046-a20e-5f95e37cbd40 transid=3D13 parent_uuid=3Dbad4a908-21b4-
> > > 6f40-9a08-6b0768346725 parent_transid=3D13
> > >   utimes          ./subvol2/                      atime=3D2021-01-
> > > 25T17:18:46+0000 mtime=3D2021-01-25T17:18:46+0000 ctime=3D2021-01-
> > > 25T17:18:46+0000
> > >   link            ./subvol2/b                     dest=3Da
> > >   unlink          ./subvol2/a
> > >   utimes          ./subvol2/                      atime=3D2021-01-
> > > 25T17:18:46+0000 mtime=3D2021-01-25T17:18:46+0000 ctime=3D2021-01-
> > > 25T17:18:46+0000
> > >   utimes          ./subvol2/b                     atime=3D2021-01-
> > > 25T17:18:46+0000 mtime=3D2021-01-25T17:18:46+0000 ctime=3D2021-01-
> > > 25T17:18:46+0000
> > >
> > > =3D> subvol1/a is renamed to subvol2/b instead of recreated to
> > > updated
> > >    rdev which results in received subvol2/b having the wrong minor
> > >    number:
> > >
> > >   257 crw-r--r--. 1 root root 1, 3 Jan 25 17:18 subvol2/b
> > >
> > > Signed-off-by: Roman Anasal <roman.anasal@bdsu.de>
> > > ---
> > > v2:
> > >   - add this patch to also handle changed rdev
> > > ---
> > >  fs/btrfs/send.c | 15 ++++++++++-----
> > >  1 file changed, 10 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> > > index c8b1f441f..ef544525f 100644
> > > --- a/fs/btrfs/send.c
> > > +++ b/fs/btrfs/send.c
> > > @@ -6263,6 +6263,7 @@ static int changed_inode(struct send_ctx
> > > *sctx,
> > >         struct btrfs_inode_item *right_ii =3D NULL;
> > >         u64 left_gen =3D 0;
> > >         u64 right_gen =3D 0;
> > > +       u64 left_rdev, right_rdev;
> > >         u64 left_type, right_type;
> > >
> > >         sctx->cur_ino =3D key->objectid;
> > > @@ -6285,6 +6286,8 @@ static int changed_inode(struct send_ctx
> > > *sctx,
> > >                                 struct btrfs_inode_item);
> > >                 left_gen =3D btrfs_inode_generation(sctx->left_path-
> > > >nodes[0],
> > >                                 left_ii);
> > > +               left_rdev =3D btrfs_inode_rdev(sctx->left_path-
> > > >nodes[0],
> > > +                               left_ii);
> > >         } else {
> > >                 right_ii =3D btrfs_item_ptr(sctx->right_path-
> > > >nodes[0],
> > >                                 sctx->right_path->slots[0],
> > > @@ -6300,6 +6303,9 @@ static int changed_inode(struct send_ctx
> > > *sctx,
> > >                 right_gen =3D btrfs_inode_generation(sctx-
> > > >right_path->nodes[0],
> > >                                 right_ii);
> > >
> > > +               right_rdev =3D btrfs_inode_rdev(sctx->right_path-
> > > >nodes[0],
> > > +                               right_ii);
> > > +
> > >                 left_type =3D S_IFMT & btrfs_inode_mode(
> > >                                 sctx->left_path->nodes[0],
> > > left_ii);
> > >                 right_type =3D S_IFMT & btrfs_inode_mode(
> > > @@ -6310,7 +6316,8 @@ static int changed_inode(struct send_ctx
> > > *sctx,
> > >                  * the inode as deleted+reused because it would
> > > generate a
> > >                  * stream that tries to delete/mkdir the root dir.
> > >                  */
> > > -               if ((left_gen !=3D right_gen || left_type !=3D
> > > right_type) &&
> > > +               if ((left_gen !=3D right_gen || left_type !=3D
> > > right_type ||
> > > +                   left_rdev !=3D right_rdev) &&
> > >                     sctx->cur_ino !=3D BTRFS_FIRST_FREE_OBJECTID)
> > >                         sctx->cur_inode_recreated =3D 1;
> > >         }
> > > @@ -6350,8 +6357,7 @@ static int changed_inode(struct send_ctx
> > > *sctx,
> > >                                 sctx->left_path->nodes[0],
> > > left_ii);
> > >                 sctx->cur_inode_mode =3D btrfs_inode_mode(
> > >                                 sctx->left_path->nodes[0],
> > > left_ii);
> > > -               sctx->cur_inode_rdev =3D btrfs_inode_rdev(
> > > -                               sctx->left_path->nodes[0],
> > > left_ii);
> > > +               sctx->cur_inode_rdev =3D left_rdev;
> > >                 if (sctx->cur_ino !=3D BTRFS_FIRST_FREE_OBJECTID)
> > >                         ret =3D send_create_inode_if_needed(sctx);
> > >         } else if (result =3D=3D BTRFS_COMPARE_TREE_DELETED) {
> > > @@ -6396,8 +6402,7 @@ static int changed_inode(struct send_ctx
> > > *sctx,
> > >                                         sctx->left_path->nodes[0],
> > > left_ii);
> > >                         sctx->cur_inode_mode =3D btrfs_inode_mode(
> > >                                         sctx->left_path->nodes[0],
> > > left_ii);
> > > -                       sctx->cur_inode_rdev =3D btrfs_inode_rdev(
> > > -                                       sctx->left_path->nodes[0],
> > > left_ii);
> > > +                       sctx->cur_inode_rdev =3D left_rdev;
> > >                         ret =3D send_create_inode_if_needed(sctx);
> > >                         if (ret < 0)
> > >                                 goto out;
> > > --
> > > 2.26.2
> > >
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
