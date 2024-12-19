Return-Path: <linux-btrfs+bounces-10596-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65C99F7191
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 02:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259F0167E69
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2024 01:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000EA2EB10;
	Thu, 19 Dec 2024 01:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XMtufsE7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C599D79FD
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2024 01:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734570535; cv=none; b=hBCmrwCVCCuQK7tAJ9s1VLd+soiyxwhUg8o9wzO85m1DAxwRlMPHyKuN5/8vtRtxr9IILI6cxQsrTF5TZ/R8hkAJxE1BG0XUJdH3tqhy6h3/RJ+yINktY23tSF6r87P2y1yXH18Ng8TMWzXaZ5NtSlzlRqxOf3gVwWlwt24eokg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734570535; c=relaxed/simple;
	bh=4rhhQZcUW/pJ2mdN0RCagK7bMaXqwx+vPK5toJ0U6KE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ROX2i6Tj+8Jr5IHOCszZmUBL3T/bvrsIkOZieVz3preKOnovon+0ZAq06FpZqCW0tui3tDoIT07qN82Je/J1K8Da6MkqtjvFhu3uO/+gZ19gTFaB3Dr+kK9bgF62Q5cBXgeQYPx5pDK1jueKCOfHUIkFnR7f8+eiscAm0Ye9izY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XMtufsE7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385df53e559so217580f8f.3
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 17:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734570530; x=1735175330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rwtOYALS3/SuDuENhb66PY329lsBYaueUzxKaaRpXE=;
        b=XMtufsE7DupmQFRcJFhpLHJgK9eFg8GohDBqGl+wGFbKACcdQIJ2T7PAJTaL1Yp1lQ
         VHjGpZYHISGuJnwyAJpNMl7SZ9dNBh0vna5Kx4/Qj2RCO/M+Yy5kjfGIFUmtz7J8UeXK
         qNhRo0LdDODTAKgW4gMr+PB+DyRn4Ir3Ggsh8Gug/qicz2GRmRiSFsqB6bGrilG32iO/
         Yjx2rWUCNb7Dmfl9hQvuzORNvomDUnPvVIewkPVRl2XC1lPSHe6rIUrEe8RgVignmSmh
         TJBjMVcl65P7qmad43uH1u9ST1q0BIvMNoZdQ8mhlrpLHeSQznYNmR4yEvBIz5x5PgWD
         s0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734570530; x=1735175330;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rwtOYALS3/SuDuENhb66PY329lsBYaueUzxKaaRpXE=;
        b=WejEorzYmRAo1TxbyHkk5dbqfrbmUYJTfZlZr0HwobhB9S/Ec7Reo6TB+MECfKqTYI
         2jy6VmI+LOKqTMluVzn2pgMnUMLXz581MqnjOQs8nALfgYBa6IGIgqg8guXgVFak1/UT
         xRNbTt8hXVnLrBFKhMYosa0EjX9mzqK0YqZ9yqvaiVJxINlWQWQ1Uiou0zo8OGgHZl9K
         DZ/19qK+j2VwqKV5z+F6IH2e+lpbVT65zVv4PdwJS4+oaFIq44WuEIwnTrCqMEikNJux
         FEdyO8v1o/+rSVRRzO4Z4tGLWleGBTniFVtAu8qhG5b84QcjN6lKfBivx+mj+FPee1gk
         UWaA==
X-Gm-Message-State: AOJu0YzJG6IkcEDiv8r6epFk8/vLPRUolV9AUKeGOfECcYiwz7oLa9Qx
	hir3z+Ck5grEb2lxrlqkwXUSRGl6jTK4kbAFD3I5nY+MGIgRd+QLksErq/LanvK7ikTQsJNi2sG
	6
X-Gm-Gg: ASbGncs4G2aCssJQnlTHQNwloiUIITM3hsuA4FmcfphYxJajaEwJ2cuJz3WQFLdX4pJ
	Wlifq4INEo7T75eMq77tOzKq/6Gd0NNbf/s9M85KFm0q0fDCRi4TeRdN2Q3LK8iByy2AX2dc/1V
	Q6zzz9mQLIhPUGAzVDAt9nsHaxl+oLreqmgk86mQ/+9u6Jga9PF2n2zU84lTniV1YOdLvFtwsnv
	YjWugwyzfw+zdgTo8aeXy93sNm0bYNZx62OdTqnnE2+mAyr3Xj+v2dUcPlUPqhK6wX7aQq8GI7V
	AQgElWIX
X-Google-Smtp-Source: AGHT+IFRDGHVBlhvJ3KDmk+aQEMdU/ZhROpxIR7Ypa/EBvb1EJ0HH0csHx0yyIF7PvV3jT1crqurWQ==
X-Received: by 2002:a05:6000:1a8e:b0:385:f996:1bb9 with SMTP id ffacd0b85a97d-388e4d57fcdmr4511322f8f.23.1734570529759;
        Wed, 18 Dec 2024 17:08:49 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee26fdfdsm2054908a91.52.2024.12.18.17.08.48
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 17:08:49 -0800 (PST)
Message-ID: <a8f6432c-aa51-48a1-974b-e7ae952bd043@suse.com>
Date: Thu, 19 Dec 2024 11:38:45 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: validate system chunk array at
 btrfs_validate_super()
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <5d205dc4e1126be4c33b1eac62ba625075749469.1732080133.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <5d205dc4e1126be4c33b1eac62ba625075749469.1732080133.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/20 15:52, Qu Wenruo 写道:
> Currently btrfs_validate_super() only does a very basic check on the
> array chunk size (not too large than the available space, but not too
> small to contain no chunk).
> 
> The more comprehensive checks (the regular chunk checks and size check
> inside the system chunk array) is all done inside
> btrfs_read_sys_array().
> 
> It's not a big deal, but for the sake of concentrated verification, we
> should validate the system chunk array at the time of super block
> validation.
> 
> So this patch does the following modification:
> 
> - Introduce a helper btrfs_check_system_chunk_array()
>    * Validate the disk key
>    * Validate the size before we access the full chunk/stripe items.
>    * Do the full chunk item validation
> 
> - Call btrfs_check_system_chunk_array() at btrfs_validate_super()
> 
> - Simplify the checks inside btrfs_read_sys_array()
>    Now the checks will be converted to an ASSERT().
> 
> - Simplify the checks inside read_one_chunk()
>    Now all chunk items inside system chunk array and chunk tree is
>    verified, there is no need to verify it again inside read_one_chunk().
> 
> This change has the following advantages:
> 
> - More comprehensive checks at write time
>    Although this also means extra memcpy() for the superblocks at write
>    time, due to the limits that we need a dummy extent buffer to utilize
>    all the extent buffer helpers.
> 
> - Slightly improved readablity when iterating the system chunk array
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/disk-io.c      | 21 +--------
>   fs/btrfs/disk-io.h      |  2 +-
>   fs/btrfs/tree-checker.c | 99 +++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/tree-checker.h |  3 ++
>   fs/btrfs/volumes.c      | 64 +++++++-------------------
>   5 files changed, 121 insertions(+), 68 deletions(-)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 814320948645..5d02ee491ec2 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2337,7 +2337,7 @@ static int btrfs_read_roots(struct btrfs_fs_info *fs_info)
>    * 		1, 2	2nd and 3rd backup copy
>    * 	       -1	skip bytenr check
>    */
> -int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
> +int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>   			 const struct btrfs_super_block *sb, int mirror_num)
>   {
>   	u64 nodesize = btrfs_super_nodesize(sb);
> @@ -2495,24 +2495,7 @@ int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
>   		ret = -EINVAL;
>   	}
>   
> -	/*
> -	 * Obvious sys_chunk_array corruptions, it must hold at least one key
> -	 * and one chunk
> -	 */
> -	if (btrfs_super_sys_array_size(sb) > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
> -		btrfs_err(fs_info, "system chunk array too big %u > %u",
> -			  btrfs_super_sys_array_size(sb),
> -			  BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
> -		ret = -EINVAL;
> -	}
> -	if (btrfs_super_sys_array_size(sb) < sizeof(struct btrfs_disk_key)
> -			+ sizeof(struct btrfs_chunk)) {
> -		btrfs_err(fs_info, "system chunk array too small %u < %zu",
> -			  btrfs_super_sys_array_size(sb),
> -			  sizeof(struct btrfs_disk_key)
> -			  + sizeof(struct btrfs_chunk));
> -		ret = -EINVAL;
> -	}
> +	ret = btrfs_check_system_chunk_array(fs_info, sb);
>   
>   	/*
>   	 * The generation is a global counter, we'll trust it more than the others
> diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
> index a7051e2570c1..ff8f314f5ac8 100644
> --- a/fs/btrfs/disk-io.h
> +++ b/fs/btrfs/disk-io.h
> @@ -54,7 +54,7 @@ int btrfs_check_super_csum(struct btrfs_fs_info *fs_info,
>   			   const struct btrfs_super_block *disk_sb);
>   int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_devices);
>   void __cold close_ctree(struct btrfs_fs_info *fs_info);
> -int btrfs_validate_super(const struct btrfs_fs_info *fs_info,
> +int btrfs_validate_super(struct btrfs_fs_info *fs_info,
>   			 const struct btrfs_super_block *sb, int mirror_num);
>   int btrfs_check_features(struct btrfs_fs_info *fs_info, bool is_rw_mount);
>   int write_all_supers(struct btrfs_fs_info *fs_info, int max_mirrors);
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index 148d8cefa40e..83e88bcb0475 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -973,6 +973,105 @@ int btrfs_check_chunk_valid(struct extent_buffer *leaf,
>   	return 0;
>   }
>   
> +int btrfs_check_system_chunk_array(struct btrfs_fs_info *fs_info,
> +				   const struct btrfs_super_block *sb)
> +{
> +	struct extent_buffer *dummy;
> +	u32 array_size;
> +	u32 cur_offset = 0;
> +	u32 len;
> +	int ret = 0;
> +
> +	/*
> +	 * We allocated a dummy extent, just to use extent buffer accessors.
> +	 * There will be unused space after BTRFS_SUPER_INFO_SIZE, but
> +	 * that's fine, we will not go beyond system chunk array anyway.
> +	 */
> +	dummy = alloc_dummy_extent_buffer(fs_info, BTRFS_SUPER_INFO_OFFSET);
> +	if (!dummy)
> +		return -ENOMEM;
> +	set_extent_buffer_uptodate(dummy);
> +	write_extent_buffer(dummy, sb, 0, BTRFS_SUPER_INFO_SIZE);
> +
> +	array_size = btrfs_super_sys_array_size(sb);
> +	if (array_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
> +		btrfs_crit(fs_info,
> +			   "superblock syschunk too large, have %u expect <=%u",
> +			   array_size, BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
> +		ret = -EUCLEAN;
> +		goto out;
> +	}
> +
> +	while (cur_offset < array_size) {
> +		struct btrfs_disk_key *disk_key;
> +		struct btrfs_key key;
> +		struct btrfs_chunk *chunk;
> +		u32 num_stripes;
> +		u64 type;
> +
> +		len = sizeof(*disk_key);
> +		if (cur_offset + len > array_size)
> +			goto out_short_read;
> +		disk_key = (struct btrfs_disk_key *)(sb->sys_chunk_array + cur_offset);
> +		btrfs_disk_key_to_cpu(&key, disk_key);
> +		cur_offset += len;
> +
> +		if (key.type != BTRFS_CHUNK_ITEM_KEY) {
> +			btrfs_crit(fs_info,
> +			    "unexpected item type %u in sys_array at offset %u",
> +				  (u32)key.type, cur_offset);
> +			ret = -EUCLEAN;
> +			goto out;
> +		}
> +		/*
> +		 * At least one btrfs_chunk with one stripe must be present,
> +		 * exact stripe count check comes afterwards
> +		 */
> +		len = btrfs_chunk_item_size(1);
> +		if (cur_offset + len > array_size)
> +			goto out_short_read;
> +
> +		chunk = (struct btrfs_chunk *)
> +			(offsetof(struct btrfs_super_block, sys_chunk_array) +
> +			 cur_offset);
> +		num_stripes = btrfs_chunk_num_stripes(dummy, chunk);
> +		if (!num_stripes) {
> +			btrfs_crit(fs_info,
> +			"invalid number of stripes %u in sys_array at offset %u",
> +				  num_stripes, cur_offset);
> +			ret = -EUCLEAN;
> +			goto out;
> +		}
> +		type = btrfs_chunk_type(dummy, chunk);
> +		if ((type & BTRFS_BLOCK_GROUP_SYSTEM) == 0) {
> +			btrfs_err(fs_info,
> +			"invalid chunk type %llu in sys_array at offset %u",
> +				  type, cur_offset);
> +			ret = -EUCLEAN;
> +			goto out;
> +		}
> +
> +		len = btrfs_chunk_item_size(num_stripes);
> +		if (cur_offset + len > array_size)
> +			goto out_short_read;
> +
> +		ret = btrfs_check_chunk_valid(dummy, chunk, key.offset);

This btrfs_check_chunk_valid() call site is causing false alerts, as it 
relies on fs_info->sectorsize (blocksize), which is not yet fully 
initliazied at this timing.

So it will cause problems if the sector size of the system is not the 
default 4096 value.

I'll fix it in the next update.

Thanks,
Qu

> +		if (ret)
> +			goto out;
> +		cur_offset += len;
> +	}
> +out:
> +	free_extent_buffer_stale(dummy);
> +	return ret;
> +
> +out_short_read:
> +	btrfs_crit(fs_info,
> +	"sys_array too short to read %u bytes at offset %u array size %u",
> +		   len, cur_offset, array_size);
> +	free_extent_buffer_stale(dummy);
> +	return ret;
> +}
> +
>   /*
>    * Enhanced version of chunk item checker.
>    *
> diff --git a/fs/btrfs/tree-checker.h b/fs/btrfs/tree-checker.h
> index db67f96cbe4b..b1c85e4e1add 100644
> --- a/fs/btrfs/tree-checker.h
> +++ b/fs/btrfs/tree-checker.h
> @@ -8,6 +8,7 @@
>   
>   #include <linux/types.h>
>   #include <uapi/linux/btrfs_tree.h>
> +#include "fs.h"
>   
>   struct extent_buffer;
>   struct btrfs_chunk;
> @@ -68,6 +69,8 @@ int btrfs_check_node(struct extent_buffer *node);
>   
>   int btrfs_check_chunk_valid(struct extent_buffer *leaf,
>   			    struct btrfs_chunk *chunk, u64 logical);
> +int btrfs_check_system_chunk_array(struct btrfs_fs_info *fs_info,
> +				   const struct btrfs_super_block *sb);
>   int btrfs_check_eb_owner(const struct extent_buffer *eb, u64 root_owner);
>   int btrfs_verify_level_key(struct extent_buffer *eb,
>   			   const struct btrfs_tree_parent_check *check);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1cccaf9c2b0d..c2863075ee86 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7002,16 +7002,6 @@ static int read_one_chunk(struct btrfs_key *key, struct extent_buffer *leaf,
>   	warn_32bit_meta_chunk(fs_info, logical, length, type);
>   #endif
>   
> -	/*
> -	 * Only need to verify chunk item if we're reading from sys chunk array,
> -	 * as chunk item in tree block is already verified by tree-checker.
> -	 */
> -	if (leaf->start == BTRFS_SUPER_INFO_OFFSET) {
> -		ret = btrfs_check_chunk_valid(leaf, chunk, logical);
> -		if (ret)
> -			return ret;
> -	}
> -
>   	map = btrfs_find_chunk_map(fs_info, logical, 1);
>   
>   	/* already mapped? */
> @@ -7274,11 +7264,9 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
>   	u8 *array_ptr;
>   	unsigned long sb_array_offset;
>   	int ret = 0;
> -	u32 num_stripes;
>   	u32 array_size;
>   	u32 len = 0;
>   	u32 cur_offset;
> -	u64 type;
>   	struct btrfs_key key;
>   
>   	ASSERT(BTRFS_SUPER_INFO_SIZE <= fs_info->nodesize);
> @@ -7301,10 +7289,17 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
>   	cur_offset = 0;
>   
>   	while (cur_offset < array_size) {
> +		u32 num_stripes;
> +
>   		disk_key = (struct btrfs_disk_key *)array_ptr;
>   		len = sizeof(*disk_key);
> -		if (cur_offset + len > array_size)
> -			goto out_short_read;
> +
> +		/*
> +		 * The super block should have passed
> +		 * btrfs_check_system_chunk_array(), thus we only do
> +		 * ASSERT() for those sanity checks.
> +		 */
> +		ASSERT(cur_offset + len <= array_size);
>   
>   		btrfs_disk_key_to_cpu(&key, disk_key);
>   
> @@ -7312,44 +7307,24 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
>   		sb_array_offset += len;
>   		cur_offset += len;
>   
> -		if (key.type != BTRFS_CHUNK_ITEM_KEY) {
> -			btrfs_err(fs_info,
> -			    "unexpected item type %u in sys_array at offset %u",
> -				  (u32)key.type, cur_offset);
> -			ret = -EIO;
> -			break;
> -		}
> +		ASSERT(key.type == BTRFS_CHUNK_ITEM_KEY);
>   
>   		chunk = (struct btrfs_chunk *)sb_array_offset;
>   		/*
>   		 * At least one btrfs_chunk with one stripe must be present,
>   		 * exact stripe count check comes afterwards
>   		 */
> -		len = btrfs_chunk_item_size(1);
> -		if (cur_offset + len > array_size)
> -			goto out_short_read;
> +		ASSERT(cur_offset + btrfs_chunk_item_size(1) <= array_size);
>   
>   		num_stripes = btrfs_chunk_num_stripes(sb, chunk);
> -		if (!num_stripes) {
> -			btrfs_err(fs_info,
> -			"invalid number of stripes %u in sys_array at offset %u",
> -				  num_stripes, cur_offset);
> -			ret = -EIO;
> -			break;
> -		}
> +		/* Should have at least one stripe. */
> +		ASSERT(num_stripes);
>   
> -		type = btrfs_chunk_type(sb, chunk);
> -		if ((type & BTRFS_BLOCK_GROUP_SYSTEM) == 0) {
> -			btrfs_err(fs_info,
> -			"invalid chunk type %llu in sys_array at offset %u",
> -				  type, cur_offset);
> -			ret = -EIO;
> -			break;
> -		}
> +		/* Only system chunks are allowed in system chunk array. */
> +		ASSERT(btrfs_chunk_type(sb, chunk) & BTRFS_BLOCK_GROUP_SYSTEM);
>   
>   		len = btrfs_chunk_item_size(num_stripes);
> -		if (cur_offset + len > array_size)
> -			goto out_short_read;
> +		ASSERT(cur_offset + len <= array_size);
>   
>   		ret = read_one_chunk(&key, sb, chunk);
>   		if (ret)
> @@ -7362,13 +7337,6 @@ int btrfs_read_sys_array(struct btrfs_fs_info *fs_info)
>   	clear_extent_buffer_uptodate(sb);
>   	free_extent_buffer_stale(sb);
>   	return ret;
> -
> -out_short_read:
> -	btrfs_err(fs_info, "sys_array too short to read %u bytes at offset %u",
> -			len, cur_offset);
> -	clear_extent_buffer_uptodate(sb);
> -	free_extent_buffer_stale(sb);
> -	return -EIO;
>   }
>   
>   /*


