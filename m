Return-Path: <linux-btrfs+bounces-6862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006A94030F
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 03:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C638282705
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jul 2024 01:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9396B79CC;
	Tue, 30 Jul 2024 01:05:44 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80330524C;
	Tue, 30 Jul 2024 01:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722301544; cv=none; b=Wa7ayxf8omLQpZrVVDOlfiirUtWaDlIkaTQkJHdNzJN+bsWO1oUYSIMKuzpIRhZChNpwO6fv8ljyCzcWROMF6YoXu8+TYqhbAsujmVil9dfEoP7ScF8iJyOkn+SKrJjNBotCK9JVFDfCuYidi7JxJkTWLbNpbu3gaubv64QwPoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722301544; c=relaxed/simple;
	bh=XlKCDM9DCeAaTuqg2behROHnG0qmrfUaQh2HoE8z6No=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=K1+JBsHiemADn3/IzcBpRgWe9dnJJ32adlH9D5DaYm99lrOLHxHLN34K2NObh9+SbCV/SYf4d87UjgiiWMqiEzKlJVCJ3tig6TM7d51TlK2h1IqBwlv4F1O+I81GBFY6NhrFM+0kLLFBplePhNaa0+kT35dV1PSMrGD5pbLImas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WXxn44lTpz1xtsg;
	Tue, 30 Jul 2024 09:03:36 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 30B651A0188;
	Tue, 30 Jul 2024 09:05:21 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 30 Jul 2024 09:05:20 +0800
Message-ID: <938ab47e-c68c-ea6e-7a9f-b9080529cf75@huawei.com>
Date: Tue, 30 Jul 2024 09:05:19 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
To: Filipe Manana <fdmanana@kernel.org>
CC: Christoph Hellwig <hch@infradead.org>, <chuck.lever@oracle.com>,
	<zlang@kernel.org>, <fstests@vger.kernel.org>, <linux-mm@kvack.org>,
	<hughd@google.com>, <akpm@linux-foundation.org>, linux-btrfs
	<linux-btrfs@vger.kernel.org>
References: <20240720083538.2999155-1-yangerkun@huawei.com>
 <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
 <4188b7b5-3576-9e5f-6297-794558d7a01e@huawei.com>
 <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
 <CAL3q7H6bNpDnh=XYKgFOp4xTRHY2EDJ_MaSFx-nHfKnx8gQVkw@mail.gmail.com>
From: yangerkun <yangerkun@huawei.com>
In-Reply-To: <CAL3q7H6bNpDnh=XYKgFOp4xTRHY2EDJ_MaSFx-nHfKnx8gQVkw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100006.china.huawei.com (7.202.181.220)



在 2024/7/29 22:32, Filipe Manana 写道:
> On Mon, Jul 29, 2024 at 2:54 PM yangerkun <yangerkun@huawei.com> wrote:
>>
>> Hi,
>>
>> 在 2024/7/24 21:30, yangerkun 写道:
>>> Hi, All,
>>>
>>> Sorry for the delay relay(something happened, and cannot use pc
>>> before...).
>>>
>>> 在 2024/7/21 1:26, Filipe Manana 写道:
>>>> On Sat, Jul 20, 2024 at 9:38 AM Yang Erkun <yangerkun@huawei.com> wrote:
>>>>>
>>>>> We use offset_readdir for tmpfs, and every we call rename, the offset
>>>>> for the parent dir will increase by 1. So for tmpfs we will always
>>>>> fail since the infinite readdir.
>>>>
>>>> Having an infinite readdir sounds like a bug, or at least an
>>>> inconvenience and surprising for users.
>>>> We had that problem in btrfs which affected users/applications, see:
>>>>
>>>> https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net/
>>>>
>>>> which was surprising for them since every other filesystem they
>>>> used/tested didn't have that problem.
>>>> Why not fix tmpfs?
>>>
>>> Thanks for all your advise, I will give a detail analysis first(maybe
>>> until last week I can do it), and after we give a conclusion about does
>>> this behavior a bug or something expected to occur, I will choose the
>>> next step!
>>
>> The case generic/736 do something like below:
>>
>> 1. create 5000 files(1 2 3 ...) under one dir(testdir)
>> 2. call readdir(man 3 readdir) once, and get entry
>> 3. rename(entry, "TEMPFILE"), then rename("TMPFILE", entry)
>> 4. loop 2~3, until readdir return nothing of we loop too many times(15000)
>>
>> For tmpfs before a2e459555c5f("shmem: stable directory offsets"), every
>> rename called, the new dentry will insert to d_subdirs *head* of parent
>> dentry, and dcache_readdir won't reenter this dentry if we have already
>> enter the dentry, so in step 4 we will break the test since readdir
>> return nothing  (I have try to change __d_move the insert to the "tail"
>> of d_sub_dirs, problem can still happend).
>>
>> But after commit a2e459555c5f("shmem: stable directory offsets"),
>> simple_offset_rename will just add the new dentry to the maple tree of
>> &SHMEM_I(inode)->dir_offsets->mt with the key always inc by 1(since
>> simple_offset_add we will find free entry start with octx->newx_offset,
>> so the entry freed in simple_offset_remove won't be found). And the same
>> case upper will be break since we loop too many times(we can fall into
>> infinite readdir without this break).
>>
>> I prefer this is really a bug, and for the way to fix it, I think we can
>> just use the same logic what 9b378f6ad48cf("btrfs: fix infinite
>> directory reads") has did, introduce a last_index when we open the dir,
>> and then readdir will not return the entry which index greater than the
>> last index.
> 
> Don't forget to reset the index to whatever is the current last index
> when rewind() is called.
> We ended up with that bug in btrfs later, see:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e60aa5da14d01fed8411202dbe4adf6c44bd2a57

Thanks for your reminder, will change offset_dir_llseek too!

> 
> Anyway, if the same mistake is made, it would be caught by a test case
> for fstests I submitted after:
> 
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=68b958f5dc4ab13cfd86f7fb82621f9f022b7626
> 
> 
> 
>>
>> Looking forward to your comments!
>>
>> Thanks,
>> Erkun.
>>
>>
>>
>>>
>>> Thanks again for all your advise!
>>>
>>>
>>>>
>>>> Thanks.
>>>>
>>>>>
>>>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>>>> ---
>>>>>    tests/generic/736 | 2 +-
>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/tests/generic/736 b/tests/generic/736
>>>>> index d2432a82..9fafa8df 100755
>>>>> --- a/tests/generic/736
>>>>> +++ b/tests/generic/736
>>>>> @@ -18,7 +18,7 @@ _cleanup()
>>>>>           rm -fr $target_dir
>>>>>    }
>>>>>
>>>>> -_supported_fs generic
>>>>> +_supported_fs generic ^tmpfs
>>>>>    _require_test
>>>>>    _require_test_program readdir-while-renames
>>>>>
>>>>> --
>>>>> 2.39.2
>>>>>
>>>>>

