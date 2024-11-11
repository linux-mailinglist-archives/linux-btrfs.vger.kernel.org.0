Return-Path: <linux-btrfs+bounces-9422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC169C3B6E
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 10:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E5501C2239D
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Nov 2024 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE3016A930;
	Mon, 11 Nov 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6AEULeF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F9814600D
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Nov 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319007; cv=none; b=EM74E0AoS01gUlxWJcE92TfK4OVpYlvtSN2aLYIjabChFnSubSvqN4JIabQtDfoL3T2w3cbqkWEXsExGFMLV7IQGxhhplQR/sOIVrhVulU5Rrzy2NZjj5OhUVQbscffFST5ZDHvH+8JJh6KdwPoSjHvnm/8P8NMjM3nqtxH1b98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319007; c=relaxed/simple;
	bh=nAQyGB2nPfIbrIdlD6OnM3965fhO3gaMv24kJsHRyrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ty/eWRh7nx0MQsJXyGPZmW2Yt41qutmdQkQWYez6WZN/XNgFc18GwSVfr6hoLhv63DQ/DwtC2Mwh4IwgcGv9QzUqoBK2n25gy3zXHOfUjMzECWbHNnU9xMoomv6ER1/aj8FHr893Lif6wNLTOfbBqNPwxiwYFix8BzJhIyRYpJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6AEULeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EA0C4CED0;
	Mon, 11 Nov 2024 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731319006;
	bh=nAQyGB2nPfIbrIdlD6OnM3965fhO3gaMv24kJsHRyrM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d6AEULeFHsCTUxJ6O7M+f7o9gq4dUhzdcbp+3wgc/yu6NfPYUulAxxqsl5ldQDO1L
	 GJ2l5oUac4bp1GYqvnhdISP8bu7ur6D+f1aDmhPj61kcxugauLCJmT4TVqw+IXMqTl
	 uD48bpSUMgMwIDU3S2HIIMBYxngkSU0tyUV2o2A58rg7qV9rbT6InHfMCfyYcnZFwF
	 UQY9LqJiOj3+Qg9iCw6UeiOsXYQB9Bcge31FnSfK0bPqC441HZSaKL0IWy4UoiM+1M
	 0nuNH/8rNd2b4SM3Uu2y0yYw4wKGmRkOSe5MqVgFFL3e767XkjMBT2/OThxZTsRmyM
	 x3SaRlO9sGKbQ==
Message-ID: <61b214b6-6036-4afd-b3fa-4506567f066f@kernel.org>
Date: Mon, 11 Nov 2024 18:56:44 +0900
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: simplify waiting for encoded read endios
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Mark Harmstone <maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
References: <cover.1731316882.git.jth@kernel.org>
 <22c7231a2ce9c0c7c187dff159be1c868d783765.1731316882.git.jth@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <22c7231a2ce9c0c7c187dff159be1c868d783765.1731316882.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/24 18:28, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Simplifiy the I/O completion path for encoded reads by using a
> completion instead of a wait_queue.
> 
> Furthermore skip taking an extra reference that is instantly
> dropped anyways.
> 
> Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/inode.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cb8b23a3e56b..916c9d7ca112 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9068,7 +9068,7 @@ static ssize_t btrfs_encoded_read_inline(
>  }
>  
>  struct btrfs_encoded_read_private {
> -	wait_queue_head_t wait;
> +	struct completion done;
>  	void *uring_ctx;
>  	atomic_t pending;
>  	blk_status_t status;
> @@ -9097,7 +9097,7 @@ static void btrfs_encoded_read_endio(struct btrfs_bio *bbio)
>  			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
>  			kfree(priv);
>  		} else {
> -			wake_up(&priv->wait);
> +			complete(&priv->done);
>  		}
>  	}
>  }
> @@ -9116,7 +9116,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>  	if (!priv)
>  		return -ENOMEM;
>  
> -	init_waitqueue_head(&priv->wait);
> +	init_completion(&priv->done);
>  	atomic_set(&priv->pending, 1);
>  	priv->status = 0;
>  	priv->uring_ctx = uring_ctx;
> @@ -9145,11 +9145,10 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>  		disk_io_size -= bytes;
>  	} while (disk_io_size);
>  
> -	atomic_inc(&priv->pending);
>  	btrfs_submit_bbio(bbio, 0);
>  
>  	if (uring_ctx) {
> -		if (atomic_dec_return(&priv->pending) == 0) {
> +		if (atomic_read(&priv->pending) == 0) {

This does not look right... Testing this essentially means that you are doing
wait_for_completion(). So I would move this hunk after the call for
wait_for_completion(). That will also allow avoiding duplicating the cleanup
path getting ret and doing the kfree(priv).

>  			ret = blk_status_to_errno(READ_ONCE(priv->status));
>  			btrfs_uring_read_extent_endio(uring_ctx, ret);
>  			kfree(priv);
> @@ -9158,8 +9157,7 @@ int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,
>  
>  		return -EIOCBQUEUED;
>  	} else {
> -		if (atomic_dec_return(&priv->pending) != 0)
> -			io_wait_event(priv->wait, !atomic_read(&priv->pending));
> +		wait_for_completion(&priv->done);
>  		/* See btrfs_encoded_read_endio() for ordering. */
>  		ret = blk_status_to_errno(READ_ONCE(priv->status));
>  		kfree(priv);


-- 
Damien Le Moal
Western Digital Research

