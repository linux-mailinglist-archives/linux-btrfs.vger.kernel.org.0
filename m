Return-Path: <linux-btrfs+bounces-19163-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC38C712CF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 22:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 60A2B29964
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Nov 2025 21:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BC32FFF91;
	Wed, 19 Nov 2025 21:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WHJlszu/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262802FB97B
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 21:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588541; cv=none; b=mmqZxsHwDSoWrPp25qDoIOdh6Bl7xWqeJnYrFfELO5GYdZ/MuDVhSWyPAtKU+Dl0iJ7IsZAABKpOoDXCCF3J/ukoxW/iJMvpkByb/6BEM8GyXF9+SJwkEh1IdNc3J3czD2rRWJtMOqqja3Oq9fPGuJTVVVQkvNr7cFpy3gyVJuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588541; c=relaxed/simple;
	bh=KUR1Vcd1SRB4bMrl+7M42pbm6uW93YkAszkHJw4SesM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o/Qc5w0cW6Q8uW45jrcocnPqlYTnudsyy4xLCxfa/Ps4QtXlUTwnoUApEWXE8BWWCtL8KaSBQgk0eFDRY+Y+wN8WvW0S8nW8y4ZoXIQfvKXJgiTW0GwWEI7YlxdJwtDKVaG/RzRb9TDLXjbrreR/2LQ04EU/kk4I/OFivbheXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WHJlszu/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47796a837c7so1502225e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Nov 2025 13:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763588537; x=1764193337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FVVF6vUiq09i6ibXWF9MuS5POlmSlGLKyIrYgAcKbpo=;
        b=WHJlszu/Q+o4FmevTqkFsJL0nCY/dKNwR6VZiYOZJiYmuyqo0iBQkCxanIRMT6WQ07
         5UdJF48+YXm2kW20Sn2JfmMmume5wE3sUYRJocteYwJ7vK0VeUGAFfh/GuzFHhgOXhNU
         oZp4CRgzuLIZrSHYjhHVi8QBkF9muUSC4nTkbbkBtnA9guUo0r39xTQOrQurYtOH8Zfa
         ovrKqaSd1fKc7Ro4L1+jIaI3Hwl+xuP44WEOk1a+hYPG/Cj34bt+Yzd2rC3F2QpvR/xc
         pgVvPrVseCJJuoJQPns6UBBA8mM4LA17jIFK/G+E5Bj9awa1fh7P6Lo4U961MwgEpN3q
         W7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763588537; x=1764193337;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVVF6vUiq09i6ibXWF9MuS5POlmSlGLKyIrYgAcKbpo=;
        b=svnENgUjy+dco1lgGGTGkiXCNcvMuym1O9Z22m4j0/cvpM+kpKHlqzGnXIsKdWv/hr
         X8mjkDZQrNuaaP3JxrU7uIw0jlsesocbgdWazneR551iQJRAyiV+6UH5+Ga9QDlB0DWf
         g/rD1gQte+rGGjQkkhxWMj4Xs9XM7XDWYASp97niBxVcSmD6Z+cIzNngh5NcFT5Wf0QL
         AFDdmMub6kpaGKn+53zXWBrh+hRB18GidsYQxT/CR/AejJI4GzbsDF7v6TAKkA1pAEMr
         y7TSjHuuIASYIEKObSZDi+4wBpxTwwKKMgsYr3R1MM4dkMevMy3iOLCGEKM1+NqWHPSP
         51qw==
X-Forwarded-Encrypted: i=1; AJvYcCUJCMKNPILnrgKsA8uL2JaV+Vzs5StwbKvbaojTXGLLw5bwfYWK8hLbE8vitb2HPARyUuMZuwbQUwbIpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzS1jT1Vg5a+QOV37ukakAsCdjjqk0rKmzvTDR9LeWKzhtRV1vv
	uY6N9rf7yWrCTsCLBaJq2i+/E/PM9l+Mpc1VcgtknNeJ0tetqjO3WC1gD+zzlf+/CqayLOvPdxz
	dzHd+
X-Gm-Gg: ASbGnctCcbRz4wlrWBuTFeZh+0tWrXxJVHNJbFMGhlEdHswPpCIypeCT85I5eXhZriW
	+jtTksxVOgFwNvCLvcPCdkLq5apG/fY8h+VIRA/y2UqcOrRJR4tGLZGSrlCMfd6aLQgEqPJNYv7
	AqWtLvVILXyqtdaIoqKTfJcbWrVg6IJnLuOlPLP/L9fmD89VzodbM3EljSqlt+wrsJfRSyyI1x3
	yfrB4BvuNZo2jemSmiNVwsR1HgvJJd5asC0Lc+TS/p5N/6rtrA1UQmndmOO36LEfaCbWFiZMdYd
	UMQTtJYSBNVqN7vrERaedJF8rhZ6QoVRXYsr2SOnyd6m12tsH8fasw/BaxLwRVAZAd9FgR/8ibn
	57OjF0HPvlPFdCXDVTxsx3LlwkHyCr6LIDWACtJ6NmercR1iASjdDhlEK+nMI6H2rKLz8Yw3eLu
	PM/jLwDevLo7VbLNcqfHTxBQodv4VbcnkMCXVw7mI=
X-Google-Smtp-Source: AGHT+IEsAyLZx5j2nlmxXiW8Sqj4M90PmJRMF88A/diOVea5AxD9pe5XVrW19uhSgY+jffw3I24NKw==
X-Received: by 2002:a05:600c:3550:b0:477:7f4a:44b4 with SMTP id 5b1f17b1804b1-477b9dc2086mr884185e9.1.1763588537303;
        Wed, 19 Nov 2025 13:42:17 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ea4322a7sm355989b3a.0.2025.11.19.13.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 13:42:16 -0800 (PST)
Message-ID: <caf816ae-d72b-436c-a5dd-9fb1f63eb88a@suse.com>
Date: Thu, 20 Nov 2025 08:12:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: send: add unlikely to all unexpected overflow
 checks
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <70cee567e5423a6c87196db3ff6622ef9b5c2ccb.1763570949.git.fdmanana@suse.com>
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
In-Reply-To: <70cee567e5423a6c87196db3ff6622ef9b5c2ccb.1763570949.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/20 03:22, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> There are several checks for unexpected overflows of buffers and path
> lengths that makes us fail the send operation with an error if for some
> highly unexpected reason they happen. So add the unlikely tag to those
> checks to hint the compiler to generate better code, while also making
> it more explicit in the source that it's highly unexpected.
> 
> With gcc 14.2.0-19 from Debian on x86_64, I also got a small reduction
> the text size of the btrfs module.
> 
> Before:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1936917	 162723	  15592	2115232	 2046a0	fs/btrfs/btrfs.ko
> 
> After:
> 
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1936789	 162723	  15592	2115104	 204620	fs/btrfs/btrfs.ko
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/send.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 3d437024e8bc..ebb5a74500f4 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -1134,12 +1134,12 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
>   		btrfs_dir_item_key_to_cpu(eb, di, &di_key);
>   
>   		if (btrfs_dir_ftype(eb, di) == BTRFS_FT_XATTR) {
> -			if (name_len > XATTR_NAME_MAX) {
> +			if (unlikely(name_len > XATTR_NAME_MAX)) {
>   				ret = -ENAMETOOLONG;
>   				goto out;
>   			}
> -			if (name_len + data_len >
> -					BTRFS_MAX_XATTR_SIZE(root->fs_info)) {
> +			if (unlikely(name_len + data_len >
> +				     BTRFS_MAX_XATTR_SIZE(root->fs_info))) {
>   				ret = -E2BIG;
>   				goto out;
>   			}
> @@ -1147,7 +1147,7 @@ static int iterate_dir_item(struct btrfs_root *root, struct btrfs_path *path,
>   			/*
>   			 * Path too long
>   			 */
> -			if (name_len + data_len > PATH_MAX) {
> +			if (unlikely(name_len + data_len > PATH_MAX)) {
>   				ret = -ENAMETOOLONG;
>   				goto out;
>   			}
> @@ -5173,14 +5173,14 @@ static int put_data_header(struct send_ctx *sctx, u32 len)
>   		 * Since v2, the data attribute header doesn't include a length,
>   		 * it is implicitly to the end of the command.
>   		 */
> -		if (sctx->send_max_size - sctx->send_size < sizeof(__le16) + len)
> +		if (unlikely(sctx->send_max_size - sctx->send_size < sizeof(__le16) + len))
>   			return -EOVERFLOW;
>   		put_unaligned_le16(BTRFS_SEND_A_DATA, sctx->send_buf + sctx->send_size);
>   		sctx->send_size += sizeof(__le16);
>   	} else {
>   		struct btrfs_tlv_header *hdr;
>   
> -		if (sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len)
> +		if (unlikely(sctx->send_max_size - sctx->send_size < sizeof(*hdr) + len))
>   			return -EOVERFLOW;
>   		hdr = (struct btrfs_tlv_header *)(sctx->send_buf + sctx->send_size);
>   		put_unaligned_le16(BTRFS_SEND_A_DATA, &hdr->tlv_type);
> @@ -5580,8 +5580,8 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
>   	 * between the beginning of the command and the file data.
>   	 */
>   	data_offset = PAGE_ALIGN(sctx->send_size);
> -	if (data_offset > sctx->send_max_size ||
> -	    sctx->send_max_size - data_offset < disk_num_bytes) {
> +	if (unlikely(data_offset > sctx->send_max_size ||
> +		     sctx->send_max_size - data_offset < disk_num_bytes)) {
>   		ret = -EOVERFLOW;
>   		goto out;
>   	}


