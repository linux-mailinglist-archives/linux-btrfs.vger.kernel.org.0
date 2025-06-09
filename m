Return-Path: <linux-btrfs+bounces-14558-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42025AD1892
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 08:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1602E3A7B4D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 06:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9530127FD67;
	Mon,  9 Jun 2025 06:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y4/Z+K2F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAB72F3E
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749450455; cv=none; b=XLZeeJmr4/F4AqEie9LcXcGCBaL36yea+qMRC1IEabcOCe9jk+UOOtsnKNZYXgJHBfEmryM5Rle6XOWTJtYi789Ps+/+z+DEAy39B0MgdA68q0wCpA+oc7T0I08S5h4yooQjXwEodnPe54dWuf1RpIh2XZJmWTSoeaZs92SsywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749450455; c=relaxed/simple;
	bh=aIF5ztSlUog/4jZUfWkpBn1NHfLPJKYMsZ1UXT3t3bQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgjCL3uoj4q1eDHA4Xa0oQZyNLKMkIcHJrEVwsW0d7FCPpcWQOpo8WxsSt7JBAqMV97V7jUCcy5NJrZnL3iQRGDtxWz3DSdFlaQpA11A42DJBiBmYJUsyH4eAelOB3pG7kB1wvpTsF5Z9qgL9hrLPh1QtSvaMmoHIInmmhW0bUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y4/Z+K2F; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a54836cb7fso456837f8f.2
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Jun 2025 23:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749450452; x=1750055252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=svzCR6uFMZkSaGB3wG3DXSBrJ3VyAb8JW2pum4YBUBM=;
        b=Y4/Z+K2FMPZfONgMmM7PUglJ9Fa8slVfF6qLEpErpNBAkD5zVTKiSFznPpR6Q0OGmw
         fb/KXgjP+e0xApAs5YlDHzZsFVclBoyK0XtYqy1pLP2D94Ia8FZQJU6jMYWgmbVc0RO+
         pe5EWGiZOF+YFqNANPypmH63niCwGF45FDOSkqgXQFK4LPloeAT5KLx7JMA2y7xXdC6U
         1yA9XIBzppPGRG9fzl2jV9sdK9l0O79mjijpOltpWbYaT6QXaf+0uVBIEBvxd/bukZGo
         h6qVIBFBwtrdrlu9jABmWlJFZOiFKZrVvdZxzepeVRRtt2NFCaaWURJMJGdUCjEtoEaI
         wrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749450452; x=1750055252;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svzCR6uFMZkSaGB3wG3DXSBrJ3VyAb8JW2pum4YBUBM=;
        b=PPRzY92IkMJkMNpf3SGYYfUkGewvB7sVIcTrgtQUg/L8bmR7OixhvUvQfTTaonC2jY
         ahL8T4xB8HNM3fuMznvkBFeGT6mI26xvFDJg+0bEaOjxgtSCSHtQNpS6/IopsIHW07hm
         4UtG8Yz1+F6lyr0X1xyzlSd9cahtFX/UPKe6hGvYsBP5v2NVNDn7BCRe4sKqBIh9Fdks
         XfpT+Z2HmWgrKWjf+2lgwi7N+Oys1PYhbmt6c2qLyxTsQ2SbA0aK+RdQSFvwzy5+nycR
         5wR+pJEH0wXiWmMsVAkUkGgoxFX88b65do5x5SPN9Zadjfa89182fdStJxP1nnBg4uFK
         M47A==
X-Gm-Message-State: AOJu0Yz31TDz4LiwjXF4xkFD136CDJ61IoUGmS2zUdAAqqWI7uz0x2ng
	fkrrY8MyAnGK5j1BaOUQD5dpILxBQS9ZT0D9XU0OzbkPj25hdzPQUsvdv2uPA4HtwJUjJrdA5Qk
	t0VjO
X-Gm-Gg: ASbGncvKOz1csp+5KXVjO8ItLXKwugTKGstnSh2jqlnD1yw33qsCuxH3EgX3cwO6bMs
	KNV7sDORjJdzWyncb5ui7wPJFdsUwmtta6p0O8yHFiExg8ZQTxd82R5gY3cjpnjZED+Hrt2nr0I
	1VNUIdMQwWfbFwzJAawpKiKhlad6FGiLK0pWZI8l4NjhZ+h6xdrOTV5/GKXO4YYvt8VpHSdo4H/
	kiBK14pgXp6DOq0F+xQOQ53WqRLkwkYhc/pvDjjSiJOYzX1iydjyZn9KGnnsEViyYy+viQ41++/
	lQI3T3CmEbHFjrOeJZEBoSZE04OUrqB35SDhrnPokMwT7H1mhj7j9QryPLZlTOp0+WyqS0sE1Jv
	GpLw=
X-Google-Smtp-Source: AGHT+IE/AQubidDeoTRZIJz5h6AFSW8bEHe0AjichkhEjkWBdzr9bEbkcdaC9iQNbQeJbNbguUmDdA==
X-Received: by 2002:a05:6000:4287:b0:3a4:f7ae:77e8 with SMTP id ffacd0b85a97d-3a53189b014mr10338627f8f.15.1749450451687;
        Sun, 08 Jun 2025 23:27:31 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034061f3sm48350335ad.179.2025.06.08.23.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jun 2025 23:27:31 -0700 (PDT)
Message-ID: <7352872f-968a-43b5-a2db-2d329424896d@suse.com>
Date: Mon, 9 Jun 2025 15:57:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] btrfs: introduce btrfs specific bdev holder ops
 and implement mark_dead() call back
To: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1749446257.git.wqu@suse.com>
 <aEZvaqtkM6JvLtLL@infradead.org>
 <e2a5a99c-3da8-4b2a-acd1-b892b4f67073@gmx.com>
 <aEZzTyBsj7x-4g5l@infradead.org>
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
In-Reply-To: <aEZzTyBsj7x-4g5l@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/6/9 15:08, Christoph Hellwig 写道:
> On Mon, Jun 09, 2025 at 03:01:32PM +0930, Qu Wenruo wrote:
>>
>>
>> 在 2025/6/9 14:51, Christoph Hellwig 写道:
>>> No full reivew yet, but I think in the long run your maintainance
>>> burdern will be a lot lower if you implement my suggestion of using
>>> the generic code and adding a new devloss super_uperation.
>>
>> The main problem here is, we didn't go through setup_bdev_super() at all,
>> and the super_block structure itself only supports one bdev.
>>
>> Thus even if we implement a devloss call back in super ops, it will still
>> require quite some extra works to make btrfs to go through the
>> setup_bdev_super().
> 
> Why do you need setup_bdev_super?  Everything relevant is already
> open coded in btrfs, you'll just need to use fs_holder_ops and ensure
> the sb is stored as holder in every block device.
> 
> The other nice thing is that you can also stage the changes, i.e.
> first resurrect the old holder cleanups, then support ->shutdown,
> then add the new ->devloss callback to not shut down the entire file
> system if there is enough redundancy.
> 
>> Although I have to admit, if all btrfs bdevs go through fs_holder_ops, it
>> indeed solves a lot of extra races more easily (freeze ioctl vs bdev freeze
>> call back races).
>>
>>>
>>> This might require resurrecting my old holder cleanup that Johannes
>>> reposted about a year ago.
>>>
>> Maybe it's time to revive that series, mind to share the link to that
>> series?
> 
> My original posting:
> 
> https://lore.kernel.org/linux-btrfs/b083ae24-2273-479f-8c9e-96cb9ef083b8@wdc.com/
> 
> Rebase from Johannes:
> 
> https://lore.kernel.org/linux-btrfs/20240214-hch-device-open-v1-0-b153428b4f72@wdc.com/
> 

Thanks a lot, I'll give that series a review and rebase.

It will be great if we do not need to introduce any extra per-device 
specific freeze/thaw serialization inside btrfs.

Thanks,
Qu

