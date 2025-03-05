Return-Path: <linux-btrfs+bounces-12039-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41692A50F0E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 23:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B6BF3A15FE
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EC92066F4;
	Wed,  5 Mar 2025 22:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="PoJr4MmO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C381D8DEE
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215015; cv=none; b=fhtucIwq4ILctfcksGwAgUKvpbmwCdtjKXN9KyS9AAWD31OL5AKyFSPIhew7+QzuAlZEV5hA7Qtsun5KS9pvG+pLqc+2P84TALdxPorGEux1RxUjZKo81HlfKUhbmNwwfxjCopByrOoAcajPeRJ6x0wyr7838eYDwDcBtYT6/p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215015; c=relaxed/simple;
	bh=yFjzSKBlAC/UCHCvJ1bloHll+WandR+miBPzhreQ5Aw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=XlgSg/NLyIb1uQOfHlFa4k5cc7pKCLR+1SOTtDnB1i7Y6XhVO/kmbihMqOzIoVoXkJOpA1zXZ5qAeR52RqIByIuHoSrEafoD1usiJDegQrmzsS14I/B+P+1xby/2T0CZhhe7225jFdHekaE3cr+4g3yqdmbKLEo42993/iJq9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=PoJr4MmO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5dee07e51aaso13798870a12.3
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Mar 2025 14:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741215011; x=1741819811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zifsEKhG7gIna6t8caGy7nZa1Z7SmyLIOtisvPOEduU=;
        b=PoJr4MmO6S/prX5adVULDp2KxQSyOrnxGFdwVpRgxwQ5fJKHWNyB4DLyeyQXAK9KrQ
         Z9hfXiZA1AVydANqaqXju7tjtgC6wJtNaZXNr+NQaliIP1rWH1u4fuegfu9omirqG033
         JV9RLU4IoXdNCSnCvxCIr3oB4Y4/h38qYRaw6yEsSA3CXlLbn2NjN+b03lUkp+sbQlaA
         Ilb84dZtSozprhYwN4b/K9oa7YD+jq2vKAPs7AY8YhR57A856ZxQhGlesE33y4YMk14k
         H77+uYLRvUPcsAg1XKsBTLw5LdWPoizsIIJBqbBboycTQ6gTPYu+Wd601kOb9CByPwZn
         QEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215011; x=1741819811;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zifsEKhG7gIna6t8caGy7nZa1Z7SmyLIOtisvPOEduU=;
        b=mDeLdVfVp8GDgS9PSmLoiU+DJoYk01eHpjk1KBHi/k47fs2E9a33JgJZORLBTvpHha
         OVg/Ejw1pC4nD8ML3aSf3+ovx6Fyk60u/D7hk671jbAyn0Zn80JZel/QD5EJdDUGe1EP
         s2Oq1KWw8jWKKVNeHYbNFbozCwqNyrHepLQTaOyhStp4alWsADFQYVF14ZemBrGgAwXO
         b76B16EneUmQBQZNjqt/nIjeMllY2+kc2GfID+vVaG9zEqKpT02DSM6kgZwl58UIL/7L
         pyn4GCxOjVhVKb6FUUlkUb4+ySpd4wtPVpr73QveyqZjusMRbF4MkvXd3fYwVaKCCfUY
         4oRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpEpD5UmA/rRIMpiY73cHPjXKg/0eH2TLMkEoT20LRMMBvxLBNVEt56R6CJ2ijSZKDIfUOAx41EGSpfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9oEJAXa0mHT9pyFu8UMqwXrX6TbaQ6wuW4paI/HmJ/00mVafS
	1GgxoVN7g7AtfQ27RLig6eebh8wsqBx6BmY6ZEVCfIQ7whDUcXWveN4D7jVN5zCKwCKZsa4BV/u
	1
X-Gm-Gg: ASbGncuxcNOcPPQbU7tj/+trHLmyxsvJ5cyD7q7Ke5lgTWi/zVxlE9MNvGmHfpUnTr6
	THtEWRN9LhssG9cQlrSwv+qIgYSxkDzshSdtasGZnzmrxcuCsy0RSBZ/roK4QlqRvDxP4Cd1u6j
	b0/LhYoSZQqVEt1ZFfNI046gMWC2uCLvvB121XwyKJ4LpcxziSsbVajMBVaviXoid2KcRJbd+As
	J0FNAz4g/dvD4ceQ0hBnlZN/kK5wK+N67aO9NIpYSlzaFGcsyYg18qpqV9ZxHLDqld9Aqlhu2qf
	pgwjrm+H7zAPRlEFUUdefHAYJ2usok9qW7nh9Sl8PE6xpjMmydG2BGUmN9GVAoRZpBhywf+k
X-Google-Smtp-Source: AGHT+IGEym6iUl35My4FdKGnsTKd0r8xUuxQG1CMg6UccEsD7Onf4tdT9dCQoXHBity4pOH/gBzCcg==
X-Received: by 2002:a05:6402:1d55:b0:5e0:8920:c4c5 with SMTP id 4fb4d7f45d1cf-5e59f3d6494mr4750725a12.11.1741215010707;
        Wed, 05 Mar 2025 14:50:10 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73641496007sm8365988b3a.10.2025.03.05.14.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 14:50:10 -0800 (PST)
Message-ID: <674580db-c8c9-4b8c-baf3-3071fa4a2d01@suse.com>
Date: Thu, 6 Mar 2025 09:20:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs: fix non-empty delayed iputs list on unmount
 due to endio workers
From: Qu Wenruo <wqu@suse.com>
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1741198394.git.fdmanana@suse.com>
 <e1cf2949e4b03fba268f923947543bbf4a7b6752.1741198394.git.fdmanana@suse.com>
 <74baca21-ea92-46f1-a85a-d5834eeaa430@suse.com>
Content-Language: en-US
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
In-Reply-To: <74baca21-ea92-46f1-a85a-d5834eeaa430@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/6 09:16, Qu Wenruo 写道:
> 
> 
> 在 2025/3/6 04:47, fdmanana@kernel.org 写道:
>> From: Filipe Manana <fdmanana@suse.com>
>>
>> At close_ctree() after we have ran delayed iputs either through 
>> explicitly
>> calling btrfs_run_delayed_iputs() or later during the call to
>> btrfs_commit_super() or btrfs_error_commit_super(), we assert that the
>> delayed iputs list is empty.
>>
>> Sometimes this assertion may fail because delayed iputs may have been
>> added to the list after we last ran delayed iputs, and this happens due
>> to workers in the endio_workers workqueue still running. These workers 
>> can
>> do a final put on an ordered extent attached to a data bio, which results
>> in adding a delayed iput. This is done at btrfs_bio_end_io() and its
>> helper __btrfs_bio_end_io().
> 
> But the endio_workers workqueue is only utilized by data READ 
> operations, in function btrfs_end_io_wq(), which is called in 
> btrfs_simple_end_io().
> 
> Furthermore, for the endio_workers workqueue, for data inodes it only 
> handles btrfs_check_read_bio(), which shouldn't generate ordered extent 
> either.
> 
> Did I miss something here?

Oh, I missed the recently disabled (for subpage) uncached io.

So I guess the real fixes tag should be that not-yet-upstreamed uncached 
io patch.

Thanks,
Qu

> 
> Thanks,
> Qu
> 
>>
>> Fix this by flushing the endio_workers workqueue before running delayed
>> iputs at close_ctree().
>>
>> David reported this when running generic/648.
>>
>> Reported-by: David Sterba <dsterba@suse.com>
>> Fixes: ec63b84d4611 ("btrfs: add an ordered_extent pointer to struct 
>> btrfs_bio")
>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>> ---
>>   fs/btrfs/disk-io.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index d96ea974ef73..b6194ae97361 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -4340,6 +4340,15 @@ void __cold close_ctree(struct btrfs_fs_info 
>> *fs_info)
>>        */
>>       btrfs_flush_workqueue(fs_info->delalloc_workers);
>> +    /*
>> +     * We can also have ordered extents getting their last reference 
>> dropped
>> +     * from the endio_workers workqueue because for data bios we keep a
>> +     * reference on an ordered extent which gets dropped when running
>> +     * btrfs_bio_end_io() in that workqueue, and that final drop 
>> results in
>> +     * adding a delayed iput for the inode.
>> +     */
>> +    flush_workqueue(fs_info->endio_workers);
>> +
>>       /*
>>        * After we parked the cleaner kthread, ordered extents may have
>>        * completed and created new delayed iputs. If one of the async 
>> reclaim
> 
> 


