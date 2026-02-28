Return-Path: <linux-btrfs+bounces-22114-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBiVN6Jio2myBQUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22114-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 22:48:18 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D741C9401
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 22:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8346316AE3B
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 20:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9562A2D781B;
	Sat, 28 Feb 2026 20:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NmbSyxzt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A03426C3BE
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772311026; cv=none; b=B776Rp9lw7k0Zzg5AtqjHKN7QJdZN9cD8AuCOiyOB70et8iOeP0reuOotAmF6jH6j/Ugp2as5tbij8l9JaE0oOEafKvpmzGQf/2DrduYHAeIkyCvbYLQyKnM8yaF4NqEl8dzc9WE2YgERSMHWDelXrZdEMw01HQIbKx1kNtC6T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772311026; c=relaxed/simple;
	bh=qX+mX02bg9Os5AIq0Z3ZS8CXIXhvKyPc3QAzLS9dmk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rot++gDSoN/ZtGiTKWc3bk/pDZeoPNOX+7ncCMpQZ/kD2eqv8ph9uhyPFL+LOKwtrtUTzPXUGXa0CoZ7vrz4O/QWs4nO53zyGGx1o0nZ/qE+S/hc6GRaHq4YzOwhMNks0PexTbQI2JhnTUobfWvDsjpbZFerS299labawnAMZ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NmbSyxzt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48069a48629so34512275e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 12:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772311024; x=1772915824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UhOPMUn3MDPjH/riefoLNYpJcYKlthTSrTs8DhurUXw=;
        b=NmbSyxztt6Eump8Jql5w+AMuQED4SPBA6zefhWe1pGS1YzLCI17ofcshN74csbI0Wh
         2j2JPpXiCRidqh1vxJjXfB65FdmuAWN5Zkc7MMz9ZkbTYxTwDsvTITP0wcZnOT/UV2ms
         UM8jIat7CbEv3frynCrRVf5Q150QLvY1xlTvRhm2w1VpbjwOkzqS58peSmJKpS8JNitO
         XwYj9gOsQe847GQIWTo/sYmHk6KDLNii1FeFesXErRCHt3LLUnhMhYD/Wieq37GtWjC4
         RBKHP1Vnnwm1bkJ5o+SgLwZWNKzNQVqZ3tDa6wZiR1WLwCN+y3UXkc92Xi51PmgFMe7h
         RaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772311024; x=1772915824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhOPMUn3MDPjH/riefoLNYpJcYKlthTSrTs8DhurUXw=;
        b=VzJMCYNyj4htE59N7KUDzmhpLQcd44u+0ce7b1j567o+EqPwzwXgwfw3sgZ/o5cw00
         jv7IGVx5SCG3pEna/1jDZJW5oA4bbixUhG7m+hdQW6Ng2VozVqBr7ogreP5U5M8Yx1/t
         tfRlQWDQnR5WF5yYrIzydp+1vz/+FTyqEV+7d7MTF0KBESbo4y7gDWcx/iLmJTFck1r2
         i+oxLQlJ5KAj520dZEODt/xTOnw7F+QVgYLJ9Hzboj7vwg7lP3Zsa683DZlNuonkhNJz
         e2x6QGJM7XdPszQ7qNmmCjgFRKs+RgLHvIbQ4v5jb4gYY0f/PtdJKYFGtsvLA9RMnQe1
         hnjA==
X-Forwarded-Encrypted: i=1; AJvYcCVG5lZJIJWDnojIvGfFnGzESO7Jcx8Zxy35fbg9xE02OV0Fdg9BQRb1Z+v/x6J5ogIBH7e80Vi1dody/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUYE0gb9JDf/4aT5w1nUxL/XxTRLANbpVdIXrSiSqETDSft5HK
	u9UPQPgHOCFAYAmGaxTCx5RHlg+OMSyI8IOHyCMpMl5rNGsXt2cQiHQhhkFOphx5Uy8=
X-Gm-Gg: ATEYQzx879DhSLsjPK6gvfwmUNxYQHR+gGi3Q0ZeSNkaGsebkSFxBDt4FMoQJ3hHFha
	DaT/WhaThVN779M/Vc4oCtvjHCYeXo7EugqdxvZPgfh9nVrLbPrGp45Mjz+dKI7aNVKLanO4fWz
	t/RPbSGsW7elDn06wr5RJG6FY5H9vSt7M5glu0VK8gcJuEX3wPBSGf3zeeknB4X6JWNhpqeiBrr
	V1MmaNywsf+2E9oYz2fgP18o9COlZ+2lSUP73YueCH5Jwi5fliJUPouXOF0XmTJd3xyu6+W+A4L
	s0N9WYY5qOTYULvzkaQ4uI9fcEvpgkaNEXGJ947tALN8+VRUX/keUz+ltEBOO3jOelqyU4L6ERo
	Z35zAs3GC3CAfH8KTfVeepUTOqD57mAsGXYl+sS8NljshBn8jA4fbYpobWsxxAXYAvBtAphvmdU
	6Z+OIIEITdS5Xv+EW8wgEoQLQDgwur5eEUPx30AVO88ngj8Cugn9o=
X-Received: by 2002:a05:600c:6994:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-483c9c0b88amr122717255e9.22.1772311023611;
        Sat, 28 Feb 2026 12:37:03 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b4177sm94307705ad.62.2026.02.28.12.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 12:37:03 -0800 (PST)
Message-ID: <dff3a75f-61d7-42a0-944a-e06118eab8af@suse.com>
Date: Sun, 1 Mar 2026 07:07:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] btrfs: replace BUG() and BUG_ON() with error
 handling in extent-tree.c
To: Adarsh Das <adarshdas950@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: terrelln@fb.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260228090621.100841-1-adarshdas950@gmail.com>
 <20260228090621.100841-3-adarshdas950@gmail.com>
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
In-Reply-To: <20260228090621.100841-3-adarshdas950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22114-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,fb.com,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 63D741C9401
X-Rspamd-Action: no action



在 2026/2/28 19:36, Adarsh Das 写道:
> v2:
> - use ASSERT() instead of btrfs_err() + -EUCLEAN
> - append ASSERTs in btrfs_add_delayed_data_ref() and btrfs_add_delayed_tree_ref() to validate action at insertion time instead of runtime
> - fold coding style fixes into this patch

The same problem as patch 1.

> 
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
> ---
>   fs/btrfs/delayed-ref.c |  8 ++++--
>   fs/btrfs/extent-tree.c | 62 ++++++++++++++++++++----------------------
>   2 files changed, 36 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/btrfs/delayed-ref.c b/fs/btrfs/delayed-ref.c
> index 3766ff29fbbb..d308c70228af 100644
> --- a/fs/btrfs/delayed-ref.c
> +++ b/fs/btrfs/delayed-ref.c
> @@ -1113,7 +1113,9 @@ int btrfs_add_delayed_tree_ref(struct btrfs_trans_handle *trans,
>   			       struct btrfs_ref *generic_ref,
>   			       struct btrfs_delayed_extent_op *extent_op)
>   {
> -	ASSERT(generic_ref->type == BTRFS_REF_METADATA && generic_ref->action);
> +	ASSERT(generic_ref->type == BTRFS_REF_METADATA &&
> +	       (generic_ref->action == BTRFS_ADD_DELAYED_REF ||
> +					generic_ref->action == BTRFS_DROP_DELAYED_REF));
>   	return add_delayed_ref(trans, generic_ref, extent_op, 0);
>   }
>   
> @@ -1124,7 +1126,9 @@ int btrfs_add_delayed_data_ref(struct btrfs_trans_handle *trans,
>   			       struct btrfs_ref *generic_ref,
>   			       u64 reserved)
>   {
> -	ASSERT(generic_ref->type == BTRFS_REF_DATA && generic_ref->action);
> +	ASSERT(generic_ref->type == BTRFS_REF_DATA &&
> +	       (generic_ref->action == BTRFS_ADD_DELAYED_REF ||
> +	        generic_ref->action == BTRFS_DROP_DELAYED_REF));
>   	return add_delayed_ref(trans, generic_ref, NULL, reserved);
>   }
>   
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 03cf9f242c70..98bdf51774c4 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -604,7 +604,7 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
>   		return -EUCLEAN;
>   	}
>   
> -	BUG_ON(num_refs < refs_to_drop);
> +	ASSERT(num_refs >= refs_to_drop);
>   	num_refs -= refs_to_drop;
>   
>   	if (num_refs == 0) {
> @@ -863,7 +863,7 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>   
>   	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK && !skinny_metadata) {
>   		ptr += sizeof(struct btrfs_tree_block_info);
> -		BUG_ON(ptr > end);
> +		ASSERT(ptr <= end);
>   	}
>   
>   	if (owner >= BTRFS_FIRST_FREE_OBJECTID)
> @@ -1237,7 +1237,7 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
>   {
>   	int ret = 0;
>   
> -	BUG_ON(!is_data && refs_to_drop != 1);
> +	ASSERT(is_data || refs_to_drop == 1);
>   	if (iref)
>   		ret = update_inline_extent_backref(trans, path, iref,
>   						   -refs_to_drop, NULL);
> @@ -1451,10 +1451,9 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>   	struct btrfs_fs_info *fs_info = trans->fs_info;
>   	int ret;
>   
> -	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
> -	       generic_ref->action);
> -	BUG_ON(generic_ref->type == BTRFS_REF_METADATA &&
> -	       generic_ref->ref_root == BTRFS_TREE_LOG_OBJECTID);
> +	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET && generic_ref->action);
> +	ASSERT(generic_ref->type != BTRFS_REF_METADATA ||
> +	       generic_ref->ref_root != BTRFS_TREE_LOG_OBJECTID);
>   
>   	if (generic_ref->type == BTRFS_REF_METADATA)
>   		ret = btrfs_add_delayed_tree_ref(trans, generic_ref, NULL);
> @@ -1621,8 +1620,6 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>   		ret = __btrfs_inc_extent_ref(trans, node, extent_op);
>   	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
>   		ret = __btrfs_free_extent(trans, href, node, extent_op);
> -	} else {
> -		BUG();
>   	}
>   	return ret;
>   }
> @@ -1639,7 +1636,7 @@ static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
>   
>   	if (extent_op->update_key) {
>   		struct btrfs_tree_block_info *bi;
> -		BUG_ON(!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK));
> +		ASSERT(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK);
>   		bi = (struct btrfs_tree_block_info *)(ei + 1);
>   		btrfs_set_tree_block_key(leaf, bi, &extent_op->key);
>   	}
> @@ -1774,8 +1771,6 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
>   			ret = drop_remap_tree_ref(trans, node);
>   		else
>   			ret = __btrfs_free_extent(trans, href, node, extent_op);
> -	} else {
> -		BUG();
>   	}
>   	return ret;
>   }
> @@ -2088,7 +2083,7 @@ static noinline int __btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
>   			 * head
>   			 */
>   			ret = cleanup_ref_head(trans, locked_ref, &bytes_processed);
> -			if (ret > 0 ) {
> +			if (ret > 0) {
>   				/* We dropped our lock, we need to loop. */
>   				ret = 0;
>   				continue;
> @@ -2645,7 +2640,7 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num_bytes
>   	struct btrfs_block_group *cache;
>   
>   	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
> -	BUG_ON(!cache); /* Logic error */
> +	ASSERT(cache);
>   
>   	pin_down_extent(trans, cache, bytenr, num_bytes, true);
>   
> @@ -4119,20 +4114,25 @@ static int do_allocation(struct btrfs_block_group *block_group,
>   			 struct find_free_extent_ctl *ffe_ctl,
>   			 struct btrfs_block_group **bg_ret)
>   {
> +	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
> +	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
>   	switch (ffe_ctl->policy) {
>   	case BTRFS_EXTENT_ALLOC_CLUSTERED:
>   		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
>   	case BTRFS_EXTENT_ALLOC_ZONED:
>   		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
> -	default:
> -		BUG();
>   	}
> +	return -EUCLEAN;
>   }
>   
>   static void release_block_group(struct btrfs_block_group *block_group,
>   				struct find_free_extent_ctl *ffe_ctl,
>   				bool delalloc)
>   {
> +	ASSERT(btrfs_bg_flags_to_raid_index(block_group->flags) ==
> +	       ffe_ctl->index);
> +	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
> +	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
>   	switch (ffe_ctl->policy) {
>   	case BTRFS_EXTENT_ALLOC_CLUSTERED:
>   		ffe_ctl->retry_uncached = false;
> @@ -4140,12 +4140,8 @@ static void release_block_group(struct btrfs_block_group *block_group,
>   	case BTRFS_EXTENT_ALLOC_ZONED:
>   		/* Nothing to do */
>   		break;
> -	default:
> -		BUG();
>   	}
>   
> -	BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
> -	       ffe_ctl->index);
>   	btrfs_release_block_group(block_group, delalloc);
>   }
>   
> @@ -4164,6 +4160,8 @@ static void found_extent_clustered(struct find_free_extent_ctl *ffe_ctl,
>   static void found_extent(struct find_free_extent_ctl *ffe_ctl,
>   			 struct btrfs_key *ins)
>   {
> +	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
> +	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
>   	switch (ffe_ctl->policy) {
>   	case BTRFS_EXTENT_ALLOC_CLUSTERED:
>   		found_extent_clustered(ffe_ctl, ins);
> @@ -4171,8 +4169,6 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
>   	case BTRFS_EXTENT_ALLOC_ZONED:
>   		/* Nothing to do */
>   		break;
> -	default:
> -		BUG();
>   	}
>   }
>   
> @@ -4232,14 +4228,15 @@ static int can_allocate_chunk_zoned(struct btrfs_fs_info *fs_info,
>   static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
>   			      struct find_free_extent_ctl *ffe_ctl)
>   {
> +	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
> +	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
>   	switch (ffe_ctl->policy) {
>   	case BTRFS_EXTENT_ALLOC_CLUSTERED:
>   		return 0;
>   	case BTRFS_EXTENT_ALLOC_ZONED:
>   		return can_allocate_chunk_zoned(fs_info, ffe_ctl);
> -	default:
> -		BUG();
>   	}
> +	return -EUCLEAN;
>   }
>   
>   /*
> @@ -4310,8 +4307,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
>   			if (ret == -ENOSPC) {
>   				ret = 0;
>   				ffe_ctl->loop++;
> -			}
> -			else if (ret < 0)
> +			} else if (ret < 0)
>   				btrfs_abort_transaction(trans, ret);
>   			else
>   				ret = 0;
> @@ -4441,15 +4437,16 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
>   			      struct btrfs_space_info *space_info,
>   			      struct btrfs_key *ins)
>   {
> +	ASSERT(ffe_ctl->policy == BTRFS_EXTENT_ALLOC_CLUSTERED ||
> +	       ffe_ctl->policy == BTRFS_EXTENT_ALLOC_ZONED);
>   	switch (ffe_ctl->policy) {
>   	case BTRFS_EXTENT_ALLOC_CLUSTERED:
>   		return prepare_allocation_clustered(fs_info, ffe_ctl,
>   						    space_info, ins);
>   	case BTRFS_EXTENT_ALLOC_ZONED:
>   		return prepare_allocation_zoned(fs_info, ffe_ctl, space_info);
> -	default:
> -		BUG();
>   	}
> +	return -EUCLEAN;
>   }
>   
>   /*
> @@ -5260,6 +5257,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>   	bool skinny_metadata = btrfs_fs_incompat(fs_info, SKINNY_METADATA);
>   	u64 owning_root;
>   
> +	ASSERT(parent <= 0);
> +
>   #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>   	if (btrfs_is_testing(fs_info)) {
>   		buf = btrfs_init_new_buffer(trans, root, root->alloc_bytenr,
> @@ -5292,8 +5291,7 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>   			parent = ins.objectid;
>   		flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
>   		owning_root = reloc_src_root;
> -	} else
> -		BUG_ON(parent > 0);
> +	}
>   
>   	if (root_objectid != BTRFS_TREE_LOG_OBJECTID) {
>   		struct btrfs_delayed_extent_op *extent_op;
> @@ -5633,7 +5631,7 @@ static int check_ref_exists(struct btrfs_trans_handle *trans,
>   		 * If we get 0 then we found our reference, return 1, else
>   		 * return the error if it's not -ENOENT;
>   		 */
> -		return (ret < 0 ) ? ret : 1;
> +		return (ret < 0) ? ret : 1;
>   	}
>   
>   	/*
> @@ -6437,7 +6435,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>   	int parent_level;
>   	int ret = 0;
>   
> -	BUG_ON(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID);
> +	ASSERT(btrfs_root_id(root) == BTRFS_TREE_RELOC_OBJECTID);
>   
>   	path = btrfs_alloc_path();
>   	if (!path)


