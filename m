Return-Path: <linux-btrfs+bounces-13185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 329DBA94D88
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 09:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A17F170D21
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Apr 2025 07:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7022D20E336;
	Mon, 21 Apr 2025 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="blhSS5Gs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9517920E002
	for <linux-btrfs@vger.kernel.org>; Mon, 21 Apr 2025 07:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745222250; cv=none; b=q+m5tEqSlPwQw05j0vLKklXDJSCNdNdck5WTwwOQ1WV2DmNYrZc/AFgpl/czQSEucmrKzwYqygpQ7NWycHmP4dSycpOyYYoTJZGPwpCtQaNuPRdzTsaWnEeocInKQ3LyeACWE9pJWjexBHuBk//Mf1+8mdCX5oGRZo8T7xKRNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745222250; c=relaxed/simple;
	bh=kqIWdFItiELQ4qB7+CGFAgzjDGMxev7qomaMdoSU09Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zvx3qYur6/WUC4/tgXwoqj6707zt69UWZYFNCHBl+rKWdU4l83YtWHnude70QUvok7qQk/oYt1JXDV5oQnMm6TN5AAIrj/AR0qoSlrcQ5kDbNERkY+LJqilaLz+Uc5D1yqAP+iwCc62OlHUJxYXPMl3uqE8aT/JHxAxC4SugWm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=blhSS5Gs; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso2524945f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Apr 2025 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745222246; x=1745827046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=adqPWmejmuezNf4f8vq8x1mLJ0k23w/bmuzA0I7jSzQ=;
        b=blhSS5GsHdT6WCY8xcMljMRt/1NIEvFJePM1jJiu54JXRjff4LV+ADxTKkngQCOYSK
         OXGOm2ufaXbJDQmoG+ih8txwYqCBwvNiorgv4GjR/lJgn2aGt4HauQsZdmclOQRj3hdA
         AbX9JCZrOamSu3aUeTdezn3KqV9c53nhNoiRYQKeh5umoD6Ha9k94fDcU1r/kz21wtOp
         oe6XfcOzOBc6oBEuXP+t9I7xjhTUhVxRYY2mH1yPREL9GNncYg2hkeLaSjbhyShwtgsa
         rXK0SbPckXq6fmqCfjyynaD4zyKrK02A3uC2piuGChdXwZxyIq4tSrb93beMwISO0lH+
         iISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745222246; x=1745827046;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adqPWmejmuezNf4f8vq8x1mLJ0k23w/bmuzA0I7jSzQ=;
        b=aZ9vgSuxCR8ICUldvrJmhZFjkSdDJjV4IgviLjldwc+XVb7tkU8XptBc7OuZoK9W6h
         n70BVmBd2B54wG9jXeDpcWuWKaMjmiL17jSvYq1hT4QzvwklyvWLvE44iVzVv6xADKOv
         Jim5LPuVLjPSP2px97cJjUWQtG7/TWJ7BX7T0x5c7m9vF0ewUwCsBbOtxtgI+IeAFWWL
         cKOClIfpISdTXVOX2hggO7xPr7XheMlMVeHOBKPkZCQ2HO2wHXKwVRcWvMvB2Oe5ozVl
         DqeP2QAfpDctYsLho1WwIKK1HCp9ElDTZxi+oA9ZAAvhLMbKVbNmusXNjv7K9y4fmBs/
         SdoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWY8s+yDTsyHJqpLBXzmYrkBOlLmZ6VJRjku41Rb5/rY3aKPPZK7wUA+bggN0UkbbpR/ozQHgpEadsSxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfWuTeqdd1ElEEd6siW3fFD/eP7Yq7GZGJQo1FccTVZ8bR6VC
	60zrm1iipq9wS1YAx23m/tWii3CFAyBemJCie0u+Zkkm59pAS9h05etOJ3HY5yg=
X-Gm-Gg: ASbGnct2s6EajKOrK1TaOcXqQd7vUWaTrEefZ4grIGWQ1Mw69g6TmGQBhD8BUhwCqu+
	dtfW7ztEf1qLSVXP4OLVhUdmuzFF6scDLff/YpeiVmtSw+Ahb+NIoI5spZzkSOrRHz47N1KqSbq
	2pnchUbRUArqRONODBzOb2M7KalPSMAWKuL74/OxxrX2bansFWMFrD2BsTI2ymYx+LxOEK8Cuo2
	FXNPgBQyiUVMzxYYCYSE1j+/JTCINY0dKLfKkZAImSXN/60fykg0lgi3aVCBKz8bzBvZitg461d
	ZylYXvy+HBGm5sNY2RiUSeC4ts88E+4u9uhW3r4fUWMY1F7j507tdJfVh8qoWHh8G48T
X-Google-Smtp-Source: AGHT+IE4x8uEsspOVElZXmr9L0jEK3s4asmwDmAMfNbyvyQDNKLj7RRd/zW6qFbYrB6CsL8MlMcgqg==
X-Received: by 2002:a5d:6d83:0:b0:397:5de8:6937 with SMTP id ffacd0b85a97d-39efbae3fbcmr7191520f8f.41.1745222245635;
        Mon, 21 Apr 2025 00:57:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::c8a? (2403-580d-fda1--c8a.ip6.aussiebb.net. [2403:580d:fda1::c8a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50eceb4fsm59575765ad.183.2025.04.21.00.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 00:57:25 -0700 (PDT)
Message-ID: <ab191f38-fd73-416e-a168-299db23f184b@suse.com>
Date: Mon, 21 Apr 2025 17:27:21 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/253: fix false alert due to
 _set_fs_sysfs_attr changes
To: Naohiro Aota <Naohiro.Aota@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Anand Jain <anand.jain@oracle.com>
References: <20250420083817.231610-1-wqu@suse.com>
 <D9C4F4DRFD6F.1PCSE73DVIV8Y@wdc.com>
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
In-Reply-To: <D9C4F4DRFD6F.1PCSE73DVIV8Y@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/21 16:30, Naohiro Aota 写道:
> On Sun Apr 20, 2025 at 5:38 PM JST, Qu Wenruo wrote:
>> [FALSE FAILURE]
>> Test btrfs/253 now fails like the following:
>>
>> btrfs/253 2s ... - output mismatch (see ~/xfstests/results//btrfs/253.out.bad)
>>      --- tests/btrfs/253.out	2022-05-11 11:25:30.753333331 +0930
>>      +++ ~/xfstests/results//btrfs/253.out.bad	2025-04-20 17:28:39.139180394 +0930
>>      @@ -5,6 +5,7 @@
>>       Calculate request size so last memory allocation cannot be completely fullfilled.
>>       Third allocation.
>>       Force allocation of system block type must fail.
>>      +./common/rc: line 5213: echo: write error: No space left on device
>>       Verify first allocation.
>>       Verify second allocation.
>>       Verify third allocation.
>>      ...
>>      (Run 'diff -u ~/xfstests/tests/btrfs/253.out ~/xfstests/results//btrfs/253.out.bad'  to see the entire diff)
>>
>> [CAUSE]
>> Since commit 0a9011ae6a36 ("fstests: common/rc: set_fs_sysfs_attr:
>> redirect errors to stdout") the function _set_fs_sysfs_attr() always
>> output everything into stdout, thus the stderr redirection makes no
>> sense anymore.
>>
>> And the expected failure will cause output difference and fail the test.
>>
>> [FIX]
>> Instead of the useless re-direct of stderr, save the stdout and check if
>> it contains the word "error" to determine if it failed.
>>
>> Fixes: 0a9011ae6a36 ("fstests: common/rc: set_fs_sysfs_attr: redirect errors to stdout")
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   tests/btrfs/253 | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/tests/btrfs/253 b/tests/btrfs/253
>> index adbc6bfb..ad69dfe1 100755
>> --- a/tests/btrfs/253
>> +++ b/tests/btrfs/253
>> @@ -228,7 +228,12 @@ alloc_size "Data" FOURTH_DATA_SIZE_MB
>>   # Force chunk allocation of system block type must fail.
>>   #
>>   echo "Force allocation of system block type must fail."
>> -_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1 2>/dev/null
>> +output=$(_set_fs_sysfs_attr ${SCRATCH_BDEV} allocation/system/force_chunk_alloc 1)
>> +
>> +if ! echo "$output" | grep -q "error" ; then
>> +	echo "Force allocation succeeded unexpectedly."
>> +	echo "$output" >> $seqres.full
>> +fi
> 
> Can't we use _set_sysfs_policy_must_fail() instead? Apparently, that
> function does not looks only for "policy" setting. So, renaming the
> function would also be appreciated.

Thanks a lot for pointing out the _must_fail() version.

Didn't notice that since the functions are split into common/rc and 
common/sysfs.

I have to say the split and naming is really bad, especially when none 
of the policy related helpers are not utilized by anyone.

I'll keep the fix simple for now, and leave the rename for Anand, as he 
would have a more clear view why those helpers are introduced and may 
have a better naming scheme.

Thanks,
Qu

> 
>>   
>>   #
>>   # Verification of initial allocation.


