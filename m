Return-Path: <linux-btrfs+bounces-17481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B4BBF00F
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 20:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3198F3AC10F
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F792D7DFF;
	Mon,  6 Oct 2025 18:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GJMVIv09"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2F1DF982;
	Mon,  6 Oct 2025 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776041; cv=none; b=TfnH1vw10SNPSJMIyPOwsoXBdu3ef9VfKZn3jAQvWIoSm2YfOUrZorgHC7w/2KjuYLesCkkb9aXiS8aVYXTPGbYYZ377HI73cTHmVb/0KfhB+gXp1A+AGgR0KrPacn0wL5H5s2yv/xzV2I6bShjvyWSGern6f6MFF4SkyoW8PSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776041; c=relaxed/simple;
	bh=H3FQVBXLKCOvyv9tk5fTh1h6+uLOiYruYKy2MwZwOsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7kMBRX77QVyZG/RgMi+t8F53zI5qg8jLNfw2tFAzZ/soZGPJsLT8FLDqh/hUaIGy1KIcth0y7hBDIw2R/H2A86umObMeHHyirdh5s3o6/RJVmoqNZ82clFwuVzvQUEw6MYqxuzUqYA3qvRcA0Z1677P6PjqkQ6ZF6/gnm7is7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GJMVIv09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43880C4CEF5;
	Mon,  6 Oct 2025 18:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759776041;
	bh=H3FQVBXLKCOvyv9tk5fTh1h6+uLOiYruYKy2MwZwOsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GJMVIv09JfxCqrPpUiZuTxd82BCC6U41D8WMfgp7iEkcmMnlUgBWGXiC6y87vN4xh
	 6jo8RErJmNtX2rL9rhmlKd/OM9W42obHIMVfq2cUrr2G1+A8buY+27qWQ4AHBToA4t
	 0zoeJqmjzvDwoupezn0QOrY2evGPpOh9ZOLcwwc2SfVYcJiQP87GCtaNJUsU8caAJd
	 rQIv4I/xvjo7XJqjZKblB11IVRxeUGspyfSLcrCezXLNAKXYtaIQrPkv5CQN6tX1EP
	 UPqx9oNUNuNnIi1KAGFNKIpaEF91MdiuvZPhi+RMwmA3yNnowXFY0afdgIPVHe8sFL
	 AC8I9y/hhxafA==
Date: Mon, 6 Oct 2025 20:40:36 +0200
From: Carlos Maiolino <cem@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>, 
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org, 
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic: basic smoke for filesystems on zoned block
 devices
Message-ID: <iqwkuhobfvpeiktvk6pba6ahirgzngltj3ilrifcfgaugme67s@r54pl6d6foys>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
 <OtglCyTJgl3RCnletH8ai3IsE0wk2nR5CISvt5ZfvYPj85MMxGBFHEw9UmPSHvpve5QOIFQCXD9LFB1DpsNuAQ==@protonmail.internalid>
 <20251006132455.140149-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006132455.140149-3-johannes.thumshirn@wdc.com>

On Mon, Oct 06, 2025 at 03:24:55PM +0200, Johannes Thumshirn wrote:
> Add a basic smoke test for filesystems that support running on zoned
> block devices.
> 
> It creates a zloop device with 2 sequential and 62 sequential zones,

This seems wrong? Don't you mean 2 conventional zones?
Also, won't the arguments used to create the zone dev end up creating 64
sequential zones? I might be very wrong here, so my apologies in advance
but looking into the zloop code this seems that 256MiB zone size will end
up creating 64 sequential zones instead of 62?

Carlos

> mounts it and then runs fsx on it.
> 
> Currently this tests supports BTRFS, F2FS and XFS.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/generic/772     | 52 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/772.out |  2 ++
>  2 files changed, 54 insertions(+)
>  create mode 100755 tests/generic/772
>  create mode 100644 tests/generic/772.out
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..412fd024
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,52 @@
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
> +zloop_args="add id=$ID,zone_size_mb=256,conv_zones=2,base_dir=$zloopdir"
> +
> +mkdir -p "$zloopdir/$ID"
> +mkdir -p $mnt
> +echo "$zloop_args" > /dev/zloop-control
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
> 

