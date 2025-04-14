Return-Path: <linux-btrfs+bounces-12981-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6A8A878B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 09:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1D1E188CA07
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Apr 2025 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FCE2580E1;
	Mon, 14 Apr 2025 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AQgk6L+5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F14E2580D1
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 07:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744615634; cv=none; b=qTHbEx/VuBgkd1LYcehHORz5TNLobREWgzk21JTMCVaZGLftHeDaAvRXOxYCxMzuOHGMjhDeI8wqfIvpWIgExduQCA6ZAVeMNloI/o7YEZbXvNdjVZcVWrI3G3qU64aZ+gesEeT4kzrTbWhp7HoBDdfL12QPz5RSal/rq7mfyAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744615634; c=relaxed/simple;
	bh=2j7orh8F0LYu2YgFsjD6FQoC7JsFVCtqI4cl9/VKunA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kLZyPYe3WlUhH8hWe1FSkf9t+L6DxIhg8FM1cia2PzORJ42B0+Knphz+frs5V+4cKWYF4KWcP4qH15eVW8BeQH7E3M4mnDVOXe0MAvDFFvP1PHFYaRaZ38FSdbF9oF+lQfjGeJYQAXbAAhtUyn7Y/q8OE1PSVbENWOyp1Q0aoQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AQgk6L+5; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1efc457bso2522153f8f.2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Apr 2025 00:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1744615631; x=1745220431; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j+fBl/g7LF5eJvquVdvPpK3heybbZ5fMQhhEuUNZiT0=;
        b=AQgk6L+5iQqqv5q9s/s0RMTwcSOHwSl0cPCVGwHH/LfD1enMPIyEVIzGFecAlbrU7d
         v/2DxpSLTCPU1C8K54cslIO5cxWjWBROUrsBX3DhXBXEBI7KtiAKlCw4R2SUddHk1Hxh
         1wY/yz4ud0p7jCI52NVYrkernZXuL4daw1vibJ9kxd4EeKhnMAmb7HdOmDlQ7j2QwIYS
         xHoOLwHnf2NcOK/2zFkB6ubACl/L0j46M2C1kSvZDAZDHorM2PKtomxLAMXRHtWlgwuO
         O1P7zhrT6KfMZl93oEq+7tk0uu2WWSEQ4lEKTx/hUvQFggyiaH+am7DAOGId9bVX56KM
         voOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744615631; x=1745220431;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+fBl/g7LF5eJvquVdvPpK3heybbZ5fMQhhEuUNZiT0=;
        b=xNrfpS4dMsbVUPxpfWR0yqzzLvgMS/DIFqTlPNO72Z3bxVAvg1YTr8aO1B437fNbHp
         bbr7jN/sWmdRzuEu7tpUlTQLdfFYQ+KwVcElNYfH7KEIkdHb/fbc71W4WT6HuaFMB4HL
         hntf8D3Ki0AIhNhbw2RRgzRtousaWUwqHtxongoVRkVmoBA4hzDSOYe0zqiGZGQsrByr
         d6/4vajBImaoH9JwC/4k/Oq4LE6zRW0EGvyFRqzYNmgIQhNS5mH5Ff2kv2oijROQhu2E
         8yWueEIM55TLRyWC4Pj2GppKpNaxIt8XSA5g0LkDLjmTGAQNvFmec+rVot8WpJl3Rua2
         uLiA==
X-Gm-Message-State: AOJu0YzMbck1KtiX0R2XFo4CqqNoGTsKlJ9xynJ3Wt4TUQDpildQiZ3w
	J75WHts2+0ow6Z4niZAF2PGvgvfjPjOaDibxi+PBQveOkXW/Fd/xpqovKXk+HFkcGv0dkTrJlUk
	2
X-Gm-Gg: ASbGncuTTUjIwMKNfLy1Oz8gV1vonslT2CtvWr+6pUtG2zE6tmoFBHqOtbHjwtGvjRd
	I8ArSzXwCGtpWlGroi7jhTTOrXZpqC2cWiN1ZBZKLFcZeS2KLCgcVT0mhQgdXET4M0XW/8Q3v3L
	6ugniDVce4+YMmHs8YvN334L90t85cvMlNNj4h+i0QK+8oV5oIhn6C/iSMoa6blo/vWuDDNeOg6
	DihvawOXbUt92ocPUdqCgepVA41NjHzc98crGxnMY1zaJ1RYZysxOYFB4brbzhHYn4riDvEQ120
	DQwZtcCYqs1U7S2D7fuikgJeKF4k6NPkeK4Srp+6Omh4a/BC+Y8uCoMy07PAcI5dJu6N
X-Google-Smtp-Source: AGHT+IGRGTcP4ZVqM6HKrBulOD+oQuJWkqhFFwq9VkE7FdpqTExmwebDjPMS/Cw3ddJfKOM3GsxlNQ==
X-Received: by 2002:a05:6000:400d:b0:392:c64:9aef with SMTP id ffacd0b85a97d-39ea52009camr7672012f8f.20.1744615630522;
        Mon, 14 Apr 2025 00:27:10 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8afc6sm93099235ad.68.2025.04.14.00.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 00:27:10 -0700 (PDT)
Message-ID: <96b7ef66-3b13-423b-9bed-14d3a2236f5d@suse.com>
Date: Mon, 14 Apr 2025 16:57:06 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [xfstests generic/619] hang on aarch64 with btrfs
To: Zorro Lang <zlang@redhat.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250413125349.w5jxnnphr7wliib5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <17cd9240-99eb-49e1-8843-0a80a18f8ac2@suse.com>
 <20250414042322.ehea2rb5g5bo34zq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <31bd0214-955a-49a9-a4ae-f102044fcbdc@gmx.com>
 <20250414052259.ldxjeiamj2l23bwc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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
In-Reply-To: <20250414052259.ldxjeiamj2l23bwc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/14 14:52, Zorro Lang 写道:
[...]
>>
>>> The whole config file is large, I paste it at the end of this email (hope it's
>>> not out of the size limitation:)
>>
>> I'll try to reproduce it on aarch64 with 4K page size.
> 
> Thanks, I'll keep testing on latest mainline linux, to check if this issue
> is still there.

This may not sound good, as I ran 64 runs of generic/619 in a row, 
upstream master branch (-rc2), aarch64 4K page size, no hang triggered.

Each one takes around 10~15 seconds to finish.


Not sure if it's related, but the host names looks like it may be a 
baremetal nvidia machine with fstests running on a physical partition?

I do not have a good experience in the Xavier days, but maybe you can 
try to reproduce it inside an aarch64 VM on that machine.
It may reduce the variables caused by the baremetal hardware.
(But my bad experience was exactly unacceptable VM performance on Xavier 
boards)


Maybe you can finetune `kernel.hung_task_timeout_secs` to a smaller 
value and enable `kernel.hung_task_panic` to catch the stack more 
automatically.

But my personal experience is, a much lower timeout (even 90s) for hung 
tasks can cause some false alerts, thus may not help much.

Thanks,
Qu

