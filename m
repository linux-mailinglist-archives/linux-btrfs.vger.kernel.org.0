Return-Path: <linux-btrfs+bounces-13822-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 886DEAAF2E6
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 07:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831D71BC610D
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 May 2025 05:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEEB215168;
	Thu,  8 May 2025 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iO7Iwtuo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB493215063;
	Thu,  8 May 2025 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746682211; cv=none; b=AgR+FpYbN2VdBp2GZyrPUr7bwT+4vZgMqW8OefVrRL4T9iae9WlO0DGqF42uJqlTVI/17REGyLWrsc9VLK9d4EHzfy6yiAcKypB9iTZ/1DE+L3lYgn6gRfXap2b6Ql9QX26KayJ8xdwRiGfy6ufZPa5jED5bZmHA52i3DKEMx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746682211; c=relaxed/simple;
	bh=+j2nGh1iZoKqUNxCPUvIhwqhATsOcBMd/tEw23xw9Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLEtKSuAIfUCwR0rWLm2OCDdVTrAGn8mALE23443LM/Mq2vVxFVLsNUAyE85uzcHYgn3GD2Z2nUG7kVK/Vi7aT5CDUmrX6HWsVL9cxP2moT3ZEl0EU4P2l8BCUnfKnYsXeTD32a4IoSzZSUVEiFIQMNJdxgcYHnaPVLnI9zv9mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iO7Iwtuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D70C4CEEB;
	Thu,  8 May 2025 05:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746682211;
	bh=+j2nGh1iZoKqUNxCPUvIhwqhATsOcBMd/tEw23xw9Xw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iO7Iwtuo2ZyDL9s2h5j+xgvwKoNTgES7EaXvL9WegLVc3uXXXC7DaD/p1EPp1wmRY
	 1e1KmeJs/sNhQFMyh1JB9T48ikyRWsnNPyghi1/b9158PIwQ1vYYxRdB/oIzvBHBzX
	 s2hUNQIikQ9sDj3C+HGaApj3S1So9+Z3PwJgkCRc=
Date: Thu, 8 May 2025 07:30:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: always fallback to buffered write if the inode
 requires checksum
Message-ID: <2025050830-epilepsy-emu-5a5d@gregkh>
References: <54c7002136a047b7140c36478200a89e39d6bd04.1746666535.git.wqu@suse.com>
 <dcffa5400745663641e58a261e8dbccbb194b468.1746666392.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcffa5400745663641e58a261e8dbccbb194b468.1746666392.git.wqu@suse.com>

On Thu, May 08, 2025 at 10:39:17AM +0930, Qu Wenruo wrote:
> commit 968f19c5b1b7d5595423b0ac0020cc18dfed8cb5 upstream.
> 
> [BUG]
> It is a long known bug that VM image on btrfs can lead to data csum
> mismatch, if the qemu is using direct-io for the image (this is commonly
> known as cache mode 'none').
> 
> [CAUSE]
> Inside the VM, if the fs is EXT4 or XFS, or even NTFS from Windows, the
> fs is allowed to dirty/modify the folio even if the folio is under
> writeback (as long as the address space doesn't have AS_STABLE_WRITES
> flag inherited from the block device).
> 
> This is a valid optimization to improve the concurrency, and since these
> filesystems have no extra checksum on data, the content change is not a
> problem at all.
> 
> But the final write into the image file is handled by btrfs, which needs
> the content not to be modified during writeback, or the checksum will
> not match the data (checksum is calculated before submitting the bio).
> 
> So EXT4/XFS/NTRFS assume they can modify the folio under writeback, but
> btrfs requires no modification, this leads to the false csum mismatch.
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
> - Let hardware handle all the checksum
>   AKA, just nodatasum mount option.
>   That requires trust for hardware (which is not that trustful in a lot
>   of cases), and it's not generic at all.
> 
> - Always fallback to buffered write if the inode requires checksum
>   This was suggested by Christoph, and is the solution utilized by this
>   patch.
> 
>   The cost is obvious, the extra buffer copying into page cache, thus it
>   reduces the performance.
>   But at least it's still user configurable, if the end user still wants
>   the zero-copy performance, just set NODATASUM flag for the inode
>   (which is a common practice for VM images on btrfs).
> 
>   Since we cannot trust user space programs to keep the buffer
>   consistent during direct IO, we have no choice but always falling back
>   to buffered IO.  At least by this, we avoid the more deadly false data
>   checksum mismatch error.
> 
> CC: stable@vger.kernel.org # 6.6
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> [ Fix a conflict due to the movement of the function. ]
> ---
>  fs/btrfs/direct-io.c | 1094 ++++++++++++++++++++++++++++++++++++++++++

Did you mean to include all of this file in here?

I see 2 versions of this patch sent, the first one looks "correct", but
this one is very odd.

thanks,

greg k-h

