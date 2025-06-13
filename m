Return-Path: <linux-btrfs+bounces-14638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9CAAD852D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 10:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBA53A487E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jun 2025 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60D2DA779;
	Fri, 13 Jun 2025 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OVSplDfV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834622DA767
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749801689; cv=none; b=T4e3N3WkZvryClmhiYbmmQZk85ObFwuH0up+YZH6XhghM3GeeeQOtCuV6AqJpjWqxwPGXv1YJPY/2hQdMEjC7Tzmo1ezZF3W+GgTILVatI3wW0tlOeg89dyd9U9w0sVuCGiLrNSQd7lvUwyVvSX/qUcTWUsXLZxjeo0SC7WzjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749801689; c=relaxed/simple;
	bh=ReUUmSAd1h4IQdF0GzT/GaMOWpQYN8xGYCvweExf6Hc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJQrJb2ydVIE2q4eieIpng5zJJULvD4bj70XvbcxnCHj+X3pgsj6IVcmctSt7lMJADrDSwpNLpx+jQHU+bgMdmy04tNmcqc06/EA1nDdM9HPubrxs7HjaOad7yzFYGNGxpB8gqjiOp7cGhX6ycJRhvoW9paa06J2FUufe8TjetQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OVSplDfV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a54690d369so1822006f8f.3
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jun 2025 01:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749801686; x=1750406486; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PTAddDVNTozzFbCBJu3jjspWANMo9SI9m4F4Nzw2h8o=;
        b=OVSplDfVwjcX5v6PZvY/0MEp2bhRL1z5qoNXeMJPpw/rH+nLtqzHFsPri8D3KuTZR+
         pwSbAS/f6um9m3QQwR9oRB1uvEt2n6WLNzjn9+GT9zcJF8kFdGZfBxjZ0VzlEIBokOYb
         nOP6ovQh0G/WQz79kqVsJZY6rqak+r8I3hQQf4eJikDOq8UAhoBt8I3a0CsEqcI5XyIl
         fTeLy869k1P73rlEtvLiKnsquXsw3VHoI60txzlEsBPXhBSnYSOVLgP2hwrnN1Ur6I3D
         g7rykNmPSdyLiRx4Mv5/BmAYugKY/lTuosJDHmQwlDZI29toxg4B4bi5vtkZikHBYqpv
         C2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749801686; x=1750406486;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTAddDVNTozzFbCBJu3jjspWANMo9SI9m4F4Nzw2h8o=;
        b=rv9p5aPhJ1MrPgy2AyqYRpIO4EeDqmrndho9fyXJNXaaf5v4lxhHWB8ciITcu59DWL
         i91+So/5FDrbAaGFnVCepIrKjr+MT+Zx/f1n8EU5kD8XpOkWu4fMz6JtsVS5LIv1HQtZ
         wrhHWBqqH2HGombjQ3k3/Y/RM7JxLLsk+0d6PS+fwlW4q94IxUf1/bswty4anceaKz7U
         EIjoHal4YlrSxMtHGzRRxJnTnFBdodrusv9Zrf2qO1wmj9paQaotnWuDwi6m0+pjm6IS
         aAiGJe8WHX/fW9H1pcCMXyx1+hLf14bUKROheKqDEKuR1GtvTqVLrldFY9P2V5NuZf8H
         XyjA==
X-Forwarded-Encrypted: i=1; AJvYcCXf9CQWjDBMceL2TYhLDFEepIoAIPC3hpYs4zeYTMpAchVkDgE5qkvKpdbkADSUPl30QWCJNjd1gwVfjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKybo2zCmP5o3qjYR+PZBNLAklU60VXqUQWW9YqQ8c7jFw+nKb
	bZIT9e9Y3z6u9ynUYRTSUg2+YmVLQr1AgkV4EbdYe0bi/yyvDGBNVzEFaDTtkmvdNQo=
X-Gm-Gg: ASbGncuXz9PetdT3nruDyZPh/JQSZxM0tHUZbqdoQ4syZ/FNc/NPdwY2BXUebLgsAOd
	YmVRdyxdjRCWpVA1CMnlzSxBusF7xdG2tfl65oHR1rB7LspksJEsTlqBbSw6MK7fJSMKkUCZfLp
	qHCKhy7Dz0FqaaX2OL6dElf5OWyilTtlwRBMdsCMJI+C+M65A34V2xmvKuNNnc7dtL5A1CMltyJ
	UsVfSJGTkivPuXCgwlVd+F6LirWQBgeJUI4yTLktSo3sJavAoXlZ4VvpZGCNgwtU/gVVB6blgrz
	nGr6+Cm7c2clwJtwQX+W4YX+ByJlUmlOt7NFbB+mbbKs7LXCUoFsXrlk1uVi5WF9Iwj3RPijv5d
	0Tdd8pdK7iiM/bQ==
X-Google-Smtp-Source: AGHT+IFSE+tK3bqA9ZPyMxLmVtoKYYAxn1N9Yys/gGf+vxmtCV8fI2lrcDW9oIW6ljGP61MiXvoUCg==
X-Received: by 2002:a5d:64c5:0:b0:3a5:24a9:a5d3 with SMTP id ffacd0b85a97d-3a5686f510emr1768365f8f.17.1749801685597;
        Fri, 13 Jun 2025 01:01:25 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88bf61sm8958235ad.22.2025.06.13.01.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 01:01:25 -0700 (PDT)
Message-ID: <862c5dbb-b8ad-4f79-9d0d-901bbedac977@suse.com>
Date: Fri, 13 Jun 2025 17:31:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] btrfs: use the super_block as bdev holder
To: hch <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 Boris Burkov <boris@bur.io>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>
References: <20250611100303.110311-1-jth@kernel.org>
 <9093e0d6-d33e-4c4b-814f-9134d568f395@suse.com>
 <69982e5e-96d3-4e60-891c-ade4474253cc@suse.com>
 <1618ecb3-2bc5-4c48-89d5-ba1c9ec788b3@wdc.com>
 <01b0f70f-c131-4b79-a997-7317176d6269@gmx.com> <20250613055920.GA9176@lst.de>
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
In-Reply-To: <20250613055920.GA9176@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/13 15:29, hch 写道:
> On Fri, Jun 13, 2025 at 07:51:25AM +0930, Qu Wenruo wrote:
>>> -       if (fs_info->fs_devices) {
>>> +       if (fs_info && fs_info->fs_devices) {
>>> +               ASSERT(fs_info->fs_devices->is_open);
>>>                    btrfs_close_devices(fs_info->fs_devices);
>>>                    fs_info->fs_devices = NULL;
>>>            }
>>>
>>> So if we end up in btrfs_reconfigure_for_mount() and fs_info and
>>> fs_info->fs_devices are set, I see the is_open flag being set as
>>> well. But the fstests run isn't 100% finished yet (and it's only
>>> been a -g quick run anyways).
>>
>> Since I'm also working on cleaning up the mount process, I'm getting a
>> little familiar with this part, but if HCH can comment on this, it will be
>> a great help.
> 
> I wish I could.  A lot of this mount stuff has been entirely paged out
> of my memory, I'm sorry.  Note that Christian did some fairly big rework
> in this area, and now the new mount API came in as well.  So things
> around it looks pretty different.

That's totally fine.

And since I'm already working on the surrounding code, I'll definitely 
make the involved code easier to read.

> 
> I think the parts of the series that are valueable as is are the
> "open read-only for scanning" and split the inuse counter bits,
> which are pretty obvious.  Everything else might need a more or less
> big redo with all the surrounding changes.
> 

And the "open block devices after super block creation" patch.

It's the existing code making the sb creation way harder to grasp.

With that improved, the benefit of delaying device open should be very 
obvious.

If Johannes is fine, I can integrate those patches into my upcoming 
get_tree cleanup.

Thanks,
Qu

