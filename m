Return-Path: <linux-btrfs+bounces-14641-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25675AD88A7
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 12:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE2B7AB77A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 10:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B0C2C1592;
	Fri, 13 Jun 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BhlcFkmE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851382DA748
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 10:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808902; cv=none; b=cRROb+gg2BeovpoY9+9di0sMoESVr3nMr91LZf1HPrTP9HWDw0GumTy5imTdybhUPme4OCIT3EqKnJ0rzQGI/rrRGMj327IonSDgg3otDlJHRAf5bkSnBKQyp2MMbbRjOA9U9yjD++UKrP6kNU7XBZZ8P+5TvxtLsbXw7EBUazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808902; c=relaxed/simple;
	bh=tmsqdQtgjepeWKrGm1DreHocb1zURRXk1MQFWonW3V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LfZY48k+xblrAoc9WgNjw9H0V6YJCtLQr/lTYj2wpgCD6JSgHluXkLXGXyWC/Pst4oXQhixPp+uXSFragCg8uQqKyss9pU9zuQsyaQwgw6zjPbKTJ9rwXBv8FoL+y3XbSn4KkVX5t3/Q5sRGwV5nnjCbEVTRolb5D2J7D61SOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BhlcFkmE; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-adb2e9fd208so381344866b.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749808899; x=1750413699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dbqz6Mwv6M5IcjsMHdUEfXrWrtHv9zQC+F8KuP4fr/k=;
        b=BhlcFkmEsbIjM4u1hwuFoA57s5qYBHGR2IJ/OjGlbxYy3sMbqqUll6HSDlEuRSz6U/
         9p/lvQwey+/oAGsEYm5kADEMtPpdnrZ5c4EyzuJHACOaVRBfpWIMvm5UBqYIN40RzTZQ
         wCOFzSl4OWPl5Ct4QLe9oHp+hwT18eWnJtSbdAvH6QJVfbz6t8MhROsr64W9AmwkxFF/
         UBFvwqJBy+liStNDcw2tQV95c0QwIiQnPR4eUTgEy5tm9bQms6nUJEWZLY9UoWUqN4ap
         7Yd9WWoKFFyTGo4qhg9xGm//XYlpEoS5y1CUwROHhUEIUxX8zBvYblHjt6cg2vya2KZg
         mM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749808899; x=1750413699;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dbqz6Mwv6M5IcjsMHdUEfXrWrtHv9zQC+F8KuP4fr/k=;
        b=rCw/5CCqtTCPt8XkOAhvrXfsxLJjCVrDmqQsbt5pDtG3X3HzE+Ttxyv3Ln3IPWPo4W
         wLFXm5CVMMrXF/PQ0cZfRpBH1JmdkTI4wBaBY3qToWvgsmAd8EcK9SJyuPd19X7qm5fi
         ym5EI/G5sYzg6m7XU5lLaUXdmp/QXkHFJtsycooqsVaR8n49XUOf+bPEfRRfYQlNr9Xc
         pmw2E1Ls2NB0BfB2QGVMYyIDqWOEo/WPjrYHHepSNpzC2jqwyb+c9tdXOP4nFRwjbrol
         TsU+bCRcQy2BKzyodmX2IDp+W1kgo8oSg0baZ5jLnStTeqzFvlRcg/o29IY+wnXkki8X
         RZsA==
X-Forwarded-Encrypted: i=1; AJvYcCXV9UgkA6iesrJ6pvERo2AKrQZSTSewAgqHk+3gUWW7Z0C84fhSup0SF9rFHzmqfc/iKd2ItJ5aLbTcUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YziFLJeQu2IU9K5Zyko4V8wAlPWf6Hx0J4lJCm8BHwU2QOMHn4y
	VabTln2F5NC1WWuRq4/I4oNhBiTdoUUg+EZEEcUKf+5xHwks2G/as59BaAQ6lfKntME=
X-Gm-Gg: ASbGncv7aA+ea4TVhZ4fbaeHfUhkGRvbclmNfkbmDW1lqykAmmzcckwEqBIqkLZrxXe
	jT8pSCjKRNLJ90odEbES7NyRdg1anL/ZkzQ63AIztT49Xi+wGYjfiw9oP7G70ZT/1ewm3BJLEb0
	pnMxPuLe40BNz9Gh5UNBZ9LZrpzqJRgVr5OEi17bamh278IfKaZFwWd0TiMR7agGYJQv5kk6vyI
	1BK6oh6wdY/nWHuYKtaHDmiXEyKKtjNQcjyUaltesbHLxhOY0SFIoj4idKBoYDPhcLdX26tt7sG
	ae2VGYq4y9Ng3JVRI4dbi3QPJVP6QrpxzVcJ1Kl+xjW94zo+zb85WC3i/tua9FyxC7hpndWo+4J
	HR4Kh8jTk7RK1hw==
X-Google-Smtp-Source: AGHT+IHy3osXMwoQ6vZ592ZI/tePCC6u+NdKCJ/pqy7ctchQgtNmDrfSVfHIftFam0cpLjobkvZFkQ==
X-Received: by 2002:a17:906:dc94:b0:ad5:55db:e411 with SMTP id a640c23a62f3a-adec5bc8393mr222504066b.27.1749808898341;
        Fri, 13 Jun 2025 03:01:38 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de781c7sm10736325ad.128.2025.06.13.03.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 03:01:37 -0700 (PDT)
Message-ID: <b673bc6a-296b-418c-b20f-9cab6345131e@suse.com>
Date: Fri, 13 Jun 2025 19:31:34 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Stuck in CHANGING_BG_TREE state after interrupted btrfstune
 --convert-to-block-group-tree
To: Tine Mezgec <tine.mezgec@gmail.com>, linux-btrfs@vger.kernel.org
References: <a90b9418-48e8-47bf-8ec0-dd377a7c1f4e@gmail.com>
 <d57e673e-f894-48cc-8b34-c3754fa23b70@suse.com>
 <e264b3d7-1242-4470-8a5c-805e29911390@gmail.com>
 <99814fd5-3f80-4d08-af7e-468f7c8885df@suse.com>
 <38c007e1-fd3f-4f5c-9f54-ad380d7071ad@gmail.com>
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
In-Reply-To: <38c007e1-fd3f-4f5c-9f54-ad380d7071ad@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/13 19:01, Tine Mezgec 写道:
> Hi Qu,
> 
> Your patch did the trick, the conversion completed cleanly, the 
> CHANGING_BG_TREE flag is gone, and the incompat BG_TREE bit is now set. 
> Mounting the 11‑device volume takes ~5 seconds instead of several 
> minutes, so everything is back to normal or even better than before.
> 
> Thanks a lot for the quick diagnosis and the fix.
> 
> One thought: the optimisation that skips the full extent‑tree scan 
> clearly helps in the common case, but when it backfires the only 
> recovery path is recompiling progs with a patch. Would it make sense to 
> expose a --full-scan (or --no-fast-scan) switch in btrfstune so an 
> interrupted conversion can be resumed with stock binaries?

No need for a new option, because it's definitely a bug, and a bug 
should and will be hunt down.

The only problem is, I still didn't get a full chain on why the last 
block group in the old tree is skipped.

The old code seems correct, but it isn't. I'll keep digging and send out 
a proper fix later.

Thanks,
Qu

> 
> Either way, I really appreciate the help.
> 
> Best regards,
> -Tine


