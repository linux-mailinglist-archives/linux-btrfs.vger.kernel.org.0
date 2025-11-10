Return-Path: <linux-btrfs+bounces-18847-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD29C495AB
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 22:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5772D3A9704
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Nov 2025 21:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6AD2F90EA;
	Mon, 10 Nov 2025 21:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eOKK7pc9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8222F261F
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762808711; cv=none; b=gvXoRn/tbnUjhbIkdoNnmz9dOEE4Vmhi4a1pObe2L76LhhzL84SLugJAms4YZYcXqT670qCuoQUgCA0CYGXOJfXbVuLTb+lm9hHC1u+LlEWlt41tfehXjWl31bgKKA0UD/AJTdToXYdVNqf2CbDayo+0FRNU/Fpu3FWId+xjqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762808711; c=relaxed/simple;
	bh=CPgwKXbIv/M7BWk6xGWcZMLjTcPl4UwtLs1UudkSmcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gC0+5TPfLXiEZVZO5POxn32WCNjrkacRxCFUSr6RRaJ5C25Y26tFeTN2784C3fT178dr1BeYZjLzCETyOQY5dH9xfXOqdYd0IgqsOcywFq/rrigvFBSW8yOBhM0dMxCbNnMdF17YApjL7IuS2EdqfVCOEj8hygYo3ZG9IElyOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eOKK7pc9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so95410f8f.1
        for <linux-btrfs@vger.kernel.org>; Mon, 10 Nov 2025 13:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762808707; x=1763413507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3gxjdqqKRjUYr0NsbLGOTlHgWtKTYSETgUc/63wH/Q=;
        b=eOKK7pc9IH2H6kJbNAsHy+ji95KswA/nwYznQ6mya4K5yYJ2YiwcFF+kOx2x+fHII4
         Z3XgTJ9le3Pn30rYdhQoff8TJCZAavoXbsJ0AYX6NW+EkqDj0hozi+V8DRwcYh1EbZDe
         iPPJsGFiBHw6hzENc2UtKiAxnfNg3wQjBOsCBqBZYwL3fdIbb4LjcEjGOWYAjdVQP1Pm
         T2yND3lWixhpCaqNTmaY4i+W0kZWZZNMADz24AyIA+Z4Bcb5TEBQORTktLNB65R9qQ/6
         g2zy2lW9S5LlAnax0wY5picUhKcLPoFAdYj1DHPHxoIDjlcgeTewj1Dx+7FUzwR9AV0J
         FBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762808707; x=1763413507;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3gxjdqqKRjUYr0NsbLGOTlHgWtKTYSETgUc/63wH/Q=;
        b=OtUBWKit47zBC5bLE4f07fyMzalV+/5/czDpU/PaXvK/Y273GSgp7U9eNyvk4MZP6C
         AbX16cW9bVh7UQ46FeFLZLjmcr515TDhR2ypmdtATcMPEcUIoGGycCvA170J8dbq57IK
         sTiSt4s0xd3GUst53t18BW48b4mdF5e2XK5XjPwPn6bo5Y6kUF2Xom7woJRqA1E3y6tV
         z7Tw1P/D/IxTUDseunnZARbwwTuEAeY2dSU59hkMgSu/sqjyPb1CiNQFjgK2em5AuFhx
         +dk2PcbowKudi/IvsrYZjItSCsXPcelqVsYMaDhYqXvtuHhbAGmS7Ir+OcqFIAUEd1mf
         Ln7w==
X-Gm-Message-State: AOJu0YyR+t/f4rUl4pDj/V+i8zAaI34uWZo862xolt+duqCZbscccWYt
	aCHwh6Q/IoYlCDY3gvgQLBzTQ7HgAOiudUiK1QWUXGsOhHGMx8fSHrBN6rXU/S0LDoIrQSHqjVX
	FSc/Y
X-Gm-Gg: ASbGncvTgKZPU2Bz3W7zKnP7HvHU1wXHeDkjhYLtQQ2ea07z5iSfaHaecR48oAYWqtM
	9eWOF11IkbgiFw55vCBSt5vtIRVErG7inUU/UjqKJzF+t89ck+pWtubaiV82yajAUAucCHSe01V
	szjEVCk5C5UCaPjXtU/nufpwuOA8wHrGHngzBPbi9siRDCicUDwRr60ZlWw8LV7zbF6IKoLOHxG
	1Gd3FmUEuik0ujoGxdqr3edRxttDABtrn/CD3jM4AKW/t26NfTvAhjYWNMXoN5ecgk6ObHcWvG5
	HCstZUIntMEp6JoWroGL4NwjuimZQCkOwo43dZs3HGlySY5ULib8f5NjEW2jXL8D/8HuSuvlntu
	yJalRZMqwWKzNnXYPW/YNf1Y4DPqiJ7ea8X+R63qvpafhMjC/jKHK+wWN7qNGZYMv/nhHsssEDT
	1MGNvmRipYwhtZgGajl6aDkBTX62Y+
X-Google-Smtp-Source: AGHT+IFXW/Dnn4J5hub6G89O27yu1T8KNf6G1mu6jWv2d7fkj9uFG+cd91IuQJejvt7uLlyl8UdG4A==
X-Received: by 2002:a05:6000:1a8f:b0:429:bb77:5deb with SMTP id ffacd0b85a97d-42b432d31d1mr771981f8f.31.1762808707218;
        Mon, 10 Nov 2025 13:05:07 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c953d103sm12853979b3a.5.2025.11.10.13.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 13:05:06 -0800 (PST)
Message-ID: <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com>
Date: Tue, 11 Nov 2025 07:35:03 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] btrfs: introduce btrfs_bio::async_csum
To: Daniel Vacek <neelx@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1761715649.git.wqu@suse.com>
 <2b4ff4103f157ffd2d7206a413246990b3ef2746.1761715650.git.wqu@suse.com>
 <CAPjX3FdaDTXcP3v52tofjwhByYnN6Rc4PQ257hz7PFvu4zh9Fw@mail.gmail.com>
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
In-Reply-To: <CAPjX3FdaDTXcP3v52tofjwhByYnN6Rc4PQ257hz7PFvu4zh9Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/11 05:10, Daniel Vacek 写道:
> On Wed, 29 Oct 2025 at 06:43, Qu Wenruo <wqu@suse.com> wrote:
>>
>> [ENHANCEMENT]
>> Btrfs currently calculate its data checksum then submit the bio.
>>
>> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered write
>> if the inode requires checksum"), any writes with data checksum will
>> fallback to buffered IO, meaning the content will not change during
>> writeback.
>>
>> This means we're safe to calculate the data checksum and submit the bio
>> in parallel, and only need the following new behaviors:
>>
>> - Wait the csum generation to finish before calling btrfs_bio::end_io()
>>    Or we can lead to use-after-free for the csum generation worker.
>>
>> - Save the current bi_iter for csum_one_bio()
>>    As the submission part can advance btrfs_bio::bio.bi_iter, if not
>>    saved csum_one_bio() may got an empty bi_iter and do not generate any
>>    checksum.
>>
>>    Unfortunately this means we have to increase the size of btrfs_bio for
>>    16 bytes.
>>
>> As usual, such new feature is hidden behind the experimental flag.
>>
>> [THEORETIC ANALYZE]
>> Consider the following theoretic hardware performance, which should be
>> more or less close to modern mainstream hardware:
>>
>>          Memory bandwidth:       50GiB/s
>>          CRC32C bandwidth:       45GiB/s
>>          SSD bandwidth:          8GiB/s
>>
>> Then btrfs write bandwidth with data checksum before the patch would be
>>
>>          1 / ( 1 / 50 + 1 / 45 + 1 / 8) = 5.98 GiB/s
>>
>> After the patch, the bandwidth would be:
>>
>>          1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) = 6.90 GiB/s
>>
>> The difference would be 15.32 % improvement.
>>
>> [REAL WORLD BENCHMARK]
>> I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 vCPUs, the
>> storage is backed by a PCIE gen3 x4 NVME SSD.
>>
>> The test is a direct IO write, with 1MiB block size, write 7GiB data
>> into a btrfs mount with data checksum. Thus the direct write will fallback
>> to buffered one:
>>
>> Vanilla Datasum:        1619.97 GiB/s
>> Patched Datasum:        1792.26 GiB/s
>> Diff                    +10.6 %
>>
>> In my case, the bottleneck is the storage, thus the improvement is not
>> reaching the theoretic one, but still some observable improvement.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/bio.c       | 21 +++++++++++----
>>   fs/btrfs/bio.h       |  7 +++++
>>   fs/btrfs/file-item.c | 64 +++++++++++++++++++++++++++++++-------------
>>   fs/btrfs/file-item.h |  2 +-
>>   4 files changed, 69 insertions(+), 25 deletions(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index 5a5f23332c2e..8af2b68c2d53 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -105,6 +105,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>>          /* Make sure we're already in task context. */
>>          ASSERT(in_task());
>>
>> +       if (bbio->async_csum)
>> +               wait_for_completion(&bbio->csum_done);
> 
> Can we do `flush_work(&bbio->csum_work);` instead here and get rid of
> the completion? I believe it is not needed at all.

I tried this idea, unfortunately causing kernel warnings.

It will trigger a warning inside __flush_work(), triggering the warning 
from check_flush_dependency().

It looks like the workqueue we're in (btrfs-endio) has a different 
WQ_MEM_RECLAIM flag for csum_one_bio_work().


I'll keep digging to try to use flush_work() to remove the csum_done, as 
that will keep the size of btrfs_bio unchanged.

Thanks,
Qu

> 
> --nX
> 

>>


