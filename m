Return-Path: <linux-btrfs+bounces-21381-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0M31JZ0bhGmyywMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21381-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 05:25:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F00EE861
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 05:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EEE23012EAD
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 04:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BC12E92BA;
	Thu,  5 Feb 2026 04:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TgYl+sFU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F282E888C
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770265466; cv=none; b=cc4VV6MtQ76DByVWJiRMTpnCcAXAcMZebjBxbT89M/fe1CcmLnLALQ8Xap8NzYCFQNBCe7UFZDAfgz2MesnHAHy8FHUYp7zWmBBjXy3ZioMT6q59TYpM+0dY3NOaAs1zXzNamH6pOPq7wa8XyyUCsb8hnh5J5TvS5Sz+l4OPSNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770265466; c=relaxed/simple;
	bh=uqaBNWuKMtfpAUlRLveGczjo1f/a4zmBSLBHZYCb4R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ivgp0HBNF3YeXYtCaFarAzq7LnAbb27QskQHAL+umkBpi5acc9l/YrD6S0RPgJu2QnSz7bJ9Cud+rF9irJ4fVZk7u8pSEDKCoBMVpRCa7KwjCTBeiy7Uc7N04s3Eh4NVbqjVNbMddi1vcB5f4hshlJjlugfTK9zaFSCqSd15HWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TgYl+sFU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48069a48629so4169355e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 20:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770265464; x=1770870264; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IRMQoJe6lxyavLbVB8579zPQO6rITEzovQTqZ0nCc9g=;
        b=TgYl+sFUIP3/XekCiVbdGq6hg5Dvpckfy+oINowtTqPFta5xX6WHCoYsjq22KeptKa
         zexTJ1SAYGrlGC6QYU+HnhPRmdVj7/PveRoHMl4a+YWz3BIFGDFftPa+zX/X8uOiYW0J
         ct6zzMO7RuzcMiOC2J0CMvyM8HPlHIv17MCE5ytzIBhRhxH14T2R3xTVqiuusmalysCD
         VpVkKvv6OZNw/azp4EcgoK7Pk0xT2z/cAnjsSqYd3402ZjbXSGAPq0V+vjFsTGXfILCr
         LbGBmcWFEv0ZFpS+P2fAKvg6SggAkNm9HeI+DGKaBB6f31JJ2mSFQ8HaBbcStY4yqgth
         LAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770265464; x=1770870264;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRMQoJe6lxyavLbVB8579zPQO6rITEzovQTqZ0nCc9g=;
        b=dk7uguaO8XZQiEBgHr7y4Trj+OT2/NA+qLLb48e3KD4lxV2srENw3nES31AYI1DDJE
         W6QDZ0R2L1cIZq5dAX4g4qhFLCmTEB4q5QS8T9xBtHWJn70ey00mMJFjwqyRcMt40N3I
         /YEpAntR5/at/GC2EEvUujV2A5KI7A3g08bsmQ04CQ7HwXBMq3IzP6yIcrMSzfCLq4A1
         Xw01nyFgKGdoAa+wdN18RNoMpWt7RtFhZs58XU8cZC4Z7tgXE8c06J8ZddrMq/Y25/3z
         +zM7QYnsJ7ulT4iX/Igydc+ZTS3eFGx59YWw4AMpsktsJigLmFKg0A0gHOXRCEMq3Rw6
         covA==
X-Gm-Message-State: AOJu0YxGeQc81R3I99rCllZn18QE6KOUFCfQ6Vuqa+xF+B1rwPf9n2cw
	4Na5isgiJsxsXeF5cK1KBzY4ny2BpNGkTLYLC7AqosVFqtgJDSeKpPCovXyGdll0GuKfpaMVmuZ
	7y0WfHtc=
X-Gm-Gg: AZuq6aJkqGX+l+yhgKMD1velkxbj4BJ34qj9a9kf/afDG+vcVBkSFZHn+dVzavUYlWZ
	mowS994+avnsPmKu+Jc4nn40WbAuOs1EdszqWfrtgDiVwOFoiH4PyRin8eMMY/cn1H/OmOnrfCO
	YX1IMjzlQQ9F5c1Vo7nCxzOH6cZlgBx/ONO8kHSVOvVMaMxADGFbCped/snpTamUyuKjJW2hDfY
	Ba/KurycB/rmxssHMeVpYsIfYYOTeauu3bM2CTn214L5kXrUY1gnORuowq+pFU/1W2aruBXLC1e
	2P6iUP2IxnFMezm0Wg8LmOhuXtvacAVcrXZgmtZcbJWpKAsGy9jfDUeYbl6daFGDhEtuAwrQQkx
	RwCvz8FZT9zHzAmygkgbYhZQtytr0BrNqpJ1n6NWLDfvK4bLkUdXq5F7jzz22A+sg2XxyroJ7op
	YXCE4fuqa6hWkIwd1PSX8CLYAVKLNfRZW4qpzy9Fk=
X-Received: by 2002:a05:600c:19cd:b0:480:32da:f338 with SMTP id 5b1f17b1804b1-4830e940b2cmr71937235e9.14.1770265463973;
        Wed, 04 Feb 2026 20:24:23 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1a5214sm4207403b3a.16.2026.02.04.20.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 20:24:23 -0800 (PST)
Message-ID: <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
Date: Thu, 5 Feb 2026 14:54:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: We have a space info key for a block group that doesn't exist
To: Christoph Anton Mitterer <calestyo@scientia.org>
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
References: <f3574976d7b5bc8f05e42055d85d4b61263bc5c5.camel@scientia.org>
 <c07b6fde-03a3-4c97-9f59-866c81e78b85@suse.com>
 <31615495f428dbe499ae5f5a109cc6c74c8979ca.camel@scientia.org>
 <fc2f1d31-7f2c-493f-be42-2cb8c1fd5a17@gmx.com>
 <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
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
In-Reply-To: <84b22b2cc7534be60eb423973336101c9e9b9ad3.camel@scientia.org>
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
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21381-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3F00EE861
X-Rspamd-Action: no action



在 2026/2/5 12:14, Christoph Anton Mitterer 写道:
> Hey Qu.
> 
> Took me a while... but I’ve tried that now (kernel 6.18.8), but even
> after clearing the v2 space cache, btrfs check still finds the space
> info key for a block group that doesn't exist:
> 
> # mount /data/a/1/ -o space_cache=v2,clear_cache
> # umount /data/a/1

Can you provide the dmesg during that mount and unmount.

It looks like the v2 cache is not rebuilt.

And that's the thing concerning me.

> # btrfs check /dev/mapper/data-a-1 ; echo $? ; beep
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/data-a-1
> UUID: ff14e046-d72c-4671-b30a-6ec17c58a0f1
> [1/8] checking log skipped (none written)
> [2/8] checking root items
> [3/8] checking extents
> [4/8] checking free space tree
> We have a space info key for a block group that doesn't exist
> [5/8] checking fs roots
> [6/8] checking only csums items (without verifying data)
> [7/8] checking root refs
> [8/8] checking quota groups skipped (not enabled on this FS)
> found 15359868010496 bytes used, error(s) found
> total csum bytes: 14972501936
> total tree bytes: 28026028032
> total fs tree bytes: 10490626048
> total extent tree bytes: 773816320
> btree space waste bytes: 3556556510
> file data blocks allocated: 21845206437888
>   referenced 17683364839424
> 1
> 
> Still nothing to worry about? (in terms of possible corruptions? right
> now I’d still have backups of all data... but probably not forever)

For the check error itself, you have nothing to worry.

Thanks,
Qu
> 
> 
> Thanks,
> Chris.


