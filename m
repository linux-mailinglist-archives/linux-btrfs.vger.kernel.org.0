Return-Path: <linux-btrfs+bounces-17244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF8CBA8540
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 09:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88547189C8A8
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37FD261B92;
	Mon, 29 Sep 2025 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AfRnrkij"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5B225397
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132474; cv=none; b=njIkHh23e+B3+MZ0bmNzKlkmgJhxeEgSY1xR3bPOagN2LvYz9Nmiwfh778sRkr623neeAkrDB+jjQ6qoj8ihO9UEJ9U8AlKdSU56hlULKscIxHipE8+3v65lHZyvoiTv/dweUaYVOWBS273knoKwNSegGNUG/xSOhRpcsxSLD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132474; c=relaxed/simple;
	bh=/rGJNYa2on9hPlUbsjJLkJ9sW+OuoKBxNd9TnJqWEME=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZRBesfNieMYblHYYVa7mL5CMR0atW98JhJTTvPYCEb5LGDpgp192+cs5FExBFVTvmTwFJ3Mq3ydre0uqRv1qoM3UW6aKP8/82+lsHOx11XPMlA7Tgkebd1sUs1gvtHR5tKFkGXRkUg9pMrqyQa/GwgOnfXm+HUL25rtxjWCXnFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AfRnrkij; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so3691080f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Sep 2025 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759132470; x=1759737270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ev/uwTA01eAb8/zW/W1RMcPA6NjIFrDe11pHjKPYh+I=;
        b=AfRnrkijNkv+pUoOBSAXwiFrQoyv6cDRfSz9HW6FjqlycsRH5rdbE40b5clmAeD+y4
         EP9M6VYEZYzDRtwfowFHgTCHHXSu/T2wpIMxwpkJJsxl6wfiNrXqwQB9iVHSHzzMrczy
         oTQki7ZxNKilBp7HarG1X4woftBQhvFbUTHfvQkHsBTgAOg7/bAd27jBZJKtBC1mZaRj
         cbLQggzLungP8vrOBUGBeI+GWOUZlo2+OKTGhE5xwH7Dtcvl/SFkLyvhFBRFwwqZ/zpI
         RXXj+1Jv1AUbZNz+Oz9qO/5oGBFERyQDqG8uT8318aNttUBgz7jnIDRAxrvstq1kQCbQ
         VP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132470; x=1759737270;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ev/uwTA01eAb8/zW/W1RMcPA6NjIFrDe11pHjKPYh+I=;
        b=tEgJPmRgpcnha4/K+5+pE7CtMFR8uDZeXMbUJVT3V+hQ1wq6j1yWrVGxwq0TPeUCPr
         qPF75yfsDMMhJdR1jATdqH0W0bjZtdlJkp+o2BdG665OkxVxhBDfhne4s/5c/DRye3Yn
         Xuu7513uAXs7Cyv4O5kpmFhd985HWkP9rHhndy4z1OY2DTcP24eHJXHIIcYT7m+LEI7y
         ILXF/GaxauhZ8qz+D1O1xeSCJN/yDI+AYyY/K+7yRyLrWy2oqXXWYtTM6usKsps1QC0c
         O2puXENvsdPNMrpJ514bXGXDKTJAYjfp3rnJCddJChK3I4CfZgfdz/fiVt5hdaSueuoy
         cBJw==
X-Forwarded-Encrypted: i=1; AJvYcCUonmHGqSFiRl/G8t2ShRh4GtcDOzTIarxRqRMUsxbaZPbfUqyo8YTgxG3RqF7PMo6bym+yF6IHZ2wOPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJi9zRbvJU4cJ391OepkUSXlER8BPvDYMiTB1demGRAWo/F0X2
	20+qt4q8PcejqpZ7zXqzqBGekdrkQ0QEnAWXvlwQqxDlnPaqJmiz6EL0VUi++c+juXLbwoosEOC
	ZgSMd
X-Gm-Gg: ASbGncs/H71Qk8mHG+u0xA9NMBGIaDFY0MkvGM38ur1yQlI62eio1ArgTmw10m9Abh4
	nGvBq7c5oBAyIIJTtwvvCK9R3zWQBXhcvR36AZW1/atRibHCRcDxy8ojs9j69R2CAxJCwCYwo5r
	opQudi6atj1V4oyv5KRgMHPy3YgItLG4WKsj7hCU7CbaMRGIWJdfym3XAptjiOso/W+5ADeMIJi
	UFxCt8g6O1nD0Ngbtng/0vqJjOMYpEgxXwl9sFk1lLuWlALHFCOmUwy48C/hXxB1kMxpetn241A
	CgEfqggpLlepo1YrrFDRpcIx3HNMNp29ulClRsLnStx3ZyHX/KHnwYkc8Zgv4d6LP0mSThiRCHs
	GeiNIsLNs8KE8Pw5U3ByxYq5pl7S1L/cZDqLEC1bRwatJRGSDEHM=
X-Google-Smtp-Source: AGHT+IH23BI+EwKvLU7BI1UGNhiQZnzijwcV4qjj2p2563y4j95h0+ZGrKHUdFBjinX+adqLX20lXQ==
X-Received: by 2002:a05:6000:2584:b0:3fc:cb54:b083 with SMTP id ffacd0b85a97d-40e4886df36mr14211680f8f.31.1759132470297;
        Mon, 29 Sep 2025 00:54:30 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be148e8sm16224290a91.16.2025.09.29.00.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 00:54:29 -0700 (PDT)
Message-ID: <eb37da47-2a32-4ff1-9c63-b97a69cc019d@suse.com>
Date: Mon, 29 Sep 2025 17:24:26 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: reorganize error handling in
 btrfs_tree_mod_log_insert_key
To: Sun YangKai <sunk67188@gmail.com>, linux-btrfs@vger.kernel.org
References: <20250929065802.2748-1-sunk67188@gmail.com>
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
In-Reply-To: <20250929065802.2748-1-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/29 16:26, Sun YangKai 写道:
> Restructure the error handling flow in btrfs_tree_mod_log_insert_key
> to address memory allocation failures more cleanly.
> 
> No functional changes are made - this is purely a code readability
> improvement.
> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>   fs/btrfs/tree-mod-log.c | 17 +++++++----------
>   1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/tree-mod-log.c b/fs/btrfs/tree-mod-log.c
> index 9e8cb3b7c064..4fd7859ad7dc 100644
> --- a/fs/btrfs/tree-mod-log.c
> +++ b/fs/btrfs/tree-mod-log.c
> @@ -267,9 +267,8 @@ int btrfs_tree_mod_log_insert_key(const struct extent_buffer *eb, int slot,
>   	if (!tree_mod_need_log(eb->fs_info, eb))
>   		return 0;
>   
> +	/* Allocation error is handled later. */
>   	tm = alloc_tree_mod_elem(eb, slot, op);
> -	if (!tm)
> -		ret = -ENOMEM;
>   
>   	if (tree_mod_dont_log(eb->fs_info, eb)) {
>   		kfree(tm);
> @@ -278,16 +277,14 @@ int btrfs_tree_mod_log_insert_key(const struct extent_buffer *eb, int slot,
>   		 * need to log.
>   		 */
>   		return 0;
> -	} else if (ret != 0) {
> -		/*
> -		 * We previously failed to allocate memory and we need to log,
> -		 * so we have to fail.
> -		 */
> -		goto out_unlock;
>   	}
>   
> -	ret = tree_mod_log_insert(eb->fs_info, tm);
> -out_unlock:
> +	/* Deal with allocation error. */
> +	if (tm)
> +		ret = tree_mod_log_insert(eb->fs_info, tm);

Sorry, I don't think this is really that better.

In fact I'm wondering why we don't delay the allocation after 
tree_mod_dont_log()?

That would be way more straightforward.

Thanks,
Qu
> +	else
> +		ret = -ENOMEM;
> +
>   	write_unlock(&eb->fs_info->tree_mod_log_lock);
>   	if (ret)
>   		kfree(tm);


