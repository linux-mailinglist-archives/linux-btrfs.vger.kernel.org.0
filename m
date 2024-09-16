Return-Path: <linux-btrfs+bounces-8074-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4596F97A8BA
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 23:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6874B23AF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Sep 2024 21:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085814B07E;
	Mon, 16 Sep 2024 21:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c835jvYj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A152E17753;
	Mon, 16 Sep 2024 21:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726522085; cv=none; b=EbjJMQaxuf6se4Aek90ykDPMfWT2im7SHqMGsbaljLW3jTcfPfQdN30K7cnDa2/ddMluGLdHCuVdTM4ZtlNhQgE9IBGkjZimkNVfwD7ioWb6p7A3rjlNDdN57wP2dxp8Q6+bF3+yZIFRzuyygpikF9qW1KPRmYD80IoAKLxHHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726522085; c=relaxed/simple;
	bh=nH1mM8UwCxqcduN+A4cv92JuTN+2paqVqXUjV6xX1KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hJbDnmTDYsj3deuwnJxKe1UN09RgyihxMk/WOOfrGWlfgfwXNcejcXGUG3uVJ2dUALZVZ/OU5a2E2foOx2BmXAZ08nyWLQUjLOKxYBqrOmg3ZMcIoFsG4kMMbYY3dYDDr5+ppRmOX/pNqcifdp953zG3KLjSyxdYuM0jbpOlVEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c835jvYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B26C4CEC4;
	Mon, 16 Sep 2024 21:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726522085;
	bh=nH1mM8UwCxqcduN+A4cv92JuTN+2paqVqXUjV6xX1KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c835jvYjb8LxLjG7QYNavvVeiSNXePN76UAxblbNFbVfN1545X0+12uiuFBXdeTxL
	 0vxBqFAsLE99RxbKBXZZxOMDPGq+rlaI7U3jHq9+5CQVMh1z6vSh0icZ3awYteYh0T
	 AP4N5imXtz7IPR6mmaeacpKeLdJezAfgQb1ld3YSA8970pkAI1INE3RH1OXHWR2Dcx
	 uGgnQYDB1qnzWLV/fyihkCElm9Sa183qhjpmfAg0Wb4d++kLCBc6UP2Q0NP7r5m8+2
	 2w6xMipCbiAFDBw6oxXSIpvLcF/LH8KAJZ8LAOKwSCX2+g08OFS3uOBosFYW3KPnjZ
	 1ATg9wtaPxaPA==
Date: Mon, 16 Sep 2024 14:28:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: fix min_dio_alignment logic for getting device
 block size
Message-ID: <20240916212804.GC182183@frogsfrogsfrogs>
References: <0d6ec0b588b578b9f9aabef91b8ecdf9950b682a.1726488132.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d6ec0b588b578b9f9aabef91b8ecdf9950b682a.1726488132.git.fdmanana@suse.com>

On Mon, Sep 16, 2024 at 01:03:12PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we failed to get the dio alignment from statx we try to get the
> device's block size using the BLKSSZGET ioctl, however we failed to
> return it because we don't check if the ioctl succeeded (returned 0).
> Furthermore in case the ioctl returned an error, we end up returning an
> undefined value since the 'logical_block_size' variable ends up not
> being initialized.
> 
> This was causing some tests to be skipped on btrfs after commit
> ee799a0cf1d4 ("replace _min_dio_alignment with calls to
> src/min_dio_alignment"), like generic/240 for example:
> 
>   $ ./check generic/240
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian0 6.11.0-rc7-btrfs-next-174+ #1 SMP PREEMPT_DYNAMIC Tue Sep 10 17:11:38 WEST 2024
>   MKFS_OPTIONS  -- /dev/sdc
>   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>   generic/240 1s ... [not run] fs block size must be larger than the device block size.  fs block size: 4096, device block size: 4096
>   Ran: generic/240
>   Not run: generic/240
>   Passed all 1 tests
> 
> Where before that commit the test ran.
> 
> Fix this by checking that the ioctl succeeded.
> 
> Fixes: 0e5f196d0a6a ("add a new min_dio_alignment helper")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Looks good, sorry for missing that during review.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  src/min_dio_alignment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> index 131f6023..5a7c7d9f 100644
> --- a/src/min_dio_alignment.c
> +++ b/src/min_dio_alignment.c
> @@ -42,7 +42,7 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
>  		if (dev_fd > 0 &&
>  		    fstat(dev_fd, &st) == 0 &&
>  		    S_ISBLK(st.st_mode) &&
> -		    ioctl(dev_fd, BLKSSZGET, &logical_block_size)) {
> +		    ioctl(dev_fd, BLKSSZGET, &logical_block_size) == 0) {
>  			return logical_block_size;
>  		}
>  	}
> -- 
> 2.43.0
> 
> 

