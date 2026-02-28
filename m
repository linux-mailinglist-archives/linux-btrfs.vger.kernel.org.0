Return-Path: <linux-btrfs+bounces-22100-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h8eECT6Oomk04AQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22100-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 07:42:06 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B091C1C0985
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 07:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D31013028504
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Feb 2026 06:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E425342CBD;
	Sat, 28 Feb 2026 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RDcxk3vZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D022157B
	for <linux-btrfs@vger.kernel.org>; Sat, 28 Feb 2026 06:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772260920; cv=none; b=cntnxPaQ9qCL2+u21O4lneQvEFJpKiLj5HQE7n6m3lFogKcPubLaJxTvCmEulygFrJQ9bt5EXBuawGzMSUgOUNtQTMBM/bb9+g7BARdVOSdL8p5AtH/7uD/KAVXxcovkiwfE6v6bCXnAXWd0Mujwf8u1ufvsWrTdJko34YCtrnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772260920; c=relaxed/simple;
	bh=z+o81kn/ql89cKoZlXDAhxD6qUyiW0IvNUb6VG4euYs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=rJiJlRohta7gudgKILWi6pCD5Rs2A7xSVdtX5eHVgXhz+sn5YTX+TzbsYH68OD4aGEFIHnnSRQKDclWCifd0/if9IrHiOCqH86t970DqR1aiYyCdWyKstGWAogfy1djZ7vm1DWwx2CBrr/dO5NRWX52FlxgNUEJWuO/IDemvWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RDcxk3vZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48371119eacso32274615e9.2
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Feb 2026 22:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772260917; x=1772865717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VJ4utVQjiEiAzRmrbINb4sFzSqLIX1TyQuUIo3ZnNQE=;
        b=RDcxk3vZNEmlmqHi7GTmsitNHuMeJykKsdjpBEOSqHeFAwrmZCop5yBlj1/+ramiVE
         J66da23HcgPYKgOEBROSSIaBhNDQz8/y+hbVA41QuEQIUoon/0LQu5O8REe+vfvtZac/
         b9egbcxcNTaohAsSWPm+eO0zM+iOjZElE9gpVpLLei26gxbxR9ScTiC2hmW20wyqpVNt
         DA5rGczZcoXfKpVRg+lhK4Oenq1niD8GJqktmmVKn1tpFrH1VxQMqq/FesrUhHPAtpVj
         mIzQ6MVw8M/t1ADsWJuqkavS7QaGKnD/3vD2eN1Lt2+L1p3wyTloGKjABGroUznj3b5M
         gjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772260917; x=1772865717;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJ4utVQjiEiAzRmrbINb4sFzSqLIX1TyQuUIo3ZnNQE=;
        b=YFF+/HuTd2mRb8N7b7257Y3BDOd1W6zBRs+QXjGyfIxJdfSb8XQSzvkMixNcA3pp+e
         fYfEc5vbbWBxwquex8MFXAQVaLXoqkU3HSXJrBPf5fxZLOaGh7ZNo/zqYloH8oVVMedh
         QH7W1HNvQrs9MohgTsoX31WnLGehG0e0OMsXU3Bp3vIogIzIAPSQi1NSY1gAGUjNpBFH
         sW+zCJaMkbXyHwS3LEds9lVJqsFHOixfKY1/UqJO407tmyIuMt7EOce6imm1jRItudzn
         ON9ElepTqOEvFiB4RGnwchUyHiFcl0WemWrdzG5xJYD4WcxUFzPRMgT3aMsGgBYmYh1t
         SsGw==
X-Gm-Message-State: AOJu0YydYbAb+Fw/UaquZRZZTOnM42NANPsB2XFIxZh4eN4DnlsKg6lg
	arYQQ/mCrTK1wvZQT9IMcpBcTDLKoWXDhTzgK7QGS7H3l+GZOA/g7UbPULIB/HJMGqxqhYKhxOl
	UWuFmIMQ=
X-Gm-Gg: ATEYQzwtCvRYYVD/na6lQgg2idxmJmz8GAwtom7EQ1uOi/gHF8GhaWTLeqaIzFHNINY
	KckEkqDlQPxas5AP3IagDvh4MR+drLBQaClgQHl9vQdP2zGoqcguQNQk/JJCYeZGsVCIRgC3Ntp
	GlBRKmhIpk3fI5z4mPZ2aBTd4kCo1T+dzLEtYHGzmly36wi73Sogzo3Nq4cDvSbwTmJFb+JJiv8
	U7w5gPOPl4VbCHkYO5NCzFLoxOohH1RZZUPPzt3PQZI/NFpZV4RzJ379qe9ul+Wswy20HAPvx3G
	AhMddoU+Qis+A5CawPWBDYj9Lpz2SEBw8KLbHMXkhhVawaxPmw0vr5BNTdrnPQLHVghweZ9EdqU
	73vRF0Mxn4lZURJyT2RrbcEf3Yv9Q43cuamBcRQsmFHEMDF2p81brNAa8j7M1Bl2+qGdEAZ1GKp
	UNz0oQKfWb23eYMxZVMQdj9mUu89gDxn5GUGh6pIMEkr9Zbqsvzq0=
X-Received: by 2002:a05:600c:c4a6:b0:483:4a95:66da with SMTP id 5b1f17b1804b1-483c9bc1d50mr90429325e9.13.1772260917295;
        Fri, 27 Feb 2026 22:41:57 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5ea0dcsm5899955a12.3.2026.02.27.22.41.54
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 22:41:56 -0800 (PST)
Message-ID: <67d965b7-9cf0-4ffa-8c87-664c30d48be2@suse.com>
Date: Sat, 28 Feb 2026 17:11:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: fix unpaired compr folio allocation/freeing
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1772238005.git.wqu@suse.com>
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
In-Reply-To: <cover.1772238005.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22100-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: B091C1C0985
X-Rspamd-Action: no action



在 2026/2/28 10:53, Qu Wenruo 写道:
> With the recent *_compressed_bio() rework, we're using compressed_bio
> everywhere for reads/writes (including regular and encoded).
> 
> However this requires us to allocate/free folios using
> btrfs_alloc_compr_folio() and btrfs_free_compr_folio().

Sorry, this is only a cosmetic fix.

The btrfs_alloc_compr_folio() will only grab a folio from the 
compr_pool, and after that the folio can be handled just like a regular one.

It's recommended to use btrfs_free_compr_folio() so that pool can be 
re-charged, but not strictly necessary.

And even if exhausted the pool, we will just fallback to regular allocation.
Even without exhaustion, the pool can still be fully reclaimed when the 
shrinker is involved.

So this series is not addressing the problem that David is hitting.

I'm afraid the best way is just to get rid of the compr_pool completely.

Thanks,
Qu

> 
> Not using the later to release a folio allocated by
> btrfs_alloc_compr_folio() can screw up the LRU list.
> 
> Fix the unpaired calls as a hot fix.
> 
> For the long run, I'd like to remove btrfs_(alloc|free)_compr_folios()
> with regular folio_(alloc|put)() instead.
> As I do not think the compr pool is that helpful compared to the extra
> maintanance needed.
> 
> Qu Wenruo (2):
>    btrfs: fix the incorrect freeing of a compression folio in
>      btrfs_submit_compressed_read()
>    btrfs: fix the incorrect freeing of a compression folio in
>      btrfs_do_encoded_write()
> 
>   fs/btrfs/compression.c | 2 +-
>   fs/btrfs/inode.c       | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 


