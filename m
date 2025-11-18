Return-Path: <linux-btrfs+bounces-19111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E106C6BA5F
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 21:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id DA2182BBF2
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 20:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332FE2DF156;
	Tue, 18 Nov 2025 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Oc+w2tLG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172472F0C45
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 20:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763498229; cv=none; b=WaqOgnvUEcK/VjNG1Hj45/e6JDScaE03s1/sgDSc9imbXQrZ0ThQTYEk71yDaWjbd5vUzd1krgUdHTmgk4cUMmR6QVgIjhfrJzc6tyNXM1hQPfZRqOd9ZjFDiKeOnE0KTqz2239a/Awpi58qwcFM833Zzy9Tc2B+UugOnilqLQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763498229; c=relaxed/simple;
	bh=V7TIEWFt6ZwQupkaiRl+bT4dzsSvS5l7b7w9HlOWcf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tnq5hy2b2brmHItXCtjVIPNG4e0FCjks97ZBcUU/LszEKcMPKXOE29+JKlUKD8mG087SIU89CtZjLrWkLCIMboG15j/gvKR+Uw3amJFcVOjuko+gv9P29OOKBYPSILD5JrX0H3hd1v44+s+XjHE7kAtQ3l79OX5pFUuFB1rxBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Oc+w2tLG; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso39832935e9.0
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 12:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763498224; x=1764103024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=j3I0llCQW4dEWDZIIFipg+6I+96RQcXF2HQQl7jQZps=;
        b=Oc+w2tLGmzyEBaBV86LWUOFhJBtIsHItUBFLclv7qhAZhOwJbHBsYeUSKMBUB8K2Hq
         CCSbQl/J/jzFqzBDo2+b4PqKVYvQt85onkcUS2rBgSTmGNKp9VQJviA/OwgZJHnys5lJ
         ac7BWAxxCP3c5zn/FHr9vEkfiQbspO2+6mNp++4XEAdKCDE1nHt7EaVKipo5nR1V6Vba
         Wb4ozH6KleQWW3Nfy3jzxEs6WR8lDqt2mgMwiQF1IOR6cOA40NmTVyXWFyQPyqJODkcP
         nkkRXGcrM/814BwQylGPrmwLZ1o6glk1sfNtUuShC/JAXXaC9ydn3tq0WOIved2CFHmP
         qY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763498224; x=1764103024;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3I0llCQW4dEWDZIIFipg+6I+96RQcXF2HQQl7jQZps=;
        b=A/w/gPw649mLIX6JtXxHX5Bg93ZT1nOlSSqb4iiCIyHQCopEg+Q6Wn9p7G8qoiJ9Ih
         CrUyWG+QDCTkOKeIwUaG7irr75/6TGFXEoUC4ZrFx7bwkUXP9YH4P9wS/lBpDmzhWfdk
         TKpNiI9W1CmuHZ4MBQJHdrf4lK6ZAB6uv7z78IIlUDYJjsjL64FJ7beMdwDMCjB8D+3+
         nxAhDPNTbnD1XS3wdmbLHAtSer4BbBLyKsQpLNcoz2RJ97678SErVU+DejLCNRBKDler
         VlKgV+vhhRE+HABP5Sfkl2paYvNnCziZ+/Rh9KvObis74Yq5F7q0+c2WK//BIUQ6a/Ew
         2H+A==
X-Gm-Message-State: AOJu0YwfSXBp94PFSlXVHGi109K0xXcbjMfHEN0zWPCVPB5Ae3DNnEWO
	aabyjCEYEab/wv3bIQjUG7v0FnpRN/kIgxTO/1FdB5OmrfTuyLi1kktIe5uNeBj2gZR/7toRZnI
	nNAQL
X-Gm-Gg: ASbGncuxWMfP9muN6GWg4fyZYi+rbyWayAlrrB2wx7j0bWjJzQnqZtm9bAJulwTSv7C
	VxBKSG33ANPeBEyRrzl6olHrZMqIJKIidnNTlyzCOcBLhl0t0t3GNxuHL2rSQ37ZhLs/+3/Tdxs
	wzzNQ5bn3rYmJdP5+fKXhH5W67/oIRMglEqGqNVuogX2Y6NIQupKl91IFcYwkRgPmuPn7urViYv
	0788SDtwjeL1gkWbVN7CC9RoWmqntslx1+FxdSIPM4T5T/g6VRsh5BbKRYwUr0Ek/GRcRjTeC+G
	CV9oIw6TCiIzCfskHjWJUG3PTqWH4pIausMmd83gtamC/C4SWSpchL9l7BSIva3iOtbJtWWxfPH
	2dkX4550UKvuAX0yUc2/h2SYY+hFzPrW6TEGAy3bYDuHNoIqGGlelcqRDUGXpJc6H1XSH0X9EkF
	3583W3Z2wHn9JX2h/BgTrfGI6a6T0KfpImseUKRGdsOp/7xOqvmbqaro7vXbel
X-Google-Smtp-Source: AGHT+IHIIXm9xkSI4ob725bJr4SGM0fRVurS30RK/kRAXoGPaAIzzSxxOMjm6HrcLh9TRMkxiCU22g==
X-Received: by 2002:a05:600c:3b0f:b0:477:557b:691d with SMTP id 5b1f17b1804b1-4778fe9b23amr162657775e9.25.1763498224107;
        Tue, 18 Nov 2025 12:37:04 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-345bc25ffd5sm341846a91.16.2025.11.18.12.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Nov 2025 12:37:03 -0800 (PST)
Message-ID: <421adf69-1145-44d2-8046-586edbfaa1ea@suse.com>
Date: Wed, 19 Nov 2025 07:06:59 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fallback to buffered IO if the data profile has
 duplication
To: dsterba@suse.cz
Cc: linux-btrfs@vger.kernel.org
References: <c233e29e6b011666accf3be888f61a78d7833f1b.1761954724.git.wqu@suse.com>
 <20251118145658.GV13846@twin.jikos.cz>
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
In-Reply-To: <20251118145658.GV13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/19 01:26, David Sterba 写道:
> On Sat, Nov 01, 2025 at 10:22:16AM +1030, Qu Wenruo wrote:
>> [BACKGROUND]
>> Inspired by a recent kernel bug report, which is related to direct IO
>> buffer modification during writeback, that leads to contents mismatch of
>> different RAID1 mirrors.
>>
>> [CAUSE AND PROBLEMS]
>> The root cause is exactly the same explained in commit 968f19c5b1b7
>> ("btrfs: always fallback to buffered write if the inode requires
>> checksum"), that we can not trust direct IO buffer which can be modified
>> halfway during writeback.
>>
>> Unlike data checksum verification, if this happened on inodes without
>> data checksum but has the data has extra mirrors, it will lead to
>> stealth data mismatch on different mirrors.
>>
>> This will be way harder to detect without data checksum.
>>
>> Furthermore for RAID56, we can even have data without checksum and data
>> with checksum mixed inside the same full stripe.
>>
>> In that case if the direct IO buffer got changed halfway for the
>> nodatasum part, the data with checksum immediately lost its ability to
>> recover, e.g.:
>>
>> " " = Good old data or parity calculated using good old data
>> "X" = Data modified during writeback
>>
>>                0                32K                      64K
>>    Data 1      |                                         |  Has csum
>>    Data 2      |XXXXXXXXXXXXXXXX                         |  No csum
>>    Parity      |                                         |
>>
>> In above case, the parity is calculated using data 1 (has csum, from
>> page cache, won't change during writeback), and old data 2 (has no csum,
>> direct IO write).
>>
>> After parity is calculated, but before submission to the storage, direct
>> IO buffer of data 2 is modified, causing the range [0, 32K) of data 2
>> has a different content.
>>
>> Now all data is submitted to the storage, and the fs got fully synced.
>>
>> Then the device of data 1 is lost, has to be rebuilt from data 2 and
>> parity. But since the data 2 has some modified data, and the parity is
>> calculated using old data, the recovered data is no the same for data 1,
>> causing data checksum mismatch.
>>
>> [FIX]
>> Fix the problem by checking the data allocation profile.
>> If our data allocation profile is either RAID0 or SINGLE, we can allow
>> true zero-copy direct IO and the end user is fully responsible for any
>> race.
>>
>> However this is not going to fix all situations, as it's still possible
>> to race with balance where the fs got a new data profile after the data
>> allocation profile check.
>> But this fix should still greatly reduce the window of the original bug.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=99171
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> This fixes some cases but also adds another exception/quirky behaviour
> of direct io. At minimum we should document it in a clear way of what is
> compatible and how. So far I think we have the direct io features
> scattered in the documentation.

If all (including that direct IO read fallback patch) patches got 
merged, the final doc would be easy:

   Fallback to buffered IO if:
   - The inode has csum (no matter read or write)
   - The fs has duplication (DUP/RAID1*/RAID5/RAID6)

But still, the direct IO read patch doesn't have any feedback yet, which 
makes the matrix much more complex.

Thanks,
Qu

