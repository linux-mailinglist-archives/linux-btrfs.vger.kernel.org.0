Return-Path: <linux-btrfs+bounces-11236-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E463A25809
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 12:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A10D81660DD
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 11:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1D4202F68;
	Mon,  3 Feb 2025 11:24:02 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from out198-152.us.a.mail.aliyun.com (out198-152.us.a.mail.aliyun.com [47.90.198.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD459202C2A
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581842; cv=none; b=laYegQUY+tGFSTIYIOhB8rEyqWL9RTsHp0rEwpZDNu6titEd7kBJjw/3ISoitR8L2DxMmo03LMCi0QMOo5QCpe0hL6dd5t85X3llTfvh3PeKP5VKpvl3mWlgFWXQAgW08oxbbuNe0wo1FRKq0b/2PvOue+CDxnFwaBcX8w+3tTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581842; c=relaxed/simple;
	bh=bPOwkb4CVR/pYjUeCmRhESNZ24fDKmk24H69FU712e8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:Message-Id:
	 MIME-Version:Content-Type; b=eTci670jYba3RDjjh3YXWPVO65y/o04EhBYddMF9yNwOfXi9Nqh+QkLhEQUyLuBQ0QOCwURch1CN8qfH7t/8LRqBl4pZaVjGqXypzq3mcJsz3skbsPe+fQ28w8QAXUP80nJNbtro1ToXGLay584qeiVJeGkmLGEV8nNduh2Ej6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com; spf=pass smtp.mailfrom=e16-tech.com; arc=none smtp.client-ip=47.90.198.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=e16-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=e16-tech.com
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.bFntz5h_1738578158 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 03 Feb 2025 18:22:38 +0800
Date: Mon, 03 Feb 2025 18:22:39 +0800
From: Wang Yugui <wangyugui@e16-tech.com>
To: Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: always fallback to buffered IO if the inode requires checksum
Cc: linux-btrfs@vger.kernel.org,
 "hch@infradead.org" <hch@infradead.org>
In-Reply-To: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
References: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
Message-Id: <20250203182238.E5E7.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.81.08 [en]

Hi,

> [BUG]
> It is a long known bug that VM image on btrfs can lead to data csum
> mismatch, if the qemu is using direct-io for the image (this is commonly
> known as cache mode none).
> 
> [CAUSE]
> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
> fs is allowed to dirty/modify the folio even the folio is under
> writeback (as long as the address space doesn't have AS_STABLE_WRITES
> flag inherited from the block device).
> 
> This is a valid optimization to improve the concurrency, and since these
> filesystems have no extra checksum on data, the content change is not a
> problem at all.
> 
> But the final write into the image file is handled by btrfs, which need
> the content not to be modified during writeback, or the checksum will
> not match the data (checksum is calculated before submitting the bio).
> 
> So EXT4/XFS/NTRFS believes they can modify the folio under writeback,
> but btrfs requires no modification, this leads to the false csum
> mismatch.
> 
> This is only a controlled example, there are even cases where
> multi-thread programs can submit a direct IO write, then another thread
> modifies the direct IO buffer for whatever reason.
> 
> For such cases, btrfs has no sane way to detect such cases and leads to
> false data csum mismatch.
> 
> [FIX]
> I have considered the following ideas to solve the problem:
> 
> - Make direct IO to always skip data checksum
>   This not only requires a new incompatible flag, as it breaks the
>   current per-inode NODATASUM flag.
>   But also requires extra handling for no csum found cases.
> 
>   And this also reduces our checksum protection.
> 
> - Let hardware to handle all the checksum
>   AKA, just nodatasum mount option.
>   That requires trust for hardware (which is not that trustful in a lot
>   of cases), and it's not generic at all.
> 
> - Always fallback to buffered IO if the inode requires checksum
>   This is suggested by Christoph, and is the solution utilized by this
>   patch.
> 
>   The cost is obvious, the extra buffer copying into page cache, thus it
>   reduce the performance.
>   But at least it's still user configurable, if the end user still wants
>   the zero-copy performance, just set NODATASUM flag for the inode
>   (which is a common practice for VM images on btrfs).
> 
>   Since we can not trust user space programs to keep the buffer
>   consistent during direct IO, we have no choice but always falling
>   back to buffered IO.
>   At least by this, we avoid the more deadly false data checksum
>   mismatch error.

Could we mark the page for direct write to READ-only
when ! BTRFS_INODE_NODATASUM?

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2025/02/03



> Suggested-by: hch@infradead.org <hch@infradead.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/direct-io.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index c99ceabcd792..d64cda76cc92 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -444,6 +444,19 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>  			goto err;
>  	}
>  
> +	/*
> +	 * For direct IO, we have no control on the folio passed in, thus the content
> +	 * can change halfway after we calculated the data checksum.
> +	 *
> +	 * To be extra safe and avoid false data checksum mismatch, if the inode still
> +	 * requires data checksum, we just fall back to buffered IO by returning
> +	 * -ENOTBLK, and iomap will do the fallback.
> +	 */
> +	if (!(BTRFS_I(inode)->flags & BTRFS_INODE_NODATASUM)) {
> +		ret = -ENOTBLK;
> +		goto err;
> +	}
> +
>  	/*
>  	 * If this errors out it's because we couldn't invalidate pagecache for
>  	 * this range and we need to fallback to buffered IO, or we are doing a
> -- 
> 2.48.1
> 



