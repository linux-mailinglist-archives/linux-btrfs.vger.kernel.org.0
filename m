Return-Path: <linux-btrfs+bounces-14608-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA3AAD614B
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5DBF7A4B0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 21:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1865D23C39A;
	Wed, 11 Jun 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BCnOALI/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35EF288D6
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749677344; cv=none; b=ETCV66V2cVhHXel+3NqE6pTh0IYUvgcQuAkAW+WOHgzKlTPi5yuOf9Q5O4+vw0u5RUO9nmc3zgfmkbzyBoOqU3plZBoaKjuiSQVCgBD0utj7urcqOijIMC2E/pxIW/uWjXpXsoaBLDHeCn3whXv6c5Sn4OzBqn0x6iEbTKvemF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749677344; c=relaxed/simple;
	bh=VUCOQY5W7jFEbI4bLsMT3qtHqv6OXB8il3ofX28yfLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=syYUrlxSSXk2H/CdRHwYKgfY4PID52KPszx4RHQlPLtnQUd8khLlAylU2DUSgAJ8t00klfXqBC4ToGUbTORTjpm3LTdtMqJRxEzNw7wZNpunPsBmf+sLQPAgLYpAf1cI80/w0EVDTHlBv8ySyS7dkKEkDqFIB/e0WgoVjFK264E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BCnOALI/; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45024721cbdso1895525e9.2
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749677340; x=1750282140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uNizbGJEAt3jvDN5Qul0deJO0ANLQ3Z2lH9JQrVhEK4=;
        b=BCnOALI/nSewmeBhixKlq65HQqfafj0/qu3weHeH4nBPfEWIPPDCZSKQyerveFvpDe
         NY0vAjIvVk4jaboYNoick1GD9Fns2uztkhY+Bp2Zu3Eh09G3lYBYcIjwRFQbPmYTMn2c
         rgR0ij5UlPfKJP//MXsDJmA0SNkUwxPm3r0o1AWoaTcux2QSmvPi1rwev5Lrak5dSCx5
         0xfuG260B+oQRTo5BDi/GN+AD/4Vtv0FBaUOea/snymbqP2AIfZzpYG/Tk8tAE0FTGre
         9KVHd8o194eCJgqXfvFsFF7Yv87rj0RzmluwgTcfiHxSGwH8cYfA3YcasODxHYihtZvF
         ti9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749677340; x=1750282140;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uNizbGJEAt3jvDN5Qul0deJO0ANLQ3Z2lH9JQrVhEK4=;
        b=sDYNut6VfqhHRx+nYBFypxGXnMJ1d/JzI3WtGxWxlSgZYjr9+8skVMUgYBeCE2tQnD
         L/AysyOtpYGXJoYv3e81+7Y8uiNC1a6lvBrA9yMQhjjOXP79qze0NiIXEED/kMrt8nHT
         JhINGDckz6KYMb7h0LS91oIz3/ycodZGR9jg03WJEJQh1keqd06lvpdhs6DGH8mYy4Hs
         VumGN4e9GO1hS00GVzwGyw2G3gMrctFR8ExMoNkudvS+maSrwPFeouy9yMK7W8/Wk9SS
         MSPFUJ7leTj0gCVQyGA+S+3OGX9jC4p1mHeTlS00z58P3W5HZfzUpLmSb8uJBF5a2hSd
         89Og==
X-Forwarded-Encrypted: i=1; AJvYcCVqkKql3IguJGu1b7vEdMZIEd84DESVeFSc2jSUFn21gHoPSK9djqGlLpgINwuApoQ/2H8oY3ZpmOpM2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzDuv7VOLy1d6FCQ7pDhwaitUlBx50tU+aStgZeqtEzkDnIOjGr
	ELTynKIHKdCoPVAOYBdeaYbYugS/PoTnRiQ1pi23reu31ynCEzHF/6m9kI9J4+qeJJY=
X-Gm-Gg: ASbGncu4fWnoygV4a5TmyxxpwSsibKvlO5Q1sAgvxGWRjCgPyoLmaFwB9NwnX06Yit9
	jtJMHDnaq3b31lbLWLaLcWRInMsHPWgfpAHrqruvuwLJL9XMUfPePCqS4IHb+IfMm1XZP3hssCw
	bEBpprkB4VtLj2S0nU7vl9Fgt3YKG0sRSQvmmk4iW1h00pGE+BRv2VweT2Em5AScBBWLRl6WQWx
	TR2OF243QB/ELP2pJnMQyy4Ljd8+XDBNxxsHuNOg524yke6IsBwIrkEV9aFvG6d8QGk1I7SgG6u
	4sFIzzBD/+ADfIp+6yzia4SLaWTYoMKWfzwyCh4Dygfgd75/ZvO/BkrRhdCe4I/dC95GA4ZS+Eu
	vdjrXWh+5GbXLzg==
X-Google-Smtp-Source: AGHT+IEGJP7Tn27j8rcf8qprFMS9XraQDYJbpOlCUDmxwtfVuuGPO49v9uSlcQy1dQ86qXnJHWc93g==
X-Received: by 2002:a05:6000:40cc:b0:3a5:52d4:5b39 with SMTP id ffacd0b85a97d-3a5586dcc0cmr3655581f8f.8.1749677339786;
        Wed, 11 Jun 2025 14:28:59 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e702d9dsm265605ad.180.2025.06.11.14.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 14:28:59 -0700 (PDT)
Message-ID: <e26c5163-e492-4275-bfaa-b36d81e363ea@suse.com>
Date: Thu, 12 Jun 2025 06:58:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] btrfs: always open the device read-only in
 btrfs_scan_one_device
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Boris Burkov <boris@bur.io>, Christoph Hellwig <hch@lst.de>,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250611100303.110311-1-jth@kernel.org>
 <20250611100303.110311-2-jth@kernel.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20250611100303.110311-2-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/11 19:32, Johannes Thumshirn 写道:
> From: Christoph Hellwig <hch@lst.de>
> 
> btrfs_scan_one_device opens the block device only to read the super
> block.  Instead of passing a blk_mode_t argument to sometimes open
> it for writing, just hard code BLK_OPEN_READ as it will never write
> to the device or hand the block_device out to someone else.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/super.c   | 9 ++++-----
>   fs/btrfs/volumes.c | 4 ++--
>   fs/btrfs/volumes.h | 2 +-
>   3 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 2d0d8c6e77b4..b9e08a59da4e 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -364,10 +364,9 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   		break;
>   	case Opt_device: {
>   		struct btrfs_device *device;
> -		blk_mode_t mode = btrfs_open_mode(fc);
>   
>   		mutex_lock(&uuid_mutex);
> -		device = btrfs_scan_one_device(param->string, mode, false);
> +		device = btrfs_scan_one_device(param->string, false);
>   		mutex_unlock(&uuid_mutex);
>   		if (IS_ERR(device))
>   			return PTR_ERR(device);
> @@ -1855,7 +1854,7 @@ static int btrfs_get_tree_super(struct fs_context *fc)
>   	 * With 'true' passed to btrfs_scan_one_device() (mount time) we expect
>   	 * either a valid device or an error.
>   	 */
> -	device = btrfs_scan_one_device(fc->source, mode, true);
> +	device = btrfs_scan_one_device(fc->source, true);
>   	ASSERT(device != NULL);
>   	if (IS_ERR(device)) {
>   		mutex_unlock(&uuid_mutex);
> @@ -2233,7 +2232,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   		 * Scanning outside of mount can return NULL which would turn
>   		 * into 0 error code.
>   		 */
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
> +		device = btrfs_scan_one_device(vol->name, false);
>   		ret = PTR_ERR_OR_ZERO(device);
>   		mutex_unlock(&uuid_mutex);
>   		break;
> @@ -2251,7 +2250,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
>   		 * Scanning outside of mount can return NULL which would turn
>   		 * into 0 error code.
>   		 */
> -		device = btrfs_scan_one_device(vol->name, BLK_OPEN_READ, false);
> +		device = btrfs_scan_one_device(vol->name, false);
>   		if (IS_ERR_OR_NULL(device)) {
>   			mutex_unlock(&uuid_mutex);
>   			if (IS_ERR(device))
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1535a425e8f9..1ebfc69012a2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1440,7 +1440,7 @@ static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
>    * the device or return an error. Multi-device and seeding devices are registered
>    * in both cases.
>    */
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> +struct btrfs_device *btrfs_scan_one_device(const char *path,
>   					   bool mount_arg_dev)
>   {
>   	struct btrfs_super_block *disk_super;
> @@ -1461,7 +1461,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
>   	 * values temporarily, as the device paths of the fsid are the only
>   	 * required information for assembling the volume.
>   	 */
> -	bdev_file = bdev_file_open_by_path(path, flags, NULL, NULL);
> +	bdev_file = bdev_file_open_by_path(path, BLK_OPEN_READ, NULL, NULL);
>   	if (IS_ERR(bdev_file))
>   		return ERR_CAST(bdev_file);
>   
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 6d8b1f38e3ee..afa71d315c46 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -719,7 +719,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>   void btrfs_mapping_tree_free(struct btrfs_fs_info *fs_info);
>   int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
>   		       blk_mode_t flags, void *holder);
> -struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
> +struct btrfs_device *btrfs_scan_one_device(const char *path,
>   					   bool mount_arg_dev);
>   int btrfs_forget_devices(dev_t devt);
>   void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);


