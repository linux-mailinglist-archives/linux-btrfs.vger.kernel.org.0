Return-Path: <linux-btrfs+bounces-21505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id W8v6IxL4iGmXzwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21505-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:54:42 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F60010A23A
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 21:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BD19130028FA
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 20:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1E6343D8A;
	Sun,  8 Feb 2026 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BhX0x+Bo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BFA324B23
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 20:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770584073; cv=none; b=b0hcp7Z2+jMOfUWJYFC3gPejgYyCtk4MnGjDaSUJyulwjzUVUI3jormZAxIaOvgL+2d0u5njFfeuUZihHE8FDhUwd2vJ5vu98P8R/lAKQ8E3NAN4rK1YFEn06bwVKeMrTTerjQlw9F9pFZAMsFxmCXz5YLqk2ZSOryu5hQHwIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770584073; c=relaxed/simple;
	bh=AWkSO+XNlYQ3TECcDJ5JP+0IvjTCfNNK6YCKmv70s1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OIZHJmcsFXqinr+cB/2acrgeHCy5gAguFETYUwrwsEIG9hKi7W0PAIFfAV0N1c6j6KWibbOJ9pSlDN8N5oDlCLKW1QtVFk2Yl8TmWEQLHe6d94Cgp1ihweigETXNZ4vmLS3ObnLmDBp2/71DlKQJ8UenG9UFtL0RWkRP200a5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BhX0x+Bo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee0291921so21546415e9.3
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 12:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770584071; x=1771188871; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+DKDX0WK6/9LC6H5G3lErHwbcNWp5SjeuUh8oGXcYIg=;
        b=BhX0x+BoCMKywHjmzdYp5EvA/h+p2Xd96byMW73UKNwz+014ddUg8cWHRigz4fjn3/
         FqFGsXYdEYAi4MJKjzzTQ2vfLDvCUyzLDRcNBEDCh/SuMMzQPit7YioygORXE6gxZUIW
         WX5q/EPGSCttlyxDfQiW2e+OecvTCie4tqL1U5lgUskv4GKc6fhOryNbcoNESAXcJl2d
         uF+s/ZSf+sTikGMf9PWpGSwwgCcdgYzux3P+smoX1kg70YnSDBt26sRbwKXFAnA/zNhR
         C4VHqwbQgyJOmZIkfo6vf4dtfjjc9X79eTJFbQEX9dnsgErHqF4E7E0XbaQVdEZSsbY/
         Medg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770584071; x=1771188871;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DKDX0WK6/9LC6H5G3lErHwbcNWp5SjeuUh8oGXcYIg=;
        b=BrC7epA63+Y0QgE8F06jc/E76fDY0M9058ufysNGF6o3Wvcftfhn0GK/JflpyWjC4e
         gl8Zoc/ANlg1ANbp5kWHvSuG4nHOpxF7+0bGIIhlV4giiQptc/x/e8EEIHZzkOs/0zM+
         Ga1Tp0uAwd8Q/e2sVpc6+316UJ0POrExg+aJ0+rbmwLdQQnqIYlKARREI1ti3HPOi2XS
         HYPMoGmDZYjGKe1E0ZdTPDktc6g+irofNVTgvxfYcxnE+EVMWaqz8o0alfA+X8OGLO8l
         m7IV5m0aL5xhJWOLauXNiqGrWMXnwC1wMdpqPLHbtnEqfW5+YSldQVYDrmQlGWWefajQ
         qmdA==
X-Gm-Message-State: AOJu0YxyapGrVAMz5r3UkBtqtZp/bkao1KBKedqUlLMFOOVW5WWYGmBw
	BgqP27p843vVZblVXc9M8KuCKIkLBrAoEqATV9oDhLMpY457O2JeEJGS5Kgo16MKwIQ=
X-Gm-Gg: AZuq6aKX+n454oQjwoTRnKDEIjB8gb/MNk6sDgc7danOxatKI/Ifwlmo4zB5rWCXp7P
	2w4hC6FnTAudwGKyXkA7xdD+OsIodoh58R3i25K2GQwokbWqvx73ycg4t8UHo+5xeQPtMzN92un
	+XpyOXeNLmGhnYnia3HhQE1/rffKWy7usvJkTCgD9pae/OD5rYm8q5JJPyqk4e+LI12r5QEd+0a
	+gUDJrbQJdSFIlTmj+3/yi202YA0fgRbPQZmtWbKxNbFnKY0fVUz0VFIFwn21cfZoYdzi15egt2
	QiYpHk6oF1rwuKv16gU/f27VyYnxCSs3DfC0mPBnDezIrsadr+J8wrTJyKOpLvu6P6n9g3666NA
	hdL+bsWsDEEN02STPFsyJJsLmbTH+/0bAMZRTGAQOYyR5WkzXcpZWGBIXJnXHq19I0zOUK4WItB
	zaq2i7o4NNrCo5j4l5KWf2MfGOtibYwYmRa5VX+TE=
X-Received: by 2002:a05:600c:4506:b0:480:1c53:2085 with SMTP id 5b1f17b1804b1-48320213830mr111659845e9.19.1770584071210;
        Sun, 08 Feb 2026 12:54:31 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb520f1csm7939638a12.9.2026.02.08.12.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Feb 2026 12:54:30 -0800 (PST)
Message-ID: <4cb38f95-6e02-42e5-9325-a5b4bd93d381@suse.com>
Date: Mon, 9 Feb 2026 07:24:26 +1030
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
In-Reply-To: <20260208183840.975975-1-clm@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21505-lists,linux-btrfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wqu@suse.com,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Queue-Id: 8F60010A23A
X-Rspamd-Action: no action



在 2026/2/9 05:04, Chris Mason 写道:
> Qu Wenruo <wqu@suse.com> wrote:
>> Currently for an inode that needs compression, even if there is a delalloc
>> range that is single fs block sized and can not be inlined, we will
>> still go through the compression path.
>>
>> Then inside compress_file_range(), we have one extra check to reject
>> single block sized range, and fall back to regular uncompressed write.
>>
>> This rejection is in fact a little too late, we have already allocated
>> memory to async_chunk, delayed the submission, just to fallback to the
>> same uncompressed write.
>>
>> Change the behavior to reject such cases earlier at
>> inode_need_compress(), so for such single block sized range we won't
>> even bother trying to go through compress path.
>>
>> And since the inline small block check is inside inode_need_compress()
>> and compress_file_range() also calls that function, we no longer need a
>> dedicate check inside compress_file_range().
>>
> 
> Hi everyone,
> 
> I'm running the btrfs for-next branch, along with the encryption patch set
> through my AI review prompts:
> 
> https://github.com/masoncl/review-prompts
> 
> I'm working on some btrfs specific instructions, but hopefully these reviews
> are already useful.  I've kept the headers to make it easier to double check
> that I'm actually replying to the right email, but please let me know if any
> parts of this are incorrect:
> 
> commit 59615e2c1f63dfd65f74c166e803873d3362e51a
> Author: Qu Wenruo <wqu@suse.com>
> 
> btrfs: reject single block sized compression early
> 
> This commit moves single block size rejection earlier from
> compress_file_range() to inode_need_compress() to avoid allocating
> async_chunk memory for ranges that will not be compressed anyway.
> 
> Link: https://git.kernel.org/linus/59615e2c1f63dfd65f74c166e803873d3362e51a
> 
>> diff --git fs/btrfs/inode.c fs/btrfs/inode.c
>> index 247b373bf5cf0..be47aa58e944e 100644
>> --- fs/btrfs/inode.c
>> +++ fs/btrfs/inode.c
>> @@ -816,6 +816,13 @@ static inline int inode_need_compress(struct btrfs_inode *inode, u64 start,
>>   		return 0;
>>   	}
>>
>> +	/*
>> +	 * If the delalloc range is only one fs block and can not be inlined,
>> +	 * do not even bother try compression, as there will be no space saving
>> +	 * and will always fallback to regular write later.
>> +	 */
>> +	if (start != 0 && end + 1 - start <= fs_info->sectorsize)
>> +		return 0;
> 
> Is the early rejection check in inode_need_compress() missing the
> 'end + 1 < inode->disk_i_size' condition from the original check?
> 
> The old code in compress_file_range() rejected single-block ranges with:
> 
>      if (total_compressed <= blocksize &&
>         (start > 0 || end + 1 < inode->disk_i_size))
>          goto cleanup_and_bail_uncompressed;
> 
> The new check only tests 'start != 0' but doesn't check whether the write
> reaches EOF. This means a single-block write at offset 0 that doesn't reach
> EOF will now go through compression, inline attempt, and ratio checking in
> compress_file_range() before being rejected, when the old code rejected it
> immediately.

I think the change is just fine.

The point is, the rejection for that specific case happens at the same 
timing, inside compress_file_range(), no matter if it's before or after 
the patch.

The patch improves the checks for most single block writes by rejecting 
them much earlier.

But for this particular fileoff 0 single block writes, we just go back 
to the old timing inside compress_file_range(), aka falling back to the 
old behavior.

So there is no extra lose, just a corner case where it still goes the 
old path.

Thanks,
Qu

> 
> Doesn't this cause MORE work for the case where start == 0 AND single block
> AND end + 1 < disk_i_size?
> 
>>   	/* Defrag ioctl takes precedence over mount options and properties. */
>>   	if (inode->defrag_compress == BTRFS_DEFRAG_DONT_COMPRESS)
>>   		return 0;
> 
> [ ... ]
> 
>> @@ -953,18 +960,7 @@ static void compress_file_range(struct btrfs_work *work)
>>   	if (actual_end <= start)
>>   		goto cleanup_and_bail_uncompressed;
>>
>> -	total_compressed = actual_end - start;
>> -
>> -	/*
>> -	 * Skip compression for a small file range(<=blocksize) that
>> -	 * isn't an inline extent, since it doesn't save disk space at all.
>> -	 */
>> -	if (total_compressed <= blocksize &&
>> -	   (start > 0 || end + 1 < inode->disk_i_size))
>> -		goto cleanup_and_bail_uncompressed;
>> -
>> -	total_compressed = min_t(unsigned long, total_compressed,
>> -			BTRFS_MAX_UNCOMPRESSED);
>> +	total_compressed = min_t(unsigned long, actual_end - start, BTRFS_MAX_UNCOMPRESSED);
>>   	total_in = 0;
>>   	ret = 0;
> 


