Return-Path: <linux-btrfs+bounces-22138-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MrJImVkpWmx+wUAu9opvQ
	(envelope-from <linux-btrfs+bounces-22138-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:20:21 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D60A1D6550
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98E7C306C461
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 10:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBAF39B97D;
	Mon,  2 Mar 2026 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OvWseO8Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0921A38F254
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 10:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772446480; cv=none; b=ZoMhwkRIEaTWStk/tFEyFUaLMGaLSHaEkv5LBfx4DJCQ0qbWbU99k3a/4uhUyYTSNa52k0brryu6/hjGQkjYFEgFLW1s7I0w8AP0DG5QLiPSn7wmoG/pW+YgKb8Vu0dJbGsLTUUQ1ilkDi7JEJ0G2WhJqFK7iKKbYap6qbAgqvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772446480; c=relaxed/simple;
	bh=YKo8ebElBpSuxvCCU0RI3PEXUYuRsMhz9kTGnNZZRiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U8Knl7Jja4ByAFkd/2VqdPR5s3DewKt0bFt/Vazhky3+rMwStfCKbsPHjSTAZ7cK08SnCrKHHKgPBhtxzwh2xDuYl/7NrISf07/lbIRrUmLXgtgp9F5nHMedRDjjzH5kQR7fZvhcnkNQsJFZ1BD0fdQys+LHCd1CpvtXPKwH9d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OvWseO8Y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483770e0b25so37149795e9.0
        for <linux-btrfs@vger.kernel.org>; Mon, 02 Mar 2026 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1772446475; x=1773051275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=f7aMrhnfweYUXWjXEW7R/U16ZKfbe2UJNOk3DBae8bA=;
        b=OvWseO8YdYIeLBKQcSfwh+QaNcXfx3a1QeDR9A4stR9WG0GffFkx42FP0hRaCIit5u
         ysDKx3DvPLSzMhryyrX3dzyJYuGjm+4FEAtMfGhubU+oQzNCjqeGiDblWleTSesiGIoJ
         4nezILT5Sc0+YxmAHJqy4ysPjCPiR1dIE/9EiVBjse2bKq8w+C2FNh/4V5SIFmFnTk6Y
         F79sMJZ6lO80o8y2E7JAGzUxMf2FlubsYB4ar/ZowosC0N9iFn+VGyebnRnsgHPiJ7Is
         KjGPhJFAOb2GfLRIY/NXhoEG/clFVyubINhZR1nmEZ1lWQZllcSWfeyevZ1w5KC57vi5
         4dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772446475; x=1773051275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7aMrhnfweYUXWjXEW7R/U16ZKfbe2UJNOk3DBae8bA=;
        b=OT46Uaqr8vNxGl4yn/JpBCkmPzFZPriiD+7PFhtwOBBeBXs9HbNYdcouwKxQdoKZIB
         28nKbfVNA5YINUAaA4oa7jWHY/9eWAqnss44No/AtKEdGJts3DYAcOHlD3KamvIMTdi7
         38wBr69OnNOreFt+f1ToPX8J8mmY11ZUEBGSHscWXv7mKDVDM6NWhTF2zlEsY3QYcSvj
         J3lzZMXwz044pSW46udOIeVCYyiAi2RZ+/XnMWwBbxMsZoKjMSlYL4o0SGJMLAbbqdrT
         hMuhUVDKtCFY3BKMWawLkVOm1w2tlPLtoadSwKJ0tNx6TSqGTe1yWbO51upSH4SouPKJ
         wuJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs94n7QaRrxpQRO6FRbE6OwzH+Z8bnxuYQZgUyrf+fGRgRT7dCo/w1OS8P3zER1BtlEmZM6O9af58cLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL4AsYqe52fIik5v6hB+jxEkRjkIYEsIVRO6EqrR7edlVFW5DY
	rstkVK/xQjTQYPvLSoTZy4/P4+hMcqbWOF+9jPxElXjLuKJiHcJVsxKCP6c8XKXnyihxRSJlxKY
	KC17qGFQ=
X-Gm-Gg: ATEYQzyMZy/ld/OxS5nlSA50yu1kl+HiHFCvqCcsnml4w7p4MwGbOrH+Wvqng6WRXYL
	kIKTNBKDIQlgm7m8Vii/TR8R5iZR40NYh8Vh0fysTmv935ADS7zauMnAoZr3MwDslegpYTSNg7q
	RJD0UjPINSFvqFYftfGuQKRZg1zBFWATQHmfeJ/RsxmSB+6cEMDl3LXI7nc268jnLeIFZuABqNp
	fJNtUYu4sw3MqWD9IKGjKBvbup+xPitrmL/wpFudJg64bXE2ayuythidsrbGoKd5bLn90i9IzYR
	sbQCusLd0VHzXTJm2QN0+l9wWZGBmDicB0eT3BWjK4p0HEde+8co514qfTwVgPwIuVMJOB/Xk7E
	nFwycU4WSZ/lqtlDE7Prb1J0eDTz0GqZmFYz5WAK9SGC9G9h5c33yQeRbqM1hnfl5/e56eVhyXG
	1T0huzc4+FUtnSv1XJuUy0W1n436nUsIIgHmpP+RsPoq3+BaKSgss=
X-Received: by 2002:a05:600c:a47:b0:475:da1a:53f9 with SMTP id 5b1f17b1804b1-483c9be2ab1mr211142205e9.14.1772446474909;
        Mon, 02 Mar 2026 02:14:34 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c183bsm138745415ad.24.2026.03.02.02.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 02:14:34 -0800 (PST)
Message-ID: <15f543c6-acec-48f5-bfd5-e14e15c5d8ab@suse.com>
Date: Mon, 2 Mar 2026 20:44:30 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: pass 'verbose' parameter to
 btrfs_relocate_block_group
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-btrfs@vger.kernel.org
References: <20260227131224.159801-1-johannes.thumshirn@wdc.com>
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
In-Reply-To: <20260227131224.159801-1-johannes.thumshirn@wdc.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22138-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: 0D60A1D6550
X-Rspamd-Action: no action



在 2026/2/27 23:42, Johannes Thumshirn 写道:
> Function `btrfs_relocate_chunk()` always passes verbose=true to
> `btrfs_relocate_block_group()` instead of the `verbose` parameter passed
> into it by it's callers.
> 
> While user initiated rebalancing should be logged in the Kernel's log
> buffer. This causes excessive log spamming from automatic rebalancing,
> e.g. on zoned filesystems running low on usable space.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/volumes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c0cf8f7c5a8e..95accc9361bd 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3595,7 +3595,7 @@ int btrfs_relocate_chunk(struct btrfs_fs_info *fs_info, u64 chunk_offset, bool v
>   
>   	/* step one, relocate all the extents inside this chunk */
>   	btrfs_scrub_pause(fs_info);
> -	ret = btrfs_relocate_block_group(fs_info, chunk_offset, true);
> +	ret = btrfs_relocate_block_group(fs_info, chunk_offset, verbose);
>   	btrfs_scrub_continue(fs_info);
>   	if (ret) {
>   		/*


