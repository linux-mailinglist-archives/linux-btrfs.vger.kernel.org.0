Return-Path: <linux-btrfs+bounces-16469-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64FDB38CB2
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Aug 2025 00:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19F71161527
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Aug 2025 22:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F3312815;
	Wed, 27 Aug 2025 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="azLv6Jki"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8F2305E19
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332335; cv=none; b=CPrQRYsH4s5fMlPt6CCdvhMClAJCIoObWULf+Diq/jcwM56izxwo/NFvGYRH4dNswiIlPP71C/vgFNznwQZ0kcfJ9ZTGTV/prKW4GnfuKbXPBofjldbEG21dQs9nIy+FGRKzIf1273lN+dghKP2flPL/l/S18JqHqmCJF0NyIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332335; c=relaxed/simple;
	bh=egcsJ2C+6TMCFKyNNMu5ZyINOAuzbKXVPyPooWLRvVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O91qgPYTq+qlKLj/qVogv8RSOWjcscsowSN3xqUCJcdLkAjUOXTVEVUqdMVYeHmXIqwyd8Euqp/C8zOLzt5yOTEKNFinJzBlI4jNL2ig4ydQyTPmjrSNM5a0wjZIX+NhQWRKuFvzB+qaiIC9yM1TE5U0UVYGRs6tAbzwQ0d7HcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=azLv6Jki; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3c51f0158d8so267559f8f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Aug 2025 15:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756332330; x=1756937130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=66dl+vG7e+9njjYnXsJN+/Q3gT/VeY1rNagrbWTE+QE=;
        b=azLv6JkitKAHfBZiCDyG4DEXoGOHbwLvHNt8l0AozshLxlNnx4xgx7xLEMAseSgGNi
         Xfty8rBPUvmMl6N/MCtcEL8I/c0Io2V0za4gLoLjn0njNsmDqWM5hvR5W2S/hPmr5yIT
         OPm38N5aor2DiqpRPb8bQBkuh458+g4sI0z75J73ZXfk8B20rAzwoCcM1g4PEisavBCB
         J5hp0PJ57AwdxjInYQ0VECtCUo43bqPs1YOJlwnTPIs0VekQ6hNs1INTUJkaLzvud/cH
         d9fBSzhaDnpVN6FHwBH53WeMGqDlekDq4/KXvFp08G3Ckm5Qdw4eZGyUrTSarr1zdpLZ
         2BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756332330; x=1756937130;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66dl+vG7e+9njjYnXsJN+/Q3gT/VeY1rNagrbWTE+QE=;
        b=pnyKVUiiT/DDbdrd7V8FAXOzqK5x7V4YP2eCXhfbWV6JTCAGEztnIjEHVOH3VY+6cG
         qlsHgpjAw7RoxzLwl58ZrMxHckOxhTrfKQQdLr7OGBKiuzJ9X1HZHbw1XqwV6+NdJdp/
         NELeXJRX1Dj4DIj16VcsoKDuhfmCHHI8eKExeBNnxlWY0G0qwI/D64gBu47fbONGXdf0
         1TJa1y7kwKu7tbKKqu5qkmpYDjFPkuVcfjrEFAynBPQk1utLd58QLTIsuDlYybl7EeaE
         LbJ5SiTm1ZoOLQuukU53RbH6OtWQFI5jUp382VeCRi3Jc1kheD92d2rNdeALqUl+bmy+
         24bg==
X-Forwarded-Encrypted: i=1; AJvYcCV5uGfbY8cz9mBOvl/YpZFamBCfBkVXJthIn3RO7wUjMorYK/2yeQm2laFWtO+iqrC0HCqwB3o6KjdNKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8AuMWQstTSZ8HkPewXEIVzacN3B2WUPNRWrU7J87FK+zJq4PF
	P5sNYfwJlKTf+VA4JrCme9YVYb1j1rBSyr1UfUFVgngQjYYW0Xu2kBQHZzws8fdubAk=
X-Gm-Gg: ASbGncuP7qNv0h3jJgslV71EUH1wpE17msn+CrTMR8DHmx/UvXqnx+aFuu5I6rpIeSl
	xtYlR6U2AQx6y0eRLD2K+1ABb7SGjhGFR8GWczoYGOCDQ8OIk7j3OhEY3UyotrlTDukqHbmaut9
	Y3Eiu6tNA5yR73ihqUn2yEfO2H87ymrUnD27t5AIF4V+LeVut5C7f3aptcH7jirT/MSArdH/CVJ
	cGQAN2U6UVX14zqXZ+8+k3asQgNz4FBlzeX/BylPPyyS1bGgQE9AV5qBC8Dh7TG5CzGf3ZmlWmB
	g/w7HZLDaf5V54gkmNqo+YhhXqYVbgxkXXPukRza9RgOzGvhAZ4Yqu3Kwl7QOrS/dN+8fmFu5Tu
	tHSihhCkxQoOE6dHKbv5RVUZylAUlX5c4GsjhJDMXW4NB5vqWzX8=
X-Google-Smtp-Source: AGHT+IFLVKCeq5P9NUxEWkxHijKdw0B+zg4a1aIa3M2i7AlDmJZ3JzhFneBEwT8/zElE69vjgD7FVg==
X-Received: by 2002:a5d:64ce:0:b0:3b7:7377:84c5 with SMTP id ffacd0b85a97d-3c5d7cb4888mr13750122f8f.0.1756332330168;
        Wed, 27 Aug 2025 15:05:30 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7720f609b0csm1617654b3a.22.2025.08.27.15.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 15:05:29 -0700 (PDT)
Message-ID: <29f97f46-acdf-412e-8f05-6a131dcf6d3d@suse.com>
Date: Thu, 28 Aug 2025 07:35:25 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: don't allow adding block device with 0 bytes
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Mark Harmstone <mark@harmstone.com>,
 linux-btrfs@vger.kernel.org
References: <20250827103725.19637-1-mark@harmstone.com>
 <e37b9714-b079-4304-8067-9120d0f16637@gmx.com>
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
In-Reply-To: <e37b9714-b079-4304-8067-9120d0f16637@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/27 20:14, Qu Wenruo 写道:
> 
> 
> 在 2025/8/27 20:07, Mark Harmstone 写道:
>> Commit 15ae0410 in btrfs-progs inadvertently changed it so that if the
>> BLKGETSIZE64 ioctl on a block device returned a size of 0, this was no
>> longer seen as an error condition.
> 
> My bad, that commit changed the handling of zero sized device, 
> previously the caller who checks the returned size now only checks if 
> the ioctl/stat works.
> 
> Feel free to send out a progs fix.
>>
>> Unfortunately this is how disconnected NBD devices behave, meaning that
>> with btrfs-progs 6.16 it's now possible to add a device you can't
>> remove:
>>
>> ~ # btrfs device add /dev/nbd0 /root/temp
>> ~ # btrfs device remove /dev/nbd0 /root/temp
>> ERROR: error removing device '/dev/nbd0': Invalid argument
>>
>> This check should always have been done kernel-side anyway, so add a
>> check in btrfs_init_new_device() that the new device doesn't have a size
>> of 0.
>>
>> Signed-off-by: Mark Harmstone <mark@harmstone.com>
> 
> The extra kernel checks looks good to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>

In fact this reminds me to try other extreme situations.

Like adding a 64K sized device.

The result is, the fs will never be able to be mounted again, as we 
saved the cursed device which can not have the primary super block written.

Since we're here, can we enlarge the bdev size to <= 
BTRFS_DEVICE_RANGE_RESERVED?

Thanks,
Qu
> 
> Thanks,
> Qu
> 
>> ---
>>   fs/btrfs/volumes.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index 63b65f70a2b3..0757a546ff5c 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -2726,6 +2726,11 @@ int btrfs_init_new_device(struct btrfs_fs_info 
>> *fs_info, const char *device_path
>>           goto error;
>>       }
>> +    if (bdev_nr_bytes(file_bdev(bdev_file)) == 0) {
>> +        ret = -EINVAL;
>> +        goto error;
>> +    }
>> +
>>       if (fs_devices->seeding) {
>>           seeding_dev = true;
>>           down_write(&sb->s_umount);
> 


