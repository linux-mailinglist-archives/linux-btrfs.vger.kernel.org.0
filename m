Return-Path: <linux-btrfs+bounces-21456-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mA6PGvakhmlrPgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21456-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 03:35:34 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A2D104AC7
	for <lists+linux-btrfs@lfdr.de>; Sat, 07 Feb 2026 03:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7249A305DA7C
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Feb 2026 02:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9AA330332;
	Sat,  7 Feb 2026 02:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hu6y9co1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522D1FE47B
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Feb 2026 02:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770431681; cv=none; b=XUaPA11TpiBhIS/OQyirBXPXY3Y2huDyCh+l3fcY+dgAcCaBlEw+b5R9BtzXl0fclpLS5yaPF7gGAZELjoy3d9NnXwU3X9aGHn1YyuMu6TsaXexDtmvkjyLAuaGNewoaBKs6Wha3qTwZxWuP3PCL2Hz9QK/sAXJVT45/nDqWM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770431681; c=relaxed/simple;
	bh=f33HgZoMQMWTLvt1bh8MKEdI8JTYgVr87YcYsWhsS4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1oS8v8mFqRZ/sBP5siSnQpmaHDsXdc63kgyitOTzgKNDqxUerPnjkQnXN8Zk9JD/NGkoeUEPpbXFRGSb53APurtmAy7U5dNanBbnpfAgP3jRA0biAiVJOq13t6arNf+jL+iiz2dWBr/C5N6Xit3sreLOV1vSv3XmF8YVA7mMBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hu6y9co1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48069a48629so24822125e9.0
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Feb 2026 18:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770431679; x=1771036479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=86EYPnxJ4ttYO1y1g+bCxrZ15h2589GsV8yiOtMjsjw=;
        b=Hu6y9co1XysCC6nYah/84ktwWyALqqltyUJYBSRtK0IEogHIQQsiDeA3x5r5kHaOGP
         A8xSNGIUw5bucING1Lk4Oi4h44OCjbYu1unCWB47fTPtvejtU+O4WYdR+4gGWr3iKLmB
         dLH1mDjjcZwzo2/GEILv8HFvjk6fg8MUNCe1uJJTH+1+B5sGw074336UhUYTbbfpo/SB
         6ahHKRPqoFqC0zS1YCvpYjXt/I2SfZwGPnsd8poQkz0iyoi/FsZaMcijabruxnp1tMjz
         i6gl1nnrkyhNO2zQcWT/GUp36EkKPXJMwtzklctd2lt+aWK+xYGo+8jwqwUVV+RFZhkN
         69tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770431679; x=1771036479;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86EYPnxJ4ttYO1y1g+bCxrZ15h2589GsV8yiOtMjsjw=;
        b=TrW8T0PFjrdsilqonwBMIkTxOlZQI1bhdPEjcKm2mcvRL5tMcizvKQz5FsmCNYFWhv
         r5xFekDjDkBTC3npgbkWZrZ2irpacm/w5sv2CEt+wwssVYqyApmR/0rXzEtkgBIVkt5y
         czpaVODiOXszSmrwu5J2MNLMAiBWyx5GTqDrKlXjeR9UvOXYWFvZgzTAjiR6+ip26r0t
         iUxCnONX257NSs5dIFL9t9TIryFLlkx4iIk5lVE/UeeJq/CD2Q0FHec/s9hIiyOU889Z
         VucWFR6ZBUY4+zTrsoeaEU+YfYQW3CT0gR1jTtdQj40gOhnIX+2azKWJqaYV1XLjRWjj
         vrhQ==
X-Gm-Message-State: AOJu0Yybi1682O18/tjdD/utOyivp4mMCVOA8GOmb6C9ada0qcNnf6cY
	q/6POH3OaIqrYu7yCcBThvS0krGMhMcihGgOUri9EMBgZ0U5kEaZTxsmGo2LCw2lM2h42XKgecP
	ypOONPlQ=
X-Gm-Gg: AZuq6aLbRXqRagtk4AJfUf1Qsr50Kyb5WqcOJNVGkWdo95FZCgsF2gNBwQcoGt1MWfv
	gJjUdzkrx1IYwFtxBlXXz/5L4+lhhGXoQBmpb5ZlfU5F6YzIhZC9ScxBKHK13jzGGa8mymgZ+ia
	Nlxxtj0/ERNv1WGGRMzusfxY9wUrN9MscoV7I1m/FNAecD6IE91H06IdRlUJKxl77Ugh7x8EV3s
	IVJezSG+4rlbmbfTwUjjgqViwmixtZPDrck18ZMvjQZ18pdffAgIdDNfMOkZnggeWZenadn5HMP
	7hk83HihFEkoKNvCOw2/jTgbHSmHp0n/rXMa6yJkWp2BTj3YjOJC5ms8qVtRpG+5LPJstxdnUY2
	OnTlYe95nqetbkbqWRf1UWS5XKNYZ6dFOyhxPNSmkNlfdM7d7xHW8RUgvpQ9Bw3FEe7vzhk9pMD
	8pdZd0pCVKvUVL/vxxHmK2X1XgUGEZzlHHby5+4T8=
X-Received: by 2002:a05:600c:5489:b0:480:3b4e:41b8 with SMTP id 5b1f17b1804b1-48320229c89mr68305115e9.33.1770431678826;
        Fri, 06 Feb 2026 18:34:38 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441882481sm3465724b3a.35.2026.02.06.18.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 18:34:38 -0800 (PST)
Message-ID: <a6d825eb-3e8c-404f-90f6-6b4e5621479d@suse.com>
Date: Sat, 7 Feb 2026 13:04:34 +1030
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
 <cca8b4ea-97ef-433e-9db9-4eca67b89576@suse.com>
 <f1aaada378adad0da020bd679531c7f503ad6f93.camel@scientia.org>
 <914a6a60-6bb6-4255-a8cc-ea6f28e7a9cf@suse.com>
 <a75537dc77e5b6fac922a97409ca4636805147dc.camel@scientia.org>
 <fff60222-0b9f-4f09-b3a6-d415aa64b6d7@gmx.com>
 <18a87dd4f3155bb1d9c9884f39dbf53c802a10cd.camel@scientia.org>
 <572f0ac4-90f6-4c56-aa4c-2a64e365d526@suse.com>
 <52c813cf8dffe11325ce291d3f3bd41bcce21936.camel@scientia.org>
 <f094ddbb70cabd2e329615269519b1844f786629.camel@scientia.org>
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
In-Reply-To: <f094ddbb70cabd2e329615269519b1844f786629.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21456-lists,linux-btrfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:mid,suse.com:dkim]
X-Rspamd-Queue-Id: B6A2D104AC7
X-Rspamd-Action: no action



在 2026/2/7 11:57, Christoph Anton Mitterer 写道:
> Hey.
> 
> I think I might have found the reason... and I guess it's a mix of me
> being an imbecile and perhaps not detailed enough
> documentation/messages:
> 
> 
> When I did e.g.:
>    mount -o space_cache=v2,clear_cache
> I actually used my fstab entries and did e.g.:
>    mount -o space_cache=v2,clear_cache /data/e
> 
> but my fstab is has ro set as option for all these data devices.

OK, you got me completely.

Next time we need the full mount command just in case some one is using 
fstab to save some key strikes.

> 
> 
> So I'd guess ro here not only means no "normal" IO. but also no fs
> internal IO (like rebuilding/clearing the tree).

Not really, read-only mount can still write, the most common one is the 
log replay.

But other than that, we follow RO pretty well.

> 
> Would also explain why it worked with btrfs check.
> 
> If I now mount it explicitly e.g:
>   # mount -o space_cache=v2,clear_cache /dev/mapper/data-e /mnt/
> 
> I get:
> Feb 07 02:20:33 heisenberg kernel: BTRFS: device label data-e devid 1 transid 12267 /dev/mapper/data-e (253:1) scanned by mount (21114)
> Feb 07 02:20:33 heisenberg kernel: BTRFS info (device dm-1): first mount of filesystem 1f346f85-af92-4025-8647-6d1ecb962bc1
> Feb 07 02:20:33 heisenberg kernel: BTRFS info (device dm-1): using crc32c (crc32c-lib) checksum algorithm
> Feb 07 02:20:48 heisenberg kernel: BTRFS info (device dm-1): creating free space tree
> Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): setting compat-ro feature flag for FREE_SPACE_TREE (0x1)
> Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): setting compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
> Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): checking UUID tree
> Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): enabling free space tree
> Feb 07 02:23:41 heisenberg kernel: BTRFS info (device dm-1): force clearing of disk cache
> 
> 
> Not sure what one should do to prevent this trap?
> Nothing a all? A kernel message that xxx isn't done because the fs is
> mounted ro?
> Documenting all these cases (this probably not just space cache
> related?) in the manpage?

I prefer nothing, if we really want to dig into the situation, I should 
have asked about your mount command, but I haven't and that's my fault.

The function btrfs_start_pre_rw_mount() should give us enough clue, but 
I didn't think too much about the RO mount possibility.

So nothing unexpected expect the fstab usage.

Thanks,
Qu

> 
> 
> Cheers,
> Chris.


