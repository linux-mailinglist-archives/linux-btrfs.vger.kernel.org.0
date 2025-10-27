Return-Path: <linux-btrfs+bounces-18355-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAB3C0BD79
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 06:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9C63AC804
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Oct 2025 05:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA342D6603;
	Mon, 27 Oct 2025 05:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eU1DD1xG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993B2236EE
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Oct 2025 05:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761543738; cv=none; b=nLxBu9oy2yPsZrRD/2NFXEJ/9MJ9bhIwGZgtV/uYJKZAo5pIONT+Lc+PKek+bJ8yUo/6xnJqOXFYvkqg9uaFPGQc4wWNnBqaXkzkiNydTs1WbGpxHcJCna125quWSf5cQeZ6sKP34do+bUPM9K5A2rXgVt5D/ShEJh1WIFNFA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761543738; c=relaxed/simple;
	bh=mksmVedLOB/0yihk4v2TLs5l9wMBLLLWI09o1ETyVl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grMb7veqqAbyHagdcMlIMhgW3g87bVF6LQrLLFA0YuwuCqWRjkc/3aWxi/yCdFU4HDPvyIwXRqgK1tkmwkjCeU+u0QnH0c/olVhOURePdr1ZIFHBNQ4Yi6zwzsafQfDhhf/b//lh85QNOTTpuOQ3J52bchGDcGpsAAQM3yNPLBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eU1DD1xG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4270a3464bcso3277133f8f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 22:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761543735; x=1762148535; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ClUiw+yW057DclYSPLUU+sXuCaMIlapeysTsDzBiJrM=;
        b=eU1DD1xGytE0ZSJZ9G++OI/fBEjZjEr8rdN4/j+L+MfMZN41pHArrc4WPzE1I28qDK
         ZtBs3B1o6p1cASKDtAX7pa1yV3y9WwquJiE+/GVBluOYxDkIDVx4cgz5CNea+G9RGOIj
         HU/cL/NmebeHt++hgNmD2IFDmsysIPVqMUJ8fGJj7/Sn1ToNKoZi05342y1oiCNvc9tf
         lB2LqZ0Je9mUZGKUxWitLO856YwxdvDXUoEqIy6JJNT03vHSZNyUZ6PXb1at9ygwiZ+q
         cMWUQuJ6/Mx39kwq7GHcWdMmqnIysCwEmta9XHJ4hdcCC+mS4Ol/xGCzDi2h+AoseDJ4
         TsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761543735; x=1762148535;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClUiw+yW057DclYSPLUU+sXuCaMIlapeysTsDzBiJrM=;
        b=KKyoI7L0cD+soimVzXXzpR4IGMFW7n6EOwVq1vGhLNmw90WzmSTxVt2HSdv1oknaX2
         YEhQXLX+DECmLaHsuP9Ual+ttJD61O3SWEzfCQFLy+ZrOmLIs62dXa5vY6fX5XwQ1b2L
         tlvXvhHq6YDBtcVqPEjFGNzNfCE6/odMRqm8RhG1kqpR7JibxdlvxgYNFNhF47SzxSOO
         eiJcF18CHkpt1dIAS6Seeq6WI9P5aOfYL/7wdfHmXb/9Unt/yssY/RWs59FZMK2s84pM
         uM4wpUEaleibLPqaGGl5iMdnPrxFZxke+sbdGI6sD3plkbKoAA3UooG/G1yJ4chPLk1S
         sKXA==
X-Forwarded-Encrypted: i=1; AJvYcCV9amZCdrf9CcBuh9eOn11Vvh4ctNhxzwl3a5kz/EFwW3tIH2NJdJ+b8Fws+He97GuVfKmxA7Qg/VOtfA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+sA/3/SEKkhCt9fHQR1W3JLyrrikD6LFfC4tbX/9pRfmHlp8
	SMqhsefD0EhmlR7n/AAE/AkzoJmMfEg1malNQFVcafnTr7iKLv3qbHLZR3NJibZfkuXoMBsXfOR
	f/W7p
X-Gm-Gg: ASbGncvP8xMZo8GyTY+XEWfFjzXg+ItBj1qKTe7sjvPhzp8dPtQ22S7L2JmAGu0DOg9
	1JAsfLJg1hWVn8X62cEEOvM80z1F0XAAkLYET41gX/oMsXqzaqtIA4JbBJjhpoK04l4S921v5Gu
	E7l4ks+9RM61b9q8xCPCr0r55kcyRk6K5Pk4fPI1bMGpabNTyhR1IHSIKBA9MOK3bJC45fFJ+4i
	x9wTmWEOKH0gUwgcG+b+OTPr6yEvUgh52xXpkFLXJpZTE5MPHzdFwYOWL7IoD3pB/Ij8UwuUZ5g
	nk/OKtckYj6IP1fgN8ERUUM1buYn/q0citRk+FC7kNOfnbXvoFVDYpgU66laQtRTMXsNJj4b6dq
	cV5FdcRPFw6cbibAJRjHZqJFS7d77LA3K+NPHRN15LnV9R+ex/ubqJn1wVMwgpFDvYGaKoD4Rb7
	jG7om2vjr3CkgPFFO0eNrrvAAXyFkraFNc3impzU8=
X-Google-Smtp-Source: AGHT+IEtPieswSC+QMmdH2+NXylTZyJxhV54exx162Vuqe+KaYpCHWaJHIbEWA6wMAUN+OKHUHvcTw==
X-Received: by 2002:a05:6000:428a:b0:429:8cb0:cf9d with SMTP id ffacd0b85a97d-4298cb0d288mr8107487f8f.48.1761543734861;
        Sun, 26 Oct 2025 22:42:14 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41408c4dfsm6710848b3a.65.2025.10.26.22.42.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 22:42:14 -0700 (PDT)
Message-ID: <bdfd4ab9-3db1-4ce3-8f9a-8e4fceb5488a@suse.com>
Date: Mon, 27 Oct 2025 16:12:02 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 fs/btrfs v3] btrfs: fix memory leak of qgroup_list in
 btrfs_add_qgroup_relation
To: Shardul Bankar <shardulsb08@gmail.com>, linux-btrfs@vger.kernel.org
Cc: clm@fb.com, dsterba@suse.com, linux-kernel@vger.kernel.org,
 fdmanana@kernel.org
References: <20251025092951.2866847-1-shardulsb08@gmail.com>
 <20251025200021.375700-1-shardulsb08@gmail.com>
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
In-Reply-To: <20251025200021.375700-1-shardulsb08@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/26 06:30, Shardul Bankar 写道:

You don't need to include the "fs/btrfs v3" in the [PATCH] part.

You can refer to the mailing list for how to add versions to the patches.
Thankfully the "fs/btrfs v3" part will just be discarded by git-am.

> When btrfs_add_qgroup_relation() is called with invalid qgroup levels
> (src >= dst), the function returns -EINVAL directly without freeing the
> preallocated qgroup_list structure passed by the caller. This causes a
> memory leak because the caller unconditionally sets the pointer to NULL
> after the call, preventing any cleanup.
> 
> The issue occurs because the level validation check happens before the
> mutex is acquired and before any error handling path that would free
> the prealloc pointer. On this early return, the cleanup code at the
> 'out' label (which includes kfree(prealloc)) is never reached.
> 
> In btrfs_ioctl_qgroup_assign(), the code pattern is:
> 
>      prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
>      ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
>      prealloc = NULL;  // Always set to NULL regardless of return value
>      ...
>      kfree(prealloc);  // This becomes kfree(NULL), does nothing
> 
> When the level check fails, 'prealloc' is never freed by either the
> callee or the caller, resulting in a 64-byte memory leak per failed
> operation. This can be triggered repeatedly by an unprivileged user
> with access to a writable btrfs mount, potentially exhausting kernel
> memory.
> 
> Fix this by freeing prealloc before the early return, ensuring prealloc
> is always freed on all error paths.
> 
> Fixes: 4addc1ffd67a ("btrfs: qgroup: preallocate memory before adding a relation")
> Signed-off-by: Shardul Bankar <shardulsb08@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

And now pushed to for-next branch.

Thanks,
Qu

> ---
> 
> v3:
>   - Update Fixes: tag to correct commit SHA as suggested by Filipe Manana.
>   - No code changes.
> 
> v2:
>   - Free prealloc directly before returning -EINVAL (no mutex held),
>     per review from Qu Wenruo.
>   - Drop goto-based cleanup.
> 
>   fs/btrfs/qgroup.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index 1175b8192cd7..31ad8580322a 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -1539,8 +1539,10 @@ int btrfs_add_qgroup_relation(struct btrfs_trans_handle *trans, u64 src, u64 dst
>   	ASSERT(prealloc);
>   
>   	/* Check the level of src and dst first */
> -	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst))
> +	if (btrfs_qgroup_level(src) >= btrfs_qgroup_level(dst)) {
> +		kfree(prealloc);
>   		return -EINVAL;
> +	}
>   
>   	mutex_lock(&fs_info->qgroup_ioctl_lock);
>   	if (!fs_info->quota_root) {


