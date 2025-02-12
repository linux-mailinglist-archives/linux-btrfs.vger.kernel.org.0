Return-Path: <linux-btrfs+bounces-11401-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ED0A32826
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 15:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ED823A531F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2025 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24780210186;
	Wed, 12 Feb 2025 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ng82MDeP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CFA20FA9D
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 14:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739369540; cv=none; b=qx4qOTIvEmZOFjrE7pKS2dJ6XDbiuBoPNeMBxGa8F7XmlxFffyz7Tz5PNMEV+978jgtCY88E3ShPc+ML1SJ8uALochi0l713Sl2D8v1T8RZCjYkDdy5hCG/jfIUDtcco+iVoxfeyt1NSl/RPCiTOZ95QQ0EbK37CBalWCtcfzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739369540; c=relaxed/simple;
	bh=DfMo3fpU+ZaCcD01USQ9QlAjcp97KNKu0cTkDOSvC5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tl3P12pnggG2muH9wiZuZYElfJxLGz5GkWnc4Lt9WGFcP0KpvkCjSRaQsQs+zhoGzOMwuRccs6dRO9J3H/v4nlAold11Y7kjYoMAfvZNbMjrcSaXc9gQhMhqD1xDL/e4q6MIILFt+LbtVugrDYHKp05cY9Xlb6n89fVdShJ+hKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ng82MDeP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739369537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QqklkF2wM7Dvc2tnyKwBTZhu7zUVqNPBwlh/B6VLTnI=;
	b=Ng82MDePPI8uGXg6gs6QcHQf56KrpkHo+WU2/kZR7yskOk3yyFRtGgoVSTmAjE8SiI3E5l
	02+fMvEFlLFBaU/ckdQWikLBx9vZiJsP8f8sffdVjYM/7l59a3eltXw9XOIrtud6M+NjZ+
	yJWrRTfLXdmxuSJwWtmAbW88sS2zmR0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-AV1qXy1zNNanzxwmfHZs4A-1; Wed, 12 Feb 2025 09:12:16 -0500
X-MC-Unique: AV1qXy1zNNanzxwmfHZs4A-1
X-Mimecast-MFC-AGG-ID: AV1qXy1zNNanzxwmfHZs4A_1739369535
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-21f73260b22so86779665ad.1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2025 06:12:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739369535; x=1739974335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QqklkF2wM7Dvc2tnyKwBTZhu7zUVqNPBwlh/B6VLTnI=;
        b=nMpqR3vhVGKIDJmGNdwHwQYaBuDfzNTwm0c3v2lhnRyvgtFwK3tlDU48odFAltRKmY
         mi09CNDBsaJdQzzMR/TjWUtzluazSh9o0UHp6JSQEeY9lQDo28r2qNxKZUfCWtcO4HQm
         Qab2mXY2xKwY3Zjganw8SMgb2KNx3C3cluFrEyDCa47FZwGdyLQCC0YwJnJ8Bu/ln5qy
         46YiY1JWV3DqvFL8Ia0Z+PoILHH06+4qQO1W8pmYYiVSHopi/Err5+vYxIFWof0QvhJh
         E52/E/HV/GaSYzVTtpA6ngX3KmAWoKeRb5XOk+dZhomCiC6h9ZIHxvFPs8+NMA2OuH32
         E/Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWqpI5Vb83CFn6KIZ/eoK0jNF+osYsrSXxhafmhWpMfLzYFSrWQG090HMvYB2UnKqwb6h2qsQtpVJtfxA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDmSVgxsB/KnxXj0hXnUiruxzeXVYKkqqAhd02qmkONMb5616w
	3o93JtxmKJv/nx3KBOKGZv9cNnychEKPQ22m7NamBI55r4f7dcu10M8Fgt8Xag3S0hTS3v6p0NB
	9og/JxZOyv1ZmSBVutiwBgmWeRZ9RKX3le1yXMrk1R0QWYy54NABVR/hQrxoklCtGivl7SQo=
X-Gm-Gg: ASbGncuIZpWk9Q+uoTMs87CN//SEvZSE+kABtElcQRoN4EXyE94rQ41TSCnnydR56eJ
	EoKlIXi1L0O6mh1paeu/+bH2q/M4mhz3VVFuZ8xGUS24NjnQY8bpAsaomlq/bXD2xF6dagnN+SY
	sPOJ5hpV3FrMVLMurA04vU29rX7kk4lh9qfnOCNR2xRw041UAdwEFEu/dXsvtIok5YBN2b/OobD
	Kkntx6O2lbeUFEg8tDhL8F2ZrXYZkJBkzYAxhYKnAowop53FIVHyeT7joKKFqJVT9IThCuVr0My
	v9LKQXzgYpcw81ghrTxI2Kvzsn6SUNoe+QAVDfV+ED7o8A==
X-Received: by 2002:a17:903:2b05:b0:21f:4b01:b985 with SMTP id d9443c01a7336-220be007160mr46027875ad.45.1739369533304;
        Wed, 12 Feb 2025 06:12:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFespjGa3ie8YbhdXg9QxEeNJEn/Sfmx/F+qj84dd93CY9usjelxTh7awlJ75UvzRu3ay/VpQ==
X-Received: by 2002:a17:903:2b05:b0:21f:4b01:b985 with SMTP id d9443c01a7336-220be007160mr46025975ad.45.1739369531219;
        Wed, 12 Feb 2025 06:12:11 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3655164bsm113822365ad.85.2025.02.12.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 06:12:10 -0800 (PST)
Date: Wed, 12 Feb 2025 22:12:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: suggest fs specific fix only if the tested
 filesystem matches
Message-ID: <20250212141206.y65onr7xfyy5qdll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8c64ba21953b44b682c72b448bebe273dba64013.1738847088.git.fdmanana@suse.com>
 <20250212015310.ifnjdxj53jbsy2qx@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H6wzKJCBR0qbGsTEiCH1PV977+XLC+Atr4kMfhd5nXAVQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H6wzKJCBR0qbGsTEiCH1PV977+XLC+Atr4kMfhd5nXAVQ@mail.gmail.com>

On Wed, Feb 12, 2025 at 12:38:27PM +0000, Filipe Manana wrote:
> On Wed, Feb 12, 2025 at 1:53 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Thu, Feb 06, 2025 at 01:05:06PM +0000, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > It's odd when a test fails on a filesystem and a specific fix is suggested
> > > for another filesystem. Some generic tests are suggesting filesystem
> > > specific fixes without checking if the running filesystem matches, so
> > > update them.
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  tests/generic/365 | 10 ++++++----
> > >  tests/generic/366 |  2 +-
> > >  tests/generic/367 |  2 +-
> > >  tests/generic/623 |  2 +-
> > >  tests/generic/631 |  2 +-
> > >  tests/generic/646 |  2 +-
> > >  tests/generic/649 |  2 +-
> > >  tests/generic/695 |  2 +-
> > >  tests/generic/700 |  4 ++--
> > >  tests/generic/701 |  2 +-
> > >  tests/generic/702 |  2 +-
> > >  tests/generic/704 |  4 +++-
> > >  tests/generic/707 |  4 ++--
> > >  13 files changed, 22 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/tests/generic/365 b/tests/generic/365
> > > index 1f6a618a..1bca848a 100755
> > > --- a/tests/generic/365
> > > +++ b/tests/generic/365
> > > @@ -9,10 +9,12 @@
> > >  . ./common/preamble
> > >  _begin_fstest auto rmap fsmap
> > >
> > > -_fixed_by_kernel_commit 68415b349f3f \
> > > -     "xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> > > -_fixed_by_kernel_commit ca6448aed4f1 \
> > > -     "xfs: Fix missing interval for missing_owner in xfs fsmap"
> > > +if [ "$FSTYP" = "xfs" ]; then
> > > +     _fixed_by_kernel_commit 68415b349f3f \
> > > +             "xfs: Fix the owner setting issue for rmap query in xfs fsmap"
> > > +     _fixed_by_kernel_commit ca6448aed4f1 \
> > > +             "xfs: Fix missing interval for missing_owner in xfs fsmap"
> > > +fi
> > >
> > >  . ./common/filter
> > >
> > > diff --git a/tests/generic/366 b/tests/generic/366
> > > index b322bcca..b2c2e607 100755
> > > --- a/tests/generic/366
> > > +++ b/tests/generic/366
> > > @@ -23,7 +23,7 @@ _require_scratch
> > >  _require_odirect 512 # see fio job1 config below
> > >  _require_aio
> > >
> > > -_fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > >       "btrfs: avoid deadlock when reading a partial uptodate folio"
> > >
> > >  iterations=$((32 * LOAD_FACTOR))
> > > diff --git a/tests/generic/367 b/tests/generic/367
> > > index 7cf90695..ed371a02 100755
> > > --- a/tests/generic/367
> > > +++ b/tests/generic/367
> > > @@ -17,7 +17,7 @@
> > >
> > >  _begin_fstest ioctl quick
> > >
> > > -_fixed_by_kernel_commit 2a492ff66673 \
> > > +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 2a492ff66673 \
> > >       "xfs: Check for delayed allocations before setting extsize"
> > >
> > >  _require_scratch_extsize
> > > diff --git a/tests/generic/623 b/tests/generic/623
> > > index 6487ccb8..9f41b5cc 100755
> > > --- a/tests/generic/623
> > > +++ b/tests/generic/623
> > > @@ -11,7 +11,7 @@ _begin_fstest auto quick shutdown
> > >
> > >  . ./common/filter
> > >
> > > -_fixed_by_kernel_commit e4826691cc7e \
> > > +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit e4826691cc7e \
> > >       "xfs: restore shutdown check in mapped write fault path"
> > >
> > >  _require_scratch_nocheck
> > > diff --git a/tests/generic/631 b/tests/generic/631
> > > index 8e2cf9c6..c38ab771 100755
> > > --- a/tests/generic/631
> > > +++ b/tests/generic/631
> > > @@ -41,7 +41,7 @@ _require_attrs trusted
> > >  _exclude_fs overlay
> > >  _require_extra_fs overlay
> > >
> > > -_fixed_by_kernel_commit 6da1b4b1ab36 \
> > > +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 6da1b4b1ab36 \
> > >       "xfs: fix an ABBA deadlock in xfs_rename"
> > >
> > >  _scratch_mkfs >> $seqres.full
> > > diff --git a/tests/generic/646 b/tests/generic/646
> > > index dc73aeb3..b3b0ab0a 100755
> > > --- a/tests/generic/646
> > > +++ b/tests/generic/646
> > > @@ -14,7 +14,7 @@
> > >  . ./common/preamble
> > >  _begin_fstest auto quick recoveryloop shutdown
> > >
> > > -_fixed_by_kernel_commit 50d25484bebe \
> > > +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 50d25484bebe \
> > >       "xfs: sync lazy sb accounting on quiesce of read-only mounts"
> > >
> > >  _require_scratch
> > > diff --git a/tests/generic/649 b/tests/generic/649
> > > index a33b13ea..58ef96a8 100755
> > > --- a/tests/generic/649
> > > +++ b/tests/generic/649
> > > @@ -31,7 +31,7 @@ _cleanup()
> > >
> > >
> > >  # Modify as appropriate.
> > > -_fixed_by_kernel_commit 72a048c1056a \
> > > +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 72a048c1056a \
> > >       "xfs: only set IOMAP_F_SHARED when providing a srcmap to a write"
> > >
> > >  _require_cp_reflink
> > > diff --git a/tests/generic/695 b/tests/generic/695
> > > index df81fdb7..694f4245 100755
> > > --- a/tests/generic/695
> > > +++ b/tests/generic/695
> > > @@ -25,7 +25,7 @@ _cleanup()
> > >  . ./common/dmflakey
> > >  . ./common/punch
> > >
> > > -_fixed_by_kernel_commit e6e3dec6c3c288 \
> > > +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit e6e3dec6c3c288 \
> > >          "btrfs: update generation of hole file extent item when merging holes"
> > >  _require_scratch
> > >  _require_dm_target flakey
> > > diff --git a/tests/generic/700 b/tests/generic/700
> > > index 052cfbd6..7f84df9d 100755
> > > --- a/tests/generic/700
> > > +++ b/tests/generic/700
> > > @@ -19,8 +19,8 @@ _require_scratch
> > >  _require_attrs
> > >  _require_renameat2 whiteout
> > >
> > > -_fixed_by_kernel_commit 70b589a37e1a \
> > > -     xfs: add selinux labels to whiteout inodes
> > > +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 70b589a37e1a \
> > > +     "xfs: add selinux labels to whiteout inodes"
> > >
> > >  get_selinux_label()
> > >  {
> > > diff --git a/tests/generic/701 b/tests/generic/701
> > > index 527bba34..806cc65d 100755
> > > --- a/tests/generic/701
> > > +++ b/tests/generic/701
> > > @@ -22,7 +22,7 @@ _cleanup()
> > >       rm -r -f $tmp.* $junk_dir
> > >  }
> > >
> > > -_fixed_by_kernel_commit 92fba084b79e \
> > > +[ "$FSTYP" = "exfat" ] && _fixed_by_kernel_commit 92fba084b79e \
> > >       "exfat: fix i_blocks for files truncated over 4 GiB"
> > >
> > >  _require_test
> > > diff --git a/tests/generic/702 b/tests/generic/702
> > > index a506e07d..ae47eb27 100755
> > > --- a/tests/generic/702
> > > +++ b/tests/generic/702
> > > @@ -14,7 +14,7 @@ _begin_fstest auto quick clone fiemap
> > >  . ./common/filter
> > >  . ./common/reflink
> > >
> > > -_fixed_by_kernel_commit ac3c0d36a2a2f7 \
> > > +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit ac3c0d36a2a2f7 \
> > >       "btrfs: make fiemap more efficient and accurate reporting extent sharedness"
> > >
> > >  _require_scratch_reflink
> > > diff --git a/tests/generic/704 b/tests/generic/704
> > > index f452f9e9..f2360c42 100755
> > > --- a/tests/generic/704
> > > +++ b/tests/generic/704
> > > @@ -21,7 +21,9 @@ _cleanup()
> > >  # Import common functions.
> > >  . ./common/scsi_debug
> > >
> > > -_fixed_by_kernel_commit 7c71ee78031c "xfs: allow logical-sector sized O_DIRECT"
> > > +[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 7c71ee78031c \
> > > +     "xfs: allow logical-sector sized O_DIRECT"
> > > +
> > >  _require_scsi_debug
> > >  # If TEST_DEV is block device, make sure current fs is a localfs which can be
> > >  # written on scsi_debug device
> > > diff --git a/tests/generic/707 b/tests/generic/707
> > > index 3d8fac4b..23864038 100755
> > > --- a/tests/generic/707
> > > +++ b/tests/generic/707
> > > @@ -13,9 +13,9 @@ _begin_fstest auto
> > >
> > >  _require_scratch
> > >
> > > -_fixed_by_kernel_commit f950fd052913 \
> > > +[ "$FSTYP" = "udf" ] && _fixed_by_kernel_commit f950fd052913 \
> > >       "udf: Protect rename against modification of moved directory"
> > > -_fixed_by_kernel_commit 0813299c586b \
> > > +[ "$FSTYP" = "ext4" ] && _fixed_by_kernel_commit 0813299c586b \
> >
> > I'm wondering if it's a "ext4 only" bug, or it might can be [[ "$FSTYP" =~ ext[0-9]+ ]] ?
> 
> Not sure either, but other generic test cases do that, so it's
> probably best to do it like that.
> Do you want a new patch version with that change or can you change it yourself?

I'll change that when I merge it, just double check with you :)

Thanks,
Zorro

> 
> Thanks.
> 
> > Others looks good to me.
> >
> > Thanks,
> > Zorro
> >
> > >       "ext4: Fix possible corruption when moving a directory"
> > >
> > >  _scratch_mkfs >>$seqres.full 2>&1
> > > --
> > > 2.45.2
> > >
> > >
> >
> 


