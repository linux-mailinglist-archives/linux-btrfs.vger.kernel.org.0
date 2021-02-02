Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F339730BD85
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Feb 2021 12:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbhBBL50 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Feb 2021 06:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhBBL5Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Feb 2021 06:57:25 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2B7C061573
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Feb 2021 03:56:45 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id l23so14633001qtq.13
        for <linux-btrfs@vger.kernel.org>; Tue, 02 Feb 2021 03:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=7lsCzJGHLvr8Kj2E1UlXtenLUTlo64+FCBy95fDW3Cg=;
        b=DzaK3QBTE8qh2JHpIWyeIorAFMa5M99xqaH61sMYWU1HgRwHIf1dcdAKA6d1BF+m5c
         un7b6FSeqS/aNgvf0l8aZCPQHsXu9u/cd9jk3C1EH/qJP61DRXpK02htTDVwxKi1EzfT
         lkGebkFGl09qTbMF3re4ptZSyn6MtK6pi0zZbYODGM7+RPslymwaIKMS5rQTWn8+hvtM
         fyn2qM6Sqnj8ZV8/i8lUzPBRpPYM9cgrjvbEUj4ihXsqgwrgh/PEHYtOlFJVh5La/EFX
         4gSUxUJs7B8HT3SeLxuw9RS+/q2S6VBsIibv0Uky6r1DeBPKdgZJvN9oARve7Ms2yFT0
         KytQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=7lsCzJGHLvr8Kj2E1UlXtenLUTlo64+FCBy95fDW3Cg=;
        b=gxethLmnV4/fdYkamXPIHnj1jrPHF5pADv2C7027fObN1zHf9JOqnnr8cuYyhiII7G
         qNFayVtGJmz5kw8LhQk1JfTdAMs+wN4N3m8TiD0Fxtn1wqSnkO7X3rOF57VUl7GXyrKE
         5wtjytKdNfmq8lr0AZrlt2vEokQByIT6Rg4VzhGdDO+H+sBhMLpHUZX01MJ2nNA6Gnq1
         hjvaHFz8uM9HXK28Q5gNkl9NscPP2CCh3GU1i+DidF9an3X5TXt+eqBwNVxdZCqBJmuP
         ivWGFFcgiD54dIferf87y0OjCwWstQNxvSy4p+G4E1NeG3jG0e/VYXCsG9SI3cWCHeB0
         dt4A==
X-Gm-Message-State: AOAM530R60FMYcKfzhKRrixUt9YmDbGtj/Co+PSiQNc0V0JYEMM3SB84
        lW4+5HciYCdDK3uvFqfJTmtxBks/SLXUqUyIb3Ibyb0n
X-Google-Smtp-Source: ABdhPJynSRmcWBbeItCSSYWLXAy6+Fxt0JKpDuooebQJJK49X2QCbNyEmWfdoeFL49zcdWMELZtLTYF80RKvg5p8lzs=
X-Received: by 2002:ac8:7762:: with SMTP id h2mr19294360qtu.259.1612267004940;
 Tue, 02 Feb 2021 03:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20210125194210.24071-1-roman.anasal@bdsu.de> <20210125194210.24071-4-roman.anasal@bdsu.de>
 <CAL3q7H79meSfikTKvTujQzA_SRb3bfF9ajYtWSVTfu0+pLE8wQ@mail.gmail.com> <aa2cf62fc268c9db63d47ef408accca79bc7b22f.camel@bdsu.de>
In-Reply-To: <aa2cf62fc268c9db63d47ef408accca79bc7b22f.camel@bdsu.de>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Tue, 2 Feb 2021 11:56:33 +0000
Message-ID: <CAL3q7H7DcSuM4ba6HU3vjsZ+h-i61Gb-21D1sqLScD0sdX2xZQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] btrfs: send: fix invalid commands for inodes with
 changed rdev but same gen
To:     "Roman Anasal | BDSU" <roman.anasal@bdsu.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jan 31, 2021 at 3:52 PM Roman Anasal | BDSU
<roman.anasal@bdsu.de> wrote:
>
> On Mon, Jan 25, 2021 at 20:51 +0000 Filipe Manana wrote:
> > On Mon, Jan 25, 2021 at 7:51 PM Roman Anasal <roman.anasal@bdsu.de>
> > wrote:
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
> Since this should be fixed then I'd like to propose to add the
> following check:
>
> The inodes of the subvolumes' root directories (ino
> BTRFS_FIRST_FREE_OBJECTID =3D 256) must have the same generation.
>
> Since create_subvol() will always commit the transaction, i.e.
> increment the generation, no two _independently_ created subvolumes can
> be created within the same generation (are there race conditions
> possible here?).

That is currently true, but it has been discussed and proposed the
ability to skip the transaction commit when creating a subvolume
Boris sent a proposal patch for that a few months ago.

I don't think that should be assumed. Avoiding the transaction commit,
either by default or optionally, is something that makes sense.
Plus for a case like snapshots, we can actually batch the creation of
several ones in a single transaction.

> Taking a snapshot of a subvolume does not modify the generation of the
> root dir inode. Also it is not possible to change or delete/re-create
> the root directory of a subvolume since this would delete the subvolume
> itself.
>
>
> So having two subvolumes with root directories created with different
> generations means they were created independently and can not share a
> common ancestor. Doing an incremental send with them is unsafe and thus
> must return an error.
> With the root directories at the same generation though the subvolumes
> are based on a common ancestor which is a requirement for a safe
> incremental send.
>
> Are my assumptions and my understanding here correct? Then this check
> would catch most of the unsafe parents.
> If so I could have a shot at a patch for this if you'd like me to?

That is too complex and makes too many assumptions.

To check if two roots are snapshots of the same subvolume (the send
and parent roots), you can simply check if they have non-null uuids in
the "parent_uuid" field of their root items and that they match.

While this is more straightforward to do in the kernel, I would prefer
to have it in btrfs-progs, because:

1) In btrfs-progs we can explicitly print an informative error message
to the user, while in the kernel you can only return an errno value
and log something dmesg/syslog, which is much less user friendly;

2) The check would be on by default but could be skipped with some new
flag - this is just being conservative to avoid breaking any existing
workflows we might not be aware of.
    In particular I'm thinking about people using "btrfs send" with -c
and omitting -p, in which case btrfs-progs selects one of the -c roots
to be used as the parent root,
    but the selected root might not be a snapshot of the same
subvolume as the send root.
    Then maybe one day that option to skip the check would be removed,
after we are more sure no one is using or really needs such workflows.

>
>
> This check still does not solve the second edge case though, when
> snapshots are modified afterwards and diverge independently form one
> another. For this I still see no good solution besides a new on-disk
> flag whether a snapshot was *ever* set to ro=3Dfalse. But with that I'm
> not sure how to (not) inherit that flag in a safe way ...

I'm afraid there's nothing, codewise, to do about that case.

Setting some flag on the root to make it unusable for send in case it
was ever RW would break send in at least one way:

During a receive we create the root as RW, apply the send stream and
then change the root to RO.
After such change, it would mean we could not send the received
snapshot anymore. There's no way to make sure that only btrfs-receive
can do that, since anyone can use the ioctl.

Perhaps all that needs to be done is to document this well in the man
pages and wiki in case it's not already there.

Thanks.


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
