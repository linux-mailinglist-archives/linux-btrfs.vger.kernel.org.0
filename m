Return-Path: <linux-btrfs+bounces-20224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 280E5D010A9
	for <lists+linux-btrfs@lfdr.de>; Thu, 08 Jan 2026 06:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 901A53003FEC
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jan 2026 05:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D376D2D249A;
	Thu,  8 Jan 2026 05:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BSH27jbe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E52C0F7F
	for <linux-btrfs@vger.kernel.org>; Thu,  8 Jan 2026 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767849016; cv=none; b=ePXMxswEsQ4833IUgn/mXw7N6bgWQg+Ib9nP51U50UL8SGL1x7U9ijB6vIapXHlOOJi+KaVGp23ex1AyMDhRI4XLIsCDhYW3PBGSZgaBFDNZXVywt38GOXmJuJNYX2U9hNLpxUt2oEIsOUbS85Jkjk8mBpNp/oVHlUo15bDQl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767849016; c=relaxed/simple;
	bh=TeDhKdX2i1pu0oyLAWXpzETngVWQyWTcsYXI+Aw22PY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nC7OwlKPAkmGcApbmxJfqryRcgCDZgmuEBNFLMI6rseSGtiTHdmdttLlCGTm7vAS/Dp/3U7v5p5BsAvqltMuZHm/ddfdMCYYQNyU/BUF2rCExMPSQV7BzwtnUN4HxmCdo2HPkYgefnZFfwhDEWpk2SpEMZlZNEWGIrlNFkqeZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BSH27jbe; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so25389925e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jan 2026 21:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767849012; x=1768453812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vqAK3sVU6/wnYja1UehMcs3j90V8HvHsu940WgfmUDw=;
        b=BSH27jbeJi0MPz2b65BS+G5nT8DEyBjp3khCMt2Szi6BuKRxPmc+AQz1ioAwMHmIOA
         jp+EfZaQLE6ygrGpGkaNgp7ykxKndASf0J5lamT81e11bL2SiGIuH4m14KkbtYuIrMjB
         PYndHRvgNRL4jCJlzaEppovdrDCiF7d1VXs71sA0bRfy/TUBpvCVxKDmlxFqc8RLrCG5
         UDm9uK2jbNSR4N/4rVE9fMAi5m2I/Z7VQ7rm4VycJy+B4b4uKeI6Mp1ayksamPtfK99j
         Zlhya+pSonXs0uB3YBB1PfASn+m2s8Kv2fGQTpD+L5qP1O70tYwHQorW2evFkn/YvhUm
         69Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767849012; x=1768453812;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqAK3sVU6/wnYja1UehMcs3j90V8HvHsu940WgfmUDw=;
        b=lnXgiNqEFScG0k/xlD4NgAac+VFeE8j2t3V+FFnoEcog0Fx8s8b/iuO4kKhfM2M0hd
         GS6zme3JYmbgPRdsOnd6U/v6cyZUjNKYTfpkfhWmwDX/SO5/JCX0M7WJkRRnyhC/UmyZ
         W9a+jkgORXjtlf0jY/gsYeIQuwPi8q97+Hq6NokshGevIxQM9eYRO40VBbgjtkSEajop
         n1a20OVgfWCgR4pH5uoW4fx+pS2Xqc7Fp4CRiBcM/yjAAteXwCVs6VgO5EUsgHNltXTB
         3uI8rO6HlJCj01q5LQyaWOs+nSNU32jBHjczNEyrRnmiE3SmvWZFqCkKegvNExDDsYIt
         +rgA==
X-Gm-Message-State: AOJu0YxNs2E2vHitMJvIOBCwUQjW8CBePiDKTFtXZgnSP0VYfvQuN7Xk
	Avjp8ZXfKYilJeLl3/NZwUe4DyIwpgqaNEEunfE9iuO8OlFs3blvKvvKGGnn6EyKmbRTgXN3Rrl
	7H5vYuo0=
X-Gm-Gg: AY/fxX77+nxrsKtcXmG55AcpdqNLoyu2bm9k+0gQk/UeIVBUOYs+fX6WYykKPEQQqWg
	2sN2c+2VlY9/oVnZLYfRGEt0QJJ1TiNUUEsse5+pDQWHGq+I/7rJM49hThPEoYNoqtT+VpkrGHG
	i7Bki4hgnMFIC3Rnl06+aqR8NDK6X3xCgtPJXEMSRMEgAC/4mdELIRSKC0XRerGYwGxDCYp8+/I
	Zgb3PGpVpD7Du21pRhRIaHv1zb1mwKe8Sdjg3LOldKGiieUwHcSghbD694b+f9D7ZthOEE6YPHf
	S8KxN3yPsHEvKaE4+Q0PatPNpC6/uFuOiUv9kR/2qbYldf1LtsdXiRFL8vKJ537ZDmL/dcoAV8w
	nWydHl0O2QbZqWq3Of69rxrZy4BZeTeSJZWhH8O1w+yvPY7YtBfd7NTX5ypECXhXu1zdgeL4Lys
	Cdjez92dAkNHLNP6kjnW9kyKbWE+wsBeWgOKiVzg==
X-Google-Smtp-Source: AGHT+IF68HJsw2s5/0ap3KGsa+CwJtSITU0/Gd7r78bT5omJ5xz9Q53BhRq8reNJ3hrVpiDEzck5IA==
X-Received: by 2002:a05:600c:6994:b0:47d:649b:5c48 with SMTP id 5b1f17b1804b1-47d84b540f0mr46973985e9.36.1767849011970;
        Wed, 07 Jan 2026 21:10:11 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f6b9a1881sm1182622a91.13.2026.01.07.21.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 21:10:11 -0800 (PST)
Message-ID: <5ff5f6b0-148a-4b48-a5f9-19215ffa3d36@suse.com>
Date: Thu, 8 Jan 2026 15:40:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: mkfs: use device_discard_blocks() to replace
 prepare_discard_device()
From: Qu Wenruo <wqu@suse.com>
To: Roman Mamedov <rm@romanrm.net>
Cc: linux-btrfs@vger.kernel.org
References: <284c38aeccd4abefa2349d2bab1cefb09e89b5bd.1767847334.git.wqu@suse.com>
 <20260108095120.0d85f706@nvm> <35a26759-cd26-4d1f-9d84-03d13e909f07@suse.com>
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
In-Reply-To: <35a26759-cd26-4d1f-9d84-03d13e909f07@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/1/8 15:24, Qu Wenruo 写道:
> 
> 
> 在 2026/1/8 15:21, Roman Mamedov 写道:
>> On Thu,  8 Jan 2026 15:12:17 +1030
>> Qu Wenruo <wqu@suse.com> wrote:
>>
>>> -static void prepare_discard_device(const char *filename, int fd, u64 
>>> byte_count, unsigned opflags)
>>> -{
>>> -    u64 cur = 0;
>>> -
>>> -    while (cur < byte_count) {
>>> -        /* 1G granularity */
>>> -        u64 chunk_size = (cur == 0) ? SZ_1M : min_t(u64, byte_count 
>>> - cur, SZ_1G);
>>> -        int ret;
>>> -
>>> -        ret = discard_range(fd, cur, chunk_size);
>>> -        if (ret)
>>> -            return;
>>> -        /*
>>> -         * The first range discarded successfully, meaning the 
>>> device supports
>>> -         * discard.
>>> -         */
>>> -        if (opflags & PREP_DEVICE_VERBOSE && cur == 0)
>>> -            printf("Performing full device TRIM %s (%s) ...\n",
>>> -                   filename, pretty_size(byte_count));
>>> -        cur += chunk_size;
>>> -    }
>>> -}
>>> -
>>>   /*
>>>    * Write zeros to the given range [start, start + len)
>>>    */
>>> @@ -293,8 +270,16 @@ int btrfs_prepare_device(int fd, const char 
>>> *file, u64 *byte_count_ret,
>>>           goto err;
>>>       }
>>> -    if (!(opflags & PREP_DEVICE_ZONED) && (opflags & 
>>> PREP_DEVICE_DISCARD))
>>> -        prepare_discard_device(file, fd, byte_count, opflags);
>>> +    if (!(opflags & PREP_DEVICE_ZONED) && (opflags & 
>>> PREP_DEVICE_DISCARD)) {
>>> +        ret = device_discard_blocks(fd, 0, byte_count);
>>> +        if (ret < 0) {
>>> +            errno = -ret;
>>> +            warning("failed to discard device '%s': %m", file);
>>> +        } else {
>>> +            printf("Performing full device TRIM %s (%s) ...\n",
>>> +                   file, pretty_size(byte_count));
>>> +        }
>>> +    }
>>>       ret = btrfs_wipe_existing_sb(fd, zinfo);
>>>       if (ret < 0) {
>>
>> Before: the message is printed after the first successful discard of a 1G
>> range, so with any real-world device at the very beginning of operation.
>>
>> After: the message is printed only after the full device is discarded???
>> And it still implies the operation has just begun and is in progress.
> 
> I'll change the message timing to before the call.

Well, this is a special handling for full device trim, where we don't do 
any special probing on if the device support TRIM.
But based on the first discard try to determine and output needed message.

Either we need a reliable way to do the probe (which is not that simple, 
previously we had some try to use 0 length discard, but it's not 
reliable), thus we changed to use the current way.

So it's not that easy to change without changing the timing of the 
message or the behavior.

Please ignore this patch.

Thanks,
Qu

> 
>>
>> It could take a significant time and it was good to print it in the 
>> beginning
>> to let the user know what is going on.
>>
>> Or I am missing something here?
>>
> 
> 


