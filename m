Return-Path: <linux-btrfs+bounces-16878-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5BBB7D321
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508CB18960D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Sep 2025 07:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D382F3606;
	Wed, 17 Sep 2025 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dhPklKpc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B2B2D0C6C
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758094300; cv=none; b=WGZtiMlRvJePyViq6VjbhVN15fMif1jZxQgAH7ZB4MmoAgT+Pay9+TR8GqqkDC4XZEVG0+Xmd6d5kKEedOqSLmPiXWoahUCiMN96Fsa5TCA5VYVb+vb7wY8FJAP6xo1CXRVNCMSfAKexNvR8Gw6dWzZx0SGyT2eRFRnsPM9DTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758094300; c=relaxed/simple;
	bh=cpMacGZyl7DyrxAe2yL4YWA9T1hiB7Sse3O/4tjV8j4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=UOpPlbAxWnXUPkx3oZC2oHbJ6nLuRwOWKOPuIHslqunlfP3DWgJkLJJ32JgGoaMJsynggHc3zoS9yBQfxF8YF8BbOFE/5obTMWDazIkBp+U79XkR0dUXGlqrWNTsTVAuit5pR9eICtjGcp8AxzE5wBYJSA5z/0I/Tlze2h2q1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dhPklKpc; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso251156f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Sep 2025 00:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758094296; x=1758699096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGpRJK4G5DhLJ4IdnzXX1HWSDD3wl7sNKdBS080icSY=;
        b=dhPklKpcZA8TH7ZX3dCG+/aGGblF7qctgbsNh7I9lCxLk1bayWp/hXCoyca3+B1Aio
         5IKkcFCpz1QDlyEXjOnmvBaAVj4HrZPzIVQQIVhbWif5NWjnQu/tfwdhLc3g6S03KELK
         Qv140CCp4Y0Q0pekiSouEi3aGgnCSROK4yLnkJFeZ5NdsI/zHKT+9srQEuKZjzIuNWOs
         eO0PjtITT+wQP5z8NBDi9HEURZCuB3AaFEZNB/IEck9fJiJ+dIN7hFI+bLfzt6aaXfi+
         YjjqvyJO4MgDyL93q5QkNjjUdIhTPGgOdlpjFtM7jBiWxUhaBe3E56mRb4MAzah/dGBE
         JTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758094296; x=1758699096;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGpRJK4G5DhLJ4IdnzXX1HWSDD3wl7sNKdBS080icSY=;
        b=uw8eXYXROMQbiCc7zXqhPoUPWpcZuyD8ubwfIbcUbcMvQQOQopT+sAbxDaItED+U/W
         Xn7g4rZ4w/T4nXPxMI8QEQ15/ApImmovIPUtShz8PouQDNDdhV6XP5XYF7xiZz0P4kX0
         /IlFpOvkk+5iEI9OvvXqGVCStgwZWeEUDCwK4sld5NJu0L3qOeBrGQ24ZMmq4M1/ZRlL
         giRSNXEKadQ0+XpWkEF60UfAr34s8iL1cvwhEnHM8SxB2IG1FVUIgmUQb7w+FlKMglc5
         MCQjxKdMqROEBvv4u0TlmhMu9H1owyxCzTMMJLsPg7r5nLqP1s1MPpM+rrCKIFFVEjyz
         dnyQ==
X-Gm-Message-State: AOJu0Yw6faDYux26c/wK8+iIOw7w7viMczG8JsIiu1YrGC/e5TWBPfpH
	d3LQ5XneQodVAbAuBU0tWBFek6leB5L/4DjMLRvIV6+bLaWohjp+fQkEGkSwBu06efqwDKjTPEM
	XC+Mc
X-Gm-Gg: ASbGncu9vR3R7vL9EWqooONaNkBtsys7xIFYac7vxIwlFtzgjqlTvL7eCQJLGT4fZl1
	gv5hJH1xknDdHo+EpMsmaBPCP1x/Y2WJheYpjRq0AqSUZIhl+lE+evMQ73uEHQneuefJNtMlEew
	SN1fS/GLVQcgMmqPosSlbpkKaPMWY17EXpDXKIe4QjvMpZPnBtfZq2xL8ARgUlDB6dCb1u1EPsc
	v6erEJimZQNIWmNLW/4NR0Uo/kUyXVgieRPLxTrkqnrvB25izJ8SXODia9RlG78ydEzmYJ05eV5
	ZZaVXPRQ/BLQgquYzwzgCjL0fAimoGnRCNM17Txqm+sQsYKVH29K47kJhZPizu5lp2A9lcFChIl
	BP6QjFXaGzt5/67iW72YtZj2tax+YFvuduVu+BV6Q+wlPv3O55uAzEyr0rr7gGw==
X-Google-Smtp-Source: AGHT+IHO0mSIj4aVMoVC77tUNKb8Td2LloBDG8zf+reHTqWx63ycKPjZ5r5wDYs1VyP17vfXBhSGxQ==
X-Received: by 2002:a5d:64e5:0:b0:3eb:ad27:9802 with SMTP id ffacd0b85a97d-3ec9d70e1d9mr3935307f8f.2.1758094296136;
        Wed, 17 Sep 2025 00:31:36 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33046a4d0basm139768a91.27.2025.09.17.00.31.34
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 00:31:35 -0700 (PDT)
Message-ID: <2d157281-9c70-4fe3-9205-431c3420df40@suse.com>
Date: Wed, 17 Sep 2025 17:01:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] btrfs: prepare raid56 and scrub to support bs > ps
 cases
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
References: <cover.1757649253.git.wqu@suse.com>
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
In-Reply-To: <cover.1757649253.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/12 13:29, Qu Wenruo 写道:
> After the previous compression bs > ps preparation, this series focus on
> raid56 and scrub.
> 
> Both raid56 and scrub are using a page array storing their stripes.
> 
> Thankfully both are already using physical memory addresses for checksum
> calculation, thus there are no internal code to do the checksum
> handling.
> 
> Just convert the involved arraies (and some RAID56 internal page related
> members) to folio arraies will handle most thing properly.
> 
> Now the remaining code is mostly encoded write, which shares some
> infrastructure with send, which makes the conversion more complex than I
> thought.

Please drop the series.

The scrub part is fine, but the RAID56 shouldn't migrate to the 
mandatory large folios.

Currently we're relying on minimal folio size for filemap, but in the 
future direct IO will pass folios that are not meeting our minimal order.

If we force RAID56 to use large folios, it will need to revert back to 
the current page based solution to support direct IO again.

For now, I'll just disable RAID56 for bs > ps support.

Thanks,
Qu

> 
> Qu Wenruo (2):
>    btrfs: prepare raid56 to support bs > ps cases
>    btrfs: prepare scrub to support bs > ps cases
> 
>   fs/btrfs/misc.h   |   5 ++
>   fs/btrfs/raid56.c | 180 +++++++++++++++++++++++-----------------------
>   fs/btrfs/raid56.h |  26 ++++---
>   fs/btrfs/scrub.c  |  51 +++++++------
>   4 files changed, 142 insertions(+), 120 deletions(-)
> 


