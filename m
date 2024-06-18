Return-Path: <linux-btrfs+bounces-5775-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AE390C09C
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 02:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8914CB23580
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2024 00:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34BBE28DC3;
	Tue, 18 Jun 2024 00:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7bu8uEx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795322EF4;
	Tue, 18 Jun 2024 00:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671155; cv=none; b=BjO4KI/HDZSVE8QTm+cVySkeAeXEYOfo3kk3NPstqbZ1z4k/oQZOWxsDjVhrQfSBuGsa19tU3vXUCKaGJhiL0rAbreMqoeEtuxdC6Dc930hoDnt/h7m/8I1uJEa02z+AAcb/rVQt7Xq+rBw+V+pl1jyIA9dQ+0RjlwZVFNoUC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671155; c=relaxed/simple;
	bh=tla7hD2q3QkjVFoo1z5dsVV7obX+8eTVEfRWgmMaRck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXXyBg6QujW936rVq7Nb+/PFICrDO+Z+MsP4fTmsBxiLL1jeVMUSAexltIYXdLag+LFWCXEYTtt139OIDHsON0v9J4rw4WwUVKG0qwhsKFx/a0t9ti0O+mBoFp5+RodAQAFxp9Bgbtr7YRynDXpLWo/3X9T9ldhSZKSuuA0e+GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7bu8uEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FBCC2BD10;
	Tue, 18 Jun 2024 00:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718671154;
	bh=tla7hD2q3QkjVFoo1z5dsVV7obX+8eTVEfRWgmMaRck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7bu8uExGbL99sJabceZF5ZJZnwZGB8hp0G7EtrYMdO5eoI687ltDtaQ38Xnn1St+
	 xhjF5CfEcbuYuBg2rb/BLYdR04BFi984albm+AS7L6VFQZ1gZZguE3hFbR6scKcTuV
	 7CSXrvO+YufNbmX4efPhZG8d1mDa+cTn7j4V/qCD4XcGOzRN+Km2E36LF4alnFK+Ws
	 3dAPF/r8L82WQ2GEckfRcH1XjlgHQp6yQFJcA6xH2L0z/I4p6dHu3uEeBAz8fJuxE8
	 QopM97ffd+nX7dCxtTF0IKKezJOVrDcnOBcW77flJL/gYrq4igTf5YO8E8BqBxoTwD
	 6Hm74QHhTIK5Q==
Date: Mon, 17 Jun 2024 17:39:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/74[3,8]: add git commit ID for the fixes
Message-ID: <20240618003914.GA103020@frogsfrogsfrogs>
References: <85c32250ac781bf925d1f26b0c6933dace05b3d1.1718643112.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85c32250ac781bf925d1f26b0c6933dace05b3d1.1718643112.git.fdmanana@suse.com>

On Mon, Jun 17, 2024 at 05:52:14PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The corresponding fixes landed in kernels 6.10-rc1 and 6.10-rc3, so update
> the tests to point the commit IDs.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Thanks for for the update!

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  tests/generic/743 | 2 +-
>  tests/generic/748 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/743 b/tests/generic/743
> index ad37d32f..769ce706 100755
> --- a/tests/generic/743
> +++ b/tests/generic/743
> @@ -23,7 +23,7 @@ _cleanup()
>  # Import common functions.
>  . ./common/dmerror
>  
> -_fixed_by_kernel_commit XXXXXXXXXXXX \
> +_fixed_by_kernel_commit 631426ba1d45 \
>  	"mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly"
>  
>  # real QA test starts here
> diff --git a/tests/generic/748 b/tests/generic/748
> index 71b74166..428d4a33 100755
> --- a/tests/generic/748
> +++ b/tests/generic/748
> @@ -17,7 +17,7 @@ _require_scratch
>  _require_attrs
>  _require_odirect
>  _require_xfs_io_command falloc -k
> -[ "$FSTYP" = btrfs ] && _fixed_by_kernel_commit XXXXXXXXXXXX \
> +[ "$FSTYP" = btrfs ] && _fixed_by_kernel_commit 9d274c19a71b \
>  	"btrfs: fix crash on racing fsync and size-extending write into prealloc"
>  
>  # -i slows down xfs_io startup and makes the race much less reliable.
> -- 
> 2.43.0
> 
> 

