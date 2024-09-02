Return-Path: <linux-btrfs+bounces-7733-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796869685CF
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 13:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2374B1F21D35
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 11:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4B7184542;
	Mon,  2 Sep 2024 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERHPERwg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069714A4E0;
	Mon,  2 Sep 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275452; cv=none; b=KcBQHivhuDkkprebiIAVKTyfll6XjisrImMbdV1AWtWZSTWvRQUCWTy8JNLvnSIpFoXT023Qzec53oBMz2k/JZn9p22bBAVxrTT+DiJmZ41IWd/wUDQnEepeccZN8SAxoRe9Dx9PFLjscEcAvUax0c1Q3lTYxvN7ttw6nsyG9yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275452; c=relaxed/simple;
	bh=hvKVyYM12/inKgea9u+ScMOdYuR88UFHPokNGhYDoWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HIR5XrcZA659S/mlT2ReeO+XyV6gQW3bVpSaKvTsLbAGP50ypf2pGI1Bc5PWFlVspmKyAJMW5OiP+J/OjQoUz5DhvimafGY/VBSy6G5zGox2StM+YUAsjqTCUFlrTxDunhFlcKbsyjPUzkAhQfy9KreARDz1YFxcQTx9vR/+i44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERHPERwg; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42c7bc97423so17994505e9.0;
        Mon, 02 Sep 2024 04:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725275449; x=1725880249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OJleH/ZEI5w7raHfUnyiwA0IJCBrxXCODdKKpXj1aNQ=;
        b=ERHPERwgiAPbvZipr5O/uQYq+5GJ97VlTh14OJTc/W2L34R5RZOzKjyF58qWIOJqNT
         WVElTIujAGJK9jfHZEs1sQSc2Ogw9DE9vaIyzUkW6H961iX9p2XZNrYu4EIG3m26wy9i
         f7/bvolnloNKq2OK0G0NgpUBlZcPEvgr0u7HmcsIHMah0cFUiOKxzmwMV/0q5p7929tF
         +BzstOfdGXaicLrJwjpKtwjZ8sXH5yL3ERDZIGNW8ovs7CdFR7QxEOPHsE9Eq6AsvPD3
         VdsMYlMnewCd4psA0QBjO9RpP0q0087iCQ70FlZkz8Xna+Y1AUYytw496hxGImdjZeFH
         V3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275449; x=1725880249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJleH/ZEI5w7raHfUnyiwA0IJCBrxXCODdKKpXj1aNQ=;
        b=DEB/b0jViYEMJ1jSobGRrQw5BsEbWZWmH4BggulfEoFlyGhei9pIf72Cq/sZFUR3AT
         7IE//4KlHsE5R9cQa7dijE15Tb9V5laICW+EuxeDubPF3fgp2/h5MYFWG60jXsuJICSi
         nre0Drp61vfpjNedJy5XSthzxe1JPmAlD9xWA6P41lUnVFVb5vtv/eKD8UjYK9ORej8r
         PiS8DPNKsZzS/ATK9jTTj+tsWI/wc7v2xtqw4CUjK8ynbMekam32Eh/u3NPIii4Qg9Z5
         XSmK5QLscQQh4CGlZ5c6GR5SQB0r8WcSTa5K5g1aSpeVgdgOv7DjePD5IYZcZOY7YAwi
         9trw==
X-Forwarded-Encrypted: i=1; AJvYcCWCr1Y127y1SfBsFA+gHKUYZ2hMVv4zb6j2UQf9CvEoFiY2cjpaFxFqEK2mWLXBXkRiP03te92bvRf66lGn@vger.kernel.org, AJvYcCXIvQkvLQzt1GAqSBDA6eKmHSree8BUyzd/RY70a1HRcwCo2lJSlvEWuehZU073KqBKz8uIPJ9xPbaI3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm7n0ikJppzwQ6ok2ZWyNu/orFA+y29iEikIzuLuQoTBISLl1E
	vNsjkRjMXz42O5tNgbD5ncJ3j7fxEU1ydqI0UhJOZgDFOHn8H7KL
X-Google-Smtp-Source: AGHT+IG6rONG9nPw/CPJflcCc4MY2bXsYJNwuMwhGtrATDjFgpikRyUsxfY4v1OOhm5Q1vEEHm+iTQ==
X-Received: by 2002:a5d:69ce:0:b0:374:bd48:fae8 with SMTP id ffacd0b85a97d-374bd48fd8bmr4541125f8f.25.1725275449165;
        Mon, 02 Sep 2024 04:10:49 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374caf10f37sm2468049f8f.28.2024.09.02.04.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:10:48 -0700 (PDT)
Message-ID: <2e15214b-7e95-4e64-a899-725de12c9037@gmail.com>
Date: Mon, 2 Sep 2024 13:10:47 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Don't block system suspend during fstrim
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822164908.4957-1-luca.stefani.ge1@gmail.com>
 <400d2855-59c2-47d2-9224-f76f219ae993@gmail.com>
 <745754f6-0728-4682-95a0-39807675bb18@gmx.com>
 <CAO0HQ0X3zk6aau50Ew2nmNP-pwNEkmgAoC2Ewmi30sGi7uQwDA@mail.gmail.com>
 <22c49ecd-e268-4738-853e-9f79ea1e87f7@gmx.com>
 <94178c8f-c9d6-4c3e-9d1d-6d465d379e0f@gmx.com>
 <e4903dac-cfd6-4513-b7ae-7f64c80fc8b6@gmx.com>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <e4903dac-cfd6-4513-b7ae-7f64c80fc8b6@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/09/24 13:01, Qu Wenruo wrote:
> 
> 
> 在 2024/9/2 18:47, Qu Wenruo 写道:
> [...]
>> Forgot to mention that, even for error case, we should copy the
>> fstrim_range structure to the ioctl parameter to indicate any progress
>> we made.
> 
> Sorry to bother you again, I should have notice it earlier.
> 
> There is another possible cause of the huge delay for freezing, that's
> the blkdev_issue_discard() calls inside btrfs_issue_discard() itself.
> 
> The problem here is, we can have a very large disk, e.g. 8TiB device,
> mostly empty.
> 
> In that case, although we will do the split according to our super block
> locations, the last super block ends at 256G, we can submit a huge
> discard for the range [256G, 8T), causing a super large delay.
> 
> So the proper way here is to limit the size of each discard (e.g. limit
> it to 1GiB, just as the chunk stripe size limit), and do the check after
> each 1GiB discard.
> 
> So this may be a larger problem than we thought.
> 
> I would recommend to split the fix into the following parts:
> 
> - Simple small fixes
>    Like always update the fstrim_range structure, no matter the return
>    value.
Sure, that's already done. Will upload separately.
> 
> - Proper discard size split and new freezing checks
I'll try to do the first part, and fallback to the mailing list for help 
in case of failure, thanks.
> 
> Thanks,
> Qu
>>
>> Thanks,
>> Qu
>>>
>>> Just please update the commit message to explicitly mention that, we
>>> have a free extent discarding phase, which can trim a lot of unallocated
>>> space, and there is no limits on the trim size (unlike the block group
>>> part).
>>>
>>> Thanks,
>>> Qu
>>>>
>>>>     Thanks,
>>>>     Qu
>>>>
>>>>      >>       }
>>>>      >>       mutex_unlock(&fs_devices->device_list_mutex);
>>>>      >
>>>>
>>>

