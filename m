Return-Path: <linux-btrfs+bounces-17531-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72237BC5757
	for <lists+linux-btrfs@lfdr.de>; Wed, 08 Oct 2025 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FDFC4E2956
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Oct 2025 14:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423402EBBB0;
	Wed,  8 Oct 2025 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drWa0epX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C32EB862;
	Wed,  8 Oct 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759934361; cv=none; b=AcVGTQUVIjSPd4IvhNqeFOFz3ss2wEcsh8YvmsQVR/rQW76shjcKbMKlu9KRnJgwncTruyma/Lm4a4mUYySJnMmpoTSA3/b3K8v+8TIf6ueWDTvCPE4w+CbuH6ho0sloYbJNPP3Y08Ksh/5aB0pEZ8V/ku+Udpt3QP3Q9ggm06o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759934361; c=relaxed/simple;
	bh=DwnbLd/w3kQxkRwT3MX69nNPsgenpojbUf4AVH4B/s8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho4OQgmFJ+x7N7kILMFzcJwFbgjM3OZxcqmhTtVmkOyMTqU11vddhAy/5znXz8DVqH3PnN6cSW/skVqs4n+CRUCNMwk8XmMf4+JMH94kuRvnVsVeiawiCD2IiDaXlnrylVJrJlUdNzyhwjh1xL74dvzJnTmhgX8ub5P5y9KQIFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drWa0epX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B80C4CEE7;
	Wed,  8 Oct 2025 14:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759934361;
	bh=DwnbLd/w3kQxkRwT3MX69nNPsgenpojbUf4AVH4B/s8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drWa0epXQZub64IDqLYlgk8NWFI69RroX1HpYK70GzYOHaGhiJmLLq5m6aJNsaUO8
	 DeaYZUFey2qaNRP3QgiNiI58Tfko8qE+SQN+jtKig/da4FP++e2La6vaDjjxN92c2Z
	 VlQxVYlEN97qhFuRqkVbZuogDP7KxjLLdQAZMb8aWMVxo1bboro+n6QFzliWn5eIsw
	 +6sZQr99DEp7X85nCvBoH2F8Q0IzPwZAqHbhvjqS2fWgXPNi54jOH7CNI6cNgqskuv
	 VmdW5JyZXK6+9/D/Azze/bCrFsIXHBt7qFEWw+50XPeY8tjfTJdudbtK7XReXx9z1s
	 0mcVUm5THWmvw==
Date: Wed, 8 Oct 2025 16:39:16 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <avdwdikvusufurrzfglpedp74vkdx7baqv7uruda5sazbirwv7@bmgipkeuvx4t>
References: <20251007125803.55797-1-johannes.thumshirn@wdc.com>
 <xM_yDtK6YNwdumZ0kyt-f2Yv1PkG5qOjcs6msZQgmlmKrCljdcZ9MExz2IdGrpMWMWoU-9mzrXgfofBA4pV9ng==@protonmail.internalid>
 <20251007125803.55797-4-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007125803.55797-4-johannes.thumshirn@wdc.com>

On Tue, Oct 07, 2025 at 02:58:03PM +0200, Johannes Thumshirn wrote:
> Add a basic smoke test for filesystems that support running on zoned
> block devices.
> 
> It creates a zloop device with 2 conventional and 62 sequential zones,
> mounts it and then runs fsx on it.
> 
> Currently this tests supports BTRFS, F2FS and XFS.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Looks fine:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> ---
>  tests/generic/772     | 50 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/772.out |  2 ++
>  2 files changed, 52 insertions(+)
>  create mode 100755 tests/generic/772
>  create mode 100644 tests/generic/772.out
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..403798ff
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,50 @@
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
> +	if test -b /dev/zloop$ID; then
> +		echo "remove id=$ID" > /dev/zloop-control
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
> +last_id=$(ls /dev/zloop* 2> /dev/null | grep -E "zloop[0-9]+" | wc -l)
> +ID=$((last_id + 1))
> +
> +mnt="$SCRATCH_MNT/mnt"
> +zloopdir="$SCRATCH_MNT/zloop"
> +
> +mkdir -p "$zloopdir/$ID"
> +mkdir -p $mnt
> +_create_zloop $ID $zloopdir 256 2
> +zloop="/dev/zloop$ID"
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

