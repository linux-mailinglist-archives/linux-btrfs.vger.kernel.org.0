Return-Path: <linux-btrfs+bounces-22080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DKtHQf9oWl4yAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22080-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:22:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AC61BD907
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 21:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E4F43054331
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Feb 2026 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F9246AEF7;
	Fri, 27 Feb 2026 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YtzlMxOj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9657F3290C1
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772223734; cv=none; b=u/N2Zw8oZf2myPttYOHi+TVb3U5SB9sQR4Nn2j5MiAPFsavS7TIRSj2bkWuxGjxBAAoLV0PXx2Ci5n+yEgqejmNgsZIQ2nl4c2AZfIF6fJAM/+cX1inUd1l6KqRwc8o33syJ2NBzk+a2DL6WCMa6Eo6Au0rvYuFDfn4GwFug+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772223734; c=relaxed/simple;
	bh=l7k69CtN+IiNcGJIP+6XPRW27ZmEutG6RFmbRhsiAKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAcBGfL/vWVTIsPg5M/QBJbQZpjat1mkoo4hrN6DJUnRWeqfvdUT+NT4fmNMcNEWKORHnrPooUlE6nCZVQV2fbo2i72i1AFN5LwW1zdQJSpiSn5bLfwNmZ4mNwpU/LLbkO1zFfxDfNiCB3SlEZc6Kn6riC5AJk+9/x3VFK2+vfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YtzlMxOj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so27055975e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 12:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772223731; x=1772828531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R5yXGsU6hwsugdRjdYVC6VN7lOu0FrSG1G+gKSiGlY4=;
        b=YtzlMxOjQo9ChHv2R5Mjp67/MSiDYpDT9aG5obJ8HdX16BK24GsLJ8/efa0VQ9rpUQ
         YM9RAPIn4B1M01Dceqr+DnNFd7enWAC8jq95KxlNADLqt9OKq8RiqCa7JLyzKhDwcMjH
         D5WgpIdfYOtCJiLMKVMopN7FTLk6g9bW2yb+Kz9wtboOJ1YS6wrMFUbPoms8Tc2ztHOz
         Cogf8WGfr9i/PTqEQXNnZ+kyIvJ9BJyqlhnJxgMuhDN4LkJoUIrPAilyfOtIbM208a7m
         WqEp2i6yezMkl7UE46bkGp5XwDHTjxZFe5UD2pJEdsC6EOae0zNOSYUa/oF3ofizhLD6
         L6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223731; x=1772828531;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5yXGsU6hwsugdRjdYVC6VN7lOu0FrSG1G+gKSiGlY4=;
        b=VKSHxOYMMqjQ2+XOS5THEtGXNl+tqsOypkZ6EX1hMPA27CeVgeiA1GDpTZK847Wy7Z
         +7xHizaOh35w9Iv7D7SJ2+TuHwYXLXfFpWB97Ialw7lPX70wuoYouIXZA6D2WYh8ev/0
         8yo40SxLkleA3QF6Mzr9Gl1bkhu/IiidTrsJel3vxZdMC9vZnssYMqmi6Zw09fvbebUr
         0DTXJJNgPsQN/WkAcDNhlAR2Upj0ph4bO/+Hvu4wRLUjN9vfIXiLTipjZsjQihjNYkJ1
         6lFk5DHvISsFrRk4HjRahwGBAVrwOlxEiRUmXH33Vughta7+20Vcr07IH3gEus9DqKrA
         BbIw==
X-Forwarded-Encrypted: i=1; AJvYcCVwJCerKOMy7uOTfwe51kGDZAFepGryMqi2xkAgiT/JykaCXyngI2+WnZJohgyAkNuqqntTBGRgwI59sA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4oq1bbrFgrFYZ/Tfjun/9Todg5vCepyBlsnd3znsisdFD6b9o
	fEmNVMtmk7B2znthgE+OXd8/ASlmhz/IbeIm0tqAFEdP9lWuCnBqPnDvrZvxLdiUDc0=
X-Gm-Gg: ATEYQzxv/kDVVCjqAmyckaMTOkiFXZsf/ARDyU8C1ARe5iN6NijwjBeixtpC6HOtNeK
	phIIqERCGeOYnXjpoiGc/NcfcwtVhFPzqhOoaPw1xyUwbKDG79N0PymV+wqgbMNj1zUasWB03ED
	lte6vbXBeEHEjicqL1OYBB/E+93pQYgCfmndyAF24hXJ14hT3JWoDU5M8MSTd+GFV2r5yAFc8tY
	ihi0AdON0Zoj0ztWu9ujKx8qusVeKzr9U+L+orwIui/NjLusXz0uZNPYt8RAUm/QUnVUZ8CKpOW
	DiwIddOY0WqZFvH4iWHWQArRC/qkGpYVyJ80b/cyGgu8C1nHSdmLrnrEqv1FN3qexMNL2VU4lUV
	z6K9PUymXqTakrPeseWImTfqOawucTJhKsK5/FcIAIO5V9GB9EWBcKLaz0EnCqCpnVm+NOCmlIJ
	zyPnpi1BiULJZurNEq3i2t8wi4GX4reYZfPWhgXQiH9vQoRusCDGA=
X-Received: by 2002:a05:600c:3b9f:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-483c9ba7e4dmr63328315e9.6.1772223730908;
        Fri, 27 Feb 2026 12:22:10 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c531sm5448388a12.24.2026.02.27.12.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 12:22:10 -0800 (PST)
Message-ID: <07ebe143-13a4-47f6-8935-600a7cc50797@suse.com>
Date: Sat, 28 Feb 2026 06:52:01 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] btrfs: replace BUG() with error handling in
 compression.c
To: Adarsh Das <adarshdas950@gmail.com>, clm@fb.com, dsterba@suse.com
Cc: terrelln@fb.com, linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260227183111.9311-1-adarshdas950@gmail.com>
 <20260227183111.9311-2-adarshdas950@gmail.com>
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
In-Reply-To: <20260227183111.9311-2-adarshdas950@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22080-lists,linux-btrfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: 09AC61BD907
X-Rspamd-Action: no action



在 2026/2/28 05:01, Adarsh Das 写道:
> Replace BUG() calls with proper error handling. Where fs_info is
> available, use btrfs_err() and return -EUCLEAN. Where fs_info is
> not available,

btrfs_err() can accept a NULL pointer as @fs_info.

[...]
>   
> @@ -874,11 +862,8 @@ static struct list_head *get_workspace(struct btrfs_fs_info *fs_info, int type,
>   	case BTRFS_COMPRESS_LZO:  return btrfs_get_workspace(fs_info, type, level);
>   	case BTRFS_COMPRESS_ZSTD: return zstd_get_workspace(fs_info, level);
>   	default:
> -		/*
> -		 * This can't happen, the type is validated several times
> -		 * before we get here.
> -		 */
> -		BUG();
> +		btrfs_err(fs_info, "invalid compression type %d", type);
> +		return ERR_PTR(-EUCLEAN);

Although for such unknown compression level case, the workspace user and 
put_workspace() are all erroring out correctly, it's not following the 
common pattern of checking the error first.

I'd prefer to just remove those default: branch, and add an ASSERT() 
checking the type is inside the BTRFS_NR_COMPRESS_TYPE before calling 
switch().

Just as the comment said, the @type has been verify too many times, we 
don't need to add a new error pattern where no one is checking.

Thanks,
Qu

>   	}
>   }
>   
> @@ -925,11 +910,8 @@ static void put_workspace(struct btrfs_fs_info *fs_info, int type, struct list_h
>   	case BTRFS_COMPRESS_LZO:  return btrfs_put_workspace(fs_info, type, ws);
>   	case BTRFS_COMPRESS_ZSTD: return zstd_put_workspace(fs_info, ws);
>   	default:
> -		/*
> -		 * This can't happen, the type is validated several times
> -		 * before we get here.
> -		 */
> -		BUG();
> +		btrfs_err(fs_info, "invalid compression type %d", type);
> +		return;
>   	}
>   }
>   


