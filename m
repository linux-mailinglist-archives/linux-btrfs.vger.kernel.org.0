Return-Path: <linux-btrfs+bounces-2694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B8D861F6C
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 23:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB5F1F246DF
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Feb 2024 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CB214CAC1;
	Fri, 23 Feb 2024 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ap9dGNZQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE1B1F600
	for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726390; cv=none; b=XDeG6RgYNq72Oq4vYGtQXkI6woZwh4g6Ykuk08c/a/R3lqtvwd4eg6kOX13RxK2YzaqbtzQ/z7jeVFjzKJrCc9F/KoKFBKWqe6WTKV0bP+Q77gYv1Bd1BeGoT4pRsTjQmnrX2TqgDhEuykpDCMX6pm0sLfOyBECL5KUhXRJvZbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726390; c=relaxed/simple;
	bh=6HTE+jS+ToIzKHEKQ+pai2ptgnwjZ3ecic5xX2hGb3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e1564CHYhHdl3/5x7M/8Eaa/8Tgp99l2qpCdr1G7iMQNoDVEBvpS/FtLI0h5tbQLFgDXHjUyWaDzLaUA6L36dOVRId0Fvag51L7c+Wv+gcNytoza73v92pMl+kIAASrerA/XXv7r8E0lAWbTYeWgdueW+XWC3Noyj6DIiGFE4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ap9dGNZQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d109e82bd0so10772411fa.3
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Feb 2024 14:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1708726384; x=1709331184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jWbW73meGRUpb9wvNrA3PyD9kDpRblF/00/EDe0z0cA=;
        b=Ap9dGNZQQys4EfFRWOdWHEL48Z000wSsT/MWX14aWSESMqrV87WQOiUsBZYt5NSY47
         XIpUUD7Ofmgx8DFq+AbEuXEvi6ZLyCmHitiWQZJapikV9nIwko8ci2dpTHbrcvE1T4Oq
         nqoMkz7AUi0hUqGeqjU8PwllFMmnz1MAVhUSFthm6/5NRS6FpkVUN81xMNQGQ2kTQGhi
         9LhxXN2UMWD9p5HQtplcGxicOFPaACjUY+EZbLHPzd5B1DjY6A03LZrlQH1QNWl0TqBH
         eZtUyEpqRSOTt7xEfLb9USKoIgPb4PZVgwrYoDxN91GoerpX+QqATGHN/TpWM2vGXKyH
         QLlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708726384; x=1709331184;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jWbW73meGRUpb9wvNrA3PyD9kDpRblF/00/EDe0z0cA=;
        b=quSVvtkkNWCgH7UGl2J9FKygaH95YZdE6FtmP//7EeqOaVjACFjJRLtKcyReTL+PaG
         Piz0IFblISBXLx3VrMeo6l7h5W58kTUcG3/XkO9LBM3EwbTUfszkbV2zjcGvWmbnbGvg
         XJ9qyb9LqxaJOMY6RkDyY3mE8jiYyt0/A+MDk5fDki7MeayyenfbxN9YYsQF2Oqvuh1J
         Wxj24+bhM8uiO89ahwXOJ+Jl3kr973XTI6rhXs94vh0sA+GqC+zTxwVaaWyvx3FTgjsl
         NQqEBGGy+1zzBnmUThvKgCsmALprRuMyOkRiI+5cexsRdszlv/pdzV0wuz2qvpkpvRSc
         Z3CA==
X-Forwarded-Encrypted: i=1; AJvYcCUHU/ekOzMhyqjVpMwYAqAUPf1ZX+wnJQ8sExRX7bbK3vn4HIkIXCY1z3u8UtriDItw/xefoIWxCReE/V1CUcqpD4G2jKMzQcS73iE=
X-Gm-Message-State: AOJu0YxoQO0w8QLotNh8ydpsn4KD5bzu6/xxEtmkzLAEDR5QEe2NgaL+
	u8mQb6H8XWXBHj1PgfYHV3XqJiHh52T4afortJe42nrjGzPR2G0zCLJukZ5A9xY=
X-Google-Smtp-Source: AGHT+IG1PPOiGoGgvI67uEZZID5YW4JgIYzPr8HPFYOWR/ZnXI7ndoIAbJlIQOpbc+1MiDMiASwQ2Q==
X-Received: by 2002:a05:651c:152:b0:2d2:2a90:704f with SMTP id c18-20020a05651c015200b002d22a90704fmr218370ljd.15.1708726384154;
        Fri, 23 Feb 2024 14:13:04 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id y7-20020a056a00180700b006e4e5ee9a75sm1592216pfa.191.2024.02.23.14.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 14:13:03 -0800 (PST)
Message-ID: <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
Date: Sat, 24 Feb 2024 08:42:58 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
To: Matthew Jurgens <default@edcint.co.nz>, Qu Wenruo
 <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
From: Qu Wenruo <wqu@suse.com>
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
In-Reply-To: <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/2/24 08:11, Matthew Jurgens 写道:
> 
> On 24/02/2024 6:55 am, Qu Wenruo wrote:
>>
>>
>> 在 2024/2/23 21:39, Matthew Jurgens 写道:
>>> If I can't run --repair, then how do I repair my file system?
>>>
>>> I ran a scrub which reported 8 errors that could not be fixed.
>>
>> The scrub report and corresponding dmesg please.
>>
> The latest scrub report is
> 
> UUID:             021756e1-c9b4-41e7-bfd3-bc4e930eae46
> Scrub started:    Fri Feb 23 21:42:13 2024
> Status:           finished
> Duration:         5:52:50
> Total to scrub:   9.00TiB
> Rate:             447.36MiB/s
> Error summary:    verify=8
>    Corrected:      0
>    Uncorrectable:  8
>    Unverified:     0
> 
> 
> Probably the most relevant dmesg lines:
[...]
> [10226.535987] BTRFS warning (device sdg): tree block 20647087931392 
> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
> [10226.615321] BTRFS warning (device sdg): tree block 20647087931392 
> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
> [10226.615524] BTRFS warning (device sdg): tree block 20647087931392 
> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
> [10226.615731] BTRFS warning (device sdg): tree block 20647087931392 
> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b

This is not good, this means both tree block copies are having csum 
mismatch.

Since both metadata copies are corrupted, it's not some on-disk data 
corruption, but more likely some runtime corruption leads to bad csum 
(like runtime memory corruption).

Since the unmounted fsck still gave tons of error on fs tree, I'd say at 
least some of the corrupted tree blocks are in subvolume trees.
(aka, affecting data salvage)

The first thing I'd recommend is to do a full memory tests (if it's not 
ECC memory), to make sure the hardware is not the cause. Or it would 
just show up again no matter whatever filesystem you're using in the 
next try.

Anyway, since the fs is really corrupted, data salvage is recommended 
before doing any writes into the fs.
You can salvage the data by "-o ro,rescue=all" mount option.

I won't recommend any further rescue/writes until you have verified the 
hardware memory and rescued whatever you need.

Thanks,
Qu

> [10226.615733] BTRFS error (device sdg): unable to fixup (regular) error 
> at logical 20647087898624 on dev /dev/sdb physical 1597612949504
> [10226.615741] BTRFS error (device sdg): unable to fixup (regular) error 
> at logical 20647087898624 on dev /dev/sdb physical 1597612949504
> [10226.615742] BTRFS error (device sdg): unable to fixup (regular) error 
> at logical 20647087898624 on dev /dev/sdb physical 1597612949504
> [10226.615744] BTRFS error (device sdg): unable to fixup (regular) error 
> at logical 20647087898624 on dev /dev/sdb physical 1597612949504
> [10871.525097] BTRFS warning (device sdg): tree block 20647087931392 
> mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
> [10871.538286] BTRFS warning (device sdg): tree block 20647087931392 
> mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
> [10871.546525] BTRFS warning (device sdg): tree block 20647087931392 
> mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
> [10871.551011] BTRFS warning (device sdg): tree block 20647087931392 
> mirror 1 has bad csum, has 0x97fa472a want 0xccdf090b
> [10871.551033] BTRFS error (device sdg): unable to fixup (regular) error 
> at logical 20647087898624 on dev /dev/sdg physical 1600879263744
> [10871.551055] BTRFS error (device sdg): unable to fixup (regular) error 
> at logical 20647087898624 on dev /dev/sdg physical 1600879263744
> [10871.551063] BTRFS error (device sdg): unable to fixup (regular) error 
> at logical 20647087898624 on dev /dev/sdg physical 1600879263744
> [10871.551069] BTRFS error (device sdg): unable to fixup (regular) error 
> at logical 20647087898624 on dev /dev/sdg physical 1600879263744
> [12097.231261] btrfs_validate_extent_buffer: 12 callbacks suppressed
> [12097.231264] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12097.257496] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [12097.399518] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12097.437847] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [12097.456673] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12097.507496] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [12097.539579] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12097.562906] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [12097.610849] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12097.616316] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [12817.886430] btrfs_validate_extent_buffer: 12 callbacks suppressed
> [12817.886437] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12817.911375] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [12818.002768] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12818.031952] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [12818.066655] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12818.108668] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [12818.136420] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12818.169702] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [12818.207071] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 2 wanted 0x97fa472a found 0xccdf090b level 0
> [12818.235735] BTRFS warning (device sdg): checksum verify failed on 
> logical 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
> [20654.902312] BTRFS info (device sdg): scrub: finished on devid 3 with 
> status: 0
> [20790.498498] BTRFS info (device sdg): scrub: finished on devid 4 with 
> status: 0
> [21228.046956] BTRFS info (device sdg): scrub: finished on devid 1 with 
> status: 0
> [21333.526634] BTRFS info (device sdg): scrub: finished on devid 2 with 
> status: 0
> 
> The complete dmesg is at https://www.edcint.co.nz/tmp/dmesg_1.txt
> 
>>>
>>> ------------------------------------------------------------------------------------------------------------------------------
>>>
>>> Then I ran a btrfs check while mounted which looks like:
>>>
>>> WARNING: filesystem mounted, continuing because of --force
>>
>> Do not run btrfs check --force on RW mounted fs.
>>
>> It's pretty common to hit false transid mismatch (which normally should
>> be a death sentence to your fs) due to the IO.
> Ok, thanks for the info
>>
>> Thanks,
>> Qu
>>> Opening filesystem to check...
>>> Checking filesystem on /dev/sdg
>>> UUID: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
>>> parent transid verify failed on 18344238039040 wanted 4416296 found
>>> 4416299s checked)
>>> parent transid verify failed on 18344238039040 wanted 4416296 found 
>>> 4416299
>>> parent transid verify failed on 18344238039040 wanted 4416296 found 
>>> 4416299
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=18344237924352 item=1 parent
>>> level=2 child bytenr=18344238039040 child level=0
>>> [1/7] checking root items                      (0:00:06 elapsed, 69349
>>> items checked)
>>> ERROR: failed to repair root items: Input/output error
>>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>>> 4416300
>>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>>> 4416300
>>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>>> 4416300
>>> Ignoring transid failure
>>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>>> 4416301
>>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>>> 4416301
>>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>>> 4416301
>>> Ignoring transid failure
>>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>>> 4416301
>>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>>> 4416301
>>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>>> 4416301
>>> Ignoring transid failure
>>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>>> 4416301
>>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>>> 4416301
>>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>>> 4416301
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=18344243445760 item=4 parent
>>> level=1 child bytenr=18344246345728 child level=2
>>> [2/7] checking extents                         (0:00:00 elapsed)
>>> ERROR: errors found in extent allocation tree or chunk allocation
>>> parent transid verify failed on 18344238039040 wanted 4416296 found 
>>> 4416299
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=18344237924352 item=1 parent
>>> level=2 child bytenr=18344238039040 child level=0
>>> [3/7] checking free space cache                (0:00:00 elapsed)
>>> parent transid verify failed on 18344241594368 wanted 4416296 found
>>> 4416300ecked)
>>> parent transid verify failed on 18344241594368 wanted 4416296 found 
>>> 4416300
>>> parent transid verify failed on 18344241594368 wanted 4416296 found 
>>> 4416300
>>> Ignoring transid failure
>>> root 5 root dir 256 not found
>>> parent transid verify failed on 18344253374464 wanted 4416296 found 
>>> 4416300
>>> Ignoring transid failure
>>> ERROR: free space cache inode 958233742 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233743 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233744 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233745 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233746 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233747 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233748 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233749 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233750 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233751 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233752 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233753 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233754 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233755 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233756 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233757 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233758 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233759 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233760 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233761 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233762 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233763 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233764 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233765 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233766 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233767 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233768 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233769 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233770 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233771 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233772 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233773 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958233774 has invalid mode: has 0100644
>>> expect 0100600
>>> parent transid verify failed on 18344264335360 wanted 4416296 found 
>>> 4416301
>>> Ignoring transid failure
>>> ERROR: free space cache inode 958232811 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232812 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232813 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232814 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232815 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232816 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232817 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232818 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232819 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232820 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232821 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232822 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232823 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232824 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232825 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232826 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232827 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232828 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232829 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958232830 has invalid mode: has 0100644
>>> expect 0100600
>>> parent transid verify failed on 18344243511296 wanted 4416296 found 
>>> 4416301
>>> Ignoring transid failure
>>> ERROR: free space cache inode 958231543 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231544 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231545 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231546 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231547 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231548 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231549 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231550 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231551 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231552 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231553 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231554 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231555 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231556 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231557 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231558 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231559 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231560 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231561 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231562 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231563 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231564 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231565 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231566 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231567 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231568 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231569 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231570 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231571 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231572 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231573 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231574 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231575 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231576 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231577 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231578 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231579 has invalid mode: has 0100644
>>> expect 0100600
>>> ERROR: free space cache inode 958231580 has invalid mode: has 0100644
>>> expect 0100600
>>> parent transid verify failed on 18344246345728 wanted 4416296 found 
>>> 4416301
>>> Ignoring transid failure
>>> ERROR: child eb corrupted: parent bytenr=18344243445760 item=4 parent
>>> level=1 child bytenr=18344246345728 child level=2
>>> [4/7] checking fs roots                        (0:00:00 elapsed, 1 items
>>> checked)
>>> ERROR: errors found in fs roots
>>> found 0 bytes used, error(s) found
>>> total csum bytes: 0
>>> total tree bytes: 0
>>> total fs tree bytes: 0
>>> total extent tree bytes: 0
>>> btree space waste bytes: 0
>>> file data blocks allocated: 0
>>>   referenced 0
>>>
>>> ------------------------------------------------------------------------------------------------------------------------------
>>>
>>> I then ran a btrfs check again whilst not mounted and I won't put the
>>> output here since the file is 1.5GB and full of things like:
>>> root 5 inode 437187144 errors 2000, link count wrong
>>>          unresolved ref dir 942513356 index 9 namelen 14 name
>>> _tokenizer.pyc filetype 1 errors 0
>>>          unresolved ref dir 945696631 index 9 namelen 14 name
>>> _tokenizer.pyc filetype 1 errors 0
>>>          unresolved ref dir 948998753 index 9 namelen 14 name
>>> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>>>          unresolved ref dir 952510365 index 9 namelen 14 name
>>> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>>>          unresolved ref dir 954421030 index 9 namelen 14 name
>>> _tokenizer.pyc filetype 0 errors 3, no dir item, no dir index
>>>
>>> and
>>>
>>> root 5 inode 957948416 errors 2001, no inode item, link count wrong
>>>          unresolved ref dir 690084 index 17960 namelen 19 name
>>> 20240222_084117.jpg filetype 1 errors 4, no inode ref
>>> root 5 inode 957957996 errors 2001, no inode item, link count wrong
>>>          unresolved ref dir 890819470 index 4463 namelen 8 name hourly.3
>>> filetype 2 errors 4, no inode ref
>>>
>>> and ends like:
>>>
>>> [4/7] checking fs roots                        (0:00:58 elapsed, 415857
>>> items checked)
>>> ERROR: errors found in fs roots
>>> found 4967823106048 bytes used, error(s) found
>>> total csum bytes: 4834452504
>>> total tree bytes: 17343725568
>>> total fs tree bytes: 10449027072
>>> total extent tree bytes: 1109393408
>>> btree space waste bytes: 3064698357
>>> file data blocks allocated: 5472482066432
>>>   referenced 5313641955328
>>>
>>>
>>> ------------------------------------------------------------------------------------------------------------------------------
>>>
>>> I have tried to see if I can find out which files are impacted by 
>>> doing eg
>>>
>>> btrfs inspect-internal logical-resolve 18344253374464 /export/shared
>>>
>>> using a what I think is a logical block number from the scrub or btrfs
>>> check, but these always give an error like:
>>>
>>> ERROR: logical ino ioctl: No such file or directory
>>>
>>> ------------------------------------------------------------------------------------------------------------------------------
>>>
>>> after mounting it again, subsequent checks while mounted look like the
>>> first one
>>>
>>> I have also run
>>>
>>> btrfs rescue clear-uuid-tree /dev/sdg
>>> btrfs rescue clear-space-cache v1 /dev/sdg
>>> btrfs rescue clear-space-cache v2 /dev/sdg
>>>
>>>
>>> I am currently running another scrub so I will see what that looks like
>>> in a few hours
>>>
>>>
>>> ------------------------------------------------------------------------------------------------------------------------------
>>>
>>> Other Generic Info:
>>>
>>> uname -a
>>> Linux gw.home.arpa 6.5.7-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Oct
>>> 11 04:07:58 UTC 2023 x86_64 GNU/Linux
>>>
>>> btrfs --version
>>> btrfs-progs v6.6.2
>>>
>>> btrfs fi show
>>> Label: 'SHARED'  uuid: 021756e1-c9b4-41e7-bfd3-bc4e930eae46
>>>          Total devices 4 FS bytes used 4.52TiB
>>>          devid    1 size 2.73TiB used 2.55TiB path /dev/sdg
>>>          devid    2 size 2.73TiB used 2.56TiB path /dev/sdf
>>>          devid    3 size 2.73TiB used 2.55TiB path /dev/sdb
>>>          devid    4 size 2.73TiB used 2.56TiB path /dev/sdc
>>>
>>> btrfs fi df /export/shared
>>> Data, RAID1: total=5.09TiB, used=4.50TiB
>>> System, RAID1: total=64.00MiB, used=768.00KiB
>>> Metadata, RAID1: total=24.00GiB, used=16.14GiB
>>> GlobalReserve, single: total=512.00MiB, used=0.00B
>>>
>>>
>>
> 

