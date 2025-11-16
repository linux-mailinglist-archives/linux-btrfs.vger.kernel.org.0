Return-Path: <linux-btrfs+bounces-19036-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7748C611BE
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Nov 2025 09:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7E694E0640
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Nov 2025 08:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11A9285CA4;
	Sun, 16 Nov 2025 08:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="LAFpYxoi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C782641CA
	for <linux-btrfs@vger.kernel.org>; Sun, 16 Nov 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763281397; cv=none; b=RgzWbO6M1G8sgcvxY19ocVsMYWpsMukEje0YaxmLni4RraYEeAHxez0K8SXAO8ULzZ0RRAccNAmv7PDIIveGIK0AYCEAq5EpeHtjxg7iO0Zc9YQbEGiVC5yfete4SMH0/ZZTgDSknyzXQtSsPjHQJYL+/mtsTM8G4fpw5icOaqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763281397; c=relaxed/simple;
	bh=C+JcvFRwZHyavGe7kxRswHzD35IQVhdGIfMoOL9ybQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M80tEjPWyAzLDfKD87TY/VrdUrIegBdl9i++rWvH0qkKAwBmalxW6dSl9dzCWU7z+qvSip6iOyb6YVZy27Xn6mSHOvs3lyaIYNhRHaxYF5sZJbYgiUDmdJJU9uZFBYFoUMOVM5yyLAezvtMaCw8U0EbzpjFwsl/B5rUbyN9QmhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=LAFpYxoi; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e982506fso39638385ad.2
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Nov 2025 00:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1763281395; x=1763886195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M4MaMBAoduJmljAfpOLsOwZXGopJOVWqjmgthPn26W4=;
        b=LAFpYxoiJGcYCTAW2kOg1UFBq9oMMmEaBg4IvoS0x3oCTo4DCvJt3kTJIKB0DB5SL7
         NJDSdSfhSUy6img3FIkk9DZo93wSfy/IQfxyXAy6nDow269dr8fz2JWVYR2FIsFXjAQ0
         6SHD9N2jFT5ezuoq/DJaH6tv4TwQfB25O47G/5O+HEeM/r7mF4AIebekDNxdrWcmQ39u
         NVZ9AS0QiPWLnpgRmkIicMuRk263e5xdrNFcBbAuXJO5c1Qv8Kr2mRr+4x0u/bfpWq65
         Td07/17O4ZU71mQrPJ/qJtNKqi/9DqB5XVUZhh78859hNaw+PP8r8dqXyw4pnhkA0gvB
         IvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763281395; x=1763886195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M4MaMBAoduJmljAfpOLsOwZXGopJOVWqjmgthPn26W4=;
        b=KtQmCJHiRx1OaWHy5BPqiI1eUKCLq/CPiVTha8D6J5CcVnXIsBGSqhydnQJ7n4OFHs
         GNBdaIPAxb4iC+oa5TDLg9FQ5qbhP+ifPY+6hHqviaeF9nn7ZZvkF9yhRGm98wQhrcCI
         aryXAysaBGESKgugbUNFdF6OkgPFBS4CdQJpfwfZ0YvJeDU+TsSpmN4mGZMqbP/wzDGM
         iSrqhHynscJA4oCxm4WSCrxDh67RwI7HeOL0MwRvwkyHbSVM/lbaYXgkvcVSokpGXYD5
         9XsTCI5jG40yl24qTrZR/TIMGUBxffw+M4h8XWzAa79NR/qZ7EEQ3Y6pQcmMPITEWDY1
         2DcA==
X-Forwarded-Encrypted: i=1; AJvYcCXgmiaP3WV7HSNtpohq50kGDdQmDbhvWAXN8CRtq7HRgrTvXbmD8+jjgTZzZPY7rQrq4idFXPrxE6ZIVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEgwCYp9dmbjEQT7wwJAnWOYFGaOmhnHC+1jNAQyumXPCldKT8
	fD2O9/8Y+02aLHXkZukVLjB+Dm5MJUcefTa+1edLZD/llLR/+Y3EO6f3GiLaT3ZFrZU=
X-Gm-Gg: ASbGncsJ6AizJzQGVAphur2EmZNlixhj5BQjsF1/u61US/pBRh6ribYl7hr5Krmgv2H
	nuQhLQP6Q7QPDBTrFKbD6NCxNTI/fYpat2SL+4WXKKaq5mq3NcSpFPqHodLTjXj/4PgAQjHaQZR
	rwYSmJ6u2R59R/OEpZf6oVYtnMCh6qzeWJClvFabjMetIKTDKlwetu3z8kaTNRywsFs/+Ie6pu9
	ubl2KcvVb94/yeAk5ky8V9oXE1eM3hiGP+K3YZ5e/EQ2l9QzGG3i2Y+ZN5tBrVkgfNleqUIP/lJ
	eQm/fyvlUhVRPpn9WndSS+4hOa8LDSVD80t7+mkpEEfCzleqcMYepnMz26sHfxmigHyOqqPuAoh
	SqscKjCCvPe7RdxSDkWCRem6BJ29iUab2VrjAFdXx4SLL8e4wGpVHdhze0jFQ1pwB9vrKUrnD9+
	BPqJSl3v8uL95v/2IPURaw4fy5SAGAkBL19GPQd0sxGBoqkEmoRaCDP8k3GthfFA==
X-Google-Smtp-Source: AGHT+IE2kISBEpmbZV/bnZzdrwmOacrEejG6ljtHkn9ZRcGe++TC5tzXGzGVsKaVV/gcvGARY/ZhHw==
X-Received: by 2002:a17:903:41ca:b0:294:ec7d:969c with SMTP id d9443c01a7336-2986a769988mr112616935ad.49.1763281394800;
        Sun, 16 Nov 2025 00:23:14 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29864b00fc9sm79958015ad.40.2025.11.16.00.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 00:23:14 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vKY2R-0000000BUhZ-3a27;
	Sun, 16 Nov 2025 19:23:11 +1100
Date: Sun, 16 Nov 2025 19:23:11 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
	Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
	Martin Brandenburg <martin@omnibond.com>,
	Carlos Maiolino <cem@kernel.org>, Stefan Roesch <shr@fb.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	linux-btrfs@vger.kernel.org, gfs2@lists.linux.dev,
	io-uring@vger.kernel.org, devel@lists.orangefs.org,
	linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 14/14] xfs: enable non-blocking timestamp updates
Message-ID: <aRmJ728evgFnBLhn@dread.disaster.area>
References: <20251114062642.1524837-1-hch@lst.de>
 <20251114062642.1524837-15-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114062642.1524837-15-hch@lst.de>

On Fri, Nov 14, 2025 at 07:26:17AM +0100, Christoph Hellwig wrote:
> The lazytime path using generic_update_time can never block in XFS
> because there is no ->dirty_inode method that could block.  Allow
> non-blocking timestamp updates for this case.
> 
> Fixes: 66fa3cedf16a ("fs: Add async write file modification handling.")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/xfs/xfs_iops.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index bd0b7e81f6ab..3d7b89ffacde 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1195,9 +1195,6 @@ xfs_vn_update_time(
>  
>  	trace_xfs_update_time(ip);
>  
> -	if (flags & S_NOWAIT)
> -		return -EAGAIN;
> -
>  	if (inode->i_sb->s_flags & SB_LAZYTIME) {
>  		if (!((flags & S_VERSION) &&
>  		      inode_maybe_inc_iversion(inode, false)))
> @@ -1207,6 +1204,9 @@ xfs_vn_update_time(
>  		log_flags |= XFS_ILOG_CORE;
>  	}
>  
> +	if (flags & S_NOWAIT)
> +		return -EAGAIN;
> +
>  	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_fsyncts, 0, 0, 0, &tp);
>  	if (error)
>  		return error;

Not sure this is correct - this can now bump iversion and then
return -EAGAIN. That means S_VERSION likely won't be set on the
retry, and we'll go straight through the non-blocking path to
generic_update_time() and skip logging the iversion update....

-Dave.
-- 
Dave Chinner
david@fromorbit.com

