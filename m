Return-Path: <linux-btrfs+bounces-6371-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 708F492E166
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 09:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8FBB22D14
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 07:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88D514D6FE;
	Thu, 11 Jul 2024 07:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IuapxxYu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE76C14A633
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 07:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684513; cv=none; b=YlzGvq3sZrwCjH4OuSLlUuBhRguqZw31T4ObuFUmI0kyn5DbZHnzS2QSst2P3psB9BQp3QUz5uQYz14B3Ii1/QGQYrJyiSAhebkAF5j86bNGGr/JMTSDiiL1bZsYoexSIZ2GOjvWmNXZkwtq5I2QYKR+QJUvJa7Sxwz4VeC3yBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684513; c=relaxed/simple;
	bh=8jDLQTzauzvrw7anQAcZaNhH5egayNSj4cFpkPdsKMY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hIHOW3eO9DWnLY8kZlXw0aUkJiU1Lqj5NJg0wodHVvYW6wuWBOTYTChdtKIFOX5IvUm88O3Qhniue/TV+D62z6byZvlkdAVoa+6KUnpZRPxt2f1ruAr4Xl3X/uYcMbLQCrzFAHR0vCsBiaTWrLt7GydBcvPb3Q+w6lBu+WgPf5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IuapxxYu; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eea7e2b0e6so6220811fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 00:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720684509; x=1721289309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1ytnPWmLi+VjCJfLaY7mUCubtk44P/QoUJC6G6/ZS2Q=;
        b=IuapxxYulJ0slT3lQNhxURWu4OCvWpUdxzTD7vjQjfzXw00OgZYL0e3uoZwNiCbsfp
         dpFqNBtyccq6E3arOKh85otkao6I7xBldEPSsKGoGSnYPY8GIIkrv/bpMJ/SgojiL8ln
         ZYh2MvjzGqV/kEU2tyIoUYKcObATBhy4fx0zkG1CQoEKv0VdZOKC6JOTZ4/GUaOY0eW2
         xn+nbcoLARtF2zOUqxOauPRRINXtwu0h/AoRzXuaiNDEC6Yx0JjDrHzHZNV2czwEieg0
         MOdtTnhwdWAqQ3/1LaenVtJpEruXFqd6AyWT4mqPBMLqZY62woG9f+zj6qkMM0lvYyRQ
         MeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720684509; x=1721289309;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ytnPWmLi+VjCJfLaY7mUCubtk44P/QoUJC6G6/ZS2Q=;
        b=itVz8KBl6au7naztQpCqlk3ThVJQmt0A+bwQMHUuuyRIQhg6Ro/8auB4kePCtSXhi1
         gEIP1xn6fcu5RKkbujQDZVOypCTsLWgQqfEsrlUa/H83i/hE9ZXfCFPf55T2sjDh7yOi
         UXZNW564u5a28FebLXs0lfO0f1N8KUmyVvioPcHWOlgZ/tRYVcSzmqVzc6qJG2h8CpLH
         gDB3QH86pjt4P0aLch/dvyVTZ4kH60W1JR4ZiNywu9o+bhm0KafZQi9hn5Q2qDOIjqRd
         prpkcYIYvQszYKOZfV5xW7uJ0O1RBfZTGyp69Z5Tt7RKXKBnOFJPLGEQktNwokmlPt8h
         NnMQ==
X-Gm-Message-State: AOJu0YznQAtfC9L/e02JsvPznOqtOgbJeNe3jjeMeoLKZNpXTtJOM8sM
	VtAbiiTvvgbim2B5CqKvFRN221RTTMmo1FSG2xFNUz29DorRMXqfPEA+3WkKPy4=
X-Google-Smtp-Source: AGHT+IEdIlPYfa3nZV1IRf1EkCk1e9IErBMYZoW+RYY9oS+Rt5tR0zUE04xwE09IA22Ct2Wqz2xCVQ==
X-Received: by 2002:a2e:3315:0:b0:2ec:565f:ef56 with SMTP id 38308e7fff4ca-2eeb30b4d38mr50186091fa.7.1720684508413;
        Thu, 11 Jul 2024 00:55:08 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad129asm44561715ad.269.2024.07.11.00.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 00:55:07 -0700 (PDT)
Message-ID: <5838503b-a4aa-4023-901b-99d637cadac4@suse.com>
Date: Thu, 11 Jul 2024 17:25:02 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] btrfs: update stripe_extent delete loop
 assumptions
From: Qu Wenruo <wqu@suse.com>
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240711-b4-rst-updates-v2-0-d7b8113d88b7@kernel.org>
 <20240711-b4-rst-updates-v2-3-d7b8113d88b7@kernel.org>
 <08b5cf14-8b00-4a19-ae98-e83e83357688@suse.com>
 <ca001842-92f4-46ff-80ee-e7a8a97fc433@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <ca001842-92f4-46ff-80ee-e7a8a97fc433@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/11 17:14, Qu Wenruo 写道:
> 
> 
> 在 2024/7/11 16:25, Qu Wenruo 写道:
>>
>>
>> 在 2024/7/11 15:51, Johannes Thumshirn 写道:
>>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>>
>>> btrfs_delete_raid_extent() was written under the assumption, that it's
>>> call-chain always passes a start, length tuple that matches a single
>>> extent. But btrfs_delete_raid_extent() is called by
>>> do_free_extent_acounting() which in term is called by > 
>>> __btrfs_free_extent().
>>
>> But from the call site __btrfs_free_extent(), it is still called for a 
>> single extent.
>>
>> Or we will get an error and abort the current transaction.
> 
> Or does it mean, one data extent can have multiple RST entries?
> 
> Is that a non-zoned RST specific behavior?
> As I still remember that we split ordered extents for zoned devices, so 
> that it should always have one extent for each split OE.


OK, it's indeed an RST specific behavior (at least for RST with 
non-zoned devices).

I can have the following layout:

         item 15 key (258 EXTENT_DATA 419430400) itemoff 15306 itemsize 53
                 generation 10 type 1 (regular)
                 extent data disk byte 1808793600 nr 117440512
                 extent data offset 0 nr 117440512 ram 117440512
                 extent compression 0 (none)

Which is a large data extent with 112MiB length.

Meanwhile for the RST entries there are 3 split ones:

         item 13 key (1808793600 RAID_STRIPE 33619968) itemoff 15835 
itemsize 32
                         stripe 0 devid 2 physical 1787822080
                         stripe 1 devid 1 physical 1808793600
         item 14 key (1842413568 RAID_STRIPE 58789888) itemoff 15803 
itemsize 32
                         stripe 0 devid 2 physical 1821442048
                         stripe 1 devid 1 physical 1842413568
         item 15 key (1901203456 RAID_STRIPE 25030656) itemoff 15771 
itemsize 32
                         stripe 0 devid 2 physical 1880231936
                         stripe 1 devid 1 physical 1901203456

So yes, it's possible to have multiple RST entries for a single data 
extent, it's no longer the old zoned behavior.

In that case, the patch looks fine to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> 
> Thanks,
> Qu
>>
>>>
>>> But this call-chain passes in a start address and a length that can
>>> possibly match multiple on-disk extents.
>>
>> Mind to give a more detailed example on this?
>>
>> Thanks,
>> Qu
>>
>>>
>>> To make this possible, we have to adjust the start and length of each
>>> btree node lookup, to not delete beyond the requested range.
>>>
>>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>> ---
>>>   fs/btrfs/raid-stripe-tree.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
>>> index fd56535b2289..6f65be334637 100644
>>> --- a/fs/btrfs/raid-stripe-tree.c
>>> +++ b/fs/btrfs/raid-stripe-tree.c
>>> @@ -66,6 +66,11 @@ int btrfs_delete_raid_extent(struct 
>>> btrfs_trans_handle *trans, u64 start, u64 le
>>>           if (ret)
>>>               break;
>>> +        start += key.offset;
>>> +        length -= key.offset;
>>> +        if (length == 0)
>>> +            break;
>>> +
>>>           btrfs_release_path(path);
>>>       }
>>>
>>
> 

