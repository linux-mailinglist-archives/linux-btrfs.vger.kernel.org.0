Return-Path: <linux-btrfs+bounces-21861-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NMJbHtFJnWmLOQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21861-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:48:49 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DED182887
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 07:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDC4330734CB
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Feb 2026 06:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE18A2F12AF;
	Tue, 24 Feb 2026 06:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U7o2gveB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED71367
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Feb 2026 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771915721; cv=none; b=rie2UYPMftx2yi204cjFixmP3iMfokfzeZ2TBJv0OiYtDxqzfSi7tiv8/+7/8DAd2Vpnq98hbkLy2pt7zYs3aDZJ4y7xe+Fc7dcWgMth/hDte7SRZQE54BrVFdJ8RVs9XQ28VsDyvg2+rsNGLGyosx730BQXNtlq8CtwBPEyC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771915721; c=relaxed/simple;
	bh=4ylNWypsuhx9LHDaDg5URq458OpvPkDs+SiHtlMIjPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQVfbheNzQuGGbGcLP/OdafqzWfHtaoqG5p52E/xV5XaiH3chThw4VGhYzHFiKcQnSBw9B45QnbbJXSEmOLaWcbTGRlyHsSvPNEXIzS5FwD0hSS0D/6n3ptrwoVkM8TwcQY9ZzpxUqoAQIqelq9YfcrMRGnswrKEvGhsAxYvaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U7o2gveB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-483703e4b08so40601015e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 23 Feb 2026 22:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771915718; x=1772520518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mI0ID9dgFA9CTGmtCf5PFRmxKnR+sAq5iQ25NnzfaF0=;
        b=U7o2gveBx+cv6B825V5kJYF3lfwHzNfibIR9nJWdXRHzCidHwwlCZBwamCDKuV50kE
         Rmq7S9CIsHIE/C5OgO1s3ZRvei/rkX+HBng82dYt1Qm9x457fGWN43bIStfDhB1b/Vx6
         JrYqJP8UT2aWufvZ7TQq5J/5K3DTklncNu7zKEUqV3c1V7rSh5c/2WveItb4IE6vPPtY
         Dv3t/TCtg/kxo+HklOU+DBv4jsgpAZFwrkmwePHNWK2rFNqJkEXiMUr0CAyYcFzQAZg2
         a5+WyOYcjDzV+CMSh+OildN3gJSHZ4ah3jPY/kL4Wo1q98JYQ7C5POtDm7k1zQTymfis
         JJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771915718; x=1772520518;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mI0ID9dgFA9CTGmtCf5PFRmxKnR+sAq5iQ25NnzfaF0=;
        b=UwTjTx/VZi8EZ+dTXFHNOBxXT1yjHSa3/5j2Gx6RQsRWIiYIh0efrJUU1up+e1HwG0
         ybg9mbqp2PrbVfi45fRJOE7mgS5/2M7/Ij8RjLW+Q6U4eAr65lAGmqjYQhYlbWoTLZux
         DAimJMJOk+QHY5Z2BATixXP48ES2GxrsMD8AtjOH12geMmEq1rWBDeSXnpWpjAGhDz93
         Cu+IuqBdbnqyjdMCfB9gIzuN8bDYpV8m+lKaKWm7/MzeHzh2WpanCFf75U4OpkC1ijki
         H9hIBuXZGCvi73WSZRkN9/TXKwZ21yq64BkxTgbiPK3psmgiiq4cnOu+Ui52G52OC6oF
         G+pw==
X-Forwarded-Encrypted: i=1; AJvYcCU+4/HlR1RJeB6pKzn46ZEtMF2m3D0P8ixKQHhadDPSTYRrJo4/mcYjTk+fv8hRoi3joWMT5bVg8zVbcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgsw6kXqLtZzKK9nLmATe9Gr3uwEedbBFF3IeeLaWcAO34D50
	IbH4vX/ACnNY6XY2UexE8TD/j6S+QXLLbRNK2gfHj29JWdtS+SfCAIzAu7dg7on40oI=
X-Gm-Gg: AZuq6aL6TMOUizSZ0/3KPR6WfvkzYjlWR2RP/YSBIjFfAjpWs6nulVa/PdZOU8Quuoj
	y28Ae00vdVqRg01v9xt2Vz+qehSKI8QDRU8jDlGMyNU6lrVFZXVLWqO2kUtpUkZxNGJmOAaMPp7
	DvvcnYWUktVAEQHt3UNJnmhc5+aAg9MgT39RNRbE2vZpc/l9qevhITTf4aZ9iGvXGWYpVG2D/qZ
	iPNQCj1HtjC89orCoA0Qw6oRlYzcqpuIrUuKoiSrm3PunvI8cFQafRZ60hmf6nlzPVVDp5ydCGv
	ndc055xBpeBrlvUO507Y46MWuv+2TDUjwhJtbA4Gx6vBpTCKUEyssO8fOe0E4DrWv5A9sUmUkf6
	UPLjNdlawfwZWfEMibiBRGBpOOY4Zxcqxif2SJkm8JsWjKq9gFUV/hRiKeka/8eJo9qVg8Ht9Fy
	TkhqdJoUgaDVlI9pzfvqTQPMGla0IXu2ddAAZINZohdFq97oVNTsY=
X-Received: by 2002:a05:600c:6c87:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-4839fe8e8b4mr181446105e9.1.1771915717564;
        Mon, 23 Feb 2026 22:48:37 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad97d6132asm12997805ad.68.2026.02.23.22.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Feb 2026 22:48:37 -0800 (PST)
Message-ID: <e21ea0cf-b392-487f-843f-962efedcf10c@suse.com>
Date: Tue, 24 Feb 2026 17:18:31 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: replace kcalloc() calls to kzalloc_objs()
To: =?UTF-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>,
 Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: dsterba@suse.com, clm@fb.com, naohiro.aota@wdc.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, kees@kernel.org
References: <20260223234451.277369-1-mssola@mssola.com>
 <69c16813-5ac1-4756-ad42-41b4275e6aee@gmx.com>
 <699d4704.050a0220.1a6450.86d7SMTPIN_ADDED_BROKEN@mx.google.com>
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
In-Reply-To: <699d4704.050a0220.1a6450.86d7SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[mssola.com,gmx.com];
	TAGGED_FROM(0.00)[bounces-21861-lists,linux-btrfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E1DED182887
X-Rspamd-Action: no action



在 2026/2/24 17:06, Miquel Sabaté Solà 写道:
> Qu Wenruo @ 2026-02-24 15:07 +1030:
> 
>> 在 2026/2/24 10:14, Miquel Sabaté Solà 写道:
>>> Commit 2932ba8d9c99 ("slab: Introduce kmalloc_obj() and family")
>>> introduced, among many others, the kzalloc_objs() helper, which has some
>>> benefits over kcalloc().
>>> Cc: Kees Cook <kees@kernel.org>
>>> Signed-off-by: Miquel Sabaté Solà <mssola@mssola.com>
>>> ---
>>>    fs/btrfs/block-group.c       | 2 +-
>>>    fs/btrfs/raid56.c            | 8 ++++----
>>>    fs/btrfs/tests/zoned-tests.c | 2 +-
>>>    fs/btrfs/volumes.c           | 6 ++----
>>>    fs/btrfs/zoned.c             | 5 ++---
>>>    5 files changed, 10 insertions(+), 13 deletions(-)
>>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>>> index 37bea850b3f0..8d85b4707690 100644
>>> --- a/fs/btrfs/block-group.c
>>> +++ b/fs/btrfs/block-group.c
>>> @@ -2239,7 +2239,7 @@ int btrfs_rmap_block(struct btrfs_fs_info *fs_info, u64 chunk_start,
>>>    	if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK)
>>>    		io_stripe_size = btrfs_stripe_nr_to_offset(nr_data_stripes(map));
>>>    -	buf = kcalloc(map->num_stripes, sizeof(u64), GFP_NOFS);
>>> +	buf = kzalloc_objs(*buf, map->num_stripes, GFP_NOFS);
>>
>> Not sure if we should use *buf for the type.
>>
>> I still remember we had some bugs related to incorrect type usage.
> 
> Considering the type of 'buf' and how kzalloc_objs() will resolve the
> first argument '*buf', it should really just be equivalent to what was
> written before.

Good luck if you miss the '*' for a structure pointer, and compiler 
won't give you any warning.

I still remembered that Johannes exposed such bug for me.
Unfortunately I didn't have exact lore link for it.

> 
>>
>> Another thing is, we may not want to use the kzalloc version.
>> We don't want to waste CPU time just to zero out the content meanwhile we're
>> ensured to re-assign the contents.
>>
>> Thus kmalloc_objs() maybe better.
> 
> Yes, having a second look at this function, it looks like kmalloc_objs()
> might just be enough. If you don't mind, I will add another commit in v2
> translating kzalloc_objs() into kmalloc_objs() wherever I see we can do
> this from the ones I've touched. This way we can easily revert in case
> things go south :)
> 
>>
>> Thanks,
>> Qu
> 
> Thanks,
> Miquel
> 
>>
>>
>>>    	if (!buf) {
>>>    		ret = -ENOMEM;
>>>    		goto out;
>>> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
>>> index 02105d68accb..1ebfed8f0a0a 100644
>>> --- a/fs/btrfs/raid56.c
>>> +++ b/fs/btrfs/raid56.c
>>> @@ -2110,8 +2110,8 @@ static int recover_sectors(struct btrfs_raid_bio *rbio)
>>>    	 * @unmap_array stores copy of pointers that does not get reordered
>>>    	 * during reconstruction so that kunmap_local works.
>>>    	 */
>>> -	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>>> -	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>>> +	pointers = kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>>> +	unmap_array = kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOFS);
>>>    	if (!pointers || !unmap_array) {
>>>    		ret = -ENOMEM;
>>>    		goto out;
>>> @@ -2844,8 +2844,8 @@ static int recover_scrub_rbio(struct btrfs_raid_bio *rbio)
>>>    	 * @unmap_array stores copy of pointers that does not get reordered
>>>    	 * during reconstruction so that kunmap_local works.
>>>    	 */
>>> -	pointers = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>>> -	unmap_array = kcalloc(rbio->real_stripes, sizeof(void *), GFP_NOFS);
>>> +	pointers = kzalloc_objs(*pointers, rbio->real_stripes, GFP_NOFS);
>>> +	unmap_array = kzalloc_objs(*unmap_array, rbio->real_stripes, GFP_NOFS);
>>>    	if (!pointers || !unmap_array) {
>>>    		ret = -ENOMEM;
>>>    		goto out;
>>> diff --git a/fs/btrfs/tests/zoned-tests.c b/fs/btrfs/tests/zoned-tests.c
>>> index da21c7aea31a..2bc3b14baa41 100644
>>> --- a/fs/btrfs/tests/zoned-tests.c
>>> +++ b/fs/btrfs/tests/zoned-tests.c
>>> @@ -58,7 +58,7 @@ static int test_load_zone_info(struct btrfs_fs_info *fs_info,
>>>    		return -ENOMEM;
>>>    	}
>>>    -	zone_info = kcalloc(test->num_stripes, sizeof(*zone_info), GFP_KERNEL);
>>> +	zone_info = kzalloc_objs(*zone_info, test->num_stripes, GFP_KERNEL);
>>>    	if (!zone_info) {
>>>    		test_err("cannot allocate zone info");
>>>    		return -ENOMEM;
>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>> index e15e138c515b..c0cf8f7c5a8e 100644
>>> --- a/fs/btrfs/volumes.c
>>> +++ b/fs/btrfs/volumes.c
>>> @@ -5499,8 +5499,7 @@ static int calc_one_profile_avail(struct btrfs_fs_info *fs_info,
>>>    		goto out;
>>>    	}
>>>    -	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
>>> -			       GFP_NOFS);
>>> +	devices_info = kzalloc_objs(*devices_info, fs_devices->rw_devices, GFP_NOFS);
>>>    	if (!devices_info) {
>>>    		ret = -ENOMEM;
>>>    		goto out;
>>> @@ -6067,8 +6066,7 @@ struct btrfs_block_group *btrfs_create_chunk(struct btrfs_trans_handle *trans,
>>>    	ctl.space_info = space_info;
>>>    	init_alloc_chunk_ctl(fs_devices, &ctl);
>>>    -	devices_info = kcalloc(fs_devices->rw_devices, sizeof(*devices_info),
>>> -			       GFP_NOFS);
>>> +	devices_info = kzalloc_objs(*devices_info, fs_devices->rw_devices, GFP_NOFS);
>>>    	if (!devices_info)
>>>    		return ERR_PTR(-ENOMEM);
>>>    diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>> index ab330ec957bc..851b0de7bed7 100644
>>> --- a/fs/btrfs/zoned.c
>>> +++ b/fs/btrfs/zoned.c
>>> @@ -1697,8 +1697,7 @@ static int btrfs_load_block_group_raid10(struct btrfs_block_group *bg,
>>>    		return -EINVAL;
>>>    	}
>>>    -	raid0_allocs = kcalloc(map->num_stripes / map->sub_stripes,
>>> sizeof(*raid0_allocs),
>>> -			       GFP_NOFS);
>>> +	raid0_allocs = kzalloc_objs(*raid0_allocs, map->num_stripes / map->sub_stripes, GFP_NOFS);
>>>    	if (!raid0_allocs)
>>>    		return -ENOMEM;
>>>    @@ -1916,7 +1915,7 @@ int btrfs_load_block_group_zone_info(struct
>>> btrfs_block_group *cache, bool new)
>>>      	cache->physical_map = map;
>>>    -	zone_info = kcalloc(map->num_stripes, sizeof(*zone_info), GFP_NOFS);
>>> +	zone_info = kzalloc_objs(*zone_info, map->num_stripes, GFP_NOFS);
>>>    	if (!zone_info) {
>>>    		ret = -ENOMEM;
>>>    		goto out;


