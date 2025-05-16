Return-Path: <linux-btrfs+bounces-14097-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8D4ABA56F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 23:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11836A011EC
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 May 2025 21:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0B82522B4;
	Fri, 16 May 2025 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="asdw45ZP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8120E332
	for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 21:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747431648; cv=none; b=guU5TwEdEFhw6hwUcmC87upOZ/upj0Qf8OgDALEWo6hWOcptPzduVgzSvxBEhbad5vaHMpGgtMT110HweQs1kOQxUMU/qJy0rrQroU9b7uPAtlTD4zB5ic6LL3zxAikP6GTpwQh5ds2zJKOAmxlqkYxhYLw/XWJPQAdTuq2lkFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747431648; c=relaxed/simple;
	bh=6nuO155qU0gMgqTQpY19sisYwvUhcFXaJEW6fqUW4lI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a9IaSfNIw4FadfdoenIA5ouXL0ALMLDiwfmYAPODvWnZJrWKcZKFPYx/mptizYwTBuNpNwYk1aM+4yu/+WuoPeAAhnUsjoNpMPR1rZGWMHXAnPPysRUfn4J+QYageIweW69iG02GaqKC93/LIQpN5KtUbLPujfQcXFq/syFtVds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=asdw45ZP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a064a3e143so1285570f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 16 May 2025 14:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1747431645; x=1748036445; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=34WTkvffH7VGUgklJQeKsSMs3HFCG6B/NISFhJp5PUg=;
        b=asdw45ZP/mMM5ctgD33Ckmg7u7uOvNQ5bSkVjpaGbusLLpCLWrY7WlZz6s0oEMZjsv
         Na3ShtYoLxh9kW4lFLTTbMmFH8CqX+2SsIE65e+EbTSRyUuVQAmZ8nsoFTjPCggMlV3U
         5dhbj7uZchJpLD01YhMPY385JY63KRTaUqKtYTPeuQYvivg+nXKMa0ajN6jqcHx/iwvR
         tfyVkhu+pQ23kjzL4BDbFCfZW7gFXTZ/1J9diTpMLkRR1uzRYifkRUEuQRHRbGBM6bN3
         HGw1eOeJgAhXx7jfuQxrDG6j3IZeEAxDN5qNAJxSzf7KPNbepC/XNDTard7JeWtrq9t6
         YUeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747431645; x=1748036445;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=34WTkvffH7VGUgklJQeKsSMs3HFCG6B/NISFhJp5PUg=;
        b=mzpb+lMf/dqMdKiwQD6rTOOjRtzLRJlITMQlelYSe09nTTS1xLXcS5wFzgYuNGo2dQ
         /jMeWRjWr5Mc1AktTM6+2MjvQi5+23iLTZ049PR+9jMBN5iqSYfxGmzGfXfdFtoYekpJ
         nSfCBWVK11wEj95pKeSBftjYS994wu3bPkK6rPKS6mazxTztuCN6/YtFIVuricVKp9fx
         rtB9sGl6zPMVdqVhHnXSlWb4kM+dE8OnEADergh68ih3UsF5BlEVRVdiTYiiQ0QecfVu
         cYldqn4gCTjzI985I/51U1uNI4PaH4lHJTFalPwBp7RJGP5+zShp28X9h0I5HivqzNRc
         pieg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ8TvcrdhiG638OU2orSIUktCkl7qdAM9MnzriLJQB9GK1mVeGd4dPSTSLzMkBldci55s4lsV91wok8g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDmTMUqA5jv/zs7mo92Hr6jbjzq32avhEz99PxSmfbqvDAUQxx
	1ADVpONR/chcm9fLipExvJchvBM952VnDJjtpYu3YDUAKRxjFGK72/+vF6zr576UXm0RohXqCdn
	XOOl+
X-Gm-Gg: ASbGncvMTBSM0qwemmvljbl7SnDU0xpr6mSxFfMd5N4je+SQZdlMCGACxZ3xGkWsox0
	i+FcgcIen3A3TKmB3XczYLqHWhMsuA0hX6X/T12kRLTMZs/hHvXUvouvsTi30vXqxa07hxHLyPL
	aqGiJYOx+S5vQAmWQBhPW509w9aI1KNouZlYchDdNO5bmAmJLrZeuVFm2U56idvTPAxx8U6V4E1
	hTWcXfhvd+Axa2G3WWu6vY7ztlLSyAUeJPXoJl+vYOwpQtQgXfIorV3eNF2nBH9Xq946hLoDgcG
	1UU7edBQ+k29uwUQN6qiwWDoOcvqVnj1mQ6VmLQAODSCVN16b3Kp2kF/S2I+/7A0gZfbf/QyM2u
	j5qo=
X-Google-Smtp-Source: AGHT+IEHMTMlbdUPi/JZUnHdCoWjBUUsWfxlOC5UKWIduVY/bEUBu+MhcZkwLVNe84AOgm2Sxhdv7Q==
X-Received: by 2002:a5d:598b:0:b0:3a0:b1de:1bc0 with SMTP id ffacd0b85a97d-3a35c83a05amr4656651f8f.13.1747431644981;
        Fri, 16 May 2025 14:40:44 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33401768sm5787390a91.3.2025.05.16.14.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 14:40:42 -0700 (PDT)
Message-ID: <c4af7263-4714-414d-9406-dee0f59aab7f@suse.com>
Date: Sat, 17 May 2025 07:10:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: unfold transaction abort at
 __btrfs_inc_extent_ref()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <56bea892fbeb023b89ac362c3882c80181372f7a.1747412853.git.fdmanana@suse.com>
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
In-Reply-To: <56bea892fbeb023b89ac362c3882c80181372f7a.1747412853.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/17 02:04, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Instead of having a common btrfs_transaction_abort() call for when either
> insert_tree_block_ref() failed or when insert_extent_data_ref() failed,
> move the btrfs_transaction_abort() to happen immediately after each one of
> those calls, so that when analysing a stack trace with a transaction abort
> we know which call failed.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu> ---
>   fs/btrfs/extent-tree.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index cb6128778a83..678989a5931d 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1522,13 +1522,15 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
>   	btrfs_release_path(path);
>   
>   	/* now insert the actual backref */
> -	if (owner < BTRFS_FIRST_FREE_OBJECTID)
> +	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
>   		ret = insert_tree_block_ref(trans, path, node, bytenr);
> -	else
> +		if (ret)
> +			btrfs_abort_transaction(trans, ret);
> +	} else {
>   		ret = insert_extent_data_ref(trans, path, node, bytenr);
> -
> -	if (ret)
> -		btrfs_abort_transaction(trans, ret);
> +		if (ret)
> +			btrfs_abort_transaction(trans, ret);
> +	}
>   
>   	return ret;
>   }


