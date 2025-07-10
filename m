Return-Path: <linux-btrfs+bounces-15420-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 534A3B000C5
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 13:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AF24E5562
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D3A248F78;
	Thu, 10 Jul 2025 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d9ep8oQd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810C9246795;
	Thu, 10 Jul 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148089; cv=none; b=PMzlpxqy+8JiKDOQgW1MzyEdh1pzdo8JTSaFRFjflglrTBJMwqjrkcpmUgIzmGnAWeyxLjFftWQ3lvhN1axamJvPXDPeKwTufLbuis/HOtbeBk1Ry6KLfiZoorkS2LDsV/szuYt0BRrnc2nFF+XSziY8glfHGAku+rOn11lHWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148089; c=relaxed/simple;
	bh=zh7515rMrL5Xc4b23EmXlbTClvllrsKoqXvNhKbzFnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OA6LyTZramiBPs2YNuI6aWvhe1BLTjWVBhjwzB0yz6bWIW8VXb7WLPH3s5gHVGQE4eON2gUwCsR8jiRUzopO8OI8LwSTCDAPcCJ74GBDSZICmyl8daJ/5wYVTGFh0SnUHY8BGgD2K3PTkpwPNiDjfaZi8mUjDMvqR4hyVT8THic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d9ep8oQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B716C4CEF5;
	Thu, 10 Jul 2025 11:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752148089;
	bh=zh7515rMrL5Xc4b23EmXlbTClvllrsKoqXvNhKbzFnI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d9ep8oQdBoBk1OccIWIo94+BMmF2jPjdBFMV3XisMRHIfNgBjCCakHkr0yxmv/1js
	 x8Jzf4EAPSXcg6I7c72yrjHTJdsIPQ5tdOzQJaJQLmbhEEfKDJnqc/5F3OZeTZTfya
	 wwc1uMkD0XXJxx+6Exg2h515xHnU36s0GCBQH07SVxwZnJDTgL2DfoeCEOKeCCJRFN
	 DQjpQv4HmVBZ2Orh6sbjlzqaetWxVQGyasENsWEyw+jRzU2d4funXla5hegS2cWhV4
	 MW/E9+3+ZXNipZKiYt0fImu1zn7RGEaO5nCtadA2vN/FDxA47heKAfrbusd+FDa+/2
	 zokfdHVCe8t+Q==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so1363610a12.2;
        Thu, 10 Jul 2025 04:48:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV0/jdwKMlj4WCc17dGnSxFFtOxx6YJ+BrIB+vPnqwQUsh81XG+w1b0FNjjvKSGI3ZneQSDeh/ZokD/Rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlGdnTcipWZCvLmMjc0tRAXTlyMG7VyDdnQd6ecUiHrhv166DJ
	MRoakC4gECK3NGLJqpYTn3bxsDtNoGg8KpvPHv/GQimnsViRVKHD2haIFZYRb0egeMRYw2bs/hw
	/xpQ9KAD+lXVCPIZAPvekRd6gSy9dq4M=
X-Google-Smtp-Source: AGHT+IF4hh4elekWVL13aPi5I9egu6DnkbH+0ObbEP5fZvUvtXVT6AockKqYmY8h0eQmPhT96DNVXcN8Ij9cr86MEAs=
X-Received: by 2002:a17:907:7249:b0:ade:2e4b:50d1 with SMTP id
 a640c23a62f3a-ae6e7048e57mr285301566b.29.1752148087565; Thu, 10 Jul 2025
 04:48:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <20250710072929.dfhksffdogk35ik7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250710072929.dfhksffdogk35ik7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 10 Jul 2025 12:47:30 +0100
X-Gmail-Original-Message-ID: <CAL3q7H63UVfZ5xJfh2n0rfB4Y03_hgupvTxn2EWJgrNN+s=BvQ@mail.gmail.com>
X-Gm-Features: Ac12FXwMybDLYrR3FFwvxxeV4jvkSoM-7DYegfiRe7tou_7b_7rj-rpX0NcdnaE
Message-ID: <CAL3q7H63UVfZ5xJfh2n0rfB4Y03_hgupvTxn2EWJgrNN+s=BvQ@mail.gmail.com>
Subject: Re: [PATCH] generic: test overwriting file with mmap on a full filesystem
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 8:29=E2=80=AFAM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Wed, Jul 09, 2025 at 09:53:50AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that overwriting a file with mmap when the filesystem has no more
> > space available for data allocation works. The motivation here is to ch=
eck
> > that NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> >
> > This currently fails with btrfs but it's fixed by a kernel patch that h=
as
> > the subject:
> >
> >    btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >  tests/generic/211     | 58 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/211.out |  6 +++++
> >  2 files changed, 64 insertions(+)
> >  create mode 100755 tests/generic/211
> >  create mode 100644 tests/generic/211.out
> >
> > diff --git a/tests/generic/211 b/tests/generic/211
> > new file mode 100755
> > index 00000000..c77508fe
> > --- /dev/null
> > +++ b/tests/generic/211
> > @@ -0,0 +1,58 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> > +#
> > +# FS QA Test 211
> > +#
> > +# Test that overwriting a file with mmap when the filesystem has no mo=
re space
> > +# available for data allocation works. The motivation here is to check=
 that
> > +# NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick rw mmap
> > +
> > +. ./common/filter
> > +
> > +_require_scratch
> > +
> > +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > +     "btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
> > +
> > +# Use a 512M fs so that it's fast to fill it with data but not too sma=
ll such
> > +# that on btrfs it results in a fs with mixed block groups - we want t=
o have
> > +# dedicated block groups for data and metadata, so that after filling =
all the
> > +# data block groups we can do a NOCOW write with mmap (if we have enou=
gh free
> > +# metadata space available).
> > +fs_size=3D$(_small_fs_size_mb 512)
> > +_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || =
\
> > +     _fail "mkfs failed"
>
> _scratch_mkfs_sized calls _notrun if it fails:
>
>   _scratch_mkfs_sized()
>   {
>         _try_scratch_mkfs_sized "$@" || _notrun "_scratch_mkfs_sized fail=
ed with ($*)"
>   }
>
> So you can let it _notrun:
> _scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1
>
> or you'd like to _fail:
>
> _try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 ||=
 \
>          _fail "mkfs failed"

The fail makes more sense to me - having the _scratch_mkfs_sized()
calling _notrun doesn't make sense to me at the moment.

>
> > +_scratch_mount
> > +
> > +touch $SCRATCH_MNT/foobar
> > +
> > +# Set the file to NOCOW mode on btrfs, which must be done while the fi=
le is
> > +# empty, otherwise it fails.
> > +if [ $FSTYP =3D=3D "btrfs" ]; then
> > +     _require_chattr C
> > +     $CHATTR_PROG +C $SCRATCH_MNT/foobar
> > +fi
> > +
> > +# Add initial data to the file we will later overwrite with mmap.
> > +$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xf=
s_io
> > +
> > +# Now fill all the remaining space with data.
> > +blksz=3D$(_get_block_size $SCRATCH_MNT)
> > +dd if=3D/dev/zero of=3D$SCRATCH_MNT/filler bs=3D$blksz >>$seqres.full =
2>&1
>
> As this's a generic test case, I'm wondering if the common/populate:_fill=
_fs()
> helps?

Because the intention is to exhaust data space and leave enough
metadata space free so that the NOCOW write can be done, as Qu already
replied before.
In btrfs we have space divided in two sections (block groups): one for
data and one for metadata.
Metadata is always COWed in btrfs by design, data can be NOCOWed
(chattr +C or prealloc extents for the first write) - as longs as
there's enough metadata space available (every data write requires
updating some metadata).

If this is too specific or hard to comprehend, I can move the test
case into tests/btrfs/ (we have a few similar to this scenario iirc).
Let me know if I shall move it into tests/btrfs/.

Thanks.

>
> Thanks,
> Zorro
>
> > +
> > +# Overwrite the file with a mmap write. Should succeed.
> > +$XFS_IO_PROG -c "mmap -w 0 1M"        \
> > +          -c "mwrite -S 0xcd 0 1M" \
> > +          -c "munmap"              \
> > +          $SCRATCH_MNT/foobar
> > +
> > +# Cycle mount and dump the file's content. We expect to see the new da=
ta.
> > +_scratch_cycle_mount
> > +_hexdump $SCRATCH_MNT/foobar
> > +
> > +# success, all done
> > +_exit 0
> > diff --git a/tests/generic/211.out b/tests/generic/211.out
> > new file mode 100644
> > index 00000000..71cdf0f8
> > --- /dev/null
> > +++ b/tests/generic/211.out
> > @@ -0,0 +1,6 @@
> > +QA output created by 211
> > +wrote 1048576/1048576 bytes at offset 0
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >.............=
...<
> > +*
> > +100000
> > --
> > 2.47.2
> >
> >
>

