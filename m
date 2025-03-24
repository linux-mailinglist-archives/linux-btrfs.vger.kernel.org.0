Return-Path: <linux-btrfs+bounces-12520-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665EEA6E5CB
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 22:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE193B351E
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Mar 2025 21:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F1F1DE896;
	Mon, 24 Mar 2025 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="2VgWxT7O"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C4318EB0
	for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852305; cv=none; b=T2eKnwnY72Yh2TcDJ8v1gq3UKf5sF9H999E3NscFM6KOXmRm1lmZVNNnoENtX200ZPiJWWiMIMIezY5koOsmsS676lFHhrxogmkYbTWeQ9vKa7YXhf8TAEmAy0ookiegLRhc1RebaHU+BBj+ZWEBYJlOQDsBae+9ZInNbhFBdFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852305; c=relaxed/simple;
	bh=e6+o7WJw5TOEzbrDuJYbMePrGMIO0NZQPacJerUpzQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWZ473zWbPtUSlIg03EudG2wTeS8W/Jo6explNZ5iPJJ4ln1sPanFqJ5Bkzx3XrUwHPNHuUpC8OBMJ6+FTllcNaarWauzCMkJCeiTFMhQbCWz1apETGAHFD2vQOfsrL8q6VkgCiuBUdc5A0MGAdfgjWC0j1/DQtu5bsUW1lEabg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=2VgWxT7O; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240b4de12bso22721245ad.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Mar 2025 14:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1742852303; x=1743457103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=So+22YhDM1kXmK3vjKe26la8c3db2c2zBGBpnn//tjQ=;
        b=2VgWxT7Opojfy/Yja1BYmwhnfShWhJbA16pkXL5fvu5WPG5viFx5Z4GR86OadmlmSt
         4d8XbhXod4lmgw+4X/UoSN9lk0eocgk+XJuRaxTBKhiYMyg8lRkabD0k4pA/aYhiHApw
         m36EGkGZpBXAWe3RXa8YbvkkmpJPjREQMdro/E8GxVuT+5Ikm+SrPb6aGFZKaoODJtJf
         qSIoVCywHevyfglbJ6/LeI04191e7nvkeK+woo+JpDqdgeNNF6mxOxrCB9l0SQ1ta5tU
         kl8ozpwAto0ztygH2BIlN62eOlUwizdlImAQnCdpkL/FqxUVF3fVUmlpuIADczk11Mbz
         zeUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852303; x=1743457103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=So+22YhDM1kXmK3vjKe26la8c3db2c2zBGBpnn//tjQ=;
        b=xQR1gL69iCbrFMtW5XecKRGbHhqo6PqxHZfVOdprUr889aAdKBuo8ZtQwvDM6CqFUW
         enwI4a621C0PmpJ3PwTRtSI7jrjxVf4Pubvk8BVx6SbR0sGEbpXtNYJvovxpOUtPGk7l
         jGDCcgS1mxn2nPR2+dEy+DvrIbW+1fJjPY+kSAQO/11IHCdmPT+8uBK/6KMPmV2BsQve
         YpV1I3vB25NIQXqPnsfPeK0NoyWGqj+BeWti5GGGvRuprccUt/gBA54+X/qUXCvvZX0v
         OCdH2eKO8zvWx+dY/Kz1KBEWzkvMuuEzOcUXzeatc08RQgj0MlPiJ536LF2sXtV39CMb
         z1lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvDDkZQ4X6I7twI4VjOfHJG5MbtNmySNs63kCqZzC4bQIi8ryf+bMumTU02jknyFsqtbYf2ZHrYQCW1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8iMbfgQc4mWpIBJZQod9WQflfhd8rZi4Rop//bo9jZbmgZnsx
	uoNaQn/uLY1PGon9FN+P779AcFKt5EMjc1bzSCWaBtlVKpyzRrMV5wOBucgnHZBOXCPPW3ySYc0
	t
X-Gm-Gg: ASbGncv9aYa6NPvxnOsjsqBRDCupESynSrjd7kmU3TM2iOd1rDO+8rq/XipePDzXEj4
	RE3CPeNqIZ/at3bR025aWrRqBoyP8L0OQExYNPpCjJd9NoDpHynqi7cePeDIAweC/pi9TfrJkjJ
	2weEg5+LPQmeI1WkRXjbZRbNN2bvbO+EK3yq+ifD0GvsS6PYlzlclFtgTEOYtVz+mc422ZgrHaP
	Zst2lYBhMzjSB2f03IZa5pRmW85UEsVWnaQyATdFrz3UxPOlp+n+mFn5lUikU/cBUaZGZWNsQFv
	QZPYp5hHrNuYtkxYlHaCu7hWSFXVHyjRnhY2GpR4SHHjRomZWYbgp8/LsVp+/362ukqPirN0OJS
	y8KlvBdPRug==
X-Google-Smtp-Source: AGHT+IGCX+fLHojZeOyrTf1lxQ0kKWVc5WI/q9cCJe7TEnPc4EtJkvieI+p3apb0hkNrtxp51zlbSg==
X-Received: by 2002:a05:6a00:928f:b0:736:2a73:6756 with SMTP id d2e1a72fcca58-73905a25194mr23726136b3a.21.1742852302550;
        Mon, 24 Mar 2025 14:38:22 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-36-239.pa.vic.optusnet.com.au. [49.186.36.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611cae4sm8826909b3a.101.2025.03.24.14.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:38:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1twpUw-0000000HRM5-1wRa;
	Tue, 25 Mar 2025 08:38:18 +1100
Date: Tue, 25 Mar 2025 08:38:18 +1100
From: Dave Chinner <david@fromorbit.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic: test fsync of file with no more hard links
Message-ID: <Z-HQypONiMW6tnYi@dread.disaster.area>
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

	if [ -n "$XFS_IO_PID" ]; then

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
> +wait $XFS_IO_PID
> +unset XFS_IO_PID

So this is effectively src/multi_open_unlink.c with an added fsync
after the unlink() call.

Wouldn't it be better to add a "-F" option to multi_open_unlink.c to
tell it to fsync after the unlink to src/multi_open_unlink.c, and
then the test becomes a lot simpler

> +# Simulate a power failure and then mount again the filesystem to replay the
> +# journal/log.
> +_flakey_drop_and_remount
> +
> +# We don't expect the file to exist anymore, since it was fsynced when it had no
> +# more hard links.
> +[ -f $SCRATCH_MNT/foo ] && echo "file foo still exists"

`ls $SCRATCH_MNT` and let the golden image match fail because
there's output when the file still exists. i.e. the ls command
should be silent if the test passes.

> +_unmount_flakey
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit

OK, so this seems to me that the test could be written as:

	src/multi_open_unlink -F -f $SCRATCH_MNT -s 0 -n 1
	_flakey_drop_and_remount

	ls $SCRATCH_MNT
	_unmount_flakey

	echo "Silence is golden"
	status=0
	exit

if we add a few lines of code to add fsync support to
src/multi_open_unlink.c...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

