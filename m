Return-Path: <linux-btrfs+bounces-9242-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB7A9B5D11
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 08:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F511C20C2B
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2024 07:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBF71E0DCC;
	Wed, 30 Oct 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps3xFZ/b"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9141E0B76;
	Wed, 30 Oct 2024 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730273974; cv=none; b=IQVobhh/7Iae7MV/gXUJVkDv4E3dJpEzkVmjoxCAOXJc1QTDpxI+jGDtRYsT4bh/x6TS8XNGyKjRr9sM6BazlkXnWwqvJPEuMqwtnnB17E5rORKxY8wGiIRScyvpPDdna1wKIp0acu4HZp12fNjSV/dJK5F5RzHU3qyqNwKlNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730273974; c=relaxed/simple;
	bh=H4BidCniCzYHAFF2Uujg1LadtS255qezECLb+LvRFuc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fatPyFzbwsmiYUKuSSg5q4iBK7+Uh1Z0eDi60sHMMYwjZptW/D6thG2fSCMiBif6IslCchoq2RW05BYwtHSkkV8c1ug+qUa4VLU2R7two+yXg3SQarJkWI77F630SIVBiO4eELE4JRZPAdGw3e/DpG4q4Wc/y0d6CcJkVDe4QDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps3xFZ/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21122C4CEE5;
	Wed, 30 Oct 2024 07:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730273974;
	bh=H4BidCniCzYHAFF2Uujg1LadtS255qezECLb+LvRFuc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ps3xFZ/bjleG+1oEc8s/MG1WR/SdpFX4gZUM1KglHcoRLulc1rz4ojmjPqXF37fQi
	 lJ6Tj0RJS8mRAbvYezrbYNGfFKC2NAzZxRYHPPqqzhzxo1UqskJTdt69KLDWnHcCuD
	 qIZuk2bR/PpsSTs8vUUt4EPdqzYRt+Rok0LCpPxgQEUEpGHVgpXcQ9O5ApHyt5Qw2D
	 Las7lfqTK585JV6Tm9xOaF7SRNnMknWyKH9f7HkIP/V/Wg/YQSxqkB80N9MZ3ncuiO
	 13PFmlX9G2i6lI2EeSdfma/4ITmw75fGCdzdFG6ocK9ydeyHU7StVX/TRLIYarM3z2
	 37P9lpr2Tg57w==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a99f646ff1bso793809866b.2;
        Wed, 30 Oct 2024 00:39:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQx2RDluzo0JkO+aYpyO/uGs8y2xiS813iFxN0YuierchQYBvgG7Py0xNAU81E0FPxeC6RIRxDx7kU2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuzEU/7YOjd4Hq97164E5c8h1ryx5xoxg7I/xfExSrCbZufDu
	iX5fAGJkoz+HivB7fMCLM1d1M8gDqKDux22cvrhyIKyg9szIlmBIeLBI5XR9RTZzvlIMJA7XUrT
	BCTf02DOeN1WKF9it8KWxKAUFd2I=
X-Google-Smtp-Source: AGHT+IHG68HPrWUix7SQvtY2oD98n1KFZMWjgkkc6QNELTaTr5xQ5jjudT6GTb7BXyeyB+s8R55hRyQQF4q7eolfA8g=
X-Received: by 2002:a17:907:1c82:b0:a9a:5cf8:9e40 with SMTP id
 a640c23a62f3a-a9e3a5a2bf0mr224823766b.24.1730273972680; Wed, 30 Oct 2024
 00:39:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e592bcc458f5c2ec41930975003702a667c92a8e.1730220751.git.fdmanana@suse.com>
 <a88924e1-4ff0-4cca-9d28-cd23f7a67b58@oracle.com>
In-Reply-To: <a88924e1-4ff0-4cca-9d28-cd23f7a67b58@oracle.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 30 Oct 2024 07:38:55 +0000
X-Gmail-Original-Message-ID: <CAL3q7H45kuJB3tnpbbUomhnDrZ4QAaNEvxuhh2sThMG_Q8550w@mail.gmail.com>
Message-ID: <CAL3q7H45kuJB3tnpbbUomhnDrZ4QAaNEvxuhh2sThMG_Q8550w@mail.gmail.com>
Subject: Re: [PATCH] btrfs: add a test for defrag of contiguous file extents
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 12:49=E2=80=AFAM Anand Jain <anand.jain@oracle.com>=
 wrote:
>
> On 30/10/24 01:23, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that defrag merges adjacent extents that are contiguous.
> > This exercises a regression fixed by a patchset for the kernel that is
> > comprissed of the following patches:
> >
> >    btrfs: fix extent map merging not happening for adjacent extents
> >    btrfs: fix defrag not merging contiguous extents due to merged exten=
t maps
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   tests/btrfs/325     | 80 ++++++++++++++++++++++++++++++++++++++++++++=
+
> >   tests/btrfs/325.out | 22 +++++++++++++
> >   2 files changed, 102 insertions(+)
> >   create mode 100755 tests/btrfs/325
> >   create mode 100644 tests/btrfs/325.out
> >
> > diff --git a/tests/btrfs/325 b/tests/btrfs/325
> > new file mode 100755
> > index 00000000..0b1ab3c2
> > --- /dev/null
> > +++ b/tests/btrfs/325
> > @@ -0,0 +1,80 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> > +#
> > +# FS QA Test 325
> > +#
> > +# Test that defrag merges adjacent extents that are contiguous.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick preallocrw defrag
> > +
> > +. ./common/filter
> > +
> > +_require_scratch
> > +_require_btrfs_command inspect-internal dump-tree
> > +_require_xfs_io_command "falloc"
> > +
> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: fix extent map merging not happening for adjacent extents=
"
> > +_fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: fix defrag not merging contiguous extents due to merged e=
xtent maps"
> > +
> > +count_file_extent_items()
> > +{
> > +     # We count file extent extent items through dump-tree instead of =
using
> > +     # fiemap because fiemap merges adjacent extent items when they ar=
e
> > +     # contiguous.
> > +     # We unmount because all metadata must be ondisk for dump-tree to=
 see
> > +     # it and work correctly.
> > +     _scratch_unmount
> > +     $BTRFS_UTIL_PROG inspect-internal dump-tree -t 5 $SCRATCH_DEV | \
> > +             grep EXTENT_DATA | wc -l
> > +     _scratch_mount
> > +}
> > +
> > +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> > +_scratch_mount
> > +
> > +# Create a file with a size of 256K and 4 written extents of 64K each.
> > +# We fallocate to guarantee exact extent size, even if compression mou=
nt
> > +# option is give, and write to them because defrag skips prealloc exte=
nts.
> > +$XFS_IO_PROG -f -c "falloc 0 64K" \
> > +          -c "pwrite -S 0xab 0 64K" \
> > +          -c "falloc 64K 64K" \
> > +          -c "pwrite -S 0xcd 64K 64K" \
> > +          -c "falloc 128K 64K" \
> > +          -c "pwrite -S 0xef 128K 64K" \
> > +          -c "falloc 192K 64K" \
> > +          -c "pwrite -S 0x73 192K 64K" \
> > +          $SCRATCH_MNT/foo | _filter_xfs_io
> > +
> > +echo -n "Initial number of file extent items: "
> > +count_file_extent_items
> > +
> > +# Read the whole file in order to load extent maps and merge them.
> > +cat $SCRATCH_MNT/foo > /dev/null
> > +
> > +# Now defragment with a threshold of 128K. After this we expect to get=
 a file
>
> > +# with 1 file extent item - the treshold is 128K but since all the ext=
ents are
>
> > +# contiguous, they should be merged into a single one of 256K.
> > +$BTRFS_UTIL_PROG filesystem defragment -t 128K $SCRATCH_MNT/foo
>
> > +echo -n "Number of file extent items after defrag with 128K treshold: =
"
>
> Nit: s/treshold/threshold/g
>
> > +count_file_extent_items
> > +
> > +# Read the whole file in order to load extent maps and merge them.
> > +cat $SCRATCH_MNT/foo > /dev/null
> > +
> > +# Now defragment with a threshold of 256K. After this we expect to get=
 a file
> > +# with only 1 file extent item.
> > +$BTRFS_UTIL_PROG filesystem defragment -t 256K $SCRATCH_MNT/foo
> > +echo -n "Number of file extent items after defrag with 256K treshold: =
"
> > +count_file_extent_items
> > +
> > +# Check that the file has the expected data, that defrag didn't cause =
any data
> > +# loss or corruption.
> > +echo "File data after defrag:"
> > +_hexdump $SCRATCH_MNT/foo
> > +
>
> Nice.
>
> Nit: This can be a generic test-case.

No it can't, because:

1) Not all filesystems have a defrag functionality and with the
ability to specify a threshold;
2) We need to use dump-tree to count file extent items - both the tool
and metadata are btrfs specific.

>
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
>
> Thx, Anand
>
>
> > +status=3D0
> > +exit
> > diff --git a/tests/btrfs/325.out b/tests/btrfs/325.out
> > new file mode 100644
> > index 00000000..96053925
> > --- /dev/null
> > +++ b/tests/btrfs/325.out
> > @@ -0,0 +1,22 @@
> > +QA output created by 325
> > +wrote 65536/65536 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 65536/65536 bytes at offset 65536
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 65536/65536 bytes at offset 131072
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +wrote 65536/65536 bytes at offset 196608
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +Initial number of file extent items: 4
> > +Number of file extent items after defrag with 128K treshold: 1
> > +Number of file extent items after defrag with 256K treshold: 1
> > +File data after defrag:
> > +000000 ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab ab  >.............=
...<
> > +*
> > +010000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >.............=
...<
> > +*
> > +020000 ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef ef  >.............=
...<
> > +*
> > +030000 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73 73  >sssssssssssss=
sss<
> > +*
> > +040000
>

