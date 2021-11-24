Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1087A45C734
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 15:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350362AbhKXO2u (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 09:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353081AbhKXO1u (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 09:27:50 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AC5C08EC36;
        Wed, 24 Nov 2021 04:52:19 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id m17so1651377qvx.8;
        Wed, 24 Nov 2021 04:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Rk2+Lzqze2vtgSadafVqZ0x2GIQIAw5gHAk0AulbEj4=;
        b=gapOsMbQqFp2EHZ7BAaJl5/muRC168pmA1UKKBHrQtfFF4gdFaj/7JhfWPfvUATRgk
         sFB6FMYkYfTReLSLf2hkhBGfl+EzUyJPXPRU/opccpcXS8R9cPHFsyM0Gc/KQx3/aND5
         kJ6NixAl+FLgXPGq/MCNA026F5n51vVlqf0KW9tKGIuW1e/XdFC8kTdDyKI4EC+yT8hn
         7KF3mJDS9I8B9IdowZHBx9lA1d3+YFFN16o59OoRDFJgzLRKjVsnqCSe9arqH0ujnzcV
         b5HMgTpKTPkd51gXFkAhn/fiYnPOqr9IOGLmsOv7qs0zhT24FLEUqyRcJo61PdfZLtRW
         7h1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Rk2+Lzqze2vtgSadafVqZ0x2GIQIAw5gHAk0AulbEj4=;
        b=5NGqCvFoyAtn07qbwdMwivc1Fi2zXbmBGN8BC55VO7GvxI2kxDO1sEyPLWrpHhDEaJ
         cba0lm5tE9xDqfls2RSSJen54xmY0rZurpdVtbH9CP9YfywWIDgN02OTzkZebPOBm+4c
         miCbntXYtac4lJhl9IK3QtydrXz6s2BkAe5FQ4EEpuZ9o7wtE/eFmax0tHiOTz72Xudu
         pgCbj7TyCpdP3kngsDxl3q71NjzsV9XHbuGBM0wfIe33UjAWur2HDWj8f8TfFV9Upuic
         KaTozZE1cth/TOoMrW7/MaxeSPRXRZrtX4c4G3G0QscEcpMcpN79xfDpbYHfIYPOLRnT
         /Evw==
X-Gm-Message-State: AOAM532y6DEpuAX6YQ6mSaXH86jupeUh5ywRqRSXoIUMm+0pVKLyLOQ/
        WzJc3zZucDFS5gYZJdKEJRnLnRndhfxvDl/Pltc6WRyPuR8=
X-Google-Smtp-Source: ABdhPJxgFXdFxhErqvOZ9e6eesizjmpKQsmOZqUq/E///EQH63Ce3uNM+bRNAifzNwQdXRkCO1bE/QCvpsohBS+1leY=
X-Received: by 2002:a05:6214:224e:: with SMTP id c14mr7261052qvc.41.1637758338415;
 Wed, 24 Nov 2021 04:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20211124065219.33409-1-wqu@suse.com> <CAL3q7H7FB96c753TniOvZwqqOvvT0MFiyjg0=Ev9wHThD4z-Kw@mail.gmail.com>
 <e094e7d5-7f4c-2583-db85-fe296ce24528@gmx.com>
In-Reply-To: <e094e7d5-7f4c-2583-db85-fe296ce24528@gmx.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Wed, 24 Nov 2021 12:51:42 +0000
Message-ID: <CAL3q7H5PnRLEFnwUDmS5igBbGBxJW7+EaCvEi7ig78S-7mWcZw@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs/049: add regression test for
 compress-force mount options
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 24, 2021 at 12:28 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/11/24 19:22, Filipe Manana wrote:
> > On Wed, Nov 24, 2021 at 9:24 AM Qu Wenruo <wqu@suse.com> wrote:
> >>
> >> Since kernel commit d4088803f511 ("btrfs: subpage: make lzo_compress_p=
ages()
> >> compatible"), lzo compression no longer respects the max compressed pa=
ge
> >> limit, and can cause kernel crash.
> >>
> >> The upstream fix is 6f019c0e0193 ("btrfs: fix a out-of-bound access in
> >> copy_compressed_data_to_page()").
> >>
> >> This patch will add such regression test for all possible compress-for=
ce
> >> mount options, including lzo, zstd and zlib.
> >>
> >> And since we're here, also make sure the content of the file matches
> >> after a mount cycle.
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >> Changelog:
> >> v2:
> >> - Also test zlib and zstd
> >> - Add file content verification check
> >> ---
> >>   tests/btrfs/049     | 56 +++++++++++++++++++++++++++++++++++++++++++=
++
> >>   tests/btrfs/049.out |  6 +++++
> >>   2 files changed, 62 insertions(+)
> >>   create mode 100755 tests/btrfs/049
> >>
> >> diff --git a/tests/btrfs/049 b/tests/btrfs/049
> >> new file mode 100755
> >> index 00000000..264e576f
> >> --- /dev/null
> >> +++ b/tests/btrfs/049
> >> @@ -0,0 +1,56 @@
> >> +#! /bin/bash
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +# Copyright (C) 2021 SUSE Linux Products GmbH. All Rights Reserved.
> >> +#
> >> +# FS QA Test 049
> >> +#
> >> +# Test if btrfs will crash when using compress-force mount option aga=
inst
> >> +# incompressible data
> >> +#
> >> +. ./common/preamble
> >> +_begin_fstest auto quick compress dangerous
> >> +
> >> +# Override the default cleanup function.
> >> +_cleanup()
> >> +{
> >> +       cd /
> >> +       rm -r -f $tmp.*
> >> +}
> >> +
> >> +# Import common functions.
> >> +. ./common/filter
> >> +
> >> +# real QA test starts here
> >> +
> >> +# Modify as appropriate.
> >> +_supported_fs btrfs
> >> +_require_scratch
> >> +
> >> +pagesize=3D$(get_page_size)
> >> +workload()
> >> +{
> >> +       local compression
> >> +       compression=3D$1
> >
> > Could be shorter by doing it in one step:
> >
> > local compression=3D$1
> >
> >> +
> >> +       echo "=3D=3D=3D Testing compress-force=3D$compression =3D=3D=
=3D"
> >> +       _scratch_mkfs -s "$pagesize">> $seqres.full
> >> +       _scratch_mount -o compress-force=3D"$compression"
> >> +       $XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 $pagesize" \
> >> +               "$SCRATCH_MNT/file" > /dev/null
> >> +       md5sum "$SCRATCH_MNT/file" > "$tmp.$compression"
> >
> > This doesn't really check if everything we asked to write was actually =
written.
> > pwrite(2), write(2), etc, return the number of bytes written, which
> > can be less than what we asked for.
> >
> > And using the checksum verification in that way, we are only checking
> > that what we had before unmounting is the same after mounting again.
> > I.e. we are not checking that what was actually written is what we
> > have asked for.
> >
> > We could do something like:
> >
> > data=3D$(dd count=3D4096 bs=3D1 if=3D/dev/urandom)
> > echo -n "$data" > file
>
> The reason I didn't want to use dd is it doesn't have good enough
> wrapper in fstests.
> (Thus I guess that's also the reason why you use above command to
> workaround it)
>
> If you're really concerned about the block size, it can be easily
> changed using "-b" option of pwrite, to archive the same behavior of the
> dd command.
>
> Furthermore, since we're reading from urandom, isn't it already ensured
> we won't get blocked nor get short read until we're reading very large
> blocks?

I gave dd as an example, but I don't care about dd at all, it can be
xfs_io or anything else.

My whole point was about verifying that what's written to the file is
what we intended to write.

Verifying the checksum is fine when we know exactly what we asked to
write, when the test hard codes what we want to write.

In this case we're asking to write random content, so doing an md5sum
of the file after writing and
then comparing it to what we get after we unmount and mount again, is
not a safe way to test we have the
expected content.

>
> Thus a very basic filter on the pwrite should be enough to make sure we
> really got page sized data written.

It's not just about checking if the size of what was written matches
what we asked to write.
It's all about verifying the written content matches what we asked to
write in the first place (which implicitly ends up verifying the size
as well when using a checksum).

>
> Thanks,
> Qu
>
> >
> > _scratch_cycle_mount
> >
> > check that the the md5sum of file is the same as:  echo -n "$data" | md=
5sum
> >
> > As it is, the test is enough to trigger the original bug, but having
> > such additional checks is more valuable IMO for the long run, and can
> > help prevent other types of regressions too.
> >
> > Thanks Qu.
> >
> >
> >> +
> >> +       # When unpatched, compress-force=3Dlzo would crash at data wri=
teback
> >> +       _scratch_cycle_mount
> >> +
> >> +       # Make sure the content matches
> >> +       md5sum -c "$tmp.$compression" | _filter_scratch
> >> +       _scratch_unmount
> >> +}
> >> +
> >> +workload lzo
> >> +workload zstd
> >> +workload zlib
> >> +
> >> +# success, all done
> >> +status=3D0
> >> +exit
> >> diff --git a/tests/btrfs/049.out b/tests/btrfs/049.out
> >> index cb0061b3..258f3c09 100644
> >> --- a/tests/btrfs/049.out
> >> +++ b/tests/btrfs/049.out
> >> @@ -1 +1,7 @@
> >>   QA output created by 049
> >> +=3D=3D=3D Testing compress-force=3Dlzo =3D=3D=3D
> >> +SCRATCH_MNT/file: OK
> >> +=3D=3D=3D Testing compress-force=3Dzstd =3D=3D=3D
> >> +SCRATCH_MNT/file: OK
> >> +=3D=3D=3D Testing compress-force=3Dzlib =3D=3D=3D
> >> +SCRATCH_MNT/file: OK
> >> --
> >> 2.34.0
> >>
> >
> >



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
