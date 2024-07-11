Return-Path: <linux-btrfs+bounces-6365-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D3292E11C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 09:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F92E282B9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 07:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3C14B943;
	Thu, 11 Jul 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LjGb0Per"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC4614A4F1
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683901; cv=none; b=E1k8QF/+1UlY/x2SHx2e5FUU0/fa+5rPnD6MUzYlsiUdobGGbzY7RUI2CHc8tMmqTwqFgoxPncdb5tBqun+diOoNTlCrJ3LYOrP1wLkN99TV0FesOdWS0XadpmjKSDemyUXvjc6toiS4WRyan8VuP41Nzv01WJ9cz8DXS7sOyPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683901; c=relaxed/simple;
	bh=dWO1XABC13Rs+hCpo4XrLk0JAwxOSW7wtGIhf2+uYUo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=U3sPMVHYNKutQvUTdeD5D/kGwrCNucGtLZhgqr4J3HrjY+0IB0xKsV+XN5uUqvuLQ1M/r0E91MZrhg0kVQ0+0wiOyKgza2XETCrB5O3d6767mgDiX7By2SeTAOyrSlmuZHE7xBq2jfh3Gtn/ACNA3tPUiaMMnEF22CuBulsJuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LjGb0Per; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso4697881fa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720683897; x=1721288697; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VM5TBvTpwknYaPGyjEUpi3Yz7BjmJkz9OLN+xweVaMQ=;
        b=LjGb0Perr2J/FQ60kx3R4rkwS1xu4LFCJrYD/dqu0I3gsccSh6XUSXgzVUVvLAj6jG
         lmxeWN/BVgKSaBZu3l0ikfciLoDFvd4Hd3az7q1/opthWrp+GV9N1516Zy5sPnZF8QDl
         Ea0mBmQRclmHyCDBvdrSVrf/XY8zzNOuinqMGGtJb5BGuxUq2PU/sK02iRRy3SxytH0S
         P/xeGE1iDuLbNTwqgVP0zSLfWq4XCWSM5Bi92fTVuqoFVPRrHSa/cbgbkHyjFdTTvppw
         SHIPgNzdJ4jeYEs5DxqPyi+g0nnKUlL7MI9GCXtwDdAoIqXrCMfhr9EsS+BoJ05r1/28
         +YKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720683897; x=1721288697;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VM5TBvTpwknYaPGyjEUpi3Yz7BjmJkz9OLN+xweVaMQ=;
        b=dn5vtIG4C8ue+MjC+JcstB2lNaZihqi+/iR1uPbKm3nxZ3MwZ05TLDmS1VQltlkZRN
         MFxsHJAeAX1w1KjmtGdpnLtI4aX1EVrFArEX9/ap7PPar5z1xkl+SBtpEqRXXGI1pFFo
         G091SZUbuzdSiiQ8k7UVF2s2vv58D384V+syn6hG8H1QyB86MKk4r5c3hv8sa1PJah8y
         PXPC7ibJs2Xqh2WWmD5GE9RpYQ+LpVMEcnybT9aZ+9MCkorXoUHCVmc4vPxRIYzf+BLf
         wOWv128SSF6VHYVdd/cwnOfEk2u3xs6wSGlSt366wN/P/j4KGWibNcSbVYC7ZDqpHFu0
         aECQ==
X-Gm-Message-State: AOJu0YxYT6T0e3egkbHgYMDHfymCvbgijVT0GF2B+3SikzPOG+9CvmxU
	a4cWGkloADXb+E38PayTtRaNlacXe9jZ/e/2lBnc/YuejWmV87ANulV9/TeOWjQ=
X-Google-Smtp-Source: AGHT+IGL0gMkSBaGDXnel0L0he0+Geb5Lig1vUQpIlMr5lh7WCoHJE2W5NuuujDRawcmT+3R/w3Dsg==
X-Received: by 2002:a2e:90d0:0:b0:2ee:80b2:1e99 with SMTP id 38308e7fff4ca-2eeb31977famr45772941fa.44.1720683896915;
        Thu, 11 Jul 2024 00:44:56 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca344c151csm5055544a91.12.2024.07.11.00.44.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 00:44:56 -0700 (PDT)
Message-ID: <ca001842-92f4-46ff-80ee-e7a8a97fc433@suse.com>
Date: Thu, 11 Jul 2024 17:14:50 +0930
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
In-Reply-To: <08b5cf14-8b00-4a19-ae98-e83e83357688@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/7/11 16:25, Qu Wenruo 写道:
> 
> 
> 在 2024/7/11 15:51, Johannes Thumshirn 写道:
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>> btrfs_delete_raid_extent() was written under the assumption, that it's
>> call-chain always passes a start, length tuple that matches a single
>> extent. But btrfs_delete_raid_extent() is called by
>> do_free_extent_acounting() which in term is called by > 
>> __btrfs_free_extent().
> 
> But from the call site __btrfs_free_extent(), it is still called for a 
> single extent.
> 
> Or we will get an error and abort the current transaction.

Or does it mean, one data extent can have multiple RST entries?

Is that a non-zoned RST specific behavior?
As I still remember that we split ordered extents for zoned devices, so 
that it should always have one extent for each split OE.

Thanks,
Qu
> 
>>
>> But this call-chain passes in a start address and a length that can
>> possibly match multiple on-disk extents.
> 
> Mind to give a more detailed example on this?
> 
> Thanks,
> Qu
> 
>>
>> To make this possible, we have to adjust the start and length of each
>> btree node lookup, to not delete beyond the requested range.
>>
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>> ---
>>   fs/btrfs/raid-stripe-tree.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
>> index fd56535b2289..6f65be334637 100644
>> --- a/fs/btrfs/raid-stripe-tree.c
>> +++ b/fs/btrfs/raid-stripe-tree.c
>> @@ -66,6 +66,11 @@ int btrfs_delete_raid_extent(struct 
>> btrfs_trans_handle *trans, u64 start, u64 le
>>           if (ret)
>>               break;
>> +        start += key.offset;
>> +        length -= key.offset;
>> +        if (length == 0)
>> +            break;
>> +
>>           btrfs_release_path(path);
>>       }
>>
> 

