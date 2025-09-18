Return-Path: <linux-btrfs+bounces-16929-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8C2B84530
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 13:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C873AE0AD
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Sep 2025 11:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194DA30214E;
	Thu, 18 Sep 2025 11:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XtH9Fu1l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171922DA757
	for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194416; cv=none; b=kDjyPAR0CkeZyy0slFeoxqIoXYhKVsvNZBS5ICggAe9RnHHMQJtJkELIrehD84T8KCXZ1SZGtwcAs2G1/KZ7q/T1h8RU7aYDlYvZHkbMvYjnfs3qFyVDHHnsyrmxSkjw5OE86rydXIquaBso5VO3gGx1Jou50QUVMQhX2Q3Vit8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194416; c=relaxed/simple;
	bh=DvNk/6Tfbe234u7pJoBYWvNrwsGekYd5PhezW27Jq/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uXicFSfIwJzZTOwTl3HIiomZeTjhgzV3LkEEiyAzjEkXT4Zf8Yx5jAw1uS/PlQXcxlSmlHptvB6dIQpwhYP8r+F9r2yDM99AHU4pmYjGDX8wLugbgTblTLmXXA549gOIzzPriKDz4PAqLG7ZAIqEnnkuWmP3JThOcL48Dn6kWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XtH9Fu1l; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3d44d734cabso524183f8f.3
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Sep 2025 04:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758194411; x=1758799211; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sENNlj28H6WAqlpeJFaW44U/oykFV61OE6bayPFhytY=;
        b=XtH9Fu1luq9LfDS53d2+8yRquM59sLMNx6C3uHWCJ2vLZnbNcEtqV+ASEXK2/zenZt
         M30esao+HgrIlZAvVSkMngB4b131JlTR1DVI3agP/GzD2zKVF8NwwtLfF9rHGI6A1grn
         xwnkWzhwbCKcI7H0Kv8alEsdvbVHUleim4JbG/CmqHgG+liYNpPtxVMRu2PZhUpHiahR
         PV9lxDSLZM3dbT05fLBplV8QFOff+6ygNj5jKtIzrVE2ftuuWmLyf47Lmwb+UAm0/HHk
         eZfDPUY4JRAdMpz3mbIbfZQaTe0xXYGJxqRaf1c+rz7CSAilWAnSeCA0eZxsR1uuE13Q
         dKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758194411; x=1758799211;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sENNlj28H6WAqlpeJFaW44U/oykFV61OE6bayPFhytY=;
        b=J1OGbT5nyOOSqNoYrt3PPLEcx9EriIlWaTEA0ul8zYreu/OpfHmXbxYWRqfXf1BcRl
         eEKGi4Ci4gBSt1haclyv1KynAzodFdxR685L53W3GDqda9eE9cWnm6D9IChDUY137L40
         C3/FTFwP3fWmuPDilwGTTQ2f8otONCNTHH2YmomqngI4uJQvhPywfBKmD8VeICawQH93
         vj7q6EY4lacjwxMMffSE7VMfRsrh2YYtiwkbjnc5jry+Zy8FMx2lJaXe46ZGRs6zxBBW
         qDhITSpFkBx1HmuXN9z2yl6pwbTBmIkepe2VCpRg9CZK0hdPZpHhMzzt2/T75vehi6XO
         lb9Q==
X-Gm-Message-State: AOJu0YyirIjUjJj3NvHQmAd48m1pgO/JuBFlioEnKH3TjJbRUBwcvr4i
	7+8Y3VSq2oed6luCFx0Sg0s2DuQVBOPy+GduT0zzc+2vquNM8+r40vsLsUksu0G2Jrw=
X-Gm-Gg: ASbGncvtIUYlbyVSMN1doagzcm+h6G2VSthzCbJ4XTo/SuxFFvDtSa6KeRBqZMBr8ch
	oRMLqblDxFHnY8ktlF4e8LACEDsNcp0s17xOXKOMmGpyZ/Oge9AjM0GgdWGxsUm5vtfPGV0UpZm
	nEfDpEi7u3V3NLQtBTCElB/q4r6SyMj47oPfL9CcygajS9I/0rFWWQVCIcd710jR2qKLANAK3oK
	+dRvPzQBN9IvP2ZxDKrewqRrFAYDQSr58iJi20WkFaT6jmJha3VdL2ka5vRSrRwYtCQeDZEflcJ
	8tfkPMhzTE5fRq0mAvGnQjHZGj6Tu5sFN3byjk8kSWzq8Y2xLJ8c6Ms4b5zlIraJLmcEkNfVWDR
	N0wvrw/zvCZydtBrLtTPodzgLAfHZb2/HVEwbFCdiym9tXkwmquB/0DXvucW5Dd+4dREszQ==
X-Google-Smtp-Source: AGHT+IESPWrlsLTpLEpusTWXutsxWfyDhohP0Vqvoj+NuDj6V3wKtIqPYIGHATlcP5nDl8MIUxAn3A==
X-Received: by 2002:adf:faca:0:b0:3ee:1118:df7d with SMTP id ffacd0b85a97d-3ee1118e2a5mr1381400f8f.47.1758194411232;
        Thu, 18 Sep 2025 04:20:11 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060803335sm2298051a91.24.2025.09.18.04.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 04:20:10 -0700 (PDT)
Message-ID: <64692751-9073-4554-96ac-7cad3db48e88@suse.com>
Date: Thu, 18 Sep 2025 20:50:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] btrfs/305: skip the run if block size is not 4K
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250918105909.102551-1-wqu@suse.com>
 <CAL3q7H6E=pcY12JGvz2Cx=vuDRMprLwptvWtsQ5FevtHpC37xA@mail.gmail.com>
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
In-Reply-To: <CAL3q7H6E=pcY12JGvz2Cx=vuDRMprLwptvWtsQ5FevtHpC37xA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/18 20:47, Filipe Manana 写道:
> On Thu, Sep 18, 2025 at 11:59 AM Qu Wenruo <wqu@suse.com> wrote:
>>
>> [FALSE ALERT]
>> When running btrfs with block size larger than 4K (e.g. 8K in this
>> case), the test case will fail like this:
>>
>> FSTYP         -- btrfs
>> PLATFORM      -- Linux/x86_64 btrfs-vm 6.17.0-rc4-custom+ #287 SMP PREEMPT_DYNAMIC Thu Sep 18 16:42:54 ACST 2025
>> MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
>> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
>>
>> btrfs/305 1s ... - output mismatch (see /home/adam/xfstests/results//btrfs/305.out.bad)
>>      --- tests/btrfs/305.out     2024-07-15 16:17:42.639999997 +0930
>>      +++ /home/adam/xfstests/results//btrfs/305.out.bad  2025-09-18 18:44:14.914196231 +0930
>>      @@ -12,11 +12,9 @@
>>       leaf XXXXXXXXX flags 0x1(WRITTEN) backref revision 1
>>       fs uuid <UUID>
>>       chunk uuid <UUID>
>>      -   item 0 key (XXXXXX RAID_STRIPE 61440) itemoff XXXXX itemsize 16
>>      +   item 0 key (XXXXXX RAID_STRIPE 65536) itemoff XXXXX itemsize 16
>>                          stripe 0 devid 1 physical XXXXXXXXX
>>      -   item 1 key (XXXXXX RAID_STRIPE 4096) itemoff XXXXX itemsize 16
>>      ...
>>      (Run 'diff -u /home/adam/xfstests/tests/btrfs/305.out /home/adam/xfstests/results//btrfs/305.out.bad'  to see the entire diff)
>>
>> In the above case it's the experimental support of block size larger
>> than page size.
>> The feature is still under development.
>>
>> [CAUSE]
>> That test case requires 4K block size, but it has no way to control
>> that, as QA runners can specify MKFS_OPTIONS="-s 8k", to override the
>> default block size.
>>
>> Normally this is impossible as on x86_64 the only supported block size is
>> 4K, already the minimal block size of btrfs. So there is no way to use
>> other block size in that test case.
>>
>> However with the experiemental bs > ps support, even on x86_64 it's
> 
> typo in experimental
> 
>> possible to use 8K block size, and that breaks the 4K block size
>> assumption of the test case.
>>
>> [FIX]
>> Add a quick scratch mkfs, and grab the block size of the resulted fs.
> 
> resulted -> resulting
> 
>> If the block size is not 4K, skip the run.
>>
>> Since we're here, also remove the page size check, since we have subpage
>> block size support for a while, and replace it with a more accurate
>> supported sectorsize check.
>>
>> This more accurate sectorsize support now allows aarch64 (64K page size)
>> to run btrfs/305 successfully, improving the subpage bs support coverage.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> Changelog:
>> v2:
>> - Fix the _notrun message to use $blksz instead of the wrong $blocksize
>> ---
>>   tests/btrfs/305 | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/305 b/tests/btrfs/305
>> index ad060853..bd484bbe 100755
>> --- a/tests/btrfs/305
>> +++ b/tests/btrfs/305
>> @@ -22,7 +22,13 @@ _require_btrfs_fs_feature "free_space_tree"
>>   _require_btrfs_free_space_tree
>>   _require_btrfs_no_compress
>>
>> -test $(_get_page_size) -eq 4096 || _notrun "this tests requires 4k pagesize"
>> +_require_btrfs_support_sectorsize 4096
>> +
>> +_scratch_mkfs >> /dev/null
>> +blksz=$(_scratch_btrfs_sectorsize)
>> +if [ $blksz -ne 4096 ]; then
>> +       _notrun "this tests require blocksize 4096, has $blksz"
>> +fi
> 
> should be "this test requires a block size of 4096 bytes, have $blocksize"
> 
> So at least 3 of the raid stripe tree tests, from btrfs/304,305,306
> require the same exact fix, why not combine all the fixes in a single
> patch?
> I've sent patches for the other two that do exactly the same.

Right, I'll combine them into one, so we don't need to duplicate the 
same grammar errors into 3...

Thanks,
Qu
> 
> Thanks.
> 
>>
>>   test_8k_new_stripe()
>>   {
>> --
>> 2.51.0
>>
>>


