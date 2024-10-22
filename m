Return-Path: <linux-btrfs+bounces-9050-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590749A9645
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 04:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1B01C22CA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2024 02:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1711139CE2;
	Tue, 22 Oct 2024 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EEWBKDJr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA30C33DF
	for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2024 02:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729564562; cv=none; b=dMUMM08LTDMfVfEUQ0jfqKsagI1XHVtCUbA5EWqNo02Ixft5Au2T/YuoBAvfMjlyg9QXotHYNi+b66zpKcSAyG888+bR/hm248Nh/GhBH3pHdj6d6K+F4bVsAQF29WQiumDao1IRvnQde7ommKMt8kxR+Y1i3dOHuNmL24h3wvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729564562; c=relaxed/simple;
	bh=p0V/gvPKH1rH47s0YYBUkslly5iK538m5yizTC9AIA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLUnK7nX/zyaRcR44zOn6BpVVLXvqQ7/OXrC+kPdlQeJ3mS/c/Ql2s9KAJr+RdsmHedqHm4uZFi91/uk5rmsHb9COsw8y3X2cTdKeJ5YP6cpkIl1zxENExMsXMQfJyEFQgxQia/56cma7SVE0clV4i9214AB17xJTrAba2l4yEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EEWBKDJr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d447de11dso4031096f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Oct 2024 19:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729564558; x=1730169358; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=URFzMlBbLy45Xhzrfxhquc3cOkhT8VMvxJCO5Itcibs=;
        b=EEWBKDJrkbkoIjBtacHhq1tWKoEFWV4kGwSZZObilLv1YN1YxcbFX+xCG48oounSZW
         5HKsvCvJ5hN0qkK98CXXieFE+JGAdqE1mgvZvnDZ+w5DMDBYhvpM4JvAKZ/B9xVZqJeK
         FSB9mjdSatETU4X7RzGV0AKhldBpXDeeOvC1DGtcYe//Y+03AhTTA7KpikNhT8oDlT/w
         9OoYGg51AjcxWSPJxd9qjtlDJ7lLeq4FWdmRAJqedGfI5btAuPXqDzCN08XBkaJ+ddWs
         43WR2kNHVKQXmUtqLGHMRG2UUiRvoQizDnOJLv4asYeAEKgNJ21saR4ORAoxGy+7yXPO
         wAVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729564558; x=1730169358;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URFzMlBbLy45Xhzrfxhquc3cOkhT8VMvxJCO5Itcibs=;
        b=HVbTUmW5s37m8T7kZJkTLy/1ASSNNZUgD7SdDMafdhepaZ+TBMnE9XCtg2uFU5Bk6h
         lnBPYp4jNUbz116Kg8DG5Au2VgL6kRFaMXvr7KnI2QJn29Ksp3dzPoG2cDMqphKjUOwI
         1jp9rOS1RNxI2ujrvfNWUhi6gm2TO85vRv/pEyLI1hHAmDrUY0ORIttlaKtwFFnjPlMD
         Gpe46sQqnxihK7MpZSPUSzOVFlc2CB+aFd2MCgZBFYdxTYU0TcHHGMpW+b36N8uwqQhJ
         nMs2LGRiDEuSgKyd7Gd/NYyl7E8Hvl/+RzZeCCP3eNzNLig3y5CzYRrpfwQiR//Wo/TD
         8xyQ==
X-Gm-Message-State: AOJu0Yw0QOqXKzEnq8ShrDFWZds5QHRaUlLpRENDbBJWN+eCE4n1bdpH
	6FNfyitSAy+Gm1ZZ7alCfLSbjmnLtCEGKq8/3/6ZtgcCSquFVpSsgOVvNNFkxqQEhfqLR4kznJG
	o
X-Google-Smtp-Source: AGHT+IFbi8zCojc0hXpPwrCeJZ6NA/hICMIw0NTTwFlUekhg+/Yv1Q3KWzFPiAOmxPT62+khXsd5eQ==
X-Received: by 2002:a5d:6743:0:b0:37d:453f:4469 with SMTP id ffacd0b85a97d-37ef214d2c3mr703685f8f.22.1729564557674;
        Mon, 21 Oct 2024 19:35:57 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef181e2sm32704715ad.114.2024.10.21.19.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 19:35:57 -0700 (PDT)
Message-ID: <52d9adb4-8917-40fa-968a-d55845320ad5@suse.com>
Date: Tue, 22 Oct 2024 13:05:53 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: convert btrfs_buffered_write() to folio
 interface
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1728532438.git.wqu@suse.com>
 <20241022011734.GB31418@twin.jikos.cz>
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
In-Reply-To: <20241022011734.GB31418@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/22 11:47, David Sterba 写道:
> On Thu, Oct 10, 2024 at 03:16:11PM +1030, Qu Wenruo wrote:
>> Inspired by generic_perform_write(), convert btrfs_buffered_write() to
>> go a page-by-page iteration, then convert it to use folio interface.
>>
>> This should provide the basis for use to go
>> address_operations->write_begin() and write_end() callbacks.
>>
>> There is a tiny timing change.
>> Before this patchset we wait for the page writeback after we get an
>> uptodate or no need to read the page.
>>
>> But now we follow the regular FGP_WRITEBEGIN, which implies FGP_STABLE
>> and will wait for writeback before reading the page.
>>
>> Qu Wenruo (2):
>>    btrfs: make buffered write to copy one page a time
>>    btrfs: convert btrfs_buffered_write() to use folio interface
> 
> So this is another step towards folios, ok. The first patch got a LKP
> bot report about performance degradataion due to the change from
> multiple pages to per page loop, but you mention that. The drop is 16%,
> that's not something that we should ignore. It was for one workload so
> this is mabye acceptable.

The performance drop in fact is larger than my expectation, and affects 
quite some benchmarks, thus I'm not in a rush to push it for upstream 
anytime soon.

> 
> Another thing is that how it's changed to the write begin/end, I don't
> understand this enough to give it a yes/no.

It's only one step towards that interface, and there are still quite 
some work left.

And the change to write_begin/end interface is not high on my to-do list.

> Also this is the buffered
> write so quite fundamental file operation. I've had the patches in
> misc-next (and in linux-next) for some time, so we have some testing. I
> hope we get more reviews too. We're now in rc4, so it's about the time
> to get it in or delay until the next cycle if there are doubts.
> 
> Regarding the patches, I have only style comments, you touch a lot of
> code that is not changed often so it would be good to fix the style of
> code or comments but correctness comes first so this can be fixed later,
> I'd really like to be sure this is safe.
> 
> My suggestion is to add the patches to for-next, we'll have enough time
> to catch problems and expose the new code to more testing environments.

OK, I can do the push, but if anyone hits any functional problems I'll 
be more than happier to revert/remove them immediately.

Thanks,
Qu

