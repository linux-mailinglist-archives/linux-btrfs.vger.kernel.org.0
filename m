Return-Path: <linux-btrfs+bounces-3436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB29880404
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 18:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B381F2472B
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F1E2B9D2;
	Tue, 19 Mar 2024 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="eEeZZxLz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D828DD0
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870884; cv=none; b=Jbha1rq6hGXCUrl2CkotpQt2pUj+FZ1iLOwZUE7pV6APw64fd/hDTib5uzrrE/ikzfDNrdFKd5Kj0J43Z+S0E9wJ8nFtOnY5R3PXX6LfzAw4Csv48mSk8WWWmLqEY9l3BYJ2bZB4E/+jf7rTFIznvec3XpHQfunkyDgwnjB9OIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870884; c=relaxed/simple;
	bh=2VxAVuhNh7FTJv09iwofS9003lmE/Lbo8dEd4R2oKvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLLKhSLYPGKtrIeFNRvrNnmGlYxx9L1/5olZPQAw1Gx7adSJ4jOt/XxhJddKO8nSPLG8zw2kawZzLrcpDU/t/YGSNgVvll9n9mLhfZqEFRkYXDZuvVc78BFxXm5cKnY5FGug3BQPuoTBa3W7Q0SArtRL34m/u0EeUkw9IO04yoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=eEeZZxLz; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-78a16114b69so12850885a.0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 10:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1710870882; x=1711475682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7XelpAnpXZSYAyMvD382cEg9etSspU6rGD+gKaQPvU=;
        b=eEeZZxLzxCXdcTDiQNThKBxL0jzuHo4u5YgYyPgc1bX+Rj4R6dXujg1sosKXAFM/W1
         wSIN0YcgLivtZ7rH9wYnUWP2COqLoIdwU7wCLqnYjJTIttTgJhiAtS4dkSCe0gMVtVIG
         FJ5Oh9JIkaTveD5VbmLOq4EU5J8qu0g4ldl22xPWE6uMn9pKWXRRKCObguvZPTdiotOk
         VUt3MiVntAIG+N0K0t7tOn7sz01ZcWfmm6GdpCT9PQzaKMa4M4Jruj0V9g5BxTL0KGO6
         6rKm8jd2f409TFvyz0KOFyLR2Rwg9mJi/KVqw2U1Pk4a5eX0mO43CvcMR+WV5HJu3VS9
         cMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870882; x=1711475682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7XelpAnpXZSYAyMvD382cEg9etSspU6rGD+gKaQPvU=;
        b=jQe2l0aN5bLQBUFMaQ2KN9ojOgrEH+TWZ2C7ngZ1PdnSqrI9qxXnSz/5Bv4fYcUTae
         o96dyFV3zHoOCgIsiTTcjQFJ/oZVK9t3UTQk6k3Rw7qvD66jDtzfhVqoiu1T/31XyfJ6
         mKFn9YthV/yrUIibIuCJCXO2torDBktXoD5sLgzJkuPMMhjb5jsVcqOMlwB5OUBSl1Z7
         Sgg47z/wwJslGwmWdtFKudybkjwafixzrr9ANDij9OMeSm2Rwv7VBFdwtG1hQqulcwM8
         81YIvjnhfm3fZVObDYdsMpTYNX6a+/FzYA9LevK+Cc+fKQ3Nj9UkHDJYFOSaNvh04nUT
         QXkA==
X-Gm-Message-State: AOJu0Ywu+H0o5mp7GLLCDKKfbFKAc/DVU5jQc9nFZcYqMUAmiNdZ714J
	eywZEH/5Se3ViTfnW+vCjDucJioue1PQGWX22430lAesNYf1VNOWCvwx0zLUCtY=
X-Google-Smtp-Source: AGHT+IFoFKGKVrU7s3v1vxB49RJpY2kYvJUIxopuq6dA2/S/yWxgSIDY0uwMfA6kUzalrNQCugaGvA==
X-Received: by 2002:ae9:c20f:0:b0:789:e91a:f1ed with SMTP id j15-20020ae9c20f000000b00789e91af1edmr246289qkg.38.1710870881809;
        Tue, 19 Mar 2024 10:54:41 -0700 (PDT)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id x14-20020ae9e90e000000b00789ea3555acsm3653543qkf.19.2024.03.19.10.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:54:41 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:54:40 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 13/29] btrfs: __btrfs_wait_marked_extents rename werr to
 ret err to ret2
Message-ID: <20240319175440.GD2982591@perftesting>
References: <cover.1710857863.git.anand.jain@oracle.com>
 <2e8fef09405de09488a3dde439d213dee33e117e.1710857863.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e8fef09405de09488a3dde439d213dee33e117e.1710857863.git.anand.jain@oracle.com>

On Tue, Mar 19, 2024 at 08:25:21PM +0530, Anand Jain wrote:
> Rename the function's local variable werr to ret, and err to ret2.
> Also, align these two variable declarations with the other declarations in
> the function for better function space alignment.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/transaction.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 167893457b58..f344f97a6035 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1173,12 +1173,12 @@ int btrfs_write_marked_extents(struct btrfs_fs_info *fs_info,
>  static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
>  				       struct extent_io_tree *dirty_pages)
>  {
> -	int err = 0;
> -	int werr = 0;
>  	struct address_space *mapping = fs_info->btree_inode->i_mapping;
>  	struct extent_state *cached_state = NULL;
>  	u64 start = 0;
>  	u64 end;
> +	int ret = 0;
> +	int ret2 = 0;
>  
>  	while (find_first_extent_bit(dirty_pages, start, &start, &end,
>  				     EXTENT_NEED_WAIT, &cached_state)) {
> @@ -1190,22 +1190,22 @@ static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
>  		 * concurrently - we do it only at transaction commit time when
>  		 * it's safe to do it (through extent_io_tree_release()).
>  		 */
> -		err = clear_extent_bit(dirty_pages, start, end,
> -				       EXTENT_NEED_WAIT, &cached_state);
> -		if (err == -ENOMEM)
> -			err = 0;
> -		if (!err)
> -			err = filemap_fdatawait_range(mapping, start, end);
> -		if (err)
> -			werr = err;
> +		ret2 = clear_extent_bit(dirty_pages, start, end,
> +					EXTENT_NEED_WAIT, &cached_state);
> +		if (ret2 == -ENOMEM)
> +			ret2 = 0;
> +		if (!ret2)
> +			ret2 = filemap_fdatawait_range(mapping, start, end);
> +		if (ret2)
> +			ret = ret2;

Same comment here as the previous one.  In fact now that I think about it I'd
rather you fix this problem first, and then do the cleanup, so we can easily
backport the fix to stable kernels.

Then once you clean everything up you can change this to just use one ret
variable.  Thanks,

Josef

