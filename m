Return-Path: <linux-btrfs+bounces-6831-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8507193F716
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 15:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AEF51F22521
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2024 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBEE14F115;
	Mon, 29 Jul 2024 13:54:06 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DB14A0B7;
	Mon, 29 Jul 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722261245; cv=none; b=rBsYoMHGXqaFIeuxp2+m2YH1EMlAEf0oxVQBz28pEPDYQIjNLIQ0FHjjISLHBSHXTofUWIvb2vakMHo4yo+tmPA8O2Bi4xel1+KoCoCia2PykMMMMdgnhMhPlwskgHpO/wnHNHqQMQn/q5qo5L9NLlXiAXUtcafLndNuXzmSUPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722261245; c=relaxed/simple;
	bh=ZpeOxFm/gLaxfVBCZ4PcaAnxIOBoACk7GdmWouxAnR0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=fsyDR7ZiAqAkxcpfLkuR7gXX34jUpWrl19UiWtpb8mIpkdAdGIoK9PhmtNyXDFVwrz8UnHYNFql+yWOjTaqPzoPu4yNkdzJJW38K06oznr7qMprNqivp4aQPkpJVh/nT9v+xFFCctUlOQY5a0GEYlJ61vIPp9TYdvgeHGRpP4Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WXfqP0gDHzPtKQ;
	Mon, 29 Jul 2024 21:49:37 +0800 (CST)
Received: from kwepemf100006.china.huawei.com (unknown [7.202.181.220])
	by mail.maildlp.com (Postfix) with ESMTPS id 00D3E1402CA;
	Mon, 29 Jul 2024 21:53:54 +0800 (CST)
Received: from [10.174.177.210] (10.174.177.210) by
 kwepemf100006.china.huawei.com (7.202.181.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Jul 2024 21:53:53 +0800
Message-ID: <9514fd55-4f83-8e43-bdf7-925396ab5e48@huawei.com>
Date: Mon, 29 Jul 2024 21:53:52 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] generic/736: don't run it on tmpfs
From: yangerkun <yangerkun@huawei.com>
To: Filipe Manana <fdmanana@kernel.org>, Christoph Hellwig
	<hch@infradead.org>, <chuck.lever@oracle.com>
CC: <zlang@kernel.org>, <fstests@vger.kernel.org>, <linux-mm@kvack.org>,
	<hughd@google.com>, <akpm@linux-foundation.org>, linux-btrfs
	<linux-btrfs@vger.kernel.org>
References: <20240720083538.2999155-1-yangerkun@huawei.com>
 <CAL3q7H5AivAMSWk3FmmsrSqbeLfqMw_hr05b_Rdzk7hnnrsWiA@mail.gmail.com>
 <4188b7b5-3576-9e5f-6297-794558d7a01e@huawei.com>
In-Reply-To: <4188b7b5-3576-9e5f-6297-794558d7a01e@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100006.china.huawei.com (7.202.181.220)

Hi,

在 2024/7/24 21:30, yangerkun 写道:
> Hi, All,
> 
> Sorry for the delay relay(something happened, and cannot use pc
> before...).
> 
> 在 2024/7/21 1:26, Filipe Manana 写道:
>> On Sat, Jul 20, 2024 at 9:38 AM Yang Erkun <yangerkun@huawei.com> wrote:
>>>
>>> We use offset_readdir for tmpfs, and every we call rename, the offset
>>> for the parent dir will increase by 1. So for tmpfs we will always
>>> fail since the infinite readdir.
>>
>> Having an infinite readdir sounds like a bug, or at least an
>> inconvenience and surprising for users.
>> We had that problem in btrfs which affected users/applications, see:
>>
>> https://lore.kernel.org/linux-btrfs/2c8c55ec-04c6-e0dc-9c5c-8c7924778c35@landley.net/
>>
>> which was surprising for them since every other filesystem they
>> used/tested didn't have that problem.
>> Why not fix tmpfs?
> 
> Thanks for all your advise, I will give a detail analysis first(maybe
> until last week I can do it), and after we give a conclusion about does
> this behavior a bug or something expected to occur, I will choose the
> next step!

The case generic/736 do something like below:

1. create 5000 files(1 2 3 ...) under one dir(testdir)
2. call readdir(man 3 readdir) once, and get entry
3. rename(entry, "TEMPFILE"), then rename("TMPFILE", entry)
4. loop 2~3, until readdir return nothing of we loop too many times(15000)

For tmpfs before a2e459555c5f("shmem: stable directory offsets"), every 
rename called, the new dentry will insert to d_subdirs *head* of parent 
dentry, and dcache_readdir won't reenter this dentry if we have already 
enter the dentry, so in step 4 we will break the test since readdir 
return nothing  (I have try to change __d_move the insert to the "tail" 
of d_sub_dirs, problem can still happend).

But after commit a2e459555c5f("shmem: stable directory offsets"), 
simple_offset_rename will just add the new dentry to the maple tree of 
&SHMEM_I(inode)->dir_offsets->mt with the key always inc by 1(since 
simple_offset_add we will find free entry start with octx->newx_offset, 
so the entry freed in simple_offset_remove won't be found). And the same 
case upper will be break since we loop too many times(we can fall into 
infinite readdir without this break).

I prefer this is really a bug, and for the way to fix it, I think we can 
just use the same logic what 9b378f6ad48cf("btrfs: fix infinite 
directory reads") has did, introduce a last_index when we open the dir, 
and then readdir will not return the entry which index greater than the 
last index.

Looking forward to your comments!

Thanks,
Erkun.



> 
> Thanks again for all your advise!
> 
> 
>>
>> Thanks.
>>
>>>
>>> Signed-off-by: Yang Erkun <yangerkun@huawei.com>
>>> ---
>>>   tests/generic/736 | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/generic/736 b/tests/generic/736
>>> index d2432a82..9fafa8df 100755
>>> --- a/tests/generic/736
>>> +++ b/tests/generic/736
>>> @@ -18,7 +18,7 @@ _cleanup()
>>>          rm -fr $target_dir
>>>   }
>>>
>>> -_supported_fs generic
>>> +_supported_fs generic ^tmpfs
>>>   _require_test
>>>   _require_test_program readdir-while-renames
>>>
>>> -- 
>>> 2.39.2
>>>
>>>

