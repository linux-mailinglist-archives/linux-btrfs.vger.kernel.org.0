Return-Path: <linux-btrfs+bounces-9799-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFB79D4450
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Nov 2024 00:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D39BB21BAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Nov 2024 23:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1008C19D078;
	Wed, 20 Nov 2024 23:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CImU7Nr1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49119B3ED
	for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 23:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732144223; cv=none; b=ELkXvEbn53DHsvzkBjkpy3yFAGg3JFb1yTN+p+NKdD16aTLOO03Evr+eSf8BJ8y4XR+x1w1zBda9NmSLkz5JphVWnvwFQ1N5vwbLLX0FvrR5tlYIzJwRfKMx/yuywE5w5alLW1xpm0wJNZr3XeFVGuvkc64Z4bA0eW7r5/KPyyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732144223; c=relaxed/simple;
	bh=nQa6vtkvnYgIIWXO0al8i2sNbirHaTI9aq3+lFLOPO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZX4tHrClPx2AaWyYeomlVgKjU0s0dknwxRCAwMrVmeEIKsvjiF4nZeAtmLwUjUPKaX7abKIdx2sTA7PVSS7I7DnwVMO1uzOedIBFvZdACqo4hPUe1/MM1fUx8WcO2OkmebAQuLo2mDQpUQB7G0Y18EZGiiVj0gfVHShSrMpsPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CImU7Nr1; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43162cf1eaaso2984545e9.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Nov 2024 15:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732144219; x=1732749019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TERUUy/ELqf8T2J/DgfUgbib//lpIRWZZFk6LKbSDYs=;
        b=CImU7Nr10QoMGzyK1AUiS0qhlU9uBt0FeRqhn3KLNsu2rZocVCaP1gomj3UoRktZJ1
         DMeLJooZdEMW134Ekt8yTTOxQLoSAOt6+vDwu5w329r7Qa6xZ4nw9lF/NwQ05g4WdgmE
         y+XoxsgJOkYKvxrStNqOJoFSfgqTiVFhGp1ziA/qH3DIWuwOmT7C4GaFaW+7R+/tf8er
         CfN3tUP8WcIU56hEi7FslvKUMBRsH4EMgvlLqi85LyvDV68TEfK/qQxB90RX+LpWvek6
         RYoDPhum76P8Pr1fJoOq5YXgGaPpl5nQyV7YIUUxe/qVMeIjDn8y3BljcxiljNrLGj4o
         QPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732144219; x=1732749019;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TERUUy/ELqf8T2J/DgfUgbib//lpIRWZZFk6LKbSDYs=;
        b=mnBjOeJnPXVkBzFsW1cFEGXTUsg0uQPCrFG1whHOr2DW1kNUvcKMunQIY9tpD9LFnp
         BS49X16ZAtfJfcdRnic/ML0ASjMob5R+D6Ag+WeyicOQ5WdvYT4W+VYY+3wuiwgAb/Gv
         +GXzylMy+PguFCggsy74zPJ3ZSkVEf8vViuXseFwzrEdUbGWgnLQHOpc0JH3LV/Df4Iw
         aOmTY6fH2OAzT3NIRA3Hoyf3GSEXiR+hEba+uU2diLCL6DFF8hBcmrefJwPr39m8guuF
         6eEdyeTpQUTUMkosNx7Tb3vMJQsWVyf47zhVVSUb4l69bc7nLqEcu2sOGMFvBwh03fm5
         5j+g==
X-Forwarded-Encrypted: i=1; AJvYcCWaLcg7wjfakmGQRKeObivWGpZJcV+PLJO5hee5LAf6B0rkSippslqT1JgqkVEnjVdvbtvQTsR4K2pQHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeqCNtmuJTWHJKxwArbGGVOw1X72bkO8zCGA+nALyIppphDs8i
	MpdEiJf/6ou0IfiQecaAQIUnPNxzfYnEInR4lQRUzrEd0Y+AhZKeqUjAAPcDfLA=
X-Google-Smtp-Source: AGHT+IGnVs1G/8O9wh4skYZvueMqwcVCUzoCjIZkajbfoddawA/NQCYDEHorJ2xrz6CkXDaVnyvRrA==
X-Received: by 2002:a05:6000:1a8e:b0:382:29aa:565a with SMTP id ffacd0b85a97d-38254af9d47mr4248270f8f.24.1732144219154;
        Wed, 20 Nov 2024 15:10:19 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead0311a00sm1904766a91.13.2024.11.20.15.10.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 15:10:18 -0800 (PST)
Message-ID: <cf150514-d820-4f79-8e19-b479bc93855b@suse.com>
Date: Thu, 21 Nov 2024 09:40:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: fix blksize_t printf format warnings across
 architectures
To: "Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-xfs@vger.kernel.org
References: <c4847cd94f86bd98fc563f112e177b317dc21111.1732102551.git.anand.jain@oracle.com>
 <1141f20f-86e4-4638-adc4-5cb290f87691@gmx.com>
 <20241120222152.GD9438@frogsfrogsfrogs>
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
In-Reply-To: <20241120222152.GD9438@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/11/21 08:51, Darrick J. Wong 写道:
> On Thu, Nov 21, 2024 at 08:36:58AM +1030, Qu Wenruo wrote:
>>
>>
>> 在 2024/11/20 22:10, Anand Jain 写道:
>>> Fix format string warnings when printing blksize_t values that vary
>>> across architectures. The warning occurs because blksize_t is defined
>>> differently between architectures: aarch64 architectures blksize_t is
>>> int, on x86-64 it's long-int.  Cast the values to long. Fixes warnings
>>> as below.
>>>
>>>    seek_sanity_test.c:110:45: warning: format '%ld' expects argument of type
>>>    'long int', but argument 3 has type 'blksize_t' {aka 'int'}
>>>
>>>    attr_replace_test.c:70:22: warning: format '%ld' expects argument of type
>>>    'long int', but argument 3 has type '__blksize_t' {aka 'int'}
>>
>> Why not just use %zu instead?
> 
>  From printf(3):
> 
>         z      A  following  integer conversion corresponds to a size_t
>                or ssize_t argument, or a following n conversion  corre‐
>                sponds to a pointer to a size_t argument.
> 
> blksize_t is not a ssize_t.

You're right, it's indeed different and it's more complex than I thought.

blksize_t is __SYSCALL_SLONG_TYPE, which has extra handling on x86_64 
with its x32 mode handling.
Only for x86_64 x32 mode it is __SQUAD_TYPE (depending on wordsize 
again) otherwise it's __SLONGWORD_TYPE (fixed to long int).

Meanwhile ssize_t is __SWORD_TYPE, which is only dependent on word size.
For 32bit word size it's __int64_t, and for 64bit it's long int.

So blksize_t is more weird than ssize_t.

Then force converting to long (int) is fine.

> 
> --D
> 
>> Thanks,
>> Qu
>>
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>    src/attr_replace_test.c | 2 +-
>>>    src/seek_sanity_test.c  | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/src/attr_replace_test.c b/src/attr_replace_test.c
>>> index 1218e7264c8f..5d560a633361 100644
>>> --- a/src/attr_replace_test.c
>>> +++ b/src/attr_replace_test.c
>>> @@ -67,7 +67,7 @@ int main(int argc, char *argv[])
>>>    	if (ret < 0) die();
>>>    	size = sbuf.st_blksize * 3 / 4;
>>>    	if (!size)
>>> -		fail("Invalid st_blksize(%ld)\n", sbuf.st_blksize);
>>> +		fail("Invalid st_blksize(%ld)\n", (long)sbuf.st_blksize);

Although for this case, I'd prefer to use "long int" just for the sake 
of consistency.

Otherwise looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>>>    	size = MIN(size, maxsize);
>>>    	value = malloc(size);
>>>    	if (!value)
>>> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
>>> index a61ed3da9a8f..c5930357911f 100644
>>> --- a/src/seek_sanity_test.c
>>> +++ b/src/seek_sanity_test.c
>>> @@ -107,7 +107,7 @@ static int get_io_sizes(int fd)
>>>    		offset += pos ? 0 : 1;
>>>    	alloc_size = offset;
>>>    done:
>>> -	fprintf(stdout, "Allocation size: %ld\n", alloc_size);
>>> +	fprintf(stdout, "Allocation size: %ld\n", (long)alloc_size);
>>>    	return 0;
>>>
>>>    fail:
>>
>>
> 


