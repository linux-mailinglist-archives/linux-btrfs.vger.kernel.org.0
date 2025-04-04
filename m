Return-Path: <linux-btrfs+bounces-12811-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E48C7A7C68D
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Apr 2025 01:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC00E3B8213
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Apr 2025 23:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C934E1F1300;
	Fri,  4 Apr 2025 23:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jc1VSY5B"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DE815990C
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Apr 2025 23:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743808017; cv=none; b=NKV6DDLcDF4FLMu/RbeDChN94DBObjuLDvM0p2Cs/N6crzmP628EETx+5DarKMS+m090w6G+fLRZwKaSarf8ArlcmcdiF5wL43qm5XtMfmQE9XJzIfdkvIRFoI0sm2nD9jBkOF/g3c3RNoWKFB+iKALd7Vg3y0jHkjCHwVCuMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743808017; c=relaxed/simple;
	bh=WQmK1n4rxP1NIqnmqaSuPdBm4rJ/8/oKx+afGEiiBL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JY27fHowWZuozJb5YlL7gYOeHMZ95sl/ArdHBEkBeFmcE/2V7/59VzbilWZ6/gO2IWWMkXMM41SrfrRqRwqAA9Cs0aFnWT7tnojbozsmhvVoyVjQxYDRpM5yUd9ZrCmaE2TS6sTRYRzZnKlzorSG6lDWyalJ/4bv9IXZCmv11rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Jc1VSY5B; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so1565347f8f.0
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Apr 2025 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743808013; x=1744412813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=047Dt8J1s0VynpIhR8HKAO930yxwqQUHRfFXVykkWK0=;
        b=Jc1VSY5BjpXi6ceKZLMzqfqerc1g8l9I2Ly/dzoWYButThVxcgf2FF4f2498tkGJaZ
         Ps7IaVZvWhE63pJDBS3/3MNfZ+w26AGg93rqhuo7NKJGzfNTFixECnqAaM6433TCCZjF
         uohcU/lbCmrG8FOrQuQtUF7lPCdUHWXqMg/XAXbJkTWLOSe/cInu+3obAXYLuDdLr8y9
         NQi2dBy8AC3TREUg0cjzhuEnP/3zGnIyKFPOB7S1bctus8dyj7sH997xGHQOtkSldInw
         zFdiRr+VC8ilb9neGA7GXwQNCY/S7ovDSz1dYLrb5Ikn1DjqdPpAZZC7yEhX204YqFjb
         REsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743808013; x=1744412813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=047Dt8J1s0VynpIhR8HKAO930yxwqQUHRfFXVykkWK0=;
        b=DXSoPNVqvDjC3nSAflAWCA9rx4sfVWUO7zFI5UVgAF/6CoPU7CmsuFu+UhrWNMIUow
         ZWyLZxIujx+ixYdF1CcsLJKELslxhOMzERdkelEFC7//cUrruBqsp4izXyOeF8g0tDRO
         SWuvB1XXviVYInK1k6sV3zEowcedAUo1bMBeybuHk0WFw8Y7rf0OyS4YLApdB9yKyHWf
         z5WE0euLoxvAih4QE/ujtLPUg9KbRjnLADJGc/W1R+Tmd/QXTerjniOqnlNsD6SHAVSf
         th73mvT/riaie/ca/WWfbjBb3d/4jeVjL7sGtCjGksiqx76GL8J/SrOeT29qwchE8m5D
         1gJw==
X-Forwarded-Encrypted: i=1; AJvYcCUPZOfL1Nl4ah5gDVXOGqyvq5yT4zuYnVVWstrlJFOreL7AfqBla7IFoKJaNk/NigPAARYDkCD4LpUaZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ6imitWe88SwqXXbwBsSkpthP3p6WHrKuRZ9Db0p4QiBblS3A
	4e/2j4CMKMHuO7TWIF/WsKFExDsIoY7xCaBgzqmUvFeQV8HttnfacoeXdlWt8UGGn8cq+8m4Rgy
	N
X-Gm-Gg: ASbGncve1qwmtqlAu6tS7Ixyd7Fbidh8Vk3DWKP9BdJr0/T91xBqY1paoxHcYTIO9So
	Mju3c5J5xkBX4m2VoxPSUyktBiT6PqkhWIbWuB8h+z9LMyRsNAAI+HYL64j+Ddm55mJ5oZGVD70
	kQGaCxcwZDJN68y/CkQjQQZSfo6CzeSvHY2qOsozaYQ6oef87Wf7wuoDSBvDUY+OV2tETtkQtYr
	3Io/9XPrpEo7Cl9yMGXXKZFXIE+ZSWqSsmdEEvqO9y5lCVHzZ/J+1kGoFuIO+IH9Rblmi1OnqmE
	ut26oIdRCn4POYjSnZaMIaoAaGQ3Onyt0MokNQMR0TDODpY1HWHwsypjdx61ROCnxyCiExzY
X-Google-Smtp-Source: AGHT+IFrDYuXm4KGJKER47zeVSEvVib1UXu0ZTUQ4OjMgOy8/uVAwSuklkYnJ4mqJtPQ8ngJJFJfOQ==
X-Received: by 2002:a05:6000:1787:b0:39a:ca40:7bfb with SMTP id ffacd0b85a97d-39d1466239amr3155986f8f.54.1743808012832;
        Fri, 04 Apr 2025 16:06:52 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d9806509sm3999190b3a.82.2025.04.04.16.06.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 16:06:52 -0700 (PDT)
Message-ID: <223120f3-5faa-4790-8235-5f2fb6dba17a@suse.com>
Date: Sat, 5 Apr 2025 09:36:48 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: tracepoints: use btrfs_root_id() to get the id of
 a root
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <acef2fc25f3912f7cb105e45d4d63a3a096c2eb6.1743762625.git.fdmanana@suse.com>
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
In-Reply-To: <acef2fc25f3912f7cb105e45d4d63a3a096c2eb6.1743762625.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/4 21:01, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of open coding btrfs_root_id() to get the ID of a root, use the
> helper in the tracepoints, which also makes the code less verbose.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   include/trace/events/btrfs.h | 50 +++++++++++++++++-------------------
>   1 file changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 60f279181ae2..f3481a362483 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -223,8 +223,7 @@ DECLARE_EVENT_CLASS(btrfs__inode,
>   		__entry->generation = BTRFS_I(inode)->generation;
>   		__entry->last_trans = BTRFS_I(inode)->last_trans;
>   		__entry->logged_trans = BTRFS_I(inode)->logged_trans;
> -		__entry->root_objectid =
> -				BTRFS_I(inode)->root->root_key.objectid;
> +		__entry->root_objectid = btrfs_root_id(BTRFS_I(inode)->root);
>   	),
>   
>   	TP_printk_btrfs("root=%llu(%s) gen=%llu ino=%llu blocks=%llu "
> @@ -296,7 +295,7 @@ TRACE_EVENT_CONDITION(btrfs_get_extent,
>   	),
>   
>   	TP_fast_assign_btrfs(root->fs_info,
> -		__entry->root_objectid	= root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(root);
>   		__entry->ino		= btrfs_ino(inode);
>   		__entry->start		= map->start;
>   		__entry->len		= map->len;
> @@ -375,7 +374,7 @@ DECLARE_EVENT_CLASS(btrfs__file_extent_item_regular,
>   	),
>   
>   	TP_fast_assign_btrfs(bi->root->fs_info,
> -		__entry->root_obj	= bi->root->root_key.objectid;
> +		__entry->root_obj	= btrfs_root_id(bi->root);
>   		__entry->ino		= btrfs_ino(bi);
>   		__entry->isize		= bi->vfs_inode.i_size;
>   		__entry->disk_isize	= bi->disk_i_size;
> @@ -426,7 +425,7 @@ DECLARE_EVENT_CLASS(
>   
>   	TP_fast_assign_btrfs(
>   		bi->root->fs_info,
> -		__entry->root_obj	= bi->root->root_key.objectid;
> +		__entry->root_obj	= btrfs_root_id(bi->root);
>   		__entry->ino		= btrfs_ino(bi);
>   		__entry->isize		= bi->vfs_inode.i_size;
>   		__entry->disk_isize	= bi->disk_i_size;
> @@ -526,7 +525,7 @@ DECLARE_EVENT_CLASS(btrfs__ordered_extent,
>   		__entry->flags		= ordered->flags;
>   		__entry->compress_type	= ordered->compress_type;
>   		__entry->refs		= refcount_read(&ordered->refs);
> -		__entry->root_objectid	= inode->root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(inode->root);
>   		__entry->truncated_len	= ordered->truncated_len;
>   	),
>   
> @@ -663,7 +662,7 @@ TRACE_EVENT(btrfs_finish_ordered_extent,
>   		__entry->start	= start;
>   		__entry->len	= len;
>   		__entry->uptodate = uptodate;
> -		__entry->root_objectid = inode->root->root_key.objectid;
> +		__entry->root_objectid = btrfs_root_id(inode->root);
>   	),
>   
>   	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu len=%llu uptodate=%d",
> @@ -704,8 +703,7 @@ DECLARE_EVENT_CLASS(btrfs__writepage,
>   		__entry->for_reclaim	= wbc->for_reclaim;
>   		__entry->range_cyclic	= wbc->range_cyclic;
>   		__entry->writeback_index = inode->i_mapping->writeback_index;
> -		__entry->root_objectid	=
> -				 BTRFS_I(inode)->root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(BTRFS_I(inode)->root);
>   	),
>   
>   	TP_printk_btrfs("root=%llu(%s) ino=%llu page_index=%lu "
> @@ -749,7 +747,7 @@ TRACE_EVENT(btrfs_writepage_end_io_hook,
>   		__entry->start	= start;
>   		__entry->end	= end;
>   		__entry->uptodate = uptodate;
> -		__entry->root_objectid = inode->root->root_key.objectid;
> +		__entry->root_objectid = btrfs_root_id(inode->root);
>   	),
>   
>   	TP_printk_btrfs("root=%llu(%s) ino=%llu start=%llu end=%llu uptodate=%d",
> @@ -779,8 +777,7 @@ TRACE_EVENT(btrfs_sync_file,
>   		__entry->ino		= btrfs_ino(BTRFS_I(inode));
>   		__entry->parent		= btrfs_ino(BTRFS_I(d_inode(dentry->d_parent)));
>   		__entry->datasync	= datasync;
> -		__entry->root_objectid	=
> -				 BTRFS_I(inode)->root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(BTRFS_I(inode)->root);
>   	),
>   
>   	TP_printk_btrfs("root=%llu(%s) ino=%llu parent=%llu datasync=%d",
> @@ -1051,7 +1048,7 @@ DECLARE_EVENT_CLASS(btrfs__chunk,
>   		__entry->sub_stripes	= map->sub_stripes;
>   		__entry->offset		= offset;
>   		__entry->size		= size;
> -		__entry->root_objectid	= fs_info->chunk_root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(fs_info->chunk_root);
>   	),
>   
>   	TP_printk_btrfs("root=%llu(%s) offset=%llu size=%llu "
> @@ -1096,7 +1093,7 @@ TRACE_EVENT(btrfs_cow_block,
>   	),
>   
>   	TP_fast_assign_btrfs(root->fs_info,
> -		__entry->root_objectid	= root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(root);
>   		__entry->buf_start	= buf->start;
>   		__entry->refs		= atomic_read(&buf->refs);
>   		__entry->cow_start	= cow->start;
> @@ -1254,7 +1251,7 @@ TRACE_EVENT(find_free_extent,
>   	),
>   
>   	TP_fast_assign_btrfs(root->fs_info,
> -		__entry->root_objectid	= root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(root);
>   		__entry->num_bytes	= ffe_ctl->num_bytes;
>   		__entry->empty_size	= ffe_ctl->empty_size;
>   		__entry->flags		= ffe_ctl->flags;
> @@ -1283,7 +1280,7 @@ TRACE_EVENT(find_free_extent_search_loop,
>   	),
>   
>   	TP_fast_assign_btrfs(root->fs_info,
> -		__entry->root_objectid	= root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(root);
>   		__entry->num_bytes	= ffe_ctl->num_bytes;
>   		__entry->empty_size	= ffe_ctl->empty_size;
>   		__entry->flags		= ffe_ctl->flags;
> @@ -1317,7 +1314,7 @@ TRACE_EVENT(find_free_extent_have_block_group,
>   	),
>   
>   	TP_fast_assign_btrfs(root->fs_info,
> -		__entry->root_objectid	= root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(root);
>   		__entry->num_bytes	= ffe_ctl->num_bytes;
>   		__entry->empty_size	= ffe_ctl->empty_size;
>   		__entry->flags		= ffe_ctl->flags;
> @@ -1671,8 +1668,7 @@ DECLARE_EVENT_CLASS(btrfs__qgroup_rsv_data,
>   	),
>   
>   	TP_fast_assign_btrfs(btrfs_sb(inode->i_sb),
> -		__entry->rootid		=
> -			BTRFS_I(inode)->root->root_key.objectid;
> +		__entry->rootid		= btrfs_root_id(BTRFS_I(inode)->root);
>   		__entry->ino		= btrfs_ino(BTRFS_I(inode));
>   		__entry->start		= start;
>   		__entry->len		= len;
> @@ -1865,7 +1861,7 @@ TRACE_EVENT(qgroup_meta_reserve,
>   	),
>   
>   	TP_fast_assign_btrfs(root->fs_info,
> -		__entry->refroot	= root->root_key.objectid;
> +		__entry->refroot	= btrfs_root_id(root);
>   		__entry->diff		= diff;
>   		__entry->type		= type;
>   	),
> @@ -1887,7 +1883,7 @@ TRACE_EVENT(qgroup_meta_convert,
>   	),
>   
>   	TP_fast_assign_btrfs(root->fs_info,
> -		__entry->refroot	= root->root_key.objectid;
> +		__entry->refroot	= btrfs_root_id(root);
>   		__entry->diff		= diff;
>   	),
>   
> @@ -1911,7 +1907,7 @@ TRACE_EVENT(qgroup_meta_free_all_pertrans,
>   	),
>   
>   	TP_fast_assign_btrfs(root->fs_info,
> -		__entry->refroot	= root->root_key.objectid;
> +		__entry->refroot	= btrfs_root_id(root);
>   		spin_lock(&root->qgroup_meta_rsv_lock);
>   		__entry->diff		= -(s64)root->qgroup_meta_rsv_pertrans;
>   		spin_unlock(&root->qgroup_meta_rsv_lock);
> @@ -1993,7 +1989,7 @@ TRACE_EVENT(btrfs_inode_mod_outstanding_extents,
>   	),
>   
>   	TP_fast_assign_btrfs(root->fs_info,
> -		__entry->root_objectid	= root->root_key.objectid;
> +		__entry->root_objectid	= btrfs_root_id(root);
>   		__entry->ino		= ino;
>   		__entry->mod		= mod;
>   		__entry->outstanding    = outstanding;
> @@ -2078,7 +2074,7 @@ TRACE_EVENT(btrfs_set_extent_bit,
>   
>   		__entry->owner		= tree->owner;
>   		__entry->ino		= inode ? btrfs_ino(inode) : 0;
> -		__entry->rootid		= inode ? inode->root->root_key.objectid : 0;
> +		__entry->rootid		= inode ? btrfs_root_id(inode->root) : 0;
>   		__entry->start		= start;
>   		__entry->len		= len;
>   		__entry->set_bits	= set_bits;
> @@ -2111,7 +2107,7 @@ TRACE_EVENT(btrfs_clear_extent_bit,
>   
>   		__entry->owner		= tree->owner;
>   		__entry->ino		= inode ? btrfs_ino(inode) : 0;
> -		__entry->rootid		= inode ? inode->root->root_key.objectid : 0;
> +		__entry->rootid		= inode ? btrfs_root_id(inode->root) : 0;
>   		__entry->start		= start;
>   		__entry->len		= len;
>   		__entry->clear_bits	= clear_bits;
> @@ -2145,7 +2141,7 @@ TRACE_EVENT(btrfs_convert_extent_bit,
>   
>   		__entry->owner		= tree->owner;
>   		__entry->ino		= inode ? btrfs_ino(inode) : 0;
> -		__entry->rootid		= inode ? inode->root->root_key.objectid : 0;
> +		__entry->rootid		= inode ? btrfs_root_id(inode->root) : 0;
>   		__entry->start		= start;
>   		__entry->len		= len;
>   		__entry->set_bits	= set_bits;
> @@ -2620,7 +2616,7 @@ TRACE_EVENT(btrfs_extent_map_shrinker_remove_em,
>   
>   	TP_fast_assign_btrfs(inode->root->fs_info,
>   		__entry->ino		= btrfs_ino(inode);
> -		__entry->root_id	= inode->root->root_key.objectid;
> +		__entry->root_id	= btrfs_root_id(inode->root);
>   		__entry->start		= em->start;
>   		__entry->len		= em->len;
>   		__entry->flags		= em->flags;


