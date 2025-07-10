Return-Path: <linux-btrfs+bounces-15426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3122FB0081A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 18:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0890E3BC09F
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Jul 2025 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A872EF2B1;
	Thu, 10 Jul 2025 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bY48yI5o"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494227A10F
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163685; cv=none; b=PoMmUPvz4W/upjsqzBA+u6j1FVGQOvvoPO4ySjO9lrvIanIw1n1+eQr1TY1Qw/RUuOQfw25m5VBH2um0rwx5sD5+Pqzeoci1dDe8qu+7ynJctZZPTc/h9u6KZtZKDuOcpTQpTRk1PYPgdFg7OZpxxezgmc5aAX9Bf8AoQLUlW7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163685; c=relaxed/simple;
	bh=DtbO3r2s0j76BIs6Ffl+0uBOgnz0YgHm4VHlGhIUtjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUCkRP8TrFMs5MQ5R35HBJbHDSWjTvbx4X/GcZoC5Bwnwgz+B7IRrAXjlC1XaSJYsMe4lYiHLrMZWzdtIVUOZTJt1YgHxIFiobT08kmJOqcMYDYN4QB6r7n35noxgfdExI7S7QZy2NkULDYjtnuVEOY4uoyXEn2QkZaqLy1t0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bY48yI5o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/S6ib9l1DK4vHAQjPyW40H5e/41gkSoFyJQWaqvpTVU=;
	b=bY48yI5o5qqgGIdvp6INwIYTC9v6UIxkRop2ohzM+jJ6wU+bBJTAitwrrVWkjAMRwhWF6q
	cknYmZPr9VD+/iK1ymVYwuFK4QJ48iLdnQ++XuAoVq5WAK9qTce3MjCf/wqRqMuVe+rnsE
	R8jwlYyrivvwl8HGiPEGzv/EmhXE/R0=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-KYAhOgYKP0ymjMDndWDLoQ-1; Thu, 10 Jul 2025 12:07:56 -0400
X-MC-Unique: KYAhOgYKP0ymjMDndWDLoQ-1
X-Mimecast-MFC-AGG-ID: KYAhOgYKP0ymjMDndWDLoQ_1752163676
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-311e7337f26so1192043a91.3
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Jul 2025 09:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163675; x=1752768475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/S6ib9l1DK4vHAQjPyW40H5e/41gkSoFyJQWaqvpTVU=;
        b=tUI2TlzZ5N+hbQlVNNDCDRwrSNvSQapHuoo9u6nnJdru1qG1j2D2bqPPdk6EpGcuum
         IEP2P2KjY3C0McqZSkgcNjtd8fNJ6pjcB74q1SFjCXZSdHsrFO1VmCSmTUES10I6sOHJ
         duUtMmOUbaD6qqFzTw2OCHuf55ZM6LoB62qDWmUozqW6kixNRFpNcAP6iY1sh88b/Fc5
         rhxPJrBIBRqVY8r5w6//yzuKk+H0aGrwa69zHAhkd0p2Yhp3MucKl/nUTWWgvL6CyKG2
         qUz2vQIsJTNl7qiTixaE3+VZg1oGgrnAbEffC4wVGvGTB3Id6T0VEqbBE7TRFbBmwcCO
         XWUA==
X-Forwarded-Encrypted: i=1; AJvYcCXqxl+VwaCpLDdRFAWLFYIiaeFT7FDUUTQKjfL97sMXtL4TFA2V1HiqQ8dKakixgOEd14WdN9wcucwZVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYkPk0y/vxDCKf8AB8loww1z/uQSR3YJVqvwKPBz8xwK5fCd2+
	lgbIWTuP07xrH9h//HhIzxYF/DefHC+x6hh0HPB5rz/7bWS3vx4RT5U5FA28e/vixzMWzksG/ZH
	jMVuaYy804w5ATHajrgRdjg+USC8croJ7bK4BcEKixI/LDtnkYQegy94OnvwPxVpM
X-Gm-Gg: ASbGncujaWHClnMEBVAnJZ+OPH3MWEDSk/yBiCSTZzHpXQKneIyFFgFGYx5Z1G3Ccqx
	wXWriHcJUXkN9n3gTYXLs0dy/1OhEERAertdQoXq3gKerdEmAx+Ufqzxby7JCSQC6TBassTBRH3
	qxf1AJxZ2y6EPu9QK2NiasNiA3DH+D4U8rfuNAGQJ4BmFuDjNio8wG2h8eXaPDpuJi3DsHiA1IP
	Xs/STLUCXwUbcs+L/t8lN4eS54oajkKOYaJZjQMD1y1m71W28ZKjj18cX4K5timHI13VXExNF/4
	Mqoe2GKaDPgnoAkfDioBqUqt56eB17IiW+a4tIXvt36vuI4uJcC/q3kctPJ5pnw=
X-Received: by 2002:a05:6a21:b95:b0:21f:50d9:dde with SMTP id adf61e73a8af0-22cd59ffe34mr11131068637.5.1752163675474;
        Thu, 10 Jul 2025 09:07:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/eWl5mrGN4itlRFZlA555g55yBF6fWT1l1eVNbgeOSVbnV62pbBn7FT2J7oe07aAYBA9l/g==
X-Received: by 2002:a05:6a21:b95:b0:21f:50d9:dde with SMTP id adf61e73a8af0-22cd59ffe34mr11131009637.5.1752163674865;
        Thu, 10 Jul 2025 09:07:54 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe5b0ffasm2638390a12.30.2025.07.10.09.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:07:54 -0700 (PDT)
Date: Fri, 11 Jul 2025 00:07:50 +0800
From: Zorro Lang <zlang@redhat.com>
To: Filipe Manana <fdmanana@kernel.org>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] generic: test overwriting file with mmap on a full
 filesystem
Message-ID: <20250710160750.q6sgqrfbazsxi2og@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <f28ef5098ed18d53df6f94faded1b352bb833527.1752049536.git.fdmanana@suse.com>
 <20250710072929.dfhksffdogk35ik7@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <CAL3q7H63UVfZ5xJfh2n0rfB4Y03_hgupvTxn2EWJgrNN+s=BvQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H63UVfZ5xJfh2n0rfB4Y03_hgupvTxn2EWJgrNN+s=BvQ@mail.gmail.com>

On Thu, Jul 10, 2025 at 12:47:30PM +0100, Filipe Manana wrote:
> On Thu, Jul 10, 2025 at 8:29 AM Zorro Lang <zlang@redhat.com> wrote:
> >
> > On Wed, Jul 09, 2025 at 09:53:50AM +0100, fdmanana@kernel.org wrote:
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that overwriting a file with mmap when the filesystem has no more
> > > space available for data allocation works. The motivation here is to check
> > > that NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> > >
> > > This currently fails with btrfs but it's fixed by a kernel patch that has
> > > the subject:
> > >
> > >    btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents
> > >
> > > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > > ---
> > >  tests/generic/211     | 58 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/211.out |  6 +++++
> > >  2 files changed, 64 insertions(+)
> > >  create mode 100755 tests/generic/211
> > >  create mode 100644 tests/generic/211.out
> > >
> > > diff --git a/tests/generic/211 b/tests/generic/211
> > > new file mode 100755
> > > index 00000000..c77508fe
> > > --- /dev/null
> > > +++ b/tests/generic/211
> > > @@ -0,0 +1,58 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 211
> > > +#
> > > +# Test that overwriting a file with mmap when the filesystem has no more space
> > > +# available for data allocation works. The motivation here is to check that
> > > +# NOCOW mode of a COW filesystem (such as btrfs) works as expected.
> > > +#
> > > +. ./common/preamble
> > > +_begin_fstest auto quick rw mmap
> > > +
> > > +. ./common/filter
> > > +
> > > +_require_scratch
> > > +
> > > +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> > > +     "btrfs: fix -ENOSPC mmap write failure on NOCOW files/extents"
> > > +
> > > +# Use a 512M fs so that it's fast to fill it with data but not too small such
> > > +# that on btrfs it results in a fs with mixed block groups - we want to have
> > > +# dedicated block groups for data and metadata, so that after filling all the
> > > +# data block groups we can do a NOCOW write with mmap (if we have enough free
> > > +# metadata space available).
> > > +fs_size=$(_small_fs_size_mb 512)
> > > +_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
> > > +     _fail "mkfs failed"
> >
> > _scratch_mkfs_sized calls _notrun if it fails:
> >
> >   _scratch_mkfs_sized()
> >   {
> >         _try_scratch_mkfs_sized "$@" || _notrun "_scratch_mkfs_sized failed with ($*)"
> >   }
> >
> > So you can let it _notrun:
> > _scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1
> >
> > or you'd like to _fail:
> >
> > _try_scratch_mkfs_sized $((fs_size * 1024 * 1024)) >>$seqres.full 2>&1 || \
> >          _fail "mkfs failed"
> 
> The fail makes more sense to me - having the _scratch_mkfs_sized()
> calling _notrun doesn't make sense to me at the moment.

OK, so you can use _try_scratch_mkfs_sized.

> 
> >
> > > +_scratch_mount
> > > +
> > > +touch $SCRATCH_MNT/foobar
> > > +
> > > +# Set the file to NOCOW mode on btrfs, which must be done while the file is
> > > +# empty, otherwise it fails.
> > > +if [ $FSTYP == "btrfs" ]; then
> > > +     _require_chattr C
> > > +     $CHATTR_PROG +C $SCRATCH_MNT/foobar
> > > +fi
> > > +
> > > +# Add initial data to the file we will later overwrite with mmap.
> > > +$XFS_IO_PROG -c "pwrite -S 0xab 0 1M" $SCRATCH_MNT/foobar | _filter_xfs_io
> > > +
> > > +# Now fill all the remaining space with data.
> > > +blksz=$(_get_block_size $SCRATCH_MNT)
> > > +dd if=/dev/zero of=$SCRATCH_MNT/filler bs=$blksz >>$seqres.full 2>&1
> >
> > As this's a generic test case, I'm wondering if the common/populate:_fill_fs()
> > helps?
> 
> Because the intention is to exhaust data space and leave enough
> metadata space free so that the NOCOW write can be done, as Qu already
> replied before.
> In btrfs we have space divided in two sections (block groups): one for
> data and one for metadata.
> Metadata is always COWed in btrfs by design, data can be NOCOWed
> (chattr +C or prealloc extents for the first write) - as longs as
> there's enough metadata space available (every data write requires
> updating some metadata).
> 
> If this is too specific or hard to comprehend, I can move the test
> case into tests/btrfs/ (we have a few similar to this scenario iirc).
> Let me know if I shall move it into tests/btrfs/.

Thanks for the detailed explanation from you and Qu:) If so, maybe
_get_file_block_size better than _get_block_size?

I think we can keep this case in generic directory, it's a btrfs bug reproducer
and it won't break other fs test. If someone fs hopes to change that "fill fs"
part, we can use if...else... so maybe you can add more comments about why btrfs
need this dd operation rather than _fill_fs things, to avoid others change this
part in the future.

Thanks,
Zorro

> 
> Thanks.
> 
> >
> > Thanks,
> > Zorro
> >
> > > +
> > > +# Overwrite the file with a mmap write. Should succeed.
> > > +$XFS_IO_PROG -c "mmap -w 0 1M"        \
> > > +          -c "mwrite -S 0xcd 0 1M" \
> > > +          -c "munmap"              \
> > > +          $SCRATCH_MNT/foobar
> > > +
> > > +# Cycle mount and dump the file's content. We expect to see the new data.
> > > +_scratch_cycle_mount
> > > +_hexdump $SCRATCH_MNT/foobar
> > > +
> > > +# success, all done
> > > +_exit 0
> > > diff --git a/tests/generic/211.out b/tests/generic/211.out
> > > new file mode 100644
> > > index 00000000..71cdf0f8
> > > --- /dev/null
> > > +++ b/tests/generic/211.out
> > > @@ -0,0 +1,6 @@
> > > +QA output created by 211
> > > +wrote 1048576/1048576 bytes at offset 0
> > > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > > +000000 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  >................<
> > > +*
> > > +100000
> > > --
> > > 2.47.2
> > >
> > >
> >
> 


