Return-Path: <linux-btrfs+bounces-13882-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A78AAB35C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455D5166B1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 11:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB02290BA7;
	Mon, 12 May 2025 11:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7rz9oJ9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0F1A317E;
	Mon, 12 May 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747048647; cv=none; b=c1BP47imMf2Kb3XXOexMms6jSdoGm2XF0Wq2/DWhXzEg73LJMDu1kLwrvYUXeXWjSB3T+tGWdENXc4ShlgrQW9F3os1Mu6uy0bwZvOlUVyGdZ1CdpBkkVxE5CFXEH/iNU5GcaUUMBL5K51/0APYypzOKZwFKGYfbAypeELPSDlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747048647; c=relaxed/simple;
	bh=xSWldtXKYPXsY9pWZlXTaliyoXBXdImsAv6dkFdB2T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L7Eu8s0ooLNJjn5TKJnOFLqv06AAUcpUkISsd3wbqIk4fcY8o75moGZK5XKHLrhJfPVkrhztCIUEKYUweeH2CD30IljLoI225M3LyVW0qVReBlzBaXm8GSekmTXJ+r/NwucxlFO0grb9XfWO7EFEDcUkdFuQSuG3AQ8jDvjHj50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7rz9oJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CF3C4CEEF;
	Mon, 12 May 2025 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747048646;
	bh=xSWldtXKYPXsY9pWZlXTaliyoXBXdImsAv6dkFdB2T4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=P7rz9oJ9q+L1tAH2myUxCiv2S49eMNeJ66UDPgemJHvhk3quSBNZYVYTDvrQEyemc
	 6KcpKA7e6U+yX4ypBF3dS9VtgE94suL3MoU6RFQJ4XF747sDiK2oz5tBLyfyAS5f7Y
	 Vb1pVWZcWA/yVyFolRvF3HarTZf6YuRhiBdY69XiQhvBeCYnKQsOEZiLjj0eZFpVIk
	 oXhDM7zEka/vESJ5ZuiG2UTaGk9K/K1yORydrmpdjN78J+Ab97rAxBRktWFfcy8hul
	 zY7SFV9eF+qmtuqmz++9sNW1xwkb6Wv0qI5k+BC+kHvoXCpZ7OPvPalDLttY2aoAJo
	 0ttoQqc8MHw/Q==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad21a5466f6so574086466b.1;
        Mon, 12 May 2025 04:17:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzz6Psw2xIgcrLcOQ9Nm72p3kJraGKGvW9yL/QftuxWLPPWwdm1+lZF1xY6vOi/S7BzxxiW9mp@vger.kernel.org
X-Gm-Message-State: AOJu0Yykq/C7qbedupwQHp7SgSz/jChrh+x+j2tTJePzj1cGBSWnLagI
	kOLY1n3NUzhMJWF8ASC42MitPSaQ0ipD/h5XwAu9fTtLzNTcykV57tkdv1CSMKDoACH3/55CLm5
	q3AcHgDTMGyhmEG0fnYedpNzCYAM=
X-Google-Smtp-Source: AGHT+IHeLSE8bYLDzwBoGmmh+6DEkXn3N4Tg5NzViWTKKBJLM6GB7bUiLSYmdS7U5haJi8D3ilK2m5qZ8xBKF8Pj0Gg=
X-Received: by 2002:a17:907:8689:b0:ace:dc05:b186 with SMTP id
 a640c23a62f3a-ad21b426337mr1145244066b.21.1747048645519; Mon, 12 May 2025
 04:17:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512093910.390688-1-wqu@suse.com>
In-Reply-To: <20250512093910.390688-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Mon, 12 May 2025 12:16:48 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5i2ua1dT-aAfpcdybY2ifL71Mk=ENa-WiOmAX-Qd+8Gg@mail.gmail.com>
X-Gm-Features: AX0GCFt-DHitqQuC_f6b14VTifUs6zkKCzndncz_dTZp-cGnT_k2prmSHpGvGE4
Message-ID: <CAL3q7H5i2ua1dT-aAfpcdybY2ifL71Mk=ENa-WiOmAX-Qd+8Gg@mail.gmail.com>
Subject: Re: [PATCH v2] fstests: btrfs: a new test case to verify scrub and rescue=idatacsums
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org, 
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:40=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a kernel bug report that scrub will trigger a NULL pointer
> dereference when rescue=3Didatacsums mount option is provided.
>
> Add a test case for such situation, to verify kernel can gracefully
> reject scrub when  there is no csum tree.
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Looks good now, thanks.

> ---
> Changelog:
> v2:
> - Strictly require the scrub to fail
>   Suggested by Filipe
> ---
>  tests/btrfs/336     | 35 +++++++++++++++++++++++++++++++++++
>  tests/btrfs/336.out |  2 ++
>  2 files changed, 37 insertions(+)
>  create mode 100755 tests/btrfs/336
>  create mode 100644 tests/btrfs/336.out
>
> diff --git a/tests/btrfs/336 b/tests/btrfs/336
> new file mode 100755
> index 00000000..f6691bae
> --- /dev/null
> +++ b/tests/btrfs/336
> @@ -0,0 +1,35 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2025 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 336
> +#
> +# Make sure read-only scrub won't cause NULL pointer dereference with
> +# rescue=3Didatacsums mount option
> +#
> +. ./common/preamble
> +_begin_fstest auto scrub quick
> +
> +_fixed_by_kernel_commit 6aecd91a5c5b \
> +       "btrfs: avoid NULL pointer dereference if no valid extent tree"
> +
> +_require_scratch
> +_scratch_mkfs >> $seqres.full
> +
> +_try_scratch_mount "-o ro,rescue=3Dignoredatacsums" > /dev/null 2>&1 ||
> +       _notrun "rescue=3Dignoredatacsums mount option not supported"
> +
> +# For unpatched kernel this will cause NULL pointer dereference and cras=
h the kernel.
> +$BTRFS_UTIL_PROG scrub start -Br $SCRATCH_MNT >> $seqres.full 2>&1
> +# For patched kernel scrub will be gracefully rejected.
> +if [ $? -eq 0 ]; then
> +       echo "read-only scrub should fail but didn't"
> +fi
> +
> +_scratch_unmount
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/336.out b/tests/btrfs/336.out
> new file mode 100644
> index 00000000..9263628e
> --- /dev/null
> +++ b/tests/btrfs/336.out
> @@ -0,0 +1,2 @@
> +QA output created by 336
> +Silence is golden
> --
> 2.47.1
>
>

