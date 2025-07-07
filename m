Return-Path: <linux-btrfs+bounces-15296-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DC4AFBE2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 00:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CFA24A53CC
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Jul 2025 22:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99A7226CE5;
	Mon,  7 Jul 2025 22:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="geWertxo"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70860186A
	for <linux-btrfs@vger.kernel.org>; Mon,  7 Jul 2025 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926604; cv=none; b=a6KMypx3N3F4Tqau+en1LJXjRi8lEi9dKLImI94NqVX+NjFr2EcymhK6O5ba2LAVbFBv1gEQ/9hwmBr60EjA1v8VYzSEV7TwjwBzBxtKC7V+2zUJX+oJQExh7ggDNi4170DVO7KBRvIWKV5tQTmfIleOrW+jpqRyoDsJ0tR7clo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926604; c=relaxed/simple;
	bh=z/Jcde4Czi8gpQm3E/BjwYHxAx58PYpTeilxbUedkVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8hbUoJ71tfo34aD1Wvp4odeXaehiaI+YIZVNmElyz+XP1+c4pr4cLWlzZCOr/EZ9jgK0mxjEsPnKzynG309ipbKhuQ7Na5JlmzsrxucQnI+XK0sziHPx6k7m+4WD0MctOTAqhGlg9TFenUsRniYknKTI/K/t3l04SKapj63p74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=geWertxo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453398e90e9so25139735e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 07 Jul 2025 15:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751926598; x=1752531398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EM7/mfwxVYW/eoPE66Em3XNSgDatO/226j0hZ8nF8B4=;
        b=geWertxoCdb8TqmE77tCuYhAaCoR0v7FHntWX5ckIDg6UOGu8xFPzgNTrRLPjeNR8F
         orBoJsd6Iw0Mb5a1/acz+u6wGo+QOkUhwWk7VzT7qChsu0eu6eo4+LPwK2iGbeEgMmda
         xQw85fFW6fgiePGJgSXR+Gat+zz9Zw75RrC1iv//HVS6cUiwraHsi++eFKJiiTXWDHlc
         XjBi2iCbeW7zTyEGHX+RzathkcpuZj0k6fuPOoKsHxedfjBOrqM2zBSW7o0GCyGIgIr3
         FundKNC26r6f4Gcogl36MBUrVgM2vSva84o2PbhKat8b7MLznuxXTmQ2xoom3g/NS6lr
         Ah7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751926598; x=1752531398;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM7/mfwxVYW/eoPE66Em3XNSgDatO/226j0hZ8nF8B4=;
        b=pRa5eLsW77IU+DG7ahjSygui2/b/xziH8FB4yCJrzQosMmfOyjI/FmZto6+Wm2O1MI
         9MMEl0AZ+hLwjBCcl/KczpLmdD7eIdtz0uy0ds34Y35U54L/Er5e7KCi7mi6HiIKrUyY
         z+FAiuWll2JGJjCVwfceqDOlyMQctA2ra7VsAPOoXscE0wRvLZf7c1xl19c20Fz2dcRz
         +SWuxyc4CXp7EsVvFMm/KwzPc0FyP0dG0WzNGus8AOYB/+JzyAAnB7ovsbFDnKWbfv6f
         FDMw6xc4DyKN5SP9B1CSNRIPNah/Nc9adAD1no06f0Nc1QhL1FqBxsoxcN8n3qeJqmgw
         OLUw==
X-Gm-Message-State: AOJu0Yxg4ndUZaGSELBCNOCZDRAXvoLbFqfzunK0ggpK8OqtbqJbikxP
	0bWgSNBKCn73cdsRzhPjLJRNQ/TmfSv83zHdsaebPqH7PDVnDHctnZNe486qh63IhBNjLbcrogb
	NYkZ6
X-Gm-Gg: ASbGncu6QdHph1/pe1rP+AybkRLY9ixOzIzIyueCcAhnrZhZTZTxh3sy8equSSGFjlR
	ySPDk7ahhY5UORIzS4klagJE8Ilu2axfxiv2uAMl0pfbdWmdxI0ANVccYoqSg3w+g0OuMPRR78D
	SoVbnLCupRqYMFQv++QdHEO2SzFp4prPauXD7KfTQi/8mDMZCOq2wQvzCrEyKatEMAE9emfVr6v
	FYgrhscYMWhzezeHPPVV3Qs47jckatBFG3FjopXFnDlI+CnXB7fmR/iYVLxxmw/RzZfaXH5Wb68
	XWMj7sLQJfhB1JWyGCgobUdEmmZIG+H/TnprMh4wtgjptalFDiu2PsQep1CoSFHEvOAmHMHcw/l
	tCyVwNgd062vQPA==
X-Google-Smtp-Source: AGHT+IHlkk+McnDDtQ2KOqAAUgOGNCgFUZt3rASmRY7bcr0Mkz9QwgHulxLr0/4RVVR4zTFy8Rn0vA==
X-Received: by 2002:a05:6000:4011:b0:3a5:2ec5:35b8 with SMTP id ffacd0b85a97d-3b4964bbab2mr9711355f8f.11.1751926597428;
        Mon, 07 Jul 2025 15:16:37 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c220ed0f9sm247284a91.0.2025.07.07.15.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 15:16:36 -0700 (PDT)
Message-ID: <64c96919-5825-4cef-a456-8b625d0d176d@suse.com>
Date: Tue, 8 Jul 2025 07:46:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] btrfs: exit scrub and balance early if the fs is
 being frozen
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <9606fae20bff6c1fbe14dc7b067f3b333c2a955b.1751847905.git.wqu@suse.com>
 <8abcc475-98c8-4bb7-add7-c4fa40065add@suse.com>
 <20250707123026.GE4453@twin.jikos.cz>
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
In-Reply-To: <20250707123026.GE4453@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/7/7 22:00, David Sterba 写道:
> On Mon, Jul 07, 2025 at 02:53:58PM +0930, Qu Wenruo wrote:
>>> Reason for RFC:
>>> I'm not sure if cancelling is the best solution, but it is the easiest
>>> one to implementation.
>>>
>>> Pause the scrub/balance is not really feasible yet, as it will still hold the
>>> mnt_want_write_file(), thus blocking freezing.
>>>
>>> Meanwhile for end users, pausing scrub/balance when freezing, and resume
>>> when thawing should be the best outcome.
>>
>> I have explored some other solutions, like dropping and grabbing the
>> s_writers.rw_sem during the balance/scrub.
>>
>> The problem of that solution is the reserved lock sequence, thus it will
>> be deadlock prune.
> 
> What do you mean by 'reserved lock sequence'?


The s_umount and s_writers.rw_sem are always locked way before any btrfs 
specific locks.

If you unhold the s_writers.rw_sem, it's very easy to cause ABBA lock 
sequence thus lockdep warnings.


> 
>> Currently I guess the best solution would be introducing a special error
>> code (maybe >0? -EGAIN may be a little too generic in this case) so that
>> if we hit that specific error code, we error out as usual.
>>
>> But at the top level where we call mnt_want_write*() function, we drop
>> the rw_sem, and retry other than exit.
>>
>> By this, we split the original long-running ioctl into several different
>> smaller sections (the split only happens after the fs being frozen), so
>> that they can properly follow the fs freeze behavior.
> 
> We have cancellable balance and scrub so there are checkpoints that can
> be extended to also handle freezing in a way that pauses the operation
> and waits until unfreeze. The sequence "drop locks/freeze/take locks"
> should work.

It will cause deadlock if you drop the lock then re-lock with any btrfs 
specific lock hold.

You have to return to where we call mnt_want_write_file() to unlock, 
thus meaning a much different resume path.

> For the exclusive ops it's guaranteed nothing else will
> start so the state will remain the same.
> 
>> The challenge is how to resume from such interruption.
>> Currently neither scrub nor balance can properly handle such resume and
>> will restart from the beginning.
>>
>> And even with that resume implementation, the checks in this patch will
>> still be needed.
> 
> The checks peek into the interals of the freezing mechanism, which I
> think is not the right.

Nope, that's completely common.

f2fs is already doing that to skip its background gc.

Thanks,
Qu


