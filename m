Return-Path: <linux-btrfs+bounces-18848-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B01C4972D
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 22:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F033E3A6315
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC00340DA4;
	Mon, 10 Nov 2025 21:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="a6cC14Sc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2200934028B
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762811127; cv=none; b=n/xMZfc16QgX8lBs2DTsabn4LLfVwzSd14tasjTX6449BV/Jac9rsE25ezaH2m0c1bFzpuWQdPgI++F5YGimO1z70EsOZjS4mIb61FUZ+kKuT3jUm1ra4aRNNKgY/cFfoeKq9JO/tMpifby/m35mzMckOyJ0rJfxtF5ySAFpHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762811127; c=relaxed/simple;
	bh=8ex6Be21RT4lGOqtmJkZm8n5rwdA3ohc90qk8Kr4GhI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kgk3NP3d/gjB1J9uyZFKg5Cde094VCh4A9DSznfe/2AZ8HsSf2ZJVuhWPIxbSWUFBPjYTLfGhA+d5mj8080Qtk4xYQqo3rk7cC+OwyIBl4HH7WAgh8WL5LlAU8CYfFTu1+BFmw7kFYCva6kwqHfJ8XG6NzBdbxNYlDDFD6/FdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=a6cC14Sc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b312a086eso1344004f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 13:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762811121; x=1763415921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=goBHQAQNeAMOF8HA4Do2xfCyU+8RcVE84zIFFD46shg=;
        b=a6cC14SchXRIgTCHXl9tgpBH6R6b6nzyYRLGm5c6tpQlm/bhlskEgCCawySPpz/7S/
         VhASXAeZ5Co8q7mBUF4eyQabz4t7CceJM2NBF85jmuyAJLxnd8iNJ2qCmJvt1OSeaP0b
         KqTg0RufgUwhkWmKmXQ+nPACIu7j4bnlXycq3L4GGBEen7OADd/OYVNaV7XGOdBw4fq7
         YAf3DvCl48wFtzE/aYXye4+ZqDtuobES5Plx0L3Q7AHRRWHmbC1fMbf4ditscrfbFVoF
         XBjtjIZeyd3uXl0QvsF8o+FsZNT59GtYtGywVPR53hEV2D+lu4HJvlvVILWhSNAqyBGi
         FcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762811121; x=1763415921;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goBHQAQNeAMOF8HA4Do2xfCyU+8RcVE84zIFFD46shg=;
        b=HGbGWrgaktRr3L5HeG9J5pNvxh41SCLvm8yf1Kbhb6WBOU5XSmxmbq4XcqJvB9zjXg
         3NnaP3KcurBiah3j298gzvWO/u+fUvPtZzpRzYagTn7o6PJAsESLZkgpVD0H61r72nOc
         TUXuU7C87v/Z54ZX1LT6E+1NMebN7+O7/KIxPkn7H2FCF8T1TAGOS1tZAJqoiWJHc4K7
         ZkSSoSUWtm6r62GvaeMboDAlb0Gx84p/6oaQW3s/jQ/UNd2ZJJf6grMwCZpsrYqVyRXT
         yjHXj2fjPBTArRc6KZY6/wJVn9bUiEtV6w3CixlP21tw9xImgbmFj9f/Chy4zfmkLzg8
         YKoA==
X-Gm-Message-State: AOJu0Yyoh86IZgfYxJM3vWCmTc/7PKHQPzxxuvJ6N7g+l6jjEQJYFEhg
	m62TWfdwr6+hmN1GB/kwW2EuiFHOIKveHmEFjBkc033bkO1uI4naxUGIdImy+R1+Ge44tZ4koO3
	Kc7dK
X-Gm-Gg: ASbGncu9S48ahVL9Fii29CrbJG33F0yBYkLx/dOKXgerDHyg9d2XtKxgJvyOhfx+AIC
	3ojSqsvEof7InW4tS5h26qgoEtEZfvwznXQUePMuuJe9DnOj6dmt3jeqTBooLxtSEqc+R3uUvnw
	UzRlWXXsTdCk4IJgt88ooWNOm3oDS2jfNKmCYwA9+tM8RzlyrfBFY3x7O4nW0//VTLQljrrLfZd
	Ow2xD259iLc6CMYjJjG/GDOjGiwo88ZSiMjhDqLB3Sp+evhW+YRmdEZ/Ggh2aSshuauOxXLmgDZ
	AyShF2q7JqAvvJyaynPBFs7D8nr1FldxbJiayfMb1fbvvKI9ZMOIkOT+HWjTu2rHmKgZN0A9RmP
	Q2TNTSIhiZ22/UsPxdwnbC515aGzTQN0rwMOWg3Io1SN37vGw5CAZccraVmGBzL3M1GfAC3mxCM
	U6+95jLoaI96/yxl/9g0GOZSd9xsUM0RiXeP9JAnU=
X-Google-Smtp-Source: AGHT+IEvJ+46QxRrYx8HuVmzQmZQ2ZStvwCtb0QPJYbIZPTcmulq29qyld/vRqaNCesyz0mazsad2w==
X-Received: by 2002:a05:6000:2285:b0:42b:389a:b49 with SMTP id ffacd0b85a97d-42b389a0f47mr5143886f8f.28.1762811120958;
        Mon, 10 Nov 2025 13:45:20 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bad33c801d1sm10232358a12.7.2025.11.10.13.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 13:45:20 -0800 (PST)
Message-ID: <1f3edc7e-0532-4621-8619-7044f38e0ddd@suse.com>
Date: Tue, 11 Nov 2025 08:15:17 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
From: Qu Wenruo <wqu@suse.com>
To: Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1761715649.git.wqu@suse.com>
 <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
 <CAPjX3FdaDTXcP3v52tofjwhByYnN6Rc4PQ257hz7PFvu4zh9Fw@mail.gmail.com>
 <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com>
Content-Language: en-US
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
In-Reply-To: <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/11 07:35, Qu Wenruo 写道:
> 
> 
> 在 2025/11/11 05:10, Daniel Vacek 写道:
[...]
>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>>> index 5a5f23332c2e..8af2b68c2d53 100644
>>> --- a/fs/btrfs/bio.c
>>> +++ b/fs/btrfs/bio.c
>>> @@ -105,6 +105,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, 
>>> blk_status_t status)
>>>          /* Make sure we're already in task context. */
>>>          ASSERT(in_task());
>>>
>>> +       if (bbio->async_csum)
>>> +               wait_for_completion(&bbio->csum_done);
>>
>> Can we do `flush_work(&bbio->csum_work);` instead here and get rid of
>> the completion? I believe it is not needed at all.
> 
> I tried this idea, unfortunately causing kernel warnings.
> 
> It will trigger a warning inside __flush_work(), triggering the warning 
> from check_flush_dependency().
> 
> It looks like the workqueue we're in (btrfs-endio) has a different 
> WQ_MEM_RECLAIM flag for csum_one_bio_work().
> 
> 
> I'll keep digging to try to use flush_work() to remove the csum_done, as 
> that will keep the size of btrfs_bio unchanged.

Unfortunately it doesn't look like possible to use flush_work() here.

The point is that btrfs_bio_end_io() can be called inside a workqueue 
(endio_workers or rmw_workers).
Those involved workqueues have WQ_MEM_RECLAIM flags set, this means they 
can not flush works without breaking the forward-process guarantee.
(check_flush_dependency()).

It looks like flush_work() has more complex mechanism than just waiting, 
not suitable for our pure waiting usage.

Thanks,
Qu
> 
> Thanks,
> Qu
> 
>>
>> --nX
>>
> 
>>>
> 
> 


