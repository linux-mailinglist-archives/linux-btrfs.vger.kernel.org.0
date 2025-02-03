Return-Path: <linux-btrfs+bounces-11231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F1EA254E3
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 09:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68EB3A5224
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16361FE466;
	Mon,  3 Feb 2025 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WkAUYlYA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65871FC0FB
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738572679; cv=none; b=LKwkLwScHl1h0ZuTF7KDWNhYJcwEJ8P5xy4jFw80ZDuWLVpcBNDvn5+Mb57LFdZzZNmQSYQxguugdr52NepxNmj4YWXswX+guMVQ+b/pIjtxRXRCNT0H7OLMKvydttG4GmfyUkl0rT1OZ3i1jxlySZE+Cb9q91PmvJH9Uh1Txds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738572679; c=relaxed/simple;
	bh=tQZM/at0IwkBGu/z0+Yi6qxJcakksxHqjn4IkzJD7Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M8BrdcqyEMLVWJV+K8qz7oIDPruRgxSEGbFORFPeE6JfGUAfAIMrXz9m3RPFwf0R6l9wCU5vmznIroRT/WghM11LCVcxniSw4P5bfhFMBvCvOewGlB995ogPPA1WMt9U4CuP3297Jw5AC/RQM3Jt9bWdH6JQIOK3Zp0K+EzNfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WkAUYlYA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862f32a33eso1783266f8f.3
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2025 00:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738572675; x=1739177475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yuh1Y2aj/w3XNQwubD+Q5fCshIpTUv/N/3WlT+4cPKM=;
        b=WkAUYlYAKJgnJLp+G1EoOwyVbmW3Bh2FkD4BDWnlilzhYeSTIPbtG/uMvQNmHr8rlS
         /oefGnt9skULx/Hc2Zw56sKLpAM/iOUI5cA30UbQ1WxV5gpWFkUDmMV3nEukNZ4wf/Dz
         1PcMBsMr7l4c8qTY4fKg+5i32pokJuFdVqxxYC1cI1PkfJnVSz/gOXy3OnDb1iucd9zc
         Lm9990bBu6PhBu3G7HcMsn6nPNy1pGsGsqVl4UjaQr2fz+A90MtixLr+9tp/pwJU9j+d
         I0XI+ds0/uEZK261Y+A3i/AfLdQguzLgPOAT4XOlIfrpJq5RVCgM2dueqf567P2Hb0r9
         fWZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738572675; x=1739177475;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuh1Y2aj/w3XNQwubD+Q5fCshIpTUv/N/3WlT+4cPKM=;
        b=O32xV4CxRiTDcudFC+AQl3MHHvADy4EUzPlaA0hSgzFU8bOMgKmgQms5FUkL3yBTSG
         ryiogjNshfUJ5aNvvQ5iTU6xo4sbbsNrFtcymc39FHfXgelXRNtteYUCfgGPQGrI22oF
         z+GSoWB2FNnFGGliihF4SjvWUoBT3Oya5ZZz3eMuKll8M3gPpEPtMz3zxXrYFtt5XhmF
         A+eGLCfiVyFxaJMFaGaRMn9Stvmo8Giir7WYks2lHuUqhvJTze2e5YIw4+kgteVfx4kV
         RgKk6ZzCqFjX63DsNA0m2BT6ds3NetjPsWZPkKKmPfCSxagjbBUcjyC47DqF8YNI5QEg
         KxpA==
X-Forwarded-Encrypted: i=1; AJvYcCUykE/3C1oOOibAdKPCoqtKfrB15rAHB298zqC7/9/bEQ4bkE3CZu52kBR+vlWIYaF/5Wk1UWlyQE2vpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoam+qsjS1OxpM3LByjYElWA2wcQsN+8V9jPWFLpuVd4uLWOTa
	eOtWt7zT7yWX41WpvMuR5Ra+MJRV9K43bfuLxeXTHtoz2BsQvRYlyQNnS/FG1h4=
X-Gm-Gg: ASbGncusSJQweRv0Yt5luLBJEn+DNvkY25jWycQgpe6evYfdVSKaLgbpvh6+42IXNZe
	mpXJx21z5uOUu5cj+KKduMmDX95lzlpxiPmqpjaeW1Nho+3nafjw9J2kXw6lyqWS7tKh4S483MR
	Vtqveons/9v4RZ212XRFH5wC17eRSXuAJHu5XQmyYNjJfizTd1qGlMjVj0UQfbRmL7k6Ot86Ade
	bqay5Aku7RcWo3ZENlzqc3pURSQveXJVrb4K3WW/LRWuntvzJRnJO9NYRmqZkaArGQa9agMmqwX
	qwfJZDORThrAHhY6ErI30kuQ8/pBE/xmn9o9/6kjjdw=
X-Google-Smtp-Source: AGHT+IEWYQIsW4byeRku5mnmhA2UC6HmLVZIhKFc/Af14p4WumqMTRj11XeXCHIL2Pg9mxDA3GTgDg==
X-Received: by 2002:a05:6000:1562:b0:38c:1270:f964 with SMTP id ffacd0b85a97d-38c52097624mr16090182f8f.47.1738572674853;
        Mon, 03 Feb 2025 00:51:14 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::e9d? (2403-580d-fda1--e9d.ip6.aussiebb.net. [2403:580d:fda1::e9d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d42a0sm8321604a91.25.2025.02.03.00.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 00:51:14 -0800 (PST)
Message-ID: <26a5ee76-3e5c-441d-b335-41ee4c879e0e@suse.com>
Date: Mon, 3 Feb 2025 19:21:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: "hch@infradead.org" <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <Z6B9uSTQK8s-i9TM@casper.infradead.org> <Z6B-luT-CzxyDGft@infradead.org>
 <efcb712d-15f9-49ab-806d-a924a614034f@suse.com>
 <Z6CA9sDUZ_nDj5LD@infradead.org>
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
In-Reply-To: <Z6CA9sDUZ_nDj5LD@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/3 19:10, hch@infradead.org 写道:
> On Mon, Feb 03, 2025 at 07:06:15PM +1030, Qu Wenruo wrote:
>> Thus my current plan to fix it is to make btrfs to skip csum for direct IO.
>> This will make btrfs to align with EXT4/XFS behavior, without the complex
>> AS_STABLE_FLAGS passing (and there is no way for user space to probe that
>> flag IIRC).
>>
>> But that will break the current per-inode level NODATASUM setting, and will
>> cause some incompatibility (a new incompat flag needed, extra handling if no
>> data csum found, extra fsck support etc).
> 
> I don't think simply removing the checksums when using direct I/O is
> a good idea as it unexpectedly reduces the protection envelope.  The
> best (or least bad) fix would be to simply not support actually direct
> I/O without NODATASUM and fall back to buffered I/O (preferably the new
> uncached variant from Jens) unless explicitly overridden.
> 

That always falling-back-to-buffered-IO sounds pretty good.
(For NODATASUM inodes, we do not need to fallback though).

The only concern is performance.
I guess even for the uncached write it still involves some extra folio 
copy, thus not completely the same performance level of direct IO?

And always falling back (for inodes with datacsum) may also sound a 
little overkilled.
If the program is properly coded, and no contents change halfway, we 
always pay the performance penalty but without really any extra benefit.

I guess it really depends on the performance of uncached writes.
(And I really hope it's not obviously slower than direct IO)

Thanks,
Qu

