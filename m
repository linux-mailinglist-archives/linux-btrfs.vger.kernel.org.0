Return-Path: <linux-btrfs+bounces-19165-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A66A6C71686
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 00:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 668C54E43B3
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 23:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342FE329C57;
	Wed, 19 Nov 2025 23:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="eprTYM9B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1oKcb43X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA460290D81
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763593295; cv=none; b=EBwBf9xpjwG/cNcjj9apvA/aQRsHTzVOV1FxFbY+nZsXi6NmEm/Bu/tE/cup+BCG8LcjTNAvV/le3CdSVh5qJ3ecfK404IQovaTBzpFGFTn6fp2rTWcZCBV3YUK821rnyeqYKSTNjpEpZ6nwEBi4UF/zPqyRmM40ZftOee8vuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763593295; c=relaxed/simple;
	bh=3PKfofcztjDO93zNxiwWRiJ8ifO5pCA8croWBHFaH44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlgP5wl3uA29CKXZv7GiH8tB7FAW5ApmJR3gOEd1YdNbsH9cTO0hjHSUBNQXf/XHIABQF7C3dTpPhb5d9N8DmRlmYN32uf73cj+OS933T0T+eZcDd8yqhnd/4jTGD8zbRZgWMFDwftNqU/0n5pBk37vIBR4Bzs+6M1/DzhfxyiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=eprTYM9B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1oKcb43X; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9F92114001DB;
	Wed, 19 Nov 2025 18:01:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 18:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1763593291; x=1763679691; bh=ofuBbfwSS+
	zQTp9CliJhDz2DeVkFaYIBiXzzaAAN6wg=; b=eprTYM9BdeDIAjjRp6jF8erqEt
	lbnD7TH7TpgKSnXwZsJR18bkD9eqvuEjiMEZ/NrJkwsvvOsOd8RAiJlLeKBu7F1B
	YMUM7qHnnMK8OwIbb0hWAf4ptbQIQK8ok1EbpmQX86+NzR09qEkGdzivLiLfB1aN
	3IAk9B8cVUFWi9zQcohlz52MdBpGFQ8adi8VcHnzxIOFsELX+sHWRdpK97KWSDnl
	DRDwsLnDVY0Th0Q7OVXvMS9AbE+B7Hs8yRcIIzP3jFnu92iZe1R/13SwNfUsALol
	ob9ABw+Bytg5t6WWLXj/SPw81tUOe151LuSFqFB2ZhxIOJ1cKKVnV8eCVwdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763593291; x=1763679691; bh=ofuBbfwSS+zQTp9CliJhDz2DeVkFaYIBiXz
	zaAAN6wg=; b=1oKcb43X153+cWsEPid+fUfj94leKcdVCaC6+R2jsXoOZIxtrrt
	WujPVnRX3CSbQ1FaXFoDWU6yYjHU6bmez7tJjyDKU7NxY1V/8fz9OhA+aE3ZwI93
	6fQL8djfLA7PAAbMGirIa7jXb8XtbirV28hJcDf4FW8B0685G0FTGx+osMRJ36nw
	u2OD9DJBIHYhhtAXIO5CfVWfflllf4epO6MQkQ5C4BpR+u7b8yPcIgIH5ljwmBxE
	zrT0fXCtvmWC19reAkqo4Y8sGUFF7a629FMeu7Tolq23HSdExLKBRyEsTduy7zOw
	EjWmWkR9PWc1VMb+6l+iujr43Jl4MVQ6ijw==
X-ME-Sender: <xms:S0weaWDoijaCYHBwOR2q0_zxE5CkwI48kwBKtgc2R8yaACZOMi-4OA>
    <xme:S0weaWjQ_laQZ6R33Pyp5odIrZRf-ZZTenRKW21NGctV3JUdlhZ7rCsx4YsUibEJf
    W3Lk_1yV46iiOabgg4rT9aCsSra5wLL8CaK-G2jmEGdP64zoxcjIls>
X-ME-Received: <xmr:S0weaXMi5X3PP1RSW5S1XcW6R5Km-w3f72eWbAKDVpUIQkf8E6A6ED6bYVgynL3ZokFYykxIujdNKSqw96_nlKcZNjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhrihhsuceuuhhrkhhovhcuoegsohhrihhssegsuhhrrdhi
    oheqnecuggftrfgrthhtvghrnhepkedvkeffjeellefhveehvdejudfhjedthfdvveeiie
    eiudfguefgtdejgfefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghorhhishessghurhdrihhopdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehfughmrghnrghnrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqsghtrhhfshesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:S0weaf5FYRslbBbJyYT9uRUM5_88gTLLZio3RXuhTClCmxYqkBFkjw>
    <xmx:S0wead1-O8ETtbXT0QpBNDc8zX_nEJXG4n6lhak6QRn_zf5IkjxDig>
    <xmx:S0weaYZ9o_FM1E4rHdqxyDxZTo6K1JnjR6Ec23Qlir6kqTiL2BwqUw>
    <xmx:S0weadCIf4ykiTYh5wxRoAtzHq6-w5OT7fLV-d--zDQlHV4q4SxDlg>
    <xmx:S0weae2dga0aU_lCJKXPWJxJIpT_NzzjT6hGAE8qVsThKcuxV9CqvZCy>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 18:01:30 -0500 (EST)
Date: Wed, 19 Nov 2025 15:00:46 -0800
From: Boris Burkov <boris@bur.io>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: send: do not allocate memory for xattr data when
 checking it exists
Message-ID: <20251119230008.GA2475306@zen.localdomain>
References: <d95e088ffbc10bc6b5db30846e31970e347b0a3a.1763575479.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95e088ffbc10bc6b5db30846e31970e347b0a3a.1763575479.git.fdmanana@suse.com>

On Wed, Nov 19, 2025 at 06:09:23PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When checking if xattrs were deleted we don't care about their data, but
> we are allocating memory for the data and copying it, which only wastes
> time and can result in an unncessary error in case the allocation fails.
> So stop allocating memory and copying data by making find_xattr() and
> __find_xattr() skip those steps if the given data buffer is NULL.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/send.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index ebb5a74500f4..806cc4ba9dc4 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -4943,6 +4943,7 @@ struct find_xattr_ctx {
>  	int found_idx;
>  	char *found_data;
>  	int found_data_len;
> +	bool copy_data;
>  };
>  
>  static int __find_xattr(int num, struct btrfs_key *di_key, const char *name,
> @@ -4954,9 +4955,11 @@ static int __find_xattr(int num, struct btrfs_key *di_key, const char *name,
>  	    strncmp(name, ctx->name, name_len) == 0) {
>  		ctx->found_idx = num;
>  		ctx->found_data_len = data_len;
> -		ctx->found_data = kmemdup(data, data_len, GFP_KERNEL);
> -		if (!ctx->found_data)
> -			return -ENOMEM;
> +		if (ctx->copy_data) {
> +			ctx->found_data = kmemdup(data, data_len, GFP_KERNEL);
> +			if (!ctx->found_data)
> +				return -ENOMEM;
> +		}
>  		return 1;
>  	}
>  	return 0;
> @@ -4976,6 +4979,7 @@ static int find_xattr(struct btrfs_root *root,
>  	ctx.found_idx = -1;
>  	ctx.found_data = NULL;
>  	ctx.found_data_len = 0;
> +	ctx.copy_data = (data != NULL);
>  
>  	ret = iterate_dir_item(root, path, __find_xattr, &ctx);
>  	if (ret < 0)
> @@ -4987,7 +4991,7 @@ static int find_xattr(struct btrfs_root *root,
>  		*data = ctx.found_data;
>  		*data_len = ctx.found_data_len;
>  	} else {
> -		kfree(ctx.found_data);
> +		ASSERT(ctx.found_data == NULL);
>  	}
>  	return ctx.found_idx;
>  }
> -- 
> 2.47.2
> 

