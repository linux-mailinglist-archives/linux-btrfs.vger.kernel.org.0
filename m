Return-Path: <linux-btrfs+bounces-16000-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C2FB21802
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Aug 2025 00:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089097A20F5
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Aug 2025 22:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A785F2E2856;
	Mon, 11 Aug 2025 22:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EDmXTefE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2B2D47F3
	for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950459; cv=none; b=WO/Hs4I+lkrIF2/mmrt9RCAD7ghiD98GcrjaU5p2KXtb5DGY10Xyrdt7odZgt6peXrSPapHNZkfGDiemOSdKD+jWzcZOmennOhfEvV1Bj/sPA5AEYeay0S+UohIEbyV3m1Hbt8b6jbRx42V0Bc+TGlLH22sei6hUwiXauNaYOXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950459; c=relaxed/simple;
	bh=esWlmt9famZe00ef95muzVKF2UFlfNU0ydBp971fb58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lgJIoJGlKfW7gg1eKSpgexQeKKOGKDkgKviImREERYBHO/G/qDrxbTvwXAcf3S+8F+snfohR8ijNVYfeKFkJC16wV4wWtHoBKgsN/j14DKnN7if//H1q9E3Gstkw60t4c7J1n0DeVz2DSl8HwengNO3BOOszUSjI4SV4B4AAeYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EDmXTefE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b7825e2775so4330544f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Aug 2025 15:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754950454; x=1755555254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=StXsv7n9ycDoKUvCDAMzA/5f9WpekoxbNKKgKKyZkTE=;
        b=EDmXTefEvRAF29L4XUlvJeKSvtTaq20Q9BrtrH0gfREbc9o2pG5Z+Asglx3ZBT8Us3
         woYs7erdxhNXjEd6rbmFsHj9mm9986LxSJ8PTOVS6khx2R8wAeysCIqC/ciEsMqT3qpI
         8kQOHsja9p65JJqOCShkid2MJ95lmdOo7AGUffM33diC+iUmuFqaHdbdRH78tC5k1pZd
         i82mP82wsZXv3u6mBk0mlK7J9n8tGKnLNohP/C6AtSDIFD5apLK1l06lkHGnQA3ZWI7v
         sDA9Tj8z/PfSPeT0AyX/FfulotxibX10vOYYaKTZiDriM8YAkSWaG+wub+r0nZiNHovW
         N5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950454; x=1755555254;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=StXsv7n9ycDoKUvCDAMzA/5f9WpekoxbNKKgKKyZkTE=;
        b=cs5IosF6Ify+syl9JvPbT5S7361QMZ6RqAwq0NjlpBNabHKCZMEV5/V9I9r76Vq45h
         Hnendhb4tHvQhgq0wXOoOpGo7zK3xQQNIPmyeuZe7I+0p8qFAIL0QW7vXdbEIeIiUwIc
         Dw9g5kSfSMMvkQqv+qpibKOXT46lK/j2ZqKz+rOmgqz91bMFfj8364YDrTLDCF5oCSNX
         NNXCOCm5mQ6dcx+88VQF4LRaOc3qBetHXOlPkEZ0xLHTKEi5tlAqxIJKfDnsyCyv4dSS
         bV5mUIeU+HAPVvs6yEC42maoAT15CY3vdQ1+fSm9KpbkGtYS5ClO7tX/GIWoQQfXzTQB
         Sv/A==
X-Forwarded-Encrypted: i=1; AJvYcCUHsD83UcL39YpNp/y2jjxU1EUCAUJW+wCRi+f81fVunyWmwmKdIxzN18sCmdXwb/VWW3ZaS3ZTvO2JIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz+xn7p3Ijw3c38xMORg2bD05pLf/JfvttC6irv+QzTv8wK/iB
	0ZzQpZ2Ap7p/cOyOAd6CYdJVY7DHo77wFMKMr71RdGoXZAWNTU9Ci7hNICpwLpv3JwA7P+paC9z
	G4lqA8w0=
X-Gm-Gg: ASbGncs7sWxXuyOeNs69SguHVg6h/c3K4x4R7YVmgMn7yCM3n13VcrjjsWv4kUJ2Vd/
	pvYLhh2kdVKagX+hCaA8euJKBNTMpjZiA1dY+MSTZ8q7kpktnguTlR4S5I1hZGdY87YMguqhx57
	eJbvbcdCTbzrRYuEcbSEaPx6Pz0/icz/rSiKvmGRx4Jnhj1DCsAnETCciPB5fSN13KDVI/VMtUh
	mD5ey2ZudomwsiY2RG+9WxpsnAf266uQblIdpxb/aLh5Mrz52OhfT8t7/i4dCfIDXRQ5vLYdWQJ
	wHOAm2XHmFhyLMRhwfwB845h9LJk4zIomLT1L/94aVbMGPi+VLYZqtCVcLihS4F7D8BAnb5wUL4
	pULlha9UHV5Z+v9PltkCqLIKKzzu9nzkjVLOyoWCJIPbUj9+jcQ==
X-Google-Smtp-Source: AGHT+IGSdozthHUW2k0+iswqlCm3CAwaYuPZuTFax2g2J4kvjOKNSIh9iivUtHMpRpDhMHigS8WuEw==
X-Received: by 2002:a05:6000:4284:b0:3b8:d271:cdc5 with SMTP id ffacd0b85a97d-3b911004755mr1090920f8f.34.1754950454370;
        Mon, 11 Aug 2025 15:14:14 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd167sm27862529b3a.78.2025.08.11.15.14.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 15:14:13 -0700 (PDT)
Message-ID: <869c9ca6-2799-4ae0-8490-f383d7e0564b@suse.com>
Date: Tue, 12 Aug 2025 07:44:09 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Ext4 iomap warning during btrfs/136 (yes, it's from btrfs test
 cases)
To: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <9b650a52-9672-4604-a765-bb6be55d1e4a@gmx.com>
 <4ef2476f-50c3-424d-927d-100e305e1f8e@gmx.com>
 <20250808121659.GC778805@mit.edu>
 <035ad34e-fb1e-414f-8d3c-839188cfa387@suse.com>
 <c2a00db8-ed34-49bb-8c01-572381451af3@huaweicloud.com>
 <15a4c437-d276-4503-9e30-4d48f5b7a4ff@gmx.com>
 <20250811154935.GD7942@frogsfrogsfrogs>
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
In-Reply-To: <20250811154935.GD7942@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/12 01:19, Darrick J. Wong 写道:
> On Sun, Aug 10, 2025 at 07:36:48AM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2025/8/9 18:39, Zhang Yi 写道:
>>> On 2025/8/9 6:11, Qu Wenruo wrote:
>>>> 在 2025/8/8 21:46, Theodore Ts'o 写道:
>>>>> On Fri, Aug 08, 2025 at 06:20:56PM +0930, Qu Wenruo wrote:
>>>>>>
>>>>>> 在 2025/8/8 17:22, Qu Wenruo 写道:
>>>>>>> Hi,
>>>>>>>
>>>>>>> [BACKGROUND]
>>>>>>> Recently I'm testing btrfs with 16KiB block size.
>>>>>>>
>>>>>>> Currently btrfs is artificially limiting subpage block size to 4K.
>>>>>>> But there is a simple patch to change it to support all block sizes <=
>>>>>>> page size in my branch:
>>>>>>>
>>>>>>> https://github.com/adam900710/linux/tree/larger_bs_support
>>>>>>>
>>>>>>> [IOMAP WARNING]
>>>>>>> And I'm running into a very weird kernel warning at btrfs/136, with 16K
>>>>>>> block size and 64K page size.
>>>>>>>
>>>>>>> The problem is, the problem happens with ext3 (using ext4 modeule) with
>>>>>>> 16K block size, and no btrfs is involved yet.
>>>>>
>>>>>
>>>>> Thanks for the bug report!  This looks like it's an issue with using
>>>>> indirect block-mapped file with a 16k block size.  I tried your
>>>>> reproducer using a 1k block size on an x86_64 system, which is how I
>>>>> test problem caused by the block size < page size.  It didn't
>>>>> reproduce there, so it looks like it really needs a 16k block size.
>>>>>
>>>>> Can you say something about what system were you running your testing
>>>>> on --- was it an arm64 system, or a powerpc 64 system (the two most
>>>>> common systems with page size > 4k)?  (I assume you're not trying to
>>>>> do this on an Itanic.  :-)   And was the page size 16k or 64k?
>>>>
>>>> The architecture is aarch64, the host board is Rock5B (cheap and fast enough), the test machine is a VM on that board, with ovmf as the UEFI firmware.
>>>>
>>>> The kernel is configured to use 64K page size, the *ext3* system is using 16K block size.
>>>>
>>>> Currently I tried the following combination with 64K page size and ext3, the result looks like the following
>>>>
>>>> - 2K block size
>>>> - 4K block size
>>>>     All fine
>>>>
>>>> - 8K block size
>>>> - 16K block size
>>>>     All the same kernel warning and never ending fsstress
>>>>
>>>> - 32K block size
>>>> - 64K block size
>>>>     All fine
>>>>
>>>> I am surprised as you that, not all subpage block size are having problems, just 2 of the less common combinations failed.
>>>>
>>>> And the most common ones (4K, page size) are all fine.
>>>>
>>>> Finally, if using ext4 not ext3, all combinations above are fine again.
>>>>
>>>> So I ran out of ideas why only 2 block sizes fail here...
>>>>
>>>
>>> This issue is caused by an overflow in the calculation of the hole's
>>> length on the forth-level depth for non-extent inodes. For a file system
>>> with a 4KB block size, the calculation will not overflow. For a 64KB
>>> block size, the queried position will not reach the fourth level, so this
>>> issue only occur on the filesystem with a 8KB and 16KB block size.
>>>
>>> Hi, Wenruo, could you try the following fix?
>>>
>>> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
>>> index 7de327fa7b1c..d45124318200 100644
>>> --- a/fs/ext4/indirect.c
>>> +++ b/fs/ext4/indirect.c
>>> @@ -539,7 +539,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>>>    	int indirect_blks;
>>>    	int blocks_to_boundary = 0;
>>>    	int depth;
>>> -	int count = 0;
>>> +	u64 count = 0;
>>>    	ext4_fsblk_t first_block = 0;
>>>
>>>    	trace_ext4_ind_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
>>> @@ -588,7 +588,7 @@ int ext4_ind_map_blocks(handle_t *handle, struct inode *inode,
>>>    		count++;
>>>    		/* Fill in size of a hole we found */
>>>    		map->m_pblk = 0;
>>> -		map->m_len = min_t(unsigned int, map->m_len, count);
>>> +		map->m_len = umin(map->m_len, count);
>>>    		goto cleanup;
>>>    	}
>>
>> It indeed solves the problem.
>>
>> Tested-by: Qu Wenruo <wqu@suse.com>
> 
> Can we get the relevant chunks of this test turned into a tests/ext4/
> fstest so that the ext4 developers have a regression test that doesn't
> require setting up btrfs, please?

Sure, although I can send out a ext4 specific test case for it, I'm 
definitely not the best one to explain why the problem happens.

Thus I believe Zhang Yi would be the best one to send the test case.



Another thing is, any ext3 run with 16K block size (that's if the system 
supports it) should trigger it with the existing test cases.

The biggest challenge is to get a system supporting 16k bs (aka page 
size >= 16K), so it has a high chance that for most people the new test 
case will mostly be NOTRUN.

Thanks,
Qu

> 
> --D
> 
>> Thanks,
>> Qu
>>
>>> Thanks,
>>> Yi.
>>>
>>
>>


