Return-Path: <linux-btrfs+bounces-17895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6E5BE459D
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 17:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C5CC2508F71
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C49720E011;
	Thu, 16 Oct 2025 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a62bj/ed"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB6314D28;
	Thu, 16 Oct 2025 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629749; cv=none; b=RtRzl5Q9PnCKwzrs7yUETm+r4RdfCdbz/si5PDR1ENvy8qCJR7PZ6VWSCjMsxQbcbY+zEWkPP0P0s1pWxC0bL2UyOF+fhc50QthuMAOR0Wgogmv4w6aAtf5oITk7Ks7pNq5YRt2vfcexmTanRY/HzHl6Lo25Vy0S8TgsvDJatn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629749; c=relaxed/simple;
	bh=1bvw7hnpbf4RMSD/SNP3eMZk7kGGZ6Y71M6cC8PDX8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j03mPqrgWXbNRyWTqf3pB3sFz9v0cpJyBqHNzvEUk2BVnYoh+ahGklS4GchvJHWPs1MlU1qUeXmTKLbURxT4tIDI/4tVwQP36oJEPgLCQfo6GzqSObTfYQbr8CxSrKHk0/pI7PEUkhqXlLQL9YBVC5vZOUDNO45KeKR06XxJKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a62bj/ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDBCC4CEF1;
	Thu, 16 Oct 2025 15:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629749;
	bh=1bvw7hnpbf4RMSD/SNP3eMZk7kGGZ6Y71M6cC8PDX8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a62bj/edGwOdZArmayZBan1mXEETu8nLI7krp6LXzj5rnesftccBfrgRMM4kEITCV
	 eU3XQHbRpXYOGAEtBUpFm0uTxEyaezC2P0Rl9rhlb4hgGeJoBy5dCJdwg5EGoptGfZ
	 TAt+sTaKLHV+ByPijCUpmDfOyLAqYzyeAfU1F4tLJQdojfKTyONt90xg1iVANtVko5
	 0d+bSEbqs9qe9A8rZxZ7z9W0OLN08HGjfF3Z7GKfVSO8M1EzzNxx0cBQOaYoty7dkC
	 7XfQKOu5qqWxliYwslNmr20P8Ur+3puDxyqiF4mXeY0bcefckNaKH0tfv3s2AvlcIw
	 4QKkY18vFAqgw==
Date: Thu, 16 Oct 2025 08:49:08 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, Carlos Maiolino <cem@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251016154908.GO2591640@frogsfrogsfrogs>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016152032.654284-4-johannes.thumshirn@wdc.com>

On Thu, Oct 16, 2025 at 05:20:32PM +0200, Johannes Thumshirn wrote:
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

Looks good to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/772     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/772.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/generic/772
>  create mode 100644 tests/generic/772.out
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..10d2556b
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 772
> +#
> +# Smoke test for FSes with ZBD support on zloop
> +#
> +. ./common/preamble
> +. ./common/zoned
> +
> +_begin_fstest auto zone quick
> +
> +_cleanup()
> +{
> +	_destroy_zloop $zloop
> +}
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
> +_try_mkfs_dev $zloop >> $seqres.full 2>&1 ||\
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

