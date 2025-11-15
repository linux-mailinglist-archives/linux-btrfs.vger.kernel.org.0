Return-Path: <linux-btrfs+bounces-19033-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3EC60371
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Nov 2025 11:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFBBC4E2B34
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Nov 2025 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F88C2857FA;
	Sat, 15 Nov 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aHLg2KtX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D69209F43
	for <linux-btrfs@vger.kernel.org>; Sat, 15 Nov 2025 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763203541; cv=none; b=p+5zFj5A7SygiNIkdN9+XIEXzaDKIUfaFo/+p6MRHbk5Hu38EAhX4VhJHxfMt/nCXDvB/x61Y/nhzZgEaxd6lbYo5K0KO7opALe7m109Bp0WJ3v0yfMpE9GGK3yNK8SwCUy7rJDrevuACTuvTeuNQqqNPeS8xk2wYFHXTDEtPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763203541; c=relaxed/simple;
	bh=iNZDk2h6uMjHy0a9bXwtsNQkx/9P8+QfXqLOluZhlq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VLVeJKwEceTlp5CDJY5Ce0haSjMG5pCU2T6hS/lqj+Q4eEyr7DP3IMUpI1kpoLmVwpkPPXIjdF+MLXEOnFK43FJPz9qY3j4VOCI2oI4UTDy6BYw9Y8f/KYGDmNDsgURLGmBJQfpJJ04Y0wfwV7yYQhE0uYXYOno1mXX3JpXyimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aHLg2KtX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47778b23f64so19958995e9.0
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Nov 2025 02:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763203537; x=1763808337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9PwHMfk75WgWavEjGA0SWMT5bIpjt+7iG3v1Ygo3GHA=;
        b=aHLg2KtXoCu1wA8uBQ6tOmHqgTy89nEAbAatTeyFjSNkhuUrCTblDH3836rQejyI0C
         uTG7vf/4wwe90oVySZyd5Xpt1YzVU/M/oFnMQwmz4eN5jZfL4kLMZf4knutxEWQx9fPK
         UeYFkyaOehF4cvnO7+u1+LOHOPJrYRKTfwtBjsrqitxKDiPCfdT+1qFumcove+C8KJlP
         B6JcVhsMdygVMM09uIEaFwwabKDgUdudxwKLqPf4ww1fTn3ewlpwVkPm6D0Kr0iuzMjQ
         6c9aA7VvSc2I7o+OPWBmlk0nYZIVSckYxsa6IXaMuXAzlzg3bwesM/JhwLWSGvZDLv+j
         sDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763203537; x=1763808337;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9PwHMfk75WgWavEjGA0SWMT5bIpjt+7iG3v1Ygo3GHA=;
        b=DCen9j7h3EfjMZGEtvd2wKm/tpnfftB8fFVDdf2EqW7NIjQjFH+mCUVWfU8PMG+yM/
         aAB5mhkuW0NqFfBEYe71YcnX98102iGyPSFzA5AfsqUmaxmjGMEeax/qXa+1JlIgGC+B
         hJv8akMzQ6KOjP7jb5QaFj5MPynGddAlswmS2VOZD47FyryqpDv5nqXGV6xZxdgImhEr
         JJWBpU5iXO8sYJcZqx/XFTj1VCuEN0J0fIpVzwTpl1WAJSU8HPYH/BLfLhWFLxcb2mFJ
         Ir1Sntu9i1NIYYU+N/QbZbHY9Q6I1BPHmYyMhpYSGmlNob5wgcTWKJsXltSwONO9iQ40
         r6pg==
X-Forwarded-Encrypted: i=1; AJvYcCV9K1kZTcTkxsLbv7yZGi7UMfwIu386kASFNzeDHYoDWq+8cM8p3SlaP+x2x6W58f5mEYUXdnL3Nv1b2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwinrwWY72mqKuiqO/RTpY9gYSJV8FGw6TCZxc03ecqKZu6eMng
	rQOSp5NhYAQij9onJukbO23ZAoztrkwLuYmEx6nL6gGNhNFjbP130aPef0rHtZX2b6k=
X-Gm-Gg: ASbGncvcjE9qzSWl/unaQyiILfc1g6HW55j9vT72aLkE/UPkz0hiJgoG/5MBo3fZbDd
	nr8YIxAD4TSZ01IY6cXE6xxQaOFCvsNuH4NFXao3ZgCJRAixCeXDgD9d/cc7Ecsp8AUnM8mjnYC
	PY6naQEkATE2Ue7hnka3a5hW6aTchQpsJkZgPqlBOKCLZrQzFX5MJ+Qr8yP+AQVQqE3PwSyWVWn
	2FkRwlmRJsYox5R3OASeBDSWYOVUGwK7qlnWq4mVC0nmvjkzGOKsvwTh7Vl3w92Yo7cjgLnle5O
	gIWUCkzYM8kFvOasZCWJ6km6sQU2JD0Z8v02eMZ5icO8FTJNa3IMhY5+Rs8nj96yt8Zcr6hzL/+
	7T5EInz/tDRStrpnJWXs9XmyifqTk0AcHjCvEYn7BGebpkeGW+SUcHYFPpoEiIgCDTLPFuw+iCx
	B67awjkVr4x7eWeXX1Krja74AjDS1Y
X-Google-Smtp-Source: AGHT+IFymMBf2gX1uHtPtE5uacff6QWySlBVBh7HFKfWyPjVPRXCOjka7A2nerTS07UUJBVbpYz4vw==
X-Received: by 2002:a05:600c:6289:b0:477:54cd:200a with SMTP id 5b1f17b1804b1-4778fe50f5emr55881365e9.6.1763203537363;
        Sat, 15 Nov 2025 02:45:37 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed5asm83168685ad.88.2025.11.15.02.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Nov 2025 02:45:36 -0800 (PST)
Message-ID: <ae23e676-1a1e-4e12-b23e-9431a14239a2@suse.com>
Date: Sat, 15 Nov 2025 21:15:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs-progs: fsck-tests: make test case 066 to be
 repairable
To: kreijack@inwind.it, linux-btrfs <linux-btrfs@vger.kernel.org>
References: <cover.1763156743.git.wqu@suse.com>
 <59b21f15f2199cd27233c367457935cb2708e63f.1763156743.git.wqu@suse.com>
 <314461b6-9c30-4f19-aed3-486656db661e@libero.it>
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
In-Reply-To: <314461b6-9c30-4f19-aed3-486656db661e@libero.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/15 20:17, Goffredo Baroncelli 写道:
> On 14/11/2025 22.46, Qu Wenruo wrote:
>> The test case fsck/066 is only to verify we can detect the missing root
>> orphan item, no repair for it yet.
>>
>> Now the repair ability is added, change the test case to verify the
>> repair is also properly done.
> 
> 
> It seems more that this patch only can removed a test...
> 
> May be something was wrong ?

Nope, it's completely correct.

Check run_one_test() from tests/fsck-tests.sh.

There are tons of examples inside tests/fsck-tests/ where there are only 
test images without test.sh.

Test.sh are all utilized to override the existing check_image() which is 
not the full default check-repair-check run.

Thanks,
Qu
> 
> 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   .../.lowmem_repairable                             |  0
>>   .../066-missing-root-orphan-item/test.sh           | 14 --------------
>>   2 files changed, 14 deletions(-)
>>   create mode 100644 tests/fsck-tests/066-missing-root-orphan- 
>> item/.lowmem_repairable
>>   delete mode 100755 tests/fsck-tests/066-missing-root-orphan-item/ 
>> test.sh
>>
>> diff --git a/tests/fsck-tests/066-missing-root-orphan- 
>> item/.lowmem_repairable b/tests/fsck-tests/066-missing-root-orphan- 
>> item/.lowmem_repairable
>> new file mode 100644
>> index 000000000000..e69de29bb2d1
>> diff --git a/tests/fsck-tests/066-missing-root-orphan-item/test.sh b/ 
>> tests/fsck-tests/066-missing-root-orphan-item/test.sh
>> deleted file mode 100755
>> index 9db625714c1f..000000000000
>> --- a/tests/fsck-tests/066-missing-root-orphan-item/test.sh
>> +++ /dev/null
>> @@ -1,14 +0,0 @@
>> -#!/bin/bash
>> -#
>> -# Verify that check can report missing orphan root itemm as an error
>> -
>> -source "$TEST_TOP/common" || exit
>> -
>> -check_prereq btrfs
>> -
>> -check_image() {
>> -    run_mustfail "missing root orphan item not reported as an error" \
>> -        "$TOP/btrfs" check "$1"
>> -}
>> -
>> -check_all_images
> 
> 


