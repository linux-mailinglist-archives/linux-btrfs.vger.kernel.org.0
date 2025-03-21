Return-Path: <linux-btrfs+bounces-12489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DD0A6BE6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 16:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77330465A1B
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Mar 2025 15:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF57A1E00B4;
	Fri, 21 Mar 2025 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCJrWcDz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AE82AE84;
	Fri, 21 Mar 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742571611; cv=none; b=WtFTw+n861wfZtw/Y42yVBv7cer645it02dOPaaWniXousbcpmjhvuf4p0v1jXnDx3J0/ccaxrUCpy2C1OnXYtd27lwTgLCeze41tdMQ+ekUi4m6ZXuDGA43aB8PqqTfAjPWhuiRLcYnq+kLEdjGjWSkMBKILudQMKhB4H7Q3S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742571611; c=relaxed/simple;
	bh=Ro2a9ja0TwBp/Wt/y/Mom69Yv8pR3PPk1fakmQAgG9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbWStg/vLO7fDLzG7137fvkRYYGjp82esVQibXUtx1WKvDBePzqeUA/DOiRSxy5IZMKDfh3oOaIytEKaxgi7NJr91qtHlS4q6Hml/p4Bf+Aay7Ge7PVf7kuXubEFhbmC/scXEr4IXlJUFYMsLvZwi3hC1PlbZRMcEwrPV0DIaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCJrWcDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8952EC4CEE3;
	Fri, 21 Mar 2025 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742571610;
	bh=Ro2a9ja0TwBp/Wt/y/Mom69Yv8pR3PPk1fakmQAgG9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mCJrWcDzN1kw5/rC4wQd7gZlTOvwI/2NYgYrDc1nyqhGu1WQwO29tDOOGHgxejEJN
	 bYNMtnmZ8loIZoTmTzMpASk7oEf0pXEkuZ3qZpfvbyi93gE+POg65SAc/qfee8Hmjq
	 GhnxiwmpgwJPHDM5ApgP03dqGWvhL8FGf1p3zHti/onbxMMyR0EsfeyGS0rw+En8hT
	 7vVFn0KIntP6jw24URi1mWSe2h3aYG5zZbvkFr6ObWqs7endCXPCDSatxW40c/meVv
	 t7PPz+7nsxfvzjN56GZ050BMTTFG/UC8+VPK/23MMWbwZ609JTFWHWcAP03wMfbmIU
	 k+mV0H2QsT7gw==
Date: Fri, 21 Mar 2025 08:40:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test fsync of file with no more hard links
Message-ID: <20250321154010.GE4001511@frogsfrogsfrogs>
References: <3476019b76d6df3ce6eb364aeb1a2725b8fb4846.1742555101.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3476019b76d6df3ce6eb364aeb1a2725b8fb4846.1742555101.git.fdmanana@suse.com>

On Fri, Mar 21, 2025 at 11:09:58AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that if we fsync a file that has no more hard links, power fail and
> then mount the filesystem, after the journal/log is replayed, the file
> doesn't exists anymore.
> 
> This exercises a bug recently found and fixed by the following patch for
> the linux kernel:
> 
>    btrfs: fix fsync of files with no hard links not persisting deletion
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/generic/764     | 78 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/764.out |  2 ++
>  2 files changed, 80 insertions(+)
>  create mode 100755 tests/generic/764
>  create mode 100644 tests/generic/764.out
> 
> diff --git a/tests/generic/764 b/tests/generic/764
> new file mode 100755
> index 00000000..57d21095
> --- /dev/null
> +++ b/tests/generic/764
> @@ -0,0 +1,78 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE Linux Products GmbH.  All Rights Reserved.
> +#
> +# FS QA Test 764
> +#
> +# Test that if we fsync a file that has no more hard links, power fail and then
> +# mount the filesystem, after the journal/log is replayed, the file doesn't
> +# exists anymore.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	if [ ! -z $XFS_IO_PID ]; then
> +		kill $XFS_IO_PID > /dev/null 2>&1
> +		wait $XFS_IO_PID > /dev/null 2>&1
> +	fi
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/dmflakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: fix fsync of files with no hard links not persisting deletion"
> +
> +_require_scratch
> +_require_dm_target flakey
> +_require_mknod
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +touch $SCRATCH_MNT/foo
> +
> +# Commit the current transaction and persist the file.
> +_scratch_sync
> +
> +# A fifo to communicate with a background xfs_io process that will fsync the
> +# file after we deleted its hard link while it's open by xfs_io.
> +mkfifo $SCRATCH_MNT/fifo
> +
> +tail -f $SCRATCH_MNT/fifo | $XFS_IO_PROG $SCRATCH_MNT/foo >>$seqres.full &
> +XFS_IO_PID=$!
> +
> +# Give some time for the xfs_io process to open a file descriptor for the file.
> +sleep 1
> +
> +# Now while the file is open by the xfs_io process, delete its only hard link.
> +rm -f $SCRATCH_MNT/foo
> +
> +# Now that it has no more hard links, make the xfs_io process fsync it.
> +echo "fsync" > $SCRATCH_MNT/fifo
> +
> +# Terminate the xfs_io process so that we can unmount.
> +echo "quit" > $SCRATCH_MNT/fifo

Hee hee, what a way to drive xfs_io ;)

Seems reasonable to me
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> +wait $XFS_IO_PID
> +unset XFS_IO_PID
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# We don't expect the file to exist anymore, since it was fsynced when it had no
> +# more hard links.
> +[ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"
> +
> +_unmount_flakey
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/764.out b/tests/generic/764.out
> new file mode 100644
> index 00000000..bb58e5b8
> --- /dev/null
> +++ b/tests/generic/764.out
> @@ -0,0 +1,2 @@
> +QA output created by 764
> +Silence is golden
> -- 
> 2.45.2
> 
> 

