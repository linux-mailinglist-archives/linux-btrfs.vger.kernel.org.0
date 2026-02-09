Return-Path: <linux-btrfs+bounces-21521-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMU1E/xciWlY7gQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21521-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:05:16 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E03C610B818
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 05:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9EC43006B33
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Feb 2026 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD6323E34C;
	Mon,  9 Feb 2026 04:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E2Flr85C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E261862A
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Feb 2026 04:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770609908; cv=none; b=qhd7knlvSYrgivaaqCmnIFl2MVb/4A0d4vnGYKzG0ZtKJAckJVm65NHA7eBPI5gf0MYqu8KJNkVGIUJ4BTVRSVloQeRgBsByf5l1rkdYL8DdyCQmxq46JfE1t5og1CcWhXq8ioJt35OPFXlEjwL5cCnXzZd7JM8OiZYdf8BCZL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770609908; c=relaxed/simple;
	bh=MDAVAtySpgS4GWToBknbLoytjGNQA+9lN5qc3pA7H3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=em/CxzE6bu/SjepFIDO0muZjQVjRjiYIcS0M7G3FX97na/3WCZD4ao8myzQVyZTYMGnthklroWobhiaYnXK2XZuuBbroVG5H2khjsi+RS2mIS8ykMTWxlDvLVKKJ1mYIoUd3IFVwrj23hzOyT4k+4dUbehaXyX+Ymm1gmR++B3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E2Flr85C; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-483337aa225so3596975e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 20:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770609906; x=1771214706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qvvSRJp6eqFb5z508i7UNREdNJ6x2Fr+taJ0YnT7AZ0=;
        b=E2Flr85Cj88OvLlM24ngft4+Gi6eZGRlO5Idr4tZI2OWYWG5EGnzQyZzN7HAs1BUqk
         Ir0CNKoLYcpmEaVh4FqAHFRAll4Ns33Zug+uppv2Fjd/Bcj0F3r+OX4RQO7DUC1c1oqr
         /RyvYC70Str5e2dFpT1/bXALTl7CZ9kdY/CwTCy+gNVvjRYWVUv5FXJJR0GcLdSUjtln
         zo+Sia78CkmTT+W6gz7KYISK1AR4Gr6vBR75xak3R1qdrBSva7CBKcsQBB8DjTY4aaw6
         daJJWh82KXqj5tTDH5lhi3EGjbx7dDO3ZqFvZXWYIDGcJ3hvYyEuVATmUtOPgHs1d0fs
         onsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770609906; x=1771214706;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qvvSRJp6eqFb5z508i7UNREdNJ6x2Fr+taJ0YnT7AZ0=;
        b=nHM/GivmwVIlmZypFwuiudO8cB5ceWiUNpso+3/YXfNMMIsi+hSlv7Z3nvRgwPjG4l
         cUZEKJj5NtrR9m5CiMHIerUOI+8XXsQx2qmXACXFMSnCLPUJXgusN8zRtGC+2o2taodU
         /zX0GGSKoq+6DOk40SzJ/MrpuJs9YNm+JjV4RmRNXzchG0bHS+owinVCWGvSTy2KMTp5
         s20nLCacXiqyKvWxY2EdZYbb4gTQAzgjULm2eAQDShvg7aT7yA8SVRAweTlxfLC5JpoC
         2LSDj/aAugC0NXMmsIyqH4guHoAntP89SGl0YVPdlI4dbvnOrdkUZPIDgfwPm237Cwj0
         VQUg==
X-Forwarded-Encrypted: i=1; AJvYcCWRLWLgwvx6ZRoOQxBWde5/WFktSF+SbHRf2e2YVL0BhfFS5oHk6+saBEMmpQU/FiPxhu7qJ/dNnTGmZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1VogwXl9dTfckAyca/MAxikZnbzVSADyOx9Z5B21zQhxfB0O
	PWK0V+/E9bHwkMruPMP360NNsIe1MH1h8Qv7qNMrnAwXRBhq4XOx9Gf+Lad7hzvAKh5vVkmZ2tq
	KseBbUfg=
X-Gm-Gg: AZuq6aJVbX0CfExqtQ+yuW/HOu7wG1iSz/Kbb35bkhfKeWzkNus8So+uvpfQsqlBWp2
	qPF5/hIO8bEPp31iUYg9vMlAergptjj4RjOLyBISoULqi60EBn4O4NhTGvMM5UTdJRlogRbGnk7
	BthUK6zPNYDvMlLVxqiEux8u2gdeQ53jcaZ5AMsYwM7gq7F5JHX7y3zGPzkUhD6USzN2q5Rl9Bs
	7vYjrlkdFNxAuHCfBhauEVQwrzGUvfuk0nEYlJXTBXABpyGfTKTUakFjxZ62QicYjZ1zMoyAX85
	VLOGM+gVLhneDeE/Y0LJyx07QkWKNKHVQhAN66S4JNE0hyQhkkldt5pV0yO1b3g0GTeK6WNSjQ+
	Kf9VEesXn79Y/Nfn7un9fmBy4oHDTHa7jQHwNg0G9IxwZHwkUWSIZCBvlN7jqjoPpb1gA7SU1U3
	0QXZ2y8ZWCW2ejC9Y4oFPTqD8qhD5wqbwgGbCbguY=
X-Received: by 2002:a05:600c:8b88:b0:47e:e20e:bbb0 with SMTP id 5b1f17b1804b1-483201d9fa8mr136553385e9.6.1770609906196;
        Sun, 08 Feb 2026 20:05:06 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b46ba137sm3871585a91.13.2026.02.08.20.05.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 20:05:05 -0800 (PST)
Message-ID: <78ebf47f-9cd2-4d71-acee-965a75e50ca7@suse.com>
Date: Mon, 9 Feb 2026 14:34:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix lost return value on error in finish_verity()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <1d384c9ac09392353418f47a8b41366545d73867.1770575632.git.fdmanana@suse.com>
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
In-Reply-To: <1d384c9ac09392353418f47a8b41366545d73867.1770575632.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21521-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E03C610B818
X-Rspamd-Action: no action



在 2026/2/9 05:06, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If btrfs_update_inode() or del_orphan() fail, we jump to the 'end_trans'
> label and then return 0 instead of the error returned by one of those
> calls. Fix this and return the error.
> 
> Fixes: 61fb7f04ee06 ("btrfs: remove out label in finish_verity()")
> Reported-by: Chris Mason <clm@meta.com>
> Link: https://lore.kernel.org/linux-btrfs/20260208161129.3888234-1-clm@meta.com/
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/verity.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
> index 06cbd6f00a78..95ea794f20d3 100644
> --- a/fs/btrfs/verity.c
> +++ b/fs/btrfs/verity.c
> @@ -552,7 +552,7 @@ static int finish_verity(struct btrfs_inode *inode, const void *desc,
>   	btrfs_set_fs_compat_ro(root->fs_info, VERITY);
>   end_trans:
>   	btrfs_end_transaction(trans);
> -	return 0;
> +	return ret;
>   
>   }
>   


