Return-Path: <linux-btrfs+bounces-17862-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A67CBE14EC
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 04:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3E93E4973
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Oct 2025 02:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9E61D5ACE;
	Thu, 16 Oct 2025 02:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="TIpLTthe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m3273.qiye.163.com (mail-m3273.qiye.163.com [220.197.32.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94D04C9D;
	Thu, 16 Oct 2025 02:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760582853; cv=none; b=oPx/fMp5mFWLwS2rWFBXtumNV9iycAVGWIdvfddo1L6SoYWxtgwIOfZZe0ZnXdoaNn89JWXwupyMVNsX3AEDvUoj4h7r9WVAFCNuVadCPYZvw0LnrG9N2Rq9O0ORhBomMoKexvh8lG6pCX6qVg2eLe4jrN8xuRtq2tF0zZJp3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760582853; c=relaxed/simple;
	bh=iogBch86DojDxI85bzEG13xmEaDs0n5ZCvnVkatq8uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jW5ol73mOmd3Mc7HrLa3Rm/4bv5a1hOjbr6jUP0Mv1R7qzQz53CMU/J5XtleulzJWkFXWomfHXPHbuFZTlROCKHdGEX2dNTm7DG0/ZZOLv7w4Y60l+GieP4V5eFmd1QjfAvX9xBgXqqKpKvsGFkwhUxrL1KO7yrKCKVkDKhso9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=TIpLTthe; arc=none smtp.client-ip=220.197.32.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Received: from [192.168.6.5] (unknown [1.193.59.83])
	by smtp.qiye.163.com (Hmail) with ESMTP id 26121cf19;
	Thu, 16 Oct 2025 10:11:53 +0800 (GMT+08:00)
Message-ID: <ec8854e3-dd79-4233-8f14-fbd55252e210@cqsoftware.com.cn>
Date: Thu, 16 Oct 2025 10:11:53 +0800
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Fix NULL pointer access in
 btrfs_check_leaked_roots()
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 josef@toxicpanda.com
References: <20251015072421.4538-1-mengdewei@cqsoftware.com.cn>
 <6a2bb5c7-0aab-4662-938f-38b8e2372338@gmx.com>
 <3745f0a8-9560-4329-8f76-b827305d6bd8@cqsoftware.com.cn>
 <eab56dc2-2404-44e0-b950-77342642a2a7@gmx.com>
From: Dewei Meng <mengdewei@cqsoftware.com.cn>
In-Reply-To: <eab56dc2-2404-44e0-b950-77342642a2a7@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99eac9bbab03abkunmd98ff9293fb07a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkpJVhodS0xLT0JCQhpIS1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKVUpCSFVOQlVDSFlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=TIpLTtheh6jXPzey1+IGVvkjw4Mui5eq/Kdbr7mExOwZrqGCP/offEh9cS+QV9zK77f19ga1QeBH4bMVqEY1gsPSa6v8ZIfzgnHGBJoGI7wmSV/1pwgty6K7hDjPfBSrOznlnNBX6NvhXrcyoKMzNJzYUjZX1kvrAgKI3RCm8Ys=; s=default; c=relaxed/relaxed; d=cqsoftware.com.cn; v=1;
	bh=YUvywQvGKIpVMxNIW7F+aYbEkjp5fJXjwuTVbjXbEHo=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/15 18:07, Qu Wenruo 写道:
>
>
> 在 2025/10/15 20:32, Dewei Meng 写道:
>>
>> 在 2025/10/15 16:24, Qu Wenruo 写道:
>>>
>>>
>>> 在 2025/10/15 17:54, Dewei Meng 写道:
>>>> If fs_info->super_copy or fs_info->super_for_commit is NULL in
>>>> btrfs_get_tree_subvol(),
>>>
>>> Please reorganize this sentence. It would be way more easier to read 
>>> by just saying something like "If memory allocation failed for 
>>> fs_info->super_copy or fs_info->super_for_commit in 
>>> btrfs_get_tree_subvol()".
>> I agree, I will fix these words to make them easier to read.
>>>
>>>> the btrfs_check_leaked_roots() will get the
>>>> btrfs_root list entry using the fs_info->allocated_roots->next
>>>> which is NULL.
>>>>
>>>> syzkaller reported the following information:
>>>>    ------------[ cut here ]------------
>>>>    BUG: unable to handle page fault for address: fffffffffffffbb0
>>>>    #PF: supervisor read access in kernel mode
>>>>    #PF: error_code(0x0000) - not-present page
>>>>    PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
>>>>    Oops: Oops: 0000 [#1] SMP KASAN PTI
>>>>    CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 #4 
>>>> PREEMPT(lazy)
>>>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (...)
>>>>    RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 
>>>> [inline]
>>>>    RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch- 
>>>> fallback.h:457 [inline]
>>>>    RIP: 0010:atomic_read include/linux/atomic/atomic- 
>>>> instrumented.h:33 [inline]
>>>>    RIP: 0010:refcount_read include/linux/refcount.h:170 [inline]
>>>>    RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 fs/btrfs/disk- 
>>>> io.c:1230
>>>>    [...]
>>>>    Call Trace:
>>>>     <TASK>
>>>>     btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1280
>>>>     btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2029
>>>>     btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
>>>>     vfs_get_tree+0x98/0x320 fs/super.c:1759
>>>>     do_new_mount+0x357/0x660 fs/namespace.c:3899
>>>>     path_mount+0x716/0x19c0 fs/namespace.c:4226
>>>>     do_mount fs/namespace.c:4239 [inline]
>>>>     __do_sys_mount fs/namespace.c:4450 [inline]
>>>>     __se_sys_mount fs/namespace.c:4427 [inline]
>>>>     __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
>>>>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>>>     do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c:94
>>>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>>    RIP: 0033:0x7f032eaffa8d
>>>>    [...]
>>>>
>>>> This should check if the fs_info->allocated_roots->next is NULL before
>>>> accessing it.
>>>>
>>>> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
>>>> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
>>>> ---
>>>>   fs/btrfs/disk-io.c | 3 +++
>>>>   1 file changed, 3 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>>> index 0aa7e5d1b05f..76db7f98187a 100644
>>>> --- a/fs/btrfs/disk-io.c
>>>> +++ b/fs/btrfs/disk-io.c
>>>> @@ -1213,6 +1213,9 @@ void btrfs_check_leaked_roots(const struct 
>>>> btrfs_fs_info *fs_info)
>>>>   #ifdef CONFIG_BTRFS_DEBUG
>>>>       struct btrfs_root *root;
>>>>   +    if (!fs_info->allocated_roots.next)
>>>> +        return;
>>>> +
>>>
>>> The check looks too adhoc to me.
>>>
>>> It would be much easier to just call kvfree() in the error handling 
>>> of super_copy/super_for_commit allocation, we do not and should not 
>>> call btrfs_free_fs_info() before calling btrfs_init_fs_info().
>>
>> It is a good solution to fix this bug, or can we put the 
>> 'btrfs_init_fs_info(fs_info)' before super_copy/super_for_commit 
>> allocation?
>
> That also sounds fine to me.

I have tested the kfree method, and test case runs fine. I plan to take 
your suggestion and re-do the patch.

Thanks.

>
>>
>> Thanks,
>>
>> Dewei Meng
>>
>>>
>>> Thanks,
>>> Qu
>>>>       while (!list_empty(&fs_info->allocated_roots)) {
>>>>           char buf[BTRFS_ROOT_NAME_BUF_LEN];
>>>
>>>
>>>
>
>
>

