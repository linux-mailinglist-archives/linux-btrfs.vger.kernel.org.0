Return-Path: <linux-btrfs+bounces-601-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E9D80492C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 06:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37CC7B20C3B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Dec 2023 05:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFD0D264;
	Tue,  5 Dec 2023 05:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPYgwQc0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111C6AC0;
	Tue,  5 Dec 2023 05:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B3A1C433C7;
	Tue,  5 Dec 2023 05:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701752873;
	bh=tiXz8P4yMZ71fXXtFvWwJ/oGgcVNWocffVheQb2zjM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPYgwQc0qjPp8P/mBCDAX19LFz0/yoLu4qQX+/DGEwgx9JAvee5+zt+0gW7usY9xv
	 1P8poTh8EfMYwdxEIbk3OAylk4J3BzP74zQdF+rdCVteBR66Rv0bH3Kmp45vcBecaK
	 hx0776Rm5zb1F55dZsSWDzQDaXyN1EZq/BlGaLmJ05Q0cMU31xWi4aLwNq9FMGmhU/
	 xlhKu0Sj3H7SlE0EFSnHUBGQnQEpF0pD314Nu1djIqgzBkSgkJpFZX4c8h1VolI3cN
	 GuUNp4yJFH+cfMcIQ2+Asrs5ebRJrwGTYXy48ZNDqKPm+vszBp6kq962V8DMkGq8TU
	 B0BMV69VPz8RA==
Date: Mon, 4 Dec 2023 21:07:51 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Subject: Re: [PATCH v4 10/46] btrfs: disable verity on encrypted inodes
Message-ID: <20231205050751.GI1168@sol.localdomain>
References: <cover.1701468305.git.josef@toxicpanda.com>
 <9fbfdc5ea7ad2059ff0560ddf079bd1daecd971e.1701468306.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fbfdc5ea7ad2059ff0560ddf079bd1daecd971e.1701468306.git.josef@toxicpanda.com>

On Fri, Dec 01, 2023 at 05:11:07PM -0500, Josef Bacik wrote:
> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> Right now there isn't a way to encrypt things that aren't either
> filenames in directories or data on blocks on disk with extent
> encryption, so for now, disable verity usage with encryption on btrfs.
> 
> Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/verity.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index 66e2270b0dae..92536913df04 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -588,6 +588,9 @@ static int btrfs_begin_enable_verity(struct file *filp)
>  
>  	ASSERT(inode_is_locked(file_inode(filp)));
>  
> +	if (IS_ENCRYPTED(&inode->vfs_inode))
> +		return -EINVAL;

As per the documentation for FS_IOC_ENABLE_VERITY
(https://docs.kernel.org/filesystems/fsverity.html#fs-ioc-enable-verity), the
error code for the case of "the filesystem does not support fs-verity on this
file" should be EOPNOTSUPP, not EINVAL.  That's what ext4 returns if you try to
enable verity on a file that doesn't use extents, for example.

- Eric

