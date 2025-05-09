Return-Path: <linux-btrfs+bounces-13854-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 741B6AB117D
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 13:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B21C1C04FE5
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 May 2025 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A3D28F531;
	Fri,  9 May 2025 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="B6qxymx8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7734C274FE5
	for <linux-btrfs@vger.kernel.org>; Fri,  9 May 2025 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788777; cv=none; b=jlKFUfRqpbkzP8sGN7wOY26rP6LfaxkaCqmRPidCSMR8A7DfjjmT7rTvuPc9RfKShU/9/s8lcDsFD8x4vZWhg/gWsAA2Sss13hxx4I9XCUntq0Buh/V83Ai72DRY6TKc+5L1pDFhO9syp3deGw7NKCCC3u07bTC3KsKtfvbONZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788777; c=relaxed/simple;
	bh=+dNdlvrZegwtRVNNwuskzi/w1obxKBW4vDfxHJdrPLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gm2+AsW9HOFqRjsyEuf8iPgY3jUShhnj7rGoG2zfrNySghRXImX0rvzlooTNkX3lqkhMizQiPqJLXoQm16xbXRE4mmOpQOdeM/8a4cYGdVPfB1xhWZEYtZn/DGMKBM7ULzsfUTqHp5Vj63SM53paJSJwmvFQzrKRluteGpJTMNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=B6qxymx8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43ce70f9afbso21190235e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 09 May 2025 04:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746788774; x=1747393574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IzT3yVowSqCH8OsyNe7iaWG1BKy//5uuGeIzp+cBzzc=;
        b=B6qxymx8R+fUqCPmMetuQF5WqzuF9jF3kw6NiXVTGAM8zsV7v87d1Jx9nd54UbMHn9
         msPh2ixXie9HYqtqiUy1OYsxWHXZe/YDEr0OqcL90cq3UJoxhkhzcsSk2/6Gl7yITeO1
         7MlNzI+tAZQiJlFCOh9BECopAdBLltE5LrJxQgf+V2uXxaH9M3JfMa1gu7od2nl1cMc6
         vMocy0woiKdelEwHk1vrwD0OjlA37ZaijA15UK7c8FdjRsjmrnmZlmport4Gf+StPFiX
         4bvtd6qI2yI9Zt/V4bJrTJfeWjnx0wp268zXu2wr0Dp93AKH7MjwUJwTezicVPsAMaBf
         tiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788774; x=1747393574;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzT3yVowSqCH8OsyNe7iaWG1BKy//5uuGeIzp+cBzzc=;
        b=BlOV9fhT6D8U7Ap7a9JkJKVxqoLmbnSbGICXXlQ3afo9lunEK1Vc4I5qBcMTUjBXjn
         ayfgEBUsCck0g1QICXDv9a3FAJBcTmoX0MCB6b2VaWLTxEdR6BhNxDCZCeRHaCjBHfB2
         p13sDgB5mBnd1q1/v5OlbxrS5z4XzDh95onpMHQ+/pH8oby+l0adbCeHN5X9nR5UFxao
         IXeBerqI6NLjO/z74XwB89E7eYcyPgrnObAtPhfbdXWN6RfMp03kt22XqYAE8OFasJyb
         g3fCnpQ7LKsqEw/faH9iDwiGJWOAbOfkLAJhK8sywqiRAHCKX+xGrzHr51oPBk/ed3mW
         G+Ag==
X-Gm-Message-State: AOJu0Yz73T3lAC7iQcYccnXVo+mZkx3T4TqpaxoIX773dq7dBSNBWcmS
	aWbBqCfZrKnlm2t6DT90ssxC3YsF2ODvjMmB4zUf1ecW5omuQV0ekX10+pkFuK0=
X-Gm-Gg: ASbGncvuMMVt9dP8YGvNjt7lbVd9RoDUDvi2GUC7gsbbLYgq0AzIE7JidiD0rTQyZOp
	nFNHW/wj090/0JNVS+eYPxyQkN5IN/ovY2MSMOeQIVc70xHbD0Isxb8XTaCMGhYg1+INB1WhU5a
	gBa1kctccNVwr3exgxJp8Fo1bf7zB5wzXaaB40cml5MZRQ1Kusqw/f512gVLVzaR/vRc1LxTtcW
	KwxBYQD/B+5XUNdFlCMo+ONq2cZJa/VjjEQ+fSu+71nC6x+TOteclS8LSjnkuJXx32uYB+eZDrY
	ELswWU/3fzRIj37ozimSY2a5knfLlF4XN/riLHql5opqhf+mM3uA82HI8GVLr2qFr9BPJ7oiyHl
	3Vfw=
X-Google-Smtp-Source: AGHT+IFko1tmH9PF8tsyoh4wWrGSNlSSx+ZN/tDLPKnFmraOfoeeWZlPPy14qEAG0vo2VXFioDMQvQ==
X-Received: by 2002:a05:6000:4285:b0:39c:12ce:6a0 with SMTP id ffacd0b85a97d-3a1f6437e79mr2333218f8f.21.1746788773447;
        Fri, 09 May 2025 04:06:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc82745d0sm14719865ad.155.2025.05.09.04.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 04:06:12 -0700 (PDT)
Message-ID: <76897b35-6727-4d9c-bd7b-2faa129851ec@suse.com>
Date: Fri, 9 May 2025 20:36:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: Implement warning for commit values exceeding
 300
To: sawara04.o@gmail.com, clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
 anand.jain@oracle.com, johannes.thumshirn@wdc.com, brauner@kernel.org
Cc: linux-btrfs@vger.kernel.org
References: <20250509102633.188255-1-sawara04.o@gmail.com>
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
In-Reply-To: <20250509102633.188255-1-sawara04.o@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/9 19:56, sawara04.o@gmail.com 写道:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> The Btrfs documentation states that if the commit value is greater than 300
> a warning should be issued. This commit implements that functionality.
> For more details, visit:
> https://btrfs.readthedocs.io/en/latest/Administration.html#btrfs-specific-mount-options
> 
> Fixes: 6941823cc878 ("btrfs: remove old mount API code")
> Signed-off-by: Kyoji Ogasawara <sawara04.o@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/fs.h    | 1 +
>   fs/btrfs/super.c | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index bcca43046064..7baa2ed45198 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -300,6 +300,7 @@ enum {
>   #define BTRFS_FEATURE_INCOMPAT_SAFE_CLEAR		0ULL
>   
>   #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
> +#define BTRFS_WARNING_COMMIT_INTERVAL	(300)
>   #define BTRFS_DEFAULT_MAX_INLINE	(2048)
>   
>   struct btrfs_dev_replace {
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 7121d8c7a318..23e230052941 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -569,6 +569,10 @@ static int btrfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>   		break;
>   	case Opt_commit_interval:
>   		ctx->commit_interval = result.uint_32;
> +		if (ctx->commit_interval > BTRFS_WARNING_COMMIT_INTERVAL) {
> +			btrfs_warn(NULL, "excessive commit interval %u, use with care",
> +				  ctx->commit_interval);
> +		}
>   		if (ctx->commit_interval == 0)
>   			ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
>   		break;


