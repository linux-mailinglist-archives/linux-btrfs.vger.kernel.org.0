Return-Path: <linux-btrfs+bounces-5523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F9D8FFB3E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 07:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AB6B2377A
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 05:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBF71BC57;
	Fri,  7 Jun 2024 05:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaMDQOuc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B3B1805A
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 05:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717737139; cv=none; b=eswIpKhb761elQIXtDoPhcQnPqXp9vqBwAc6IiPoT/5qjOwilGT8XypNuBWk0qFXQ2dnBUGG2eCGSpZbY2t/PbMXX33t+Uvg3ACpOwi4fvHCmIY83sCheZa9oXE8bA3eYWiDeAqxmZaWGTdBJVNHC3Cm1cehlniHzvFe4uL1kLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717737139; c=relaxed/simple;
	bh=3SasVotL65io6uI7nMzbdDXNOu6jy8RgTynsQOR3UL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3qNKrbvRmrmaHSRpOot6wOpbwyxinSugNdmSBFysyPKjAFXR5kREH/mriCrxN0q7Iu2JFFWDwo7pMuQ5LnynFb+eLdBO0OUYGeThJeTxIxr1UBUV+4CbiZPdgYYh/uchYeahYK9Q+RQJaCH+wwxjrtYvjN7Vq/t7dItKwfbss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaMDQOuc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717737136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BPEPQEShKUN+FEA3EreDIyeanqmPf4X97UtQry/w8Yo=;
	b=UaMDQOucPQr7AkRLWp2jSrA3/JuPBqrUGyrCd55JLCcFgeso+HRvNpZ0uNncRI/FOdEiFE
	PyEaENfHozRojJH2JbANW6plT0oQw++N28IwEVZLOXeaYm4zDyKq9hnHG5iiWbGb3WwMyi
	RtrdV+S6eT/Vufsj97ymgo+JuOTR+qw=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-RZEi0_AeNrSOMPgObaFFkQ-1; Fri, 07 Jun 2024 01:12:13 -0400
X-MC-Unique: RZEi0_AeNrSOMPgObaFFkQ-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2c2a64145c8so1100470a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Jun 2024 22:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717737133; x=1718341933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BPEPQEShKUN+FEA3EreDIyeanqmPf4X97UtQry/w8Yo=;
        b=jLwHpfvw/M2zC8cZEBTy7boc0cLrmBjeUZOtvb18l+4LJe0vitt/Eg71mcUm83+yij
         vASV1PrUenSsIvyxxCt3ZLyJk63UeF3ppcPjoKd8eINsGi7uBU14TcaxbHyn5IYOv24Y
         9YQucE1/Ub4JZ4jRTE+Uw6GnzTzk6u+2r+nbXJZygKJlJ1s5UmQaWZh276GAr2wppxUs
         kGcAYAPMvbcwyzwxYbIkFDX6wlt2IB2lcoJMAvSvHAkP6S0EWngjs4XKuP52nCdxRTgN
         5gYj74r/VxgOp9FiuL4EuI4QKJGKEJ+P2N7s8gA2rTlV9Jh0J4YFObkcQ550+nTT1CSX
         m+uA==
X-Forwarded-Encrypted: i=1; AJvYcCWFXQzjYCE7iEGtKLTKDgsisUz3v/7+9QjErSHhUH9EO73YIyXj/tb2NstAhu3stcQyA436bwH3d+wRTZNhZtY0mQvIgyo/fKoxQso=
X-Gm-Message-State: AOJu0Ywzhg7z7ehui+gnacvWcx1rt0sC+R3argPwJ1gpFFuKftZ1JyF3
	nWVOU71XTvm6SF5aP2oOl8m5uJHDwUvnEj1zXUoDG6V171sPRiLvqjoVN4Gfxta07Qc/M9vWQQ3
	+yFMD9JsHRh1Zx6h5GrDuPzN4Hqgv8bLefqdL9YJkFYIR1fHXx8Qp6bb8ryi5
X-Received: by 2002:a17:90a:df0d:b0:2c2:e22:787e with SMTP id 98e67ed59e1d1-2c2bcc6b302mr1473551a91.33.1717737132526;
        Thu, 06 Jun 2024 22:12:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4rLHzdkdz9xZ7yysa4ldbujDYaCD9ERGYpr3ddUQeAHTghrU6rxTpd9275bsjRsSJcVe6CA==
X-Received: by 2002:a17:90a:df0d:b0:2c2:e22:787e with SMTP id 98e67ed59e1d1-2c2bcc6b302mr1473531a91.33.1717737131818;
        Thu, 06 Jun 2024 22:12:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c495093sm2620723a91.53.2024.06.06.22.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 22:12:11 -0700 (PDT)
Date: Fri, 7 Jun 2024 13:12:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH fstests v2] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
Message-ID: <20240607051207.6qa3mlxfaqiwv2ww@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
 <d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
 <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>

On Sun, May 26, 2024 at 12:47:49PM +0100, Filipe Manana wrote:
> On Fri, May 24, 2024 at 9:58 PM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > This is a regression test for a Btrfs bug, but there's nothing
> > Btrfs-specific about it. Since it's a race, we just try to make the race
> > happen in a loop and pass if it doesn't crash after all of our attempts.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> > Changes from v1 [1]:
> >
> > - Added missing groups and requires.
> > - Simplified $XFS_IO_PROG calls.
> > - Removed -i flag from $XFS_IO_PROG to make race reproduce more
> >   reliably.
> > - Removed all of the file creation and dump-tree parsing since the only
> >   file on a fresh filesystem is guaranteed to be at the end of a leaf
> >   anyways.
> > - Rewrote to be a generic test.
> >
> > 1: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com/
> >
> >  tests/generic/745     | 44 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/745.out |  2 ++
> >  2 files changed, 46 insertions(+)
> >  create mode 100755 tests/generic/745
> >  create mode 100644 tests/generic/745.out
> >
> > diff --git a/tests/generic/745 b/tests/generic/745
> > new file mode 100755
> > index 00000000..925adba9
> > --- /dev/null
> > +++ b/tests/generic/745
> 
> Btw, generic/745 already exists in the for-next branch (development is
> based against that branch nowadays).
> 
> > @@ -0,0 +1,44 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) Meta Platforms, Inc. and affiliates.
> > +#
> > +# FS QA Test 745
> > +#
> > +# Repeatedly prealloc beyond i_size, set an xattr, direct write into the
> > +# prealloc while extending i_size, then fdatasync. This is a regression test
> > +# for a Btrfs crash.
> > +#
> > +. ./common/preamble
> > +. ./common/attr
> > +_begin_fstest auto quick log preallocrw dangerous
> > +
> > +_supported_fs generic
> > +_require_scratch
> > +_require_attrs
> > +_require_xfs_io_command falloc -k
> 
> Since this is now a generic test and we're using direct IO, also:
> 
> _require_odirect
> 
> > +_fixed_by_kernel_commit XXXXXXXXXXXX \
> > +       "btrfs: fix crash on racing fsync and size-extending write into prealloc"
> 
> Because it's now a generic test, it should be:
> 
> [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit ....
> 
> Otherwise it looks good to me, so with that:
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks Filipe, merged this patch with above review points, more details refer to
"patches-in-queue" branch. Feel free to have more review points before I push
to for-next :)

Thanks,
Zorro

> 
> Thanks.
> 
> > +
> > +# -i slows down xfs_io startup and makes the race much less reliable.
> > +export XFS_IO_PROG="$(echo "$XFS_IO_PROG" | sed 's/ -i\b//')"
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > +_scratch_mount
> > +
> > +blksz=$(_get_block_size "$SCRATCH_MNT")
> > +
> > +# On Btrfs, since this is the only file on the filesystem, its metadata is at
> > +# the end of a B-tree leaf. We want an ordered extent completion to add an
> > +# extent item at the end of the leaf while we're logging prealloc extents
> > +# beyond i_size after an xattr was set.
> > +for ((i = 0; i < 5000; i++)); do
> > +       $XFS_IO_PROG -ftd -c "falloc -k 0 $((blksz * 3))" -c "pwrite -q -w 0 $blksz" "$SCRATCH_MNT/file"
> > +       $SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/file"
> > +       $XFS_IO_PROG -d -c "pwrite -q -w $blksz $blksz" "$SCRATCH_MNT/file"
> > +done
> > +
> > +# If it didn't crash, we're good.
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/generic/745.out b/tests/generic/745.out
> > new file mode 100644
> > index 00000000..fce6b7f5
> > --- /dev/null
> > +++ b/tests/generic/745.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 745
> > +Silence is golden
> > --
> > 2.45.1
> >
> >
> 


