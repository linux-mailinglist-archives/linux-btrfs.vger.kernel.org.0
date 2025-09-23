Return-Path: <linux-btrfs+bounces-17131-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DACBB978C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 23:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 828837AE1FE
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Sep 2025 21:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD08330C112;
	Tue, 23 Sep 2025 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XCLX0VBw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3267926B971
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 21:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661555; cv=none; b=n9jkwcAgjT+nsBxG1Jq4nuJDphL8frCfGIMZcjlUHuMmUlADtkP/oAn5UFxoIdnAc9ONtRcL7flJH43tUf60V0fV5fvXKfcVx1ECQ9/Txypxx3z0Kw4ntXeTTzOKw7aVbfi2ZOqKG/gABIo4nzReJYlC7rfJ+erDpdBtpI1J8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661555; c=relaxed/simple;
	bh=chu+fcbHZGY3vYkecx/JM6cGxTyQtHkml6PqOXZDCH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JhP9SJAf0phdRTE7xd0V6qNvd4YqZxTZrbPnrMkLYlBobFfcWYEyPOOB+/L18LJ5/ZLS4aY47JjKMmflGpLXXUwAhurnYGxrIroedzVXgx1ECpjJPPhgi7D/giMwBRk4N1qfkRV9Twn+X7oJxtmhEgh6osMw6mL8zx4mO/csXrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XCLX0VBw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3669981f8f.0
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Sep 2025 14:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758661550; x=1759266350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TYT1Ag+DIbEsYunq/mOSaT8WFuKHk0i36yBtNqc7qUg=;
        b=XCLX0VBwY8A/4R1KAARUh1hWT+q9nyNMgq4bO5JF/VfrIs+nISUi+zrBbxTUwqo/62
         C8HcQj2yU1wcyUd8ofkBGHz/uWNckh/wgOBMSJwgsHEpmWWxRHVOGOGPB5DdD5Ihw+x3
         sf4gGKgcdowqiW0GpK7ai5Pnv3d+ZN/ekLyIysP9dOxYrmqCdVMU3S0ZJhI1RlXqCXZD
         GK90OE6ajZdZlTlgECR2+3Q5dR5RINUuLDkhZiNVdSnFOAo8fT89BhuRvYDc4nJaYPRa
         s+Ovuo1PQyF12+kUSIYwO5Ow7CPwqkfqhX+LKUV05rrZuD2Dc4pR0S4zIFjOcWPTAka1
         D6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758661550; x=1759266350;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TYT1Ag+DIbEsYunq/mOSaT8WFuKHk0i36yBtNqc7qUg=;
        b=s0paYMsUMCGmUD/iIRglCE/5jtrGvFhEF2Il9TiAJrtjHUsErfW4vZ6LEXfnclsJ9X
         wLK4NtWYzf4hUxgd58fQenWoH3i/52zoPZ9fpoRuPv7SXxmi3PRAZrDPt0ZbfoLXhTmS
         2J64BlqkcGOcwcaSk7xB4hrT7eEzNfrRClIIoCVWFqOGnCfUa8DmhRbAaZfowNttrmDb
         e86TVYKvvQb4RXghf0qcQ+0btFssU0aHtUOFAGsliAt+hcTzTa70+CfMzAekHljXTUiO
         RyFtrx/hNFDVnXFfgrWVNidr1QC1OeQCNToTHU28mWC5akmgYFWp0IX2qKyoA1dBZsox
         Zolg==
X-Forwarded-Encrypted: i=1; AJvYcCWCyiq1U4wA7ClF3amFCiBbYfZ1CM7mX+1C/gGGoy67ABw+ILBcPcXqbX6sieqO4xqMoEfB0clRatRqXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJ83ffDULOY8jc1XAKPyOoD7jEWozymQ43kAhi5EQank3RvTy
	rvqhDL1j+8rM2cOQXOEIpHAwq+PzcnjPj4uKwCYDDmKP5sIYBqGIzTXTG28162vx2Xg=
X-Gm-Gg: ASbGncvtaOJQrC2Mo4CnY0ijRenI0m0rUlfIdM6TSe2XF91D+TSBHV8opoNsAidn6VA
	q7zYRaqXGwuzRdOsYcnc7Bhl+G3uhWITlOJsfLezGwQTTzgA3Oz77KXrbUmiHCT6kFisFQoQoQ+
	P//Z2eCOxrkCdyTijpWvag/ldoo8A8nfyAS7XPdgF2JgdSjpayGMhSbwJIPY4NLNxIpzWFBx8oM
	XIu6KO0qUSCar4J2H64Zh+M45aAbWDdgSEHDK9FQ8SKq6jJf6R6q5vp8XMsNmtH8Cj8MbaE9Hjp
	gNv5QLKjGSwqXTCxlfZfCnQX4Vw83uIuNtk/QclYqtsB4VM6wAVb8tHxaMBM/Ymmgjc7cdqQmpX
	WjUNO5o+YYgFoYMUw81HKCVG2KB46+sN5/s6UBVj4ceQl85t3RY0=
X-Google-Smtp-Source: AGHT+IE5w7bsq2rxRblVkPfOO18i5wVhkzh3jnTQcGcp5oWA7Rk00oS12jCefrr58aPOryc8FFYFFw==
X-Received: by 2002:a05:6000:2385:b0:3ee:1368:a8e9 with SMTP id ffacd0b85a97d-405c46c22ddmr2962392f8f.17.1758661550290;
        Tue, 23 Sep 2025 14:05:50 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-270cdb02c3bsm109280505ad.102.2025.09.23.14.05.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 14:05:49 -0700 (PDT)
Message-ID: <a7ae58b2-6bdc-4f44-bb3f-9068fe51673d@suse.com>
Date: Wed, 24 Sep 2025 06:35:43 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: clear spurious free-space entries
To: Mark Harmstone <mark@harmstone.com>, linux-btrfs@vger.kernel.org,
 fdmanana@kernel.org
References: <20250923155523.31617-1-mark@harmstone.com>
 <20250923155523.31617-2-mark@harmstone.com>
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
In-Reply-To: <20250923155523.31617-2-mark@harmstone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/24 01:24, Mark Harmstone 写道:
> Version 6.16.1 of btrfs-progs fixes a broken btrfs check test for
> spurious entries in the free-space tree, those that don't belong to any
> block group. Unfortunately mkfs.btrfs had been generating these, meaning
> that these filesystems will now fail btrfs check.
> 
> Add a compat flag BTRFS_FEATURE_COMPAT_NO_SPURIOUS_FREE_SPACE, and if on
> mount we find this isn't set, clean any spurious entries from the
> beginning of the free-space tree.

I found this compat flag a little overkilled.

Are we really going to introduce a new compat flag every time there is 
something wrong with the free space tree?

> 
> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> ---
>   fs/btrfs/disk-io.c         |  10 ++++
>   fs/btrfs/free-space-tree.c | 115 +++++++++++++++++++++++++++++++++++++
>   fs/btrfs/free-space-tree.h |   1 +
>   include/uapi/linux/btrfs.h |   2 +
>   4 files changed, 128 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 21c2a19d690f..224369c450e4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3077,6 +3077,16 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
>   		}
>   	}
>   
> +	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE) &&
> +	    !btrfs_fs_compat(fs_info, NO_SPURIOUS_FREE_SPACE)) {
> +		ret = btrfs_remove_spurious_free_space(fs_info);
> +		if (ret) {
> +			btrfs_warn(fs_info,
> +				   "failed to remove spurious free space: %d",
> +				   ret);
> +		}
> +	}
> +
>   	/*
>   	 * btrfs_find_orphan_roots() is responsible for finding all the dead
>   	 * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and load
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index dad0b492a663..5980710cf6b5 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -1722,3 +1722,118 @@ int btrfs_load_free_space_tree(struct btrfs_caching_control *caching_ctl)
>   	else
>   		return load_free_space_extents(caching_ctl, path, extent_count);
>   }
> +
> +/*
> + * Earlier versions of mkfs.btrfs created spurious entries at the beginning of
> + * the free-space tree, before the start of any block group.
> + * If the compat flag NO_SPURIOUS_FREE_SPACE is not set, clean these up and
> + * set the flag so we know we don't have to check again.
> + */
> +int btrfs_remove_spurious_free_space(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *fst;
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_key key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_block_group *bg;
> +	u64 bg_start;
> +	BTRFS_PATH_AUTO_FREE(path);
> +	int ret, ret2;
> +	unsigned int entries_to_remove = 0;
> +
> +	struct btrfs_key root_key = {
> +		.objectid = BTRFS_FREE_SPACE_TREE_OBJECTID,
> +		.type = BTRFS_ROOT_ITEM_KEY,
> +		.offset = 0,
> +	};
> +
> +	path = btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	fst = btrfs_grab_root(btrfs_global_root(fs_info, &root_key));
> +	if (!fst)
> +		return -EINVAL;
> +
> +	trans = btrfs_start_transaction(fst, 0);
> +	if (IS_ERR(trans)) {
> +		ret = PTR_ERR(trans);
> +		goto end;
> +	}
> +
> +	key.objectid = 0;
> +	key.type = 0;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(trans, fst, &key, path, 0, 0);
> +	if (ret < 0)
> +		goto end_trans;
> +
> +	while (true) {
> +		leaf = path->nodes[0];
> +		if (path->slots[0] >= btrfs_header_nritems(leaf)) {
> +			ret = btrfs_next_leaf(fst, path);
> +			if (ret < 0)
> +				goto end_trans;
> +			if (ret > 0)
> +				break;
> +			leaf = path->nodes[0];
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
> +
> +		bg = btrfs_lookup_first_block_group(fs_info, key.objectid);

We can do the lookup out of the loop. With a parameter 0 for @bytenr.

As we just need to delete any entry before the first bg, there is no 
need to lookup the bg every time.

Furthermore, since the stale entries are just from the temporary chunks, 
they should be pretty small, thus we are able to afford the check at 
every mount.

> +		if (!bg)
> +			break;
> +
> +		bg_start = bg->start;
> +
> +		btrfs_put_block_group(bg);
> +
> +		if (key.objectid >= bg_start)
> +			break;
> +
> +		entries_to_remove++;
> +
> +		path->slots[0]++;
> +	}
> +
> +	if (entries_to_remove == 0) {
> +		ret = 0;
> +		goto end_trans;
> +	}
> +
> +	btrfs_release_path(path);
> +
> +	key.objectid = 0;
> +	key.type = 0;
> +	key.offset = 0;
> +
> +	ret = btrfs_search_slot(trans, fst, &key, path, -1, 1);
> +	if (ret < 0)
> +		goto end_trans;
> +
> +	ret = btrfs_del_items(trans, fst, path, 0, entries_to_remove);

What if @entries_to_remove is larger than the items in the leaf?
I know there should not be that many entries, but we should still take 
extra cares just in case.

Thanks,
Qu
> +	if (ret)
> +		btrfs_abort_transaction(trans, ret);
> +
> +end_trans:
> +	btrfs_release_path(path);
> +
> +	if (!ret)
> +		btrfs_set_fs_compat(fs_info, NO_SPURIOUS_FREE_SPACE);
> +
> +	ret2 = btrfs_commit_transaction(trans);
> +	if (!ret)
> +		ret = ret2;
> +
> +	if (!ret && entries_to_remove > 0) {
> +		btrfs_info(fs_info, "removed %u spurious free-space entries",
> +			   entries_to_remove);
> +	}
> +
> +end:
> +	btrfs_put_root(fst);
> +
> +	return ret;
> +}
> diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
> index 3d9a5d4477fc..b501c41acf3b 100644
> --- a/fs/btrfs/free-space-tree.h
> +++ b/fs/btrfs/free-space-tree.h
> @@ -35,6 +35,7 @@ int btrfs_add_to_free_space_tree(struct btrfs_trans_handle *trans,
>   				 u64 start, u64 size);
>   int btrfs_remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>   				      u64 start, u64 size);
> +int btrfs_remove_spurious_free_space(struct btrfs_fs_info *fs_info);
>   
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   struct btrfs_free_space_info *
> diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
> index 8e710bbb688e..6219e2b8e334 100644
> --- a/include/uapi/linux/btrfs.h
> +++ b/include/uapi/linux/btrfs.h
> @@ -337,6 +337,8 @@ struct btrfs_ioctl_fs_info_args {
>   #define BTRFS_FEATURE_INCOMPAT_RAID_STRIPE_TREE	(1ULL << 14)
>   #define BTRFS_FEATURE_INCOMPAT_SIMPLE_QUOTA	(1ULL << 16)
>   
> +#define BTRFS_FEATURE_COMPAT_NO_SPURIOUS_FREE_SPACE	(1ULL << 0)
> +
>   struct btrfs_ioctl_feature_flags {
>   	__u64 compat_flags;
>   	__u64 compat_ro_flags;


