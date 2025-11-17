Return-Path: <linux-btrfs+bounces-19079-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F9EC661DF
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 21:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C7614EE00C
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Nov 2025 20:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA634A797;
	Mon, 17 Nov 2025 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ALax8kZs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AF337688
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763411867; cv=none; b=Pl8s5nqmzq3APY0Owuc+nj/WW17DfPZt39ozLto8y0XaDfRgD5a74a6GURBuSRXxdr/wkJZPKrlOgmbdJuHpsGSiu8tDStTZ5QJjc8ZDsItluCenAI73fJRnqPwD2T10gYkKtxk385R9O61kFybWGkn6+RNx0mz7/LciOOCGBA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763411867; c=relaxed/simple;
	bh=qEqTkT85o7+EyCuIqCWTNx4PxgiZV9Hbb/oyrIfmcYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=duLq1YHNvu24cTp9iL3C7pgaMPx00KMjnCs0IcMN4ABV2BHoBGs3ZXFYM8n6z6op2s02/4KB3NHsHtRkP7cxbBewRTefPXlWoO++Th+SqRreyJsekiOadDU8OYWCBmnYKlqM3+RzRGzyp8zUUBvmmHm/tR57DHcluDZNFrmHQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ALax8kZs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477aa218f20so31995e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Nov 2025 12:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763411864; x=1764016664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yZ9VLxVoi6WZqQgLMTz7AuyvH4p1jkjzd6Fgu9R+yA8=;
        b=ALax8kZsdU7sDyxbpHfvg48XM7PCTO6q/jc5hM7vLq/yVXSKBxOa9NKh+uy6iKekwc
         nCaj9v8XAgFYnq3Zas7hWf1yepKrxBG51vdSB6PYOPK7Y35tjE85pmd4if0rVcCmzR7B
         7/HcHWIbbpnlMatV4FNHsLkS+zQHU4BR/vZLIgyPFz9zUivy6r0gL/sF3A5ELWrGOkmw
         dyqKj61440/6dM0X5Ofm0UTb495/MsEwiNgbNHSMv+kWQ9rN9owNOmr6cfoOuvYtMzhi
         SIHD0lOgvjZiR4oOSHge8fiHoablCjQSbzFVMek/lYMJDCMVk3l+UN85P8OwtgEpyb/p
         x+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763411864; x=1764016664;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yZ9VLxVoi6WZqQgLMTz7AuyvH4p1jkjzd6Fgu9R+yA8=;
        b=fBLUsI+qXVT3Ga/b3wiYp4CYL6IhQ8FMhb5bXGmcKwHq7GInXo3BKxFds7MW1oFX6m
         IeDV7Lcus9mFos0mWEmgS/uZhM0JN92E+zVD9ri6f0us+dh/lisWoVrhrHr0zaPyJrPh
         oWOGFEoMgngbhntiu4r23MMLUXec3txvL3VhjEvuBLd9rZboU5I7MfCN4+tYPqwyUkvM
         7DNmpL5EtVYg4PO97EldIv8bsCRfBkR04fHeZ3yoSPOWCZB+UaC7nTVzaMUkMiktWWBC
         dI/BVO6JFkUTjsiYMpGQmsr11eXrsvUaRxzlVmYDJsdADuqkv+mz2uSyI4pusHe//iCf
         gFMw==
X-Forwarded-Encrypted: i=1; AJvYcCVqrC24lOcAVgNYIHWxdPkbkN6bCt5G/LOKagzf3ABgVacN6eQRxT+JAXVGtfQFxC+R3vl6K9z6QibXQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YybgLOdrrG94xXUCx+bhA92F0XT4Td7oF6pi/EiQfa6k9K4DevU
	U99pIJa2zadqn1k3lewXvFEBN9QY/fyP8zlibrIn20DJ4nlfESZHSMdP/rYZYNUnyik=
X-Gm-Gg: ASbGnctt0aZX73bdtqoiEX7YQL1Lxb/VDNo6fTxls1mRU8kyqqCmtJ5oX4LpVByTdf3
	BGaiRYlEZ4ZKpsv/quV1TAM8jFdUEkuQ4t8kddY6pMUyNOvom6LRmZ83TooSjFp/xaQUppO6Os2
	Fw2olGI/OMRFw3YfHAIvTjnFSvOJQ9Pq4TFwLVpJOVg8LEfu3zvfeDlNzkLPjwmjuQcm/gemxAY
	24hQee/IP4kA097X9AipJMjDH4cTNkSpYqWeTIsZ3nAqov+8TXHg9ZQdpyp3ym5QEv2RZkF9Kdw
	DXsvMvPulTqNPkGf/GpHvjt3w3xPZsr10ydy05JGy3SgK8MDzIlLLFk8eIdHq3YAsApcNiQIJlY
	gHwTeOG2xFi4pt6cjjH/ZpwHJRYNKXzLlFHc8MdsXR3jSkFCQOduk8nAKrjSS26JxjU/DBYa48B
	D5E/wAA65ESmHU9pybdAvm9z8LXSSv
X-Google-Smtp-Source: AGHT+IFBGk9m7h5Y/5l0HBPxIZlVHUBsFtcdJ9eq4lM9akI31iiTQovaCS2Z6mbbS07ln52kW3ZNKQ==
X-Received: by 2002:a05:600c:3550:b0:477:7946:dcf4 with SMTP id 5b1f17b1804b1-4778fe95b17mr129780545e9.24.1763411863588;
        Mon, 17 Nov 2025 12:37:43 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927c22c5fsm14181197b3a.67.2025.11.17.12.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 12:37:43 -0800 (PST)
Message-ID: <477573f0-4004-4527-85ca-6fc53ef09692@suse.com>
Date: Tue, 18 Nov 2025 07:07:39 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: use booleans for delalloc arguments and struct
 find_free_extent_ctl
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1763381954.git.fdmanana@suse.com>
 <738b447897ab72b409ada9e8b3f44f91aa858bb0.1763381954.git.fdmanana@suse.com>
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
In-Reply-To: <738b447897ab72b409ada9e8b3f44f91aa858bb0.1763381954.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/17 22:56, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The struct find_free_extent_ctl uses an int for the 'delalloc' field but
> it's always used as a boolean, and its value is used to be passed to
> several functions to signal if we are dealing with delalloc. The same goes
> for the 'is_data' argument from btrfs_reserve_extent(). So change the type
> from int to bool and move the field definition in the find_free_extent_ctl
> structure so that it's close to other bool fields and reduces the size of
> the structure from 144 down to 136 bytes (at the moment it's only declared
> in the stack of btrfs_reserve_extent(), never allocated otherwise).
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/block-group.c |  2 +-
>   fs/btrfs/block-group.h |  2 +-
>   fs/btrfs/direct-io.c   |  2 +-
>   fs/btrfs/extent-tree.c | 16 +++++++---------
>   fs/btrfs/extent-tree.h |  4 ++--
>   fs/btrfs/inode.c       |  8 ++++----
>   6 files changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index ebbf04501782..8ae73123b610 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -3802,7 +3802,7 @@ int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>    * reservation and return -EAGAIN, otherwise this function always succeeds.
>    */
>   int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
> -			     u64 ram_bytes, u64 num_bytes, int delalloc,
> +			     u64 ram_bytes, u64 num_bytes, bool delalloc,
>   			     bool force_wrong_size_class)

Unrelated to the patch, as it still looks good to me.

I'm a little concerned about the double bool parameters.

It always looks like a timed bomb, as for newer callers it's not that 
hard to get the true/false sequence wrong.

For the structure member I'm completely fine with boolean members, but 
for function parameters can we avoid double bools?

Like using flags or enum instead so that the function calls are more 
clear about their special behaviors?

Thanks,
Qu
>   {
>   	struct btrfs_space_info *space_info = cache->space_info;
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 9172104a5889..5f933455118c 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -345,7 +345,7 @@ int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
>   int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>   			     u64 bytenr, u64 num_bytes, bool alloc);
>   int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
> -			     u64 ram_bytes, u64 num_bytes, int delalloc,
> +			     u64 ram_bytes, u64 num_bytes, bool delalloc,
>   			     bool force_wrong_size_class);
>   void btrfs_free_reserved_bytes(struct btrfs_block_group *cache, u64 num_bytes,
>   			       bool is_delalloc);
> diff --git a/fs/btrfs/direct-io.c b/fs/btrfs/direct-io.c
> index 962fccceffd6..07e19e88ba4b 100644
> --- a/fs/btrfs/direct-io.c
> +++ b/fs/btrfs/direct-io.c
> @@ -186,7 +186,7 @@ static struct extent_map *btrfs_new_extent_direct(struct btrfs_inode *inode,
>   	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, len);
>   again:
>   	ret = btrfs_reserve_extent(root, len, len, fs_info->sectorsize,
> -				   0, alloc_hint, &ins, 1, 1);
> +				   0, alloc_hint, &ins, true, true);
>   	if (ret == -EAGAIN) {
>   		ASSERT(btrfs_is_zoned(fs_info));
>   		wait_on_bit_io(&inode->root->fs_info->flags, BTRFS_FS_NEED_ZONE_FINISH,
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 819e0a15e8e7..a3646440c4fe 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -3587,15 +3587,14 @@ enum btrfs_loop_type {
>   };
>   
>   static inline void
> -btrfs_lock_block_group(struct btrfs_block_group *cache,
> -		       int delalloc)
> +btrfs_lock_block_group(struct btrfs_block_group *cache, bool delalloc)
>   {
>   	if (delalloc)
>   		down_read(&cache->data_rwsem);
>   }
>   
>   static inline void btrfs_grab_block_group(struct btrfs_block_group *cache,
> -		       int delalloc)
> +					  bool delalloc)
>   {
>   	btrfs_get_block_group(cache);
>   	if (delalloc)
> @@ -3605,7 +3604,7 @@ static inline void btrfs_grab_block_group(struct btrfs_block_group *cache,
>   static struct btrfs_block_group *btrfs_lock_cluster(
>   		   struct btrfs_block_group *block_group,
>   		   struct btrfs_free_cluster *cluster,
> -		   int delalloc)
> +		   bool delalloc)
>   	__acquires(&cluster->refill_lock)
>   {
>   	struct btrfs_block_group *used_bg = NULL;
> @@ -3642,8 +3641,7 @@ static struct btrfs_block_group *btrfs_lock_cluster(
>   }
>   
>   static inline void
> -btrfs_release_block_group(struct btrfs_block_group *cache,
> -			 int delalloc)
> +btrfs_release_block_group(struct btrfs_block_group *cache, bool delalloc)
>   {
>   	if (delalloc)
>   		up_read(&cache->data_rwsem);
> @@ -4033,7 +4031,7 @@ static int do_allocation(struct btrfs_block_group *block_group,
>   
>   static void release_block_group(struct btrfs_block_group *block_group,
>   				struct find_free_extent_ctl *ffe_ctl,
> -				int delalloc)
> +				bool delalloc)
>   {
>   	switch (ffe_ctl->policy) {
>   	case BTRFS_EXTENT_ALLOC_CLUSTERED:
> @@ -4689,7 +4687,7 @@ static noinline int find_free_extent(struct btrfs_root *root,
>   int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes,
>   			 u64 num_bytes, u64 min_alloc_size,
>   			 u64 empty_size, u64 hint_byte,
> -			 struct btrfs_key *ins, int is_data, int delalloc)
> +			 struct btrfs_key *ins, bool is_data, bool delalloc)
>   {
>   	struct btrfs_fs_info *fs_info = root->fs_info;
>   	struct find_free_extent_ctl ffe_ctl = {};
> @@ -5166,7 +5164,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>   		return ERR_CAST(block_rsv);
>   
>   	ret = btrfs_reserve_extent(root, blocksize, blocksize, blocksize,
> -				   empty_size, hint, &ins, 0, 0);
> +				   empty_size, hint, &ins, false, false);
>   	if (ret)
>   		goto out_unuse;
>   
> diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
> index e573509c5a71..f96a300a2db4 100644
> --- a/fs/btrfs/extent-tree.h
> +++ b/fs/btrfs/extent-tree.h
> @@ -30,7 +30,6 @@ struct find_free_extent_ctl {
>   	u64 min_alloc_size;
>   	u64 empty_size;
>   	u64 flags;
> -	int delalloc;
>   
>   	/* Where to start the search inside the bg */
>   	u64 search_start;
> @@ -40,6 +39,7 @@ struct find_free_extent_ctl {
>   	struct btrfs_free_cluster *last_ptr;
>   	bool use_cluster;
>   
> +	bool delalloc;
>   	bool have_caching_bg;
>   	bool orig_have_caching_bg;
>   
> @@ -137,7 +137,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_trans_handle *trans,
>   				   struct btrfs_key *ins);
>   int btrfs_reserve_extent(struct btrfs_root *root, u64 ram_bytes, u64 num_bytes,
>   			 u64 min_alloc_size, u64 empty_size, u64 hint_byte,
> -			 struct btrfs_key *ins, int is_data, int delalloc);
> +			 struct btrfs_key *ins, bool is_data, bool delalloc);
>   int btrfs_inc_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>   		  struct extent_buffer *buf, bool full_backref);
>   int btrfs_dec_ref(struct btrfs_trans_handle *trans, struct btrfs_root *root,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fc0f0c46ab22..f71a5f7f55b9 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -1136,7 +1136,7 @@ static void submit_one_async_extent(struct async_chunk *async_chunk,
>   	ret = btrfs_reserve_extent(root, async_extent->ram_size,
>   				   async_extent->compressed_size,
>   				   async_extent->compressed_size,
> -				   0, *alloc_hint, &ins, 1, 1);
> +				   0, *alloc_hint, &ins, true, true);
>   	if (ret) {
>   		/*
>   		 * We can't reserve contiguous space for the compressed size.
> @@ -1359,7 +1359,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
>   
>   		ret = btrfs_reserve_extent(root, num_bytes, num_bytes,
>   					   min_alloc_size, 0, alloc_hint,
> -					   &ins, 1, 1);
> +					   &ins, true, true);
>   		if (ret == -EAGAIN) {
>   			/*
>   			 * btrfs_reserve_extent only returns -EAGAIN for zoned
> @@ -9106,7 +9106,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
>   		 */
>   		cur_bytes = min(cur_bytes, last_alloc);
>   		ret = btrfs_reserve_extent(root, cur_bytes, cur_bytes,
> -				min_size, 0, *alloc_hint, &ins, 1, 0);
> +				min_size, 0, *alloc_hint, &ins, true, false);
>   		if (ret)
>   			break;
>   
> @@ -9914,7 +9914,7 @@ ssize_t btrfs_do_encoded_write(struct kiocb *iocb, struct iov_iter *from,
>   	}
>   
>   	ret = btrfs_reserve_extent(root, disk_num_bytes, disk_num_bytes,
> -				   disk_num_bytes, 0, 0, &ins, 1, 1);
> +				   disk_num_bytes, 0, 0, &ins, true, true);
>   	if (ret)
>   		goto out_delalloc_release;
>   	extent_reserved = true;


