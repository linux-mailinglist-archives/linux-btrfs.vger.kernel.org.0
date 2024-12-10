Return-Path: <linux-btrfs+bounces-10189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1209EAA0E
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 08:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7F81888A16
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Dec 2024 07:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AB322B8D3;
	Tue, 10 Dec 2024 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OLmBSj+S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F9233123
	for <linux-btrfs@vger.kernel.org>; Tue, 10 Dec 2024 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733817259; cv=none; b=qLcO6sW0Q+oW1jYv8NGJGuVIul59VHwKk5gbHHQhIRBR/SX/7KwejJhdt/5AQECqcvhcK7z1U2jPXEzZw4gjBC1C+b6QKrSM+J03KGL6ztgd0ye5k4HN/dyxaGZMTw0GD411YLfz0ucVU/Wrzjqk/P7lWHtwMsHXR3KuchGpuik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733817259; c=relaxed/simple;
	bh=ArwDI1PnLh7FfSmBa215DPlSVQmc2AL+MLPAQGqV2So=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JAE/AzzpYx+m7IaDX1Jb304eTNuQ4mVqD0v98u5fYOu1ffP5Qa4Y791MywgeLlo5EWi8OlSZbc70F0TD6jI+3ZlgVcQeXiJi43ywhjGVARMHZHavyp++rvpRW6bhuoSyftfg1EvSZGxh5TdD1pVG39DLOPGzWC9uXUok80OmEDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OLmBSj+S; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434f4ccddbdso22494595e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 09 Dec 2024 23:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733817254; x=1734422054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DM0M5MjUbE+KFRbGhO1ZWhKqlvt7SXRC7xp7ZBHzFYg=;
        b=OLmBSj+ShKt6JtLlVxQd+owYtFOql8PET9nqGp3dkYIovtiGWQZHzqA0tru0SXDDeF
         RzYqlDAdJpGC5SRWn//WkvLVxkDriEgVbZeNwYWRmObYwS3DEytiXliwLnUUrE6CBYwF
         mX9t3CFuui+9rCzZlMJm7awT9exg4MYN97dcpY4a35gK10q82JuCob1jneUmsXROxQZo
         UbzLLQCxjHAHdOYOqjkvdCoE+M7Qzbwf8UtpYjvvXp9jukN03i+RvOFvIyrR6MH9nSfm
         3wGWpw+L7M+xsbXNy/wQ4ipyS2AssSXxUVLkRBDjcjG4MGIehmTqIofc2Sihefl+Frqp
         KM3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733817254; x=1734422054;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DM0M5MjUbE+KFRbGhO1ZWhKqlvt7SXRC7xp7ZBHzFYg=;
        b=TbAcgyNuf1QRV+YLLNDM6CYewrDrZhf+G9TmMOqpLuQ56XoJwUaxvBvKkpIsuXHh7Q
         EGS/ATaGZKhNmzUYP5wkLQggdA4HZEoUNg8+0Gdvug+UAgqYRRhTDv0OBjS9WWjA9aRv
         1cTxS9dNPUQlgrRBSniLTZT1JRkJqpcLGnLCcMVYNEFyPwnlVaGrWm2RKHY1YpayI9TQ
         hQHMHUkqwQNS0k2GOd692oSy1s8KTSRujjZ1QEsXFS9aVAQDtDzeiDeK4yVFz624pDW8
         yK8nSLVow9GWXRb/WC7APZtvb+21e1XPwA9OaqLxDiO5n8nLxB/z6d2MeBbH0XKLH4hB
         Ptcg==
X-Forwarded-Encrypted: i=1; AJvYcCVUez+MP2WKF+HRm5txslWoNPyFb4R7OrdeIGgw1gPGujymhENj83/qUH+gD88Ml+5hGOOs75yYh4kc6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzP0MtReyiafll397MTlEcTamKkgh4rzmsuEXBud+CW+b8lOw9n
	HKXSxL3yDC7BNmrXzVLOfE9R1+k2ZEKqJNaapyMfZXiBWmFwEoSf8zOr4sMdb8BcsmturUNgF3E
	v
X-Gm-Gg: ASbGncuWCt/4Mo9kwAt7Ir9WWUym7dncGGwVn/amYxKAE23KdyzJZoOt1t4kXwWksK1
	6fXymk1TD4BRbFIpOVpF0qr8giiNnJ3GkJ50dSys0wp3mFh5fnEjLT5u8YodoD0ySri3fwCGhfI
	DmYrW533YYOcdRJ3T/unuIhXwE6uFnA0Tv2cvMoxC6UNcZsK7Vg8r9fb4qWJVTr938IzrwHKXk9
	rx+ryFhzpN9els1a07vV5ZpEEl0iikp+Y1U+8nz/3erBpikj5z1t357bZzuBvYo0TDMSQJPC0b/
	WresVw==
X-Google-Smtp-Source: AGHT+IHuSkzcYGZhUYU4u9/X+MFaXzWSasicOlfN5m/Fxq5ATIfABiWjJnxkv91mfYluUrIjxJEVcA==
X-Received: by 2002:a5d:6d84:0:b0:385:e3c1:50d5 with SMTP id ffacd0b85a97d-3862b3e6088mr13263878f8f.48.1733817253511;
        Mon, 09 Dec 2024 23:54:13 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd4b961f1asm3272228a12.30.2024.12.09.23.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 23:54:12 -0800 (PST)
Message-ID: <d737ead8-dccc-4a52-8166-08c5cc2c8dca@suse.com>
Date: Tue, 10 Dec 2024 18:24:09 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Safety of raid1 vs raid10
To: Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <a7f1781b-6ae8-4e71-ba00-6c1c11c4901d@scoopta.email>
 <74c8536a-3108-4e6c-941a-5d7b9c697862@suse.com>
 <67fe97da-be53-4dc3-8537-1a39ff49503c@scoopta.email>
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
In-Reply-To: <67fe97da-be53-4dc3-8537-1a39ff49503c@scoopta.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/10 17:06, Scoopta 写道:
> Yeah, that makes a lot of sense. Given what I know about btrfs it seemed 
> very unlikely it would pair up drives consistently. This actually gives 
> me an interesting side question. With raid1, which is not striped, is 
> there any guarantee that a file will be placed contiguously on a given 
> drive or is the only guarantee for chunks while files over 1GiB, and 
> therefore occupying more than one chunk, could be spread across multiple 
> drives so long as each chunk is mirrored?

For a file, there is no guarantee at all that it will be placed on a 
given drive.

As you mentioned, a file can exist on multiple chunks, thus it can be 
spread across different devices.

And the guarantee is, as long as all the file extents are all on raid1 
chunks, all of these file extents will have two copies on different devices.



And to be more accurate, a file is consisted of zero or more file extents.
The file extent size can vary, from the block size (usually 4K for 
btrfs, and we normally call it sector size), to as large as 128M 
(non-compressed extent) or 128K (compressed one).

And the extent size is determined by various factors, from the free 
space of the fs, to the write pattern (worst case like checker board 
writes, 4K write then 4K hole, will definitely result 4K sized extents).

So even for a file smaller than chunk size, it can have multiple file 
extents on different chunks.

Thus there isn't really any guarantee on how a file is stored where, due 
to all the layers involved:

   file -> file extents -> chunks


And I forgot a corner case, inlined file extents, which is fully stored 
inside a tree block, can have a different profile than the data profile 
completely.

That's why we have fiemap ioctl, to show the file extents layout (inside 
btrfs logical address space), then only with the chunk layout (btrfs ins 
dump-tree or btrfs-map-logical) info, one can really determine where the 
data is.

And if you want to dig this deep, welcome to the rabbit whole of how to 
read a file on btrfs, and there is also a small project explaining the 
whole process: https://github.com/adam900710/btrfs-fuse

Thanks,
Qu

> 
> On 12/9/24 8:36 PM, Qu Wenruo wrote:
>>
>>
>> 在 2024/12/10 12:56, Scoopta 写道:
>>> I've read online that btrfs raid10 is theoretically safer than raid1 
>>> because raid10 groups drives together into mirrored pairs making the 
>>> filesystem more likely to successfully survive a multi-drive failure 
>>> event.
>>
>> It's only theoretically possible, but hardly possible in the real world.
>>
>>
>> For one single RAID10 chunk, btrfs can tolerant as many as half of the 
>> devices being missing, as long as each sub stripe (the RAID1 pair) has 
>> one device standing.
>>
>> E.g. for chunk at bytenr X, we have 4 stripes:
>>
>>  stripe 0 devid 1 physical X1
>>  stripe 1 devid 2 physical X2
>>  stripe 2 devid 3 physical X3
>>  stripe 3 devid 4 physical X4
>>
>> We can have either devid 1+3 or devid 2+4 missing, and btrfs is 
>> totally fine with that chunk.
>>
>> But the real problem is, one btrfs has more than 3 chunks, and 
>> normally one chunk is only 1GiB in size, so for a btrfs with 1TiB used 
>> space, it will have at least 1024 chunks.
>>
>> Good luck all the chunks have the same stripe layout.
>>
>> If there is another chunk at bytenr Y, also 4 stripes but a different 
>> layout:
>>
>>  stripe 0 devid 1 physical Y1
>>  stripe 1 devid 3 physical Y2
>>  stripe 2 devid 2 physical Y3
>>  stripe 3 devid 4 physical Y4
>>
>> Then the devid 1+3 missing is fine for chunk X, but not for chunk Y.
>>
>> In really, the chunk layout is never ensured, and I just did the same 
>> RAID10 assumption in my btrfs-fuse project, until it failed selftest 
>> (missing two devices for a RAID10 btrfs) on a recent kernel, exactly 
>> due to the device rotation.
>>
>> Thanks,
>> Qu
>>
>>> I can't find any documentation that says this to be the case. Is it 
>>> true that btrfs pairs drives together for raid10 but not raid1, if 
>>> this is the case what's the reasoning for it?


