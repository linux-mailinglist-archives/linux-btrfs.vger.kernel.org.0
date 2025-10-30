Return-Path: <linux-btrfs+bounces-18412-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F5FC1EA36
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 07:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8F83A7140
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 06:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A733342D;
	Thu, 30 Oct 2025 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LKPmOFtR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA9C332908
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 06:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807229; cv=none; b=HU+ubp4b6mR3Uf0G4nCIGBjZQ7bUEdRmoUM1yUY3HsYxLvcOaGHcZQ9AcVpxYzWRqqlEU0Ddp6bF+bR2NvRKn6dAxFXU3sfU0slcHAvAvCT8vB6KAb3ii2nUw6SMExExP4MxtJUEZ04sOsYI2HSmL7b//+ML/I9uWBSa5FhYUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807229; c=relaxed/simple;
	bh=qXHx/nT/qZjdrxmThc3MLeYmmngjwAmO4ugSN42nCY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGy9HCTWbuct9Sa8jIb27rFgByFXsMqN1VZaHyaKM1YwLe13b0BKzhskt8RFDvf19MojWyFh/uGtNknyQvnh2yI6UnC/WzAxIobW26rFuzN0YJLMm9vD8ahbc7i9c8ZJFXn0aCYhKsJzy5S6g0zHy1SKQp9tmK3jSdLylzcs1ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LKPmOFtR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-421851bca51so561342f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Oct 2025 23:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761807222; x=1762412022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=spaiIJRDeLO8qql3bA4ah50+w7VcfliYUjhE/5FZ+4M=;
        b=LKPmOFtRHgudKWQ8MjmGjAuDVzuvQsIyRWZaSbIFopmL20gMfZ+pW39gduNoCHl1eF
         SZiJgOX+Vr+ihFxh79BohaT82CfbH9Q/3vBgI1W7v5FtO/oqOnR6uvdHBBIpFJl2pWLK
         btRAZ0Uf1EGq7m8oN70+NNoBYO0KSPkii5tl3X/eXe01kpYt49gL3JGg0/OkU9FCEEie
         ERAHd8OHuxt/+w6B25khsnhHEXQR+tCrqM903GoRlY8A3RgK+AhOXvqMKEs6nWLIyba+
         PZxxwErEOYi3RWz7EV8k4S958V0kFTEgzsc76Ptu6hR+LhNbP/P2b9g7CsJTvVz9hACs
         PRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807222; x=1762412022;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=spaiIJRDeLO8qql3bA4ah50+w7VcfliYUjhE/5FZ+4M=;
        b=BlmqKZF640oZnv+7YGP+arABK3IhzYcK1BAj6Wd25OcYYSk7EofOXjDKxCCwXlBluB
         NHOA/8MR+u5cdyFLDIQbc8sQxO9TMATDzB4oN/VALJ0I+Rrqd4s0w2vZQ0mom5PJ/6eI
         SaOLdW/7yT1KwIw61+y0LpG0SFTi7pYL+wQYsBIpBDltRP/gtp32guQGNocDVdK/apAo
         Candq1Htmmv7c7Vm7DYHQ5Zu2zZb62somz/M+ar8OuitzyfFCWf0HsxXOFE3e9AI06y6
         +yNWj8zNaxbrGblI5fbGU3scM6Nxi8CsmYitBU+sOF/RziP3ESjPonl1WxvU0rDsG7z9
         InTw==
X-Forwarded-Encrypted: i=1; AJvYcCUH7QxnCXIKg4hqVpfLFgywqKVlLNSWBPfmLm0U91nBPFFSO1caKVIsJjieyeNwNNYBR/lAxMzQGaE8Kw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2vxjIsDT6FtzWvataVj8YYsaLWw7P26gpLc219OmkJ0c8nxz
	jDAq7Y9iLrHfSkkE2nzQdJkQqwkaY9P8CcbjvATsLq4Lw6XwuvZR+KWEG/mU/sR2ZsE=
X-Gm-Gg: ASbGncuoNMIysVtUoJJ66vpZ27c+LTmk/+PfENh75WzyUxBYlE2gfFZ52PesOrMhBU3
	fj1HZ+SWZCxiWHiCdP37cVBD9lkH5FicVAf1OWJMAwF8q/JUnd+RQL5SPt9u/HooZwVkETOnPHk
	YnbMvG+dRPlKwmwLbOTewicS8Oplf55EvroAO7OSw29xzlexMAqmTC5fjDqSVIML38/c6paKPLG
	8RliUK+dkWWfjFGNJ4iVvculkm3Yi0tAu62N4rt+7lS7Gyhz9oEpztWx8loQfMrLrYevbsx1fzK
	CNGWz2a5TiyKrDK7Epi2sQ+Bfsqqs0wnijMOqA2IdinjJvs6ipvp44pX6nHEq5aRroBlS5lOQdm
	oLkP2a5yqC2KLqkJlokR1Yp2Q1EMufoMHutTodoYpdfDVK3Ob72BV4iSfLKFbRrjzDjDr/8lwnb
	ultiqwjUyBd0GvXK7JlyVzrbsSSncK
X-Google-Smtp-Source: AGHT+IGuyA1xrlmXYXQ1Yx0rW63y51Ujb1gDH99TS1bXYeBdhPsZDhgqJaLMAea312NaYFO3cs4sPA==
X-Received: by 2002:a05:6000:18a9:b0:3d2:9cbf:5b73 with SMTP id ffacd0b85a97d-429aef75eb2mr3899135f8f.6.1761807222300;
        Wed, 29 Oct 2025 23:53:42 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a427684bddsm14144800b3a.31.2025.10.29.23.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 23:53:41 -0700 (PDT)
Message-ID: <a44566d9-4fef-43cc-b53e-bd102724344a@suse.com>
Date: Thu, 30 Oct 2025 17:23:32 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
To: Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-5-hch@lst.de>
 <20251029155306.GC3356773@frogsfrogsfrogs> <20251029163555.GB26985@lst.de>
 <8f384c85-e432-445e-afbf-0d9953584b05@suse.com>
 <20251030055851.GA12703@lst.de>
 <04db952d-2319-4ef9-8986-50e744b00b62@gmx.com>
 <20251030064917.GA13549@lst.de>
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
In-Reply-To: <20251030064917.GA13549@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/30 17:19, Christoph Hellwig 写道:
> On Thu, Oct 30, 2025 at 05:07:44PM +1030, Qu Wenruo wrote:
>> I mean some open flag like O_DIRECT_NO_FALLBACK, then we can directly
>> reutrn -ENOBLK without falling back to buffered IO (and no need to bother
>> the warning of falling back).
>>
>> This will provide the most accurate, true zero-copy for those programs that
>> really require zero-copy.
>>
>> And we won't need to bother falling back to buffered IO, it will be
>> something for the user space to bother.
> 
> So what is your application going to do if the open fails?

If it can not accept buffered fallback, error out.

If it can, do regular open without direct IO flags, and may be even open 
a bug report to the project, questioning if they really need direct IO 
in the first place.

Thanks,
Qu

> 
>>
>> Thanks,
>> Qu
> ---end quoted text---


