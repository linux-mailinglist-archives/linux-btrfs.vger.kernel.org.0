Return-Path: <linux-btrfs+bounces-18343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB78C0B40F
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 22:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 351734E38A8
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Oct 2025 21:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8EB273D77;
	Sun, 26 Oct 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ASAkaE9m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B6227EA4
	for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 21:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761513420; cv=none; b=q+4D5tilimBHG5KykgdAtVX8DX92bYTQVWXuWfsokrS3YwzIkGk8DKBllG4h780HYN+8qs7QA0QwF0E4KkNCyWxLNcDGshq/IQwjM0HepkQY8NdvhNW1gPgT3QJmqmrSvlLNpb0F0Yl82YQ8csge9ZQH9L5g0J8HvfOlxae9aI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761513420; c=relaxed/simple;
	bh=ljzlyZcuOIgTpxc/jYU3b9Q6LcTJ3SWQDzs1/nSCgBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dtAQxW6r7wpkPbfLxW726HTOcM4mLeZh/MxOgR06NliDaq3+H97Egxu6JmGBO5vWFlmdd7LJkxJAF6WLWZPhbfci7HbJOE9/d1xQDSFNA7AwpqRayFBFUk7xXHjt96nyfLYst46+U7sRJ+YfvF4gVEfnbW5ZaN7BtvteZHkVhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ASAkaE9m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47112edf9f7so22826375e9.0
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Oct 2025 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761513416; x=1762118216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oazE1q5GCoD/+i3icz1iycSEfrKFMjlb7/NDCvgd8fQ=;
        b=ASAkaE9m6QHDQaFu7+RfvvwiBulGYHouWsKXXRgGV/SvhbnhqPa/agJpnrzOIvbGcp
         +PgYHBIqmaDvkzptXAZo0U3vMk2hLn96J3kxJSwWKrcRVNHNeI+d55a6T+2fMeYCJwuU
         F+tSZod5JzmMj9ySCz3ySV+4YUCXaXvwkiaQbENWlBc7cCsmW+lRCjm3NwPegZWOAiJO
         gA2bqnPWnBCI7suZ9Hw3S2fVc0szwpPerYBWPiBtrOm/idtAKjrerTxiLz76YoKOyx+H
         wXpbTGikuW2I2ytOyuMi+4mNH891SmaVCmK/xC/7VHISScHV14zqxsH8EWDBoENkcGAH
         Zzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761513416; x=1762118216;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oazE1q5GCoD/+i3icz1iycSEfrKFMjlb7/NDCvgd8fQ=;
        b=V9TUEx3R6VsBsgHTD7HnaXltdCpjAg7e2vasPHk4+CbKxHlj30hXbMynfOTrzEE0cn
         EX+J2BAuBM9ft5FvNtkxMX8NnkIewQMzl3T75j061J3rizBrFH9khG3gMgdBTLGWmzou
         boV8cstuARPCYuKdyzwQdFfvNQf9z/YT6d0WBY7x3OGNvjyaql5+5QDrl5GLg6Y/ia+0
         ghgzok1ZfkT/wmxr1gXURsvaCL+GuvIR/wYEEkaFs+IrQAhB4gF5UGTUs0IJYEvczYjD
         J5EqKFUcmjc0Lt070SjizFC8n8hNzUwX+sYNNWSU0P4H7hzzynuGoppHSBl8lzxYfzal
         1AHA==
X-Forwarded-Encrypted: i=1; AJvYcCVrp04El7zSaLA9WjF6FUAZlnMBhpN11XFQEp38c/nR04CBGerwDAf3tAhR37JqN0ulVwXoJWOzzXqpIQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgsNVttx4cyoik1sXQRoCZ9xoFnIRpXR1rHg/6JdeQ/458E7S
	kasK8bxVTW0R1neju22hXYooFgMv1N6ojBP5oP7bKngcx5UHhkK0in9THI+cUk5ZPCxaQR/MpVt
	RzT3r
X-Gm-Gg: ASbGncsYgGSIEh4sDW9YB1MloFZUPSFanh0TDpUm3ksQkHMEeAPE81knqFtMvbN3d89
	WkaEyVpdVq/2I2GeBO4w1dgPVDKBqJzg+T/Qm67VbCZoOMoLtl4Mm8jktCaG/UlEkibSwvcq0Zz
	ECzyGs2PiJM7VpAoake0szg6GyTuFNsUZgrRF9TR+UjSY8WLx90pePeeACVKwWzhH6uEetvLkLe
	2zA5VWK3hcPFl9lJjc3tjSz0wSvyZad3thV0eIw1YMnhib3mo/GSMVcV9+2/IG03qgQkj5lIWLy
	2BJc/ZKMOBsV2uEPrkKzP4s/LEohMAgDpb3X9I0VVWhaY0lg9/fthsRIAFHxxvexZbf2VbVru1j
	qvsKgLq7gF8TU4mpz4sKw+vhEDh8gbLCQeuGi5OYqAZqR8PdxDIaiJWiNGbsl8EqUPqPHw0k+25
	alHuV4dRXNhWolOos4AX6I5serbTcR
X-Google-Smtp-Source: AGHT+IE0+kED1GkC99RD/pDA0q8Z+Xah2zsGX2ojoJIFAwrMjwJNhd1etc7hskktuJq6gex9seVD7Q==
X-Received: by 2002:a05:600c:3494:b0:477:bf0:b9da with SMTP id 5b1f17b1804b1-4770bf0c435mr23544365e9.19.1761513415953;
        Sun, 26 Oct 2025 14:16:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b712f0c1859sm5106893a12.35.2025.10.26.14.16.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 14:16:55 -0700 (PDT)
Message-ID: <0725451c-7354-4ac2-9bd5-e0487feb77c7@suse.com>
Date: Mon, 27 Oct 2025 07:46:51 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Strange btrfs error
To: Brent Belisle <brent.belisle@verizon.net>, linux-btrfs@vger.kernel.org
References: <c01bd806-9490-454b-b29d-61e5911b2483.ref@verizon.net>
 <c01bd806-9490-454b-b29d-61e5911b2483@verizon.net>
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
In-Reply-To: <c01bd806-9490-454b-b29d-61e5911b2483@verizon.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/27 00:59, Brent Belisle 写道:
> when I run a btrfs check on my file system using btrfs-progs 6.17-1 I 
> receive the following error "we have a spare info key for a block group 
> that doesn't exist" , however when I do the same btrfs check using 
> btrfs-progs 6.16-2 the operation completes and says "no errors".  Is 
> this just a bug or has btrfs-progs 6.17-1 really found an error in my 
> filesystem?

It's a known minor (aka doesn't really affect end users) bug in older 
mkfs, and the ability to detect is added in commit e2cf6a03796b 
("btrfs-progs: use btrfs_lookup_block_group() in 
check_free_space_tree()"), introduced in v6.16.1.

You don't need to repair (no repair support in btrfs-check yet) nor 
bother too much.
There will be a kernel fix that will automatically repair this on mount 
soon.

If you really want that minor problem to be gone as soon as possible, 
you can rebuild your free space tree by mounting with "-o 
free_space_tree,clear_cache", which will rebuild the free space tree at 
the first RW mount, which may take some time depending on the fs size.

Thanks,
Qu
> 
> Thanks for looking into this
> 
> 


