Return-Path: <linux-btrfs+bounces-20293-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FA1D05D3B
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 20:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CB8C30141D4
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 19:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92E528852B;
	Thu,  8 Jan 2026 19:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="lbCw4HcD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y7F8C9Va"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA86328631
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 19:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899851; cv=none; b=Nqt6WQwvaMkhxp+jfzgQp49DJQQR3D3jBxbsb6hLkH8efcTxJ8efOx0cj2jTbUYc2zdqnUFBzk81R77Gdtg2MzFNfj9KwWGPn7vii9OwB2xY9aZxCgpJrsxVg3F1MU1q9c3GbQgV/1ezWvkHxNZMAV4MN66BLsgwp6U633LnPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899851; c=relaxed/simple;
	bh=L5hZ14vUjZECUu1ISoiQJTXh03/zMiXrMsWJYyWmqMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwacnxB2Qh73ZPikuCXcLZRCuZ9JZOBeQW9ylizKdjlfCPM6xOSMBxUaePT/y0nAlvQ/IfiU31R8R4DT/ML2H09eGBQV3DBSwn5hZ+LHc6CpV8sH5XBfARdsdgon+Fvr4JmNdzu7YLKme1v+gNlRHtIPjyLi+tJPiy69jOD8hUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=lbCw4HcD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y7F8C9Va; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AE821D00084;
	Thu,  8 Jan 2026 14:17:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 08 Jan 2026 14:17:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1767899845; x=1767986245; bh=us4qt0JYGV
	EyIoNt11RJfxaNNG1v0jOXXPIis4KKlXU=; b=lbCw4HcDlNIRVlV9pfjqqLVrii
	ne+qEyqST2ALlW3UUK0RqaSXJJPGdrotYzaAuMriyOkQyAmihOuLocC58p59OUz2
	bMZTRKcBeG1n+cphbrjbO0B8H2hih/wJfiaG3G74ER4nvMhVUrKbMPUBkTkUJunL
	tfE0+WhDBvAK+kHoSBs0pw5bSR4mbxA/VLVpQ2b/h2CW0+8vP+tpEE9lRt+Os997
	Hmh+2mWBYP6NhDW/T+MHHgPS55U40BwPEl5HpM5/RDkDZkBV8wSii1yYDJA/hnxR
	iVuv5baZmdQNQuh4FehtCj6FX+jPaBGOQWQ4NTv77WRzHuWbO1GVELJvK/Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767899845; x=1767986245; bh=us4qt0JYGVEyIoNt11RJfxaNNG1v0jOXXPI
	is4KKlXU=; b=Y7F8C9Vat//xZ/KtCyBVkEVVtKrYD1EVUSMpj5+Wkldavdv7tTB
	eVsJdRtYCo/HHXvG2k7F80cVuZBbqhpj7dyuZbIJwLcm7gm8E2vRz/b+i0gjSexo
	RjDdQiHXkyKckJN0NxwjJLxi3kRbiFZpRby+DF8ps278gWHEdUAp2+y8KzWfyPNH
	ZHOmyTxLF3rbR5ki/psl4lBiXfJcWt27a6jjYl6IYBc4x0xJa2KkKD2gjPIAsYGw
	0biWF51sjjpgRGn7gwHiw/ZHNB7oJkzdCpJGjxDa0TcD27dGBUmkI6zcd3NfK1/Q
	I+tkrFk9y5BFevuao1edrsSAfVTPkXpf1tg==
X-ME-Sender: <xms:xAJgaT371t-pW8FbwzVb9AN9GkHF9SU3vLJ-V4aGzm-HsL5i4Ij49g>
    <xme:xAJgaYFmEc--hs9TuMqbkrRbCOnuZz2rR733yCWAFkWbQoUqkNz5eMo4fhC--106-
    JpwPPOVdDx0LMguw0V6jfOLnK9UaSVThEAi8cEC0UHushy2XHDs-74>
X-ME-Received: <xmr:xAJgaRiBtV08zBcMCjtiJ8RXpwh3yIWC2in0o1NvbGbK5HmZhLpfEj17HDqq8N42jCXAVOOTIZMQYsGjKv1tLBW-M_0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdeijeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:xAJgaT_QPfKQBgoYesLWjk_vhXgJFpuCpPgQ4uxEbt7ti64MAZcHFQ>
    <xmx:xAJgaYrCRDNWLhVRuCg1FTbVklSnggDP9O9A2jPVGCkkAg1buFbueA>
    <xmx:xAJgaS-83jvNh6PsMEKVwMqa7LmXpQ419TyhlZjWTvkKHpYjsZFfAw>
    <xmx:xAJgacUM0bOid-rsRxfc5k98XIwAAScuz_YRU8TWGAalKfk4J5tRiQ>
    <xmx:xQJgaWJAtVc1gHATkvotC1e6gjES7h6ZPoDlWFc4w5HR73FrsmEXI_t2>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Jan 2026 14:17:24 -0500 (EST)
Date: Thu, 8 Jan 2026 11:17:33 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: invalidate pages instead of truncate after
 reflinking
Message-ID: <20260108191733.GA2485498@zen.localdomain>
References: <857d9448b17a3403e5c0bfa71f3defce4331f535.1767891836.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <857d9448b17a3403e5c0bfa71f3defce4331f535.1767891836.git.fdmanana@suse.com>

On Thu, Jan 08, 2026 at 05:10:04PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Qu reported that generic/164 often fails because the read operations get
> zeroes when it expects to either get all bytes with a value of 0x61 or
> 0x62. The issue stems from truncating the pages from the page cache
> instead of invalidating, as truncating can zero page contents.

Can you make it more clear if this is a subpage/large folios issue or a
generic issue? Or maybe just explain the "can zero page contents" in a
little more detail? I agree that it is the wrong "contract" so your
change makes sense either way, this is just for future
knowledge/archaeology.

The documentation of truncate_inode_pages_range only mentions zeroing
partial pages when "lstart or lend + 1 is not page aligned" but our call
is

	truncate_inode_pages_range(&inode->i_data,
				round_down(destoff, PAGE_SIZE),
				round_up(destoff + len, PAGE_SIZE) - 1);

which appears to align it?

Sorry if I am missing something obvious :)

> 
> So instead of truncating, invalidate the page cache range with a call to
> filemap_invalidate_inode(), which besides not doing any zeroing also
> ensures that while it's invalidating folios, no new folios are added.
> This helps ensure that buffered reads that happen while a reflink
> operation is in progress always get either the whole old data (the one
> before the reflink) or the whole new data, which is what generic/164
> expects.
> 
> Reported-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/reflink.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/btrfs/reflink.c b/fs/btrfs/reflink.c
> index e746980567da..f7ddd3765249 100644
> --- a/fs/btrfs/reflink.c
> +++ b/fs/btrfs/reflink.c
> @@ -705,7 +705,6 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>  	struct inode *src = file_inode(file_src);
>  	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
>  	int ret;
> -	int wb_ret;
>  	u64 len = olen;
>  	u64 bs = fs_info->sectorsize;
>  	u64 end;
> @@ -750,25 +749,29 @@ static noinline int btrfs_clone_files(struct file *file, struct file *file_src,
>  	btrfs_lock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
>  	ret = btrfs_clone(src, inode, off, olen, len, destoff, 0);
>  	btrfs_unlock_extent(&BTRFS_I(inode)->io_tree, destoff, end, &cached_state);
> +	if (ret < 0)
> +		return ret;
>  
>  	/*
>  	 * We may have copied an inline extent into a page of the destination
>  	 * range, so wait for writeback to complete before truncating pages

s/truncating/invalidating/

>  	 * from the page cache. This is a rare case.
>  	 */
> -	wb_ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> -	ret = ret ? ret : wb_ret;
> +	ret = btrfs_wait_ordered_range(BTRFS_I(inode), destoff, len);
> +	if (ret < 0)
> +		return ret;
> +

Even if it's true, not worth doing in a fix like this, but a question:
I think buffered reads will check for outstanding ordered_extents and
wait for them. If we are invalidating the cache next, then how can we
read the file without seeing this ordered_extent? Is this
wait_ordered_range still necessary?

Again, not a blocker for this patch.

>  	/*
> -	 * Truncate page cache pages so that future reads will see the cloned
> -	 * data immediately and not the previous data.
> +	 * Invalidate page cache so that future reads will see the cloned data
> +	 * immediately and not the previous data.
>  	 */
> -	truncate_inode_pages_range(&inode->i_data,
> -				round_down(destoff, PAGE_SIZE),
> -				round_up(destoff + len, PAGE_SIZE) - 1);
> +	ret = filemap_invalidate_inode(inode, false, destoff, end);
> +	if (ret < 0)
> +		return ret;
>  
>  	btrfs_btree_balance_dirty(fs_info);
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int btrfs_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> -- 
> 2.47.2
> 

