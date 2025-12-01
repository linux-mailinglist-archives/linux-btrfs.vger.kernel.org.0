Return-Path: <linux-btrfs+bounces-19440-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD733C997FD
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 00:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEDA0341AB0
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Dec 2025 23:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB0F29B78F;
	Mon,  1 Dec 2025 23:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSENFj3J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE5029B229;
	Mon,  1 Dec 2025 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630006; cv=none; b=X8eCWDmxTawi9msJDhLpNsP7nPxmD0ElgiE9+hMtXgp7MePrE8qcIDEfCum5YahWFXBymPUg6064IkHmP0pktPBgo2Ppybs+/wj052y4n1RDcyvIWGVkFtIqZ84iEYWZe36ukdpKqqJebgavnc1oSOtsqoVpsCDpNfJmNEhHYa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630006; c=relaxed/simple;
	bh=h47WILLrM08Pio2L2ksfkANUADViuwdJYXc2TEJ1YiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gU1jKZTGoOXCXNxFo5x5Mpl3PI8oBQUbW6VHg5TUE7YWswWOb5xpFzaefgvq1NxFnLe1X1WgZgpApM269gymELVBkb+qmMT+xCvdR1olwzr8ps0Bj2ybNs1wdW2qVZRCDBhN+4hdhE083Rle24M5NZiT3dqwM/WCcAjwkudhG7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSENFj3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7EDC4CEF1;
	Mon,  1 Dec 2025 23:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764630005;
	bh=h47WILLrM08Pio2L2ksfkANUADViuwdJYXc2TEJ1YiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSENFj3JLG5IFoo3PjFU7C9s2YeqQX3nHtGX5IyBMPUBcDjr7b8NixWI6G5UxTaBG
	 t7NyPIQBgVdyrXBDKgxF3M+Y/6CbWPqiAgiiBSYlukDEHe0kF4rOBkZxp0kYgzx590
	 Faxih4gaskXd+dZRyhY+DzaAKocwXdhZgxxIoin/dwxIYwZxtjTTC8a9U3m/Tne3b1
	 Kv+fCMZDrWhzav5AeSU3lCO2O7rzQve9ALRZPK+lX/chJUBtQxWY6ouQ3qAjsg2ZGK
	 SwyztQq6Ml1zW0Hh+Twp3HDGGDD/J1nHSiCjMMlA6BSkmKZXOYqTlEhFvjDjE5WqN6
	 9NPmYbDxcbRkA==
Date: Mon, 1 Dec 2025 15:00:04 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test a scenario of power failure after renames
 and fsyncs
Message-ID: <20251201230004.GB89454@frogsfrogsfrogs>
References: <5923d73eeeaf2b5d2e179c9be9cf3303149dc3f8.1764264859.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5923d73eeeaf2b5d2e179c9be9cf3303149dc3f8.1764264859.git.fdmanana@suse.com>

On Thu, Nov 27, 2025 at 06:17:44PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test moving a directory to another location, create a file in the old
> location of the directory and with the same name, fsync the file, then
> move the file elsewhere and fsync again the file. After a power failure
> we expect to be able to mount the fs and have the same content as before
> the power failure.
> 
> This exercises a bug fixed by the following kernel patch for btrfs:
> 
>  "btrfs: don't log conflicting inode if it's a dir moved in the current transaction"
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Seems reasonable to me.
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  tests/generic/784     | 76 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/784.out | 19 +++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100755 tests/generic/784
>  create mode 100644 tests/generic/784.out
> 
> diff --git a/tests/generic/784 b/tests/generic/784
> new file mode 100755
> index 00000000..8e01dff0
> --- /dev/null
> +++ b/tests/generic/784
> @@ -0,0 +1,76 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 SUSE S.A.  All Rights Reserved.
> +#
> +# FS QA Test 784
> +#
> +# Test moving a directory to another location, create a file in the old location
> +# of the directory and with the same name, fsync the file, then move the file
> +# elsewhere and fsync again the file. After a power failure we expect to be able
> +# to mount the fs and have the same content as before the power failure.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick log
> +
> +_cleanup()
> +{
> +	_cleanup_flakey
> +	cd /
> +	rm -r -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/dmflakey
> +
> +_require_scratch
> +_require_dm_target flakey
> +
> +[ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"btrfs: don't log conflicting inode if it's a dir moved in the current transaction"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_require_metadata_journaling $SCRATCH_DEV
> +_init_flakey
> +_mount_flakey
> +
> +list_fs_contents()
> +{
> +	# Remove the 'lost+found' directory which only exists in some
> +	# filesystems like extN and remove empty lines to have a consistent
> +	# output regardless of the existence of the 'lost+found' directory.
> +	ls -1R $SCRATCH_MNT/ | grep -v 'lost+found' | grep -v -e '^$' | \
> +		_filter_scratch
> +}
> +
> +mkdir $SCRATCH_MNT/dir1
> +mkdir $SCRATCH_MNT/dir2
> +
> +_scratch_sync
> +
> +mv $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2
> +
> +# Create a file with the old name of the first directory and persist it with
> +# a fsync.
> +$XFS_IO_PROG -f -c "fsync" $SCRATCH_MNT/dir1
> +
> +# Move the file to some other location.
> +mv $SCRATCH_MNT/dir1 $SCRATCH_MNT/dir2/foo
> +
> +# Fsync again the file.
> +$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/dir2/foo
> +
> +echo -e "\nfs contents before power failure:\n"
> +list_fs_contents
> +
> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log. We expect the mount to succeed.
> +_flakey_drop_and_remount
> +
> +# We expect the fs contents to be the same as before the power failure.
> +echo -e "\nfs contents after power failure:\n"
> +list_fs_contents
> +
> +_unmount_flakey
> +
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/784.out b/tests/generic/784.out
> new file mode 100644
> index 00000000..87942d04
> --- /dev/null
> +++ b/tests/generic/784.out
> @@ -0,0 +1,19 @@
> +QA output created by 784
> +
> +fs contents before power failure:
> +
> +SCRATCH_MNT/:
> +dir2
> +SCRATCH_MNT/dir2:
> +dir1
> +foo
> +SCRATCH_MNT/dir2/dir1:
> +
> +fs contents after power failure:
> +
> +SCRATCH_MNT/:
> +dir2
> +SCRATCH_MNT/dir2:
> +dir1
> +foo
> +SCRATCH_MNT/dir2/dir1:
> -- 
> 2.47.2
> 
> 

