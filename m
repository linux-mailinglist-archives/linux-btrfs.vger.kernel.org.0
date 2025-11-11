Return-Path: <linux-btrfs+bounces-18876-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BAEC4FB76
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 21:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84207189FB6C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Nov 2025 20:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEB92620FC;
	Tue, 11 Nov 2025 20:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uh6bNUb3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2E33D6C4
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762893225; cv=none; b=oO7AJzApEGjBTewHarTybOkW9nGKycqhevxrFYmBbHgNY2+Ab1fagy3wlHbWX4Vr8VSGzbdEFw0ovkmBWqwFnGS/khkTnj9/1aTJrXnX8yY8ZDehdf7mbZGgj3X1cLUksvM7I+hZ24tdo1/dMD1lGAquwduNthsiqdjhsQIA+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762893225; c=relaxed/simple;
	bh=9Yombnnn2xpKX/Yu+p73t7sP9t0cY25GYN04Zhk6zG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQJO1r5SBrMQW+FBEl9zrZRMlSnDXzNJJrEtnKzszik3VHfTinJlt3cPoXN69c5GnSV7XXDeqOw4wCHD9Ruxae9tuylQ/R3D1kkFvq1m+XQJ1l16/pPFIxnD93bV3FPGQr8RkgD9wz2LyCfnC8iIKMMU8S3tubh+eE+KZTnSfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uh6bNUb3; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47777000dadso970525e9.1
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Nov 2025 12:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762893221; x=1763498021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0Od0GSa0MVlPBe5xmkNF33DpfJt61QjqkSvM8pAR+YY=;
        b=Uh6bNUb3Pa7TmSILsU40B672QTfEf5GvSQeaTyBH/hwmhfdlPMebmlEQHLCAWqe0oi
         eZPmn/LMZvr/u8xTZsyXmbc8E60osLFK1rRGbVWwuXZ31nzM6JJyorOLaCKPEESFp0OB
         fWtca9gd5OvatyQ3Mr+5CdZM7/FQiPJDdn5bKtqRfRQ10VszDDO+1eR/Jh0UeSM/va9n
         boLB52qrY0B3C1J+TUea0ZfsB9YJeU6n0v4YO5QDUKK0vTA08vi925C4NQHZYBsxcOj/
         CrxU8shHEFdrZapjh8WVzUDHDFt8ZXfFyL1fku0/eFYVOrGeFU6xHzgb/Yk5ZkPcoplT
         WtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762893221; x=1763498021;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Od0GSa0MVlPBe5xmkNF33DpfJt61QjqkSvM8pAR+YY=;
        b=I1FAK3idUwKRe6w0fZ5i42AYb6mJ1qBCihE62jszGWoZq5vmugLIpGcQLmkOQUKovi
         1lITRMYBtIcuY1qwIzjN5wUCxAdMcFKI/SQr6CCzKf6p7lFfvBglY+Qpdoh/+r1ol/JW
         7DfJrO69kVXEnD8qzcIkQ1X3EQRsmDSQgciizB/7aNI3ono8QC4NoLm0gOHuhDA/lBFc
         rp9ayDekwh7Zi81wiLm0EJeLYMVFCnAT2ZfDZTLJX+qD8Y4pQT7d8ZPvcsSL7P4l8/7S
         u8NwIL1XERqrVqv/qlAsEJcA+aBG0EAuzhXqpzKrRL9pwX4kvJY+Yi9n8iAUsBZahnIx
         T7CQ==
X-Gm-Message-State: AOJu0Yxo+BNHJ256thvHCOspwnv8Au8CWJLa2JOVZS9JDaMuxkk+rWky
	vPAQl04GVJYvNt+fwufMgZjtw/SbNRqQDA/iOnjesykMUP5+8muZgBxzqGaY5BR4f0ZXfMfQoiD
	bxYxS
X-Gm-Gg: ASbGncv+bBL3ZRpUBjqfUXS0TRcpIJyf0QQ4TG6DUbVwWlQen8eDgMYixVAU606jFtC
	yrllkeVqm1+xnLqoDNrvSlo53YrbEb8ab6ksvGtLWMxQ9Ls6ZaGAcG6x7iWHnyvojmO4GkMXUH+
	aBTHfkNqGQcYXYGtE/yGVjiVgkRY+D74MCNufz9M3zN8XeOeCH3hc/Ei8Ei1gQNSNuZrjNn70PH
	vX0PT8/a+6welS2jink7tIJ3AM8WUg0r1nWFchyF+/7xubOFL0mBlvm6LJB/nMFWRhBGTgAPExH
	JCrW/yLD1LoHNP0kf5d2K6x8tJta1bV9WcqV8tjWmEgvn5z+mfd67oHdxKOFK9OdlHB9ylP43kL
	6SuFmm0p40tzR9KPBgHGYWlmFIOwNZi9GBhbmclN1VfRCEeH+6Bh0Nv+y7UpWa3Ir40SlM1c4Vf
	BG8Xnu55SXW5QqGO46PGlpcr/MX5aNAHikzTMGa65qf66hk0KJcw==
X-Google-Smtp-Source: AGHT+IEokYL6wy3NXN0c2InUfysWit8DSI0aif6di9GYvUMquiNS02+yGnOx888mN+31U2rIxRRMVw==
X-Received: by 2002:a5d:5d11:0:b0:42b:3bfc:d5cd with SMTP id ffacd0b85a97d-42b4bb8bb43mr396081f8f.1.1762893221271;
        Tue, 11 Nov 2025 12:33:41 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a696d978sm22010670a91.11.2025.11.11.12.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:33:40 -0800 (PST)
Message-ID: <a18a5937-a1c2-41a4-9261-5b337ccbfbf2@suse.com>
Date: Wed, 12 Nov 2025 07:03:36 +1030
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
 <c6252c65-5106-45e6-b75a-dab09e4faa52@suse.com>
 <CAPjX3FfY+Ov5sksn+e7hEFbUTWf8ROs6RNEj4-_1iwgx1xfD8w@mail.gmail.com>
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
In-Reply-To: <CAPjX3FfY+Ov5sksn+e7hEFbUTWf8ROs6RNEj4-_1iwgx1xfD8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/11 23:08, Daniel Vacek 写道:
> On Mon, 10 Nov 2025 at 22:05, Qu Wenruo <wqu@suse.com> wrote:
>> 在 2025/11/11 05:10, Daniel Vacek 写道:
>>> On Wed, 29 Oct 2025 at 06:43, Qu Wenruo <wqu@suse.com> wrote:
>>>>
>>>> [ENHANCEMENT]
>>>> Btrfs currently calculate its data checksum then submit the bio.
>>>>
>>>> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered write
>>>> if the inode requires checksum"), any writes with data checksum will
>>>> fallback to buffered IO, meaning the content will not change during
>>>> writeback.
>>>>
>>>> This means we're safe to calculate the data checksum and submit the bio
>>>> in parallel, and only need the following new behaviors:
>>>>
>>>> - Wait the csum generation to finish before calling btrfs_bio::end_io()
>>>>     Or we can lead to use-after-free for the csum generation worker.
>>>>
>>>> - Save the current bi_iter for csum_one_bio()
>>>>     As the submission part can advance btrfs_bio::bio.bi_iter, if not
>>>>     saved csum_one_bio() may got an empty bi_iter and do not generate any
>>>>     checksum.
>>>>
>>>>     Unfortunately this means we have to increase the size of btrfs_bio for
>>>>     16 bytes.
>>>>
>>>> As usual, such new feature is hidden behind the experimental flag.
>>>>
>>>> [THEORETIC ANALYZE]
>>>> Consider the following theoretic hardware performance, which should be
>>>> more or less close to modern mainstream hardware:
>>>>
>>>>           Memory bandwidth:       50GiB/s
>>>>           CRC32C bandwidth:       45GiB/s
>>>>           SSD bandwidth:          8GiB/s
>>>>
>>>> Then btrfs write bandwidth with data checksum before the patch would be
>>>>
>>>>           1 / ( 1 / 50 + 1 / 45 + 1 / 8) = 5.98 GiB/s
>>>>
>>>> After the patch, the bandwidth would be:
>>>>
>>>>           1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) = 6.90 GiB/s
>>>>
>>>> The difference would be 15.32 % improvement.
>>>>
>>>> [REAL WORLD BENCHMARK]
>>>> I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 vCPUs, the
>>>> storage is backed by a PCIE gen3 x4 NVME SSD.
>>>>
>>>> The test is a direct IO write, with 1MiB block size, write 7GiB data
>>>> into a btrfs mount with data checksum. Thus the direct write will fallback
>>>> to buffered one:
>>>>
>>>> Vanilla Datasum:        1619.97 GiB/s
>>>> Patched Datasum:        1792.26 GiB/s
>>>> Diff                    +10.6 %
>>>>
>>>> In my case, the bottleneck is the storage, thus the improvement is not
>>>> reaching the theoretic one, but still some observable improvement.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/bio.c       | 21 +++++++++++----
>>>>    fs/btrfs/bio.h       |  7 +++++
>>>>    fs/btrfs/file-item.c | 64 +++++++++++++++++++++++++++++++-------------
>>>>    fs/btrfs/file-item.h |  2 +-
>>>>    4 files changed, 69 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>>>> index 5a5f23332c2e..8af2b68c2d53 100644
>>>> --- a/fs/btrfs/bio.c
>>>> +++ b/fs/btrfs/bio.c
>>>> @@ -105,6 +105,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>>>>           /* Make sure we're already in task context. */
>>>>           ASSERT(in_task());
>>>>
>>>> +       if (bbio->async_csum)
>>>> +               wait_for_completion(&bbio->csum_done);
>>>
>>> Can we do `flush_work(&bbio->csum_work);` instead here and get rid of
>>> the completion? I believe it is not needed at all.
>>
>> I tried this idea, unfortunately causing kernel warnings.
>>
>> It will trigger a warning inside __flush_work(), triggering the warning
>> from check_flush_dependency().
>>
>> It looks like the workqueue we're in (btrfs-endio) has a different
>> WQ_MEM_RECLAIM flag for csum_one_bio_work().
> 
> If I read the code correctly that would be solved using the
> btrfs_end_io_wq instead of system wq (ie. queue_work() instead of
> schedule_work()).

That will cause dependency problems. The endio work now depends on the 
csum work, which are both executed on the same workqueue.
If the max_active is 1, endio work will deadlock waiting for the csum one.

> 
>> +       init_completion(&bbio->csum_done);
>> +       bbio->async_csum = true;
>> +       bbio->csum_saved_iter = bbio->bio.bi_iter;
>> +       INIT_WORK(&bbio->csum_work, csum_one_bio_work);
>> +       schedule_work(&bbio->csum_work);
> 
> queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->csum_work);

Nope, I even created a new workqueue for the csum work, and it doesn't 
workaround the workqueue dependency check.

The check inside check_flush_dependency() is:

         WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
                               (WQ_MEM_RECLAIM | __WQ_LEGACY)) == 
WQ_MEM_RECLAIM),

It means the worker can not have WQ_MEM_RECLAIM flag at all. (unless it 
also has the LEGACY flag)

So nope, the flush_work() idea won't work inside any current btrfs 
workqueue, which all have WQ_MEM_RECLAIM flag set.

What we need is to make endio_workers and rmw_workers to get rid of 
WQ_MEM_RECLAIM, but that is a huge change and may not even work.

Thanks,
Qu

> 
>> I'll keep digging to try to use flush_work() to remove the csum_done, as
>> that will keep the size of btrfs_bio unchanged.
>>
>> Thanks,
>> Qu
>>
>>>
>>> --nX
>>>
>>
>>>>
>>


