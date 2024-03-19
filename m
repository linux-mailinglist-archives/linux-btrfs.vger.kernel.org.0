Return-Path: <linux-btrfs+bounces-3442-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD7E880490
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 19:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55B132845B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D212C6A9;
	Tue, 19 Mar 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="2rk/6KSY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1573D2B9D3
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 18:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872243; cv=none; b=NVO+WgRycWMyEAhOnh7f7+GNVEQPRfLS+BCUOUCMLRrqur4YRBtxPKtxyKAsdAN6pt6BIxoPBb9lVlYZo3OZGyS2RQLZr6SRivQ8q7QZA0FgE3S6W28K+MG70MQljeOsZimLd2/Hz+r6icvC0JltjBZhHO5PM8fo80vi0uZA5cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872243; c=relaxed/simple;
	bh=iL7EgPU4x4tlOH4YymZQidOI98jwelNNQ8bKcW7Oo1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4nXzQK2RbD9Fwuvkkfvi/M7vmFvVQ8kt+lCS2mIAD4dUy2XmqZbrgRfm1JKhnu9jjHv8Jqmslmg9hjkYSc5Og9+Ywx7OGvdvF0UkYC4TYkqsjp4AHMaXu6o9jFp0mgGQAk17bsEr+xCBT9ISGwo2ofMlNA0SbBwBSgbdKxZxIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=2rk/6KSY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690bd329df2so40623066d6.2
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 11:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710872241; x=1711477041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8NwDgKlO8LqLXnS4qXBtuht02N+hON2q8fkR+NxEKmU=;
        b=2rk/6KSY0F2s+xL0vs+SzvvOO0EU5adYJY2mQQSGv0QMaBPocbHC6wNUn2DUxdRw8I
         iWfEvf1XxGOfEImE4E961MrID2aC7pQjrc7BW1bZGxhnr66IrHsUricHs0HWgvRQei2t
         3g3dD2KAqDsMR7dfkfHU/awqOvUFUjA3YPrlARXJSGGTmMHnN6V34ogx75iBDAalQ396
         rVJVmh2N1CoP234wG06ZivfLfM7+eZgypDiQ93CVnf3oiCqF5ZtfkPy5hcnq254xqA5a
         ymEETnJQ/1/2e2/0INYKI/5u5hKm/GSmjg6MyPaVnUheKM5Corrw+n5rKSb0F2YIwCWf
         2waQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872241; x=1711477041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NwDgKlO8LqLXnS4qXBtuht02N+hON2q8fkR+NxEKmU=;
        b=qUX0qFwB+3vCu356UlkXOBOYNwseur7kWMRJ4TO6Kh87zT0dB9FTdIsKkC9HfMFxKl
         xf37Dm934VM5j0hNR0c6WKFxsB+e5HE3XhfvREK1DvPifNX2ddk0c4TRBPKy7IAKwnmu
         h7tZTGd+Jg2pFAy8uVhtZ7sxZmoSkwWZ7Qm/rrmXbewJtMjMLE1/kGu8stul81KxnIlT
         I541T8gGg3gIdArKR4PpTpzTs7/Ry/s6176EN9wOBNw9STzN5//9IfvHcnN/b9EH/qDP
         lnAROSvaTGWYn9A0CLX7B+NyN3R4qXU1EQHT0giBZRaz5JIGBV9mW0jm8vGbCFULcqre
         q6jA==
X-Gm-Message-State: AOJu0YzbJbaIBNASwR3RZVArZ0M7Bs9YqGUXyF9LOrRpRpSEyvWch9iw
	d1Rp1fjazHqSArOaGRg4jUnyjaRV/ddymP5hfCCwoqaUQdY/IjskdqhE/orDoas=
X-Google-Smtp-Source: AGHT+IH4J1Th8efzq53jvQSMMyUYJamRhv/u1Sw/ne6WUHahw+9huNLPbzsOYfp4427057o5qO8Tjw==
X-Received: by 2002:a05:6214:1e1:b0:696:3375:bb2c with SMTP id c1-20020a05621401e100b006963375bb2cmr3652478qvu.25.1710872241070;
        Tue, 19 Mar 2024 11:17:21 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id a9-20020ad45c49000000b0068fef1264f6sm6679413qva.101.2024.03.19.11.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:17:20 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:17:20 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 23/29] btrfs: lookup_extent_data_ref rename ret to ret2
 and err to ret
Message-ID: <20240319181720.GJ2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <3dacbcffa8d7c4e70e934b8b977676a1072878f4.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dacbcffa8d7c4e70e934b8b977676a1072878f4.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:31PM +0530, Anand Jain wrote:
> First, rename ret to ret2, compile, and then rename err to 'ret',
> to ensure that no original ret remains as the new ret.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/extent-tree.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 1a1191efe59e..4b0a55e66a55 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -448,9 +448,9 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
>  	struct btrfs_extent_data_ref *ref;
>  	struct extent_buffer *leaf;
>  	u32 nritems;
> -	int ret;
> +	int ret2;
>  	int recow;
> -	int err = -ENOENT;
> +	int ret = -ENOENT;
>  
>  	key.objectid = bytenr;
>  	if (parent) {
> @@ -463,14 +463,14 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
>  	}
>  again:
>  	recow = 0;
> -	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
> -	if (ret < 0) {
> -		err = ret;
> +	ret2 = btrfs_search_slot(trans, root, &key, path, -1, 1);
> +	if (ret2 < 0) {
> +		ret = ret2;
>  		goto fail;
>  	}
>  
>  	if (parent) {
> -		if (!ret)
> +		if (!ret2)
>  			return 0;

You don't need ret2, you can just rework this to

if (parent) {
	if (ret)
		return -ENOENT;
	return 0;
}

>  		goto fail;
>  	}
> @@ -479,10 +479,10 @@ static noinline int lookup_extent_data_ref(struct btrfs_trans_handle *trans,
>  	nritems = btrfs_header_nritems(leaf);
>  	while (1) {
>  		if (path->slots[0] >= nritems) {
> -			ret = btrfs_next_leaf(root, path);
> -			if (ret < 0)
> -				err = ret;
> -			if (ret)
> +			ret2 = btrfs_next_leaf(root, path);
> +			if (ret2 < 0)
> +				ret = ret2;
> +			if (ret2)
>  				goto fail;

Just rework this to

ret = btrfs_next_leaf(root, path);
if (ret) {
	if (ret > 1)
		return -ENOENT;
	return ret;
}

Thanks,

Josef	

