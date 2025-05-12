Return-Path: <linux-btrfs+bounces-13887-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E387AB39E7
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE72461764
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 May 2025 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0B71DEFDD;
	Mon, 12 May 2025 14:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="QS0NpRGF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0Eaeo+Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFBB41DE8B3;
	Mon, 12 May 2025 14:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058412; cv=none; b=QHW9gVNj3kk1hWBISZPYyC5/B5QX3buuBhbrjtpUvalVtHEt8LqJe/20hgmcBEHPoP3dqmWCE2bGF/zHRbEenVO5F/pg9WK0nPM2qf1Kv9cpuyExikplEUFJQGycrLLq8GtPgkKHJUIWd8h/tLKgLMxQzNgbvnKGdZEhBaGZMgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058412; c=relaxed/simple;
	bh=wpCAGg5FMDdgzOinb2lO8BlPmjr9jTQeq0/EI89fN9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8EqKpm0YX0/bwDgKS2xfpQ8gv8vChkJka5d9jXWjVbkq0EPji0yOXY2u0QeHCOU7O0cMZOwlZZpnVzhNb44+NQoUcFSQhbkSB4maN8Gkw5N55obPfgxjl06fULHsEs4l+IC3YOUTiIt4MSPnvoQHBQsFqGFoAhwKGrYFrVgCKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=QS0NpRGF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0Eaeo+Q; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9E7EC1380211;
	Mon, 12 May 2025 10:00:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 12 May 2025 10:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747058407; x=1747144807; bh=g9YzhNXKHW
	zISuAoilHGKzXC61fbuoHz4GjK/DLdRY4=; b=QS0NpRGFlyZ5H+18CNSg/pCRue
	eQ8tO+7mNx0Pg3SHY7UuBc1+4csrOPDG2ahkcRnAw/C6Ca1292njyv9JOEW2X/yI
	RJCtxdTodd8NHSVRzzi64LSbjeSy3/nNSzIUIayq+pMfQKeW5VIEq3wYu0ktqSj7
	T1bkeK2LLKDiwr4zR2jjMPxineoQHMGwceBGAdaJKtV4ruNfJaCJnZ00sdWWYp5r
	a0M4tieGs4d1tY/eCon6tIvnAkS6uqD7HKmkj4RQRDU5GLmG8qynN51ZmN7BUNHS
	im49wC1iN7+0z6f5LJSbz5QtlKYAZbp6rW5o3F3ZTXu395W+9w5BUVf1v9Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747058407; x=1747144807; bh=g9YzhNXKHWzISuAoilHGKzXC61fbuoHz4Gj
	K/DLdRY4=; b=O0Eaeo+QQ1HQWxJUP7l9jw7dQ8Abp29mGHqGAukxmWARuaGUtDV
	98qAMS78WFIe5q2fLpoHnOjDiVtCombA4o+TAZgQKPfFudnZSeWWFKRBr29Wrk0y
	49b2jwZD/N5sw9a/o7zx7SQcU6CKMnm8eB5pywYSl2gEXvZGphcQSmJFQrWsQoyB
	tbIiVVY0EJFe6Y+frF70phgil+1cGUqioxsKLl+WI3Ld2yaTz17JlhGD1Ghkc447
	XUiDEF1KAMdE8J5ELCX/7/E8R70aQ51AgO9DYFVBhPWy3c1dTMENuqJ5xRj8Pbef
	IXYzHOGqhpIO0qkGZEDJl+sWCKGaqD+/q3w==
X-ME-Sender: <xms:5_4haMOJU3mpUErI5cEzFIZcxM5GqPOSX7eDtFurvEtLlsNqmaoP1A>
    <xme:5_4haC_2EBg2TWYciTKN2673qmBIoke7JY53FI2hU9WEXMJMLbWWuYhP5ssMgZQwP
    S_Ax4j4IX4reQ>
X-ME-Received: <xmr:5_4haDRkGykrWr5ztCXpoODP-cV3w2vHr6957z42ju4Hcuu5zTeSD_lBK3RIj3-VF2Vnt_3EgCeY5V3LlEJz_mhdk97ejl4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepifhrvghgucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecugg
    ftrfgrthhtvghrnhepheegvdevvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeu
    fefhgfehkeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhtghhse
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepfhgumhgrnhgrnhgrsehsuhhsvgdr
    tghomhdprhgtphhtthhopegushhtvghrsggrsehsuhhsvgdrtghomh
X-ME-Proxy: <xmx:5_4haEvOg9kF_xPqFU3IV0d9MrlDHZ42VufZCT8xAsWTOXPZGHBSpQ>
    <xmx:5_4haEf83XtdNHQw509UcI_XIDP2_zoajjebtRHiy80LtzXBciMWAA>
    <xmx:5_4haI3QhtLkkB3YeEaiVek9oy8xTkPDiVupvmzWSv7M2kjYb19oSA>
    <xmx:5_4haI8LX71S-9gX9f17Ks32s0-T4boUIZ649rGyRKTonT4AgS0c0Q>
    <xmx:5_4haHZiU0ri9t_uoQr_WFga1L0WGaBba8DyuQnrWeUwvLSYK2KfPez7>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 10:00:06 -0400 (EDT)
Date: Mon, 12 May 2025 16:00:05 +0200
From: Greg KH <greg@kroah.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.12.y] btrfs: always fallback to buffered write if the
 inode requires checksum
Message-ID: <2025051245-engine-overthrow-8820@gregkh>
References: <968f19c5b1b7d5595423b0ac0020cc18dfed8cb5.1746665263.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <968f19c5b1b7d5595423b0ac0020cc18dfed8cb5.1746665263.git.wqu@suse.com>

On Thu, May 08, 2025 at 10:31:25AM +0930, Qu Wenruo wrote:
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
> Bu the final write into the image file is handled by btrfs, which needs
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
> CC: stable@vger.kernel.org # 6.12+
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/direct-io.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

What about 6.14.y?  It is needed there too, right?  We can't take a
patch only for an older branch and not a newer one.

thanks,

greg k-h

