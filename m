Return-Path: <linux-btrfs+bounces-13812-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A73AAEE32
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 23:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A8176F9B
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 21:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D9B28937E;
	Wed,  7 May 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GObk0dBK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168922688B
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 21:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746654804; cv=none; b=fLvzzPKhdKdjufrXvBFdnD+cPOsxUI8pIN2YHKfzk1wVBw3mrS5O+a7/NFC33dLIYGZ5r3tXJ1mAFhyylu4b9JTceXXnjusfHxmPT5A2uddl8b7CmUGcQSmXtMTZf5cEquBMVqbT7g1TVNkHq+WNgzapOGtMC9UHtr7y8L90ae8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746654804; c=relaxed/simple;
	bh=BqCxGHoOT63vPdGdDqTGOOPKfSV3Q55gPYHzkNOK1Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GXHQ08TXi90yIw68X9URlCfxoh7aKYvDT/hk8Uqp86BWLV43+U1Prod9Nie3N4eIdwgCWUYoSX8ptxY8JFuZKxM3cmjUKM6rLMtWE91WvZ63G97Qm932FmOfNbwosvPUTu+VCLuQ71ce4ZvboidGHEhd5EYVzQFrjN7luoIj5dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GObk0dBK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-acbb85ce788so61031666b.3
        for <linux-btrfs@vger.kernel.org>; Wed, 07 May 2025 14:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746654800; x=1747259600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=accLGqf8UR3A6+xt184ij+hTljfF0KLCzkIsCJvy/Vk=;
        b=GObk0dBKMkAl/VE589+aJUuOyqv26Ym50SEYI3VeF4QOEcRyo7J30Uj+tTr/1NYd5b
         WGQdFZNniiwAguN8Iz4C9sJ4uI7P4J+Y+Wizzy3WGYKPzrUsB9MPPYFDl2b8Wwt0giei
         b+9C3k8hbeuS0pwscgijTlw6A5tqj5xeLQISO5MyYh7nHo4+xUaFyj61cD5S25n1FXAA
         rWldeCo2uBWOqop6MKEAYzzbIStqPqEyBVt1WUWwiHmLPAIThyXSyzyyiKIklPF3apPH
         yFezjPWQHBVzbE0uyR4YjQAilb/rgfXa+i4cCu9yXXGFtx80dh2ofpWdtVHfdrJUmQvJ
         eLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746654800; x=1747259600;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=accLGqf8UR3A6+xt184ij+hTljfF0KLCzkIsCJvy/Vk=;
        b=G234qNc786bCjVnAqeCB6ihhpjohindPfMJhUJykrk6qlaU8svS8VCE37vxKOq9quf
         s233wOyExODWLP39lMpCxrAqD4B8cRi55Byc0mf0f8fSUHha8QuihhU1FcVpQkeuop6g
         RIqkhzwF6PCzRcTGflfGx09N1FsjYa81Duj9DsyysjgPiB6MIYhAlNa+PwALOWAyG/s/
         Mqj41gYOQj2BBSQyBPbdG7Q+W7AmVnlfHu0EVIVPlq6q3TeWVO6bHF8WpKnCEFh0skAI
         JaUyisVJVV99RvvVDmJDNqZGArq6mEn2ALIJrr7coXJkDQs+7rWVoO0JqtmunNlEWyDM
         mE8A==
X-Forwarded-Encrypted: i=1; AJvYcCVgR2TcgIJ09ud2A+p4w6+XBj8A/mHyxmjiWKJ2TtKpRZn8uBPa3CA9QjgzSNQzyw1qJaEfmtjkR/anFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjjeiaNOzHZVuSnZFLj6iSVnh1iWt06iZUm7IpbdJBSPMKT0F
	hIodIHGogNJzgCFF5T+pI6RjjXmD0ubIDj30YXZpA5QTr5MB8rV3e+smi93PnV3M59sZykk8pBh
	s
X-Gm-Gg: ASbGncv97bl8oRiK4D0IFnyzPSoR633WcbEn37EqnWtbaIn6I9atjkmlW4okCQKHhlz
	EC1pw690ijcsI+6smCTQh0OY7jSt6N6K418u7jamuhlegVr+COVZGpqp+h19jQ3DfbqS3/yHuX4
	W1giFibSd0HO3aWAp6o/3HlLgjNOXRtJXsSg4Xlh+yJ4i5fXZx+2cc9vWmtNoDVhpvBT6VTg6cu
	q3tacCEWrWrHanOflFdppwzIhxPyMBFW+67ZtltqAImXVsA9vbpbyH+pSYg/ZBYicT9XkyjK5UA
	9A6I0QZnu0Ow/ET4uNUhQP3dHLxvEgMIsFAl7pecRrqa+1dvJ7Y95x+W4oag8nxKkOwS
X-Google-Smtp-Source: AGHT+IEpPYvp+PA4kXFy3X7BXqm4HDRc7ijL3saIUmps4gEBz04AeMnuiRJpRDga/7JIl2DsOR0WEQ==
X-Received: by 2002:a17:907:6d1c:b0:abf:749f:f719 with SMTP id a640c23a62f3a-ad1e8bc2a8cmr511658066b.7.1746654800432;
        Wed, 07 May 2025 14:53:20 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1febec7909sm2167388a12.1.2025.05.07.14.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 14:53:19 -0700 (PDT)
Message-ID: <db844b03-0f1c-4124-a705-bfe07eaeb9b9@suse.com>
Date: Thu, 8 May 2025 07:23:15 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: parent transid verify failed on raid1
To: Ivo Smits <ivo@ucis.nl>, linux-btrfs@vger.kernel.org
References: <507f3dd3-1148-40be-8223-87be96ac6269@ucis.nl>
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
In-Reply-To: <507f3dd3-1148-40be-8223-87be96ac6269@ucis.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/8 02:03, Ivo Smits 写道:
> Hello everyone,
> 
> After some abuse (drive going offline and unexpected shutdowns) one of 
> my fairly large BTRFS filesystems seems to suffer from some corruption. 
> The filesystem still mounts and operates mostly fine. A lot of errors 
> (probably caused by a drive going offline and later returning) have been 
> recovered from a good RAID1 mirror by scrub a little while ago, but some 
> problems persist.
> 
> The kernel log is repeating the following two messages about every 30 
> seconds:
> 
> BTRFS error (device sdg1): parent transid verify failed on logical 
> 31419461632000 mirror 1 wanted 1240926 found 1089963
> BTRFS error (device sdg1): parent transid verify failed on logical 
> 31419461632000 mirror 2 wanted 1240926 found 1089963

The transid mismatch mostly a death sentence for a btrfs.

This normally means bad metadata COW or bad hardware FLUSH/FUA behavior.

> 
> I suspect this might be some background process in the kernel trying to 
> clean things up since it starts after mounting and doesn't stop.

Nope, no regular operation should lead to such problem.

Not to mention both mirrors share the same bad transid.

[...]
> 
> I also ran btrfs check while the filesystem was unmounted. This first 
> discovered the two transid failures also found by scrub, and then 
> continued to find a lot more errors, like reference count and bytenr 
> mismatches. Since the filesystem appears to operate normally and scrub 
> did not find those errors, could this just be blocks which are no longer 
> part of the filesystem tree, possibly not even referenced by anything?

When anything go wrong on btrfs, please just go "btrfs check --readonly" 
on the unmounted fs directly.

That's the only reliable way to evaluate the problem.
If the fs is too large, or you want a better way to show the errors, 
"btrfs check --readonly --mode=lowmem" will also help.

> 
> Is this situation something btrfs check can fix? Is it possible to only 
> let it fix the most problematic transid error and ignore everything 
> else? Could manually patching the transid value help btrfs clean things up?

Normally no to all the questions above.

Thanks,
Qu

> 
> Most of the data on the filesystem is backup data, or can be backed up 
> elsewhere, so losing some files would not be the end of the world, as 
> long as damaged files can be identified and there is no silent data 
> corruption.
> 
> Best regards,
> 
> Ivo
> 
> 

