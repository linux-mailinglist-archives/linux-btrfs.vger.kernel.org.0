Return-Path: <linux-btrfs+bounces-13134-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46090A91CA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 14:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BB55A5458
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Apr 2025 12:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E1B2475E8;
	Thu, 17 Apr 2025 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="x5A4yZzW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C6433A4
	for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744893881; cv=none; b=L++OkUaUYUa8cRjCvpxvkUnTocKvoOMA0MThxeeDakL4I0I6XD8choGhwA7KeIBcMSKtwkQNSfekUx3cSZY6ZfnOnuD01C63rg60ZMBs3tYrpEGhmpjby2a6mC1jL+UlkW0O+wInlgyCfgB7A3ygvYIHYMnQndH/d0PWDzIIjFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744893881; c=relaxed/simple;
	bh=Ijba8Gfh1CAL6jPEaqJi6kcbMtLEyxCUgLGjdNoxc7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5WhKY5JDpX1OuUcyVa0XIW8gNQUhwUbdWJua7EcsBfUatgGuzbXoYedN2zbUK5DGlZzh3r+Oik3+fn89ruOWKEV3v8luTWcdS7BnPq/NTUe+ko139RmcLjXDI7+41SkBU90GZPvcPmkF94hydzH09HJobPIHRYXk04cIQ7cGxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=x5A4yZzW; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70433283ba7so6329547b3.2
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Apr 2025 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1744893879; x=1745498679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H6TCgzGPlIfi2c6d0uorXWCXwamB2BmtIKr1ncgT25U=;
        b=x5A4yZzWGvYQa9HvqAmxpEIi0Mit8WDpYrcFDSUUliUgk4Wrwmrzo4it0m7wNc9Qq/
         TWizT5usZkSXC8LNA75k3wNGHP+BLBThp1bPe55TI1pnxiMLzrY6KG1+r//2+CXeXMoz
         5D5yk/7ag/nDpGmwe3t+XmIqWFexcvyFFprEVsArhl1HuLntqY7NSnWjH3qLZ+flnY71
         c/8cBLjEUfQP6sQMEWUMCMlfHTPCAcEcOLrUqleR0QtOMLz5dVWvXdY9rzdl+OFI9IKb
         1htZDfaa+9h/PzGB6b+GinMcLnzskRhqKkm6ybSFLgZp+QRxR4+E3m1OCCLEbTSC+DnI
         /DxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744893879; x=1745498679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6TCgzGPlIfi2c6d0uorXWCXwamB2BmtIKr1ncgT25U=;
        b=afsoEvlRp57KRkk4mXcXU7Ni8/6wkU8DMowTj/K50YzlJTxmKs7z/4TVvpqE1TgO+g
         OoSLOCi1iv0Kb4GlyKc9qOTBdXk64Ze2rXcIgbR68bisINgQUWkwWotytbw1eekMnLGp
         661DmawXDZok5EhJslmYjcMHY+3GaDUIwZ5XVAT8yu2joYGGIMyJqsCsMpACRPNBwOHF
         +Y0IFnkp/o4qZXLnWehYdTarMyDpH2vB4uHSE8TqkZvsn1QoqQSBhm1VAo1bo/AttzVA
         45uU0BRwb0FT8+d8t112Pbas07mAFK0/dTq6c7KLJ272PxZrAc4JxwsbYu6XtQdiTqA2
         7rVw==
X-Gm-Message-State: AOJu0Yyr/YZWe1RukWGMUJv+xXVqI7aofk+R0hrWUKzUK2ixJMPvHaWL
	43qlvj4hoZQ8GCQwjZB3Ry2LXssIUPUttUe0+TJB0SO6dR1GTlKkXMqeRwQAZOz9CT1m8d0MPJF
	I
X-Gm-Gg: ASbGncsWImNzEljlJRYv7TDPV27DlCK42bJagXUOxyPzfQ6GA7++v6Pkv1gTsqEDEGB
	Y8FUFq2KcLSptV7mYpzmcYs9WjAtKa5mnFpkAHbOZgeb1HS6CsoCLls+IHZFofkY/P+RFeHF34u
	pJq7nnbZ3vM5TW72MRXcRnw8AQQAboLyeImGdKPmgGBrWnzX0d3aCw7TRqEU70g3ie6ccreYCFd
	UHQKQzT6+0KJyLti5JFzWGezE91HP37+F2fV+E4L2yqfmsjRskQipzC8IIJf4zX6BQqDeWocGT2
	kxuEXnz76iWOkN7GPMS2auZ1hByC/cpzlgf+LJGIybdxnpSf+F+z02kH5aHZiQPA+RLLb8EiQP3
	POA==
X-Google-Smtp-Source: AGHT+IEeY6JZ/RL6fQ03sMMPcOGVmaIlin0RTasQdnefvALw9aqTRvUCb/ZoWTR/Xw0uhi/Jc7xDAQ==
X-Received: by 2002:a05:690c:6a11:b0:6fd:318b:9acf with SMTP id 00721157ae682-706b338c5e2mr82787977b3.38.1744893879257;
        Thu, 17 Apr 2025 05:44:39 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7053e0ec54dsm46743167b3.5.2025.04.17.05.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:44:38 -0700 (PDT)
Date: Thu, 17 Apr 2025 08:44:37 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 09/13] btrfs: introduce tree-log sub-space_info
Message-ID: <20250417124437.GD3574107@perftesting>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
 <e5339b5616f1b4b7ee7625f86fa392bc49d2fc0d.1744813603.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5339b5616f1b4b7ee7625f86fa392bc49d2fc0d.1744813603.git.naohiro.aota@wdc.com>

On Wed, Apr 16, 2025 at 11:28:14PM +0900, Naohiro Aota wrote:
> This commit introduces the tree-log sub-space_info, which is sub-space of
> metadata space_info and dedicated for tree-log node allocation.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/space-info.c |  4 ++++
>  fs/btrfs/space-info.h |  1 +
>  fs/btrfs/sysfs.c      | 10 +++++++++-
>  3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 37e55298c082..4b2343a3a009 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -292,6 +292,10 @@ static int create_space_info(struct btrfs_fs_info *info, u64 flags)
>  		if (flags & BTRFS_BLOCK_GROUP_DATA)
>  			ret = create_space_info_sub_group(space_info, flags,
>  							  SUB_GROUP_DATA_RELOC);
> +		else if (flags & BTRFS_BLOCK_GROUP_METADATA)
> +			ret = create_space_info_sub_group(space_info, flags,
> +							  SUB_GROUP_METADATA_TREELOG);
> +
>  		if (ret == -ENOMEM)
>  			return ret;
>  		ASSERT(!ret);
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 64641885babd..1aadf88e5789 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -100,6 +100,7 @@ enum btrfs_flush_state {
>  
>  enum btrfs_space_info_sub_group {
>  	SUB_GROUP_DATA_RELOC = 0,
> +	SUB_GROUP_METADATA_TREELOG = 0,

This will mess up since they have the same value now.  Thanks,

Josef

