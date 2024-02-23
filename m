Return-Path: <linux-btrfs+bounces-2664-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1AE860DE5
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 10:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2AEA1C222E2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8E61AAD8;
	Fri, 23 Feb 2024 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkX7Vmsa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448242ABC;
	Fri, 23 Feb 2024 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708680207; cv=none; b=jky8z/LXETD0lXh/+FZJVwaV/UUNJGI1V91Ww7TWQ9LPhNWUYkaZoAaKmnuthqAcCE3PbAOZIR5PMa5tNyiCyWl55ia357wcfBpVnyfDUrC1VR8KOnnpY5evT7YhLEe0lroDUGUJHJWjEFEaBCC9fWAiTiun6Na13S+gkjjpN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708680207; c=relaxed/simple;
	bh=7m3zB7CC1AOLFKBG4XNFpmCKjO+cwTOOdwIn34He8Ys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3nGys8bzWmD76Ta0bWBxGwvljVBvbvSc/hqHThgKRNWuECuxT0a7o9eVfcnWqjg30QRWkd/rlV9icpQUomOwnf851z9wc4Z3LTr+ULOpz/QDs57+hsRPzPLY2Qi8XzuQvPlY3e52ayfYmyNY7dFEI/MdjPzrTcGI7oyfqFgemo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkX7Vmsa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1E9C433F1;
	Fri, 23 Feb 2024 09:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708680206;
	bh=7m3zB7CC1AOLFKBG4XNFpmCKjO+cwTOOdwIn34He8Ys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GkX7VmsapQxVdswr4AzbGnyKXB7l7KwQaKbtwQ+8BqQ0ysSiF2ILqaP2UWubgUGcQ
	 sxdEoRYeoN4W33yeHf9XroFeHlLJJ4El9FNzBHGYmhh9+2MQFEJmFTyOW+FGiVQuzQ
	 L5E7MZO/VaKdulTFifRSDuNUpWdY1E8/5XGbUbsbeqvjBfePebDMXBT3x/OuZyZVL0
	 NADdCNeDVsczc0mQ/Y1r55JLG8M8TLowbQFc2Ghw+6SFYzTtDwA77tz3HwTaux75tB
	 xQKXoT/YvUD5pL8s0EPXH16OjqhvOvHzCIebBFmA2klba4grbHwB68Lf0toIT89x57
	 IR6PQRmrtjzFQ==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso699740a12.0;
        Fri, 23 Feb 2024 01:23:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2dAqWd6teEXYlGyCkHIEWBLCXTD8WECNWkK5nthrZWzCkJpx2ZzuOyjQpJ/M1Dt0CyvyceYrVUkarNyMp8pvB/PN+ofzsyw==
X-Gm-Message-State: AOJu0YwLKtkpV0uHeyWHvUEMFIYcsTgjIOf/NMX3+GOgsf49Mhb5Ylpw
	kzhzOM3bg0qlTzvYU3D86mPfNvR/cLMiSKO8kwFk0TWbKSwnbsNGpI9mEhIEz2sbFT9pQ2ZYvYu
	AJz5cBW4h2HswFwhumhSh8tII5xA=
X-Google-Smtp-Source: AGHT+IEfijA8fcWVk+oyz08wp5YKQzF1zjCqbSigX4erEZyQ103pqmwaZiH/KxTEmKUjE5nGOzwe1p4D/z95H+fVHzE=
X-Received: by 2002:a17:906:a856:b0:a3f:c006:f141 with SMTP id
 dx22-20020a170906a85600b00a3fc006f141mr253962ejb.62.1708680204956; Fri, 23
 Feb 2024 01:23:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223085740.138791-1-wqu@suse.com>
In-Reply-To: <20240223085740.138791-1-wqu@suse.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Fri, 23 Feb 2024 09:22:48 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5qgB7Qrxf3JpKqQUu93=2eZ-6-Wea2pRQBEa2WpDLpSA@mail.gmail.com>
Message-ID: <CAL3q7H5qgB7Qrxf3JpKqQUu93=2eZ-6-Wea2pRQBEa2WpDLpSA@mail.gmail.com>
Subject: Re: [PATCH] fstests: btrfs: add a test case to make sure inconsitent
 qgroup won't leak reserved data space
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 8:58=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>
> There is a kernel regression caused by commit e15e9f43c7ca ("btrfs:
> introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTING to skip qgroup
> accounting"), where if qgroup is inconsistent (not that hard to trigger)
> btrfs would leak its qgroup data reserved space, and cause a warning at
> unmount time.
>
> The test case would verify the behavior by:
>
> - Enable qgroup first
>
> - Intentionally mark qgroup inconsistent
>   This is done by taking a snapshot and assign it to a higher level
>   qgroup, meanwhile the source has no higher level qgroup.
>
> - Trigger a large enough write to cause qgroup data space leak
>
> - Unmount and check the dmesg for the qgroup rsv leak warning
>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/btrfs/303     | 60 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/303.out |  2 ++
>  2 files changed, 62 insertions(+)
>  create mode 100755 tests/btrfs/303
>  create mode 100644 tests/btrfs/303.out
>
> diff --git a/tests/btrfs/303 b/tests/btrfs/303
> new file mode 100755
> index 00000000..44dbaeab
> --- /dev/null
> +++ b/tests/btrfs/303
> @@ -0,0 +1,60 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test 303
> +#
> +# Make sure btrfs qgroup won't leak its reserved data space if qgroup is
> +# marked inconsistent.
> +#
> +# This exercises a regression introduced in v6.1 kernel by the following=
 commit:
> +#
> +# e15e9f43c7ca ("btrfs: introduce BTRFS_QGROUP_RUNTIME_FLAG_NO_ACCOUNTIN=
G to skip qgroup accounting")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> +_supported_fs btrfs
> +_require_scratch
> +
> +_fixed_by_kernel_commit eb96e221937a \

Erroneous line here.

> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "btrfs: qgroup: always free reserved space for extent records"
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount
> +
> +$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +$BTRFS_UTIL_PROG qgroup create 1/0 $SCRATCH_MNT >> $seqres.full
> +$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/subv1 >> $seqres.full
> +
> +# This would mark qgroup inconsistent, as the snapshot belows to a diffe=
rent
> +# higher level qgroup, we have to do full rescan on both source and snap=
shot.
> +# This can be very slow for large subvolumes, so btrfs only marks qgroup
> +# inconsitent and let users to determine when to do a full rescan

inconsitent -> inconsistent

> +$BTRFS_UTIL_PROG subvolume snapshot -i 1/0 $SCRATCH_MNT/subv1 $SCRATCH_M=
NT/snap1 >> $seqres.full
> +
> +# This write would lead to a qgroup extent record holding the reserved 1=
28K.
> +# And for unpatched kernels, the reserved space would not be freed prope=
rly
> +# due to qgroup is inconsistent.
> +_pwrite_byte 0xcd 0 128K $SCRATCH_MNT/foobar >> $seqres.full
> +
> +# The qgroup leak detection is only triggered at unmount time.
> +_scratch_unmount
> +
> +# Check the dmesg warning for data rsv leak.
> +#
> +# If CONFIG_BTRFS_DEBUG is enabled, we would have a kernel wanring with

wanring -> warning

Otherwise it looks good, and you can have

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Especially after removing the erroneous _fixed_by_kernel_commit line.
Thanks.

> +# backtrace, but for release builds, it's just a warning line.
> +# So here we manually check the warning message.
> +if _dmesg_since_test_start | grep -q "leak"; then
> +       _fail "qgroup data reserved space leaked"
> +fi
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=3D0
> +exit
> diff --git a/tests/btrfs/303.out b/tests/btrfs/303.out
> new file mode 100644
> index 00000000..d48808e6
> --- /dev/null
> +++ b/tests/btrfs/303.out
> @@ -0,0 +1,2 @@
> +QA output created by 303
> +Silence is golden
> --
> 2.42.0
>
>

