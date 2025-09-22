Return-Path: <linux-btrfs+bounces-17054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24922B8FFFF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F0E1776DD
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35A12F9982;
	Mon, 22 Sep 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NeGIRmwI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471B4182B7
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536868; cv=none; b=jvlmy7mfIiVtZUw2DVH4AQr8VFcTFCbNzS2fTM2cJxqaLCljjrZwJ0pfMPsAxMpHUad+0enQxzM0y1BWXd9ILhouC4NkZ76PR/s4zek9ZgHTR96lf8dDD2rRFFJMqMj0/a1oYzkWD8/byHMs6SlApWoUMJZsiZtM+pktbqAZHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536868; c=relaxed/simple;
	bh=i5KjQT/3iSx77M87xrluMy8yg0UXPCgizWCTBJNtO/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3lI//X1Zv6Ovdhpc/zGrJoQ6r+lxXt69xDJLK53PKdZw+k02dQztlcCoqwuk8UY8TC4BV00/+4B1gnsxYnpLNCTXvogv94gVASqp9dE12dKeVx0qMoEDD4ijQsN1c2GJ8iYU2SvM9+HBubMDDoBziF+5Y88K4qhTR7Aa6ouav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NeGIRmwI; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f0134ccc0cso3012556f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 03:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758536864; x=1759141664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T3Ub2uyUWb0Aliwi9RZBwkTtABEMFS0LUIuqphRfeWw=;
        b=NeGIRmwITvU0bssH/8Vc7EQrhm8cEKVanm1vw7vr4PTLEw2G2dXU674uDOCAHCeqAs
         Rco5F4sq4QwMAWPa4Gu05wFGbw4Zj1lvPJhT9mACHzMJTL6oneganR5lp7/CpQ0LHdnb
         L8jTYiZNFWoR0TxaJxV1U6d+E/uhO4BwxBO7tFI6NVT6JbXK3im8oanV4x1J/+WkflwN
         PFs7bToleWCrV2rHhQtWDxZTs7BUqD/7aT+bdzYy3S1oZCvORoljySmv9kHWuBHlpyIB
         OkaOZpOhAKH6hn5zF4HAuCeJGvHtjh4wWqe54DDrYUZs/Hdb3Ak3hNkWbI4rTE9V9RmQ
         helg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758536864; x=1759141664;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T3Ub2uyUWb0Aliwi9RZBwkTtABEMFS0LUIuqphRfeWw=;
        b=Vdk86IVQNhhhvy2IlaRW1lbINkmrEfjyzK5NJb571PF7Ckg8hvEUtVxPEfOquhiv5k
         NuZo8KTNHiNYZjP2TP2loW39t6pRWdtbdJetibWy9/WAt9hMzOKr0r9vZoxqCABlYzmP
         0uhM33mozcMNldZd0IT3Nj8PUXKDabsXLtpaNABVf9LT3dGfCuwPSAgilLothIZi2rBj
         W8aTRwwg3o/d2XACjcwD0vkiQAZjk7iQa1iK7vGm6HTaYIHIw17MLHAlvYNNPwqIYvls
         SRPdOSYw/qB0rmU2fS9KcbX+oHzt/0MXPLx6PKagMzzNw+YM5G1uVTrdUOziucyicvE5
         xa7w==
X-Gm-Message-State: AOJu0Yy61SbG0j23MFgFyA0PdkPrakgHXCkgmvyWSNemYcIXLtaGbMAl
	4R3ncORAqWRUTfPtoUlN+OInHV2lKwS6avrtCPM9pE3f9gTZ3WbUBa7qs/nYWlkKX0E=
X-Gm-Gg: ASbGncsn9zKvHP+E4Jw3OLNylyYrOERSD3FzBl5EjD8OUQk2RlJO9/VrakniHHLmcad
	9rDw4Em71UXWzcsjpTKT5Hz4z69idjr/TCMJWUfkAoQUvrfcNk45f3R6YWLC4fXs/KaeR8N+dnA
	FSz2Bn+h1/WKgz68YhML83JFzFO4+M/QvIP/AH3iLCZbBj0rishs+UqwhY7FtZK97C87UQZvwbU
	c1nzd19v0IyENRnngy4ejbB+KvganI0n79OWXRJxHhynKwPheR52+AorpWBM9FFoQ0j+a8GMrnP
	95FWY7Ex2XPHzjv/uins81XPmWnSUjFRRj3Pdx1WdI64cq2cHzV37ownA+anuJPvPpmV5wfbbNx
	aL9h3XKKB5JcvxXfFpjA/0n9a7WSYCBABzqo1okkNZkxkm6FK9ts=
X-Google-Smtp-Source: AGHT+IHR9KlIQ2hOEpEIkV/iu5LoJssK0yVSdozctKEnzOCdalDjP4Lv1DKFm1okyBHfR1mZbB0fdA==
X-Received: by 2002:a05:6000:144b:b0:3fb:6f9d:2704 with SMTP id ffacd0b85a97d-3fb6f9d2a3dmr3011637f8f.28.1758536864505;
        Mon, 22 Sep 2025 03:27:44 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802de5dbsm128190615ad.84.2025.09.22.03.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 03:27:44 -0700 (PDT)
Message-ID: <1f4c903b-9a7a-49c7-ac5a-76511c514ebb@suse.com>
Date: Mon, 22 Sep 2025 19:57:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] btrfs: enable experimental bs > ps support
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <cover.1758494326.git.wqu@suse.com>
 <018a9a3216ac9a4d79562105ea10727cec23e8ed.1758494327.git.wqu@suse.com>
 <20250922102124.GK5333@twin.jikos.cz>
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
In-Reply-To: <20250922102124.GK5333@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/9/22 19:51, David Sterba 写道:
> On Mon, Sep 22, 2025 at 08:10:51AM +0930, Qu Wenruo wrote:
>> +	if (fs_info->sectorsize > PAGE_SIZE) {
>> +		ret = -ENOTTY;
> 
> I did a minor fixup of the error code to -EOPNOTSUPP,

Please don't.

The error code is to co-operate with btrfs-progs, which doesn't check 
EOPNOTSUPP.

And the encoded receive only falls back to regular one when got a ENOTTY.

EOPNOTSUPP will immediately abort the receive.

Thanks,
Qu
  which means the
> ioctl exists but a particular mode or option combination is not
> supported. The -ENOTTY is for the case wher the ioctl does not exist at
> all, and for completeness -EINVAL is for a valid mode but invalid
> parameters.
> 
>> +		goto out_acct;
>> +	}


