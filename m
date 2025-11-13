Return-Path: <linux-btrfs+bounces-18928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C7C54EC4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 01:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B84CF4E1D18
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 00:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5304D83A14;
	Thu, 13 Nov 2025 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FuX2/WzO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C818E3F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762994226; cv=none; b=Phs5ZRXHQ1mp2fpdwOUYg2VBrUg8zqxdrzg5DZI5k7RrtxeEv41QXp5kmCUkOCGA+totdq+CeDpU5SKF87xE6MkACpy/t3XzysiuHBobaOQvLdaa1xUZoaJEIvsyZk17oBXv1d/4zkfhcf1Q2z2eIWL3KiPuhsIl9Qg1esXAmYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762994226; c=relaxed/simple;
	bh=t0GAws+cn39GR4BVBv+F2mePjdZeEyZ+iZAFHFnnzbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBtI654lGhQkmPN1tYO5V8XsaUzFwiIU8xU1rfhFBDFQi0uppmXDG43lWd8CY1NxtJPaT/mbbmQb6jv5HW8dGGLtNBjuxA6fl96/xSiNxuPoDBOPAhB132oKvCfWVy6pFwcfIE5/0R4yt2erbLTxDkxPddRwno+Vwjcq/WVEKsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FuX2/WzO; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42b312a08a2so181850f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 16:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762994222; x=1763599022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=N0Db1p9EPgdIcmUA/Vg5yxYZphFCPC4pcR6vhZ7eR6M=;
        b=FuX2/WzO+vO6tP6n/dEvt7YpyiUAud+ZOvWH9WQgm/o5BZ74GVw8/NaXeBu7nZSjo1
         IT3uE6JmthfQSwjPG5Q4OazW+biRGrHSUiWisMyEmBwtoo3GcZ/GqG2gpVDC5pM15b/m
         e6XvKjPsANObzJc+8I43maV7mfQEiZmP6sPNMsw8zzyWzxgb2FUZD5ycACuDZxPzx1Tb
         IX7qMPcXKsttb3A2KVq2QAv1SGCXNPz23if6rqEdDv4cqXWfpFy3y0kSv/P8G4UbFvB8
         iocc+kOYj8ikLtyaZd9WPluBgEVwQDd134TUV5lM2PO7jGNrYT6RvN2itGZY+rHx/Bju
         YhBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762994222; x=1763599022;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0Db1p9EPgdIcmUA/Vg5yxYZphFCPC4pcR6vhZ7eR6M=;
        b=ovlAD7359WG94idnP1O7Nx7ZLgn8jn92UkgtteXbug3wK9weQ1Hk82K8Q78aeA4gkk
         H2gefutedb4wvCheBqCazE95/ozyd+xIpDGDmdNBcK/9TOBGSH3/uNGuncmDGfm28lWI
         1p+iXCWtpeVjWjea6XRPYnMAer+waw0V6AfkxUXumUUqUtp+Fr32GDIEKpYoK5hin1ca
         2f/VVzl8yAujni91ClDlm60zlmL1iPUmre0CTc2qjG9cfJlBVb4oZVyvVvVAEdvz5KRn
         NBqo3pGebfm8TT2JplnCzknKwFlEg1nDScZlxzLjED+tFhW1Cslg8L6ZH7GKWSQ263lk
         8NIw==
X-Gm-Message-State: AOJu0YzmFJiJastiDONPru/o6tgiockGUbioXMYp9CqHyxCuptw+OJfE
	XGbDIOc2qGomgk4uAEKVHludHw9vPLQrmxSJ3m2CmN6u32nsFWix6uVlm93PAemIHTenfqlPvv7
	kIeEe
X-Gm-Gg: ASbGncs/sj75t6kp6Tpqwiz7LBGMZGRWp8nOPersN9/1D0mc8USIuV0yb6TCA5ZeXGS
	DkPNE0Bo4V1P9oG3WvbkJYog1jNyRL/zlX5RUwXhI2IgmJXrNhN1q/r/kxxCdN0d9JTu7HQcrvz
	Jp2+mffKoVMCziQ5h2pPbnth8o0fzvDl+JDaz/EfmlQEuI5vis3D3mHd24Eh4klNjCMn8xr4bST
	oXbAvv8EckP0s2SG4oWOhPAunEI6o1s4R7aS54rm70084JB8KhdOVALt5JppqFWFTPEKw+vvGlt
	UgIZAv3vqmpeZpvtjR8GMwXsusFzGiEjEC8TbDXIBeRDljDKBlJBEO0j2Q+Fk5BcaUD79o4Z+k+
	bkHlR9C4yoFwdbYXEsWsRHYWQiv0i8a8VRP2UL7yCZrbgBZOgw3tlGsnjzMof2BUhpVGS3ryMoB
	D1vriqf1hK28MTPfXx1fl4apd/DCoJ
X-Google-Smtp-Source: AGHT+IFJSOB7bcl53COFty0Qc+//DoX8y/FIfnhDCnPJVC03LcFj5onDqLeJx/OxZNogBdf57RJNVQ==
X-Received: by 2002:a05:6000:240d:b0:42b:40df:2336 with SMTP id ffacd0b85a97d-42b4bd9b751mr4729832f8f.39.1762994222142;
        Wed, 12 Nov 2025 16:37:02 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924aed60bsm278171b3a.4.2025.11.12.16.36.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 16:37:01 -0800 (PST)
Message-ID: <42364faa-8808-43b6-86bb-089f25790c78@suse.com>
Date: Thu, 13 Nov 2025 11:06:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1761715649.git.wqu@suse.com>
 <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
 <CAPjX3FdaDTXcP3v52tofjwhByYnN6Rc4PQ257hz7PFvu4zh9Fw@mail.gmail.com>
 <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com>
 <CAPjX3FfY+Ov5sksn+e7hEFbUTWf8ROs6RNEj4-_1iwgx1xfD8w@mail.gmail.com>
 <a18a5937-a1c2-41a4-9261-5b337ccbfbf2@suse.com>
 <CAPjX3FfKhYfWd00m-3VMqSE4v-tJYePfE-A3G3cCjTx7F+B3Vg@mail.gmail.com>
 <c4d28607-702b-4817-ad94-2d52d529e344@suse.com>
 <CAPjX3FewjQqUi7pW4egmN5xvpxh5_RS-tT+_d9K6OK2DMn=PBA@mail.gmail.com>
 <86dfdcb3-5a7e-4f4e-8630-696994d07877@gmx.com>
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
In-Reply-To: <86dfdcb3-5a7e-4f4e-8630-696994d07877@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/13 10:51, Qu Wenruo 写道:
> 
> 
> 在 2025/11/13 08:13, Daniel Vacek 写道:

>> -       init_completion(&bbio->csum_done);
>>          bbio->async_csum = true;
>>          bbio->csum_saved_iter = bbio->bio.bi_iter;
>>          INIT_WORK(&bbio->csum_work, csum_one_bio_work);
>> -       schedule_work(&bbio->csum_work);
>> +       queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->csum_work);
> 
> This is the what causing the difference, that you're calling 
> flush_work() inside the same workqueue, at least for most cases.
> 
> However I'm still not 100% sure if it's fine, as for RAID56 the endio 
> function is called inside rmw_workers, not the same as the regular 
> endio_workers, causing the same cross-wq flush_work() call, which can 
> still lead to the warning.

Well, for RAID56 the rmw_workers are still having WQ_MEM_RECLAIM flag, 
thus it will still be fine.

It's really the system wide workqueues not having that flags which 
causes the warning.

> 
> Personally speaking I'd prefer not to bother the cross-wq situations for 
> flush_work() for now, which is a completely new rabbit hole.
> 
> Feel free to send out a dedicated patch removing btrfs_bio::csum_done, 
> and we can continue the discussion there.

Still, you find the fix and you deserve the patch.

Thanks,
Qu

> 
> Thanks,
> Qu
> 
>>          return 0;
>>   }
>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>>> So nope, the flush_work() idea won't work inside any current btrfs
>>>>> workqueue, which all have WQ_MEM_RECLAIM flag set.
>>>>
>>>> With the above being said, I still see two possible solutions.
>>>> Either using the btrfs_end_io_wq() as suggested before. It should be 
>>>> safe, IMO.
>>>> Or, if you're still worried about possible deadlocks, creating a new
>>>> dedicated wq which also has the WQ_MEM_RECLAIM set (which is needed
>>>> for compatibility with the context where we want to call the
>>>> flush_work()).
>>>>
>>>> Both ways could help getting rid of the completion in btrfs_bio, which
>>>> is 32 bytes by itself.
>>>>
>>>> What do I miss?
>>>>
>>>> Out of curiosity, flush_work() internally also uses completion in
>>>> pretty much exactly the same way as in this patch, but it's on the
>>>> caller's stack (in this case on the stack which would call the
>>>> btrfs_bio_end_io() modified with flush_work()). So in the end the
>>>> effect would be like moving the completion from btrfs_bio to a stack.
>>>>
>>>>> What we need is to make endio_workers and rmw_workers to get rid of
>>>>> WQ_MEM_RECLAIM, but that is a huge change and may not even work.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>>> I'll keep digging to try to use flush_work() to remove the 
>>>>>>> csum_done, as
>>>>>>> that will keep the size of btrfs_bio unchanged.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>>
>>>>>>>> --nX
>>>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>
>>>
>>
> 


