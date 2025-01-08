Return-Path: <linux-btrfs+bounces-10807-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5ABA068BB
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 23:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD99E3A5E95
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 22:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEA52040BD;
	Wed,  8 Jan 2025 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="o0NR+lrF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U3x/Kdqe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D8519EEBF
	for <linux-btrfs@vger.kernel.org>; Wed,  8 Jan 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736376450; cv=none; b=H9VKklVMury29UPHgmUMjjIpXOS+JImMtOkMu7iP3bpRObsIdme7yQ6qx4vVcPsBd9y8OTpSw+Lw/h/5U0wYHdQz8gogrf6CXSu1eSKksEx+WN2yoUPxkYLoxQfVM2swD2dp3MW5ZVdHTH3KQpr1ba7LbRwEM6dqHDZUCBDz4Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736376450; c=relaxed/simple;
	bh=u8/ceQAum8x8e+IxdcvG4nO3kif5/PCXnT5JDHvWn/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmipaVDcxMIx5QGS5mROUOiL0qQiDWtSBR/7wMjplwubtMHCKdK8ZRR2CCUC6I9MfzJ/+AW2Ijm1Z4OHEzcei/dVcrQzOn3wzRf9iNBIZCYsvn7uJQ5jFfxFkyOZNWs7/4rnGyuDZPHrm1k+C47YwD8UzxLVUyfvJ4DsB3UcxJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=o0NR+lrF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U3x/Kdqe; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2AEAE1140185;
	Wed,  8 Jan 2025 17:47:27 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 08 Jan 2025 17:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736376447; x=1736462847; bh=EJewzKZRL6
	gsRBsD/wLxpurjSeV46oL2wpWHyoRkbTg=; b=o0NR+lrFjjb2GjPFOANA0RkRtg
	fM62/LvYiO1vv0M6sODOpEfXuI60g9pvgsISuzzBoxWjhgXdHsLosSgEn5fj7GRD
	N4ncZ+nSlCMoMbvzm8d/++Vtbea2TYHfU9OEH2I4B7NxBk4rHViXICazu7d4OC62
	jurKOXDlB9aMumbBVRxlSgrTQWf2oUCxxjezOAPLTb8iQaMDcilJt+W/5/AiQzUc
	JFP3klVrQNbdV0SDLvyRmnU4wP2oD8VSW/E00u6lo6Qwi1gQ5XJl8XpPCkrf4m8D
	dphggzCGUsq/Bbe6o1iDoeq9BtybwnTrcyi0zgU2sxex/BTPvbzuqrSNLH1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736376447; x=1736462847; bh=EJewzKZRL6gsRBsD/wLxpurjSeV46oL2wpW
	HyoRkbTg=; b=U3x/Kdqeb7Sm8g7h7keb8JoGQPMQrLNMEqGwZ1Sos4ZHVL2pPMU
	Pc4InjRcpDE2q5HhmzA7dAjA4smDTA95gRmKj0jPWZA43EHUW1+VwqgcOnJhCTlR
	WHmWfI2HotF9uYj1CyYnUcU7Ma3ttatd+Ju2j58aUhpLh7BtRQyFMLBGuHec54He
	GgTx0e5vu8PP9+qJhPNYuX43pZv7UG+pvog3avSCE1JttJ7C1OhJWZfGIr0ssBQw
	xdkU536a6rr1pv9Yids1oKP046ba0dZyfy+vYko6BpZcVZRXsQdHWuLTSqiOH6C4
	KYMYRQGZ01/Af0Q8ZvhzWiY0AOs4e0ahtHw==
X-ME-Sender: <xms:fgB_Z04PER_Q75I0E49Th_u9CkfVHJIyigrtfN7P87r3f0U5_qbG9g>
    <xme:fgB_Z1604ZUXDOeeYkY3Q8KON0mCWlneVUX8pa78Z6KjSsws0oM93APwTfH0uCktF
    2ONaAFMzH1qgazLRUw>
X-ME-Received: <xmr:fgB_ZzeYLlsZO9AIgpw5qOykm4EC47hp4DZHnfxVLPknxuPe7WbRGXtIuOcc4E_FdKeFNiZB_6T_mSu6ykG6_yTEs84>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeghedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihhoqeenuc
    ggtffrrghtthgvrhhnpeekvdekffejleelhfevhedvjeduhfejtdfhvdevieeiiedugfeu
    gfdtjefgfeeljeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsohhrihhssegsuhhrrdhiohdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepfihquhesshhushgvrdgtohhmpdhrtghpthhtoheplh
    hinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fgB_Z5KlL_l9I689uah4BSJL1OzrHrJloE8N2x7wgvIjEUukub9_fg>
    <xmx:fgB_Z4Jv5mKNPSxylAhX0GpjO-urGOJrBC8MQydp-MW2IBh80KnNgA>
    <xmx:fgB_Z6ziCi0VirH-BLYpU4FL434thXK36nuGmN3IyaNA00iZqrN3vw>
    <xmx:fgB_Z8KcdoZ3KlhUjgAzqasjtnj3GxECNXLFXXA6bfopA7iG8av9Vw>
    <xmx:fwB_Z_Uqi3fuNRr-7V8J6LvOTUrTX7b2smYTGGu2pR-GB5K_0V_JlyG_>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 17:47:26 -0500 (EST)
Date: Wed, 8 Jan 2025 14:48:00 -0800
From: Boris Burkov <boris@bur.io>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 9/9] btrfs: remove the unused @locked_folio parameter
 from btrfs_cleanup_ordered_extents()
Message-ID: <20250108224800.GG1456944@zen.localdomain>
References: <cover.1733983488.git.wqu@suse.com>
 <ccbea215c530461830f0b4beca807f2bcba42ec1.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccbea215c530461830f0b4beca807f2bcba42ec1.1733983488.git.wqu@suse.com>

On Thu, Dec 12, 2024 at 04:44:03PM +1030, Qu Wenruo wrote:
> The function btrfs_cleanup_ordered_extents() is only called in error
> handling path, and the last caller with a @locked_folio parameter is
> removed to fix a bug in the btrfs_run_delalloc_range() error handling.
> 
> There is no need to pass @locked_folio parameter anymore.

I was wondering this while reviewing the others. Nice improvement, this
confused me once earlier this year in some reservation debug.

Reviewed-by: Boris Burkov <boris@bur.io>

> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/inode.c | 44 ++------------------------------------------
>  1 file changed, 2 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index a88cba85bf40..a5d33ebf90d4 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -393,34 +393,13 @@ void btrfs_inode_unlock(struct btrfs_inode *inode, unsigned int ilock_flags)
>   * extent (btrfs_finish_ordered_io()).
>   */
>  static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
> -						 struct folio *locked_folio,
>  						 u64 offset, u64 bytes)
>  {
>  	unsigned long index = offset >> PAGE_SHIFT;
>  	unsigned long end_index = (offset + bytes - 1) >> PAGE_SHIFT;
> -	u64 page_start = 0, page_end = 0;
>  	struct folio *folio;
>  
> -	if (locked_folio) {
> -		page_start = folio_pos(locked_folio);
> -		page_end = page_start + folio_size(locked_folio) - 1;
> -	}
> -
>  	while (index <= end_index) {
> -		/*
> -		 * For locked page, we will call btrfs_mark_ordered_io_finished
> -		 * through btrfs_mark_ordered_io_finished() on it
> -		 * in run_delalloc_range() for the error handling, which will
> -		 * clear page Ordered and run the ordered extent accounting.
> -		 *
> -		 * Here we can't just clear the Ordered bit, or
> -		 * btrfs_mark_ordered_io_finished() would skip the accounting
> -		 * for the page range, and the ordered extent will never finish.
> -		 */
> -		if (locked_folio && index == (page_start >> PAGE_SHIFT)) {
> -			index++;
> -			continue;
> -		}
>  		folio = filemap_get_folio(inode->vfs_inode.i_mapping, index);
>  		index++;
>  		if (IS_ERR(folio))
> @@ -436,23 +415,6 @@ static inline void btrfs_cleanup_ordered_extents(struct btrfs_inode *inode,
>  		folio_put(folio);
>  	}
>  
> -	if (locked_folio) {
> -		/* The locked page covers the full range, nothing needs to be done */
> -		if (bytes + offset <= page_start + folio_size(locked_folio))
> -			return;
> -		/*
> -		 * In case this page belongs to the delalloc range being
> -		 * instantiated then skip it, since the first page of a range is
> -		 * going to be properly cleaned up by the caller of
> -		 * run_delalloc_range
> -		 */
> -		if (page_start >= offset && page_end <= (offset + bytes - 1)) {
> -			bytes = offset + bytes - folio_pos(locked_folio) -
> -				folio_size(locked_folio);
> -			offset = folio_pos(locked_folio) + folio_size(locked_folio);
> -		}
> -	}
> -
>  	return btrfs_mark_ordered_io_finished(inode, NULL, offset, bytes, false);
>  }
>  
> @@ -1129,8 +1091,7 @@ static void submit_uncompressed_range(struct btrfs_inode *inode,
>  			       &wbc, false);
>  	wbc_detach_inode(&wbc);
>  	if (ret < 0) {
> -		btrfs_cleanup_ordered_extents(inode, NULL,
> -					      start, end - start + 1);
> +		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
>  		if (locked_folio)
>  			btrfs_folio_end_lock(inode->root->fs_info, locked_folio,
>  					     start, async_extent->ram_size);
> @@ -2387,8 +2348,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
>  
>  out:
>  	if (ret < 0)
> -		btrfs_cleanup_ordered_extents(inode, NULL, start,
> -					      end - start + 1);
> +		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
>  	return ret;
>  }
>  
> -- 
> 2.47.1
> 

