Return-Path: <linux-btrfs+bounces-18917-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D2AC545FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 21:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7CACA343E50
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 20:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A5129B8E1;
	Wed, 12 Nov 2025 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D1dZkjk2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ADC2A1AA
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978320; cv=none; b=P3mbuwRhfdTY+5G7JQi8lZaz4AxLaTew6E40uPvIJT0PZCaRrRLq9C1Xb39jQjc27UA/Nm8lqs5btxNGDFndtpRCd0Kj8JS2I7saup4OWvXeCXEIDVn/thMG0PQ61OpxsGRwXO26MeZ4HNsO4HqZT/pL54D7DdL9BGa9slcIW7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978320; c=relaxed/simple;
	bh=gw5yopuodLn3FPGlFgb61hH6ImXr8O/oSCreWRQNpLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6DI5Z6yQovPG0eeHG86zK/WOA7z+vrkSZfsntcElP1O2qQ4Ml4/ltKRpllj8VnOYUW3m+UXZ9Lc+9kXaMHNtrggT0CxKacCfzSdBiZq3bCuO2g4PgVCP5/ii/LfIp4xuVLvZtf0RuK8Xx4Q7DkcBylkqKLuR8TAjLDsnuRpOWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D1dZkjk2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so1089385e9.1
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 12:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762978316; x=1763583116; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kBz/CoOvlrVApWSql6KTfuW4uUMRBI0yi5QY8H8R4Fo=;
        b=D1dZkjk2Y2HaNNDozTiN7sJQi18izLZBNcn0Sd4IAPpTxGBQDZpCavRw7HmJQCkD6x
         b583+2QUjC+pnlNxOj9dHINYkSu3wHg3DBPpp2Vo+Y6uzG6dPZ86qcaLfa4YvteMvNwG
         OYDSAmhMuY8fFLANXmo6TlG+AJyZcxDDCv0iXI9CO7vW1okYJ3GO8eAC+Vvq6wVPju4+
         gq5VdewF/16uijPHJ7RUq6mIN7rO/dRFJVAYn46g/tXmSUOYWYj6JCmj4SY7fT1EUS9a
         b6RDnQph9e0p5+t9sYbbkPvAUlmn2E04pY1Tl9I5fYeTUGdQDu0MOyI2dALTzBj2x00y
         YmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978316; x=1763583116;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBz/CoOvlrVApWSql6KTfuW4uUMRBI0yi5QY8H8R4Fo=;
        b=euXDOg3ZC3Zk4FdH+9qDZeGeNxDOtiBhKciMXBORZTl6cyaeEbqB47GnuQo7nKGFHb
         iM3Cpwz/Qr15gkzGXmDt7dPnVn+bnU3Fapd5DqZ+uUtN+4+DcJrpT/prqqBeJmoBamb2
         GVHwit4Az2eUSBHrnUSqux5CeyhKTvsnYuP34gIhuduXIYAuNKOreSLQuB4hsxbGRlD7
         IPLSqX3xmruLHfr/rYIRxrBZlLkME/s04CbrTJQ0ATUaf9gcvBLnGyd7N7VxsiA+e6th
         QtM2Tofdjj9HEbqTjB44rfa9PIPNADW4+zwTR8ltbxFL/3DJM7RhhF7vedIZjpULR0Sh
         Ppuw==
X-Gm-Message-State: AOJu0YxVaTR6A/HzvVTHIdYfChkz2hwhgwTvbDm9yr0eVMF3cjw3SCXm
	KvgnKNF8tZlQVSw9y45LX2DVe89A96VlkMcmPM8eT21FIyRNwHtCLlXHah5iwSLVDcdEtAPRHlw
	n07Bz
X-Gm-Gg: ASbGncun0rM1j8yFl3cySytSiEJGtgDLwm9T20Qj1fvMx4bOdhnTwTcoTzD7MoKggwD
	IpC2zvKjcZKTwKqJc/RSUKeLe3qNtFpfSnBXD2Yug8D4pd6sIXpbXQmqZKRSrv6UYxP2eGrloRn
	kIIsxG9CLLS23vP9jWA38V5RqDTnKnHu2uOTbAujphnIS3pYAnk1gosVjx0hyyshB/UijIV8yzC
	+tbtMOnRa8prihXyjpBXHJMcVszHXo3BD7SVL3mEFAXjzjCa4TQdGwf9eHzwiJvsn2iawg2GFw4
	kchBbfUrsluWKg3UMR/CX7EQC5L5p55lJeACVjw7PtMBOhvbv8TXaJMESHHEhYQQsdHFz65YCWJ
	9762uS7IQNCr2kNmlPwBuKu5/EqzH7DuBhZHrLconSNOjgIP3whISdnJneE9DoZGyfP2Pe+hdlk
	AL8+mggB/BYRevPDSs8/sM3AOQ7C7M
X-Google-Smtp-Source: AGHT+IEPPHAVpR/dJpT1IJ6esL/jCDOMDrOrQTJgP8RhktWhT/ilJpl6bcDG7bkiT8p699sNKQWCWQ==
X-Received: by 2002:a05:600c:3790:b0:475:e067:f23d with SMTP id 5b1f17b1804b1-477870c52a3mr27157995e9.25.1762978316018;
        Wed, 12 Nov 2025 12:11:56 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ca1e7b19sm19308558b3a.32.2025.11.12.12.11.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 12:11:55 -0800 (PST)
Message-ID: <c4d28607-702b-4817-ad94-2d52d529e344@suse.com>
Date: Thu, 13 Nov 2025 06:41:52 +1030
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
 <a18a5937-a1c2-41a4-9261-5b337ccbfbf2@suse.com>
 <CAPjX3FfKhYfWd00m-3VMqSE4v-tJYePfE-A3G3cCjTx7F+B3Vg@mail.gmail.com>
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
In-Reply-To: <CAPjX3FfKhYfWd00m-3VMqSE4v-tJYePfE-A3G3cCjTx7F+B3Vg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/11/12 21:16, Daniel Vacek 写道:
> On Tue, 11 Nov 2025 at 21:33, Qu Wenruo <wqu@suse.com> wrote:
>> 在 2025/11/11 23:08, Daniel Vacek 写道:
>>> On Mon, 10 Nov 2025 at 22:05, Qu Wenruo <wqu@suse.com> wrote:
>>>> 在 2025/11/11 05:10, Daniel Vacek 写道:
>>>>> On Wed, 29 Oct 2025 at 06:43, Qu Wenruo <wqu@suse.com> wrote:
>>>>>>
>>>>>> [ENHANCEMENT]
>>>>>> Btrfs currently calculate its data checksum then submit the bio.
>>>>>>
>>>>>> But after commit 968f19c5b1b7 ("btrfs: always fallback to buffered write
>>>>>> if the inode requires checksum"), any writes with data checksum will
>>>>>> fallback to buffered IO, meaning the content will not change during
>>>>>> writeback.
>>>>>>
>>>>>> This means we're safe to calculate the data checksum and submit the bio
>>>>>> in parallel, and only need the following new behaviors:
>>>>>>
>>>>>> - Wait the csum generation to finish before calling btrfs_bio::end_io()
>>>>>>      Or we can lead to use-after-free for the csum generation worker.
>>>>>>
>>>>>> - Save the current bi_iter for csum_one_bio()
>>>>>>      As the submission part can advance btrfs_bio::bio.bi_iter, if not
>>>>>>      saved csum_one_bio() may got an empty bi_iter and do not generate any
>>>>>>      checksum.
>>>>>>
>>>>>>      Unfortunately this means we have to increase the size of btrfs_bio for
>>>>>>      16 bytes.
>>>>>>
>>>>>> As usual, such new feature is hidden behind the experimental flag.
>>>>>>
>>>>>> [THEORETIC ANALYZE]
>>>>>> Consider the following theoretic hardware performance, which should be
>>>>>> more or less close to modern mainstream hardware:
>>>>>>
>>>>>>            Memory bandwidth:       50GiB/s
>>>>>>            CRC32C bandwidth:       45GiB/s
>>>>>>            SSD bandwidth:          8GiB/s
>>>>>>
>>>>>> Then btrfs write bandwidth with data checksum before the patch would be
>>>>>>
>>>>>>            1 / ( 1 / 50 + 1 / 45 + 1 / 8) = 5.98 GiB/s
>>>>>>
>>>>>> After the patch, the bandwidth would be:
>>>>>>
>>>>>>            1 / ( 1 / 50 + max( 1 / 45 + 1 / 8)) = 6.90 GiB/s
>>>>>>
>>>>>> The difference would be 15.32 % improvement.
>>>>>>
>>>>>> [REAL WORLD BENCHMARK]
>>>>>> I'm using a Zen5 (HX 370) as the host, the VM has 4GiB memory, 10 vCPUs, the
>>>>>> storage is backed by a PCIE gen3 x4 NVME SSD.
>>>>>>
>>>>>> The test is a direct IO write, with 1MiB block size, write 7GiB data
>>>>>> into a btrfs mount with data checksum. Thus the direct write will fallback
>>>>>> to buffered one:
>>>>>>
>>>>>> Vanilla Datasum:        1619.97 GiB/s
>>>>>> Patched Datasum:        1792.26 GiB/s
>>>>>> Diff                    +10.6 %
>>>>>>
>>>>>> In my case, the bottleneck is the storage, thus the improvement is not
>>>>>> reaching the theoretic one, but still some observable improvement.
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>>     fs/btrfs/bio.c       | 21 +++++++++++----
>>>>>>     fs/btrfs/bio.h       |  7 +++++
>>>>>>     fs/btrfs/file-item.c | 64 +++++++++++++++++++++++++++++++-------------
>>>>>>     fs/btrfs/file-item.h |  2 +-
>>>>>>     4 files changed, 69 insertions(+), 25 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>>>>>> index 5a5f23332c2e..8af2b68c2d53 100644
>>>>>> --- a/fs/btrfs/bio.c
>>>>>> +++ b/fs/btrfs/bio.c
>>>>>> @@ -105,6 +105,9 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_status_t status)
>>>>>>            /* Make sure we're already in task context. */
>>>>>>            ASSERT(in_task());
>>>>>>
>>>>>> +       if (bbio->async_csum)
>>>>>> +               wait_for_completion(&bbio->csum_done);
>>>>>
>>>>> Can we do `flush_work(&bbio->csum_work);` instead here and get rid of
>>>>> the completion? I believe it is not needed at all.
>>>>
>>>> I tried this idea, unfortunately causing kernel warnings.
>>>>
>>>> It will trigger a warning inside __flush_work(), triggering the warning
>>>> from check_flush_dependency().
>>>>
>>>> It looks like the workqueue we're in (btrfs-endio) has a different
>>>> WQ_MEM_RECLAIM flag for csum_one_bio_work().
>>>
>>> If I read the code correctly that would be solved using the
>>> btrfs_end_io_wq instead of system wq (ie. queue_work() instead of
>>> schedule_work()).
>>
>> That will cause dependency problems. The endio work now depends on the
>> csum work, which are both executed on the same workqueue.
>> If the max_active is 1, endio work will deadlock waiting for the csum one.
> 
> When the csum work is being queued the bio was not even submitted yet.
> The chances are the csum work will be done even before the bio ends
> and the end io work is queued. But even if csum work is not done yet
> (or even started due to scheduling delays or previous (unrelated)
> worker still being blocked), it's always serialized before the end io
> work. So IIUC, there should be no deadlock possible. Unless I'm still
> missing something, workqueues could be tricky.
> 
>>>> +       init_completion(&bbio->csum_done);
>>>> +       bbio->async_csum = true;
>>>> +       bbio->csum_saved_iter = bbio->bio.bi_iter;
>>>> +       INIT_WORK(&bbio->csum_work, csum_one_bio_work);
>>>> +       schedule_work(&bbio->csum_work);
>>>
>>> queue_work(btrfs_end_io_wq(fs_info, bio), &bbio->csum_work);
>>
>> Nope, I even created a new workqueue for the csum work, and it doesn't
>> workaround the workqueue dependency check.
> 
> Did you create it with the WQ_MEM_RECLAIM flag? As like:
> 
> alloc_workqueue("btrfs-async-csum", ... | WQ_MEM_RECLAIM, ...);

Yes.

> 
> I don't see how that would trigger the warning. See below for a
> detailed explanation.

It's not the workqueue running the csum work, but the workqueue running 
the flush_work().

> 
>> The check inside check_flush_dependency() is:
>>
>>           WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
>>                                 (WQ_MEM_RECLAIM | __WQ_LEGACY)) ==
>> WQ_MEM_RECLAIM),
>>
>> It means the worker can not have WQ_MEM_RECLAIM flag at all. (unless it
>> also has the LEGACY flag)
> 
> I understand that if the work is queued on a wq with WQ_MEM_RECLAIM,
> the check_flush_dependency() returns early. Hence no need to worry
> about the warning's condition as it's no longer of any concern.

You can just try to use flush_work() and test it by yourself.

I have tried my best to explain it, but it looks like it's at my limit.

Just try a patch removing the csum_wait, and use flush_work() instead of 
wait_for_completion().

Then you'll see the problem I'm hitting.

Thanks,
Qu

> 
>> So nope, the flush_work() idea won't work inside any current btrfs
>> workqueue, which all have WQ_MEM_RECLAIM flag set.
> 
> With the above being said, I still see two possible solutions.
> Either using the btrfs_end_io_wq() as suggested before. It should be safe, IMO.
> Or, if you're still worried about possible deadlocks, creating a new
> dedicated wq which also has the WQ_MEM_RECLAIM set (which is needed
> for compatibility with the context where we want to call the
> flush_work()).
> 
> Both ways could help getting rid of the completion in btrfs_bio, which
> is 32 bytes by itself.
> 
> What do I miss?
> 
> Out of curiosity, flush_work() internally also uses completion in
> pretty much exactly the same way as in this patch, but it's on the
> caller's stack (in this case on the stack which would call the
> btrfs_bio_end_io() modified with flush_work()). So in the end the
> effect would be like moving the completion from btrfs_bio to a stack.
> 
>> What we need is to make endio_workers and rmw_workers to get rid of
>> WQ_MEM_RECLAIM, but that is a huge change and may not even work.
>>
>> Thanks,
>> Qu
>>
>>>
>>>> I'll keep digging to try to use flush_work() to remove the csum_done, as
>>>> that will keep the size of btrfs_bio unchanged.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> --nX
>>>>>
>>>>
>>>>>>
>>>>
>>


