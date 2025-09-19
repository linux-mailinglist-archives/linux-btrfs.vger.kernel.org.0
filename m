Return-Path: <linux-btrfs+bounces-17005-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF48EB8B74D
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Sep 2025 00:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8C11C242D3
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 22:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17142C21D8;
	Fri, 19 Sep 2025 22:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cKY5AFy6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF8021ABC9
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 22:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319939; cv=none; b=mKoDzytoEd7Il41y/aYMFKrv45TUiacoOIhr/KAYgebexNzveGrUGoPQ3wKHNmBTaUvVNSgJgRp6+DE8xwAugFdDdfMvVrWLnxE4ygosADvudefN8Gl6xwtABZgAeYXySBx+rkIGHsxnuhCGk5ZbHngmqqHRpukROZANgTv+dxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319939; c=relaxed/simple;
	bh=veAYRP09EvaKP6A/CvG7H7IU+hm1AItisjodvCirVjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pdh+JEaCozawNRngoJtEKAYUvwcy8D30o0dUCZ/QPtSiQtT6/DGVU/CCP31lKs4EvgGgjnhgVLClPXQ0rpMwXGWqvOLErWn6tPDfRvUrTJgMpEU9aZF5kvyTWGRHfLJd4CZfYFnThLviidRoyCrK/f0owC5qKgKyUCCqc84ZN+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cKY5AFy6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so536704f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 15:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758319933; x=1758924733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DRNQV+EaQ2YliUjZ1UJL4Y3Ft6I795sLVw0nsgXhhL4=;
        b=cKY5AFy6yA7dQUpOa523GurHDpxlI9tu2Q9anusZd+xDW6x2lPtR1ICQ+LU5WW0SOO
         v1DwXV8hqEDfwS63bp9W49xi0KtVmf/YIHsJSahbGis9/0n5DCS83pJDWRblVv2V5B3S
         +q6jJ+n5b4HuD3DMVMwDUSXKd1/dG7fwNs/73foK6dhTB8PUxOr8kadr0zfdMxNvrrPs
         mccqZE6A57f3dsAPZTeJXnIU1A/Un1XsyozXyxjtI3HDzZ2dVtgp4ayFcQdbvkZpoDz2
         gU3aDAbKGSJy0CIuBYNm/22GCHn4bSx4hXl0Hqi2hNkLuwqRkKSYvdGHH6IxNCTnfi2x
         RCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319933; x=1758924733;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRNQV+EaQ2YliUjZ1UJL4Y3Ft6I795sLVw0nsgXhhL4=;
        b=A4wuoerjoICDkroAcIYazaO/f9DQBtHMsABrVSn7bBb5vgMHBRevdzn36dBGY0e6md
         6GtZPWn8ygvsD6/RI4DUGYaibO0bUJyGfOadHPHATnpPihTEgmqrhYTf8NRsSTufdM/R
         X3fqh76GrjCKoIipPNvzMm8LmKoH/W54V36iueNndM89Ph0pd61ovG/D14rToBXLJhLL
         Mja55acGPqBQmRpSzA9xhivodJam2BpIE5H9gMpfI5XWH5bmyT64I0IYVMlrJTROu1lY
         V0U/JQnmhxv+GS+R6qd3ZjQ6+KIoKEWBdEUAYtFai2k8RkEag63wSj3Ik+uDwUbfJVUT
         OigA==
X-Forwarded-Encrypted: i=1; AJvYcCV/m+DSKp5qPJfC1mLNV43azB6QHcPwQP17kZ4viZXBwD+5qxlAeeLrqAYVRRRYFEKl0P28s0eBKbWRUw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7HiEwHnZM7xnzB+fEIcLK8HwXTBxs+8xP26XHZCk5u8o59KJ
	Aw/EOwHEyownyYxpdx3/R2xgi6HMhNVqn27+w1azKTpX2YoCAluZDe7PmyerpsY1PnU=
X-Gm-Gg: ASbGncuLbAUH/pNWHCk8/hmMn3FqY6GOR1jGSblcObrbeqyFG+sfN5HQ5fxwVT5/CCE
	3T1iU+OOKiEi2NU6IYdt9u0/vr+MYstWwzinsi6MADkOpoTtA5hDqZQjw97PKQY7OF+7NhGBc72
	NTAGPoZZdvu/MhX4LRYhm4hojsl3oQOdB3ru6BilivWq4mynhg5tilg4sdu4GMlEgyoFrWAR2h+
	A8Xz/IvA2kPbnKPqyFBsEp/Fd7un7GDRZ721aEZ8iXcRhEodZIffqY5Zvn94tLWxAxdBtVFzrDM
	HMNma92DurL/S1+T+ZHpTRtHVdAG9ae7iFzLet1xlKUf+r5bFTSTEHaoS8MWHrZGtoBzctpiGjQ
	RyDO9yiTTomWd6pwPutgQXXZMcDKCm5KCaO1tPlNMVQKQ3vzgQNc=
X-Google-Smtp-Source: AGHT+IEfAkHVShe9CPNkRZGQbs+1MjglumA6TomckplQ/ftAv4zh1ZkAZVKnMOTEnyD4faDMTqk0Wg==
X-Received: by 2002:a05:6000:2307:b0:3df:c5e3:55f8 with SMTP id ffacd0b85a97d-3ee872332abmr3632617f8f.54.1758319933208;
        Fri, 19 Sep 2025 15:12:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26e2046788dsm13313285ad.72.2025.09.19.15.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 15:12:12 -0700 (PDT)
Message-ID: <a30d07f6-0aa8-416f-9430-70826a76b489@suse.com>
Date: Sat, 20 Sep 2025 07:42:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: annotate btrfs_is_testing() as unlikely and make
 it return bool
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <eebf22439d2422d36703ab3bc7191f382605b8a4.1758272653.git.fdmanana@suse.com>
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
In-Reply-To: <eebf22439d2422d36703ab3bc7191f382605b8a4.1758272653.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/19 19:42, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We can annotate btrfs_is_testing() as unlikely since that's the most
> expected scenario and it's desirable for the compiler to optimize for
> the case we are not running the self tests. So add the annotation to
> btrfs_is_testing() and while at it also make it return bool instead of
> int.
> 
> Also make two of the existing callers use btrfs_is_testing() directly
> instead of storing its result in a local variable.
> 
> On x86_64 with Debian's gcc 14.2.0-19 this resulted in a very tiny object
> code reduction.
> 
> Before this change:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1913263	 161567	  15592	2090422	 1fe5b6	fs/btrfs/btrfs.ko
> 
> After this change:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1913257	 161567	  15592	2090416	 1fe5b0	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/delayed-ref.c | 7 +++----
>   fs/btrfs/disk-io.c     | 3 +--
>   fs/btrfs/fs.h          | 8 ++++----
>   3 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 6170803d8a1b..481802efaa14 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1251,7 +1251,6 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
>   {
>   	struct btrfs_delayed_ref_root *delayed_refs = &trans->delayed_refs;
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
> -	bool testing = btrfs_is_testing(fs_info);
>   
>   	spin_lock(&delayed_refs->lock);
>   	while (true) {
> @@ -1281,7 +1280,7 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
>   		spin_unlock(&delayed_refs->lock);
>   		mutex_unlock(&head->mutex);
>   
> -		if (!testing && pin_bytes) {
> +		if (!btrfs_is_testing(fs_info) && pin_bytes) {
>   			struct btrfs_block_group *bg;
>   
>   			bg = btrfs_lookup_block_group(fs_info, head->bytenr);
> @@ -1312,14 +1311,14 @@ void btrfs_destroy_delayed_refs(struct btrfs_transaction *trans)
>   			btrfs_error_unpin_extent_range(fs_info, head->bytenr,
>   				head->bytenr + head->num_bytes - 1);
>   		}
> -		if (!testing)
> +		if (!btrfs_is_testing(fs_info))
>   			btrfs_cleanup_ref_head_accounting(fs_info, delayed_refs, head);
>   		btrfs_put_delayed_ref_head(head);
>   		cond_resched();
>   		spin_lock(&delayed_refs->lock);
>   	}
>   
> -	if (!testing)
> +	if (!btrfs_is_testing(fs_info))
>   		btrfs_qgroup_destroy_extent_records(trans);
>   
>   	spin_unlock(&delayed_refs->lock);
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index a9e82e062bd5..5c57f523f449 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -639,7 +639,6 @@ static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
>   					   u64 objectid, gfp_t flags)
>   {
>   	struct btrfs_root *root;
> -	bool dummy = btrfs_is_testing(fs_info);
>   
>   	root = kzalloc(sizeof(*root), flags);
>   	if (!root)
> @@ -696,7 +695,7 @@ static struct btrfs_root *btrfs_alloc_root(struct btrfs_fs_info *fs_info,
>   	root->log_transid_committed = -1;
>   	btrfs_set_root_last_log_commit(root, 0);
>   	root->anon_dev = 0;
> -	if (!dummy) {
> +	if (!btrfs_is_testing(fs_info)) {
>   		btrfs_extent_io_tree_init(fs_info, &root->dirty_log_pages,
>   					  IO_TREE_ROOT_DIRTY_LOG_PAGES);
>   		btrfs_extent_io_tree_init(fs_info, &root->log_csum_range,
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index ba63a40b2bde..26b91edf239e 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -1126,9 +1126,9 @@ static inline void btrfs_wake_unfinished_drop(struct btrfs_fs_info *fs_info)
>   
>   #define EXPORT_FOR_TESTS
>   
> -static inline int btrfs_is_testing(const struct btrfs_fs_info *fs_info)
> +static inline bool btrfs_is_testing(const struct btrfs_fs_info *fs_info)
>   {
> -	return test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state);
> +	return unlikely(test_bit(BTRFS_FS_STATE_DUMMY_FS_INFO, &fs_info->fs_state));
>   }
>   
>   void btrfs_test_destroy_inode(struct inode *inode);
> @@ -1137,9 +1137,9 @@ void btrfs_test_destroy_inode(struct inode *inode);
>   
>   #define EXPORT_FOR_TESTS static
>   
> -static inline int btrfs_is_testing(const struct btrfs_fs_info *fs_info)
> +static inline bool btrfs_is_testing(const struct btrfs_fs_info *fs_info)
>   {
> -	return 0;
> +	return false;
>   }
>   #endif
>   


