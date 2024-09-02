Return-Path: <linux-btrfs+bounces-7726-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 360A89682E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 11:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD39428374E
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7BC18784F;
	Mon,  2 Sep 2024 09:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMp7PaLx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F911187347;
	Mon,  2 Sep 2024 09:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725268494; cv=none; b=TfgTCQWeuSmJxLoNJSy8MOIV6ihIEgIzRoEKoOvd2cDpQ6XfCEbaZyiAQT4B1+zErNgP8ZQJKwiaNbqQyYkOwrXvoBmTLVX3+qAykAMhppvRLQHomOjE0LxxFO6yV7c7K2EuWFWq53omdy1D2ji92RNXaxc9mWqbGAZQO14Iu5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725268494; c=relaxed/simple;
	bh=BiOfTQ/ScWjx2UeroMLEiJGQTe7d+mkNi8Eh/fXNXLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qFtVzgcvisRzmvoAKNr1ZAPHaM+eu1ZTp5aekW/SFoLlkdm5hzodkrNoUt8CCIlSkKK/678dxAu3etaF4P/HkQA4vZ/NChtRdlqUKG23Us02HQ95dKXOSMF54Oep4g5TbkUr6L+Bu7DdQZHxGPxSWDR/wSxN/1SXNXsXh1tVfOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMp7PaLx; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-374c962e5adso430456f8f.1;
        Mon, 02 Sep 2024 02:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725268491; x=1725873291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wvfx7uXnphEAcqrxryp1hC4hXuppYE7B9WLMIBchYMk=;
        b=kMp7PaLxmtfJsu4Bfbgl8Fjj5iKz4+9NcNfz9N4X7PywNSR9Ijx3Fj24NWKpuqivx7
         2tZ82Mu1i98luYLGi1kD++K0XZ8mDN65x6mgbOzqqmDlRU56tTHdp3qHM4ArlVCy065E
         BnGDdbBX/uxbTnuOVznKJdV8xoZ/P00v85yyO1oKI+IwJUpkYDVUMolduGdAn/XLSIlU
         qiXdr1PWSPbPcXA21Aqbiq1fCjey3MC0JYorbKxabH/Apjn79W53zxz0uxh1kRNZ8f1Q
         PvKXkzToRF6RbFv798bRaTC/nICybmIQpm57gCvFyN8YHZVjU/OER7ndEyXmB7auUSZB
         njOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725268491; x=1725873291;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wvfx7uXnphEAcqrxryp1hC4hXuppYE7B9WLMIBchYMk=;
        b=gXh2DyZmEWVMABZiC/xGY6vDocTC1zRsWsDkmzHQjqi+H6JiU2wwCFS1JTHYFPW67Q
         G8dp4YaI48bHwbrNZp+KD678EA0pPYsUUUv1hoaHuwcOMnCNTVFBsdYUgWUSW31FCwF3
         Xb6gujk/GFZq2DXg2wdLS7tFmBbEm8KTUaX4LvFgttE9K8Nu48ywZDk9Xd7bqKlCbKEm
         K/6IqQRxKOksp087zPVI0cLtyfb8mMzPvmsmM/NGWyk6ol3SH1nMnIjEBlDVm+Q+xWRk
         Lx4ATwrApXeuxc3Tx131UWKdMvK//Apv36kvZS95KWWPtWJy/nYXeLfYrmSbmvqWwnZI
         oAvw==
X-Forwarded-Encrypted: i=1; AJvYcCV1NKPUPLJBfW2VeE/B8NvPmNHKA1Tyr/Ca5j3hSDpL5hVTKtW4oaQJ0HLQQ+aSz6L050EtsTJXj91tgQ==@vger.kernel.org, AJvYcCWF2Rt16TbIZnNT/9M45a9RXq0zXtCB+s5X6Q3r9a7NiDBgs2+hsZPbVwu4/rzjPtAe6Uow9rv62boQdi/D@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvyaVxuHhNIhDVS+bj/iLGZeHfNIPh4Nk2rH65eNHpf/J1akI
	zb4XesQIa+qr9/wwzF1Xjw3PXsleID1MqaMO2uHNjikX6Qcsb0If
X-Google-Smtp-Source: AGHT+IFYe03u+im4J+AJUgJqbaank06o4XJpkOwEeIgY9Cech6X8TxAQCPPRv8y3D1pC3N6sWNW+VA==
X-Received: by 2002:a5d:6190:0:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-374c7cd8a12mr2011202f8f.22.1725268490298;
        Mon, 02 Sep 2024 02:14:50 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33b41sm130542065e9.40.2024.09.02.02.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:14:49 -0700 (PDT)
Message-ID: <f5e30162-8642-419f-877c-c7c9ecc27051@gmail.com>
Date: Mon, 2 Sep 2024 11:14:48 +0200
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: Don't block system suspend during fstrim
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240822164908.4957-1-luca.stefani.ge1@gmail.com>
 <400d2855-59c2-47d2-9224-f76f219ae993@gmail.com>
 <745754f6-0728-4682-95a0-39807675bb18@gmx.com>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <745754f6-0728-4682-95a0-39807675bb18@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Re-sending, was discarded because of HTML blocks, sorry!

On 02/09/24 10:49, Qu Wenruo wrote:
> 
> 
> 在 2024/9/2 18:02, Luca Stefani 写道:
>> Any update on this? It's not critical but I'd like to know if it's in
>> some part proper.
>> Thanks, Luca.
> 
> Sorry I didn't see your patch in the list, thus sent a different fix for
> it later:
> 
> https://lore.kernel.org/linux-btrfs/20240830185113.GW25962@twin.jikos.cz/T/#t
> 
No worries, glad it got picked up!
>>> Sometimes the system isn't able to suspend because
>>> the task responsible for trimming the device isn't
>>> able to finish in time.
>>>
>>> Since discard isn't a critical call it can be interrupted
>>> at any time, we can simply report the amount of discarded
>>> bytes in such cases and stop the trim.
>>>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219180
>>> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com>
>>> ---
>>> I have no idea if that's correct, just something I implemented
>>> looking at the same solution made in ext4 by 5229a658f645.
>>>
>>> The patch in itself seems to solve the issue.
>>>
>>> repro is as follows:
>>> sudo /sbin/fstrim --listed-in /etc/fstab:/proc/self/mountinfo
>>> --verbose --quiet-unsupported &
>>> sudo ./sleepgraph.py -m mem -rtcwake 5
>>>
>>> [836563.289069] PM: suspend exit
>>> [836563.909298] PM: suspend entry (s2idle)
>>> [836563.935447] Filesystems sync: 0.026 seconds
>>> [836563.951391] Freezing user space processes
>>> [836583.958957] Freezing user space processes failed after 20.007
>>> seconds (1 tasks refusing to freeze, wq_busy=0):
>>> [836583.959582] task:fstrim          state:D stack:0     pid:241865
>>> tgid:241865 ppid:241864 flags:0x00004006
>>> [836583.959592] Call Trace:
>>> [836583.959595]  <TASK>
>>> [836583.959600]  __schedule+0x400/0x1720
>>> [836583.959612]  ? mod_delayed_work_on+0xa4/0xb0
>>> [836583.959622]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959628]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959631]  ? blk_mq_flush_plug_list.part.0+0x1e3/0x610
>>> [836583.959640]  schedule+0x27/0xf0
>>> [836583.959644]  schedule_timeout+0x12f/0x160
>>> [836583.959652]  io_schedule_timeout+0x51/0x70
>>> [836583.959657]  wait_for_completion_io+0x8a/0x160
>>> [836583.959663]  submit_bio_wait+0x60/0x90
>>> [836583.959671]  blkdev_issue_discard+0x91/0x100
>>> [836583.959680]  btrfs_issue_discard+0xc4/0x140
>>> [836583.959689]  btrfs_discard_extent+0x241/0x2a0
>>> [836583.959695]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959702]  do_trimming+0xd2/0x240
>>> [836583.959712]  trim_bitmaps+0x350/0x4c0
>>> [836583.959723]  btrfs_trim_block_group+0xb8/0x110
>>> [836583.959729]  btrfs_trim_fs+0x118/0x440
>>> [836583.959734]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959738]  ? security_capable+0x41/0x70
>>> [836583.959746]  btrfs_ioctl_fitrim+0x113/0x180
>>> [836583.959752]  btrfs_ioctl+0xdaf/0x2670
>>> [836583.959759]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959763]  ? ioctl_has_perm.constprop.0.isra.0+0xd8/0x130
>>> [836583.959774]  __x64_sys_ioctl+0x94/0xd0
>>> [836583.959782]  do_syscall_64+0x82/0x160
>>> [836583.959790]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959793]  ? syscall_exit_to_user_mode+0x72/0x220
>>> [836583.959799]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959802]  ? do_syscall_64+0x8e/0x160
>>> [836583.959807]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959811]  ? do_sys_openat2+0x9c/0xe0
>>> [836583.959821]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959825]  ? syscall_exit_to_user_mode+0x72/0x220
>>> [836583.959828]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959832]  ? do_syscall_64+0x8e/0x160
>>> [836583.959835]  ? syscall_exit_to_user_mode+0x72/0x220
>>> [836583.959838]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959842]  ? do_syscall_64+0x8e/0x160
>>> [836583.959845]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959849]  ? do_syscall_64+0x8e/0x160
>>> [836583.959851]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959855]  ? do_syscall_64+0x8e/0x160
>>> [836583.959858]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959861]  ? do_syscall_64+0x8e/0x160
>>> [836583.959864]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959868]  ? srso_alias_return_thunk+0x5/0xfbef5
>>> [836583.959873]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>> [836583.959878] RIP: 0033:0x7f3e4261af2d
>>> [836583.959944] RSP: 002b:00007ffec002f400 EFLAGS: 00000246 ORIG_RAX:
>>> 0000000000000010
>>> [836583.959950] RAX: ffffffffffffffda RBX: 00007ffec002f570 RCX:
>>> 00007f3e4261af2d
>>> [836583.959952] RDX: 00007ffec002f470 RSI: 00000000c0185879 RDI:
>>> 0000000000000003
>>> [836583.959955] RBP: 00007ffec002f450 R08: 0000562d74da7010 R09:
>>> 00007ffec002e7f2
>>> [836583.959957] R10: 0000000000000000 R11: 0000000000000246 R12:
>>> 0000562d74daafc0
>>> [836583.959960] R13: 0000000000000003 R14: 0000562d74daa970 R15:
>>> 0000562d74daad40
>>> [836583.959967]  </TASK>
>>> ---
>>>   fs/btrfs/extent-tree.c | 20 ++++++++++++++++----
>>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>> index feec49e6f9c8..7e4c1d4f2f7c 100644
>>> --- a/fs/btrfs/extent-tree.c
>>> +++ b/fs/btrfs/extent-tree.c
>>> @@ -16,6 +16,7 @@
>>>   #include <linux/percpu_counter.h>
>>>   #include <linux/lockdep.h>
>>>   #include <linux/crc32c.h>
>>> +#include <linux/freezer.h>
>>>   #include "ctree.h"
>>>   #include "extent-tree.h"
>>>   #include "transaction.h"
>>> @@ -6361,6 +6362,11 @@ void btrfs_error_unpin_extent_range(struct
>>> btrfs_fs_info *fs_info, u64 start, u6
>>>       unpin_extent_range(fs_info, start, end, false);
>>>   }
>>> +static bool btrfs_trim_interrupted(void)
>>> +{
>>> +    return fatal_signal_pending(current) || freezing(current);
>>> +}
>>> +
>>>   /*
>>>    * It used to be that old block groups would be left around forever.
>>>    * Iterating over them would be enough to trim unused space.  Since we
>>> @@ -6459,8 +6465,8 @@ static int btrfs_trim_free_extents(struct
>>> btrfs_device *device, u64 *trimmed)
>>>           start += len;
>>>           *trimmed += bytes;
>>> -        if (fatal_signal_pending(current)) {
>>> -            ret = -ERESTARTSYS;
>>> +        if (btrfs_trim_interrupted()) {
>>> +            ret = 0;
>>>               break;
> 
> Here we should still return the same error number other than 0, to let
> the caller know the operation is interrupted, other than finished normally.
> 
Here I was following how ext4 did it, my explanation for that was that 
the kernel may have still discarded some data before the thread was 
interrupted thus it made sense to report success.
>>>           }
>>> @@ -6508,6 +6514,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info,
>>> struct fstrim_range *range)
>>>       cache = btrfs_lookup_first_block_group(fs_info, range->start);
>>>       for (; cache; cache = btrfs_next_block_group(cache)) {
>>> +        if (btrfs_trim_interrupted())
>>> +            break;
>>> +
> 
> The same here.
> 
ditto
>>>           if (cache->start >= range_end) {
>>>               btrfs_put_block_group(cache);
>>>               break;
>>> @@ -6547,17 +6556,20 @@ int btrfs_trim_fs(struct btrfs_fs_info
>>> *fs_info, struct fstrim_range *range)
>>>       mutex_lock(&fs_devices->device_list_mutex);
>>>       list_for_each_entry(device, &fs_devices->devices, dev_list) {
>>> +        if (btrfs_trim_interrupted())
>>> +            break;
>>> +
> 
> The same here.
> 
> Furthermore, I think we may not need the extra checks.
> 
> The fstrim is based on block groups, and a block group is normally 1GiB,
> at most 10GiB (for RAID0/5/6/10 only), thus exiting at each block group
> boundary should be enough to meet the hibernation/suspension timeout.
> 
> 
That's probably true, but 10 seconds here wasn't enough and forcing the 
early return in the other cases was also required.
I tried the current patch you linked earlier in my testings and that was 
the conclusion that led to me adding more checks.
> 
>>>           if (test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state))
>>>               continue;
>>>           ret = btrfs_trim_free_extents(device, &group_trimmed);
>>> +
>>> +        trimmed += group_trimmed;
>>>           if (ret) {
>>>               dev_failed++;
>>>               dev_ret = ret;
>>>               break;
>>>           }
>>> -
>>> -        trimmed += group_trimmed;
> 
> Any special reason moving the code here?

Same as not returning errno before in case of interrupt.
I checked the code paths and it's still possible to trim some data 
(group_trimmed != 0) even in case of failure.

> 
> Thanks,
> Qu
> 
>>>       }
>>>       mutex_unlock(&fs_devices->device_list_mutex);
>>

Thanks, Luca.

