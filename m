Return-Path: <linux-btrfs+bounces-17786-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8168ABDB5A3
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 23:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E11C4EED13
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Oct 2025 21:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A89830BF55;
	Tue, 14 Oct 2025 21:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0Jkl5b6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23330BB8E;
	Tue, 14 Oct 2025 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760475774; cv=none; b=bnFB7L41MCxae5uY9O9Q0iQPZWMbkm12OHqYFL9WUjwEdDdTKNlM24ni0xeiXKoRYykipEHUeHVqwT4RLMpfkAfr5Qu8iqOgIlOn4t30Tq0afrMysFVxualwGXkuQjjZrYDqJIPjD6IwLG9paYZk9Uf0GDeSHucs29cgK/IJ6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760475774; c=relaxed/simple;
	bh=9ppk9zCCHC1ADEC3zJePM7Kn9c3twDWNrd/askNiNuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwurrr6soAcZJJkCD2PP/Sy/6IDjqjkjOFleFncEoaS0J6lG0FFR22WBLtJiyUO2dR9cWPVc/UxSc1dMXJOQTli3vtX82yfL61/ytqEJuNKyDHQ991TldV95oePklbIUhHfdWUvzQMfH5XpV0ENN1JxVBvbW0+7ou+SwUmHqT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0Jkl5b6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34905C4CEE7;
	Tue, 14 Oct 2025 21:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760475774;
	bh=9ppk9zCCHC1ADEC3zJePM7Kn9c3twDWNrd/askNiNuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0Jkl5b6BTHHY2iF4Z//KsuIgvfeTHvH4fXmWDrB61+Wl1IUerF0e8AX7aSw6FfFZ
	 qntp0q56ijmpBmsu8dFuijxGm+tY/ErgkcI1IMUIUPgSBLudMoiRIh0tLZLU4XIzCQ
	 6UbGeRfmhDXqDM44pVQTDANKIweepoYq/ANUTBzuzyK1NCz8j4thTVbCWOCk6DbQhA
	 xECYaDDtt8P8ob1b1LIAg3oyChjbKZq8pq0o+LiemYTxX0jHiBDMtZs0J42IWxfi7u
	 faGobb0T/SrR1jPjChS3rX4ajfSKAV4b7XCKPo15yCT/+KuGpeFIzfTBFL9E3a/hoV
	 z09FD1E0ZIPog==
Date: Tue, 14 Oct 2025 14:02:53 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v4 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251014210253.GC6188@frogsfrogsfrogs>
References: <20251014084625.422974-1-johannes.thumshirn@wdc.com>
 <20251014084625.422974-4-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014084625.422974-4-johannes.thumshirn@wdc.com>

On Tue, Oct 14, 2025 at 10:46:25AM +0200, Johannes Thumshirn wrote:
> Add a basic smoke test for filesystems that support running on zoned
> block devices.
> 
> It creates a zloop device with 2 conventional and 62 sequential zones,
> mounts it and then runs fsx on it.
> 
> Currently this tests supports BTRFS, F2FS and XFS.
> 
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/generic/772     | 46 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/772.out |  2 ++
>  2 files changed, 48 insertions(+)
>  create mode 100755 tests/generic/772
>  create mode 100644 tests/generic/772.out
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..d2c982c8
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,46 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 772
> +#
> +# Smoke test for FSes with ZBD support on zloop
> +#
> +. ./common/preamble
> +_begin_fstest auto zone quick
> +
> +_cleanup()
> +{
> +	if test -b "$zloop"; then
> +		ID=$(echo $zloop | grep -oE '[0-9]+$')
> +		echo "remove id=$ID" > /dev/zloop-control

Probably ought to be a teardown helper ^^

_destroy_zloop() {
	local zloop="$1"

	test -b "$zloop" || return
	local id=$(echo $zloop | grep -oE '[0-9]+$')

	echo "remove id=$id" > /dev/zloop-control
}

Then everyone's cleanups can become:

_cleanup()
{
	_destroy_zloop "$zloop"
}

The test itself looks good though.

--D

> +	fi
> +}
> +
> +. ./common/zoned
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_scratch_size $((16 * 1024 * 1024)) #kB
> +_require_zloop
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +mnt="$SCRATCH_MNT/mnt"
> +zloopdir="$SCRATCH_MNT/zloop"
> +
> +mkdir -p $mnt
> +zloop=$(_create_zloop $zloopdir 256 2)
> +
> +_try_mkfs_dev $zloop 2>&1 >> $seqres.full ||\
> +	_notrun "cannot mkfs zoned filesystem"
> +_mount $zloop $mnt
> +
> +$FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx" >> $seqres.full
> +
> +umount $mnt
> +
> +echo Silence is golden
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/772.out b/tests/generic/772.out
> new file mode 100644
> index 00000000..98c13968
> --- /dev/null
> +++ b/tests/generic/772.out
> @@ -0,0 +1,2 @@
> +QA output created by 772
> +Silence is golden
> -- 
> 2.51.0
> 
> 

