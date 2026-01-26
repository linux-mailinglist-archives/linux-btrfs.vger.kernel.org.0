Return-Path: <linux-btrfs+bounces-21010-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIY3M3mxdmm7UgEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21010-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 01:12:41 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADCD8330E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 01:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27A9530056C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 00:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14A3594F;
	Mon, 26 Jan 2026 00:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NE2FuqET"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F050A849C
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769386354; cv=none; b=tE9Q9Fbb/Owtfh3tVLCqwaQxrLocsQPH6t5YbSsdmiowFiXcN3c5OTgcjM51O1pSLzliMhpUpM7hdmnR0pF+cvVEnMm/i7T2TEmzwGXDt/R0+SfIEqd2FnOVbgMq6MPTy3CcWMrYJdGyMLCJoCesuV/GPnQ8i6QfwccoM3UcN0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769386354; c=relaxed/simple;
	bh=qakODI+KcW4yhTlIaLvQYVgkVs4+QhTQTWIS04XEAAk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Fm9/LQnKAZ0KQA32HIndrHFeA51xmy6zbKkRfyJ5UBVxVT+190weIKN/FcuNO5zQj0Hm0t1gTXwL+D7OvTTQWVZnEZcYkebwVUS7UkBdrhzpDa3bMJHsJ6cPKocY2wTgHCoHIJGsqD/CAzzL1gWs1bw3xnhbLa8HDT8g4+E4jyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NE2FuqET; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4801ea9bafdso15462095e9.3
        for <linux-btrfs@vger.kernel.org>; Sun, 25 Jan 2026 16:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769386351; x=1769991151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+OyIDSz8xWG/lWgaX28oIlDuXPAWBPtow/rrs7fV7VE=;
        b=NE2FuqETB8PKX0b15Ou5T8vdhXtq2kU1JvbGQpIRvtH+5SVhO+KxOHQIDH9vj5Tmr9
         zw8mOajNT1poWiXYsgEgJIjIOPfjbY2WGQJoAaTB/9NG55CEy41H56Jhtk/dtHfoW5BX
         bafPa6atT383NdpLMUG7aKI/91byE5Vnzfny1FkGCUKBRdGGJX3Tj7MS/ycBznjU88jD
         ZGbsX9bliBh0G+GB4rrkYqsuljNHbt9j3OKUivSTKKr1n8SPYXT8PetGZpNejKOGdciA
         1CGL158yYnTxxwH5V/A7lxShaS9MED30iafelwzaDu0tliXEt08v2Xk3LahBu9QqZ29g
         nvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769386351; x=1769991151;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+OyIDSz8xWG/lWgaX28oIlDuXPAWBPtow/rrs7fV7VE=;
        b=aIVbPWHLF5wLPtcQ29gCx3yTSUFLN3/EdODEvPGBQePqooLqGJwWgDVFiWWIRT9miu
         viG9D84jK9PCibvdS86Io4eP8S5ngW6HRIENQF3PoiWFj5GzRlOSzoF5zstBMQPxpP5u
         KtdW1kdLTS/siumtf31Pez6CfceNaeLh77wg1Oixzku/4/hjkyneHiT82ECZ+pY7Rwhp
         UtXIFRTCkIw0zd/aFegFwqIrCuvyLTzuCQujMo+OFnR7x1/shdiW4/fF6FleIEYv7ppC
         pn++4e/AZxNZWgZry0IE+o28d/fgM7+KaPF4osDWe82LnMPqsDVfjq00Pa8G50bsrsXS
         zMpw==
X-Gm-Message-State: AOJu0Yz4PWlzmEUtIhSz9OFeLSac+t4y93wbIBxTGsHjnoSASRqz9OId
	hziRTw0HQs7Z5H+/TEkyIVWHZpfHeB/qLltlxBFzDxDHw0pSOkzcMe7kQD77CAbtnbLIMFABvI1
	OdSV1
X-Gm-Gg: AZuq6aKrypdwU4lLq9TJ+Ox/+bc7Vs+Y78mdF4JAXLSnaEEYN1QVbrlowHe+iNpt6zH
	jiUgazaOFPCHZgQwGoXt8ibCIk8yHHMtvOrth4W1pYpJWjPgY62WMwEVaWRf/Khm9k3RpUMfG/4
	lZ8VspfekUbtKAqpOLWRT/+kAmRiUtb70SJI+sUyUJhNZL+qJHL0VXRILiOqdYcGdMjh2H7jU5b
	aso6qJPwT3aDWlYQRQu5mJ/vk9O64d1JTt4y6lgY4x68mw7VfQi+D0mXiV5jmsAfnP5Sito3hR7
	iwnpjELaF9odCh5EQYyr8V1WM6d/CX5skY70QntWTc8OHz1HFqWg1+ZXtPZM2jBtcEdmiesw5UL
	tbnacNVq0u3PaUlduSQmcv95KR9xbqRNGGMC/KJMxn2xExY6I52CSydWc7lU2KL4SAW9g4ZkYY8
	BdE+tZeGc5LBGchaIc9niMvyZf0xcxWdhcdH2frww=
X-Received: by 2002:a05:600c:5494:b0:47e:e78a:c833 with SMTP id 5b1f17b1804b1-4805d064297mr46920785e9.32.1769386351286;
        Sun, 25 Jan 2026 16:12:31 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a424cf9sm6862987a12.28.2026.01.25.16.12.28
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jan 2026 16:12:30 -0800 (PST)
Message-ID: <bc3ff05a-cf99-4ba9-b879-b682fe5f1ed7@suse.com>
Date: Mon, 26 Jan 2026 10:42:26 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] btrfs: switch to btrfs_compress_bio() interface for
 compressed writes
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1769381237.git.wqu@suse.com>
 <4f2498403afc1b52f9577016e31954846cb38249.1769381237.git.wqu@suse.com>
Content-Language: en-US
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
In-Reply-To: <4f2498403afc1b52f9577016e31954846cb38249.1769381237.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21010-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7ADCD8330E
X-Rspamd-Action: no action



在 2026/1/26 09:18, Qu Wenruo 写道:
[...]
>   	/* Compression level is applied here. */
> -	ret = btrfs_compress_folios(compress_type, compress_level,
> -				    inode, start, folios, &nr_folios, &total_in,
> -				    &total_compressed);
> -	if (ret)
> +	cb = btrfs_compress_bio(inode, start, cur_len, compress_type,
> +				 compress_level, async_chunk->write_flags);
> +	if (IS_ERR(cb))
>   		goto mark_incompressible;

There is a missing assignment of cb back to NULL, the PTR_ERR() pointer 
will pass the if (cb) check, and cause incorrect cleanup on an error 
pointer.

This will trigger crash on aarch64 (but weirdly not on x86_64, I guess 
it's related to some memory layout difference).

This is fixed in my local branch, and will be updated after receving 
enough feedback.

Thanks,
Qu


