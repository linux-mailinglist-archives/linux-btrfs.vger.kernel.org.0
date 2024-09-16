Return-Path: <linux-btrfs+bounces-8073-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C100497A8B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 23:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80EA528A791
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 21:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ECE158A09;
	Mon, 16 Sep 2024 21:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR7PVE2P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658A3F9DA;
	Mon, 16 Sep 2024 21:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726521703; cv=none; b=sLd6p6x3gGRk0aV8t+BV8940E9dD+Kz4wLaAoFfmbumuCT/yTBAakiPy1C6iQfqsxxVTcqeENcdTUnHNX+V5ABeRPTODpIhnYg4kqjxBWrDDIKDDFd2sP/i2UTCmkR1vKD8pQXll8HQXv0Z4ISn6Cz7GrX1cwhlC7pCcBJ4HDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726521703; c=relaxed/simple;
	bh=rcP4MakEqdLoYp8j1UwE3hEanBGid0pNyLyhOmyWSpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xr4dZvRnuj1yDY7Fd/VRFCBT5mS8Kz93Nw//VFVQllO8zA5iP+/plBUx1Y9fl21leUGgz6m4hNUqyNYkH9Ew3abKj9oxWRuQemVruAm8HxXmN9MQaD7/F2lHIM/vm41679c3obdk+3G5qyqFlLb3bb9r/T2sIYRfeiP9gg9wu18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR7PVE2P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C44C4CEC4;
	Mon, 16 Sep 2024 21:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726521702;
	bh=rcP4MakEqdLoYp8j1UwE3hEanBGid0pNyLyhOmyWSpU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HR7PVE2PKPiUHvNVQM2pn47aV1Dewqx72/dVFBC2vfsIJG0jTAA66ZtfeWGWrivut
	 bKcRF3BLtOyCHDTW/Xx9jjOk73u6pIVUuQ/iAVsACQ0XrpLLdjfQb1vXHC0GrbRgGN
	 tw/BNDJ9BbjY53x67elTe3it/sWw8eJbIzrvZ1NEIWFxclf+sz/4eY6zOuhkjzlEoH
	 vteyPWxQxMzmaYdf4oLjVfYM+Amv355+LJKxw0ft5P0eqJp0lU2DI558BC5wAIAXHf
	 mU0mdh8EUNCMrog0NUDso286pUt54+EOsqQuHkHofjmwRe6ePiZbnBXRLSrrMZekWM
	 e7m1ZJDw2zoSQ==
Date: Mon, 16 Sep 2024 14:21:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: add missing kernel git commit IDs to some tests
Message-ID: <20240916212142.GB182183@frogsfrogsfrogs>
References: <1fe1768c5148fc857ddbba244e607f965a17937b.1726140369.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fe1768c5148fc857ddbba244e607f965a17937b.1726140369.git.fdmanana@suse.com>

On Thu, Sep 12, 2024 at 12:26:38PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Three tests (btrfs/321, generic/364 and xfs/608) refer to kernel patches
> that are now in Linus' git kernel tree, so update the tests to include
> the commit IDs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/321   | 2 +-
>  tests/generic/364 | 2 +-
>  tests/xfs/608     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/btrfs/321 b/tests/btrfs/321
> index e30199da..93935530 100755
> --- a/tests/btrfs/321
> +++ b/tests/btrfs/321
> @@ -22,7 +22,7 @@ _require_btrfs_raid_type raid0
>  _require_btrfs_support_sectorsize 4096
>  _require_btrfs_command inspect-internal dump-tree
>  
> -_fixed_by_kernel_commit xxxxxxxxxxxx \
> +_fixed_by_kernel_commit 10d9d8c3512f \
>  	"btrfs: fix a use-after-free bug when hitting errors inside btrfs_submit_chunk()"
>  
>  # The bug itself has a race window, run this many times to ensure triggering.
> diff --git a/tests/generic/364 b/tests/generic/364
> index 34029597..968b4754 100755
> --- a/tests/generic/364
> +++ b/tests/generic/364
> @@ -18,7 +18,7 @@ _require_command "$TIMEOUT_PROG" timeout
>  
>  # Triggers very frequently with kernel config CONFIG_BTRFS_ASSERT=y.
>  [ $FSTYP == "btrfs" ] && \
> -	_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	_fixed_by_kernel_commit cd9253c23aed \
>  	"btrfs: fix race between direct IO write and fsync when using same fd"
>  
>  # On error the test program writes messages to stderr, causing a golden output
> diff --git a/tests/xfs/608 b/tests/xfs/608
> index a74c7bf3..7ac40137 100755
> --- a/tests/xfs/608
> +++ b/tests/xfs/608
> @@ -9,7 +9,7 @@
>  . ./common/preamble
>  _begin_fstest auto
>  
> -_fixed_by_kernel_commit XXXXXXXXXXXX \
> +_fixed_by_kernel_commit e21fea4ac3cf \
>  	"xfs: fix di_onlink checking for V1/V2 inodes",

Yep, thank you...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  _require_scratch_nocheck	# we'll do our own checking
> -- 
> 2.43.0
> 
> 

