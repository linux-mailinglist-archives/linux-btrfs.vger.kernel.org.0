Return-Path: <linux-btrfs+bounces-16363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68637B35ACA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 13:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDE11797EA
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075362BF011;
	Tue, 26 Aug 2025 11:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klSoU7zC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0720B7EE;
	Tue, 26 Aug 2025 11:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206685; cv=none; b=TMDNfQ4Ml9jCj1adlw8DfEwb/rw88mgEI3q/VGrH6SP5Kt7HIt5bKj8eVwVZxYZ+h/NusC7DIMryFR8XpWCLcPReENFDt7BCSK0qMG08xmKRy2NPEAEKWS6H3Dj1W0IKooKWP67nNPHsWAGwglevVKlJcyoBF50mzIn2jYhotH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206685; c=relaxed/simple;
	bh=95TjGk0lZTLhT3/jIYzpQbFDCQgn2AhbNMHQGiaFSWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c3QPRBVU+GcTbcyJFwa0Kx8I7kSmLioFpAhDy1vfmKJd6ZnT13KirEeHSGKoohIS5fwpEe5e8u9IwwO+ehS/B2tfTsg7bG5ydlcbl4qwxUAnFis8yrdhbGVgTCkfR4dE5+419B1SOK6kRCS6VgVLhPJDipxFA7+nuv6tQQCiaxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klSoU7zC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D1EC4CEF1;
	Tue, 26 Aug 2025 11:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756206684;
	bh=95TjGk0lZTLhT3/jIYzpQbFDCQgn2AhbNMHQGiaFSWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=klSoU7zCM0mwQaqTRkqzQ2UP9sXPklM0uTb3ItdautmaC555gkem9U80N2pA4wKEw
	 i8Rk0v/Iw4cz31GsuWTr9BR/YeBBmGl2kQFXSGmBRVH8mJUbQOiAiZopfjpbO/gcpa
	 9TTs9y9JHXEGMrR/hYvy27zGXestAld+wQZwc7jOWx1noXJfHtedhVRzim02d+6sH2
	 O+fwv/wMeKHEeLkOkTZ3/vnOiegoAX0d0/ltm0bp6T2oEmL+N82cpeWn7xhKoBfbz4
	 WtV2ncJix8k8Td49vz1CeeXljh/wr1//X7NG0DarpH8/322C7jC11DUKTujSq+s8D/
	 +dm7Fn4VrjGpA==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb78ead12so753319466b.1;
        Tue, 26 Aug 2025 04:11:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxEVCJXT0VOfJGaCjEQGjmRCnoWk0MKTV90sF4zAfoCrXMSE7SMG2hEkkfnmRFBa5yAvtCAXXi@vger.kernel.org
X-Gm-Message-State: AOJu0YxmDvAreMztUY2Zo2ezahE7QbN4NI/kAaOeh0cr0zWS2C/Xkr5P
	QeR2nbD69YSHNad+nwJzQshb9QAD/WOgrh6ZxLVcKygZSe/YpL6ltXcJaWlBr9yype523RvaJSm
	IYkNv5w3uZecX3Q3wZ92RG9pyYDMVZ6U=
X-Google-Smtp-Source: AGHT+IGqoVJ27qRFtyTIyAI5xzQ5LyzY7htgZjQr2Wv7AdfzApB+VwunMt7xDoqPvVlxPGeF1JU6zVL8exUM8kOEPUg=
X-Received: by 2002:a17:907:9405:b0:ad8:9c97:c2e5 with SMTP id
 a640c23a62f3a-afe2875bfdcmr1508367266b.0.1756206683176; Tue, 26 Aug 2025
 04:11:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826103954.26168-1-wqu@suse.com>
In-Reply-To: <20250826103954.26168-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 26 Aug 2025 12:10:44 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4fkyrNnR=AuSQQMg2V12SRbRor87GXByhwgyTQ0rxOZQ@mail.gmail.com>
X-Gm-Features: Ac12FXyw1wJqeHumCSmS7m9ITYc-GOM3GzqbZOThUlbLcvwDtWvBp3PWLEBGfU4
Message-ID: <CAL3q7H4fkyrNnR=AuSQQMg2V12SRbRor87GXByhwgyTQ0rxOZQ@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: add a new test case to verify compressed read
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 11:40=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> The new test case is a regression test related to the block size < page
> size handling of compressed read.
>
> The test case will only be triggered with 64K page size and 4K btrfs
> block size.
> I'm using aarch64 with 64K page size to trigger the regression.
>
> The test case will create the following file layout:
>
>   base:
>   [0, 64K): Single compressed data extent at bytenr X.
>
>   new:
>   [0, 32K): Reflinked from base [32K, 64K)
>   [32K, 60K): Reflinked from base [0, 28K)
>   [60K, 64K): New 4K write
>
>   The range [0, 32K) and [32K, 64K) are pointing to the same compressed
>   data.
>
>   The last 4K write is a special workaround. It is a block aligned
>   write, thus it will create the folio but without reading out the
>   remaing part.
>
>   This is to avoid readahead path, which has the proper fix.
>   We want single folio read without readahead.
>
> Then output the file "new" just after the last 4K write, then cycle
> mount and output the content again.
>
> For patched kernel, or with 4K page sized system, the test will pass,
> the resulted content will not change during mount cycles.
>
> For unpatched kernel and with 64K page size, the test will fail, the
> content after the write will be incorrect (the range [32K, 60K) will be
> zero), but after a mount cycle the content is correct again.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/337     | 56 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/337.out | 23 +++++++++++++++++++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/btrfs/337
>  create mode 100644 tests/btrfs/337.out
>
> diff --git a/tests/btrfs/337 b/tests/btrfs/337
> new file mode 100755
> index 00000000..9cd2ea42
> --- /dev/null
> +++ b/tests/btrfs/337
> @@ -0,0 +1,56 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 337
> +#
> +# Test compressed read with shared extents, especially for bs < ps cases=
.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick compress reflink

reflink -> clone

We don't have a reflink group, instead we have "clone" and "dedupe" groups.

> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: do more strict compressed read merge check"
> +
> +. ./common/filter
> +. ./common/reflink
> +
> +_require_btrfs_support_sectorsize 4096
> +_require_scratch_reflink
> +
> +# The layout used in the test case is all 4K based, and can only be repr=
oduced
> +# with page size larger than 4K.
> +_scratch_mkfs -s 4k >> $seqres.full
> +_scratch_mount "-o compress"
> +
> +# Create the reflink source, which must be a compressed extent.
> +$XFS_IO_PROG -f -c "pwrite -S 0x0f 0 32K" \
> +               -c "pwrite -S 0xf0 32K 32K" \
> +               -c sync $SCRATCH_MNT/base >> $seqres.full

As commented in the kernel patch, the sync is not needed. The reflink
operations will sync the file.
This is only distracting since it's not needed to trigger the bug.

> +echo "Reflink source:"
> +echo "Reflink source:" >> $seqres.full
> +od -t x1 $SCRATCH_MNT/base | _filter_od

We normally use the helper _hexdump.

> +
> +# Create the reflink dest, which reverse the order of the two 32K range.

reserve -> reverses
range -> ranges

Thanks.

> +#
> +# And do a further aligned write into the last block.
> +# This write is to make sure the folio exists in filemap, so that we won=
't go
> +# through the readahead path (which has the proper handling) for the fol=
io.
> +$XFS_IO_PROG -f -c "reflink $SCRATCH_MNT/base 32K 0 32K" \
> +               -c "reflink $SCRATCH_MNT/base 0 32K 32K" \
> +               -c "pwrite 60K 4K" $SCRATCH_MNT/new >> $seqres.full
> +
> +# This will result an incorrect output for unpatched kernel.
> +# The range [32K, 60K) will be zero due to incorrectly merged compressed=
 read.
> +echo "Before mount cycle:"
> +od -t x1 $SCRATCH_MNT/new | _filter_od
> +
> +_scratch_cycle_mount
> +
> +# This will go through readahead path, which has the proper handling, th=
us give
> +# the correct content.
> +echo "After mount cycle:"
> +od -t x1 $SCRATCH_MNT/new | _filter_od
> +
> +status=3D0
> +_exit 0
> diff --git a/tests/btrfs/337.out b/tests/btrfs/337.out
> new file mode 100644
> index 00000000..d3e35863
> --- /dev/null
> +++ b/tests/btrfs/337.out
> @@ -0,0 +1,23 @@
> +QA output created by 337
> +Reflink source:
> +0 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f
> +*
> +10 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
> +*
> +20
> +Before mount cycle:
> +0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
> +*
> +10 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f
> +*
> +17 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> +*
> +20
> +After mount cycle:
> +0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0 f0
> +*
> +10 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f 0f
> +*
> +17 cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd
> +*
> +20
> --
> 2.49.0
>
>

