Return-Path: <linux-btrfs+bounces-19230-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F4C7672B
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 23:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id DCAAA2B7F3
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Nov 2025 21:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF66530B520;
	Thu, 20 Nov 2025 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="K0yiu0qc"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C617275844
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763675928; cv=none; b=Ah7L0xiDrVUEci6idpKKyWARD0SrWYtHjuixWsMdnhr8VV9soAg2jjKYoW89OwRsR75MAmfyaSfaJ/zZU0IfOrEwZatdw62hafxA7l6fxaFDsG8RHTMWeBkMHmj3Xc0kmLyU+2+8zMgr0dyO0JesUWP05TWMaGqIHNAGXrQPsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763675928; c=relaxed/simple;
	bh=XkqQKqdjbsDGit7r8PwSbQ1ITxH9cSx/AvqNbVgL654=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=l5d481fqGldN7Qea67Dc2EFpIz6TJ2HD7MoYQsspdQtoy7l3/V1hZbytqZTIlwfbTXawpQwvQtGTVngqEY5tswzo19kWnPzSVN6xauNfahwihHt8Vmy/aqRVEZhYVsYq4lf7sGZUsAEid/Sz6D3bNl1hKETrnM7RHZxZ9efGQpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=K0yiu0qc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso15057225e9.3
        for <linux-btrfs@vger.kernel.org>; Thu, 20 Nov 2025 13:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763675924; x=1764280724; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odrOFQz7SA7CqvpfhSgnCp8rueLsVlj4Xs2HgLIndY0=;
        b=K0yiu0qclIbR8xDzZR5YCuFtvn0Qaces8m5bg5+bZLKtSCRuwbJSVdxZ01kxwbH3Xq
         zmh1rQadCNjaC0UbpwpFECyR4Sbw+lKQoVrNmISNV43d7YHsO6riNf6U2ECxDv98FK2f
         y5JXjYu/MF3GTnMrQIrtkHTUOO1cm+EXFGu/n4GT8rVX6A/obKRQbeRthGmlk6Ocd2vE
         cULlCCKlfhWj95vuvS3Tm6nkRayDTiUyabZCs1v+a6EQk8ZxNrxI/bYY17O3k3haIJ3U
         xFMCZSciGtiAGsxY1z4Bkcx+OxHOJZHmXBZxoVcJl7wNpUl86ysQZ8RztdaKP8htvicJ
         Z6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763675924; x=1764280724;
        h=content-transfer-encoding:autocrypt:subject:from:content-language
         :to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odrOFQz7SA7CqvpfhSgnCp8rueLsVlj4Xs2HgLIndY0=;
        b=aODmxGyDEvaaSTWgYOXFJf9KHmvPqLHQMipCVYkzh7iLSCtjQYsovIQu7nhxyZLtdg
         3jQaMv7kCQIMwC6klCU6iByoVXkizwsSKoQhIE6MZaY824uskQ5bSU2QAEOGhMzRhnYH
         6f07IEeiKH3u7erZ821xpG8bm+4d8h8ZW3gFF3bZIpkPfCoIyg89JYCH4LV/IfpK5xGm
         EW1y5nW/DBB9r6mT9e7IYLwOGQalxnv/x59ZVact5hPHU/aEpv69Ig6GQL2gm7UQ+9pF
         4X600PlOkSXXpfbbXNtKEBJYOvXg439/3ooTBCyF67lodvgvDpCjljpzHbPHmhLwZ1uN
         CsBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUoVrGnlXjEq3Gf3hVRbvqrTn2wtpNqqmRYoSPMtJnbYrrhvP9s2LLP1NYXoCqXvdowPgjjD0+ypxHPQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3UWazoQKfbCkO3G3zLs7k42bF9apBa5q+jTOTe+rgAD6mFJA0
	EOHt4U3Sth0IVCIfXZUJw/V2YBXr/8rYTMYUe4ujM2LwAnEEd0qhoBjYm4OBx+LyekE=
X-Gm-Gg: ASbGncuOUEGDNAZIUMdJaVjc3kYN9cN9609G+CTOjMuqcdi7RDFmqAPbd9iRnIk6+cW
	spY3vuOpRGMm2aT1gwW25CqrrCUPyiftaMAgHatiwt+88EQzrRNIP8v//bMuTYqiljpkvRecd1j
	KJTlIVvUn3MvprMtoMahR2he8YNhUwmOKQXlErIQzdofrXnFSb4OGNyLLwyb9iDg48IIqbSLr2p
	9SWESybAhTKtClsk2rmH/tQs5kmYw2KKnAdjsfyDKWsbXaxGBxn+OZ6Ce3Rn8LNAAZeHhmrK8sA
	pKXJF/d8lJX5cTqSCpagTrnsYMDO9ssKsjunqeo1ivev091vl4JFQxrmk8S+ZpmRywBbtFMHQ5P
	qzl6KNs4gD5/Mm+Q288tOFXWbADY7ZpGtt0ojuDw/v9SL01ezmf4mqnVGO6kW2lwSw8aLWoBgMc
	7BPSQaDFs8SD5LKpyWm9lI91r7HSr8cFChfkiiWLc=
X-Google-Smtp-Source: AGHT+IGWFAtqLbFkh6zdSpivlG0zW6mgA2/Oc7afE8qcU2ureWlzGu+bD8EkcyUbHSjDAB1s3Pn4OA==
X-Received: by 2002:a05:600c:1f0f:b0:477:fcb:2267 with SMTP id 5b1f17b1804b1-477c0163336mr2047995e9.8.1763675924328;
        Thu, 20 Nov 2025 13:58:44 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345af1ed1e7sm4904088a91.1.2025.11.20.13.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 13:58:43 -0800 (PST)
Message-ID: <48a91ada-c413-492f-86a4-483355392d98@suse.com>
Date: Fri, 21 Nov 2025 08:28:38 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-crypto@vger.kernel.org, linux-btrfs <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Daniel Vacek <neelx@suse.com>, Josef Bacik <josef@toxicpanda.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Subject: Questions about encryption and (possibly weak) checksum
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Recently Daniel is reviving the fscrypt support for btrfs, and one thing 
caught my attention, related the sequence of encryption and checksum.

What is the preferred order between encryption and (possibly weak) checksum?

The original patchset implies checksum-then-encrypt, which follows what 
ext4 is doing when both verity and fscrypt are involved.


But on the other hand, btrfs' default checksum (CRC32C) is definitely 
not a cryptography level HMAC, it's mostly for btrfs to detect incorrect 
content from the storage and switch to another mirror.

Furthermore, for compression, btrfs follows the idea of 
compress-then-checksum, thus to me the idea of encrypt-then-checksum 
looks more straightforward, and easier to implement.

Finally, the btrfs checksum itself is not encrypted (at least for now), 
meaning the checksum is exposed for any one to modify as long as they 
understand how to re-calculate the checksum of the metadata.


So my question here is:

- Is there any preferred sequence between encryption and checksum?

- Will a weak checksum (CRC32C) introduce any extra attack vector?

Thanks,
Qu

