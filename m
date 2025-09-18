Return-Path: <linux-btrfs+bounces-16938-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD148B87013
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 23:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A5E97BB9D7
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 21:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138F2EAB60;
	Thu, 18 Sep 2025 21:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Nrdnahh5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D6B188CC9
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758229501; cv=none; b=ZiZE0BlcRjs50EWtyWsV8sOpApPyAShuNG0tFq2B6TxgAupX3vzpEfuZD/+aJQVZP7482TfBwcVCKtGq4jt9Ex4k3D1OB8wEgDuoA1uw05QSjeNmB4wqlrsA+25694JaOgrhaB35NQhUDQ331McbDp/8AErQVzfahuC7lM2ycpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758229501; c=relaxed/simple;
	bh=wVzsNCXCLUib7wbGbYQMg4fNofyBcc46J+gAhzzRfkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1REYfLecVe4upBbPivhMCtjYk5jjniFNaus5YM9hOMxgMLRmEv9NezAI/GTvEtctryv7CuHPaA9TDFRkZTsJcOD/nLsOqmQDEdQvwBJNqiE5xb1BiGfUCDI6RBvsP1kgroPGPUomk+TFSb73D9xE3ugydipH8/A0CmxqegkhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Nrdnahh5; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso13948825e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758229498; x=1758834298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g0TI49DeT+wXRQ+CyOGP8kHaWsUlu4P5GehFDahv3as=;
        b=Nrdnahh5uCeW0gmBmIXF2Df5WprNvB7qgn1viN69t1lgC9sKpfcYd8pXguJruVthOU
         DCEVktpH8s3gyAWuMa+VuAQlBKvbH8hSb/JQWmHPNg4GENiGK0iU6O/ALNCpi332+xJ5
         Z0fTvQnO8Ef1hqdIhaJBIWC86S3nnheqvrpcit+LUrU+ja5+5Ge5sQyMSgjTav2mTzDu
         bvDXyp+PtikIeinFCqkgTwmw/o0s6OH2iLD+v1wekWFHlHdxZKVqGk/7QO18xvbuKhj8
         JGZw9or7tEiSGeeDEdcjyQPoMafZ7NaQ1TfIK48Rxh5/l/2u42lcQcXNiMaXasQeFkbl
         iL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758229498; x=1758834298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0TI49DeT+wXRQ+CyOGP8kHaWsUlu4P5GehFDahv3as=;
        b=ZV3oKGUCWTbcT3MvY7Lo7ukr87J4oPL7k3fzJgaj/D5DEdbrMPUUngzTUKALJhKaHQ
         ml9rnZv7sgrqBt93LUIg0Y15u562dkj0CAXN98sbnjxXDz0C621gS92fEvlnF2UQHmEG
         CdzXuSZllEGORWHvkkQ6GT2jlYnkolfV1jGEnnMREfwy35X8pdapJS/fIx9HtRXPlwZg
         CVi3jTyaaO1uL1HXuw19OmQg4Yg9EznlwQxBgFMrMbUh7g6Be0smFyW0ubT0I92b8YKM
         s2b/9J+C4bE7sEHKioXp2CpoSAj3sdum41PIXdepViyzdpVUe1Z/RO/nFi8CduDPUvli
         aRyQ==
X-Gm-Message-State: AOJu0Yy9y5Cg8VP5wwvPm1kRc8q5HNZKjUSrkrBU9KA/TNmgssE3t80Y
	OlpgS0DI5Hi9wg/5euKa9fNP45LpwvBnMdNbooSVULN/yKqTEtNj9QV5lDWhnm9UeXk=
X-Gm-Gg: ASbGncugm8PdhIOa3ut2NHBNJnXUJ9vRUDMkhjj2M8C8+cVqAnz/c2cWqJlrFObBII+
	Jbs6/pR60uolzOngAPkRs8c4xCG2ZsXasF/oa2dc9cL7jbeAo7S3W63iNHz7Oem8taFTWghHd0Z
	sxuY/UEoQjWDcFqlKcv+qSuwnM2yD9OsfFgB5nTl2eT9DxumMN3QV894mOEvyMBbUDWke5VX2wL
	ayLdVjigEsmRp5hdl6xpB7Smmt4R5Vomnpj+mlRIH+lXUb2rxluJ2Xix/y56Zs6Gx6XhFl8Xowz
	fTzQ8HS92S0UWQKm8Bugg5/fyQcGQIrN7Fa3dvzxPiAYJf9c0jVi3YU1ZcronJtp480KzEMTNTd
	/CMKqLMn9tVynNWZ8eKPIlYvX8dF05BCv51fAhRF1D96pJ0tFr9ykPmV6So7EHge2WhVw9Pw69+
	Nxi+P4
X-Google-Smtp-Source: AGHT+IGsVRZ8PP+c8sC9uqJViIFIIagX8YwwXOoEaFa8p/9MB+iCg9q2hTvcHwgySOHwx7px0ZQ7kA==
X-Received: by 2002:a05:6000:1862:b0:3ec:df2b:14ff with SMTP id ffacd0b85a97d-3ee841718cfmr494479f8f.40.1758229497449;
        Thu, 18 Sep 2025 14:04:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e2ebf04b1sm673917b3a.49.2025.09.18.14.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 14:04:56 -0700 (PDT)
Message-ID: <5fc97562-988e-48f3-89ee-4157a0314ff3@suse.com>
Date: Fri, 19 Sep 2025 06:34:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs: reject fs block size larger than 4K
To: Zorro Lang <zlang@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250918103226.99091-1-wqu@suse.com>
 <20250918161542.a432gwgfzzbxz4rc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250918161542.a432gwgfzzbxz4rc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/19 01:45, Zorro Lang 写道:
> On Thu, Sep 18, 2025 at 08:02:26PM +0930, Qu Wenruo wrote:
>> [BUG]
>> When running the experimental block size > page support, the test case
>> btrfs/192 fails with the following error:
>>
>> FSTYP         -- btrfs
>> PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
>> MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
>> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>
>> btrfs/192 436s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//btrfs/192.out.bad)
>>      --- tests/btrfs/192.out	2022-05-11 11:25:30.746666664 +0930
>>      +++ /home/adam/xfstests/results//btrfs/192.out.bad	2025-09-18 18:34:10.511152624 +0930
>>      @@ -1,2 +1,2 @@
>>       QA output created by 192
>>      -Silence is golden
>>      +ERROR: illegal nodesize 4096 (smaller than 8192)
>>      ...
>>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/192.out /home/adam/xfstests/results//btrfs/192.out.bad'  to see the entire diff)
>>
>> Please note that, btrfs bs > ps is still under development.
>> This is only an early run to expose false alerts.
>>
>> [CAUSE]
>> The test case explicitly requires 4K nodesize to bump up tree size.
>>
>> However if we use fs block size larger than 4K, the node size 4K will be
>> smaller than a block, causing mkfs failure, as block size is the minimal
>> unit for both data and metadata, thus node size smaller than block size
>> is illege.
>>
>> [FIX]
>> Before calling mkfs on the log-writes dm device, do a simple mkfs and
>> mount of the scratch device, to verify the block size.
>>
>> If the block size is larger than 4k, skip the test case.
>>
>> And since we're here, remove the out-of-date page size check, as btrfs
>> has subpage block size support for a while.
>> Instead use a more accurate supported sector size check.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Add the commit message on why we can remove the page size check
>>
>> - Use _scratch_btrfs_sectorsize() so we do not need to mount/unmount
>>    scratch device
>>
>> - Add the missing _require_btrfs_support_sectorsize call
>> ---
> 
> Hi Qu,
> 
> As this patch only changes btrfs/192, so the subject is better to be
> "btrfs/192: ....", due to "btrfs: ..." makes me think it changes lots
> of btrfs cases, or it's a new btrfs case :)
> 
> Thanks for you fix many issues about "btrfs 4k sector and block size",

BTW, the term "sector size" is a btrfs specific terminology, it is the 
same meaning of "block size" of all the other filesystems.

And this has caused confusion in the past, so I'm trying to spread the 
usage of "block size" to align us to other filesystems.

But since the mkfs option is still --sectorsize, and dump-super is still 
using "sectorsize", the confusion is still here.

On the long run we're going to replace sector size with block size, but 
it's not going to happen in one day.
(I tried a huge patch to do all the rename, but it's not merged).

> I saw you keep sending more patches about that, I think you're working
> on this thing recently. Could you please put this patch and others
> "btrfs/304~306" patches or more if you have in one patcheset. Then I'll
> know you've done all you want, and I can merge them together :)

All my bad, I just started fixing the failures one by one, and until 
reached btrfs/305 I noticed the pattern.

I'll group them into one patchset. And for closely related test case 
like btrfs/30[456], I'll merge them into one, as they share the same fix.

Sorry for the email bombarding.

Thanks,
Qu
> 
> Thanks,
> Zorro
> 
> 
> 
>>   tests/btrfs/192 | 11 ++++++++---
>>   1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/tests/btrfs/192 b/tests/btrfs/192
>> index 0a8ab2c1..a9a43cfe 100755
>> --- a/tests/btrfs/192
>> +++ b/tests/btrfs/192
>> @@ -33,10 +33,15 @@ _require_btrfs_mkfs_feature "no-holes"
>>   _require_log_writes
>>   _require_scratch
>>   _require_attrs
>> +_require_btrfs_support_sectorsize 4096
>>   
>> -# We require a 4K nodesize to ensure the test isn't too slow
>> -if [ $(_get_page_size) -ne 4096 ]; then
>> -	_notrun "This test doesn't support non-4K page size yet"
>> +_scratch_mkfs > /dev/null
>> +blksz=$(_scratch_btrfs_sectorsize $SCRATCH_MNT)
>> +
>> +# We need 4K nodesize, and if block size is larger than that mkfs will
>> +# fail. So reject any block size larger than 4K.
>> +if [ $blksz -gt 4096 ]; then
>> +	_notrun "This test requires block size 4096, has $blksz"
>>   fi
>>   
>>   runtime=30
>> -- 
>> 2.51.0
>>
>>
> 


