Return-Path: <linux-btrfs+bounces-13377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8FA9A439
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7713A5A359F
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 07:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E54B1FCCF8;
	Thu, 24 Apr 2025 07:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LsCZtLqk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EC6231C8D
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479323; cv=none; b=BKKrGqRRu2SSd+S7w5EgYEv2AeRbuXaOJyMR2ppwCsdAB2AjmY4gO0yQzvrQ1THig/I/OZX51clbpu8im5s3nEwuS48PjVUHlkITFUNpl0+4aRcDMNH5eD+I1DCIquDc3MQg0UuWDvrnRuHHcK9LiChp8jiQwdiioJ/cVd+Z7p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479323; c=relaxed/simple;
	bh=AeSIvLUiDOKnFwSsEXCnErYULP/tMW3o2RwAmnTdxlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVGg9kAtC75+lzzQwWl+peTUSCBqzpFwlJhwVvT2GQQA3C4y90+2kk7HOI35Znes6c6zScPWv4fAMQyLpeAEs2uu7uOlKawKpD8hnW0p1IzP8OMxZLIl0ZKjSNfc3UCaK6Xp9zqUIvIYS8uPGJPU7KAShAHBVrLjTRGKv68t9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LsCZtLqk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac7bd86f637so364385266b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 00:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745479319; x=1746084119; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5znp3V/k0l+974LWOrCn6H27BLndUXlZi3r+/6xUgaI=;
        b=LsCZtLqkid4hryM76KwK0XfQXnMmd3C/UDMY6Jyrrhr3HJhCk/oIyD8u6ZCc4onRGf
         XxkPLQ9ON4qxOpeP3fu1ttWSrz/Yozx70I0dOmAO37WTr6GxgILVmA7DDiiC6/FBTflk
         nIg+ECKRCVWs0K8AP9nEZ+/TgiABSCMeaGB5zo+VCjSpqbCH0EmMm0Zhkhd25nJCjaAx
         Mw7HhCuAl9TFXg3+zQjfquWKzP1isKHAe+7tXUqR3w0Pk1OZKG7ZQiQXRnAppNwfkBQR
         gbA9b3RrhPRI06PCKUkfFD79GexhaM1ak2zXUCf0Hf21qRc3xVnFHs4LeRif573IslXa
         WIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479319; x=1746084119;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5znp3V/k0l+974LWOrCn6H27BLndUXlZi3r+/6xUgaI=;
        b=az1GtUyw+ktPV9pu/uVo8G+z6xyRmMHFvkyPO7PHKZ+DV0vK+3+LSHnEiGH1aPcBal
         HkUQnUmjElWpNkuCpUJ2Rj002BuBj3JCCRS7acBCZ4n0jz9dwfGlpJPIDtSKCEBDOoMa
         jYj8xlbEGrZSyepiPMIZjTpZMjEp3bNtb0AEvqshGhyQXzRgsGdgCiFnX7x+2t+Oi+dx
         77Ddu+tm0GaphUpjkiEL2kgBefqlH9XCeeNJhaCFOX0HlxAsYMV4DLjeepjj/tYKcCYj
         s8nxASHeapCY87vRc5+Mw3JRRcw/wJIUGuPjcqvJek399kDpnoD4ywijGl7iU8rmg6HW
         MUHQ==
X-Gm-Message-State: AOJu0Yyd+ipO/cudmEDa8WELxQfNHphXVdB0B6md9Dmw0CF1A0ZQ209C
	n93fsLfOmLvkPtTttQ/S/7FCc/tfE0MC6P+wpQZHUBbZHm/C7wFxmKN04aJyTiw=
X-Gm-Gg: ASbGncsdT99LucN64j9uwUkDSrQEkmrIXPSWeXEkT5RanopzqB7M8DFKb4br1tSIRMu
	iaJJA4v2FkX7SlWk8WXwgcV/gEpXwI0jU5Z6hi+FrML18O560NWvjuf4rZhxV/WhWA96pnbG/wK
	pPcoPCW9S2bSX4kf86BjC7ARanNy04jMXSJoWBjaIhif4R4D2OKessIZouuPKpTSs4G+mXCubY8
	33ClSfHohqxN20XMW9sa07d+YiwScyJ2+fBi9pzLpLZKdgb9iWUHOrI8TIUt4gb3qc6SVfM12tU
	tc9zwnv/t7LDs+NuspRrBRWBu+eMMQjAgeqM7gknosEA+Mr0Ce5L/Cx1wKRLcIv4GjO0
X-Google-Smtp-Source: AGHT+IHKo+ssAU4jAjbxoWNbbvBUUEk3n5K19OWn1vS6QeNL1YWi6RzzM+mVSR35HFzJyUMrkrRiSg==
X-Received: by 2002:a17:907:cd0d:b0:ace:3291:751 with SMTP id a640c23a62f3a-ace5a2a87c2mr94965566b.14.1745479319386;
        Thu, 24 Apr 2025 00:21:59 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef06043fsm597789a91.18.2025.04.24.00.21.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 00:21:58 -0700 (PDT)
Message-ID: <7119eb1c-591a-4952-a3ea-a81599c0238b@suse.com>
Date: Thu, 24 Apr 2025 16:51:54 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/315: fix golden output mismatch caused by
 newer util-linux
To: Zorro Lang <zlang@redhat.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20250424060608.251847-1-wqu@suse.com>
 <20250424065844.zl63dwo6w5hsr2ob@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250424065844.zl63dwo6w5hsr2ob@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/24 16:28, Zorro Lang 写道:
> On Thu, Apr 24, 2025 at 03:36:08PM +0930, Qu Wenruo wrote:
>> [BUG]
>> With util-linux v2.41.0 and newer, test case btrfs/315 will fail like
>> the following:
>>
>> btrfs/315 1s ... - output mismatch (see /home/adam/xfstests-dev/results//btrfs/315.out.bad)
>>      --- tests/btrfs/315.out	2025-04-24 15:31:28.684112371 +0930
>>      +++ /home/adam/xfstests-dev/results//btrfs/315.out.bad	2025-04-24 15:31:31.854883557 +0930
>>      @@ -1,7 +1,7 @@
>>       QA output created by 315
>>       ---- seed_device_must_fail ----
>>       mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>>      -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
>>      +mount: TEST_DIR/315/tempfsid_mnt: () failed: File exists.
>>       ---- device_add_must_fail ----
>>       wrote 9000/9000 bytes at offset 0
>>
>> [CAUSE]
>>
>> With util-linux v2.41.0, the mount failure error message changed to the following:
>>
>>    mount: /mnt/test/315/tempfsid_mnt: fsconfig() failed: File exists.
>>
>> Thus the existing filter only striped the "fsconfig" part, leaving the
>> "()" without changing it to " system call".
>>
>> [FIX]
>> The existing filter on error message is doomed from day one.
>> I'm fed up with the stupid catch-up game depending on util-linux, so
>> let's just stripe everything between "mount" and " failed", just leaving
>> the golden output to:
>>
>>    mount failed: File exists.
> 
> Hi Qu,
> 
> Thanks for helping fstests works with lastest until-linux.
> 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/315     | 14 +++++++++-----
>>   tests/btrfs/315.out |  2 +-
>>   2 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/tests/btrfs/315 b/tests/btrfs/315
>> index e6589abe..9b5bc789 100755
>> --- a/tests/btrfs/315
>> +++ b/tests/btrfs/315
>> @@ -30,9 +30,8 @@ tempfsid_mnt=$TEST_DIR/$seq/tempfsid_mnt
>>   
>>   _filter_mount_error()
> 
> I thought it's a common helper in common/filter, but I found it's a local
> function of btrfs/315 with "_" prefix ... it's not recommended using "_"
> prefix for a local function.
> 
> And there's a _filter_error_mount() in common/filter, could you help to
> merge this _filter_mount_error function onto common/filter:_filter_error_mount,
> then turn to use the common one? Then we don't need to maintain two different
> functions to filter mount errors :)

Thanks a lot for pointing out the common one, I had the exactly same 
initial thought and went into common/filter for the function but failed 
to locate it (they have different names), and just continue fixing the 
local one.

In fact the test case itself should use the common one, which can 
already handle the case very well.

Thanks,
Qu

> 
> Thanks,
> Zorro
> 
>>   {
>> -	# There are two different errors that occur at the output when
>> -	# mounting fails; as shown below, pick out the common part. And,
>> -	# remove the dmesg line.
>> +	# There are different errors that occur at the output when
>> +	# mounting fails:
>>   
>>   	# mount: <mnt-point>: mount(2) system call failed: File exists.
>>   
>> @@ -41,10 +40,15 @@ _filter_mount_error()
>>   
>>   	# For util-linux v2.4 and later:
>>   	# mount: <mountpoint>: mount system call failed: File exists.
>> +	#
>> +	# For util-linux v2.41 and later:
>> +	# mount: <mountpoint>: fsconfig() failed: File exists.
>> +	#
>> +	# Instead of playing the stupid catchup game, removed everything
>> +	# between ":" and "failed:".
>>   
>>   	grep -v dmesg | _filter_test_dir | \
>> -		sed -e "s/mount(2)\|fsconfig//g" \
>> -		    -e "s/mount\( system call failed:\)/\1/"
>> +		sed -e "s/: TEST_DIR\/315\/tempfsid_mnt: .* failed:/ failed:/g"
>>   }
>>   
>>   seed_device_must_fail()
>> diff --git a/tests/btrfs/315.out b/tests/btrfs/315.out
>> index 3ea7a35a..fb493e90 100644
>> --- a/tests/btrfs/315.out
>> +++ b/tests/btrfs/315.out
>> @@ -1,7 +1,7 @@
>>   QA output created by 315
>>   ---- seed_device_must_fail ----
>>   mount: SCRATCH_MNT: WARNING: source write-protected, mounted read-only.
>> -mount: TEST_DIR/315/tempfsid_mnt:  system call failed: File exists.
>> +mount failed: File exists.
>>   ---- device_add_must_fail ----
>>   wrote 9000/9000 bytes at offset 0
>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>> -- 
>> 2.49.0
>>
>>
>

