Return-Path: <linux-btrfs+bounces-10273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38E9EDAD7
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 00:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076CF18874BD
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Dec 2024 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389B1F2384;
	Wed, 11 Dec 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ANVFf47L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5708632B
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 23:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733958320; cv=none; b=e/+eHbm9WjJJkuPUuv3kwk+z7uusOaNZAGv2YUXvanQ0bbxLr1ZxJGGXO8Mqg8R1u+NqA/q6BpeU9dp4eDSS8MDkmCYTNNFhkZT9JMiV1Rb5cFzsDsF4/J1i6rgCJpX9w/vPXJXCSCXCA4CZX/4FdWbO0glNhex2ORLiM2q7/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733958320; c=relaxed/simple;
	bh=mL7MrRG+G/VCbMZnUvlbelBmJfflICTlm6aF/VJpVt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W8X2yKxu3FqynAK65nU3zhuX9otFahmTuWI8GBRH3Ko1kssdOtgEcR5AknQxo6Wr5+sYvjRzUrgqkn8W/w+UG0Km/l8e7j+ywd4JLf1OOYINmoH7Sh1cwIj/OwKUdCGlXXrchdpVreclufjfGZdn3pNFGsNJheYEtzLn6B/vJ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ANVFf47L; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so4781512f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 11 Dec 2024 15:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733958316; x=1734563116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UI1iXQwwXzr9466ttwgQnal+5UWWLNqSznuxDGZWA3k=;
        b=ANVFf47LgXQxPZuclxvmzOUU9XChrZXUwyPrhpqTZhY3BmVYxt3GDHo3H/ynPsZMoK
         kbrg1eI2Ar0g2WhSpfMyI5qGNBdiPWDKt1TeJ4pcA5XRSHeUUYazZKzYQQfgwy5gvI5k
         573rjuD5SJMqKkI8eILGTNqNdr3bTJVo1kj2ClF9iOiX6rTkx9i9ZTfCQdZ/SIwzy24O
         zBjjhvE4+ItW9g/8ViCfZEQZ1qZ0/+kiMZqogRiSJADQ9KFDh9JtSucPceB9NOFz889u
         fC2qCI1oArv26y12bZg8zasAGE86EV/Q7BtDJy2THfxQi8JhJTfbz7ICHkNkdn9wkxkY
         uUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733958316; x=1734563116;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UI1iXQwwXzr9466ttwgQnal+5UWWLNqSznuxDGZWA3k=;
        b=S3i3DRjgkOM3mHyiX3yAyZQvcVm8v5yunQyGRq98E2GBoKqDA3w4HQHcBmVc2G/2cM
         XkaYIBMQyVQoBXse01OO6PqR2brf2FbnYaO1PdIM9bOO7wLaVDrqFwdS2mu8X06UF6MO
         f1AiCzAetGQmuz86zS2Uj3WQKgJ26dld1vDybp9BDr8bQkt/ThoU6JWKb4Bq7H3GHfuL
         5k09cC0ZmpejP6X/oN/WX0uSscUmUy7+l0SqWo+2Il8t0wZ5PPXGquLifAGH6QhHYqi1
         6ThHTzS3eEakXe+usL3/Gm/5z+j3cSW1NPG1AM6PTpbkQPOmNWgz4u2Rw9XUIUDKchF1
         tGoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb3x2wSAn76pzEV4tZXfjddmho4Nl/G5JT00jdMhV4jx+yUbJv7AEg6bx3H+LQ+PzgWb6RyddxCK9/mA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWo9x/OVqEKj8ZbQLU5oi7kj/BllBpXyTTJqi2w4pxSvhr0Mk
	XdM+SmGSIUnIY+RFCcKhnHp/WYOuia0YNo1LDgKEs8umNa0IY8VcpK7iytmbhZOjJvurjUl7VI9
	y
X-Gm-Gg: ASbGncs4vn8Tnhv9Q4WWAL4unNJ6RCtE7dnQfxyu0NhWem3fTPHXHFiZRkyV8guP7Kf
	jUjzuWawL1ObLd5/D5KoJEPqnfusfwwwnJGAQHAz+GwS67NhAvssG1ZQRkD/JjoEbZ3hQmXzBsQ
	z+WB1I2lf69DdxQcDcC6KiLRp1wwRHd3I/liKWUzzkWCtMpO2o5bcq+qSYqzONSFW+zqPjoIOfk
	8w+mxpJqU/UNcTeNxBAlBpJUd2YkiPhIUmRyIhOEfNEEPkwDG0nBP0hOBRT8ep6+r/hiS0Xg1OE
	vrDlPw==
X-Google-Smtp-Source: AGHT+IH+kVPvPmmoTYaXEHdGSvgU1DeJmeIH0CZ2n6X//TU0RP44jbpoezyhkF0PMW3aF5fXpL5o1g==
X-Received: by 2002:a5d:6d8b:0:b0:386:45e9:fc8a with SMTP id ffacd0b85a97d-38787688349mr1036454f8f.5.1733958315457;
        Wed, 11 Dec 2024 15:05:15 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725e4c2defasm7087732b3a.120.2024.12.11.15.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 15:05:14 -0800 (PST)
Message-ID: <5448adb2-2368-4eb4-b7f4-9c36188529ad@suse.com>
Date: Thu, 12 Dec 2024 09:35:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: fix use-after-free when COWing tree bock and
 tracing is enabled
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <8e502fc69ea68d1647707d947e0e4625f0dd1af0.1733934886.git.fdmanana@suse.com>
 <1b96eb7eb9ce220acc21b2ac2057a5a3eab1fb3b.1733953828.git.fdmanana@suse.com>
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
In-Reply-To: <1b96eb7eb9ce220acc21b2ac2057a5a3eab1fb3b.1733953828.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/12 08:23, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When a COWing a tree block, at btrfs_cow_block(), and we have the
> tracepoint trace_btrfs_cow_block() enabled and preemption is also enabled
> (CONFIG_PREEMPT=y), we can trigger a use-after-free in the COWed extent
> buffer while inside the tracepoint code. This is because in some paths
> that call btrfs_cow_block(), such as btrfs_search_slot(), we are holding
> the last reference on the extent buffer @buf so btrfs_force_cow_block()
> drops the last reference on the @buf extent buffer when it calls
> free_extent_buffer_stale(buf), which schedules the release of the extent
> buffer with RCU. This means that if we are on a kernel with preemption,
> the current task may be preempted before calling trace_btrfs_cow_block()
> and the extent buffer already released by the time trace_btrfs_cow_block()
> is called, resulting in a use-after-free.
> 
> Fix this by moving the trace_btrfs_cow_block() from btrfs_cow_block() to
> btrfs_force_cow_block() before the COWed extent buffer is freed.
> This also has a side effect of invoking the tracepoint in the tree defrag
> code, at defrag.c:btrfs_realloc_node(), since btrfs_force_cow_block() is
> called there, but this is fine and it was actually missing there.
> 
> Reported-by: syzbot+8517da8635307182c8a5@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/6759a9b9.050a0220.1ac542.000d.GAE@google.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks for pinning down and fix the bug,
Qu

> ---
> 
> V2: Instead of temporarily bumping the extent buffer's reference count
>      to safely call the tracepoint, move the tracepoint call to
>      btrfs_force_cow_block().
> 
>   fs/btrfs/ctree.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 693dc27ffb89..185985a337b3 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -654,6 +654,8 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *trans,
>   			goto error_unlock_cow;
>   		}
>   	}
> +
> +	trace_btrfs_cow_block(root, buf, cow);
>   	if (unlock_orig)
>   		btrfs_tree_unlock(buf);
>   	free_extent_buffer_stale(buf);
> @@ -710,7 +712,6 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
>   {
>   	struct btrfs_fs_info *fs_info = root->fs_info;
>   	u64 search_start;
> -	int ret;
>   
>   	if (unlikely(test_bit(BTRFS_ROOT_DELETING, &root->state))) {
>   		btrfs_abort_transaction(trans, -EUCLEAN);
> @@ -751,12 +752,8 @@ int btrfs_cow_block(struct btrfs_trans_handle *trans,
>   	 * Also We don't care about the error, as it's handled internally.
>   	 */
>   	btrfs_qgroup_trace_subtree_after_cow(trans, root, buf);
> -	ret = btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
> -				    cow_ret, search_start, 0, nest);
> -
> -	trace_btrfs_cow_block(root, buf, *cow_ret);
> -
> -	return ret;
> +	return btrfs_force_cow_block(trans, root, buf, parent, parent_slot,
> +				     cow_ret, search_start, 0, nest);
>   }
>   ALLOW_ERROR_INJECTION(btrfs_cow_block, ERRNO);
>   


