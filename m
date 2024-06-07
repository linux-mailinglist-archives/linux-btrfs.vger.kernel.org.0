Return-Path: <linux-btrfs+bounces-5528-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A8900088
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 12:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71461F23A19
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2024 10:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A087B15B14A;
	Fri,  7 Jun 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewdDSdwx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A8D762C1
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Jun 2024 10:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717755567; cv=none; b=rps5JpM6orihaxorHuWl8cuR6HBg3OnzIpvCCKM49AfjodmaAKJNWjCsk1ZztDvBH/DYXc69k+KbNG6gIqpoBklTofqKoLzebPSW2rolHY8uSCReeMs0yo/o//CTJrQdL7I13CdWJz/oHz8TRmQE9KpoWiOMdOgcU0MIVaDhnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717755567; c=relaxed/simple;
	bh=nCTK21UVzeQz8unyvAfkDLdMajGX1MSJpjDAD/RDLvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hlpojg377S+vOVIopk5wC71Nofy1UStho/FE27EJ5rAg6JRi5Lkl6JScEq6hmNX0Vmagq0X0hFmBUJjYnMW2YFpIswYei8ZpuOO/hHqfpSrbx6Qx8x8cR2hckmg6A9vGMoqrlTS9pz3o+iKab71MEvDmVSWzvMZqCjeRwDGZDrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewdDSdwx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717755565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZfKhET66l2mLX8TP1Yz5d/Rt90kcoIUsziwhQo5Bis=;
	b=ewdDSdwxWXiMumUibcnB6CehsQTLK381RO7KNAgmO9jrItky/ASKaEJqfFZP+G0caQhSeu
	z9hPKvZj3Izdlj0A+LZJYwD+l6Aoi0+nYh/osusa1KbtBheCiCzRY8JD2IZuEzId7YOO82
	YrBNWaWxLYTWmuhUEauMk+sBSS1t7nU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-KRcNH7c0PBKrgcXezE4pHA-1; Fri, 07 Jun 2024 06:19:24 -0400
X-MC-Unique: KRcNH7c0PBKrgcXezE4pHA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-6c9b5e3dd67so1997436a12.0
        for <linux-btrfs@vger.kernel.org>; Fri, 07 Jun 2024 03:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717755563; x=1718360363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZfKhET66l2mLX8TP1Yz5d/Rt90kcoIUsziwhQo5Bis=;
        b=JLsnLt8WC2QvTOmDqRuSjjo7HjH/TT10x4nQImtbr1uxdzqtpzue1kTkrgbEBGe5JU
         fCdGEsmWdRZwRGBu0gBnL88PGaAV2PyemS8wBO8Juyi1zALhkW6/XBTGgU+8l+sN6p2D
         UYsu+m7VV8ThTU9d8olOhuqrnb00VGpn8JUje7nnhAQidTNdCMgnKctd0vnLFSFQJC2x
         oMeACCjYUch2bJdXIsyrTsrGoH1IgvdQnymArtyoCiHbYiyyNqmBFX34Lqe8zdCrd8Xb
         yoDXFS/k+uOkxlVJXXgnHb0fvcJSTxab3FqqhA2QoccppqyZD3Z5O9WYhEOBV05ooaI8
         8kHw==
X-Forwarded-Encrypted: i=1; AJvYcCW2G2dyU/3Mm+ox2aKIh3pc3Aj14+Xdh5Lnfhg3uTQxhqhBolVf78Ikv1Ma5J39DIKEstyO6DdnRFe31i2wX8g5dKQhDyMBa4rms74=
X-Gm-Message-State: AOJu0YyrUhAjxKj7z+NYOfQOfpJxL2Bm+QlMoyy0CC1m/ciGyOFu5re1
	YFBjglk/qjstXF3jYat2OTaK+NCLD/gZXJjLhZj+Sr5vYglqfB+oT38jhBFoZ3Qh/Org7aWhlok
	hwP8yVwe4dgWCgPCiSV3O9+JsOJReZ2gqYi/Y8jYvS/XHwsvbsB3q5Qn5BV45
X-Received: by 2002:a17:903:22cf:b0:1f6:e8ee:54a6 with SMTP id d9443c01a7336-1f6e8ee57f0mr1651265ad.59.1717755562680;
        Fri, 07 Jun 2024 03:19:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr2rl+5k5aOrDaut/tMd2AgcvUwfEIFu+FhrnUEycWXIHQ43xS/MhicW6XJjKiTejU17UqpQ==
X-Received: by 2002:a17:903:22cf:b0:1f6:e8ee:54a6 with SMTP id d9443c01a7336-1f6e8ee57f0mr1650945ad.59.1717755561875;
        Fri, 07 Jun 2024 03:19:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76c240sm31077465ad.89.2024.06.07.03.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 03:19:21 -0700 (PDT)
Date: Fri, 7 Jun 2024 18:19:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: Re: [PATCH fstests v3] generic: test Btrfs fsync vs. size-extending
 prealloc write crash
Message-ID: <20240607101918.sxasaimngo5564s6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <8c91247dd109bb94e8df36f2812274b5de2a7183.1716916346.git.osandov@osandov.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c91247dd109bb94e8df36f2812274b5de2a7183.1716916346.git.osandov@osandov.com>

On Tue, May 28, 2024 at 10:13:14AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> This is a regression test for a Btrfs bug, but there's nothing
> Btrfs-specific about it. Since it's a race, we just try to make the race
> happen in a loop and pass if it doesn't crash after all of our attempts.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
> Changes from v2 [1]:
> 
> - Rebased on for-next.
> - Added _require_odirect.
> - Added FSTYP check to _fixed_by_kernel_commit.
> - Added Filipe's Reviewed-by.
> 
> Changes from v1 [2]:
> 
> - Added missing groups and requires.
> - Simplified $XFS_IO_PROG calls.
> - Removed -i flag from $XFS_IO_PROG to make race reproduce more
>   reliably.
> - Removed all of the file creation and dump-tree parsing since the only
>   file on a fresh filesystem is guaranteed to be at the end of a leaf
>   anyways.
> - Rewrote to be a generic test.
> 
> 1: https://lore.kernel.org/linux-btrfs/d032e0b964f163229b684c0ac72b656ec9bf7b48.1716584019.git.osandov@osandov.com/
> 2: https://lore.kernel.org/linux-btrfs/297da2b53ce9b697d82d89afd322b2cc0d0f392d.1716492850.git.osandov@osandov.com/
> 
>  tests/generic/748     | 45 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/748.out |  2 ++
>  2 files changed, 47 insertions(+)
>  create mode 100755 tests/generic/748
>  create mode 100644 tests/generic/748.out
> 
> diff --git a/tests/generic/748 b/tests/generic/748
> new file mode 100755
> index 00000000..2ec33694
> --- /dev/null
> +++ b/tests/generic/748
> @@ -0,0 +1,45 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) Meta Platforms, Inc. and affiliates.
> +#
> +# FS QA Test 748
> +#
> +# Repeatedly prealloc beyond i_size, set an xattr, direct write into the
> +# prealloc while extending i_size, then fdatasync. This is a regression test
> +# for a Btrfs crash.
> +#
> +. ./common/preamble
> +. ./common/attr
> +_begin_fstest auto quick log preallocrw dangerous
> +
> +_supported_fs generic
> +_require_scratch
> +_require_attrs
> +_require_odirect
> +_require_xfs_io_command falloc -k
> +[ "$FSTYP" = btrfs ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
> +	"btrfs: fix crash on racing fsync and size-extending write into prealloc"
> +
> +# -i slows down xfs_io startup and makes the race much less reliable.
> +export XFS_IO_PROG="$(echo "$XFS_IO_PROG" | sed 's/ -i\b//')"

I think the "export" is not necessary, although it doesn't affect much :) I'll
remove it when I merge it. Is that good to you too?

> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +blksz=$(_get_block_size "$SCRATCH_MNT")

Maybe you'd like to use _get_file_block_size, which is more accurate
to get the minimum block size of a file as a generic test case.

I can help to do this change if you agree that too.

Thanks,
Zorro

> +
> +# On Btrfs, since this is the only file on the filesystem, its metadata is at
> +# the end of a B-tree leaf. We want an ordered extent completion to add an
> +# extent item at the end of the leaf while we're logging prealloc extents
> +# beyond i_size after an xattr was set.
> +for ((i = 0; i < 5000; i++)); do
> +	$XFS_IO_PROG -ftd -c "falloc -k 0 $((blksz * 3))" -c "pwrite -q -w 0 $blksz" "$SCRATCH_MNT/file"
> +	$SETFATTR_PROG -n user.a -v a "$SCRATCH_MNT/file"
> +	$XFS_IO_PROG -d -c "pwrite -q -w $blksz $blksz" "$SCRATCH_MNT/file"
> +done
> +
> +# If it didn't crash, we're good.
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/748.out b/tests/generic/748.out
> new file mode 100644
> index 00000000..dc050a96
> --- /dev/null
> +++ b/tests/generic/748.out
> @@ -0,0 +1,2 @@
> +QA output created by 748
> +Silence is golden
> -- 
> 2.45.1
> 
> 


