Return-Path: <linux-btrfs+bounces-5526-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844E1900045
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FA081C21048
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 10:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DCF15E5B8;
	Fri,  7 Jun 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZ0kchGb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2F01CA85
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717754674; cv=none; b=qVzG2LFi3EJVRyZVnnSBRrdyQwCDFqLVKfyHmuZPTt352TQNHZJ8M5f+Tkz0l1CowAnbFjc9vqU9HTQpzpr0eGVoLUIpywGUtLFZe4ndrwBkA7w/cV8KJ2Rp8NCIfDuoRhR6RdwQRkAQe4y8Jpf1vqIUJUv2kBvSYBwaVs5kXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717754674; c=relaxed/simple;
	bh=xrzjx5Aq+dptHpPLsPeCd9sgbKk8a9QVZjEIgYhxQ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qae0vpBvxohkzLRldmr7aWwrZk4z6sjoya13nCXP4FCDAN7RQXIUx5KBDjbLAfF4pe1wb1L/FqObs8TTfW4QFtzAlmDVFFxf0b2fCViIbGr5rTmDM4y7Zuvcl4mOfUjDN3kqlSXdYTGKL4WmHwkI1qW5nhRxD7BGId5Gh7S9NtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZ0kchGb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717754670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FuRHwHrKIs/kBu+JXKDmRZuG3VFYdHYQoP0SpNwkv2Y=;
	b=eZ0kchGbuk4ChTo1z5bQcA2EL5SvKtA5IPw2Edsf8Qerp/QPetuWeigDdOGtEUh2xfQKwu
	XdzFd8WvMKGXNmXHtjEGh/iJeBXUBl5zvJARRCDO1yKfA1wnVMc7uyECWKUhOwAmdCYuxn
	pUxX/wEP6GzHM6b2DzBX1V7/9O3TnDI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-nhA_QHkDNGC4FB0JBtf50Q-1; Fri, 07 Jun 2024 06:04:28 -0400
X-MC-Unique: nhA_QHkDNGC4FB0JBtf50Q-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f653adaed8so23304415ad.2
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 03:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717754667; x=1718359467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuRHwHrKIs/kBu+JXKDmRZuG3VFYdHYQoP0SpNwkv2Y=;
        b=flY5MrSUueAMzOq2fHKbltWPIiZVrihfmdYs9kA0CXJgIpyWjV4sIt4eTD6nzcEsZF
         +3SM1wSbczSB7yG0sLO1I0Q3wVGcjYyZXSMQKtVy6zpxiqjsLlb5J96qxrlF3tLe8Y0u
         Z+PoEARNt/T8MvWUfjKTxuCuldKwpVygd1W0Dl8j6NVgEhiZzrn20uXG5Hk4MkhJnKtI
         lbVMJMW541UAyk1VAHjLVbyWzVBaDysTgNZeXo2AD3qmSVbUPncXAkrDeKJuegkNL/JH
         OkIL7beQCnXDeeijUBBNpWAd61FFV2rKm40U1xKhGkJhX5cG5+e0bEtRwxu7FZ1atdIA
         NEsw==
X-Forwarded-Encrypted: i=1; AJvYcCVb6CEab86lR/iabzVmyi0tIR/jo/ooo95ituW1fWL1RWIErzUYs33Rc+xET3S1vvzdm71zHMuikzlYu/ycr+WBhR2PgVwyKisnroc=
X-Gm-Message-State: AOJu0Ywmc6YmNg75zXmqBgfNQTsbEcxGaeY+U0QzQVUpH5PZUT8AJ2cJ
	YcJJnWiA2Vy4tXUyND9lIfQIzYWo0UuuzQfkwTpedxSaI5isfMuQt6geBsHGSG/z7qMDK/roZ7t
	YAiC/Rg6aJIlfJLbFCHT6NFyO/j1n6yIKILudsDDe4N/QJAzv6fskJ+ZWBNNRRHXMrWTnCjIf3A
	==
X-Received: by 2002:a17:902:d492:b0:1f6:8ae4:50de with SMTP id d9443c01a7336-1f6d039b624mr24338785ad.61.1717754667349;
        Fri, 07 Jun 2024 03:04:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz4V08Sbc7JnmBOQn1Qg435qayhIO2865bh6E7voBCHkxmxJl3hP8uY7EOXHAl5Lau0+EMvg==
X-Received: by 2002:a17:902:d492:b0:1f6:8ae4:50de with SMTP id d9443c01a7336-1f6d039b624mr24338405ad.61.1717754666684;
        Fri, 07 Jun 2024 03:04:26 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd80de1esm30270765ad.294.2024.06.07.03.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:04:26 -0700 (PDT)
Date: Fri, 7 Jun 2024 18:04:22 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH fstests v2] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
Message-ID: <20240607100422.w7k7spmyg7s6xfv4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <29a4df3b9a36eb17a958e92e375e03daf9312fa5.1716583705.git.osandov@fb.com>
 <d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com>
 <CAL3q7H7X8PuXp-P2vUhz4xbhvTGr4cRyLvwQiTLcmV=LWyBKYw@mail.gmail.com>
 <20240607051207.6qa3mlxfaqiwv2ww@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H57ebkufQ=oAJ5_R=XgebC0bbKLxfgfm5pPiRvCiv=xXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H57ebkufQ=oAJ5_R=XgebC0bbKLxfgfm5pPiRvCiv=xXQ@mail.gmail.com>

On Fri, Jun 07, 2024 at 10:43:47AM +0100, Filipe Manana wrote:
> On Fri, Jun 7, 2024 at 6:12 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Sun, May 26, 2024 at 12:47:49PM +0100, Filipe Manana wrote:
> > > On Fri, May 24, 2024 at 9:58 PM Omar Sandoval <osandov@osandov.com> wrote:
> > > >
> > > > From: Omar Sandoval <osandov@fb.com>
> > > >
> > > > This is a regression test for a Btrfs bug, but there's nothing
> > > > Btrfs-specific about it. Since it's a race, we just try to make the race
> > > > happen in a loop and pass if it doesn't crash after all of our attempts.
> > > >
> > > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > > ---
> > > > Changes from v1 [1]:
> > > >
> > > > - Added missing groups and requires.
> > > > - Simplified $XFS_IO_PROG calls.
> > > > - Removed -i flag from $XFS_IO_PROG to make race reproduce more
> > > >   reliably.
> > > > - Removed all of the file creation and dump-tree parsing since the only
> > > >   file on a fresh filesystem is guaranteed to be at the end of a leaf
> > > >   anyways.
> > > > - Rewrote to be a generic test.
> > > >
> > > > 1: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com/
> > > >
> > > >  tests/generic/745     | 44 +++++++++++++++++++++++++++++++++++++++++++
> > > >  tests/generic/745.out |  2 ++
> > > >  2 files changed, 46 insertions(+)
> > > >  create mode 100755 tests/generic/745
> > > >  create mode 100644 tests/generic/745.out
> > > >
> > > > diff --git a/tests/generic/745 b/tests/generic/745
> > > > new file mode 100755
> > > > index 00000000..925adba9
> > > > --- /dev/null
> > > > +++ b/tests/generic/745
> > >
> > > Btw, generic/745 already exists in the for-next branch (development is
> > > based against that branch nowadays).
> > >
> > > > @@ -0,0 +1,44 @@
> > > > +#! /bin/bash
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +# Copyright (c) Meta Platforms, Inc. and affiliates.
> > > > +#
> > > > +# FS QA Test 745
> > > > +#
> > > > +# Repeatedly prealloc beyond i_size, set an xattr, direct write into the
> > > > +# prealloc while extending i_size, then fdatasync. This is a regression test
> > > > +# for a Btrfs crash.
> > > > +#
> > > > +. ./common/preamble
> > > > +. ./common/attr
> > > > +_begin_fstest auto quick log preallocrw dangerous
> > > > +
> > > > +_supported_fs generic
> > > > +_require_scratch
> > > > +_require_attrs
> > > > +_require_xfs_io_command falloc -k
> > >
> > > Since this is now a generic test and we're using direct IO, also:
> > >
> > > _require_odirect
> > >
> > > > +_fixed_by_kernel_commit XXXXXXXXXXXX \
> > > > +       "btrfs: fix crash on racing fsync and size-extending write into prealloc"
> > >
> > > Because it's now a generic test, it should be:
> > >
> > > [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit ....
> > >
> > > Otherwise it looks good to me, so with that:
> > >
> > > Reviewed-by: Filipe Manana <fdmanana@suse.com>
> >
> > Thanks Filipe, merged this patch with above review points, more details refer to
> > "patches-in-queue" branch. Feel free to have more review points before I push
> > to for-next :)
> 
> Btw, there's a v3 with all that addressed:
> 
> https://lore.kernel.org/fstests/8c91247dd109bb94e8df36f2812274b5de2a7183.1716916346.git.osandov@osandov.com/
> 
> Also, looking at patches-in-queue, the test was added twice, once as
> generic/748 and once as generic/749, in two different commits.

Oh, I've merged this test case last week... sorry I forgot that. I'll keep
the g/748, and remove the g/749.

> 
> Also, unrelated, but this commit:
> 
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?h=patches-in-queue&id=b4c4ba99435aa7fd4f8a6e3c02938e357e137ec9
> 
> As a Signed-off-by tag for David Disseldorp instead of Reviewed-by.

Oh, this Signed-off-by tag is generated automatically by:

https://lore.kernel.org/fstests/c9e54af5-4370-4d45-a8ed-4098b06b2629@suse.com/T/#m8fc24d233b2cf3a323c94c2b8039c0f043e09023

if it's a mistake, I'll change it to Reviewed-by:

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > Thanks,
> > Zorro
> >
> > >
> > > Thanks.
> > >
> > > > +
> > > > +# -i slows down xfs_io startup and makes the race much less reliable.
> > > > +export XFS_IO_PROG="$(echo "$XFS_IO_PROG" | sed 's/ -i\b//')"
> > > > +
> > > > +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> > > > +_scratch_mount
> > > > +
> > > > +blksz=$(_get_block_size "$SCRATCH_MNT")
> > > > +
> > > > +# On Btrfs, since this is the only file on the filesystem, its metadata is at
> > > > +# the end of a B-tree leaf. We want an ordered extent completion to add an
> > > > +# extent item at the end of the leaf while we're logging prealloc extents
> > > > +# beyond i_size after an xattr was set.
> > > > +for ((i = 0; i < 5000; i++)); do
> > > > +       $XFS_IO_PROG -ftd -c "falloc -k 0 $((blksz * 3))" -c "pwrite -q -w 0 $blksz" "$SCRATCH_MNT/file"
> > > > +       $SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/file"
> > > > +       $XFS_IO_PROG -d -c "pwrite -q -w $blksz $blksz" "$SCRATCH_MNT/file"
> > > > +done
> > > > +
> > > > +# If it didn't crash, we're good.
> > > > +
> > > > +echo "Silence is golden"
> > > > +status=0
> > > > +exit
> > > > diff --git a/tests/generic/745.out b/tests/generic/745.out
> > > > new file mode 100644
> > > > index 00000000..fce6b7f5
> > > > --- /dev/null
> > > > +++ b/tests/generic/745.out
> > > > @@ -0,0 +1,2 @@
> > > > +QA output created by 745
> > > > +Silence is golden
> > > > --
> > > > 2.45.1
> > > >
> > > >
> > >
> >
> 


