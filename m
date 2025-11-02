Return-Path: <linux-btrfs+bounces-18517-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC95DC29886
	for <lists+linux-btrfs@lfdr.de>; Sun, 02 Nov 2025 23:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1162C4E5D4B
	for <lists+linux-btrfs@lfdr.de>; Sun,  2 Nov 2025 22:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FB2367D7;
	Sun,  2 Nov 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QQX9OvRi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075BE1C5D57
	for <linux-btrfs@vger.kernel.org>; Sun,  2 Nov 2025 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762122373; cv=none; b=KjdDeYfUAXeQBOcLxu2AlIBv3pf0YaOnaOlIVEG+34LXaSmupXM9gosi1a0hE6QWIktYOm2fnFUQb+zHWTfNx7Go/4+G82SY8BXCBrCGDq9nBrOKKqvr6L2xvSW8RTqvebV/XCMoSxTbMVZgCXGA8XrX7nP+74/I+VywUhUnc80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762122373; c=relaxed/simple;
	bh=I1JSbLLrfdOu0+dxg2zPI+FP+1AUhgURHiQH6ZYQxp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHnNS13Bwb71QMIJtHCvBDFNQhyisuMUz7dWuMGNT5Hi1PPV1o6lcSc057CzJkBlrVFy7N02MO47hnPhzyeYyQQyPn3CDlNrwGgnPl0ur1ZDTf6zcaWbK5Ye4uy7Oi7MjUbL8MJvSeOo7fAd0ndWerq8YuY2k6ImvShbM4BP+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QQX9OvRi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-421851bcb25so2103039f8f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Nov 2025 14:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762122369; x=1762727169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TSoZQO1LDxMqFZ2v8FFTBXkhOch3U4kSrXEDTkJlztI=;
        b=QQX9OvRiEf916bTFDR951Ez+B5jZTlX7jL81dj5x0DHWot8MgaCCbAAMcZXNXrVF7T
         bHqvfnMiGk3RapefeWnVN77gAkd3T5UgbMn0IsFvBaKwzVJrBlkRkyTSl7x4bRWBvzck
         a7I9Fmi8Y6VlXpp/DFNVYBRlGJB9bPbOTPqH60JH4oUY8ui63ewmHsDemYvY5lx8wtQL
         pObXLfpYcDITnr4enC9LnNRQVTTvIGtyUarjHXnKKTl4zmVkHTTV9+gQllYCgp38svAD
         JFL9NKoQ58+O2vqtoYWsph7CX4bCHFbDhoAQnUnYQKRxmGB5DAfjR/B+M3KvRaACq70j
         4TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762122369; x=1762727169;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TSoZQO1LDxMqFZ2v8FFTBXkhOch3U4kSrXEDTkJlztI=;
        b=eoOKvZ13lIvj/9j53lnZ4xHeRjXcoXr948If9Jc1Mnd5mv7vfN9UEqaz4ZUASSYJY0
         hEaRiRCxGVmjG1aenW+EQv0JUhgK1rat0G1TJwT4hhha5nAoZgb89k65pC75y5smJXHZ
         JPMgPb0mZVgtYyo/7j1696PJUU+sf2M8ol+ehW3dIOSTcrmkh+DK/Y6CT/Fa9U1HDHvG
         j8HUcayO5byeG3/g0x8bGYBWF7xdBMViWDE5uc2XYjN3Rvwew5C8sTJe3zni7JeibFXn
         dhcxUlL/agmSAnQjaokMm/phw1yz3ld8+NYA1uw39k8fMXwLjphxSfC5W9KxzieCVdRG
         H2EQ==
X-Gm-Message-State: AOJu0YyQKI5zZ8Evaqxj+ltXnOPMm9HYWIIsr1H4ikh0fj/BC7+BYYBk
	9ZYeyvOh/tElyCidzFCYCC3xkNGO034fnT17gVoOKXVaX4FM2l2lLAK7+rYK1y+a174=
X-Gm-Gg: ASbGncu2thiHY837AO4cZ7m1IXnRP4BfUTvT2/gzxcGcm0Kf7YXF8glXybFTh8JmWHj
	MUgnAilDh7XTNqaqPA/tUaL5JQpJLOaPfoIY1NsmP2rpTByOQrOm1SRiQ1ovnxjyfBZ4TT3o4y5
	BYqJDULNv+/ufbouLFX3ixLOBaEGEiSbadBr4izXOzRzQFTrZSrr+SyavbICBsOtJQ7UFa3BB+u
	jPMdsazw2MNSHwd1mU7WhlPJn+IHPdbVHaQSt3abSXMBiJsJSZhbBUPwHrXYK3uMy7Z3aDcFeEU
	fHLsuJeYAzaZ8y1LvF1rxB8MuXaq8Pl1Q5/8PJbOkx3SyOLlNl82aSDFNnMmOrDwqVok6metQKm
	l2nINrRCERnzC/IUYpXFpgoEXc7qEcjq1Es+l8qIdAuiZ+gNK9ds+1+dYgHbXHVrU428u2nHcYS
	rI3KJii+gaae8bCTzlTxyFPN47xLEf1UiAi2kyhelUZndwu6wZEg==
X-Google-Smtp-Source: AGHT+IH/mrTw6saq0kRTUvdWFTHwFvJkiVrFtlmxQKhXD05hq755mlv6ubcjEgYm4Ph+i9YMQ+zRHg==
X-Received: by 2002:a05:6000:4605:b0:429:d004:bb2c with SMTP id ffacd0b85a97d-429d004bc80mr2148471f8f.57.1762122369126;
        Sun, 02 Nov 2025 14:26:09 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd6f4sm93956785ad.101.2025.11.02.14.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Nov 2025 14:26:08 -0800 (PST)
Message-ID: <66c4393b-51ae-487a-9e14-a444775b9fa4@suse.com>
Date: Mon, 3 Nov 2025 08:56:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] btrfs-progs: interpret encrypted file extents.
To: Daniel Vacek <neelx@suse.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
References: <20251015121157.1348124-1-neelx@suse.com>
 <20251015121157.1348124-6-neelx@suse.com>
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
In-Reply-To: <20251015121157.1348124-6-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/15 22:41, Daniel Vacek 写道:
> From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> 
> Encrypted file extents now have the 'encryption' field set to a
> encryption type plus a context length, and have an extent context
> appended to the item.  This necessitates adjusting the struct to have a
> variable-length fscrypt_context member at the end, and printing contexts
> if one is provided.

Unfortunately this patch will cause CI failures on fuzzed/crafted images.

The most easy way to trigger it is using misc/032 test case from 
btrfs-progs.
[...]
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index 2a624a1c..060bf997 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -421,6 +421,25 @@ static void compress_type_to_str(u8 compress_type, char *ret)
>   	}
>   }
>   
> +static void generate_encryption_string(struct extent_buffer *leaf,
> +				       struct btrfs_file_extent_item *fi,
> +				       char *ret)
> +{
> +	u8 policy = btrfs_file_extent_encryption(leaf, fi);
> +	u32 ctxsize = btrfs_file_extent_encryption_ctx_size(leaf, fi);

This is done without proper checks against current item size.

> +	const __u8 *ctx = (__u8 *)(leaf->data + btrfs_file_extent_encryption_ctx_offset(fi));

And this can easily lead to read out of the eb boundary.

Overall we need extra tree-checker for the extra encryption info if we 
want to stick to the variable file extent item size idea.

Thus I prefer to put the encryption info into a dedicated key other than 
putting it after btrfs_file_extent_item.


So unfortunately I have to remove the series from devel branch for now.

Thanks,
Qu

> +
> +	ret += sprintf(ret, "(%hhu, %u", policy, ctxsize);
> +
> +	if (ctxsize) {
> +		int i;
> +		ret += sprintf(ret, ": context ");
> +		for (i = 0; i < ctxsize; i++)
> +			ret += sprintf(ret, "%02hhx", ctx[i]);
> +	}
> +	sprintf(ret, ")");
> +}
> +
>   static const char* file_extent_type_to_str(u8 type)
>   {
>   	switch (type) {
> @@ -437,9 +456,11 @@ static void print_file_extent_item(struct extent_buffer *eb,
>   {
>   	unsigned char extent_type = btrfs_file_extent_type(eb, fi);
>   	char compress_str[16];
> +	char encrypt_str[16];
>   
>   	compress_type_to_str(btrfs_file_extent_compression(eb, fi),
>   			     compress_str);
> +	generate_encryption_string(eb, fi, encrypt_str);
>   
>   	printf("\t\tgeneration %llu type %hhu (%s)\n",
>   			btrfs_file_extent_generation(eb, fi),
> @@ -472,6 +493,8 @@ static void print_file_extent_item(struct extent_buffer *eb,
>   	printf("\t\textent compression %hhu (%s)\n",
>   			btrfs_file_extent_compression(eb, fi),
>   			compress_str);
> +	printf("\t\textent encryption %hhu (%s)\n",
> +			btrfs_file_extent_encryption(eb, fi), encrypt_str);
>   }
>   
>   /* Caller should ensure sizeof(*ret) >= 16("DATA|TREE_BLOCK") */


