Return-Path: <linux-btrfs+bounces-22081-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eM2bFMAComnPyAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22081-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:46:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5AC1BDEC0
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 646D2319FB70
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 20:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84AA477E59;
	Fri, 27 Feb 2026 20:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JeVGSTRK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E1847885C
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772225005; cv=none; b=u+Hej1E9L/pxXDG+h9tvAmo5ObF1lDLnwhqTaRVNBg+RXPAmcvz9fsw8saE8Z8X8OFAOB9eXPWIEDMGS5oEV1QrHj+C4qHEa0ivwrJQ14/b+uTOYNM1q3l8xRYpeBMlBWETPSBkKs2GRo8QAqDeBT+Gs6O7Weg8JHOosYm1TmbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772225005; c=relaxed/simple;
	bh=HqC/uWBufTMFfp6CG2UdCe8HnI0pXJbcWS68k/R/2N4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n851tmzjtPvl7PUngWHgeV15S939yMHBY/zeB5cFt166Gy3kPdPvhlrao/6LFz4a6Oc0Wlg1ZfR3g4mAF2kwWHyTgNJ6ZXLE6UllTWcxKMrN/t/tQBUTIQYBgg0x1lJXruFoMXFb7wWYpVo7fNal0bs5JyIZBfYU4+pmjLjgpTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JeVGSTRK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48378136adcso14579825e9.1
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 12:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772225001; x=1772829801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tfHF0PK3LdeWFEKsMmNrFfx88zcWC0xZHr2EiYRcbcg=;
        b=JeVGSTRK80Olmsq+X/bRAvjQI8/EwQGhKkl9ZYMUOi8qOh/jjP+CcXb9d5wdE27RDw
         gbIESz0eHJHLwEGQvDxIRqhuUg+ChsFk4DT2NrK5+5UtazdwGv0qZLXWsouJOTK8rnmB
         mhQ+2l1lGIQOiLFyYCgkMv/5ghpyxcwRiQsvrZwIcL4N7we4tB2qR2Vo923P41+FHH/c
         EFnAsM1+r988C2LqkXgR5XLiBDJS+Ruaszix4JNwhLtyrUGhEcoLW8V1J4QuUnii2IqT
         86JZ6gFGI5v238HCaJGPENiUo0N8W2C8/MmBzv4oyeFgjKI2TByqSy94tx7rqugRGMz/
         yC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772225001; x=1772829801;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tfHF0PK3LdeWFEKsMmNrFfx88zcWC0xZHr2EiYRcbcg=;
        b=Nz7CXeHSbbJYlW8da6tGFr4oZlD1Sf2RG3mRppjiG8q3zJYIgZWujKuazmPK2cmAoo
         baUYy2vjo7gEOlfcxB64k7f86UJ/t3nHtTv2iK8xNTqZ4S1XISCt8JAF31K9BOSxqNV4
         WM7NDmhARvIJYIBsJfhJzQzQNaFfxV/pagJeGuTbfSScIXXwsfqQegrY6xDDx0wsl/Ux
         VDJJXWXaqLBCpBR/De8GhlovSrakMrj4CBAEF4YvD89quS6eHCPOKaDyuVti8jqnL7q4
         NzY+sgQ+ezeKwE+qx4DZDgnze6mTRDdxXf+BjATPtHrtzBj8Qi254dzVd9q66thzLNtc
         7RGg==
X-Forwarded-Encrypted: i=1; AJvYcCW5UWJw7kznLe+bdqoxoKJpIipjmxqTu/SRc08729qnYoeUbRDIZdratsCNq4ECcGbEoOQen6e5bckTUA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9CZw80O78yJDClGo+EAVvM/p9d9KQf1bR8lCRczshHnl4JLrv
	kjBJJL8x1dvCeuq4qU1SrNAnoJ3UE6oOcNHxLoZEyQVLEEZnWbDuspsE7d3k3j3Q+ww=
X-Gm-Gg: ATEYQzy14bB5Q6ZtL6lbzf0O/2WolUbqK/4u6XU+2tBfoEm7hqFCIsXBrDzQPW+yxij
	q79zu/5Vp5A9j0ob6FcfDtNWe4sledtF1/UtqvgJyR4XL1bdTaq6v7DMLLyptbVbg1VUXuV0MAq
	qWgqz/lsQMCfYwbknTsSsfyQsM/eluIotPNksW/rC7mXirk9KnF2IDCIYyMdgE+aaGQhaCSgRKQ
	SL7tym0zt188YFSTs8a4FhvYlm6V7XRZw2pcQRrQvyi1n4id5WxS+6pse0GmcpNuurDEocDA6bB
	STkFMUpwAKv9a/xdKJDDjO87PDhWkdp959HcdnNWz5NcnSVb2qtk2CYQJb6N3BCn/seWmLC5rPC
	EVg+H6DMpA+PaI4qZVnaT9RWld0khaCQkpTbGp1tWxSH+z4HsKhjKVQ9b2kauGxWXgz7MHkR+ww
	CcUcWQ0hTjECWK8mBM5qDY1Uyow3LsnkA86LEIdj1KmJvRMog9BKc=
X-Received: by 2002:a05:600c:6488:b0:47a:814c:ee95 with SMTP id 5b1f17b1804b1-483c9bbcdfemr71990695e9.12.1772225001239;
        Fri, 27 Feb 2026 12:43:21 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5b2296sm66591335ad.5.2026.02.27.12.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 12:43:20 -0800 (PST)
Message-ID: <40c3aea8-efac-4480-bef5-a00e917468cd@suse.com>
Date: Sat, 28 Feb 2026 07:13:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] btrfs: replace BUG() and BUG_ON() with error handling
 in extent-tree.c
To: Adarsh Das <adarshdas950@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: terrelln@fb.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227183111.9311-1-adarshdas950@gmail.com>
 <20260227183111.9311-4-adarshdas950@gmail.com>
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
In-Reply-To: <20260227183111.9311-4-adarshdas950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22081-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: DD5AC1BDEC0
X-Rspamd-Action: no action



在 2026/2/28 05:01, Adarsh Das 写道:
> Replace BUG() and BUG_ON() calls with proper error handling instead
> of crashing the kernel. Use btrfs_err() and return -EUCLEAN where
> fs_info is available, and WARN_ON() with an error return where it
> is not or where the condition is a programming bug rather than
> on-disk corruption.
> 
> Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
> ---
>   fs/btrfs/extent-tree.c | 82 ++++++++++++++++++++++++++++++++----------
>   1 file changed, 63 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 03cf9f242c70..9748a4c5bc2d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -604,7 +604,13 @@ static noinline int remove_extent_data_ref(struct btrfs_trans_handle *trans,
>   		return -EUCLEAN;
>   	}
>   
> -	BUG_ON(num_refs < refs_to_drop);
> +	if (unlikely(num_refs < refs_to_drop)) {
> +		btrfs_err(trans->fs_info,
> +			  "dropping more refs than available, have %u want %u",
> +			  num_refs, refs_to_drop);
> +		btrfs_abort_transaction(trans, -EUCLEAN);
> +		return -EUCLEAN;
> +	}
>   	num_refs -= refs_to_drop;
>   
>   	if (num_refs == 0) {
> @@ -863,7 +869,13 @@ int lookup_inline_extent_backref(struct btrfs_trans_handle *trans,
>   
>   	if (flags & BTRFS_EXTENT_FLAG_TREE_BLOCK && !skinny_metadata) {
>   		ptr += sizeof(struct btrfs_tree_block_info);
> -		BUG_ON(ptr > end);
> +		if (unlikely(ptr > end)) {
> +			btrfs_err(
> +				fs_info,

Please put @fs_info in the same line of "btrfs_err(", there is 
definitely enough space for it.

> +				"extent item overflow at slot %d, ptr %lu end %lu",
> +				path->slots[0], ptr, end);
> +			return -EUCLEAN;
> +		}

And I don't think we even need to have this handling.
If the size is not correct, it should be caught by tree-checker first, 
and that will provide better debug output normally.

Normally it can be replaced by an ASSERT().

>   	}
>   
>   	if (owner >= BTRFS_FIRST_FREE_OBJECTID)
> @@ -1237,7 +1249,12 @@ static int remove_extent_backref(struct btrfs_trans_handle *trans,
>   {
>   	int ret = 0;
>   
> -	BUG_ON(!is_data && refs_to_drop != 1);
> +	if (unlikely(!is_data && refs_to_drop != 1)) {
> +		btrfs_err(trans->fs_info,
> +			  "invalid refs_to_drop %d for tree block, must be 1",
> +			  refs_to_drop);
> +		return -EUCLEAN;
> +	}

This is more like a runtime sanity checks, and we do not want it to be 
just ignored (although it will also flips the fs RO and noisy enough for 
most cases).

When this happens it's definitely some logical not correct.

I'd prefer it to be changed to ASSERT().

>   	if (iref)
>   		ret = update_inline_extent_backref(trans, path, iref,
>   						   -refs_to_drop, NULL);
> @@ -1453,8 +1470,9 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>   
>   	ASSERT(generic_ref->type != BTRFS_REF_NOT_SET &&
>   	       generic_ref->action);
> -	BUG_ON(generic_ref->type == BTRFS_REF_METADATA &&
> -	       generic_ref->ref_root == BTRFS_TREE_LOG_OBJECTID);
> +	if (WARN_ON(generic_ref->type == BTRFS_REF_METADATA &&
> +		    generic_ref->ref_root == BTRFS_TREE_LOG_OBJECTID))
> +		return -EINVAL;

Again it's a wrong logic, ASSERT() would be enough, especially the 
previous check is also an ASSERT().

>   
>   	if (generic_ref->type == BTRFS_REF_METADATA)
>   		ret = btrfs_add_delayed_tree_ref(trans, generic_ref, NULL);
> @@ -1622,7 +1640,9 @@ static int run_delayed_data_ref(struct btrfs_trans_handle *trans,
>   	} else if (node->action == BTRFS_DROP_DELAYED_REF) {
>   		ret = __btrfs_free_extent(trans, href, node, extent_op);
>   	} else {
> -		BUG();
> +		btrfs_err(trans->fs_info, "unexpected delayed ref action %d",
> +			  node->action);
> +		return -EUCLEAN;

There is already an ASSERT() in add_delayed_data_ref(), you can enhance 
that check and replace the BUG() with ASSERT().

>   	}
>   	return ret;
>   }
> @@ -1639,7 +1659,8 @@ static void __run_delayed_extent_op(struct btrfs_delayed_extent_op *extent_op,
>   
>   	if (extent_op->update_key) {
>   		struct btrfs_tree_block_info *bi;
> -		BUG_ON(!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK));
> +		if (WARN_ON(!(flags & BTRFS_EXTENT_FLAG_TREE_BLOCK)))
> +			return;

You can grab the fs_info from @leaf.

And I don't like just pure warning in this case.
You can enhance __run_delayed_extent_op() to return an error code.

Furthermore you can fix the code style problem here, no need for a 
dedicated patch just to fix those minor new line problems.

As it's already mentioned in our guideline:
https://btrfs.readthedocs.io/en/latest/dev/Developer-s-FAQ.html#how-not-to-start

 >> If you care so much about the whitespace/style issues, just fix them 
while doing a useful change as mentioned above that happens to touch the 
same code.



>   		bi = (struct btrfs_tree_block_info *)(ei + 1);
>   		btrfs_set_tree_block_key(leaf, bi, &extent_op->key);
>   	}
> @@ -1775,7 +1796,9 @@ static int run_delayed_tree_ref(struct btrfs_trans_handle *trans,
>   		else
>   			ret = __btrfs_free_extent(trans, href, node, extent_op);
>   	} else {
> -		BUG();
> +		btrfs_err(trans->fs_info, "unexpected delayed ref action %d",
> +			  node->action);
> +		return -EUCLEAN;

The same, do more validation at insert time, the earlier detection the 
more usefulness it provides.

>   	}
>   	return ret;
>   }
> @@ -2645,7 +2668,11 @@ int btrfs_pin_extent(struct btrfs_trans_handle *trans, u64 bytenr, u64 num_bytes
>   	struct btrfs_block_group *cache;
>   
>   	cache = btrfs_lookup_block_group(trans->fs_info, bytenr);
> -	BUG_ON(!cache); /* Logic error */
> +	if (unlikely(!cache)) {
> +		btrfs_err(trans->fs_info,
> +			  "unable to find block group for bytenr %llu", bytenr);
> +		return -EUCLEAN;
> +	}
>   
>   	pin_down_extent(trans, cache, bytenr, num_bytes, true);
>   
> @@ -4125,7 +4152,9 @@ static int do_allocation(struct btrfs_block_group *block_group,
>   	case BTRFS_EXTENT_ALLOC_ZONED:
>   		return do_allocation_zoned(block_group, ffe_ctl, bg_ret);
>   	default:
> -		BUG();
> +		btrfs_err(block_group->fs_info, "invalid allocation policy %d",
> +			  ffe_ctl->policy);
> +		return -EUCLEAN;

ASSERT() is more suitable here, the policy is not from on-disk data but 
purely from runtime code.

Unknown policy means some code is passing wrong numbers.
ASSERT() is more suitable.

This error message vs ASSERT() applies to all the remaining changes.

Thanks,
Qu

>   	}
>   }
>   
> @@ -4141,11 +4170,20 @@ static void release_block_group(struct btrfs_block_group *block_group,
>   		/* Nothing to do */
>   		break;
>   	default:
> -		BUG();
> +		btrfs_err(block_group->fs_info, "invalid allocation policy %d",
> +			  ffe_ctl->policy);
> +		goto release;
> +	}
> +
> +	if (unlikely(btrfs_bg_flags_to_raid_index(block_group->flags) !=
> +		     ffe_ctl->index)) {
> +		btrfs_err(block_group->fs_info,
> +			  "mismatched raid index, block group flags %llu index %d",
> +			  block_group->flags, ffe_ctl->index);
> +		goto release;
>   	}
>   
> -	BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
> -	       ffe_ctl->index);
> +release:
>   	btrfs_release_block_group(block_group, delalloc);
>   }
>   
> @@ -4172,7 +4210,8 @@ static void found_extent(struct find_free_extent_ctl *ffe_ctl,
>   		/* Nothing to do */
>   		break;
>   	default:
> -		BUG();
> +		WARN_ONCE(1, "invalid allocation policy %d", ffe_ctl->policy);
> +		return;
>   	}
>   }
>   
> @@ -4238,7 +4277,9 @@ static int can_allocate_chunk(struct btrfs_fs_info *fs_info,
>   	case BTRFS_EXTENT_ALLOC_ZONED:
>   		return can_allocate_chunk_zoned(fs_info, ffe_ctl);
>   	default:
> -		BUG();
> +		btrfs_err(fs_info, "invalid allocation policy %d",
> +			  ffe_ctl->policy);
> +		return -EUCLEAN;
>   	}
>   }
>   
> @@ -4448,7 +4489,9 @@ static int prepare_allocation(struct btrfs_fs_info *fs_info,
>   	case BTRFS_EXTENT_ALLOC_ZONED:
>   		return prepare_allocation_zoned(fs_info, ffe_ctl, space_info);
>   	default:
> -		BUG();
> +		btrfs_err(fs_info, "invalid allocation policy %d",
> +			  ffe_ctl->policy);
> +		return -EUCLEAN;
>   	}
>   }
>   
> @@ -5292,8 +5335,8 @@ struct extent_buffer *btrfs_alloc_tree_block(struct btrfs_trans_handle *trans,
>   			parent = ins.objectid;
>   		flags |= BTRFS_BLOCK_FLAG_FULL_BACKREF;
>   		owning_root = reloc_src_root;
> -	} else
> -		BUG_ON(parent > 0);
> +	} else if (WARN_ON(parent > 0))
> +		return ERR_PTR(-EINVAL);
>   
>   	if (root_objectid != BTRFS_TREE_LOG_OBJECTID) {
>   		struct btrfs_delayed_extent_op *extent_op;
> @@ -6437,7 +6480,8 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *trans,
>   	int parent_level;
>   	int ret = 0;
>   
> -	BUG_ON(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID);
> +	if (WARN_ON(btrfs_root_id(root) != BTRFS_TREE_RELOC_OBJECTID))
> +		return -EINVAL;
>   
>   	path = btrfs_alloc_path();
>   	if (!path)


