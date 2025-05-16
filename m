Return-Path: <linux-btrfs+bounces-14098-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 334BDABA570
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 23:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88693AE3F3
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 21:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4A0230BC5;
	Fri, 16 May 2025 21:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Geh/rwkT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549617BD9
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431703; cv=none; b=iSZsjhsCPr7ybPlSlP3y21Rd4L5DrCzAijlTV/b9PMu9NP0YaVVGMo1G9C/38AmKVfPEetbDBNd8H9wT97BlLLGKL0Rv8ekHjMxKritC7WRxYXqaPCtZkgDzf5DUQIPYgVtmIkuIgNO9rQ5qxR/408mIkUGjT0B/v3ZY/6cfPCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431703; c=relaxed/simple;
	bh=vkxT/hByIBP4gQEqaHxlxsBpqUFYUrdAci5uAOcvHUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L8o25Shuxt9VaYtlcrjLYmkRUMU7TLLailHVWOr83tTZ0BncFCb5a7IB7T8kgaMfnV+OBLOGZ4WJj5tFHMpimwGXyTLWTYorHSrA2WW0/lwmKGgt+FBFTgzn2D89syp90BUgtjmY3ue5Lwom5GDHhUyvfWMeQUzndwWZzrLoPTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Geh/rwkT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a0ac853894so2039004f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 14:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747431698; x=1748036498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k3cUc5qTFMsUU6ByddJaLlmUvlPgWbwnA2q5PhchpIM=;
        b=Geh/rwkTIbAtTltEu0LFw22elonnVYYFOr3LobOm1e9SStNSOx6aUS6xIog+12sj6J
         5Yt0UEzTsJfPv7u0+1GznTe82tN1kDrP3HJ1XSrL+Vyfm7RtwmqWYqm99paZ+fCiQG39
         EIjWL2XR96/15qx9Y1kOZLX4kEhRsYUQJP6YESozjmrdJygloHiUjlTuLQ4i5cPI1iZS
         ZCRzuOyy/mQnFL4OjG51VfZu5B0ca5RAUbOdYWJGyUQ7LuwJQ+SuF77RH2+ofDhKmPCn
         qQ0C63lMc15C4ON9bRFM1Y5pQItz8njBSSPADPLLvvdoQPhVE9b/CmtjX7Ctl4qM6LuC
         HN5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747431698; x=1748036498;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3cUc5qTFMsUU6ByddJaLlmUvlPgWbwnA2q5PhchpIM=;
        b=knKzI30Exy8JgnjN5iFgSnGETd+UPuhcDioJU5Fco/Ed4U/sEzrC5YlyF3S3l6ugEy
         h155iF8Fey2eXR/7HnxMy+R0oTNVHK4+kbaHzhr8gbkdyMd9FKp7mLmE+Dww8ogH1N2f
         uIugFrbkJ060zTXnRbn6/9cnt1QLno2FZRyfvs6BAmpjiWNNw5HYUs45/t4WZ3TJO77+
         gOcRkkOnPnnTmwMouaPQRXekVdESFXIorisxv0GlAsmd3bhSMbawj2022VpDEaVbQ2hz
         BquBL/WmPx3FPaVwNgW8K3ZGM5tE1pn1kl84iA9tMpb1oa5Zj9Ozn/Z0moARf5WCwtRf
         rJxw==
X-Forwarded-Encrypted: i=1; AJvYcCVxwHoF5t+yxWHb6qFnnGCWz0UTFO5Rzb159wlPnKCl+WLLcgp+u2/9LogiSyYr4cfjVrQ9IpyTL2M1ig==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPbeTMSNdl1SGOfjX9BNtAKaX6QMECLqjIpTxuG3EqUzpd0dJo
	29gUytJ01t/7EiUWawAbbdGxNQr6l3T/Kh/sHC0p4/Tc7ivAdocMTJVP347JM3Oi/kcglNbEMjx
	DTve5
X-Gm-Gg: ASbGncvIgNQ1bXjR5Z74mVrOy3zu7Wn9gQeY6oxaIGl/nb3rLJzLyLwQJhl6UKbxJCa
	mSJ1Tug02MuQgGJ3a7Y2z16crrqLREpDsDR37r5mah5bchMaOBmuX41mpGdhOdHLy2FedtlL213
	MxpH8PDjB50128R0DiU3DoBKpnUO6GtBTaVnWtcFX2vGTq+48pbsO67EVCsO1NuzZ0uPG+LL8bq
	ZYjYdC6oD8TI001bVPmaLF0nlEtPxH0WE9wuon/RqpdZUchjSzar1fIAY7L1Z4IIJpAAbNDuruF
	T0aKKYcufe0NG3YYchwR+AhME4Jiuvb7ImM8TWTcIRoMsrkBgbMJmoWXt19SkGDH8qyMxwYMi/I
	4f80=
X-Google-Smtp-Source: AGHT+IG0OVKmSKhmJ6ZRwprKt/asRWP/JfKv+JZE46sb61fdgGUjbsSMI/MSP4PxGvmWeBpcd8mfug==
X-Received: by 2002:a05:6000:400f:b0:3a0:b37f:c97e with SMTP id ffacd0b85a97d-3a35c821c56mr4792703f8f.4.1747431698045;
        Fri, 16 May 2025 14:41:38 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a986d9c3sm1957855b3a.121.2025.05.16.14.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 14:41:37 -0700 (PDT)
Message-ID: <8a8eb2e9-6f28-49f4-97cb-3e5d83e8b7b8@suse.com>
Date: Sat, 17 May 2025 07:11:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: unfold transaction abort at walk_up_proc()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <abc8c07f10bb3565627533a7140b2add7f6b5e00.1747413241.git.fdmanana@suse.com>
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
In-Reply-To: <abc8c07f10bb3565627533a7140b2add7f6b5e00.1747413241.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/17 02:05, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having a common btrfs_transaction_abort() call for when any of
> the rwo btrfs_dec_ref() calls fail, move the btrfs_transaction_abort() to
> happen immediately after each one of the calls, so that when analysing a
> stack trace with a transaction abort we know which call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/extent-tree.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index 678989a5931d..f1925ea2261f 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -5874,13 +5874,18 @@ static noinline int walk_up_proc(struct btrfs_trans_handle *trans,
>   
>   	if (wc->refs[level] == 1) {
>   		if (level == 0) {
> -			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF)
> +			if (wc->flags[level] & BTRFS_BLOCK_FLAG_FULL_BACKREF) {
>   				ret = btrfs_dec_ref(trans, root, eb, 1);
> -			else
> +				if (ret) {
> +					btrfs_abort_transaction(trans, ret);
> +					return ret;
> +				}
> +			} else {
>   				ret = btrfs_dec_ref(trans, root, eb, 0);
> -			if (ret) {
> -				btrfs_abort_transaction(trans, ret);
> -				return ret;
> +				if (ret) {
> +					btrfs_abort_transaction(trans, ret);
> +					return ret;
> +				}
>   			}
>   			if (is_fstree(btrfs_root_id(root))) {
>   				ret = btrfs_qgroup_trace_leaf_items(trans, eb);


