Return-Path: <linux-btrfs+bounces-11259-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B97A267BD
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2025 00:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9E43A5D10
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 23:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBFD2116E6;
	Mon,  3 Feb 2025 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IbxWm5ZX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796111FF60F
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 23:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738624651; cv=none; b=E/PyexwWvRSW20loYRlnXyJoU3B/nmwM3xJ0o2Y04slHEXYdB7135cQkWoyjiyxpRWaBzFIAjQlcNg5pmU0nVDlhhLacVAotPwWx1Smbi6fVroQekSvn8GQLCovg0XisIP4c1Z0ast0qByLVHZYncb0e9zw5w2Z6FIRM+rt44wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738624651; c=relaxed/simple;
	bh=ZfihIFeXaHAv+Yso24Hc+CVyQM0cZMIc4s4N+P02Xf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erAd96rqXTpHoY5uHrUI1L3d9IffmqH+6kNtaN6XEGiGQs3vXXX4H+PGUXFFMlvxyUKCaPeFYQBMtlgDrCbfKmEdDY8wYw0n4j1JYX1CZbyfFk6UMfyiAWi4pqQhjwM7lRXlUvBWkuI1qEDw4awjgOFaSs9J4vmn1/JUZzzfcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IbxWm5ZX; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so49921365e9.1
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2025 15:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1738624648; x=1739229448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M20UpxnCCjF4g6dYJIAZ+fZHXwpgnatL1DQuqP4O2ps=;
        b=IbxWm5ZXP6JlEa6U4bAS83UFKMgF+jCCfmtfAON8CdzPIqWBvj1CACz3HyLPSQM1M+
         iGgeYzGkQXq67BvEFQOSUAEPlPbrwvNJMRdL+vXf8qFlVNQcfcmX7EPJ5k/B1zaouGWD
         fi4FXq+sz99rm+vuXyy6trp4GTEyJVFhbuxkmwaeIAV1JgE3h9J5fPvpE4ZqIs0QL3Ep
         e7N9NclZWMp6Rtr2yrNM3ViceGrLxEhyFSsnNXiX8KEzbq/krnyg0XgARJz4VRdvALJ0
         VUnGDS990kjZUX9yO01q61hXuNY7TzqxFoJcQEwo1rZWE0IEZfjP2WkhkeqQ9Vdc5h7X
         hLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738624648; x=1739229448;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M20UpxnCCjF4g6dYJIAZ+fZHXwpgnatL1DQuqP4O2ps=;
        b=lXrEOGqfRRENyhAmoCnaFP+OQ2ScJWympOt0y1ELVIFCYfBQlVvBcimEpd7MYtCR9q
         RPbA6jn4ndtp/w0/MA0qoJDzJrwiuG0Wc7yN/TyXQ7fREnu3y+OLizliXlAuVYiqdbCS
         rdWU6a6yWCZ7zI0AcE+HRv9PGsydPmmEAJDBI2Dquo1Bh6/r/F7nLyC2sBfssHRxfEdw
         OgqhdiShA06RpCr1YR4iNfZs82XGpL48KWFp9t/E0d2hNxCvLUSFeAIJossrCqzlWscZ
         g8gT5/Wtvez7+P119zQab3KAMfOf7n/Y4a+NyGhKmRIZI2UboCWaEQy1peD6uhkk6cWc
         FyHg==
X-Forwarded-Encrypted: i=1; AJvYcCWC1qlrVz1Tu0jJxTKUJz/Q7RSr56LyWl3zd+VY6I3APFXBxbGkOKYPZtEl1M4DpNKcYHCs9LTHLkLagg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZSgT/fSvIskLbu3CBAJ/SOE+g1of1wKxyj9HPE+lo7+irPMs
	cWPbtBX0sqgR8A8wRMxpjndA+dVC6N45M05wXlpAfkUt4NAc4OGg3SUGfHQd/LI=
X-Gm-Gg: ASbGncuKpAAR+Ddi5W8QFlQA8WQ7v7mCkLrmNqcH9irKpXNmmb8mtze8L9iIwF35ETT
	sPcKTkp+16TGxuY0uO6uAbSB6O0p+txfJAeeOLve1DWaeBxuxjz0YBLjJsKuRGcD6qSzn0NBx6S
	iK0MSGoZKfTQruR+ShQj5mLsCDR3FNLvFhab+zPhgIUL4DnDqY6cDD5Nyy3afeDojvJt06+kQLq
	WQKCUquutqH2Fh4JRLjiguNjklU86uCJkAc877UFLaoB6VOOpqv8aDUl4AZBwElqTTunijacIGX
	7cEx+b80R0hWIrIKNM+IwBYwN+JGXsz7Uh1sEPXCizA=
X-Google-Smtp-Source: AGHT+IHKDskR6a298u6J7mhd/9DgYRSdntqz5BbexE9oUnoXAFWMJ9T+mniIRnDNpv7LfLg/ZQDLWg==
X-Received: by 2002:a5d:588d:0:b0:38a:68f4:66a2 with SMTP id ffacd0b85a97d-38c51b600f7mr18788353f8f.31.1738624647383;
        Mon, 03 Feb 2025 15:17:27 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec0a666ddsm7087129a12.73.2025.02.03.15.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 15:17:26 -0800 (PST)
Message-ID: <df9c2b85-612d-4ca3-ad3f-5c2e2467b83f@suse.com>
Date: Tue, 4 Feb 2025 09:47:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
To: Kanchan Joshi <joshi.k@samsung.com>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "hch@infradead.org" <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "josef@toxicpanda.com" <josef@toxicpanda.com>
References: <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
 <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
 <Z6B2oq_aAaeL9rBE@infradead.org>
 <bb516f19-a6b3-4c6b-89f9-928d46b66e2a@wdc.com>
 <eaec853d-eda6-4ee9-abb6-e2fa32f54f5c@suse.com>
 <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
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
In-Reply-To: <cfe11af2-44c5-43a7-9114-72471a615de7@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/3 23:57, Kanchan Joshi 写道:
> On 2/3/2025 1:46 PM, Qu Wenruo wrote:
>>> ell for the WAF part, it'll save us 32 Bytes per FS sector (typically
>>> 4k) in the btrfs case, that's ~0.8% of the space.
>>
>> You forgot the csum tree COW part.
>>
>> Updating csum tree is pretty COW heavy and that's going to cause quite
>> some wearing.
>>
>> Thus although I do not think the RFC patch makes much sense compared to
>> just existing NODATASUM mount option, I'm interesting in the hardware
>> csum handling.
> 
> But, patches do exactly that i.e., hardware cusm support. And posted
> numbers [*] are also when hardware is checksumming the data blocks.
> 
> NODATASUM forgoes the data cums at Btrfs level, but its scope of
> control/influence ends there, as it knows nothing about what happens
> underneath.
> Proposed option (DATASUM_OFFLOAD) ensures that the [only] hardware
> checksums the data blocks.

My understanding is, if the hardware supports the extra payload, it's 
better to let the user to configure it.

Btrfs already has the way to disable its data checksum. It's the end 
users' choice to determine if they want to trust the hardware.

The only thing that btrfs may want to interact with this hardware csum 
is metadata.
Doing the double checksum may waste extra writes, thus disabling either 
the metadata csum or the hardware one looks more reasonable.

Otherwise we're pushing for a policy (btrfs' automatic csum behavior 
change), not a mechanism (the existing btrfs nodatacsum mount 
option/per-inode flag).

And inside kernels, we always provides a mechanism, not a policy.

Thanks,
Qu
> 
> [*]
> https://lore.kernel.org/linux-block/20250129140207.22718-1-joshi.k@samsung.com/


