Return-Path: <linux-btrfs+bounces-6097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D8291E1A2
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E77B259C0
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B715EFCA;
	Mon,  1 Jul 2024 13:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="UjAD1MdW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AC15ECE1
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842279; cv=none; b=J6Tzlp0rOmMPGe1Ng3TxE5tp+09fxIL72WGUcoRbVLEyUKVJg8XPUzK42lrnhLaqxrHgYxwysB5Ab4PPJuWKFq5kfFbFM3dv71Tv0/ZfTp1/YiKctOHykLBHcYsnzc/6v/EUQpHK5YQjuhQEyz5qTBjw6P4LwtHfDBWAp94DQfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842279; c=relaxed/simple;
	bh=5bZVvR1vGqe3shQqFbv0+LjthaAxHETmt9AxTBPdfpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WBsFDePAQj21j5XD2xPvnO+g5EemnLS7ygWqh5BaNlQLLixAKvrVJ6dkB9cob9ekJGVj6RZC2fDJ2T20vxI8ffhF+3/3iOyMK64EVg3E2twvr5LEUSJ+PZfFAPC+DgjTrfOsjXxoRqjol3nEbaoXk4wwQMOJy8uTPpOJZYlDUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=UjAD1MdW; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4464b843e37so14693331cf.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jul 2024 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719842277; x=1720447077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rV5U0WPtHYnfXuDBYLc5s4yYVwR6Bdg00UaEphQS7H0=;
        b=UjAD1MdWigMLeu5S6X4hW49fBPPSBYO6wyNP+4Kzajd7fplDBAf54NbCQp9TaVjrU5
         +LIEDLi9dGm90uEKq4i/hd5KsN89n+C8PytW7/S2NqEMotAkORQq10C5rr7VPC9DHNA1
         JHA0VtrHPDhnnOK0V/syrmCVBnBhCmgsHdgmi6FbjZgNNpwgB3eLK5pSlohucEKCrPrf
         OAF5GWERcciTDAljNfrRyq2tFxW0TuUOLu9OFMmkXkH9IzS1+ex5dARfsG4jh2k4EBRt
         VnPnTX61A/3mCxMHbpw4L2Jr3gTWpwATkvxsv6XEZSgNOZ9RPyNp0E3nm0SYXJWk/iZD
         cMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719842277; x=1720447077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rV5U0WPtHYnfXuDBYLc5s4yYVwR6Bdg00UaEphQS7H0=;
        b=LPxllF9pb4d5UO15g0Gc+MFNBdCe7jSZxyRDphaB1rbs+iikhYnKUv9noOhhcK1NbK
         jYYUbinYTHRjEweimjtvOQVSPod+pwEnJFRS0hJ+kEWAl57GmZyiQlHcrDfGXpl2q8qw
         jdPjpC2BIK7IGWrbOE9csm1VcE8rEjsSTwR0FJxay8eVzIgt0ww8Z5SjSbqt1+122x0S
         MtwtIIhznsaubvipaBh9a39VLb1YkU2VY3upSXvQqOlo5epTKYDaYho2q/vmp6LL4kwb
         Bx4t41xFAFJzwjf9lpoXLfX/C9Q/o3175RWIvQeDDkrPcDTpmf2yUt5RIRogVkAPVP5q
         OCKA==
X-Forwarded-Encrypted: i=1; AJvYcCU5tFY1ECIOyx2RuqY2a3vJuNOgWbtNBPUUQPk2gtiUen7mrje/56Me/Uot0CZ8osUSs6MUxlSWvLDPtW/TdnuIx5egcoquf9uPVdE=
X-Gm-Message-State: AOJu0YytNFwjQXk+sp9hqbnjXadljUkhs/FYV6KEACj7AGvLomVyel03
	rnl8Up9hTpV/O38OOVYFgDaxayNCTI3f1BD/VTNhzLB3HaQIZuxvzVnmeh/e+QkCOHX2uMwgvUK
	6
X-Google-Smtp-Source: AGHT+IEIRNK2BKMnKNMbWth0aqtgJwVvYvWXkAcG8gkkqCWr4kUzMCbCtLixRDiZgLrrivOcZAk4Rw==
X-Received: by 2002:a05:622a:11d1:b0:445:3f1:4715 with SMTP id d75a77b69052e-44662debc04mr56963561cf.36.1719842276883;
        Mon, 01 Jul 2024 06:57:56 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-446514b9d41sm31429171cf.88.2024.07.01.06.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 06:57:56 -0700 (PDT)
Date: Mon, 1 Jul 2024 09:57:55 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 1/5] btrfs: replace stripe extents
Message-ID: <20240701135755.GE504479@perftesting>
References: <20240701-b4-rst-updates-v3-0-e0437e1e04a6@kernel.org>
 <20240701-b4-rst-updates-v3-1-e0437e1e04a6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701-b4-rst-updates-v3-1-e0437e1e04a6@kernel.org>

On Mon, Jul 01, 2024 at 12:25:15PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> If we can't insert a stripe extent in the RAID stripe tree, because
> the key that points to the specific position in the stripe tree is
> already existing, we have to remove the item and then replace it by a
> new item.
> 
> This can happen for example on device replace operations.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/raid-stripe-tree.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index e6f7a234b8f6..3020820dd6e2 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -73,6 +73,37 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handle *trans, u64 start, u64 le
>  	return ret;
>  }
>  
> +static int replace_raid_extent_item(struct btrfs_trans_handle *trans,
> +				    struct btrfs_key *key,
> +				    struct btrfs_stripe_extent *stripe_extent,
> +				    const size_t item_size)
> +{
> +	struct btrfs_fs_info *fs_info = trans->fs_info;
> +	struct btrfs_root *stripe_root = fs_info->stripe_root;
> +	struct btrfs_path *path;
> +	int ret;
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret = btrfs_search_slot(trans, stripe_root, key, path, -1, 1);
> +	if (ret)
> +		goto err;

This will leak 1 and we'll get an awkward btrfs_abort_transaction() call.  This
should be

if (ret) {
	ret = (ret == 1) ? -ENOENT : ret;
	goto err;
}

or whatever.  Thanks,

Josef

