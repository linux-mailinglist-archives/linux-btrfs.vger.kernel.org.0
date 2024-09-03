Return-Path: <linux-btrfs+bounces-7788-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1692969A5A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 860C61F23BCF
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 10:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BD1B985C;
	Tue,  3 Sep 2024 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ny9UNNzp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655101B9850;
	Tue,  3 Sep 2024 10:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725359957; cv=none; b=ZH4Y4v9CNemVwp1ZqZPkzUloW1CeRsLK2xLgT3Gtpj4memf7ZDJpuc7cjLZ1ZFzA9gHaTTkXkw/No85s2PEH6i+1HEuhNYtZIa6HhLKAOP+DJ01AJIP89UVD3zEx+jDs4vfbe0OSd2QRSyG7toHsRAFltZkZN5cq5qeFXnCJRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725359957; c=relaxed/simple;
	bh=x9VR8yJKbpFlJ9ULZWhO2nDLSKG8nCREG0OWxhGouxU=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYjsxslVPVhqxiR8hYVHNzq+U7fr9lQCg+5zTzIOs/2jHH3/rkEbXYGXft21z/bZEG74Yr56bF47ruyqz0zOV7mQXvGQYw0HjvNzj9Wk4aNxnLhkuZjBslW4oI8Trl6KSbyRDZGDuBVay4VpNl5dULYkZS3D+oyvqBxg/2PPjpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ny9UNNzp; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5334a8a1af7so5525651e87.2;
        Tue, 03 Sep 2024 03:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725359953; x=1725964753; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F/QXg6hFQdGDiK+u7axMDheJkaPRg6gOiLwD/Eu5ECw=;
        b=Ny9UNNzpSNB1Ri2WKmfEkpTAjCCndF9C9vkrmvVxCjAHzyJA8tu/zgdUAr4ayGG6jC
         y2X+3I9O+6sv4XqAiL5SLtoFcgbv0RlJmKiApWO3bPNCUMEbrb39Gh9JF34Wj9loNebl
         iWj+wdfFXob6J48t1DDnh+VFjasH7YDlRr+yg6KpXYTi1+xoSaiEo+RBfY9njgj1P+oX
         iR2Aii4woDCX+AR+KoJGB8tWNzCFkwuzBQNy9pCeAmNir20SrkxXLe3jVmDOAK6vSJOD
         vvtHxmneoS+Q7HUA6gEHca8iN+dxAsCYKYaPnhLXLSarsieTWxJ/RHF2ufKvycPed9n7
         nM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725359953; x=1725964753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/QXg6hFQdGDiK+u7axMDheJkaPRg6gOiLwD/Eu5ECw=;
        b=cMX7dx+QrlyjVSAlb0d2N+bwq4qM1CCb9jRAC+S43eSTVQlwWZPAssEMtSAlKwqryA
         3FLS1fQxkGSVtOSrqyISIp0jvMFmQPm5kB7fgtWND/nt5l66u0J+6eCf9YW9XJfcQ3rb
         +NEOLOC7hJvgR79px1BDsajcMhPKIhP48qKwTOwWkujcQkf2WpLFcJUGOyfLb3cduupa
         J4iSK51UAy6fh+e+YnaesuOLB3BeUXeFILyeWSWpN+db7B29IjoRrSs30vWS2Puu6s6W
         NqTfCw1Lqi1Zgw/rBMSNpLNfQWkVxp0GW0ApR7/oKx2/UEmBLZaoZOHpmMvPQFchteh8
         wr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUN/Fdc3uQIn/lLGjn5Or+c83l3tGixT6+PSwdypadffN70S8ktnWbY/ElOYoqfLFT9DKJgRbvmo0kqUA==@vger.kernel.org, AJvYcCVB4DBFOCCleLwUKcmtNENjRaulSTvG3Bm2oMwrHFONI97eWgtKipKJonIbZ9rcYwHtyrNuBSdtYAA8iANC@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ/ne2j4SP2ZD34k7EyomtMg6SKkn2Rhe98Y1J8AoaxqPraGw7
	wmN6a8aRTSvPnDYjXOo3gEsp8ky00qYnRut6KGNY3ZN1e7qV39VVMIlLuK4f
X-Google-Smtp-Source: AGHT+IFfDSIgGycFkDwfEkQ/yD94GBs9dZ4GvnjIVsl1C8IImbbjE/sR8SX0srkysrkWbt4kcpFqkQ==
X-Received: by 2002:a05:6512:1393:b0:52d:b150:b9b3 with SMTP id 2adb3069b0e04-53546b34943mr7692852e87.32.1725359952885;
        Tue, 03 Sep 2024 03:39:12 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e274c1sm166861645e9.36.2024.09.03.03.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 03:39:12 -0700 (PDT)
Message-ID: <f19308b7-9613-4b58-a4ff-edc66c964687@gmail.com>
Date: Tue, 3 Sep 2024 12:39:11 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] btrfs: Split remaining space to discard in chunks
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240903071625.957275-1-luca.stefani.ge1@gmail.com>
 <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <20240903071625.957275-3-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/09/24 09:16, Luca Stefani wrote:
> Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
> mostly empty although we will do the split according to our super block
> locations, the last super block ends at 256G, we can submit a huge
> discard for the range [256G, 8T), causing a super large delay.
> 
> We now split the space left to discard based the block discard limit
> in preparation of introduction of cancellation signals handling.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219180
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
>   fs/btrfs/extent-tree.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index a5966324607d..9c1ddf13659e 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1301,12 +1301,26 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>   	}
>   
>   	if (bytes_left) {
> -		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> -					   bytes_left >> SECTOR_SHIFT,
> -					   GFP_NOFS);
> -		if (!ret)
> -			*discarded_bytes += bytes_left;
I removed this by mistake, will be re-added.
> +		u64 bytes_to_discard;
> +		struct bio *bio = NULL;
> +		sector_t sector = start >> SECTOR_SHIFT;
> +		sector_t nr_sects = bytes_left >> SECTOR_SHIFT;
> +
> +		while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
> +				GFP_NOFS))) {
> +			ret = submit_bio_wait(bio);
> +			bio_put(bio);
> +
> +			if (!ret)
> +				bytes_to_discard = bio->bi_iter.bi_size;
> +			else if (ret != -EOPNOTSUPP)
> +				return ret;
I think I got the logic wrong, we probably want to `continue` in case 
ret is set, but it's not -EOPNOTSUPP, otherwise bytes_to_discard might 
be left uninitialized.
bio->bi_iter.bi_size can be used directly for all those cases, so I'll 
remove bytes_to_discard as a whole.
> +
> +			start += bytes_to_discard;
> +			bytes_left -= bytes_to_discard;
> +		}
>   	}
> +
>   	return ret;
>   }
>   

I'll fix those up for v4, but I'll wait for more comments before doing so.

