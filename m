Return-Path: <linux-btrfs+bounces-1563-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7A7832105
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 22:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B108BB25278
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Jan 2024 21:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C0731741;
	Thu, 18 Jan 2024 21:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="L5o+9g1Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YRr20S7q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C2E2EAF9
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Jan 2024 21:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614418; cv=none; b=enjTpv6TX+dAEHvJ8QMWLtmnjivWAERqWxLpqP85rTpfGCj51M8RoGviXM3FaBiLN2gJ/2j1xst80m4RudwSDBHdF/Yk5y1a8F0PBaHDpil/Ifsh4xhTblor4YugyNQy/bT/NDRXXVMhRUPRwNLjvXA5GG6Gl01X+tmMyCybuLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614418; c=relaxed/simple;
	bh=szbr89GyAgBUfWZKvrWX81mgnazXeqljqWlk8wbj+us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4yfrSYlp2Z8SoJbkk1frHhHd8ch50dJ6++xDXwf4a2cvfdyUdZLFkT4KR5Sc27C6e9rPEwauuNgDKy2nJaxeH6X/XqyCHSyjzJaI5emgh0cIdBH1kAqkHogUavp8WyFOdHTd7zSmTO9un4R7EjliXLjLZw226OCNmJMK9Cl1LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=L5o+9g1Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YRr20S7q; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id EEA8C3200ACF;
	Thu, 18 Jan 2024 16:46:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 18 Jan 2024 16:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705614415; x=1705700815; bh=YUPwOLte6j
	Pza8O9QvV5ccmov5s1I8qvY40gYzmCJBE=; b=L5o+9g1YQ89Z2ogcwiHyC6Tif7
	kwB3LWDurwS9goOk/filb41x5w9q9ojJ+n3qEnwdIbYCJrRJiuVBlM2ZKhmPREik
	LREFQJN3tiFpy3Fw/+nV9pPLVnbC2uLBceAezG+q2fCyz1E0k5FY9p2R2f9gweH7
	I05HIH3ifRrYpH36JQUYzzcw2WndEifY3limoXCdlOizjJdeEv6pRiQyF//McSpw
	0w1F3CAbALP5NLB7kh7M/6WFPDTTkn9q7BgS/yY1Jb9OOMfpYgS3pVOylyHsoDpF
	lAO5kmFB3qMJaGXhOe6BP7R4Fqa/8vPbyam5LxrCLWoWySH5JWoNgTtTy1uQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705614415; x=1705700815; bh=YUPwOLte6jPza8O9QvV5ccmov5s1
	I8qvY40gYzmCJBE=; b=YRr20S7qW0Wa3uQVq4RE5fsxVgGPb4sZ6e11Z+oI2fBu
	oxXOErE3DTSvEqUP6O+rmrWfKq4hxkJGqnAnMyYPC6wNu+Z7JbxFA9FBv22mdRTS
	04Zx+Z05v9+nPXF9u2wJNRfpz+xmsL4MvVyHoVA+AbCwdE0hJk5cQianqRfgwZqf
	l7gIPKhdtGw1g47Pe3lpMl9vYYutJ2KfKFuw6VVfGsv9B9z7FzVCwk+hQmSrsSjx
	d+Gjtujfz221WtiPE5nP49fOJrX5u9Ur6JHBOxi3jYtsR1yBKLBYcJBeyBsU9+N9
	uc2hbkgA2OPiqO05eaR6xDNduCd+KePWCcv/k3PiPQ==
X-ME-Sender: <xms:T5ypZV8-S4r2M6rpTWxKnrrtX3y65--QDAuqaMd1SqemrB0nb5FyIQ>
    <xme:T5ypZZsEnaWLKEAPuhFfoFpCRM0gt-jDuQ7doVWNHGARpWc79g2eHG4DOcbPi0WPX
    kZCqdIZOoHN0ysnh88>
X-ME-Received: <xmr:T5ypZTCQQjbrW_B1r7CyohI6eaO32VJaZYA5fp3PA_TgS7qgVjiJTzkhxBCb0Ll54sLfPOBSq0RhCW4_lfwqPuSjBqU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhr
    ihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhioheqnecuggftrfgrthhtvghrnh
    epkedvkeffjeellefhveehvdejudfhjedthfdvveeiieeiudfguefgtdejgfefleejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghorhhish
    essghurhdrihho
X-ME-Proxy: <xmx:T5ypZZfwBbmv1UYq1Mpcg10MxhP5lQwAEzvIhYe11KB_-4EpNZuK6A>
    <xmx:T5ypZaPeJhdOLgJ1W9OzAgaqAcFs2v1P2k9wPcXAos259Q7iR6bKVA>
    <xmx:T5ypZbnZveCoUUVGdYCVqqRUdlVrL_1NMObRo_7dwyt4j-_1UFlF6A>
    <xmx:T5ypZc3XWzRKVtktzX7OvdoIYqnx0PovH-94kG1cLo_oPJN9t1IkFg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 16:46:54 -0500 (EST)
Date: Thu, 18 Jan 2024 13:48:06 -0800
From: Boris Burkov <boris@bur.io>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/4] btrfs: page to folio conversion in put_file_data()
Message-ID: <20240118214806.GD1356080@zen.localdomain>
References: <cover.1705605787.git.rgoldwyn@suse.com>
 <861fb1618d04ccb56c00ac78b4c6ca81dc9a59e4.1705605787.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861fb1618d04ccb56c00ac78b4c6ca81dc9a59e4.1705605787.git.rgoldwyn@suse.com>

On Thu, Jan 18, 2024 at 01:46:40PM -0600, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> Use folio instead of page in put_file_data(). This converts usage of all
> page based functions to folio-based.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>

Reviewed-by: Boris Burkov <boris@bur.io>

> ---
>  fs/btrfs/send.c | 42 +++++++++++++++++++++---------------------
>  1 file changed, 21 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 7902298c1f25..0de3d4163f6b 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -5257,10 +5257,11 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  {
>  	struct btrfs_root *root = sctx->send_root;
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> -	struct page *page;
> +	struct folio *folio;
>  	pgoff_t index = offset >> PAGE_SHIFT;
>  	pgoff_t last_index;
>  	unsigned pg_offset = offset_in_page(offset);
> +	struct address_space *mapping = sctx->cur_inode->i_mapping;
>  	int ret;
>  
>  	ret = put_data_header(sctx, len);
> @@ -5273,44 +5274,43 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
>  		unsigned cur_len = min_t(unsigned, len,
>  					 PAGE_SIZE - pg_offset);
>  
> -		page = find_lock_page(sctx->cur_inode->i_mapping, index);
> -		if (!page) {
> -			page_cache_sync_readahead(sctx->cur_inode->i_mapping,
> +		folio = filemap_lock_folio(mapping, index);
> +		if (IS_ERR(folio)) {
> +			page_cache_sync_readahead(mapping,
>  						  &sctx->ra, NULL, index,
>  						  last_index + 1 - index);
>  
> -			page = find_or_create_page(sctx->cur_inode->i_mapping,
> -						   index, GFP_KERNEL);
> -			if (!page) {
> -				ret = -ENOMEM;
> +	                folio = filemap_grab_folio(mapping, index);
> +			if (IS_ERR(folio)) {
> +				ret = PTR_ERR(folio);
>  				break;
>  			}
>  		}
>  
> -		if (PageReadahead(page))
> -			page_cache_async_readahead(sctx->cur_inode->i_mapping,
> -						   &sctx->ra, NULL, page_folio(page),
> +		if (folio_test_readahead(folio))
> +			page_cache_async_readahead(mapping,
> +						   &sctx->ra, NULL, folio,
>  						   index, last_index + 1 - index);
>  
> -		if (!PageUptodate(page)) {
> -			btrfs_read_folio(NULL, page_folio(page));
> -			lock_page(page);
> -			if (!PageUptodate(page)) {
> -				unlock_page(page);
> +		if (!folio_test_uptodate(folio)) {
> +			btrfs_read_folio(NULL, folio);
> +			folio_lock(folio);
> +			if (!folio_test_uptodate(folio)) {
> +				folio_unlock(folio);
>  				btrfs_err(fs_info,
>  			"send: IO error at offset %llu for inode %llu root %llu",
> -					page_offset(page), sctx->cur_ino,
> +					folio_pos(folio), sctx->cur_ino,
>  					sctx->send_root->root_key.objectid);
> -				put_page(page);
> +				folio_put(folio);
>  				ret = -EIO;
>  				break;
>  			}
>  		}
>  
> -		memcpy_from_page(sctx->send_buf + sctx->send_size, page,
> +		memcpy_from_folio(sctx->send_buf + sctx->send_size, folio,
>  				 pg_offset, cur_len);
> -		unlock_page(page);
> -		put_page(page);
> +		folio_unlock(folio);
> +		folio_put(folio);
>  		index++;
>  		pg_offset = 0;
>  		len -= cur_len;
> -- 
> 2.43.0
> 

