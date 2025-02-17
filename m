Return-Path: <linux-btrfs+bounces-11522-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74705A38FB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2025 00:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 736E23A9F79
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Feb 2025 23:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BE41ACECF;
	Mon, 17 Feb 2025 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aDL7M1Ry"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 642651A8404
	for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 23:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835679; cv=none; b=PWXFmxjJZQP0OzhXLLU28cKL5HCFqiAc5cpZSOkxh57YU2YXu8FAGhlrlxAKVhetB2rkCTR+ZZ5ZcQ+PvLJ7KEwBWQYoVwyiObordpGv/bLqLCbYxfWxAdDEdf4+xHcagwDd692wI12wohqYpPCHX+W8yQCleXZrXcIpDgUl+IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835679; c=relaxed/simple;
	bh=V0HmODxwWwlZUfmDwOkXc/01vkCKmib3TrlGkIkVO5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O0kPiROmW7HaAuu6KCT11Zmc73C8HLX3Pyl0v6DdKGC5jOpz+P1UalPOhtz+yYMvDa+3ceSEincnC5E+3WgWwU78u13LJiwzpY3rmp0f3O45yE94otC42/Y0r6CQBGeWx1HcoXAH0tagTQ3rZrI2v260OAIvzX/z3hrUnAikdXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aDL7M1Ry; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso3041111f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Feb 2025 15:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739835674; x=1740440474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VHsYQN79tMUjo2dnHtGTMn2RWuCVV8yaRGTyKrMI2a0=;
        b=aDL7M1RyFfMMAiciYzfIZHena75fWp+20b3QY9NvZ/comsN8SUjS2NIlB+qRH1MdLP
         M422rW8iuqZI9HZ0huoqWuLsyD2MnWAcQrrZauqpmqzVc/x3uqGqoYErdTbpEg7uqV2w
         1lxu+iuWvlSagarn7QcfnO8atQkicZE0olaCzfxcZtyF+LnkkeJlWm5pmI0iZY2BA4z9
         wuGeyUi/gWas4jOOF/caUj3108SCvSjwH265OWfct624zEiL8QQqtehEJX30Et/nbTbW
         53QbeEG+zOxawiY3iU7GePQWNmK5hnyzbSlNjvO9DFr5Yr9poHjPle6z/kAUTRDF7cZR
         ClIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739835674; x=1740440474;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VHsYQN79tMUjo2dnHtGTMn2RWuCVV8yaRGTyKrMI2a0=;
        b=BgMOoXhd/NtB6J8avF4ullIso59HkpC4qGtlrBZRYRkBazpdPoYefEjfTClbLPRWlJ
         yBbQSVCnjYtepTCEtn7VVbqoo7z6iCKWmJV7GVg3nPkwHHlf183LTu5cmESCyXqY/F+p
         WrJeVp0VHKXtxCYPIY+gaxBYHKQH8D0ODcRZ6Ti2KKG491/THZE+aQ4CT0YRZAOARUAk
         PZDJ4YkrFtDHtVdlXt2OeTJvsvrtRL5QeEDZPVsy2OpiSMIJgBVsaiZfTvwa1f1rDm/Q
         +kXMIQfnDuo68lnrwMso0AL8QI280C6lXonCCm85zbsJ3fvepcULrduj7kbff1A/hZJU
         iLYg==
X-Forwarded-Encrypted: i=1; AJvYcCV9QmucIaGyZCFsGazPyL5FJvPxZ+fc4D4UJ7tFC3G6wAUZOvV8soPrTd2QCDs8g8PhTJ+bWkEEXSq7JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpJYgVHQlreuMhyGdTchTfO/gyqddAyqip/1ODd5OpCFqguUL
	6IMEA0aHhwiciVXeCSGdAYnAQGhcvsJ1ksq+TKDgVTx162J2XAx8vEO2D11Ax+g=
X-Gm-Gg: ASbGnctjOuzigx2NqXJdunplZ+8dZBvS8WK1EgsIBaVIElsGk0nWHl5t48K6HPYbde/
	Z10dC3uGlpnf58CAov/B2bFo073HXNcyr66tKDxlbA+8Be6MwHn0rCF9/1PwP9xdNa9GQRhDACb
	94nOI3wBn1LO28QNrYXXCFCm4vTT3tHZ5Fah/OAppDCYCaBQ9c5L9gvWwFjMkLUjUds71PX8OXE
	cKpZLYJM5r4oTmboWKPPcFHMNGq5GsWbZEA4tMWda7f3RX35eh6tC/434XIt+F1lNiz1XvKPz2T
	IgbQrXhNdleaP721TvZzL0qSuyrwFFjiCY0Cjnt83yA=
X-Google-Smtp-Source: AGHT+IHvCR+jxv3FxA/yRCOWCYAF4CxrbFfdTaBrM+fAkVOyH/KQWpn9VXBk7y3HbgB1/RgxobXT6Q==
X-Received: by 2002:a5d:64ad:0:b0:38d:d299:709f with SMTP id ffacd0b85a97d-38f33f4e5e9mr13503188f8f.48.1739835674158;
        Mon, 17 Feb 2025 15:41:14 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c9fbsm77549725ad.119.2025.02.17.15.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 15:41:13 -0800 (PST)
Message-ID: <61bd54ff-3547-45a8-99b9-2c849e94666a@suse.com>
Date: Tue, 18 Feb 2025 10:11:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: docs: add an extra note to btrfs data
 checksum and directIO
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <90a1ea4049bbf6d80163aa8116af722280c5d70c.1739771926.git.wqu@suse.com>
 <7f9a3bec-5ce5-4f09-8936-01ca08c2b600@oracle.com>
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
In-Reply-To: <7f9a3bec-5ce5-4f09-8936-01ca08c2b600@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/18 09:53, Anand Jain 写道:
> On 17/2/25 13:58, Qu Wenruo wrote:
>> In v6.14 kernel release, btrfs will force a direct IO to fall back to
>> a buffered one if the inode requires a data checksum.
>>
>> This will cause a small performance drop, to solve the false data
>> checksum mismatch problem caused by direct IOs.
>>
>> Although such a change is small to most end users, for those requiring
>> such a zero-copy direct IO this will be a behavior change, and this
>> requires a proper documentation update.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Grammar fixes sugguested by Johannes
>> ---
>>   Documentation/ch-checksumming.rst | 18 ++++++++++++++++++
>>   1 file changed, 18 insertions(+)
>>
>> diff --git a/Documentation/ch-checksumming.rst b/Documentation/ch- 
>> checksumming.rst
>> index 5e47a6bfb492..b7fde46fe902 100644
>> --- a/Documentation/ch-checksumming.rst
>> +++ b/Documentation/ch-checksumming.rst
>> @@ -3,6 +3,24 @@ writing and verified after reading the blocks from 
>> devices. The whole metadata
>>   block has an inline checksum stored in the b-tree node header. Each 
>> data block
>>   has a detached checksum stored in the checksum tree.
>> +.. note::
>> +   Since a data checksum is calculated just before submitting to the 
>> block
>> +   device, btrfs has a strong requirement that the coresponding data 
>> block must
>> +   not be modified until the writeback is finished.
>> +
>> +   This requirement is met for a buffered write as btrfs has the full 
>> control on
>> +   its page caches, but a direct write (``O_DIRECT``) bypasses page 
>> caches, and
>> +   btrfs can not control the direct IO buffer (as it can be in user 
>> space memory),
>> +   thus it's possible that a user space program modifies its direct 
>> write buffer
>> +   before the buffer is fully written back, and this can lead to a 
>> data checksum mismatch.
>> +
> 
>> +   To avoid such a checksum mismatch, since v6.14 btrfs will force a 
>> direct
>> +   write to fall back to a buffered one, if the inode requires a data 
>> checksum.
>> +   This will bring a small performance penalty, and if the end user 
>> requires true
>> +   zero-copy direct writes, they should set the ``NODATASUM`` flag 
>> for the inode
>> +   and make sure the direct IO buffer is fully aligned to btrfs block 
>> size.
> 
> This section covers how the bug was fixed in v6.14, but that makes
> you wonder—what about earlier versions? It’d be helpful to add a
> paragraph on that.

I'm planning on update this part when the backport lands in 
corresponding backport branches.

But since the patch is not yet even upstreamed, I do not mention it for now.

Thanks,
Qu

> 
> Thx.
> 
> 
>> +
>> +
>>   There are several checksum algorithms supported. The default and 
>> backward
>>   compatible algorithm is *crc32c*. Since kernel 5.5 there are three 
>> more with different
>>   characteristics and trade-offs regarding speed and strength. The 
>> following list
> 


