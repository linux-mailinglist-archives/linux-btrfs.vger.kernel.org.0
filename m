Return-Path: <linux-btrfs+bounces-21338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHsfLfVvgmlkUAMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21338-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 23:00:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 310B3DF113
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Feb 2026 23:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 532823051E85
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Feb 2026 21:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB73E37419F;
	Tue,  3 Feb 2026 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CuE1ERRy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76D33985A
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Feb 2026 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770155982; cv=none; b=EgYvPIOtCaRdQNF0rT1g9vhidvz8ygvTd0zwf8eTuwVX/zFOngL1oM2dDFp9itBVS8WF2CuTlVDWPmBP1EoIVJErC3JoLMPKPPcS9NJw7XaKxUBpy06GSxiYAjwKNUck3cuiOUUDuNIvcBC8tLKaEULLoyBwduo2FreFDULbCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770155982; c=relaxed/simple;
	bh=AYQ5d/3I7eQb8n0W68HRxTRNVYV8ehWjSY19rCqFcUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmrWaEysqKYy+VtVX7uI1M/xBMgI1wGCHTIsGGXTPGuu6HRdNAJ2eRtvsGbwLOyB9KqKEg0/I8r/Gb68HqtMdzPNs0x0dRpIgs5poDyQzGXJ0t9pZaCw1YsUpbWx5ysNzbXi9inLN0jX8aGyL1VQDnBwxoeT7gByL3JBLzF5hXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CuE1ERRy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so49693775e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 03 Feb 2026 13:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770155979; x=1770760779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p7ZeLF0mgG0TqJIOMOsoHN8AO14RmTYMPWBMPERiEFc=;
        b=CuE1ERRyYffZzMLavhACLNLveB6Qjgp8/yE7F2rQgPLjqYwAVzHOK341oPMS6aK5s8
         P6vHuk4kyiB53B1QnAWbJSehWpb/cSC5i4pFwQ/ZE9sYUL++vkQCebRurXgHW0sNPDy3
         yNzuA/FLXqiHPYmk95m7CQqEER2z3PYV+avtSkIlWjIj5gm5d7IifmrDtiJeJ8WbBzsp
         5YSkUe9iJX46nZgJTlCZAjJAgkvl+foVKAx7L+Cyp4yCtzRcryLEvJZCA2fs+vVhHwrH
         jKvu9Us23ZyU/Z2YJ4VN/V0VKAcbwjGOpqFr2m0dOQL3JM+SbmuXmZizzvpIZrFDtxBL
         c4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770155979; x=1770760779;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7ZeLF0mgG0TqJIOMOsoHN8AO14RmTYMPWBMPERiEFc=;
        b=ADmySU8Ag1/qTwLNkW/2KerBJ5ut3cgvZWGu9yV8ZijwrZ7Aaf52x3bijaCMBSZiae
         m8ytI10HqGAH9B/0gmrHOWyjw8l+7o+97l2YRSRE5e4zTNgVn9HAwQz4YjQsBKVL+lY6
         YeCXV1KIOQsAZpJdMo0V72dyK+YQD2JIk+EyIRtX3ao6nSmre+qRpmrthwn9P8FoAnV9
         E5oncCGCPePNEdi1dfq2Wgj0nBgqHvBvFzJ6DwFNUi4cnWyuNurY+2Sb98iMF1WgUw9r
         vefMXFBASibsXBDGgzipZK+5v4NuXyBhm2B6Ew4Pm4iDdJnSoCv4VZOQzf35G9ewmDco
         94Ig==
X-Gm-Message-State: AOJu0YyTUK2x1hMYdV7iZKNrOIyJK+0t902zXgz+KS5ELUqq/NGCMXpm
	Uq4zbTKmHWq9KTVJqH9Z36U5X75CyEEMEpbuYbCNbM/b7KmgurcYorOQht++vEFtlAHFm80FFEg
	CChL8
X-Gm-Gg: AZuq6aKwbuPcUHH8H+aCjzlskGdgkFZ+/PTr4GOM8W9ykZdFyYmsPK7bDNvGo3HFwPz
	AGIJ81jG+UZTomOmpGFCOrwx6R646CTE+74W2q9GItqlWDIwReUHZrfqLXAEEFZQd3NAI/pi6O8
	U4z3l+4fyzjjncJOtndVPEuQb3ei+A3sx1e0nkCoz0J8EuUi1ueITaSj/nuNGSvI12HN8w2jZ06
	5tG6tp5SkHDGbPdRy4/v1tiQiiATZFMuZ8oOyUHWoaRP5b4pFO1rZMD7LYKquhCM1e66tevYn1Q
	6DpnO892ACoZjXTVtn/fxDyfuqzmLFi7YxFKRB6ZfmV6DtaClSI3+arhori8BG/SpZ52B4B6BYj
	W5eo2+quCULttvdgsPFNgqBd1oJHgHNpI4W7OVV+Ycf7ucgPBEwrLTOsCFDMr6ZSedM8uIw2TFj
	j/0G24osxK77PZis2gn65syEr3yd8oTJ+3ahpdXKs=
X-Received: by 2002:a05:600c:350e:b0:47f:b737:5ce0 with SMTP id 5b1f17b1804b1-4830e967091mr13262055e9.23.1770155978586;
        Tue, 03 Feb 2026 13:59:38 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1c8c55sm321603b3a.24.2026.02.03.13.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 13:59:38 -0800 (PST)
Message-ID: <395eab87-29b9-4a70-82a4-2bf3dd8f3078@suse.com>
Date: Wed, 4 Feb 2026 08:29:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] btrfs: be less agressive with metadata overcommit
 when we can do full flushing
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1770123544.git.fdmanana@suse.com>
 <213736b4ab22e6ecdd6a10513eaed5d85b4053bc.1770123545.git.fdmanana@suse.com>
 <a3b63027-9e17-41b3-bc7f-477d1e59381a@suse.com>
 <CAL3q7H5_Q=na-W+uPm88yWAtPxYFd_t3kP1WK-9YhnFMr8uoZA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5_Q=na-W+uPm88yWAtPxYFd_t3kP1WK-9YhnFMr8uoZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21338-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 310B3DF113
X-Rspamd-Action: no action



在 2026/2/4 08:16, Filipe Manana 写道:
[...]
> 
> We can allocate when we attempt to allocate a metadata extent.
> However here it fails because we really have no space:
> 
> at calc_available_free_space() we subtract the data chunk size, and
> that leaves us at around 300M, which is not enough to allocate a
> metadata chunk in DUP profile (256M * 2 = 512M).
> 

For 1GB sized fs, 300MiB is enough for us to allocate a new metadata bg.
As the chunk size will be no larger than 10% of the fs.

In fact I just tried to for a 1GB btrfs to create a metadata bg by 
filling up the initial 51MiB metadata bg.

The resulted bg chunk size is 112MiB:

	item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
		devid 1 total_bytes 1073741824 bytes_used 367394816
                                     ^^^ 1GiB

	item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80
		length 8388608 owner 2 stripe_len 65536 type DATA|single
	item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 22020096) itemoff 15993 
itemsize 112
		length 8388608 owner 2 stripe_len 65536 type SYSTEM|DUP
	item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 30408704) itemoff 15881 
itemsize 112
		length 53673984 owner 2 stripe_len 65536 type METADATA|DUP
                        ^^^ The one from mkfs
	item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 84082688) itemoff 15769 
itemsize 112
		length 117440512 owner 2 stripe_len 65536 type METADATA|DUP
                        ^^^ The new one, 112MiB.

Mind to explain where the 256MiB requirement comes from?

Thanks,
Qu

