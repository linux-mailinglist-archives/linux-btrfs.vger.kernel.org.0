Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4676846FF08
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Dec 2021 11:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbhLJKyq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Dec 2021 05:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbhLJKyq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Dec 2021 05:54:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B93EC061746;
        Fri, 10 Dec 2021 02:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E26C7B8275B;
        Fri, 10 Dec 2021 10:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A018BC341C6;
        Fri, 10 Dec 2021 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639133468;
        bh=CqIo/DlrSAAzqB9ipNA6iMx8WscEU/S8HJkZdDfdxto=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ppUPvHoY9EK1/FCeBTbjfG8EgMJubldZSTQNcsA4u1KnsqzN4IUfPLdUOgYMiwTCc
         +cJLOHT+edtPa4BI+uW/NLou4bTknAfpE8srNNgZlNhpjesj4UrZsY9c/Vh0E5NteI
         GHU1VtoVEQujk4+JpzzTX7sXYb9zZjxxQq9mt4xDzNtUz/S7EenzRdjjPFp3S5ShxF
         Lfs/rAuQ/gswllCr4G1ZE1cOFb05zvaeJ8ZOdIrFD2689w0E54WVpEwvmGSJvMLqM/
         UxN4kdTEOAB9A3ptcJ3EkF9F4BGV6vr8DzkC7TmKsqOFvOb8TOTN0sPpSj72Mf9ukf
         ZS4ySk4V4tF8Q==
Received: by mail-qt1-f169.google.com with SMTP id n15so8058466qta.0;
        Fri, 10 Dec 2021 02:51:08 -0800 (PST)
X-Gm-Message-State: AOAM532l7PoBePRQSzCAf5KjpLX0AqjNDJ6qJad6BrLqMSUyqAnSAE0b
        OZju/HCKGliUjjr/KARrUtYdfQoceMWCyXEr6kw=
X-Google-Smtp-Source: ABdhPJzTO4Oeku7HrET4zF4rV+R1ENQdk43P1elHUgAcOY5khNljWwJAl9T36eiIdYjQoTn+C5mx5ov+NNnewGptB4Y=
X-Received: by 2002:ac8:5796:: with SMTP id v22mr24020278qta.304.1639133467682;
 Fri, 10 Dec 2021 02:51:07 -0800 (PST)
MIME-Version: 1.0
References: <4e00357fe3aaa843bd8fd02218b97104e5fd74bf.1639060960.git.fdmanana@suse.com>
 <20211210002525.GB279368@dread.disaster.area>
In-Reply-To: <20211210002525.GB279368@dread.disaster.area>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 10 Dec 2021 10:50:31 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6Sq3upF+r4mfQ8jw7O=V6wTDhpaa0LKJ4aUEukfL6xhA@mail.gmail.com>
Message-ID: <CAL3q7H6Sq3upF+r4mfQ8jw7O=V6wTDhpaa0LKJ4aUEukfL6xhA@mail.gmail.com>
Subject: Re: [PATCH] generic/335: explicitly fsync file foo when running on btrfs
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 10, 2021 at 12:32 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Dec 09, 2021 at 02:44:06PM +0000, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The test is relying on the fact that an fsync on directory "a" will
> > result in persisting the changes of its subdirectory "b", namely the
> > rename of "/a/b/foo" to "/c/foo". For this particular filesystem layout,
> > that will happen on btrfs, because all the directory entries end up in
> > the same metadata leaf. However that is not a behaviour we can always
> > guarantee on btrfs. For example, if we add more files to directory
> > "a" before and after creating subdirectory "b", like this:
> >
> >   mkdir $SCRATCH_MNT/a
> >   for ((i = 0; i < 1000; i++)); do
> >       echo -n > $SCRATCH_MNT/a/file_$i
> >   done
> >   mkdir $SCRATCH_MNT/a/b
> >   for ((i = 1000; i < 2000; i++)); do
> >       echo -n > $SCRATCH_MNT/a/file_$i
> >   done
> >   mkdir $SCRATCH_MNT/c
> >   touch $SCRATCH_MNT/a/b/foo
> >
> >   sync
> >
> >   # The rest of the test remains unchanged...
> >   (...)
> >
> > Then after fsyncing only directory "a", the rename of file "foo" from
> > "/a/b/foo" to "/c/foo" is not persisted.
> >
> > Guaranteeing that on btrfs would be expensive on large directories, as
> > it would require scanning for every subdirectory. It's also not required
> > by posix for the fsync on a directory to persist changes inside its
> > subdirectories. So add an explicit fsync on file "foo" when the filesystem
> > being tested is btrfs.
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/335 | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/tests/generic/335 b/tests/generic/335
> > index e04f7a5f..196ada64 100755
> > --- a/tests/generic/335
> > +++ b/tests/generic/335
> > @@ -51,6 +51,15 @@ mv $SCRATCH_MNT/a/b/foo $SCRATCH_MNT/c/
> >  touch $SCRATCH_MNT/a/bar
> >  $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a
> >
> > +# btrfs can not guarantee that when we fsync a directory all its subdirectories
> > +# created on past transactions are fsynced as well. It may do it sometimes, but
> > +# it's not guaranteed, giving such guarantees would be too expensive for large
> > +# directories and posix does not require that recursive behaviour. So if we want
> > +# the rename of "foo" to be persisted, explicitly fsync "foo".
> > +if [ $FSTYP == "btrfs" ]; then
> > +     $XFS_IO_PROG -c "fsync" $SCRATCH_MNT/c/foo
> > +fi
>
> Doesn't this imply a regression in the behaviour of btrfs? After
> all, this test was written explicitly to exercise a bug in btrfs log
> recovery:
>
> commit 72da52702a4b5bea1170aed791893487d0748566
> Author: Filipe Manana <fdmanana@suse.com>
> Date:   Fri Feb 19 12:15:17 2016 +1100
>
>     generic: test directory fsync after rename operation
>
>     Test that if we move one file between directories, fsync the parent
>     directory of the old directory, power fail and remount the filesystem,
>     the file is not lost and it's located at the destination directory.
>
>     This is motivated by a bug found in btrfs, which is fixed by the patch
>     (for the linux kernel) titled:
>
>       "Btrfs: fix file loss on log replay after renaming a file and fsync"
>
>     Tested against ext3, ext4, xfs, f2fs and reiserfs.
>
>     Signed-off-by: Filipe Manana <fdmanana@suse.com>
>     Reviewed-by: Dave Chinner <dchinner@redhat.com>
>     Signed-off-by: Dave Chinner <david@fromorbit.com>
>
> What's changed that now makes this an invalid test for btrfs log
> recovery? Has btrfs loosened it's metadata ordering guarantees in
> the past few years?

No, btrfs has not loosened its metadata ordering guarantees.
The test was written because btrfs had a bug where it would lose file
foo if we fsynced only directory "/a".

I should have made the test check that after log replay, file foo
exists either at "/c/foo" or at "/a/b/foo" - that the file was not
lost.
Perhaps that's a better change than making the test fsync file foo explicitly.

As I mentioned in the changelog, in this particular case the rename is
persisted,
because all the metadata is very small and fits in a single leaf of metadata.

But, for example, adding those 1000 files after creating "/a" and
another 1000 files after creating "/a/b", makes
the test fail because it expects the rename to have been persisted,
that file foo is at "/c/foo" - in that case
the file is still at "/a/b/foo".

Thanks.



>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
