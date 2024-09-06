Return-Path: <linux-btrfs+bounces-7874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C46896F206
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 12:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C119B215F3
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Sep 2024 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1901CB12A;
	Fri,  6 Sep 2024 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqIGY5A5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966C2153598;
	Fri,  6 Sep 2024 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725620287; cv=none; b=ocudq/H897+/gwf9IC9iLiPxp6HunjvGH0R2hmZo+p5ZjOTCwRbYv83RDcityvF0U5zezF6ZF5Du/nBiYVRgiPK2KXuX0tddWx8kID3BZLIydhXC+Ip4ixjDE7pWeOBomJeXSljo9vJfzJG/faQK7LgX1pOmbRXnZ2mHd9aEL74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725620287; c=relaxed/simple;
	bh=et5ZYns8cNxVyrpeLE+6LL67AiY4UA/kzfzWpxSuSSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smrv4J4+4jzVCYnyHT6Xm8IjmKy8DNO7DrmkvZbw2mShYXbEY2O5SPVzbkcbT7SovGmptYfh0CusxEYdjobYtnIFHltd3zUKmnoJRxXvfK/NLJlzkYOLfaUAcsJcS78+ZIj8X+IcNoSKKoWI04OeZXo3XHdiTmTHVEndULzM8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqIGY5A5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23C8DC4CEC5;
	Fri,  6 Sep 2024 10:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725620287;
	bh=et5ZYns8cNxVyrpeLE+6LL67AiY4UA/kzfzWpxSuSSI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AqIGY5A5PgJkzqDjtr3D23vHGsK9QStv9uVTbRUF7uXdWMObypAyM8WXIySl6Vwfn
	 FCjxXe9Q9+ItrDiYaRz1DWAq6bR7ReTUcNue3zR9TQcF9OCuzz0yvZMZkQRFpI5oeF
	 oLmQSSBZICL0HDZo+YsWe6wngx/k+30wLa3VaQV4eASTMYzSoaG3Ko/0XDd4VuO/5q
	 2JrXA3A34OV//OL2WNiLzxc3r5pyp1GHgeu5JzNbZko5WmXDZVaoSoK7QDTABlQ4uN
	 Szfwj88Dda7yQSgTf618EGv3Ok23+wBUVD2MGjv79OnaMc8Qh1PL397fqjQ1hrgnXA
	 GGnpjH6JdJ9iw==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a868b739cd9so246243466b.2;
        Fri, 06 Sep 2024 03:58:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEB9hEIEJwGAn6eVrpBIbPbi5J/lm0eqywLjZYwtiDUoiV86/0e2Q46YN9SD+p1xs5AS2sEwAK5IOKEw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIr2MYkaHHbdTPUyrpnviNO/ui6WH4dk4Ah80S3v4QxmX1ZUkC
	Xy3jmAHpIPff7wE2v36XGW+0yl0FbzQX99t5jhHvZ5EHbUlBJrjpQXIb48ZrHL7/sX2ZGoihS03
	soPPBi3PEuZHJOoHLsPzAYEwzHlk=
X-Google-Smtp-Source: AGHT+IEr7YsAidaXJSxTaBxB1hlqXWSWypg5t6+SaQ2bfKYOcfIMirKSYq6jiSADngs6UB5r0aAjCuH9E8xETzH25zM=
X-Received: by 2002:a17:907:f717:b0:a8a:7b8e:fe52 with SMTP id
 a640c23a62f3a-a8a7b8f0154mr314621366b.59.1725620285716; Fri, 06 Sep 2024
 03:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2aab2e4d87251546d4218e6d124a4fe657203e9.1725550652.git.fdmanana@suse.com>
 <21f138f8-7824-4570-b409-d773bcc7c1fa@gmx.com>
In-Reply-To: <21f138f8-7824-4570-b409-d773bcc7c1fa@gmx.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 6 Sep 2024 11:57:28 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5dJSayuWMYjHRPp_p734D98ykFShe1nwyboGm2i9AQ-Q@mail.gmail.com>
Message-ID: <CAL3q7H5dJSayuWMYjHRPp_p734D98ykFShe1nwyboGm2i9AQ-Q@mail.gmail.com>
Subject: Re: [PATCH] btrfs/319: make the test work when compression is used
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 11:39=E2=80=AFAM Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>
>
>
> =E5=9C=A8 2024/9/6 01:08, fdmanana@kernel.org =E5=86=99=E9=81=93:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Currently btrfs/319 assumes there is no compression and that the files
> > get a single extent (1 fiemap line) with a size of 1048581 bytes. Howev=
er
> > when testing with compression, for example by passing "-o compress" to
> > MOUNT_OPTIONS environment variable, we get several extents and two line=
s
> > of fiemap output, which makes the test fail since it hardcodes the fiem=
ap
> > output:
> >
> >    $ MOUNT_OPTIONS=3D"-o compress" ./check btrfs/319
> >    FSTYP         -- btrfs
> >    PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc6-btrfs-next-173+ #1 =
SMP PREEMPT_DYNAMIC Tue Sep  3 17:40:24 WEST 2024
> >    MKFS_OPTIONS  -- /dev/sdc
> >    MOUNT_OPTIONS -- -o compress /dev/sdc /home/fdmanana/btrfs-tests/scr=
atch_1
> >
> >    btrfs/319 1s ... - output mismatch (see /home/fdmanana/git/hub/xfste=
sts/results//btrfs/319.out.bad)
> >        --- tests/btrfs/319.out        2024-08-12 14:16:55.653383284 +01=
00
> >        +++ /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad 2=
024-09-05 15:24:53.323076548 +0100
> >        @@ -6,11 +6,13 @@
> >         e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
> >         e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
> >         File bar fiemap in the original filesystem:
> >        -0: [0..2055]: shared|last
> >        +0: [0..2047]: shared
> >        +1: [2048..2055]: shared|last
> >         Creating a new filesystem to receive the send stream...
> >        ...
> >        (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/319.ou=
t /home/fdmanana/git/hub/xfstests/results//btrfs/319.out.bad'  to see the e=
ntire diff)
> >
> >    HINT: You _MAY_ be missing kernel fix:
> >          46a6e10a1ab1 btrfs: send: allow cloning non-aligned extent if =
it ends at i_size
> >
> >    Ran: btrfs/319
> >    Failures: btrfs/319
> >    Failed 1 of 1 tests
> >
> > So change the test to not rely on the fiemap output in its golden outpu=
t
> > and instead just check if all the extents reported by fiemap have the
> > shared flag set (failing if there are any without the shared flag).
>
> Looks good to me.
>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
>
> Just one minor improvement to make debug a little easier.
>
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/319     | 19 +++++++++++++++----
> >   tests/btrfs/319.out |  4 ----
> >   2 files changed, 15 insertions(+), 8 deletions(-)
> >
> > diff --git a/tests/btrfs/319 b/tests/btrfs/319
> > index 975c1497..7cfd3d00 100755
> > --- a/tests/btrfs/319
> > +++ b/tests/btrfs/319
> > @@ -32,6 +32,19 @@ _require_odirect
> >   _fixed_by_kernel_commit 46a6e10a1ab1 \
> >       "btrfs: send: allow cloning non-aligned extent if it ends at i_si=
ze"
> >
> > +check_all_extents_shared()
> > +{
> > +     local file=3D$1
> > +     local fiemap_output
> > +
> > +     fiemap_output=3D$($XFS_IO_PROG -r -c "fiemap -v" $file | _filter_=
fiemap_flags)
>
> Maybe also save the full unfiltered output to seqres.full?

Hum, why?

Do you think looking at the flags in hexadecimal values instead of
symbolic names like "shared", "encoded", "last", etc, is easier to
read?

Thanks.

>
> Thanks,
> Qu
>
> > +     echo "$fiemap_output" | grep -qv 'shared'
> > +     if [ $? -eq 0 ]; then
> > +             echo -e "Found non-shared extents for file $file:\n"
> > +             echo "$fiemap_output"
> > +     fi
> > +}
> > +
> >   send_files_dir=3D$TEST_DIR/btrfs-test-$seq
> >   send_stream=3D$send_files_dir/snap.stream
> >
> > @@ -58,8 +71,7 @@ echo "File digests in the original filesystem:"
> >   md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
> >   md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
> >
> > -echo "File bar fiemap in the original filesystem:"
> > -$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_=
flags
> > +check_all_extents_shared "$SCRATCH_MNT/snap/bar"
> >
> >   echo "Creating a new filesystem to receive the send stream..."
> >   _scratch_unmount
> > @@ -72,8 +84,7 @@ echo "File digests in the new filesystem:"
> >   md5sum $SCRATCH_MNT/snap/foo | _filter_scratch
> >   md5sum $SCRATCH_MNT/snap/bar | _filter_scratch
> >
> > -echo "File bar fiemap in the new filesystem:"
> > -$XFS_IO_PROG -r -c "fiemap -v" $SCRATCH_MNT/snap/bar | _filter_fiemap_=
flags
> > +check_all_extents_shared "$SCRATCH_MNT/snap/bar"
> >
> >   # success, all done
> >   status=3D0
> > diff --git a/tests/btrfs/319.out b/tests/btrfs/319.out
> > index 14079dbe..18a50ff8 100644
> > --- a/tests/btrfs/319.out
> > +++ b/tests/btrfs/319.out
> > @@ -5,12 +5,8 @@ Creating snapshot and a send stream for it...
> >   File digests in the original filesystem:
> >   e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
> >   e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
> > -File bar fiemap in the original filesystem:
> > -0: [0..2055]: shared|last
> >   Creating a new filesystem to receive the send stream...
> >   At subvol snap
> >   File digests in the new filesystem:
> >   e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/foo
> >   e61178ee0288ebe3fa36a3c975b02c94  SCRATCH_MNT/snap/bar
> > -File bar fiemap in the new filesystem:
> > -0: [0..2055]: shared|last

