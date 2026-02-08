Return-Path: <linux-btrfs+bounces-21511-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEYBE+YYiWky2gQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21511-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 00:14:46 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D5310A954
	for <lists+linux-btrfs@lfdr.de>; Mon, 09 Feb 2026 00:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5CD63009B2D
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 23:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC622381706;
	Sun,  8 Feb 2026 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A5EToV/Q"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1672346AC1
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592477; cv=none; b=c2Ryavk++xeyLuUBEPmGwsbASfLvT+z2rMEMYRusn1wyfcfcAiVKxDU1v2Sq635w9sz9krjhN1PDVqdesgI31KGs6QW1zdjKwfMlsme6oZFjID/8zKEllmTWN7vUGmJfTCjUO0DFx2s8hWn5auFD3CXX/IT1D+liIUzfw0fOq84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592477; c=relaxed/simple;
	bh=XxWdBiWK2VFfMK5u5g2sMlQO/UL0S5mCMx1OHyT80as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hS1m3kXZCTIRmR4SpYoDxujsSKgnKIJ+BMKJlP7vMpuFtNvW5VMINVX0vSJ9axUpd7bGfpT469k84lu0k8pHVcuxXAdk0XZLzN7y8zvylxxvxqxQ6UqmpFken9ymABSzF7F9So7kLet3mDRwpB2NWzZHCnRqEWn37iscikBjOYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A5EToV/Q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so42923605e9.2
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 15:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770592475; x=1771197275; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zaHzzkhc5pWYm5X+GGTIxlWPKBv6YQdSCiCMi9qdqfA=;
        b=A5EToV/QfHcYalLE3K4OHLuYxUn1bpI8vsSyo0mfBeIWVmtWS41Ubue/HciGkGrMD+
         g1P4+tho7s42kfJV68B1FjkoJPzA1lTKktAEYtXEJEuI/u6LmILwizRWwUqP4nb5aszG
         F3LoYaQfPyVZo+Ipg3yrXlthiXFMZDuhnVX4QCHeSEWjmFSdWo4gZIxSg/ByO/L8lgkx
         kvOkwwAlZ4aVz4nfkDfi5LGx2Ty0wNC6FVjAGQmY2/hbo6XpeDKKeEOAI2XFsoYIBkub
         1dPBeA5LaCrqDWL7U+DRjdHJI1CELcKFjY0iH98XtUGtl8gPUQGtjMhZ0BOcLgKredvN
         W+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592475; x=1771197275;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zaHzzkhc5pWYm5X+GGTIxlWPKBv6YQdSCiCMi9qdqfA=;
        b=OPZa/FdhurBglBt0q3XHA5gjICNNupUM4DZwVnk9iD5cCJeHad/tXQ5TLch8Bo/cWg
         ghXA/nwb5mMMPTcgc6nfJqnfR6FVSGHgagRth+EMQGUu/lHI/yA7tuIEMSTwMuj5Jy3f
         wUFGeev4ECpybRnNA6F836hnGsFVNQy0FiNZGoy/SKAgyd7lUY46ZnC9f+/cplPS3wj7
         hByh8iv2CgllR0GJ+N40e4N7QyZ7Te4kmF9XgzhhWhG1aUgrIyEHS26Hn5qFhJoDe7bU
         VWBqpcw923+0akM7SHj35DWxFnob9y8Xqovm2m1R7IFvGu36f7s5ahR24oKnkWKG0GOy
         N9lw==
X-Gm-Message-State: AOJu0Yx06NbgOP/vZMg3KH2yWTDd4chXpIj2HcTll9IlVkp9ccluIrrl
	a5l9Y3tCqF8PF7fTNdXBDePa8VCReUpTaoYTAhcyUBS3ogJawO4tWFGu3DoTXcyBszFM8KP9Kbh
	vog3m1iU=
X-Gm-Gg: AZuq6aI9flbb49SBqS7uRur86wrqqtUe1Rmh9dZAVdDHEbtT0NvzYpF6Z+Fa2NFjQHO
	uF665+DTwDVqLFNk6oc3xeqctjTIrd/B1K8/9iAuIiXCTW91MRuNwgB6030cCiWQGK92aj4xrFV
	dugz3gZ+hAG0L+ghd1GOZDN6VjvJ8oEBXRvfyQ7QcZ7jWsUM5TilJTaRACDnPKYIbSYiLh9lCh+
	sdhsp2vpIG6TDe+2CYwQulJRiBMWlKe7HdNlrTCkLzPiYiEbwFvePAys/UZAQiwLqrBqFfm8b3x
	kvlPIz03YVHo9Hut21pUsVEgkfgRpM66Us5MRvh9j7M0QIYLHSADPQNF7HIBKQ/OUmy02NVGbj6
	U4LuV0383oQqEOy6bkmELa010EcprFmSf9Evj3w+zY7HaDEx5YN+YvUsET5TRGrUy4qAKoAWHPb
	V3u5WDWKQdVBAIxvJPKRBdOD/0hBtIv+j49DienrA=
X-Received: by 2002:a05:600c:3590:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-48320236b01mr145929895e9.30.1770592474924;
        Sun, 08 Feb 2026 15:14:34 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521ec5e8sm89457995ad.76.2026.02.08.15.14.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 15:14:34 -0800 (PST)
Message-ID: <0910960a-6ad7-4cc5-b565-b4e3f1d66d86@suse.com>
Date: Mon, 9 Feb 2026 09:44:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: reject single block sized compression early
To: Chris Mason <clm@meta.com>
Cc: linux-btrfs@vger.kernel.org
References: <89c6eb7756051dbe2e63693b5051394b16a9080b.1767667652.git.wqu@suse.com>
 <20260208183840.975975-1-clm@meta.com>
 <4cb38f95-6e02-42e5-9325-a5b4bd93d381@suse.com>
 <4d6de31c-7c26-4cda-ad11-a8418fb6d066@meta.com>
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
In-Reply-To: <4d6de31c-7c26-4cda-ad11-a8418fb6d066@meta.com>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21511-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93D5310A954
X-Rspamd-Action: no action



在 2026/2/9 07:49, Chris Mason 写道:
> 
> 
> On 2/8/26 3:54 PM, Qu Wenruo wrote:
>>
>>
>> 在 2026/2/9 05:04, Chris Mason 写道:
>>> Qu Wenruo <wqu@suse.com> wrote:
>>>> Currently for an inode that needs compression, even if there is a delalloc
>>>> range that is single fs block sized and can not be inlined, we will
>>>> still go through the compression path.
>>>>
>>>> Then inside compress_file_range(), we have one extra check to reject
>>>> single block sized range, and fall back to regular uncompressed write.
>>>>
>>>> This rejection is in fact a little too late, we have already allocated
>>>> memory to async_chunk, delayed the submission, just to fallback to the
>>>> same uncompressed write.
>>>>
>>>> Change the behavior to reject such cases earlier at
>>>> inode_need_compress(), so for such single block sized range we won't
>>>> even bother trying to go through compress path.
>>>>
>>>> And since the inline small block check is inside inode_need_compress()
>>>> and compress_file_range() also calls that function, we no longer need a
>>>> dedicate check inside compress_file_range().
>>>>
>>>
>>> Hi everyone,
>>>
>>> I'm running the btrfs for-next branch, along with the encryption patch set
>>> through my AI review prompts:
>>>
>>> https://github.com/masoncl/review-prompts
>>>
>>> I'm working on some btrfs specific instructions, but hopefully these reviews
>>> are already useful.  I've kept the headers to make it easier to double check
>>> that I'm actually replying to the right email, but please let me know if any
>>> parts of this are incorrect:
>>>
>>> commit 59615e2c1f63dfd65f74c166e803873d3362e51a
>>> Author: Qu Wenruo <wqu@suse.com>
>>>
>>> btrfs: reject single block sized compression early
>>>
>>> This commit moves single block size rejection earlier from
>>> compress_file_range() to inode_need_compress() to avoid allocating
>>> async_chunk memory for ranges that will not be compressed anyway.
>>>
>>> Link: https://git.kernel.org/linus/59615e2c1f63dfd65f74c166e803873d3362e51a
>>>
>>>> diff --git fs/btrfs/inode.c fs/btrfs/inode.c
>>>> index 247b373bf5cf0..be47aa58e944e 100644
>>>> --- fs/btrfs/inode.c
>>>> +++ fs/btrfs/inode.c
>>>> @@ -816,6 +816,13 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>>>>    		return 0;
>>>>    	}
>>>>
>>>> +	/*
>>>> +	 * If the delalloc range is only one fs block and can not be inlined,
>>>> +	 * do not even bother try compression, as there will be no space saving
>>>> +	 * and will always fallback to regular write later.
>>>> +	 */
>>>> +	if (start != 0 && end + 1 - start <= fs_info->sectorsize)
>>>> +		return 0;
>>>
>>> Is the early rejection check in inode_need_compress() missing the
>>> 'end + 1 < inode->disk_i_size' condition from the original check?
>>>
>>> The old code in compress_file_range() rejected single-block ranges with:
>>>
>>>       if (total_compressed <= blocksize &&
>>>          (start > 0 || end + 1 < inode->disk_i_size))
>>>           goto cleanup_and_bail_uncompressed;
>>>
>>> The new check only tests 'start != 0' but doesn't check whether the write
>>> reaches EOF. This means a single-block write at offset 0 that doesn't reach
>>> EOF will now go through compression, inline attempt, and ratio checking in
>>> compress_file_range() before being rejected, when the old code rejected it
>>> immediately.
>>
>> I think the change is just fine.
>>
>> The point is, the rejection for that specific case happens at the same
>> timing, inside compress_file_range(), no matter if it's before or after
>> the patch.
>>
>> The patch improves the checks for most single block writes by rejecting
>> them much earlier.
>>
>> But for this particular fileoff 0 single block writes, we just go back
>> to the old timing inside compress_file_range(), aka falling back to the
>> old behavior.
>>
>> So there is no extra lose, just a corner case where it still goes the
>> old path.
> 
> I almost didn't send this one because I do see your point.  But what do
> we lose by moving the original test into the short circuit?  I don't see
> why we'd want to do extra work when start == 0?

That's true, if we know we can not do an inlined compressed write, then 
we shouldn't.

But there is a special corner case where the AI review didn't catch, and 
I believe that's a bigger problem:

If we hit a block sized write at file off 0, but we can not do an 
inlined write (e.g. i_size > one block), the old one will just fallback 
to regular uncompressed writes, without trying compression.

But the newer one will not only fallback (after compression) but also 
mark the inode as incompressible.

That will lead to an incorrect marking of the inode incompressible.

Thus I think the AI is still reaching the correct conclusion, we should 
add back the i_size check.

Thanks,
Qu

> 
> -chris
> 


