Return-Path: <linux-btrfs+bounces-7752-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2829968FCD
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2024 00:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADF02877EC
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1598E188CA7;
	Mon,  2 Sep 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GxoZZA4l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22BC188A10
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725316288; cv=none; b=P3S9whNtPY7yyI5PL0QemXafA6u3vvuOHoLrU63s9iwINSoCG3dnLK8Nxnn9IzjjLW2xvqOYue1pWme+d4AcQnt3dZqzkLwgXcsbb28m+P8emt6shJ/i4UYhJMbjMAOMmLzG5FugP255WWrSu6fzeUmoGm9yMIs2JbJ4xJv46Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725316288; c=relaxed/simple;
	bh=gACfPgdCHzcb5wgAoTbD8VXUJG+MYS8m+u5sNYQue4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+tr4hCsG6epyCmT82iGa2Ff0J2naYCC6fkoQzCDQvccq94+TxPQbwaSSJzzejemDJV6sOnsLfYYDL7j0uZqyzJ4KeN+ocflc7U6UuVGXn0H1fyPAIfRyunlTkr2DGyT/12dTkKJZyGLBFo37O7R8jU0j4PWodEmI+INNPFZB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GxoZZA4l; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367990aaef3so2777901f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725316283; x=1725921083; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KT8MqKcN3KBWWxZdQ45vKQz3usE4zDGsB9SWcmHk2Ds=;
        b=GxoZZA4l+cvdn2Hr3zyqqBJx5Ym34hFRU4G3e79PMewAIbWj4L/yYuNqEVyuKm/wGR
         L5Q3U8MKpHAsPoouj3IonbKgqEJ9udFbG11i4LRvRD9sbBWtAwoQ6eHpEqWOKwkfdjmZ
         T6Bn9defxqiZIbqq3WbRoFM3cwLUceAQb8spt/9fUYaKdKXy9kbtGl2cDaqUaslp0Kzi
         +dm0KhQIMXJ1URLAxlvoD7COj2QQvEo7e5Pic2rHvnwP6iBec2Fm01Di5TwSZlFx5Hmz
         O492MFLLzT8MJ28Ld1MgeuWhOoHKYZwHUQrD4GSV4jFJgxfsl8mgR/BD2djpLshZgGmS
         59MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725316283; x=1725921083;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KT8MqKcN3KBWWxZdQ45vKQz3usE4zDGsB9SWcmHk2Ds=;
        b=lcpl96j4Q6eIKeoUA8EjsZw2YZPkp2hCRyObuWO7JmDF6R40jz9bVQtuBdujrMhg1B
         kCKDyHHCSG0Zg+84BYMAMdFTC/6ByW5/RJuQKKem1Zy5DicsKU9RQRWH6+RlHeUK4LLA
         Nfd9Ygd/StfZ5pMDwU17DnzrcfakcAsJzu6lJgWsUEBwYnS/AZYYhI+dm28xMLcrfjpk
         rQjMI14J7PH6DbC2ZeYiNtiAiY4r26BC08dhIv0DlH5kTMQITmxwYGgSGen2TDI5nAGR
         8r5ZbgrBsGl2ZBmUvbuqA8Lk8kvw6swVsR/cRedvkOGKiAvFDEbD+vLwAVqh2Dv5fgKe
         Ekbg==
X-Forwarded-Encrypted: i=1; AJvYcCXXjiIYQS+U46V/GelMdyxuoVf83ukhG+4JKfdKnmPD2QlvCDcDYGfcyEseCo92sCqj9QQltO8WJ7c4MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY39ThAhbpKO2gWG2HGI6uRpPNSrVEVHnfedWfGCqIfjooxUPV
	B3Wyvj7tsjYqhP7gDePmOTT9Smis6LZ+73y8M+z0Zh/Xjf0xrSr/QXJoBqOnvGY=
X-Google-Smtp-Source: AGHT+IGNEuJsJ80msoABFskGadaC48KSnEDxca7sn4c+6mivo0yb/Bi1Agkt8tdMRMKUtw1J5nOcQg==
X-Received: by 2002:a05:6000:18a1:b0:374:cd36:8533 with SMTP id ffacd0b85a97d-374cd368862mr3622431f8f.54.1725316282698;
        Mon, 02 Sep 2024 15:31:22 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576a37sm7324104b3a.29.2024.09.02.15.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 15:31:22 -0700 (PDT)
Message-ID: <c5aa26ad-4ae7-4498-8a27-118876181890@suse.com>
Date: Tue, 3 Sep 2024 08:01:16 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] btrfs: Split remaining space to discard in chunks
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-btrfs@vger.kernel.org
References: <20240902205828.943155-1-luca.stefani.ge1@gmail.com>
 <20240902205828.943155-3-luca.stefani.ge1@gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20240902205828.943155-3-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/3 06:26, Luca Stefani 写道:
> Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
> mostly empty although we will do the split according to our super block
> locations, the last super block ends at 256G, we can submit a huge
> discard for the range [256G, 8T), causing a super large delay.
> 
> We now split the space left to discard based the block discard limit
> in preparation of introduction of cancellation signals handling.
> 
> Reported-by: Qu Wenruo <wqu@suse.com>

Well, I'd say who ever reported the original fstrim and suspension 
failure should be the reporter, not me.

And David's advice is indeed pretty good for the new split according to 
the discard limit.

> Closes: https://lore.kernel.org/lkml/2e15214b-7e95-4e64-a899-725de12c9037@gmail.com/T/#mdfef1d8b36334a15c54cd009f6aadf49e260e105
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> ---
>   fs/btrfs/extent-tree.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index feec49e6f9c8..894684f4f497 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1239,8 +1239,9 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>   			       u64 *discarded_bytes)
>   {
>   	int j, ret = 0;
> -	u64 bytes_left, end;
> +	u64 bytes_left, bytes_to_discard, end;

You can calculate the discard limit here, no need to recalculate inside 
the loop.

For the other variables only utilized inside the loop, you can always 
declare them inside the loop.

Otherwise looks good to me.

Thanks,
Qu
>   	u64 aligned_start = ALIGN(start, 1 << SECTOR_SHIFT);
> +	sector_t sector, nr_sects, bio_sects;
>   
>   	/* Adjust the range to be aligned to 512B sectors if necessary. */
>   	if (start != aligned_start) {
> @@ -1300,13 +1301,23 @@ static int btrfs_issue_discard(struct block_device *bdev, u64 start, u64 len,
>   		bytes_left = end - start;
>   	}
>   
> -	if (bytes_left) {
> -		ret = blkdev_issue_discard(bdev, start >> SECTOR_SHIFT,
> -					   bytes_left >> SECTOR_SHIFT,
> -					   GFP_NOFS);
> +	while (bytes_left) {
> +		sector = start >> SECTOR_SHIFT;
> +		nr_sects = bytes_left >> SECTOR_SHIFT;
> +		bio_sects = min(nr_sects, bio_discard_limit(bdev, sector));
> +		bytes_to_discard = bio_sects << SECTOR_SHIFT;
> +
> +		ret = blkdev_issue_discard(bdev, sector, bio_sects, GFP_NOFS);
> +
>   		if (!ret)
> -			*discarded_bytes += bytes_left;
> +			*discarded_bytes += bytes_to_discard;
> +		else if (ret != -EOPNOTSUPP)
> +			return ret;
> +
> +		start += bytes_to_discard;
> +		bytes_left -= bytes_to_discard;
>   	}
> +
>   	return ret;
>   }
>   

