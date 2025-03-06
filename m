Return-Path: <linux-btrfs+bounces-12068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0213A55928
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 22:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA40C167EBD
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Mar 2025 21:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82ED2780EA;
	Thu,  6 Mar 2025 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QEg46iNk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D192A2702B8
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Mar 2025 21:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741298092; cv=none; b=aIm6eLAeRxZA6NTtif5rK7zCCEUjQMkn8wVpXWvlIsGzvb/J/pM4Mavsjh+8rLAUKZyiRNs1cuVfNAxnXzMDTj9t2fEiKPYNqP7FS7XFX4g/XKq3uOegKvdevWHA8IStmJWjVdazDUyjmKZ3o3NlH3OTbcon/YICAJS3s4bVghc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741298092; c=relaxed/simple;
	bh=VtYGbQAt16wlwEFpsXoDIWJnviGEsTuzd61Ifn3UXbY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyCSChSaH612H5pSxMCV1Ki5m7sYw5Qw4gys9CSaJuPO+sZt5zNNpaMJcxQF6Og1pPHhhOgw/YyfZ8gI1KK38paZONJ68ZRadydSWmbZsD5ximUl0nGrhtc0gMcilOYxWDHAmKzZ2X4R9ICYhecmTkrKpph4zFfr0rPc8dSqS5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QEg46iNk; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso909933f8f.2
        for <linux-btrfs@vger.kernel.org>; Thu, 06 Mar 2025 13:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741298088; x=1741902888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yk7rXCq5uGcdumJYj7quqvmpnniVTnHYEseJ9oFsaHs=;
        b=QEg46iNktwMRCBAbytzPW3q00EMoOJqOlAymUv46x6dUxh+XYBgD5h6dGHGy6iVIUN
         4QJijvqHRSiPh2iemXOOzuZ2kmnsHPGnx1YaThFenXwOebpFlpVt6IKuLM++phQcuqcT
         qzn7R4yWcsnMfyoH+dlHXglnMtQeq0Nki+PAR8ammAl1u9SdG4MJEhX9Zy77YXlXk3yc
         XE6COI+xHJqKS6gTKw46KpzyvuYxTik1h13h0AEKUUz31ge/nzHOcmF1mKZh2aNkxz9r
         pHc0H5ppf4dwdniSTKFpA8RdNPXV5YfqUawjKGQLttit5PY68uNEWN+PhySQ7kVv6VaU
         l+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741298088; x=1741902888;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk7rXCq5uGcdumJYj7quqvmpnniVTnHYEseJ9oFsaHs=;
        b=kg6Vg9gV2EFEqr+dQnIC7LAzFCADJG6Od5Lf6tuRIWXEXvg+SxEI/WDxoIara0UDk9
         MjoaG0SFL50rKMQD9k7yxoWI/odjf51AYq4JDEI6o2ER9cNcEOLgDGxJn+1T3AGFsfP/
         8UbmavnnIncTLdOlTA/xKh4RHXnNGlIRZx2FwZHOskVL7sZdPsc6I6hvnvyp3f+Q+z1I
         Q8v6Y05q8AMzysuwJqwaFAjeI3N456I5MB65xBx0bW5+SQcGNoPUey60n+5xzAixiiEj
         d2HIaIsTNBI0t21VGiLS97bD2Qp2M21Yx4MSl4zFLiPIJPOw8itA3RudD7Qipt1v+RvO
         sRjQ==
X-Gm-Message-State: AOJu0Yy3pmEJFj7Sr81TEwrPjGp69KXUxL4jVE7MbDVzj58WBzFk+Zc9
	EmkgE0UnMHQ71FWYnKnjzkJMIrcj1v1GfD9BBnI9n2dnbXzvQ83N7OnLieUprxo=
X-Gm-Gg: ASbGncsijDA85V7KKGSFg8Zs6EyjF/WeXfVjb9iF66vZh4GsgSH3SDlD54vDW1ChAv3
	RKw6k78SgwCtV3UOtsLZBE7M+N+ZpahuG7ZNoYQRNUnPqyAy5aOsz91jC3A4Gs86F7HDMTF0jIL
	AYPUZq626B83n76sVHfco5irh1XjpDQ9ehnF9e3bZr9/dd//CTD8KSroEmEbNYMpOF/1/4EXJZr
	s4K808V4M5BWwBbGBSSv/ThqVaNR3DH5matX8GyX1EU5CUK6j9aycMOIePprgn5E3SSzUp4PjF9
	2+r2Tlpyyr5DCOhJYpzKeRClJANB8Pid0gE6CF0IxgKwmink3OXLaGVyGUalNQZQCPkO783t
X-Google-Smtp-Source: AGHT+IFwsGiHRh/EfJ5dmjmyTYZHM0kTscG8hq/j0OY4yD0MaaBuN1XJN7i9lNuvQboFmQRVGlOX0g==
X-Received: by 2002:adf:e007:0:b0:390:f4f9:8396 with SMTP id ffacd0b85a97d-39132d7ff8bmr350719f8f.28.1741298087768;
        Thu, 06 Mar 2025 13:54:47 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ea87esm17405895ad.85.2025.03.06.13.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 13:54:46 -0800 (PST)
Message-ID: <afeb86e8-a1be-43b5-964c-269bd16fcc1f@suse.com>
Date: Fri, 7 Mar 2025 08:24:41 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs/defrag: implement compression levels
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Nick Terrell <terrelln@fb.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304171403.571335-1-neelx@suse.com>
 <20250306131537.972377-1-neelx@suse.com>
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
In-Reply-To: <20250306131537.972377-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/6 23:45, Daniel Vacek 写道:
> The zstd and zlib compression types support setting compression levels.
> Enhance the defrag interface to specify the levels as well.
> 
> Signed-off-by: Daniel Vacek <neelx@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
> v3: Validate the level instead of clamping and fix the comment of the
>      btrfs_ioctl_defrag_range_args structure.
> 
> v2: Fixed the commit message and added an explicit level range clamping.
> 
>   fs/btrfs/btrfs_inode.h     |  1 +
>   fs/btrfs/compression.c     | 10 ++++++++++
>   fs/btrfs/compression.h     |  1 +
>   fs/btrfs/defrag.c          | 24 +++++++++++++++++++-----
>   fs/btrfs/fs.h              |  2 +-
>   fs/btrfs/inode.c           |  9 ++++++---
>   include/uapi/linux/btrfs.h | 16 +++++++++++++---
>   7 files changed, 51 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index aa1f55cd81b79..238e4a08a52ae 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -145,6 +145,7 @@ struct btrfs_inode {
>   	 * different from prop_compress and takes precedence if set.
>   	 */
>   	u8 defrag_compress;
> +	s8 defrag_compress_level;
>   
>   	/*
>   	 * Lock for counters and all fields used to determine if the inode is in
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
> index 6d073e69af4e3..4191e9efc6951 100644
> --- a/fs/btrfs/compression.c
> +++ b/fs/btrfs/compression.c
> @@ -980,6 +980,16 @@ static int btrfs_compress_set_level(unsigned int type, int level)
>   	return level;
>   }
>   
> +/*
> + * Check whether the @level is within the valid range for the given type.
> + */
> +bool btrfs_compress_level_valid(unsigned int type, int level)
> +{
> +	const struct btrfs_compress_op *ops = btrfs_compress_op[type];
> +
> +	return ops->min_level <= level && level <= ops->max_level;
> +}
> +
>   /* Wrapper around find_get_page(), with extra error message. */
>   int btrfs_compress_filemap_get_folio(struct address_space *mapping, u64 start,
>   				     struct folio **in_folio_ret)
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h
> index 933178f03d8f8..df198623cc084 100644
> --- a/fs/btrfs/compression.h
> +++ b/fs/btrfs/compression.h
> @@ -83,6 +83,7 @@ static inline u32 btrfs_calc_input_length(u64 range_end, u64 cur)
>   int __init btrfs_init_compress(void);
>   void __cold btrfs_exit_compress(void);
>   
> +bool btrfs_compress_level_valid(unsigned int type, int level);
>   int btrfs_compress_folios(unsigned int type, int level, struct address_space *mapping,
>   			  u64 start, struct folio **folios, unsigned long *out_folios,
>   			 unsigned long *total_in, unsigned long *total_out);
> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> index 968dae9539482..513089b91b7b6 100644
> --- a/fs/btrfs/defrag.c
> +++ b/fs/btrfs/defrag.c
> @@ -1363,6 +1363,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>   	u64 last_byte;
>   	bool do_compress = (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS);
>   	int compress_type = BTRFS_COMPRESS_ZLIB;
> +	int compress_level = 0;
>   	int ret = 0;
>   	u32 extent_thresh = range->extent_thresh;
>   	pgoff_t start_index;
> @@ -1376,10 +1377,21 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>   		return -EINVAL;
>   
>   	if (do_compress) {
> -		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> -			return -EINVAL;
> -		if (range->compress_type)
> -			compress_type = range->compress_type;
> +		if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> +			if (range->compress.type >= BTRFS_NR_COMPRESS_TYPES)
> +				return -EINVAL;
> +			if (range->compress.type) {
> +				compress_type  = range->compress.type;
> +				compress_level = range->compress.level;
> +				if (!btrfs_compress_level_valid(compress_type, compress_level))
> +					return -EINVAL;
> +			}
> +		} else {
> +			if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> +				return -EINVAL;
> +			if (range->compress_type)
> +				compress_type = range->compress_type;
> +		}
>   	}
>   
>   	if (extent_thresh == 0)
> @@ -1430,8 +1442,10 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
>   			btrfs_inode_unlock(BTRFS_I(inode), 0);
>   			break;
>   		}
> -		if (do_compress)
> +		if (do_compress) {
>   			BTRFS_I(inode)->defrag_compress = compress_type;
> +			BTRFS_I(inode)->defrag_compress_level = compress_level;
> +		}
>   		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
>   				cluster_end + 1 - cur, extent_thresh,
>   				newer_than, do_compress, &sectors_defragged,
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index be6d5a24bd4e6..2dae7ffd37133 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -485,7 +485,7 @@ struct btrfs_fs_info {
>   	u64 last_trans_log_full_commit;
>   	unsigned long long mount_opt;
>   
> -	unsigned long compress_type:4;
> +	int compress_type;
>   	int compress_level;
>   	u32 commit_interval;
>   	/*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fa04b027d53ac..dd27992ecb431 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -925,6 +925,7 @@ static void compress_file_range(struct btrfs_work *work)
>   	unsigned int poff;
>   	int i;
>   	int compress_type = fs_info->compress_type;
> +	int compress_level = fs_info->compress_level;
>   
>   	inode_should_defrag(inode, start, end, end - start + 1, SZ_16K);
>   
> @@ -1007,13 +1008,15 @@ static void compress_file_range(struct btrfs_work *work)
>   		goto cleanup_and_bail_uncompressed;
>   	}
>   
> -	if (inode->defrag_compress)
> +	if (inode->defrag_compress) {
>   		compress_type = inode->defrag_compress;
> -	else if (inode->prop_compress)
> +		compress_level = inode->defrag_compress_level;
> +	} else if (inode->prop_compress) {
>   		compress_type = inode->prop_compress;
> +	}
>   
>   	/* Compression level is applied here. */
> -	ret = btrfs_compress_folios(compress_type, fs_info->compress_level,
> +	ret = btrfs_compress_folios(compress_type, compress_level,
>   				    mapping, start, folios, &nr_folios, &total_in,
>   				    &total_compressed);
>   	if (ret)
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index d3b222d7af240..dd02160015b2b 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -615,7 +615,9 @@ struct btrfs_ioctl_clone_range_args {
>    */
>   #define BTRFS_DEFRAG_RANGE_COMPRESS 1
>   #define BTRFS_DEFRAG_RANGE_START_IO 2
> +#define BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL 4
>   #define BTRFS_DEFRAG_RANGE_FLAGS_SUPP	(BTRFS_DEFRAG_RANGE_COMPRESS |		\
> +					 BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL |	\
>   					 BTRFS_DEFRAG_RANGE_START_IO)
>   
>   struct btrfs_ioctl_defrag_range_args {
> @@ -640,10 +642,18 @@ struct btrfs_ioctl_defrag_range_args {
>   
>   	/*
>   	 * which compression method to use if turning on compression
> -	 * for this defrag operation.  If unspecified, zlib will
> -	 * be used
> +	 * for this defrag operation. If unspecified, zlib will be
> +	 * used. If compression level is also being specified, set the
> +	 * BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL flag and fill the compress
> +	 * member structure instead of the compress_type field.
>   	 */
> -	__u32 compress_type;
> +	union {
> +		__u32 compress_type;
> +		struct {
> +			__u8 type;
> +			__s8 level;
> +		} compress;
> +	};
>   
>   	/* spare for later */
>   	__u32 unused[4];


