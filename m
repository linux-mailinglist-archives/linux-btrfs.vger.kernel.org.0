Return-Path: <linux-btrfs+bounces-18319-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A835BC08354
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 23:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62BDB3AF232
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Oct 2025 21:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DF12FE065;
	Fri, 24 Oct 2025 21:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ax5PsxGu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0F2C21F6
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 21:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761342028; cv=none; b=rsa7r+JILabODnK9YrOhL1lR5K7oO/O4A6nuu5VPwM0xn68wV0aErcHhRlFVOQpiNPcbimRSlKYlb7ee558vfMHbqypAfUeLKIWzJjSane0jA4wVf8htd86aCik6Tm0BOq4QOmfcaUYnZosSbIRlIk0jpxSOjB9+QyrS77ZTvVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761342028; c=relaxed/simple;
	bh=KPcmm/yN1d9mNpsb+mFCbR6gRW6KbKWWBr/lXOTPoJM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2wt5Df0/RDG3ku2n0GtszmMBXczkbhFy4BJwhNbifXLnECMqKdYBXiRE/BOrMYZiUb8HaOybyGaROc//MGjTGNP1p+t3BipGsEjeIITGt7KQz9koygwu2CGrXUqVt82mnKINHhLiR+c2yhWhKvKwMhn2/6oNHK+7r/Ce83JZIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ax5PsxGu; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so1636003f8f.1
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Oct 2025 14:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761342024; x=1761946824; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hz2ex0FhEG8ce7zbmDv+pbdhJ3pEa7gDwvcHoJb7Bxc=;
        b=Ax5PsxGulwC5N0Nj86pS43DAbj5V7Ej8N7oEw9zPGXcBmR9BDzQcwefqQeSybOJsNg
         XbGoD3HmZQn3G7+f33hm/WrHRRFT2VbAkTj+fgvrEs2SwsVGHZUi9E5LXlXuM+vQU+ws
         +V7Vsmt3TsaOqIVQyZOSmE2Cv0bmpq/RXuWCAIMI4KRaqUOm4FUkmQ4/nfcRyvtj0iEO
         DFIq5DedRlzQAO2hj7va+5I1lMxaz/BejvaxaU1boQv9uc81sPBqUruaC4z7+X9mqdM1
         vBgq28xgtPhlA4dv69hczRVy4WadR9fgB/BteudyvyG67ZfyTP/grW0ULv1GbsSRevBu
         tT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761342024; x=1761946824;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hz2ex0FhEG8ce7zbmDv+pbdhJ3pEa7gDwvcHoJb7Bxc=;
        b=sL1nW83WyknAXYLpz6GozvtoWj/eC4XndJfB4mhEFplZwqCkyPqeisggICvYEeHrPn
         7HkJ+jWeyFHTRwHwogOp77e4iptuq682MrGMQ2tpT4Xg3c3dORimcDc9bYQ/vwyjgJIw
         bV2aDdnu9hD+1OpBVBSIo0i44fmQD1+UQEPefdmF8fU1rmpUwvq+XjQQrzQDAVFtTZhr
         /LjqKbYmAgien4SkEz9TcD9v/LXeNdUjUNuENE3XBlod57xZ54tLxMIGaCpqrYylCTYN
         WuVOv2ZbK/vobcQTnuqBcsSiwQoQYybtfVWstSLAOtxehU1v72+L8eRIScTLLpto9m1y
         Or0g==
X-Gm-Message-State: AOJu0YxX32TADyHh0LUdobrD0xu0srvHi+0kof/Gg82Xg2ewfCdKsgnC
	HQSExjsvePFpx7HJodWXYrGdeN9EyJrstQBgK3H9CEJO9jT4nvdAft7ky0CRDS3IHNY=
X-Gm-Gg: ASbGncvuSmBhnjMCVYPUfwjXJVIdDBRE6OzXnWc55PX1UsvYSmKXyLHEcHEMJkaBW7O
	0dAAxJVkKJyH/pVX5uhEvbH3jz3yhyfmQHb4iCKgpIbOMX4N/zoL02D+BhxmHh2f5A6vNVQKQZM
	UAx5e0XUqqasH8iC1l/xTQAl+IRdBEZ0ZylWltHi1tKftMGydzP2HeeDNFFklgKat/JIOdyqMqg
	Pnl+4gYUt7vcP15BevJuF/rdfeX6LNk8S353dVq4B/yzpZ4ptwrfRj/XeeIWPVuJYxv/9Z+KaLw
	Ar7qa4GZ8C4AqgJ64a6h0bfo0mO8rcueeKwPxDAqlCszZSRnCN3w1cqgLgG4juQ21xmgyEhUnDI
	nu9jPLOK2TR0qLPD/rjXPlSAf3aS62mWVr0aRHw2rV3SMsX08NIrvxt+OEcHC7wp9OpnHj5Fy1g
	fBzTZ5utECcKoTQfBG5v4rrAdbc4LytL3UC6SF1+A=
X-Google-Smtp-Source: AGHT+IE9c+4igLwSyckSlTyecK6QKYF4Uy2g+qy6vHrqQSjCthHVBuFdBlH0dj70VxHQEE/MGY/1tw==
X-Received: by 2002:a5d:5f91:0:b0:429:66bd:3caa with SMTP id ffacd0b85a97d-42990746eb3mr3266366f8f.49.1761342023367;
        Fri, 24 Oct 2025 14:40:23 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414072487sm206568b3a.52.2025.10.24.14.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 14:40:22 -0700 (PDT)
Message-ID: <5eeb4eea-cd2d-4145-9e0b-d3cee300984a@suse.com>
Date: Sat, 25 Oct 2025 08:10:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] btrfs: introduce btrfs_bio::async_csum
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1761302592.git.wqu@suse.com>
 <44a1532190aee561c2a8ae7af9f84fc1e092ae9e.1761302592.git.wqu@suse.com>
 <aPuSQ/fZyE/4LRQ7@devvm12410.ftw0.facebook.com>
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
In-Reply-To: <aPuSQ/fZyE/4LRQ7@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/10/25 01:21, Boris Burkov 写道:
> On Fri, Oct 24, 2025 at 09:19:35PM +1030, Qu Wenruo wrote:
>> [ENHANCEMENT]
>> Btrfs currently calculate its data checksum then submit the bio.
>>
>> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered write
>> if the inode requires checksum"), any writes with data checksum will
>> fallback to buffered IO, meaning the content will not change during
>> writeback.
>>
>> This means we're safe to calculate the data checksum and submit the bio
>> in parallel, we only need to make sure btrfs_bio::end_io() is called
>> after the checksum calculation is done.
>>
>> As usual, such new feature is hidden behind the experimental flag.
>>
>> [THEORETIC ANALYZE]
>> Consider the following theoretic hardware performance, which should be
>> more or less close to modern mainstream hardware:
>>
>> 	Memory bandwidth:	50GiB/s
>> 	CRC32C bandwidth:	45GiB/s
>> 	SSD bandwidth:		8GiB/s
>>
>> Then btrfs write bandwidth with data checksum before the patch would be
>>
>> 	1 / ( 1 / 50 + 1 / 45 + 1 / 8) = 5.98 GiB/s
>>
>> After the patch, the bandwidth would be:
>>
>> 	1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) = 6.90 GiB/s
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
>> Vanilla Datasum:	1619.97 GiB/s
>> Patched Datasum:	1792.26 GiB/s
>> Diff			+10.6 %
>>
>> In my case, the bottleneck is the storage, thus the improvement is not
>> reaching the theoretic one, but still some observable improvement.
> 
> This is really awesome! Makes me think we could also async the read csum
> lookup...

Yes, lookup can be delayed, but I'm afraid that's the limit, and the 
improvement may not be that huge?

> 
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/bio.c       | 17 ++++++++----
>>   fs/btrfs/bio.h       |  5 ++++
>>   fs/btrfs/file-item.c | 61 +++++++++++++++++++++++++++++++-------------
>>   fs/btrfs/file-item.h |  2 +-
>>   4 files changed, 61 insertions(+), 24 deletions(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index 18272ef4b4d8..a5b83c6c9e7f 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -103,6 +103,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>>   	/* Make sure we're already in task context. */
>>   	ASSERT(in_task());
>>   
>> +	if (bbio->async_csum)
>> +		wait_for_completion(&bbio->csum_done);
>> +
> 
> This is a principled way to do it; ensure the whole endio path has the
> csums. However, as far as I know, the only place that the sums are only
> needed at finish_ordered_io when we call add_pending_csums() from
> btrfs_finish_one_ordered(), which is already able to block.

The problem is crossing layers.

btrfs_csum_bio() is called for each splitted bio range, thus I'd prefer 
to do the wait for csum at the same layer, inside btrfs bio layer, and 
not expose it to higher layers.

> 
> So I think you could separate the need to change the workers from the
> async csums if you delay the async csum wait until add_pending_csum. It
> might be a little annoying to have to recover the bbio/wait context from
> the ordered_extent with container_of, but I'm sure it can be managed.

I think it's possible to delay the wait to the whole bbio (the original 
range without split).
Using an extra atomic to track the amount of pending async csums would 
handle it.

But I'll still need to check if this will make it much harder to read.
I have already spent too much time debugging various bugs related to 
where the wait should be placed, the existing code style and lack of 
comments are definitely not helping.

> 
> One other "benefit" is that it technically delays the wait even further,
> till the absolute last second, so it is strictly less waiting, though I
> wouldn't expect any real benefit from that in practice.

Yep, that's true, and also why I still prefer to keep it contained 
inside bio layer.

Thanks,
Qu

> 
> Thanks,
> Boris
> 
>>   	bbio->bio.bi_status = status;
>>   	if (bbio->bio.bi_pool == &btrfs_clone_bioset) {
>>   		struct btrfs_bio *orig_bbio = bbio->private;
>> @@ -535,7 +538,7 @@ static int btrfs_bio_csum(struct btrfs_bio *bbio)
>>   {
>>   	if (bbio->bio.bi_opf & REQ_META)
>>   		return btree_csum_one_bio(bbio);
>> -	return btrfs_csum_one_bio(bbio);
>> +	return btrfs_csum_one_bio(bbio, true);
>>   }
>>   
>>   /*
>> @@ -613,10 +616,14 @@ static bool should_async_write(struct btrfs_bio *bbio)
>>   	struct btrfs_fs_devices *fs_devices = bbio->fs_info->fs_devices;
>>   	enum btrfs_offload_csum_mode csum_mode = READ_ONCE(fs_devices->offload_csum_mode);
>>   
>> -	if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_OFF)
>> -		return false;
>> -
>> -	auto_csum_mode = (csum_mode == BTRFS_OFFLOAD_CSUM_AUTO);
>> +	if (csum_mode == BTRFS_OFFLOAD_CSUM_FORCE_ON)
>> +		return true;
>> +	/*
>> +	 * Write bios will calculate checksum and submit bio at the same time.
>> +	 * Unless explicitly required don't offload serial csum calculate and bio
>> +	 * submit into a workqueue.
>> +	 */
>> +	return false;
>>   #endif
>>   
>>   	/* Submit synchronously if the checksum implementation is fast. */
>> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
>> index 00883aea55d7..277f2ac090d9 100644
>> --- a/fs/btrfs/bio.h
>> +++ b/fs/btrfs/bio.h
>> @@ -60,6 +60,8 @@ struct btrfs_bio {
>>   		struct {
>>   			struct btrfs_ordered_extent *ordered;
>>   			struct btrfs_ordered_sum *sums;
>> +			struct work_struct csum_work;
>> +			struct completion csum_done;
>>   			u64 orig_physical;
>>   		};
>>   
>> @@ -84,6 +86,9 @@ struct btrfs_bio {
>>   
>>   	/* Use the commit root to look up csums (data read bio only). */
>>   	bool csum_search_commit_root;
>> +
>> +	bool async_csum;
>> +
>>   	/*
>>   	 * This member must come last, bio_alloc_bioset will allocate enough
>>   	 * bytes for entire btrfs_bio but relies on bio being last.
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index a42e6d54e7cd..bedfcf4a088d 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -18,6 +18,7 @@
>>   #include "fs.h"
>>   #include "accessors.h"
>>   #include "file-item.h"
>> +#include "volumes.h"
>>   
>>   #define __MAX_CSUM_ITEMS(r, size) ((unsigned long)(((BTRFS_LEAF_DATA_SIZE(r) - \
>>   				   sizeof(struct btrfs_item) * 2) / \
>> @@ -764,21 +765,46 @@ int btrfs_lookup_csums_bitmap(struct btrfs_root *root, struct btrfs_path *path,
>>   	return ret;
>>   }
>>   
>> -/*
>> - * Calculate checksums of the data contained inside a bio.
>> - */
>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio)
>> +static void csum_one_bio(struct btrfs_bio *bbio)
>>   {
>> -	struct btrfs_ordered_extent *ordered = bbio->ordered;
>>   	struct btrfs_inode *inode = bbio->inode;
>>   	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
>>   	struct bio *bio = &bbio->bio;
>> -	struct btrfs_ordered_sum *sums;
>> +	struct btrfs_ordered_sum *sums = bbio->sums;
>>   	struct bvec_iter iter = bio->bi_iter;
>>   	phys_addr_t paddr;
>>   	const u32 blocksize = fs_info->sectorsize;
>> -	int index;
>> +	int index = 0;
>> +
>> +	shash->tfm = fs_info->csum_shash;
>> +
>> +	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
>> +		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
>> +		index += fs_info->csum_size;
>> +	}
>> +}
>> +
>> +static void csum_one_bio_work(struct work_struct *work)
>> +{
>> +	struct btrfs_bio *bbio = container_of(work, struct btrfs_bio, csum_work);
>> +
>> +	ASSERT(btrfs_op(&bbio->bio) == BTRFS_MAP_WRITE);
>> +	ASSERT(bbio->async_csum == true);
>> +	csum_one_bio(bbio);
>> +	complete(&bbio->csum_done);
>> +}
>> +
>> +/*
>> + * Calculate checksums of the data contained inside a bio.
>> + */
>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async)
>> +{
>> +	struct btrfs_ordered_extent *ordered = bbio->ordered;
>> +	struct btrfs_inode *inode = bbio->inode;
>> +	struct btrfs_fs_info *fs_info = inode->root->fs_info;
>> +	struct bio *bio = &bbio->bio;
>> +	struct btrfs_ordered_sum *sums;
>>   	unsigned nofs_flag;
>>   
>>   	nofs_flag = memalloc_nofs_save();
>> @@ -789,21 +815,20 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio)
>>   	if (!sums)
>>   		return -ENOMEM;
>>   
>> +	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>>   	sums->len = bio->bi_iter.bi_size;
>>   	INIT_LIST_HEAD(&sums->list);
>> -
>> -	sums->logical = bio->bi_iter.bi_sector << SECTOR_SHIFT;
>> -	index = 0;
>> -
>> -	shash->tfm = fs_info->csum_shash;
>> -
>> -	btrfs_bio_for_each_block(paddr, bio, &iter, blocksize) {
>> -		btrfs_calculate_block_csum(fs_info, paddr, sums->sums + index);
>> -		index += fs_info->csum_size;
>> -	}
>> -
>>   	bbio->sums = sums;
>>   	btrfs_add_ordered_sum(ordered, sums);
>> +
>> +	if (!async) {
>> +		csum_one_bio(bbio);
>> +		return 0;
>> +	}
>> +	init_completion(&bbio->csum_done);
>> +	bbio->async_csum = true;
>> +	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
>> +	schedule_work(&bbio->csum_work);
>>   	return 0;
>>   }
>>   
>> diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
>> index 63216c43676d..2a250cf8b2a1 100644
>> --- a/fs/btrfs/file-item.h
>> +++ b/fs/btrfs/file-item.h
>> @@ -64,7 +64,7 @@ int btrfs_lookup_file_extent(struct btrfs_trans_handle *trans,
>>   int btrfs_csum_file_blocks(struct btrfs_trans_handle *trans,
>>   			   struct btrfs_root *root,
>>   			   struct btrfs_ordered_sum *sums);
>> -int btrfs_csum_one_bio(struct btrfs_bio *bbio);
>> +int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool async);
>>   int btrfs_alloc_dummy_sum(struct btrfs_bio *bbio);
>>   int btrfs_lookup_csums_range(struct btrfs_root *root, u64 start, u64 end,
>>   			     struct list_head *list, int search_commit,
>> -- 
>> 2.51.0
>>


