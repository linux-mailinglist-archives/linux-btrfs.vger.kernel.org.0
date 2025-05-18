Return-Path: <linux-btrfs+bounces-14107-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC31ABB00F
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 May 2025 13:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 118FB1756DE
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 May 2025 11:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37C2192FA;
	Sun, 18 May 2025 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HgMthYJ0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637B212FB6
	for <linux-btrfs@vger.kernel.org>; Sun, 18 May 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747567560; cv=none; b=aoHKTP3vSAh+kz0xhe4UVrKc8cxmcHsT5sm+0JV4ve1RJFI3iKMkt5xU5Ev4hHzbZ6Ei/1gAmYoyTTG7jymzfFqMiio7UYJeVqn0JgKsEhPHB7e6dzCWekQuFE6zo2E/voblF/QvwpwBHluLQR5l+ueVhKhX89mgywvTiuoQlCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747567560; c=relaxed/simple;
	bh=2Cu/Qnjt6ZfojXq7DzMgyScQaBDjulrqRecCAeajtVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axaslnlaRjnmY1rNZPo2F0Ih3Yfyh/HnX8TY8OTOnqg+wNGdw60NCNVGfPTdhlOd2jJTW9XWp5Ata3yTfGU8AP+fubTyyLWeO0VVI+VcPTOJ15MDDH1Ns/qI3SgJJGx1L3x29FXbBnGRSzTO1Uku1Hd+nfJCj2jBrrA+D/beXhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HgMthYJ0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso33358005e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 18 May 2025 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747567555; x=1748172355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0zb2qIwPd54kyf/se+93zExfp9XXspBGANotLSGXEe4=;
        b=HgMthYJ0fRaLvpwfBFkpfCaCXFz+/1mePDyJAYrbq4/vCFu5ritI3xCkkSfOx/Tmf0
         CIyImkQP+KrprXq1vNZEe8ohnbt41CMuCAGYDur/edoJXkd+UcSZngK9N8RgiemcySqa
         VjUypo32P2Fz6UmGu4VOSSmIiOwdCBe3Autt4Ep5lz3n/7SID6f/aa1WQB6QPCl2QtLB
         nzpnu2IyxMLXJb+iO+OraLNeQ7Ih2My6ZZC0dfIo40K5Owu7rA+iXIoq48QJwF0fYe8+
         lC1/tU8N6fEs9vdyibErKiFfYKNwU2avlEDV5zpaYd1LziWvuxi6elmLl6GFVupc58/T
         5rNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747567555; x=1748172355;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zb2qIwPd54kyf/se+93zExfp9XXspBGANotLSGXEe4=;
        b=ff3QSG3/tqmoagl4d966JNw+Zh9mlZusk9qCQDdmlBauSezzbUcXyf1iyMD/swNHJL
         z6ioqJwVRG6grDOR2RFVX/GDF7WxQsu3TBexAifz+j4SNXiK75ET6/+lZ8i+Pv2BvlpC
         URB40IwBoAi4LTyNWMTCe/STSy8Nq4UurPuE3Yw0hmrY655VFrPMm8LRmTIb7WwxqoAK
         qHYqW5tW6dvc7ab/m9MJiForzBEOts5mV+3ESyr6SNf5NgC2diTp3lstOw7ToCs2XTBZ
         HT9WY5k3uwKFgS9HmYWXNN0u21wfa4y+WAi+PkHDcQbYbHr6ZmVY07Wd7gfydOeOibJ1
         bM6Q==
X-Gm-Message-State: AOJu0YwyuPQQF++SJrTjltGop63LOfKOIKAk2OIAQE8p0WnXdE4CroD6
	eAFGB6FDc7rCP2wl2y0KY6ZmBbgwt8lop2MweLTnL2CTPbFyUSJz2IiaqLptDspa8X8=
X-Gm-Gg: ASbGncumg+HszSxJAIasG4SV32ExWCWpHivm3BzBHQCJy/PbdMpC7QaezvmpZBKzoyG
	gH6pMEZFLp47+3N3BMwJI1LaMgA9o8YBzuw8vj0CIStXmvvNeDOubCr85PX0l4nDQRio500XMQ2
	AqnGtZ5d0186sgxwrKioarf9qV98onmcEkXXLy4bsf037wxVR5x5cHeKAn8F4qq8mAh4ydA2xux
	1oucIGgBEEfGgFpR34yfta52wZsIlxJwyBpomtVes2Jt4OSK4xPPr3mxyJ1iKKFgT2zomHa3C1y
	IvQkyzn/UT/ZyGoPmbTjrCs3mY/NVkguOQMKEStzOIvmxZ4qX8huC9XQ71BCIWKdqD8RFRtGMj/
	ImxQ=
X-Google-Smtp-Source: AGHT+IHlCEPVcAdJqhTnglHg6ThfBhkLGFh5HSNuswFbMKd+m4NMKHFrMdVLrIHpaSLDYdMndKg2+w==
X-Received: by 2002:a05:6000:1862:b0:3a0:aed9:e39 with SMTP id ffacd0b85a97d-3a35fe9514amr7550605f8f.28.1747567554474;
        Sun, 18 May 2025 04:25:54 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e7d4908d4sm4693264a91.19.2025.05.18.04.25.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 May 2025 04:25:53 -0700 (PDT)
Message-ID: <fd6b96af-7376-4008-9a76-7b2a0e050fef@suse.com>
Date: Sun, 18 May 2025 20:55:48 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] btrfs: remove nonzero lowest level handling in
 btrfs_search_forward()
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.cz
References: <2803405.mvXUDI8C0e@saltykitkat>
 <20250517134723.25843-1-sunk67188@gmail.com>
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
In-Reply-To: <20250517134723.25843-1-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/17 23:17, Sun YangKai 写道:
> Commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only
> checksums during truncate") changed the condition from `level == 0` to
> `level == path->lowest_level`, while its origional purpose is just to do
> some leaf nodes handling (calling btrfs_item_key_to_cpu()) and skip some
> code that doesn't fit leaf nodes.
> 
> After changing the condition, the code path
> 1. also handle the non-leaf nodes when path->lowest_level is nonzero,
>     which is wrong. However, it seems that btrfs_search_forward() is never
>     called with a nonzero path->lowest_level, which makes this bug not
>     found before.
> 2. makes the later if block with the same condition, which is origionally
>     used to handle non-leaf node (calling btrfs_node_key_to_cpu()) when
>     lowest_level is not zero, dead code.
> 
> Considering this function is never called with a nonzero
> path->lowest_path for years and the code handling this case is wrongly
> implemented, the path->lowest_level related logic is fully removed.



> 
> Related dead codes are also removed, and related goto logic is replaced
> with if conditions, which makes the code easier to read for new comers.
> 
> This changes the behavior when btrfs_search_forward() is called with
> nonzero path->lowest_level: now we will get a warning, and still use
> 0 as lowest_level. But since this never happens in the current codebase,
> and the previous behavior is wrong. So the behavior change of behavior
> will not be a problem.
> 
> The bevavior of the function called with a zero path->lowest_level, which
> is acturally how this function is used in current codebase, should be the
> same with previous version.
> 
> Fix: commit 323ac95bce44 ("Btrfs: don't read leaf blocks containing only checksums during truncate")
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>   fs/btrfs/ctree.c | 58 ++++++++++++++++++++++--------------------------
>   1 file changed, 26 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a2e7979372cc..32844277f2cd 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -4592,8 +4592,9 @@ int btrfs_del_items(struct btrfs_trans_handle *trans, struct btrfs_root *root,
>    * into min_key, so you can call btrfs_search_slot with cow=1 on the
>    * key and get a writable path.
>    *
> - * This honors path->lowest_level to prevent descent past a given level
> - * of the tree.
> + * This does not honor path->lowest_level any more because this
> + * function is never called with a nonzero path->lowest_level and the
> + * implementation of handling it in this function is broken for years.
This part is not helpful.

Saying something like "path->lowest_level must be 0" is more than enough.

>    *
>    * min_trans indicates the oldest transaction that you are interested
>    * in walking through.  Any nodes or leaves older than min_trans are
> @@ -4615,6 +4616,7 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
>   	int keep_locks = path->keep_locks;
>   
>   	ASSERT(!path->nowait);
> +	WARN_ON(path->lowest_level > 0);

For sanity check, ASSERT() is more useful, it crashes debug kernels 
early for developers.

And of course, you have to run full fstests with CONFIG_BTRFS_ASSERT 
enbaled to make sure the new ASSERT() is not triggered.


>   	path->keep_locks = 1;
>   again:
>   	cur = btrfs_read_lock_root_node(root);
> @@ -4636,38 +4638,29 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
>   			goto out;
>   		}
>   
> -		/* at the lowest level, we're done, setup the path and exit */
> -		if (level == path->lowest_level) {

Why not just change path->lowest_level to 0 here?

You now put the (level > 0) handling into a more complex block, which 
doesn't make much sense to me, as your purpose is to reject non-zero 
lowest_level for this function.

The diff looks way more complex than it should be.

If you want to further cleanup the code, please send out a dedicated 
patch after adding the  ASSERT() and simple "path->lowest_level"->"0" 
change (and remove the "level == path->lowest_level" check after 
find_next_key: tag).

Thanks,
Qu

> -			if (slot >= nritems)
> -				goto find_next_key;
> -			ret = 0;
> -			path->slots[level] = slot;
> -			/* Save our key for returning back. */
> -			btrfs_item_key_to_cpu(cur, min_key, slot);
> -			goto out;
> -		}
> -		if (sret && slot > 0)
> -			slot--;
> -		/*
> -		 * check this node pointer against the min_trans parameters.
> -		 * If it is too old, skip to the next one.
> -		 */
> -		while (slot < nritems) {
> -			u64 gen;
> -
> -			gen = btrfs_node_ptr_generation(cur, slot);
> -			if (gen < min_trans) {
> +		if (level > 0) {
> +			/*
> +			 * Not at the lowest level and not a perfect match,
> +			 * go one slot back if possible to search lower level.
> +			 */
> +			if (sret && slot > 0)
> +				slot--;
> +			/*
> +			 * Check this node pointer against the min_trans parameters.
> +			 * If it is too old, skip to the next one.
> +			 */
> +			while (slot < nritems) {
> +				if (btrfs_node_ptr_generation(cur, slot) >= min_trans)
> +					break;
>   				slot++;
> -				continue;
>   			}
> -			break;
>   		}
> -find_next_key:
> +
> +		path->slots[level] = slot;
>   		/*
> -		 * we didn't find a candidate key in this node, walk forward
> -		 * and find another one
> +		 * We didn't find a candidate key in this node, walk forward
> +		 * and find another one.
>   		 */
> -		path->slots[level] = slot;
>   		if (slot >= nritems) {
>   			sret = btrfs_find_next_key(root, path, min_key, level,
>   						  min_trans);
> @@ -4678,12 +4671,13 @@ int btrfs_search_forward(struct btrfs_root *root, struct btrfs_key *min_key,
>   				goto out;
>   			}
>   		}
> -		if (level == path->lowest_level) {
> +		/* At the lowest level, we're done. Set the key and exit. */
> +		if (level == 0) {
>   			ret = 0;
> -			/* Save our key for returning back. */
> -			btrfs_node_key_to_cpu(cur, min_key, slot);
> +			btrfs_item_key_to_cpu(cur, min_key, slot);
>   			goto out;
>   		}
> +		/* Search down to a lower level. */
>   		cur = btrfs_read_node_slot(cur, slot);
>   		if (IS_ERR(cur)) {
>   			ret = PTR_ERR(cur);


