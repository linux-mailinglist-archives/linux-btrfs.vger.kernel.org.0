Return-Path: <linux-btrfs+bounces-13476-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D92BA9FD9C
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E02A47AF487
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Apr 2025 23:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F7A1F4720;
	Mon, 28 Apr 2025 23:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qdmd+PPR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148B203716
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881919; cv=none; b=P0x0oQTo1Ksa/ywVyXRkHb75pSyFu7G9uSD16p8lG+RgdKdJxuRZroiB47EDBaNKkg7b26n+ibbQ87hmsORLS/NEOkGNpwzJISU0BgLGLuDPVPNHwmYX63xsNJSN9arC3z7oQFI2A69fUeTB0/j2J8t/U0bbylyM8AFqOPPKOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881919; c=relaxed/simple;
	bh=eCgy7A/2UH8kHirFeB8bMf9cQq+VQ2d/Gb8JlYxI8zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y/177jotDNnyvfErnjVnVAyQ3B8nxux1tN0Devy9GBNBppV3CdNNKWk+36e7CCt9G3lALjNtipl6vd/uWiL8BoW+XjEYsO28NhUzGaTtmyEfy6DtBzHxksh+6e6QCIYllkXhI5+cMwSvXMegTafpApCXMbpmSKM5x8UlXNzA3SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qdmd+PPR; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c1ef4acf2so4019556f8f.0
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Apr 2025 16:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745881915; x=1746486715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U29L6nxCASZzF9XGBupx9oL41NsZzOx5FkwHAFefSdo=;
        b=Qdmd+PPRpjNLRrv09+u9uub6732On54DrkcF4GYomUl1SPyKS04/umD65Wa8+OgdE/
         ZtfeURmFg01l83UJkY4U9Z0HdRY3ouKrp5zwHKhfRmejn7WgcFkHh1jXk29VHHLm3BCl
         Q0lt8Zv4voeCn8BuuTtn4MvNRZjtP+Pek2A402l2Ee8pCeysnaOxly/0mIbMtR3VTKj8
         Vx3I9oy3hfIGC+omY2Y/WFy2h7taxJUmFvPjG/ZIRqNRIOi3QnFcdAVZQz5icxoKSoSX
         G7cfmMcoQqpla02MNsuRNZfMaecO/5LgSsWvGUooM+F+5+NfacQMBZbhJbsJ6WPPhXFY
         wJUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881915; x=1746486715;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U29L6nxCASZzF9XGBupx9oL41NsZzOx5FkwHAFefSdo=;
        b=JwSrOky3FUaUk2NSv8UQajqHlzDxJAwcobPJr5VVpYfTAOnemwkXA1YDPUJaA9F8mv
         k5dM9nm30/DpqPBlrUjjtYcLfCdzyCcaR0MUnvbt0yc4h3mygynfQvV/zkS3NNMzEGjj
         whCZhnjZeiljxTcdTLkwObkFz87akjpUB942om0qucyiBlZkkuyTAvTh3g+mJT6ldR+O
         FNLEdK/9hmk6AumyrhCfBXh7Bq0hFwmfcG9utaSWsdxLpMOkB5v5ymWcV54mRrWp32de
         wFpXyZewF1+tadADgXo0SLzf4P0CDa0UlnDnZoucQa8r9UZ/4UcBkoh0ekJhQgYjZ6F3
         Ed3Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/W0bh9BoTnGQ9UZIHiE7ihkmpH/QRPFaFHC8Uvokj55J3poMDmywjT3sdaF90wGtBtnGqmXI20uUSWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkltYCIxDyxZedabB2e95g01gtaYBDRQ0yLQreQzEpvRPgfQwY
	MwNgdT1UmkjNttAmOMMrnZoi5NYkTE/Yc0hlYwBRBGFV/1chKVrXWEWhrJzmpzY=
X-Gm-Gg: ASbGnculeFoVsFXC+hhOWE0rTi4h9MZuo0tnTp6IYur40T5qmI2PN8hxrdTYcjlkvlA
	I1yoZ//jL3Xccz5kbXBuw5PUcWFydNKgch8UvgKXRQ/3sBTLjon0kFDhkFvuV1UJw664wojXuAS
	b2o6ue6zs1LT1NT+aacDetjsT4n2RJk3hWIAd6h7AGVvmzPYuzEL9IkbILP/aSrgpdw/A9v3cIR
	17HdsMulZI9gflLCsb+w1llmqhQAcSJIwki/qOkUeNgxXHlwRSM8fhikTu/URLYK/NVXoGH+AmD
	GHrkDxGIc8pPpVENEdBRtjVYE9XCrOf8X6S7hRzSTNKbKVkEelC/bICSCq/OtO4wGjZc
X-Google-Smtp-Source: AGHT+IFijKGLVQX3IceXR6g3Y0vTTBgz0Fx2283oVfh3NtArWnaW40u1NTRTZN8VEuB77RrUNmx3mg==
X-Received: by 2002:a5d:4cc5:0:b0:3a0:8834:214c with SMTP id ffacd0b85a97d-3a0890ad0bemr1265245f8f.20.1745881915397;
        Mon, 28 Apr 2025 16:11:55 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25941bddsm8881063b3a.69.2025.04.28.16.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 16:11:54 -0700 (PDT)
Message-ID: <a171a80c-bce1-4dc3-bb3a-f40fe17917bb@suse.com>
Date: Tue, 29 Apr 2025 08:41:50 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] btrfs: merge btrfs_read_dev_one_super() into
 btrfs_read_disk_super()
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1745802753.git.wqu@suse.com>
 <b251d716c8cd93ee8b9ee32fdd399bd0fff28669.1745802753.git.wqu@suse.com>
 <1cfd4998-e220-43da-b78d-2a7efa3f681e@wdc.com>
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
In-Reply-To: <1cfd4998-e220-43da-b78d-2a7efa3f681e@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/28 23:51, Johannes Thumshirn 写道:
> On 28.04.25 03:16, Qu Wenruo wrote:
>> +	ret = btrfs_sb_log_location_bdev(bdev, copy_num, READ, &bytenr);
>> +	if (ret == -ENOENT)
>> +		return ERR_PTR(-EINVAL);
>> +	else if (ret)
>> +		return ERR_PTR(ret);
> 
> Nit: else after return is superfluous.
> 
> Maybe even:
> 
> 	if (ret) {
> 		if (ret == -ENOENT)
> 			ret = -EINVAL
> 		return ERR_PTR(ret);
> 	}


Sure, I'll modify it at the merge time.

Thanks,
Qu

