Return-Path: <linux-btrfs+bounces-17832-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5E6BDDF05
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 12:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D65EA4F7761
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6445C319865;
	Wed, 15 Oct 2025 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b="Ft2IRCJ6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-m4921.qiye.163.com (mail-m4921.qiye.163.com [45.254.49.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7431A5BA2;
	Wed, 15 Oct 2025 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760523452; cv=none; b=NSPmWF0bAP9u9twoIlLSd9g50msX++8aksUhm6VKeTyqgDKxPZHeJmmrolbSCeo4lmqFa5FtmXTpJI3I1Nqhp/9wOTlepQaecPvl+/QfWnrdkz8gFJVLlvdk20JbRGRZYmuj+aAPaNIM4655Lz0cgIxVxloDkj9FEBU5yDzlrug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760523452; c=relaxed/simple;
	bh=MP1IV+SxUwO0htoDCM8ayCaDQ55pHniyWOkmyAajngo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHR5EIIghDuL74g10FdQTDQ5RwedjJGIBYC0RzqoYoeI83FxkrdLaorp6xbLgwdEuVqICV2xxZNHDNgyHLoIuhPrvmurld3hYGkTfIUQ1MmmyFolOhokZ93VW8Q5EDT1vuFsugT2afNm51J1v5SU7c4o8M9ReODpJaSXpEr26AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn; spf=pass smtp.mailfrom=cqsoftware.com.cn; dkim=pass (1024-bit key) header.d=cqsoftware.com.cn header.i=@cqsoftware.com.cn header.b=Ft2IRCJ6; arc=none smtp.client-ip=45.254.49.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cqsoftware.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cqsoftware.com.cn
Received: from [192.168.6.5] (unknown [1.193.59.83])
	by smtp.qiye.163.com (Hmail) with ESMTP id 25ffeebd1;
	Wed, 15 Oct 2025 18:02:01 +0800 (GMT+08:00)
Message-ID: <3745f0a8-9560-4329-8f76-b827305d6bd8@cqsoftware.com.cn>
Date: Wed, 15 Oct 2025 18:02:00 +0800
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
From: Dewei Meng <mengdewei@cqsoftware.com.cn>
In-Reply-To: <6a2bb5c7-0aab-4662-938f-38b8e2372338@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a99e751cca403abkunmae7e756e323314
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTExNVh8YThhKH08dHUJDSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKVUpCSFVOQlVDSFlXWRYaDxIVHRRZQVlPS0hVSktJT09PSFVKS0tVSk
	JLS1kG
DKIM-Signature: a=rsa-sha256;
	b=Ft2IRCJ6GsZgP9jL1tXm3UJ4658BfjommfiT8psPFgqYuONr1RA2TqVApOaPm/sTjJPZUIMQ363ps4GPDA91pTsWhSjyC3J1VzbQEP9CiMdBv21epOWuORHfe3+W+dtv/C6P4opky3OMoPVbbL8S2dIcJdNUsbljOzDl8jNRSCI=; s=default; c=relaxed/relaxed; d=cqsoftware.com.cn; v=1;
	bh=tSa5yZMx3yy+dOAyn2YH8Ua7mP74MG9ojzEpA/5OntM=;
	h=date:mime-version:subject:message-id:from;


在 2025/10/15 16:24, Qu Wenruo 写道:
>
>
> 在 2025/10/15 17:54, Dewei Meng 写道:
>> If fs_info->super_copy or fs_info->super_for_commit is NULL in
>> btrfs_get_tree_subvol(),
>
> Please reorganize this sentence. It would be way more easier to read 
> by just saying something like "If memory allocation failed for 
> fs_info->super_copy or fs_info->super_for_commit in 
> btrfs_get_tree_subvol()".
I agree, I will fix these words to make them easier to read.
>
>> the btrfs_check_leaked_roots() will get the
>> btrfs_root list entry using the fs_info->allocated_roots->next
>> which is NULL.
>>
>> syzkaller reported the following information:
>>    ------------[ cut here ]------------
>>    BUG: unable to handle page fault for address: fffffffffffffbb0
>>    #PF: supervisor read access in kernel mode
>>    #PF: error_code(0x0000) - not-present page
>>    PGD 64c9067 P4D 64c9067 PUD 64cb067 PMD 0
>>    Oops: Oops: 0000 [#1] SMP KASAN PTI
>>    CPU: 0 UID: 0 PID: 1402 Comm: syz.1.35 Not tainted 6.15.8 #4 
>> PREEMPT(lazy)
>>    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), (...)
>>    RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
>>    RIP: 0010:raw_atomic_read 
>> include/linux/atomic/atomic-arch-fallback.h:457 [inline]
>>    RIP: 0010:atomic_read 
>> include/linux/atomic/atomic-instrumented.h:33 [inline]
>>    RIP: 0010:refcount_read include/linux/refcount.h:170 [inline]
>>    RIP: 0010:btrfs_check_leaked_roots+0x18f/0x2c0 
>> fs/btrfs/disk-io.c:1230
>>    [...]
>>    Call Trace:
>>     <TASK>
>>     btrfs_free_fs_info+0x310/0x410 fs/btrfs/disk-io.c:1280
>>     btrfs_get_tree_subvol+0x592/0x6b0 fs/btrfs/super.c:2029
>>     btrfs_get_tree+0x63/0x80 fs/btrfs/super.c:2097
>>     vfs_get_tree+0x98/0x320 fs/super.c:1759
>>     do_new_mount+0x357/0x660 fs/namespace.c:3899
>>     path_mount+0x716/0x19c0 fs/namespace.c:4226
>>     do_mount fs/namespace.c:4239 [inline]
>>     __do_sys_mount fs/namespace.c:4450 [inline]
>>     __se_sys_mount fs/namespace.c:4427 [inline]
>>     __x64_sys_mount+0x28c/0x310 fs/namespace.c:4427
>>     do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>>     do_syscall_64+0x92/0x180 arch/x86/entry/syscall_64.c:94
>>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>    RIP: 0033:0x7f032eaffa8d
>>    [...]
>>
>> This should check if the fs_info->allocated_roots->next is NULL before
>> accessing it.
>>
>> Fixes: 3bb17a25bcb0 ("btrfs: add get_tree callback for new mount API")
>> Signed-off-by: Dewei Meng <mengdewei@cqsoftware.com.cn>
>> ---
>>   fs/btrfs/disk-io.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 0aa7e5d1b05f..76db7f98187a 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -1213,6 +1213,9 @@ void btrfs_check_leaked_roots(const struct 
>> btrfs_fs_info *fs_info)
>>   #ifdef CONFIG_BTRFS_DEBUG
>>       struct btrfs_root *root;
>>   +    if (!fs_info->allocated_roots.next)
>> +        return;
>> +
>
> The check looks too adhoc to me.
>
> It would be much easier to just call kvfree() in the error handling of 
> super_copy/super_for_commit allocation, we do not and should not call 
> btrfs_free_fs_info() before calling btrfs_init_fs_info().

It is a good solution to fix this bug, or can we put the 
'btrfs_init_fs_info(fs_info)' before super_copy/super_for_commit allocation?

Thanks,

Dewei Meng

>
> Thanks,
> Qu
>>       while (!list_empty(&fs_info->allocated_roots)) {
>>           char buf[BTRFS_ROOT_NAME_BUF_LEN];
>
>
>

