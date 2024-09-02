Return-Path: <linux-btrfs+bounces-7735-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E37968605
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 13:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E946F1C222A3
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 11:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A3B183CA6;
	Mon,  2 Sep 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E9wTynXz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE2713C9C0
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Sep 2024 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275975; cv=none; b=TDU6DMLoVpb3U/AUPvOzgx57SBeO5Ipl6uo+qlK24MkvRsmamcY5sAPzBEuZokEwWUshB0c+9ACjY8jScBdH0lGKlh/Axn4qJQIXMke+0MljNs6mjvERpXhjS6J9uztUdnkxzme2hIgxpQq8VxpJwXvV6yrgPxIUZKC7OhWA8Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275975; c=relaxed/simple;
	bh=b8PjYVxZvhv1xfIAqlqxTDyUHLdGPvqdgWutgoPXPlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f51HmDoQgDqH7D9Q7R2rLK3Ikh+395JZE/gheMsOkvAMrAOp9dePb+9egWLDbxjwtowvvgATEJgFXuziZdywHdj8ZjB4BhSVq1ynDSqwyR3Bm3vI45LoWBEwKE8Bn6hokjqkEeYqeg7GWfZmZPxIaGEJQh2Z0H2btLIUf8pGC1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E9wTynXz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c1e5fe79so1176037f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Sep 2024 04:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725275972; x=1725880772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EtLLRwzDcELeb0ZO2e/wMEHsMwK2Lp+CL6px/dCTXBY=;
        b=E9wTynXzpRHilLp5xYXju7oJ1eCgZA2bJvaFHJr8KHmqolExMdJE9vmAdg67y7xz+N
         Upo1hwchpRkVjO5k6XkgGMmiiRbgARie+ECcocRQQkPksbRiNkLQvcd6rxKbUqnoNKoz
         8pcvWkEpr/iRC/ysKO758ZFMUO/2Z2XZie3A1VPfBXYFMH/COtXs46DA4ERILGC8AImx
         BBmPJhtyMQbtANZerPgf81AixQufhxzMtYPLCMi+bEIlaGwkTAivKjuUin+Fm0GwNw/2
         1wo5UFURnNdTACLEUr3z8lJHA9f42yoF+ruTwDlIYV1HXoPhwbCUdgl66mUgWm36WXw3
         B9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275972; x=1725880772;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtLLRwzDcELeb0ZO2e/wMEHsMwK2Lp+CL6px/dCTXBY=;
        b=ONY4JBrp7ViPpBJYJXBf6OTnIEdmtrtcF7G4amIFrbCpkFZ7p+m9sT8pUkczZ1rEzp
         BDqpaXj3LGxaB0bbSj7v5JhHduUChYtCksUfJSPcYIyj0X/pmzhrUVoM3c30h4hYeHjp
         nSb07IQ032B39pUsT5BJwKNnGjYWYPjje00uuJNPNjJFxlxOYYeytJUrRRuKLSXL2qmb
         3LUiyFZet5jL+d+QCNsjdIE8ybFm1u1RMJgjRfLr+jZcX5ykkarF750f+qkh2ok4vEz/
         ZfKKwEDVPmIFbYWTqIg3v/GkDMPznjrtYF7FLu/poqpYPtO2oMRBI6jJTswWjViYgI5o
         7DUg==
X-Forwarded-Encrypted: i=1; AJvYcCWDAvctzHphPbv0vxhNsOKUs1EPbm0gv7KFC/k9HQ/KE4GXa0ZFNAw3wcxsTJ7PdtrUk1kn2uH4qZraSw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjRglVbs+xwG71tM/woXCbvhaCtfzPRCdZujnmdKAeTgfgh2u
	3GXbBdsnXN+OKy2ihw7L5eWK/W71sHf9kNiU/ZZyvbgH8d23UZZuoiiJSkKWUcY=
X-Google-Smtp-Source: AGHT+IHCc+0pl/tPsds9z0P6xI6/le7SPsaow0P6+hezx8fuBZ0z6OcbdQ+qtG7i8NaSHx3J/sP7lw==
X-Received: by 2002:a5d:648d:0:b0:374:c6ad:a7c6 with SMTP id ffacd0b85a97d-374c6adab4amr2527245f8f.20.1725275971100;
        Mon, 02 Sep 2024 04:19:31 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e5576c9bsm6651241b3a.24.2024.09.02.04.19.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:19:30 -0700 (PDT)
Message-ID: <d8383884-3ebe-445d-bd8a-6232b1c6753e@suse.com>
Date: Mon, 2 Sep 2024 20:49:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Always update fstrim_range on failure
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240902111110.746509-1-luca.stefani.ge1@gmail.com>
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
In-Reply-To: <20240902111110.746509-1-luca.stefani.ge1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/9/2 20:40, Luca Stefani 写道:
> Even in case of failure we could've discarded
> some data and userspace should be made aware of it,
> so copy fstrim_range to userspace regardless.
> 
> Also make sure to update the trimmed bytes amount
> even if btrfs_trim_free_extents fails.
> 
> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/extent-tree.c | 4 ++--
>   fs/btrfs/ioctl.c       | 4 +---
>   2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index feec49e6f9c8..a5966324607d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -6551,13 +6551,13 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>   			continue;
>   
>   		ret = btrfs_trim_free_extents(device, &group_trimmed);
> +
> +		trimmed += group_trimmed;
>   		if (ret) {
>   			dev_failed++;
>   			dev_ret = ret;
>   			break;
>   		}
> -
> -		trimmed += group_trimmed;
>   	}
>   	mutex_unlock(&fs_devices->device_list_mutex);
>   
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index e0a664b8a46a..94d8f29b04c5 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -543,13 +543,11 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>   
>   	range.minlen = max(range.minlen, minlen);
>   	ret = btrfs_trim_fs(fs_info, &range);
> -	if (ret < 0)
> -		return ret;
>   
>   	if (copy_to_user(arg, &range, sizeof(range)))
>   		return -EFAULT;
>   
> -	return 0;
> +	return ret;
>   }
>   
>   int __pure btrfs_is_empty_uuid(const u8 *uuid)

