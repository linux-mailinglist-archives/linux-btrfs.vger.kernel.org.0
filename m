Return-Path: <linux-btrfs+bounces-9195-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF79B3D65
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 23:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9FB1C214A9
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Oct 2024 22:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B7D2040B2;
	Mon, 28 Oct 2024 21:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcTqyxNf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B401F426C;
	Mon, 28 Oct 2024 21:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152649; cv=none; b=WnbsEsPmk2Ex8xELqPGWTGOVwFH6UrCno5rwro83CnNc8sQ2Fgf0TAtr+6zqX8XpqdRCteacrkCmUJQgZuXABN3Ux3Dv8DUpcQ3lAH4W7RwP2MD7nGVQnQAnQnqrgY7RyRrY3HQQeuPeaQRxqi4KxY43QFLuG6zSo+oPP7d0eEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152649; c=relaxed/simple;
	bh=TBD1r8Uk8qu6hVwMQhmmgmkUQKviNRWxIVbEBzKjiqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0puuhA/3uEJQ5RfMOtt1HAheWSNrgyeVUOgGTBYGJcdrBtr/4dH6hRaRlABXYQwQcMtrA9vxWB1Sb7zVS7TAt7QLsNxXhJQROA4/XSLZ51uWi6Q5dfJ94uuD9hOzzyRXS/3O3N9i6UyzFcS898yHjQ8Egva6XyW9RKlda1LHao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcTqyxNf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E44F7C4CEC3;
	Mon, 28 Oct 2024 21:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730152649;
	bh=TBD1r8Uk8qu6hVwMQhmmgmkUQKviNRWxIVbEBzKjiqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fcTqyxNf9uyl1X13uiMVFRw4l77oiXyCibQt921AFXsoq0Ny9TkT6LCFKP1e8cTq1
	 xukfiLIJgKFpuJjbwspLnxPzKlvf5Z2sP2DUob4XIOGMumeaiyTIektqr7IaMDupDW
	 /k+5BIQsFYwbyq6D5dTNlKBk5gXEEwRBTbtbsdm/gG+ZKrcUFHQfQiOD/eygV6qdZ5
	 Szg7fT9eiD60WbkKrCFrFHIZHDBV9V8FW1CL/wBOTx5MD6xjMscZR4SQf48blc8qXL
	 KXyhVE59GoOCXiWjqo72uPCztNCXxiFZ7mNyX/WR2yyAubQp0CXaaDDyWMXBIlkRq1
	 xm3oKG1tIzozQ==
Date: Mon, 28 Oct 2024 14:57:28 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Mark Harmstone <maharmstone@fb.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] generic: add test for missing btrfs csums in log when
 doing async on subpage vol
Message-ID: <20241028215728.GU21840@frogsfrogsfrogs>
References: <20241015153957.2099812-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015153957.2099812-1-maharmstone@fb.com>

On Tue, Oct 15, 2024 at 04:39:34PM +0100, Mark Harmstone wrote:
> Adds a test for a bug we encountered on Linux 6.4 on aarch64, where a
> race could mean that csums weren't getting written to the log tree,
> leading to corruption when it was replayed.
> 
> The patches to detect log this tree corruption are in btrfs-progs 6.11.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
> This is a genericized version of the test I originally proposed as
> btrfs/333.
> 
>  tests/generic/757     | 71 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/757.out |  2 ++
>  2 files changed, 73 insertions(+)
>  create mode 100755 tests/generic/757
>  create mode 100644 tests/generic/757.out
> 
> diff --git a/tests/generic/757 b/tests/generic/757
> new file mode 100755
> index 00000000..6ad3d01e
> --- /dev/null
> +++ b/tests/generic/757
> @@ -0,0 +1,71 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# FS QA Test 757
> +#
> +# Test async dio with fsync to test a btrfs bug where a race meant that csums
> +# weren't getting written to the log tree, causing corruptions on remount.
> +# This can be seen on subpage FSes on Linux 6.4.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick metadata log recoveryloop
> +
> +_fixed_by_kernel_commit e917ff56c8e7 \
> +	"btrfs: determine synchronous writers from bio or writeback control"
> +
> +fio_config=$tmp.fio
> +
> +. ./common/dmlogwrites
> +
> +_require_scratch
> +_require_log_writes
> +
> +cat >$fio_config <<EOF
> +[global]
> +iodepth=128
> +direct=1
> +ioengine=libaio
> +rw=randwrite
> +runtime=1s
> +[job0]
> +rw=randwrite
> +filename=$SCRATCH_MNT/file
> +size=1g
> +fdatasync=1
> +EOF
> +
> +_require_fio $fio_config
> +
> +cat $fio_config >> $seqres.full
> +
> +_log_writes_init $SCRATCH_DEV
> +_log_writes_mkfs >> $seqres.full 2>&1
> +_log_writes_mark mkfs
> +
> +_log_writes_mount
> +
> +$FIO_PROG $fio_config > /dev/null 2>&1
> +_log_writes_unmount
> +
> +_log_writes_remove
> +
> +prev=$(_log_writes_mark_to_entry_number mkfs)
> +[ -z "$prev" ] && _fail "failed to locate entry mark 'mkfs'"
> +cur=$(_log_writes_find_next_fua $prev)
> +[ -z "$cur" ] && _fail "failed to locate next FUA write"
> +
> +while [ ! -z "$cur" ]; do
> +	_log_writes_replay_log_range $cur $SCRATCH_DEV >> $seqres.full
> +
> +	_check_scratch_fs

This test fails on xfs because (afaict) replaying the log to $cur
results in $SCRATCH_DEV being a filesystem with a dirty log; and
xfs_repair fails when it is given a filesystem with a dirty log.

I then fixed the test to mount and unmount the filesystem to recovery
the dirty log before invoking xfs_repair:

	# xfs_repair won't run if the log is dirty
	if [ $FSTYP = "xfs" ]; then
		_scratch_mount
		_scratch_unmount
	fi
	_check_scratch_fs

But now the test takes a very long time to run because (on my system
anyway) the fio run can initiate 17,000 FUAs, which means that this loop
runs that many times.  100 iterations takes about 45 seconds, which is
about two hours.

Is it necessary to iterate the loop that many times to reproduce
whatever issue btrfs had?

--D

> +
> +	prev=$cur
> +	cur=$(_log_writes_find_next_fua $(($cur + 1)))
> +	[ -z "$cur" ] && break
> +done
> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/757.out b/tests/generic/757.out
> new file mode 100644
> index 00000000..dfbc8094
> --- /dev/null
> +++ b/tests/generic/757.out
> @@ -0,0 +1,2 @@
> +QA output created by 757
> +Silence is golden
> -- 
> 2.44.2
> 
> 

