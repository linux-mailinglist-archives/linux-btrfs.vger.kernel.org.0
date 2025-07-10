Return-Path: <linux-btrfs+bounces-15427-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867BAB00983
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 19:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052AF565062
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 17:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E96F2F0C65;
	Thu, 10 Jul 2025 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl9PQ+15"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC041275114;
	Thu, 10 Jul 2025 17:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166976; cv=none; b=rChD3oKQWWfhEy2SpTpMchYAhXknLQZFwFXIXHZFmWuNzsYVWrz8AROI4crtJzstEirNf6Tcuez2HOeelG7hG3DQfDrT4V7Ae/5bQt9Zw4LMIHSzYi7s97IQETEoQaU+FpNtVmyr6PxohCL3qaa/0s5xRUmsiA0VsGIwwMs5P2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166976; c=relaxed/simple;
	bh=+sb1TKFtjM8fm65irf9j6PVmo90pu/nXbxBOpCh3tjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCor00NJrRuSpVLhKC/SSHxotjkK2tOV3ut4rmtSJCJ6GNkZ8m7/X4bNf8/9GRl8InYHgCuLMmrjybhekLgRIeirj/1G+blWrXfPNd5PYx176UG2vY8IgqTVO6M8iFbNDSLjec4tJ0h5LyHsSVWhF85oQW+pImNggUdEFSioogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl9PQ+15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCE1C4CEF5;
	Thu, 10 Jul 2025 17:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752166976;
	bh=+sb1TKFtjM8fm65irf9j6PVmo90pu/nXbxBOpCh3tjE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rl9PQ+15TxBPZjd+N97yN85K6lST4g3CiqxvL5grtlZWu9rpe8b3gW5SbeB5n/9vd
	 McVgKnHPhXAGRAPRWDLmoKPALdH3AwdpARmSaSr81Ydl0FeQ5RFRbamObxo233xIuc
	 J9wIWuwLrB/t5pXe+ku6FT14g2PgQW88XQzrGtj0Pf3hZeD8zg4bRgHV+6Psfe+rn2
	 Zya90yePkwDmSCy+auGsIoL/TOZBscc8lOwiD+lHt24aleGwSoePDgCFHgX2MQ1xgA
	 TAsCFmIpHRcbcgHnoxGUGAWP72S/T+30XPff09rnPAxUWLtpAuO66F/eXZdn1Ud/3H
	 C8PWfinwfpviA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60867565fb5so1972049a12.3;
        Thu, 10 Jul 2025 10:02:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUB9KX9F4mYPPJoLswLgLmzby8bfpeP0xSHhjNXgtTok4emVJ18PI/oWvqAJ09qYlmy3k580CL+yDtmIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOniZwPo3+NiZoZS4mT/3GCJJLmMfz05fkLMr1tKqKLJSmeMne
	/aDKHsXXMQnppScLl/HrYcAyETzYT/VXJ2HiyOnGdk/oOOgpYEcogjmb0/5J3sgnT+Oik3Gy9v4
	Tx6b0bjG4axHCHSsNmRIbMaoD4s3zveU=
X-Google-Smtp-Source: AGHT+IEz06zlJqhu6fpyAOrZZZ4yIyDTRyJvWGjJo98f/eO6d+nbk1diPUVy+rSW51af90CmqkWzAAQANaolAJb7TfE=
X-Received: by 2002:a17:907:940b:b0:ae2:60ba:da91 with SMTP id
 a640c23a62f3a-ae6fbd99c4bmr3451666b.15.1752166975114; Thu, 10 Jul 2025
 10:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <20250710072929.dfhksffdogk35ik7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H63UVfZ5xJfh2n0rfB4Y03_hgupvTxn2EWJgrNN+s=BvQ@mail.gmail.com> <20250710160750.q6sgqrfbazsxi2og@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
In-Reply-To: <20250710160750.q6sgqrfbazsxi2og@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 10 Jul 2025 18:02:15 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4vez-nGXp6+StVtvayM_1j4smbc7SiejcC1P9eVaTLAw@mail.gmail.com>
X-Gm-Features: Ac12FXzjXmTxHAVo0gwbOYpkXzwzmE5t0-G2fgr-mS_pZDvMW_vuFSRq7_uf4HA
Message-ID: <CAL3q7H4vez-nGXp6+StVtvayM_1j4smbc7SiejcC1P9eVaTLAw@mail.gmail.com>
Subject: Re: [PATCH] generic: test overwriting file with mmap on a full filesystem
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 5:08=E2=80=AFPM Zorro Lang <zlang@redhat.com> wrote=
:
>
> On Thu, Jul 10, 2025 at 12:47:30PM +0100, Filipe Manana wrote:
> > On Thu, Jul 10, 2025 at 8:29=E2=80=AFAM Zorro Lang <zlang@redhat.com> w=
rote:
> > >
> > > On Wed, Jul 09, 2025 at 09:53:50AM +0100, fdmanana@kernel.org wrote:
> > > > From: Filipe Manana <fdmanana@suse.com>
> > > >
> > > > Test that overwriting a file with mmap when the filesystem has no m=
ore
> > > > space available for data allocation works. The motivation here is t=
o check
> > > > that NOCOW mode of a COW filesystem (such as btrfs) works as expect=
ed.
> > > >
> > > > This currently fails with btrfs but it's fixed by a kernel patch th=
at has
> > > > the subject:
> > > >
> > > >    btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
> > > >
> > > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > > ---
> > > >  tests/generic/211     | 58 +++++++++++++++++++++++++++++++++++++++=
++++
> > > >  tests/generic/211.out |  6 +++++
> > > >  2 files changed, 64 insertions(+)
> > > >  create mode 100755 tests/generic/211
> > > >  create mode 100644 tests/generic/211.out
> > > >
> > > > diff --git a/tests/generic/211 b/tests/generic/211
> > > > new file mode 100755
> > > > index 00000000..c77508fe
> > > > --- /dev/null
> > > > +++ b/tests/generic/211
> > > > @@ -0,0 +1,58 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserve=
d.
> > > > +#
> > > > +# FS QA Test 211
> > > > +#
> > > > +# Test that overwriting a file with mmap when the filesystem has n=
o more space
> > > > +# available for data allocation works. The motivation here is to c=
heck that
> > > > +# NOCOW mode of a COW filesystem (such as btrfs) works as expected=
.
> > > > +#
> > > > +. ./common/preamble
> > > > +_begin_fstest auto quick rw mmap
> > > > +
> > > > +. ./common/filter
> > > > +
> > > > +_require_scratch
> > > > +
> > > > +[ "$FSTYP" =3D "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > > +     "btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents=
"
> > > > +
> > > > +# Use a 512M fs so that it's fast to fill it with data but not too=
 small such
> > > > +# that on btrfs it results in a fs with mixed block groups - we wa=
nt to have
> > > > +# dedicated block groups for data and metadata, so that after fill=
ing all the
> > > > +# data block groups we can do a NOCOW write with mmap (if we have =
enough free
> > > > +# metadata space available).
> > > > +fs_size=3D$(_small_fs_size_mb 512)
> > > > +_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1=
 || \
> > > > +     _fail "mkfs failed"
> > >
> > > _scratch_mkfs_sized calls _notrun if it fails:
> > >
> > >   _scratch_mkfs_sized()
> > >   {
> > >         _try_scratch_mkfs_sized "$@" || _notrun "_scratch_mkfs_sized =
failed with ($*)"
> > >   }
> > >
> > > So you can let it _notrun:
> > > _scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1
> > >
> > > or you'd like to _fail:
> > >
> > > _try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&=
1 || \
> > >          _fail "mkfs failed"
> >
> > The fail makes more sense to me - having the _scratch_mkfs_sized()
> > calling _notrun doesn't make sense to me at the moment.
>
> OK, so you can use _try_scratch_mkfs_sized.
>
> >
> > >
> > > > +_scratch_mount
> > > > +
> > > > +touch $SCRATCH_MNT/foobar
> > > > +
> > > > +# Set the file to NOCOW mode on btrfs, which must be done while th=
e file is
> > > > +# empty, otherwise it fails.
> > > > +if [ $FSTYP =3D=3D "btrfs" ]; then
> > > > +     _require_chattr C
> > > > +     $CHATTR_PROG +C $SCRATCH_MNT/foobar
> > > > +fi
> > > > +
> > > > +# Add initial data to the file we will later overwrite with mmap.
> > > > +$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filte=
r_xfs_io
> > > > +
> > > > +# Now fill all the remaining space with data.
> > > > +blksz=3D$(_get_block_size $SCRATCH_MNT)
> > > > +dd if=3D/dev/zero of=3D$SCRATCH_MNT/filler bs=3D$blksz >>$seqres.f=
ull 2>&1
> > >
> > > As this's a generic test case, I'm wondering if the common/populate:_=
fill_fs()
> > > helps?
> >
> > Because the intention is to exhaust data space and leave enough
> > metadata space free so that the NOCOW write can be done, as Qu already
> > replied before.
> > In btrfs we have space divided in two sections (block groups): one for
> > data and one for metadata.
> > Metadata is always COWed in btrfs by design, data can be NOCOWed
> > (chattr +C or prealloc extents for the first write) - as longs as
> > there's enough metadata space available (every data write requires
> > updating some metadata).
> >
> > If this is too specific or hard to comprehend, I can move the test
> > case into tests/btrfs/ (we have a few similar to this scenario iirc).
> > Let me know if I shall move it into tests/btrfs/.
>
> Thanks for the detailed explanation from you and Qu:) If so, maybe
> _get_file_block_size better than _get_block_size?
>
> I think we can keep this case in generic directory, it's a btrfs bug repr=
oducer
> and it won't break other fs test. If someone fs hopes to change that "fil=
l fs"
> part, we can use if...else... so maybe you can add more comments about wh=
y btrfs
> need this dd operation rather than _fill_fs things, to avoid others chang=
e this
> part in the future.

Ok, I'll update the comment above dd to be more detailed, about why dd
and not __populate_fill_fs().

Thanks.
>
> Thanks,
> Zorro
>
> >
> > Thanks.
> >
> > >
> > > Thanks,
> > > Zorro
> > >
> > > > +
> > > > +# Overwrite the file with a mmap write. Should succeed.
> > > > +$XFS_IO_PROG -c "mmap -w 0 1M"        \
> > > > +          -c "mwrite -S 0xcd 0 1M" \
> > > > +          -c "munmap"              \
> > > > +          $SCRATCH_MNT/foobar
> > > > +
> > > > +# Cycle mount and dump the file's content. We expect to see the ne=
w data.
> > > > +_scratch_cycle_mount
> > > > +_hexdump $SCRATCH_MNT/foobar
> > > > +
> > > > +# success, all done
> > > > +_exit 0
> > > > diff --git a/tests/generic/211.out b/tests/generic/211.out
> > > > new file mode 100644
> > > > index 00000000..71cdf0f8
> > > > --- /dev/null
> > > > +++ b/tests/generic/211.out
> > > > @@ -0,0 +1,6 @@
> > > > +QA output created by 211
> > > > +wrote 1048576/1048576 bytes at offset 0
> > > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > > +000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >.........=
.......<
> > > > +*
> > > > +100000
> > > > --
> > > > 2.47.2
> > > >
> > > >
> > >
> >
>

