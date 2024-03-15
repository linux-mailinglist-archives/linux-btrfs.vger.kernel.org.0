Return-Path: <linux-btrfs+bounces-3331-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E787D677
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E9F1C21A22
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Mar 2024 22:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201B54FAF;
	Fri, 15 Mar 2024 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b="Y0Xo58Sh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A592A14276
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710540946; cv=none; b=t9ALoCPQFVkojxmI6IbG0IknSUE0H+DIDSTLUCGL6oRgtWhT1qzqSiEu5DduWzOK87VdBersd+PxZOGhOjstOFY+JfNeuWa/WPWkPw6JiVPDdnFOSsnYsZKvDFVuJeczcMJuOSVMVeY8Qy5n1GQUhNf09gxhNM1lYBQ8qz0w+rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710540946; c=relaxed/simple;
	bh=OwhO9/NkKg2/T3JPZahy02IgQElQHUJCFVNCGjIiDqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfCAWlN8cUoMfxeCUC3so9Voc6NA0uOT02SnLhe+2HVAUFeyfiKxnJ+vHUOaORiWPUwSX7pHcML2oGrTYejPhGCAYo+fO4Glk5nUpL1x0yvHuauaC5RyyTF6RiyMty0n0WeKbkqtM6GLS/Cwh1BK7DK0p7F+2sdD3EPb8pHtDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=tavianator.com header.i=@tavianator.com header.b=Y0Xo58Sh; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6918a0edcfaso889966d6.1
        for <linux-btrfs@vger.kernel.org>; Fri, 15 Mar 2024 15:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tavianator.com; s=google; t=1710540942; x=1711145742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtF8S3yLO9lZDN/jCdf1u3slAlPKU2NzNzH13kQn298=;
        b=Y0Xo58ShfLCXo9bGgoT/D4GMF46MbHwDKTZryg2+xZwFOSYI07kZq/NOetoLOnBUal
         aYBG8YZ3vD8YXlMlqu0og9rB6uoeFka7diGXZ4eCneMCIDAWL4q52jFUkOE3+h5zUC47
         3sUmLoZJhgeApNqzWcbKyFOqNlPv6J1g2cy2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710540942; x=1711145742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtF8S3yLO9lZDN/jCdf1u3slAlPKU2NzNzH13kQn298=;
        b=cBZ3+p6k3QKkcVBfBLAjQRuU3yJt0HX5VOUJrBIsgzlOvYaqxj7cj/5QzjbgSEjROx
         5jqvKSti2mlaPiWcFsIBW3ur22cQd6BcCGtRS+wu/rGxXxiTjlJuSp4AX0cICA1YZSuW
         WQOVngpcnMg2uxPXDcPhg/AcITpfhZqvMa8Qko5sKIyQjyab3l1DVqUJTJlrh4JciojT
         3DucUkHbAXC73olDnXh23MUiSaUx+R5DzWaZj7xD8GZPw97z5K03vJvsIMLtiT4++lX0
         dDQrGnz2dBvAhtlfQbF7nTy+FGbfUCHoNfcw8umcKaWOkkuAjqjibECdbpWtb1370nVg
         rYvA==
X-Gm-Message-State: AOJu0YwXoTDcw6gFbVQTuPJGjsl+iGRQ3QYVeA/nDqHvM0tsQ1JQTsk0
	J4DaVfO8E9hEEGL//oZh73D+mN1Gq/mbXxZC5MtcBxgcqWQTxrsTbrIfvW3X0g8WfRUj667oOBb
	GdEiEiIQuIqRWtAmaFpvK0MXLEbs=
X-Google-Smtp-Source: AGHT+IHhAihe98NKJjJbdSRgSo40wR2rPR0+h3lY6xhZsqvR8qzJUyieFU36KrgKK/qSx98ZvI3np+UTMGe1i5HU9wU=
X-Received: by 2002:a0c:f0d4:0:b0:691:629d:d26b with SMTP id
 d20-20020a0cf0d4000000b00691629dd26bmr4981481qvl.35.1710540942429; Fri, 15
 Mar 2024 15:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c7241ea4-fcc6-48d2-98c8-b5ea790d6c89@gmx.com> <CABg4E-nKSZR4kvAGfxKLwAoH1_fJXwQb91spFAMsU9L1vqEpiA@mail.gmail.com>
 <CABg4E-mRsvA5DWnwajpQzr2dbb6Efv=wxP+KCyVYHd2OqiMP_w@mail.gmail.com> <0d03ff62-7841-4559-b41e-173bf5dd848b@gmx.com>
In-Reply-To: <0d03ff62-7841-4559-b41e-173bf5dd848b@gmx.com>
From: Tavian Barnes <tavianator@tavianator.com>
Date: Fri, 15 Mar 2024 18:15:31 -0400
Message-ID: <CABg4E-mNTRoTqW9Hj=9tO=8=N3PQx7C-BYee1V6QMtGDiqr9eg@mail.gmail.com>
Subject: Re: About the weird tree block corruption
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:21=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
> =E5=9C=A8 2024/3/16 06:31, Tavian Barnes =E5=86=99=E9=81=93:
> > On Fri, Mar 15, 2024 at 11:23=E2=80=AFAM Tavian Barnes
> > <tavianator@tavianator.com> wrote:
> >> On Wed, Mar 13, 2024 at 2:07=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.=
com> wrote:
> >>> [SNIP]
> >>>
> >>> The second patch is to making tree-checker to BUG_ON() when something
> >>> went wrong.
> >>> This patch should only be applied if you can reliably reproduce it
> >>> inside a VM.
> >>
> >> Okay, I have finally reproduced this in a VM.  I had to add this hunk
> >> to your patch 0002 in order to trigger the BUG_ON:
> >>
> >> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> >> index c8fbcae4e88e..4ee7a717642a 100644
> >> --- a/fs/btrfs/tree-checker.c
> >> +++ b/fs/btrfs/tree-checker.c
> >> @@ -2047,6 +2051,7 @@ int btrfs_check_eb_owner(const struct
> >> extent_buffer *eb, u64 root_owner)
> >>                                  btrfs_header_level(eb) =3D=3D 0 ? "le=
af" : "node",
> >>                                  root_owner, btrfs_header_bytenr(eb), =
eb_owner,
> >>                                  root_owner);
> >> +                       BUG_ON(1);
> >>                          return -EUCLEAN;
> >>                  }
> >>                  return 0;
> >> @@ -2062,6 +2067,7 @@ int btrfs_check_eb_owner(const struct
> >> extent_buffer *eb, u64 root_owner)
> >>                          btrfs_header_level(eb) =3D=3D 0 ? "leaf" : "n=
ode",
> >>                          root_owner, btrfs_header_bytenr(eb), eb_owner=
,
> >>                          BTRFS_FIRST_FREE_OBJECTID, BTRFS_LAST_FREE_OB=
JECTID);
> >> +               BUG_ON(1);
> >>                  return -EUCLEAN;
> >>          }
> >>          return 0;
> >>
> >>> When using the 2nd patch, it's strongly recommended to enable the
> >>> following sysctl:
> >>>
> >>>    kernel.ftrace_dump_on_oops =3D 1
> >>>    kernel.panic =3D 5
> >>>    kernel.panic_on_oops =3D 1
> >>
> >> I also set kernel.oops_all_cpu_backtrace =3D 1, and ran with nowatchdo=
g,
> >> otherwise I got watchdog backtraces (due to slow console) interspersed
> >> with the traces which was hard to read.
> >>
> >>> And you need a way to reliably access the VM (either netconsole or a
> >>> serial console setup).
> >>> In that case, you would got all the ftrace buffer to be dumped into t=
he
> >>> netconsole/serial console.
> >>>
> >>> This has the extra benefit of reducing the noise. But really needs a
> >>> reliable VM setup and can be a little tricky to setup.
> >>
> >> I got this to work, the console logs are attached.  I added
> >>
> >>      echo 1 > $tracefs/buffer_size_kb
> >>
> >> otherwise it tried to dump 48MiB over the serial console which I
> >> didn't have the patience for.  Hopefully that's a big enough buffer, I
> >> can re-run it if you need more logs.
> >>
> >>> Feel free to ask for any extra help to setup the environment, as you'=
re
> >>> our last hope to properly pin down the bug.
> >>
> >> Hopefully this trace helps you debug this.  Let me know whenever you
> >> have something else for me to test.
> >>
> >> I can also try to send you the VM, but I'm not sure how to package it
> >> up exactly.  It has two (emulated) NVMEs with LUKS and BTRFS raid0 on
> >> top.
> >
> > I added eb->start to the "corrupted node/leaf" message so I could look
> > for relevant lines in the trace output.  From another run, I see this:
> >
> > $ grep 'eb=3D15302115328' typescript-5
> > [ 2725.113804] BTRFS critical (device dm-0): corrupted leaf, root=3D258
> > block=3D15302115328 owner mismatch, have 13709377558419367261 expect
> > [256, 18446744073709551360] eb=3D15302115328
> > [ 2740.240046] iou-wrk--173727   15..... 2649295481us :
> > alloc_extent_buffer: alloc_extent_buffer: alloc eb=3D15302115328
> > len=3D16384
> > [ 2740.301767] kworker/-322      15..... 2649295735us :
> > end_bbio_meta_read: read done, eb=3D15302115328 page_refs=3D3 eb level=
=3D0
> > fsid=3Db66a67f0-8273-4158-b7bf-988bb5683000
> > [ 2740.328424] kworker/-5095     31..... 2649295941us :
> > end_bbio_meta_read: read done, eb=3D15302115328 page_refs=3D8 eb level=
=3D0
> > fsid=3Db66a67f0-8273-4158-b7bf-988bb5683000
> >
> > I am surprised to see two end_bbio_meta_read lines with only one
> > matching alloc_extent_buffer.  That made me check the locking in
> > read_extent_buffer_pages() again, and I think I may have found
> > something.
> >
> > Let's say we get two threads simultaneously call
> > read_extent_buffer_pages() on the same eb.  Thread 1 starts reading:
> >
> >      if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
> >          return 0;
> >
> >      /*
> >       * We could have had EXTENT_BUFFER_UPTODATE cleared by the write
> >       * operation, which could potentially still be in flight.  In this=
 case
> >       * we simply want to return an error.
> >       */
> >      if (unlikely(test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags)))
> >          return -EIO;
> >
> >      /* (Thread 2 pre-empted here) */
> >
> >      /* Someone else is already reading the buffer, just wait for it. *=
/
> >      if (test_and_set_bit(EXTENT_BUFFER_READING, &eb->bflags))
> >          goto done;
> >      ...
> >
> > Meanwhile, thread 2 does the same thing but gets preempted at the
> > marked point, before testing EXTENT_BUFFER_READING.  Now the read
> > finishes, and end_bbio_meta_read() does
> >
> >              btrfs_folio_set_uptodate(fs_info, folio, start, len);
> >      ...
> >      clear_bit(EXTENT_BUFFER_READING, &eb->bflags);
> >      smp_mb__after_atomic();
> >      wake_up_bit(&eb->bflags, EXTENT_BUFFER_READING);
> >
> > Now thread 2 resumes executing, atomically sets EXTENT_BUFFER_READING
> > (again) and starts reading into the already-filled-in extent buffer.
> > This might normally be a benign race, except end_bbio_meta_read() has
> > also set EXTENT_BUFFER_UPTODATE.  So now if a third thread tries to
> > read the same extent buffer, it will do
> >
> >      if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
> >          return 0;
> >
> > and return 0 *while the eb is still under I/O*.  The caller will then
> > try to read data from the extent buffer which is concurrently being
> > updated by the extra read started by thread 2.
>
> Awesome! Not only you got a super good trace, but even pinned down the
> root cause.

Thanks!

> The trace indeed shows duplicated metadata read endio finishes, which
> means we indeed have race where we shouldn't.

Okay, glad to see I read the trace correctly.  Now that we think we
understand it, can you think of a more reliable reproducer?  It would
need lots of read_block_for_search() on the same block in parallel.

> Although I'm not 100% sure about the fix, the normal way we handle it
> would be locking the page before IO, and unlock it at endio time.

Fair enough, I don't really know the locking rules in btrfs or fs/mm
generally.  I'm pretty sure the double-checked approach from my patch
is enough to protect read_extent_buffer_pages() from racing with
itself in the way I described, but I don't know if a lock may be
required for other reasons.  It might be nice to avoid taking a lock
in this path but I'm not sure how important that is.

I do see that this code path used to take page locks until commit
d7172f52e993 ("btrfs: use per-buffer locking for extent_buffer
reading").

I'm currently re-running the reproducer with my patch.  If it survives
the night without crashing, I'll post it formally, unless you'd like
to do it a different way.

> I believe we can do that and properly solve it.
> And go with fallbacks to use spinlock to make all the bits testing in a
> critical section if the page lock one is no feasible.
>
> Thank you so much!
> You really saved us all!

No problem, happy to help :)

> Thanks,
> Qu

--=20
Tavian Barnes

