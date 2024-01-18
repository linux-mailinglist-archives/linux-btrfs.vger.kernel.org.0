Return-Path: <linux-btrfs+bounces-1560-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC968320E5
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 22:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2D5A28A160
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 21:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F254C31732;
	Thu, 18 Jan 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="veU88RpH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VlnvZqaY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251D2E405
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613431; cv=none; b=FW1nVebVCmXDgvpt49uKRdl/bT7XQOFOPFlUX3qaHmOR+wezeXaBp+yejQ2OzA7978nmjmS0NEQeqQ6nVxZfXWIUY7H+PVqP2WaTRpaCYInCokQDNEDaGMlJLL4tcJHMv/Jy5eW8hJ/jk6z0V3edpXYWvZhNIs6H5rB7hi26wHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613431; c=relaxed/simple;
	bh=jajDsJXSwpeyw/YdjSAmZeXvMP+qgd12OyN/PqMrcRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQaBU/Ysglpg2Wz5NRLNqRSkBz4XIH3JhsAsROp0eRrSPbVGeYtIGBkCMKCNAo0Hrw/U0rqRwvrT6YK9WqlPlEJ8uOAO91RbPCb8F3K7TkYMjL4azijzfwaabDxLf9v+jZPHBjNAQ5k3QSXMcMtmB2M0VjXCUIiB/TKZB8C7V8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=veU88RpH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VlnvZqaY; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 9B24E3200AEE;
	Thu, 18 Jan 2024 16:30:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 18 Jan 2024 16:30:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705613427; x=1705699827; bh=29r0TRKbsF
	cFfKVg2cPve6MpoQzck5QIiH/US/CSvJ8=; b=veU88RpH115gtktvZbBl/tfOBI
	ot9iGnRLbScPQbddokC/xkS7REvaWILzA5rm5ZIq0p1dsX89esFNfTg67JjZJDjE
	LvLLpjEag4jJ71JnDRI7xqZHWTWbqsRvTNpgFdChSDEowageuh3Iy2T9RHuUi014
	MhzsecpgiMb/2gFzuI7kMP0AqLSNKXytsO3Dz3DJt2ynjvx+UZ75wr5qzzXVf6Cd
	YlxIHHzNCKuN5slvJXufS42NVof+LorJAkAaL6rbLloptxOf7SzvNzTIHKoIn3d6
	s4RWnAeASXhWLfRkTNXqZfz78i7duBgfz9M0oIHPPlV8T9PnqP6SPsoXXU6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705613427; x=1705699827; bh=29r0TRKbsFcFfKVg2cPve6MpoQzc
	k5QIiH/US/CSvJ8=; b=VlnvZqaYdIuyuGuZerHuEb7sMQ6WUhRQIncvKKTj/QcI
	XZI/dzvbf4TExY28LBvaC2bi+RxfgXQw69/SjAY8TU6mADGUDu1yWuxlip3mGKtG
	waBaw2pxtrNPEQXgi71zQwA5tBv2DYBG2QTTRcdT3W1spGrd4ccN0lzko93Xo67+
	xBHDFTdRUCVCuQhdrUCTg6+6qJwagH9dJ9cEJDODaHkVSwjUFBedbfEppsc6bcr3
	m7jBXdAKDgfGb11vr/m0lkIdSvAfdhLVODYwq4BU5fsUQvVXmDzX2LxCWvaikzkz
	7J9XciOPlXN4oKRUSgnxEqU2BtOOtN3Hh8hpAsFJHg==
X-ME-Sender: <xms:cpipZT9fJrToj5Boad0V0GgJ2ikumQ1HQxWdkSo-EXjsGk1HSkrdDw>
    <xme:cpipZftD8-VQzrPAcRErD-RvXCDkLfuvu4JXTbWRcBKrsoDyg065jDosnYpBVd7Ll
    l73JD6B_T-UyZszFMY>
X-ME-Received: <xmr:cpipZRDMa8T3flQXr3DVSy3REFtJCVtuD5wEm7jHfivK431pSE0VC7jS5CMsUrBS4qqb0ZMv3bvehQWbjwXPb773h94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:cpipZfeu374DiMg99jxZh4oSgtt_judEi0WBoLF4-z0Shi8wKcgb6w>
    <xmx:cpipZYMtZ_ZSIal5plMNGOPfy_lmjUzcrxDmpbR9IFDPG7HhyNgtXA>
    <xmx:cpipZRmvfKx8GdyHsJiuGnAK-tnyyUhKaBOp00UAcwYrlac3mJzqCw>
    <xmx:c5ipZS0Ci1ZCPulSY2N_CrOPfN6caPx2AHNQADM7L2AoQDuN-Rnz7g>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 16:30:26 -0500 (EST)
Date: Thu, 18 Jan 2024 13:31:36 -0800
From: Boris Burkov <boris@bur.io>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/4] btrfs: Use IS_ERR() instead of checking folio for
 NULL
Message-ID: <20240118213136.GA1356080@zen.localdomain>
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <e4df9a1068c81f3edeee9bbb4e63d1d453be569b.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4df9a1068c81f3edeee9bbb4e63d1d453be569b.1705605787.git.rgoldwyn@suse.com>

On Thu, Jan 18, 2024 at 01:46:37PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> __filemap_get_folio() returns an error instead of a NULL pointer. Use
> IS_ERR() to check if folio is not returned.
> 
> As we are fixing this, use set_folio_extent_mapped() instead of
> set_page_extent_mapped().

nit:
I would change the commit message to something like:
"btrfs_truncate_block folio vs page fixes"

So that it is exactly what it says on the tin, and the second change
isn't a "sneaky" one.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Fixes: f8809b1f6a3e btrfs: page to folio conversion in btrfs_truncate_block()
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/inode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7199670599d9..25090d23834b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4714,7 +4714,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  again:
>  	folio = __filemap_get_folio(mapping, index,
>  				    FGP_LOCK | FGP_ACCESSED | FGP_CREAT, mask);
> -	if (!folio) {
> +	if (IS_ERR(folio)) {
>  		btrfs_delalloc_release_space(inode, data_reserved, block_start,
>  					     blocksize, true);
>  		btrfs_delalloc_release_extents(inode, blocksize);
> @@ -4742,7 +4742,7 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
>  	 * folio private, but left the page in the mapping.  Set the page mapped
>  	 * here to make sure it's properly set for the subpage stuff.
>  	 */
> -	ret = set_page_extent_mapped(&folio->page);
> +	ret = set_folio_extent_mapped(folio);
>  	if (ret < 0)
>  		goto out_unlock;
>  
> -- 
> 2.43.0
> 

