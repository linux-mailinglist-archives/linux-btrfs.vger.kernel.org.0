Return-Path: <linux-btrfs+bounces-21382-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NtieGgkghGl9zQMAu9opvQ
	(envelope-from <linux-btrfs+bounces-21382-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 05:43:53 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E07ADEE900
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Feb 2026 05:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEE3630131DE
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Feb 2026 04:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADEB2EB87D;
	Thu,  5 Feb 2026 04:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AIM9AVqa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574513D638
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Feb 2026 04:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770266623; cv=none; b=Mqvx3lw2knYxE8nfgHKOP8GGQGja3ZoEAuq73pivcL2nBgW0cy2C9CxcLGTvLOlJlfJJtQsM1Nk5dVngCH72Ba8G80xYqihL7GW46Pb2fJhPxbnYrxVGZAdrs55wckR3GLSGLeCz7wz5pLulzNIqQqPSNLuWUsrIYhCYUACkSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770266623; c=relaxed/simple;
	bh=F4vyN2NBGSbZ+b6hEl9AR/gsTORIlIf+/kyAMKxba5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pDCAZuDOy9CUsg6xp+jV0fp7Gp37LLjOj6aoMkwe6JxF+cRpJaNtHBxI2yYNV5eGOYbinC1w/uIGsXlxrKvYfSqdid9pzic+6MnzWjas1ZV+fUZXdeb7niLrx2TOkBYD35/R/laTN0SUPPujOQZiD563TUrrSt3XNikz5VKiFDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AIM9AVqa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4806e0f6b69so2906485e9.3
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Feb 2026 20:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770266621; x=1770871421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7o7FDsDkzCoY1fST6VuwM0jJy+FxUEWDabvQrDAQiHw=;
        b=AIM9AVqacfgyZDAKTQ7k8wnOx2S6ORAH9VaFUENSlsc2mQkIgF/YfX6ZlVbMKJ1g4z
         SHK9VPz5RuiclowWzm+gMEU+jy0xkjn1Vrzmh739iQVHG+3alUXJABMF7kQppCGI2/kl
         r0Mc25/QvpV9ZonhpMJKxTeK5E+x/4s9gse0bkyVc4AVpgKjXgR7a/HYyz2gMHypFNym
         7OzejxSratVPGUwMtXSiX1oj8U1r8c6atcyGCAILfALa81214IzTKyGgngCAGjqp1P0A
         NUDXBheKFMRekO5lLA3zxBUtVD5VW67b600xqeioxI62JXJiNboqaaksnXvNsPxO+3jN
         AaIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770266621; x=1770871421;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7o7FDsDkzCoY1fST6VuwM0jJy+FxUEWDabvQrDAQiHw=;
        b=CTQIAEK2A+Sow4ApwWLer87rXkXwJZgjj2faNnMW31m6nEWEPe2ryOM+c2pBAsRAId
         ux7LItq5xT+XtC4jgrR2yas559z3n0HnMi6sS9uZLbQJei0R+sDgkX3dK5FTluXlIwTU
         Z//5ptfGeB94TRYYR1/8xHIYLWlCaWS8yTN4Yqar7rGjWU0UOyI1maCkbx/pQh8qrCC+
         XPB3X5mdbpBECtzy1JQ409gE1glM/oJjhf518GZSko+BTPKD0n2mUw+hh0byYdxUjQwL
         E2RewFxa+Ano+U/5OTX7A7PCNweHYy0UhXXGCSLzTLE+tfCGJcWijTfHpSb5qb4DKpw6
         MeBg==
X-Gm-Message-State: AOJu0YwR2/yF2rC7C/7HrTb6zgz3i1P0ZhiSa2nj35Z+P5s3Qzcf5R80
	5K3I341X75Ta3ltdL+HlShwAP+4KyW231lxvVoctRuFBB+m5eTb4SJXWXWUjTTxfhEc=
X-Gm-Gg: AZuq6aIV46HbXtA6C9z7B43xuReLfN79NnKmpCbHi5iPRrmg2+J/25TH3zXtAUIVosN
	FrRzcXJfKgBFUy5dpQS5ILzdHf64ar6QFIXWMiXKs8qBhvLf2J4c0XHgZew5Evh2D7grj+1QvLL
	Ucs7CteXg0B8txbdYexiGUJOzWY9/qebwUz32o4X/mDqJRkC8yAgqmkI1lOytw7tqes/BK4XSlq
	goVsTJr+gel6PetStsF1wtmLn8188vp4ylKQPp1e2UjRWXs108Kv3YdvcTS5yNl5nIcZljF3z4+
	UXp6F2zKoKFB/KYDv/rRF6vXI72AClDXMoRlyeDnXXaAkI5/w27Y2sqCpn8u2gWzqBQCwhuGQ5N
	rSyYIAe/ZQXEQADIvwX2qH0p4z+AKKOtO9EDm+KHHT7ZmwIVD4+cf9UDXOsQmEEFaS7TvLDn1WD
	OGUEjZSrUhH/ZY/czjHyrogxLIFxiY6EBC2itKDUs=
X-Received: by 2002:a05:600c:3b16:b0:479:35e7:a0e3 with SMTP id 5b1f17b1804b1-4830e993349mr78816935e9.30.1770266620733;
        Wed, 04 Feb 2026 20:43:40 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d437c74sm4081860b3a.35.2026.02.04.20.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 20:43:40 -0800 (PST)
Message-ID: <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
Date: Thu, 5 Feb 2026 15:13:36 +1030
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
 <b681834e-7b0f-4606-8c52-f2b4dafba246@suse.com>
 <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
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
In-Reply-To: <4e6ad7ef198de72edaf890a2257bf63864984197.camel@scientia.org>
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
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21382-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E07ADEE900
X-Rspamd-Action: no action



在 2026/2/5 15:00, Christoph Anton Mitterer 写道:
> On Thu, 2026-02-05 at 14:54 +1030, Qu Wenruo wrote:
>> Can you provide the dmesg during that mount and unmount.
> 
> Tried the same with two different filesystems:
> Feb 05 02:21:10 heisenberg kernel: BTRFS info (device dm-1): last unmount of filesystem ff14e046-d72c-4671-b30a-6ec17c58a0f1
> Feb 05 02:32:03 heisenberg kernel: BTRFS: device label data-a-1 devid 1 transid 4084 /dev/mapper/data-a-1 (253:1) scanned by mount (39262)
> Feb 05 02:32:03 heisenberg kernel: BTRFS info (device dm-1): first mount of filesystem ff14e046-d72c-4671-b30a-6ec17c58a0f1
> Feb 05 02:32:03 heisenberg kernel: BTRFS info (device dm-1): using crc32c (crc32c-lib) checksum algorithm
> Feb 05 02:32:17 heisenberg kernel: BTRFS info (device dm-1): enabling free space tree
> Feb 05 02:32:17 heisenberg kernel: BTRFS info (device dm-1): force clearing of disk cache
> Feb 05 02:32:29 heisenberg kernel: BTRFS info (device dm-1): last unmount of filesystem ff14e046-d72c-4671-b30a-6ec17c58a0f1
> 
> Feb 05 03:39:12 heisenberg kernel: BTRFS info (device dm-2): last unmount of filesystem e1a465db-0227-46e1-9917-d6be986266cd
> Feb 05 03:39:24 heisenberg kernel: BTRFS: device label data-a-2 devid 1 transid 2620 /dev/mapper/data-a-2 (253:2) scanned by mount (53935)
> Feb 05 03:39:24 heisenberg kernel: BTRFS info (device dm-2): first mount of filesystem e1a465db-0227-46e1-9917-d6be986266cd
> Feb 05 03:39:24 heisenberg kernel: BTRFS info (device dm-2): using crc32c (crc32c-lib) checksum algorithm
> Feb 05 03:39:40 heisenberg kernel: BTRFS info (device dm-2): enabling free space tree
> Feb 05 03:39:40 heisenberg kernel: BTRFS info (device dm-2): force clearing of disk cache
> Feb 05 03:39:59 heisenberg kernel: BTRFS info (device dm-2): last unmount of filesystem e1a465db-0227-46e1-9917-d6be986266cd
> Feb 05 03:40:00 heisenberg kernel: BTRFS: device label data-a-2 devid 1 transid 2620 /dev/mapper/data-a-2 (253:2) scanned by mount (54040)
> Feb 05 03:40:00 heisenberg kernel: BTRFS info (device dm-2): first mount of filesystem e1a465db-0227-46e1-9917-d6be986266cd
> Feb 05 03:40:00 heisenberg kernel: BTRFS info (device dm-2): using crc32c (crc32c-lib) checksum algorithm
> Feb 05 03:40:16 heisenberg kernel: BTRFS info (device dm-2): enabling free space tree
> Feb 05 03:40:20 heisenberg kernel: BTRFS info (device dm-2): last unmount of filesystem e1a465db-0227-46e1-9917-d6be986266cd
> 
> 
>> It looks like the v2 cache is not rebuilt.
> 
> At least it claims it would clear it ("force clearing of disk cache").

That message only means we're parsing the "clear_cache" mount option, it 
doesn't really mean we're rebuilding the v2 cache.

Normally for "clear_cache,space_cache=v2" mount option, we will enter 
btrfs_start_pre_rw_mouont(), and it will set @rebuild_free_space_tree to 
true, and later entering btrfs_rebuild_free_space_tree(), and outputting 
a message showing "rebuilding free space tree".

So by somehow your kernel didn't go that path. I have no idea why that 
happened.

I guess for the worst case you can disable space cache completely first?
E.g. -o space_cache=no,clear_cache.

Then retry with v2 cache.

Thanks,
Qu

> 
> 
> 
> Thanks,
> Chris.


