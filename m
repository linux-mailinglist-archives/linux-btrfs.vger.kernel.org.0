Return-Path: <linux-btrfs+bounces-11249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80BA26456
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 21:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00BD416329B
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA02A20B202;
	Mon,  3 Feb 2025 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="ZyXGI32N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from libero.it (smtp-18.italiaonline.it [213.209.10.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06792139CE3
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 20:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.10.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738613978; cv=none; b=bzbXmj62eoJyMaeTbm1gDrbPWmpaoUR5veYfppctABABdjlbkc8eCpyUzE9JSGzYEuq4KdlsaG7k+FvyYtqeJQFQQtNc4l7ikJuK6YtLnf+GrVvajUqgqfXz/59u3ZKr++7NwT6MbrQZXO7ei6asTeVJRaWZeXHt/YGO09DQkSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738613978; c=relaxed/simple;
	bh=KJmIHBeqwzIaHgznKrLSVLKsKP5an4Gab8Gf1Zf7kfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u+JYLIKIJyXOCwAaJh0oFociJqxs5KCxgA0yiyw4DEx1YkPxcAjpm44ec+6+PglAzRMA4Fl2VCt7LbWwENCm1vE3cZhz2vpncjViicwsGVACugzvtG/6XhIr8I+BDshvYVagbvFuYlFrv9XgRHtKp78wDI4LmvwX71z2Co0zp8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=ZyXGI32N; arc=none smtp.client-ip=213.209.10.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Received: from [192.168.1.27] ([84.220.171.3])
	by smtp-18.iol.local with ESMTPA
	id f2ult2zeS5LVif2ultL8mI; Mon, 03 Feb 2025 21:19:28 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1738613968; bh=L6obFwme2oxkvVqVWfV/k/+RhvpoP3G3VMyBdfwIFxQ=;
	h=From;
	b=ZyXGI32NodiuevEL8qEYLXwtDI6W5nVv+sQfbSyBBpU7/eZR+bMP8ma5l/1RpDSVj
	 8ED25vY471Wpi6LuF/519jKQlrZ5KOOOXP5eeU5XbZ5t1FXKseZ0iQRIQyPh4BN95w
	 wAmYemYueyKbwc/bD6DTuWgFyd2DfwcfzDD/pkpIHGZ3Pjx27kzS22/oV1G2bLAYe9
	 xy4AkltaIta+nZbR0PiIZrQIVH54sxKZi5iK7vxWK6SCVDeZpcNVjknVLQxYxi/jT0
	 f59DgjRaj6s48SpucoItnaDh6ZKyJe1VZ/3SteyIGcccDqS7W5yGScvIezMDeDcA6X
	 VPERRkzQG2ILQ==
X-CNFS-Analysis: v=2.4 cv=StRb6+O0 c=1 sm=1 tr=0 ts=67a124d0 cx=a_exe
 a=hciw9o01/L1eIHAASTHaSw==:117 a=hciw9o01/L1eIHAASTHaSw==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=8VpDeP3kAAAA:8 a=JfrnYn6hAAAA:8
 a=iox4zFpeAAAA:8 a=xzuWP2af2hwPKr4WIJ8A:9 a=QEXdDO2ut3YA:10
 a=x58pXJj3Pl9T3GLWE5Uy:22 a=1CNFftbPRP8L7MoqJWF3:22 a=WzC6qhA0u3u7Ye7llzcV:22
Message-ID: <a210b59e-4754-4b58-846a-2529eba0aa9b@libero.it>
Date: Mon, 3 Feb 2025 21:19:27 +0100
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: kreijack@inwind.it
Subject: Re: [PATCH] btrfs: always fallback to buffered IO if the inode
 requires checksum
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: "hch@infradead.org" <hch@infradead.org>
References: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
Content-Language: en-US
From: Goffredo Baroncelli <kreijack@libero.it>
In-Reply-To: <78091f2b21b9d45678ca54e5a7d117adb69c0deb.1738574832.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNCnZp1moPOV4HbHRv+xH3cwI4oOdeip8pVG3HHNasJ2BXw9nnTdUivsGNDZkHb29JiY1Ijc+XQt9To8ZXgi/rIi3h569Z2I1zhOFKrcGQEIKY3cSQgx
 zDP4txFuBEA7MfCaxuskbq6HmgrXTTx/HWh+02AG+BEFrq1cB3UqppEgV6evts8loMamq1ku/Cw2VGI6/VTa8g6/YtXH94ZcfNGWjEXD5K2h7qA2RGIUJgVn
 nCi6gkYPQFOGanpWeLDgZg==

On 03/02/2025 10.27, Qu Wenruo wrote:
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
>    This not only requires a new incompatible flag, as it breaks the
>    current per-inode NODATASUM flag.
>    But also requires extra handling for no csum found cases.
> 
>    And this also reduces our checksum protection.
> 
> - Let hardware to handle all the checksum
>    AKA, just nodatasum mount option.
>    That requires trust for hardware (which is not that trustful in a lot
>    of cases), and it's not generic at all.
> 
> - Always fallback to buffered IO if the inode requires checksum
>    This is suggested by Christoph, and is the solution utilized by this
>    patch.
> 
>    The cost is obvious, the extra buffer copying into page cache, thus it
>    reduce the performance.
>    But at least it's still user configurable, if the end user still wants
>    the zero-copy performance, just set NODATASUM flag for the inode
>    (which is a common practice for VM images on btrfs).
> 
>    Since we can not trust user space programs to keep the buffer
>    consistent during direct IO, we have no choice but always falling
>    back to buffered IO.
>    At least by this, we avoid the more deadly false data checksum
>    mismatch error.

I tried a patch few years ago [1]. I think that it is important to point out that
even ZFS started to support DIRECT_IO only recently [2]. Until that, it ignored the
DIRECT_IO flag.

Moreover, I suggest to print a WARNING when a file is opened with
DIRECT_IO and DATASUM. Even tough it could cause a flood of dmesg.


[1] https://patchwork.kernel.org/project/linux-btrfs/patch/5d52220b-177d-72d4-7825-dbe6cbf8722f@inwind.it/
[2] https://www.phoronix.com/news/OpenZFS-Direct-IO

> Suggested-by: hch@infradead.org <hch@infradead.org>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/direct-io.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index c99ceabcd792..d64cda76cc92 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -444,6 +444,19 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>   			goto err;
>   	}
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
>   	/*
>   	 * If this errors out it's because we couldn't invalidate pagecache for
>   	 * this range and we need to fallback to buffered IO, or we are doing a


-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5

