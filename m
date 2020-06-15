Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9DA1F95AC
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jun 2020 13:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgFOLyK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Jun 2020 07:54:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgFOLyK (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Jun 2020 07:54:10 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6121A20714;
        Mon, 15 Jun 2020 11:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592222049;
        bh=w2Ikr63aPR/zBv8aefHNvfVKdUAbVhmiKMt8IkkE00o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rk+Jwby//cFxWe+3srgvWEpbEzTN3T6Gkbm7Ft+qfDkeYrUy44k2UjJSsAaRK0XHD
         N2ShA++qHgxdb3LaaeODMhJ6RZDTdmNwPxdRE0bJr/QeeZ9uRX7ZbFGlo08oWZ+Lun
         WmfBLQl7bI+KLYaWQxcRuMtENbDdXnGSz0pCGOCI=
Received: by mail-ua1-f42.google.com with SMTP id r1so5549317uam.6;
        Mon, 15 Jun 2020 04:54:09 -0700 (PDT)
X-Gm-Message-State: AOAM533cNaoHAQE1mKiPEQtIo7ASeKsL8OE2/0jAxQQ7B/BLEwnFdRvu
        2gH9zwo52zCiycqVbQtTGnxJQDbepgj0jakvrAg=
X-Google-Smtp-Source: ABdhPJyTb3ZGnJwNZA7tfNKQ23pOVqIc7F3zGjALmGdRkzRpvuh++O6ZvvVbdeLC5Pa5DlSfNNUI7bBDvjy6QnriqwU=
X-Received: by 2002:ab0:224d:: with SMTP id z13mr18467543uan.83.1592222048487;
 Mon, 15 Jun 2020 04:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200612140604.2790275-1-fdmanana@kernel.org> <89ce0d58-5c7b-2cb9-ba8b-d4320340c234@gmx.com>
In-Reply-To: <89ce0d58-5c7b-2cb9-ba8b-d4320340c234@gmx.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 15 Jun 2020 12:53:57 +0100
X-Gmail-Original-Message-ID: <CAL3q7H42yO5Z_DGhmgrSPYoWR3i13WOPawJUm-cqN1sJwDekkw@mail.gmail.com>
Message-ID: <CAL3q7H42yO5Z_DGhmgrSPYoWR3i13WOPawJUm-cqN1sJwDekkw@mail.gmail.com>
Subject: Re: [PATCH] generic/471: adapt test when running on btrfs to avoid
 failure on RWF_NOWAIT write
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 14, 2020 at 6:14 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2020/6/12 =E4=B8=8B=E5=8D=8810:06, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > This test currently always fails on btrfs:
> >
> > generic/471 2s ... - output mismatch (see ...results//generic/471.out.b=
ad)
> >     --- tests/generic/471.out   2020-06-10 19:29:03.850519863 +0100
> >     +++ /home/fdmanana/git/hub/xfstests/results//generic/471.out.bad   =
...
> >     @@ -2,12 +2,10 @@
> >      pwrite: Resource temporarily unavailable
> >      wrote 8388608/8388608 bytes at offset 0
> >      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> >     -RWF_NOWAIT time is within limits.
> >     +pwrite: Resource temporarily unavailable
> >     +(standard_in) 1: syntax error
> >     +RWF_NOWAIT took  seconds
> >
> > This is because btrfs is a COW filesystem and an attempt to write into =
a
> > previously written file range allocating a new extent (or multiple).
> > The only exceptions are when attempting to write to a file range with a
> > preallocated/unwritten extent or when writing to a NOCOW file that has
> > extents allocated in the target range already.
> >
> > The test currently expects that writing into a previously written file
> > range succeeds, but that is not true on btrfs since we are not dealing
> > with a NOCOW file. So to make the test pass on btrfs, set the NOCOW bit
> > on the file when the filesystem is btrfs.
>
> Completely agree with the point for btrfs.
>
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/471 | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/tests/generic/471 b/tests/generic/471
> > index 7513f023..e9856b52 100755
> > --- a/tests/generic/471
> > +++ b/tests/generic/471
> > @@ -37,6 +37,17 @@ fi
> >
> >  mkdir $testdir
> >
> > +# Btrfs is a COW filesystem, so a RWF_NOWAIT write will always fail wi=
th -EAGAIN
> > +# when writing to a file range except if it's a NOCOW file and an exte=
nt for the
> > +# range already exists or if it's a COW file and preallocated/unwritte=
n extent
> > +# exists in the target range. So to make sure that the last write succ=
eeds on
> > +# all filesystems, use a NOCOW file on btrfs.
> > +if [ $FSTYP =3D=3D "btrfs" ]; then
>
> Although I'm not sure if really only specific to btrfs.
> XFS has its always_cow sysfs interface to make data write to always do
> COW, just like what btrfs do by default.
>
> Thus I believe this may be needed for all fses, and just ignore the
> error if the fs doesn't support COW.

I don't understand your point.
If that flag is enabled on xfs (iirc it's a debug flag), the test
would fail on xfs even if we attempt chattr +C (afaics xfs doesn't
support +C).
So I don't see the benefit of always doing it.

Thanks.


>
> Thanks,
> Qu
>
> > +     _require_chattr C
> > +     touch $testdir/f1
> > +     $CHATTR_PROG +C $testdir/f1
> > +fi
> > +
> >  # Create a file with pwrite nowait (will fail with EAGAIN)
> >  $XFS_IO_PROG -f -d -c "pwrite -N -V 1 -b 1M 0 1M" $testdir/f1
> >
> >
>
