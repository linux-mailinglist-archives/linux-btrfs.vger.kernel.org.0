Return-Path: <linux-btrfs+bounces-7729-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF7096833D
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 11:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62AE11F233DE
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 09:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F279A1CB145;
	Mon,  2 Sep 2024 09:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOQ+vyyp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C11CB137;
	Mon,  2 Sep 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725269475; cv=none; b=H2O+0ZZ/zrF8uB2ZyVy9ZCewKMcbwfEbeNAdHVSl1noW4lLdmU28ubefahsi6SxOULV2gnCT5+anmL93M9s65pCLw7YLEFVds9WrFIuEcByhJv3/R8CKE/4zrEg6/6MFdCDBUbV470IiE3w01HnDRVxL4xoEGPSNDIjSMkYWeAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725269475; c=relaxed/simple;
	bh=N8seL/p2WOE4ANdzhWD8Xptu9CmwupWzMuGGD/lNrRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e4DkDnmrkzvnPt+0tC1xu+eUC7aDK3BBBf80PWpzPKecP0+DXOqvjl0Z2GTI0mUJpJ/3Hi/v/MkKp8zCRZFUe1dAF5LW4f7viS5MZh7OO4phPWMaAlmbDQ7UGqHcEC76rCiLde+74dliqd9GFc/jXkRTHJD2u47wAf3XdR9k+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOQ+vyyp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bbd16fcf2so24860785e9.2;
        Mon, 02 Sep 2024 02:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725269471; x=1725874271; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzi5qh/D/H8RhUaXHzJGQDS50MPVabk2Nwlc+bFhRgM=;
        b=lOQ+vyyphmxy+78OEiGEE9qFblrCS0Dnd35EL6KDuU+PTfJfFOv9p3KwNfJKLw0uDs
         Q8IBMJL0Ogykhoo8ea+uQhdJysMnFwirW7BoTo+akZrNZaXt+bDIbiCLenhCkrGqrgsp
         Rwcjc3ui2850BHp1qIBxB/w7lBTKSOE6RO9IkzEL457q+ylJVTo5cHddXE+ZP8GSYEtx
         DVSgNTPARpa4PQUzn5Njd/moeqU+q8HsXO++pG33oo9Wpr4tL2yvRVcPvraKE/MBUuA1
         LaIe+TuOZSW8L1b/J04khtn/1iK332t4ObDxGUXpjJj8mFTLGLM2SqAJN+qfssZFRldS
         6bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725269471; x=1725874271;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzi5qh/D/H8RhUaXHzJGQDS50MPVabk2Nwlc+bFhRgM=;
        b=K3I7OvRz6y5NPP1kVOp17x1PO8K3FpWfa9Ty/7NXFbjTkDUxAC44b4MIDImMq8KIpG
         d6QFzLF/hg5lHxsaJIfkCmkvtoS9i4RPAaM3IPxh0Ve82Mvg3MtkMvay1ZHOm2x/kvrQ
         +tKsNap7tNGZ3LozvtndnwMwVpZ19k7iWvPotBArMWVL7G6vTtOHtWi9mcW94OXSFczp
         52F2Gj+jGAN1bnjvhJpYEdWLOK1GxDBlP9B4w9Zrr/XGQAAZjcIjhlq/KG2XX1jysVrY
         F4jrCUX4NgGOX+vp8v8Vmbr00ViZYoczQcHtIzYtRgYhEXhmH8qsWa2UnuhK6InXOEXW
         RXOA==
X-Forwarded-Encrypted: i=1; AJvYcCU+LPSB4b8+PjZ6apSzOph4J7bkkvGdhSDVOuNVP/UxQrdKIziOUCEaT1hwTUnPxgBAUFQ3kvDi454uHA==@vger.kernel.org, AJvYcCUhyUMYOziqOSZ+ocMYTwypXK1E5w3gVwZmyJ7G5WLpQ7Abd6X1ARZx2L3gKVP2WiZ5Jm8n8J93p+DCKHEX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3mVERJT857/ahCjL5gJQvzDg9dJTQlxAvDZc+4mpLfydiB6p
	rXs3XEXtjMaBD/1cAReL6+ePstoAyzuXm+cHymsGKyChdoRjVdVH
X-Google-Smtp-Source: AGHT+IEVW2KQvBBg3HAsNqYdABtZm/r59QF+Ch5RRPSgXyT54PgDmv/Cm8p+tfzd2HpA3UYeu2SgYw==
X-Received: by 2002:adf:ecd0:0:b0:374:ce8b:bc65 with SMTP id ffacd0b85a97d-374ce8bbdb1mr852370f8f.56.1725269471107;
        Mon, 02 Sep 2024 02:31:11 -0700 (PDT)
Received: from [192.168.50.7] (net-109-116-17-225.cust.vodafonedsl.it. [109.116.17.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4abbesm10921193f8f.23.2024.09.02.02.31.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 02:31:10 -0700 (PDT)
Message-ID: <072aba7d-6571-4b22-875d-3409c0eefe40@gmail.com>
Date: Mon, 2 Sep 2024 11:31:09 +0200
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
 <CAO0HQ0X3zk6aau50Ew2nmNP-pwNEkmgAoC2Ewmi30sGi7uQwDA@mail.gmail.com>
 <22c49ecd-e268-4738-853e-9f79ea1e87f7@gmx.com>
 <94178c8f-c9d6-4c3e-9d1d-6d465d379e0f@gmx.com>
Content-Language: en-US
From: Luca Stefani <luca.stefani.ge1@gmail.com>
In-Reply-To: <94178c8f-c9d6-4c3e-9d1d-6d465d379e0f@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 02/09/24 11:17, Qu Wenruo wrote:
> 
> 
> 在 2024/9/2 18:42, Qu Wenruo 写道:
>>
>>
>> 在 2024/9/2 18:30, Luca Stefani 写道:
>>>
>>>
>>> On Mon, 2 Sept 2024 at 10:49, Qu Wenruo <quwenruo.btrfs@gmx.com
>>> <mailto:quwenruo.btrfs@gmx.com>> wrote:
>>>
>>>
>>>
>>>     在 2024/9/2 18:02, Luca Stefani 写道:
>>>      > Any update on this? It's not critical but I'd like to know if 
>>> it's in
>>>      > some part proper.
>>>      > Thanks, Luca.
>>>
>>>     Sorry I didn't see your patch in the list, thus sent a different 
>>> fix for
>>>     it later:
>>>
>>> https://lore.kernel.org/linux-btrfs/20240830185113.GW25962@twin.jikos.cz/T/#t <https://lore.kernel.org/linux-btrfs/20240830185113.GW25962@twin.jikos.cz/T/#t>
>>>
>>>      >> Sometimes the system isn't able to suspend because
>>>      >> the task responsible for trimming the device isn't
>>>      >> able to finish in time.
>>>      >>
>>>      >> Since discard isn't a critical call it can be interrupted
>>>      >> at any time, we can simply report the amount of discarded
>>>      >> bytes in such cases and stop the trim.
>>>      >>
>>>      >> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219180
>>>     <https://bugzilla.kernel.org/show_bug.cgi?id=219180>
>>>      >> Signed-off-by: Luca Stefani <luca.stefani.ge1@gmail.com
>>>     <mailto:luca.stefani.ge1@gmail.com>>
>>>      >> ---
>>>      >> I have no idea if that's correct, just something I implemented
>>>      >> looking at the same solution made in ext4 by 5229a658f645.
>>>      >>
>>>      >> The patch in itself seems to solve the issue.
>>>      >>
>>>      >> repro is as follows:
>>>      >> sudo /sbin/fstrim --listed-in /etc/fstab:/proc/self/mountinfo
>>>      >> --verbose --quiet-unsupported &
>>>      >> sudo ./sleepgraph.py -m mem -rtcwake 5
>>>      >>
>>>      >> [836563.289069] PM: suspend exit
>>>      >> [836563.909298] PM: suspend entry (s2idle)
>>>      >> [836563.935447] Filesystems sync: 0.026 seconds
>>>      >> [836563.951391] Freezing user space processes
>>>      >> [836583.958957] Freezing user space processes failed after 
>>> 20.007
>>>      >> seconds (1 tasks refusing to freeze, wq_busy=0):
>>>      >> [836583.959582] task:fstrim          state:D stack:0 pid:241865
>>>      >> tgid:241865 ppid:241864 flags:0x00004006
>>>      >> [836583.959592] Call Trace:
>>>      >> [836583.959595]  <TASK>
>>>      >> [836583.959600]  __schedule+0x400/0x1720
>>>      >> [836583.959612]  ? mod_delayed_work_on+0xa4/0xb0
>>>      >> [836583.959622]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959628]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959631]  ? blk_mq_flush_plug_list.part.0+0x1e3/0x610
>>>      >> [836583.959640]  schedule+0x27/0xf0
>>>      >> [836583.959644]  schedule_timeout+0x12f/0x160
>>>      >> [836583.959652]  io_schedule_timeout+0x51/0x70
>>>      >> [836583.959657]  wait_for_completion_io+0x8a/0x160
>>>      >> [836583.959663]  submit_bio_wait+0x60/0x90
>>>      >> [836583.959671]  blkdev_issue_discard+0x91/0x100
>>>      >> [836583.959680]  btrfs_issue_discard+0xc4/0x140
>>>      >> [836583.959689]  btrfs_discard_extent+0x241/0x2a0
>>>      >> [836583.959695]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959702]  do_trimming+0xd2/0x240
>>>      >> [836583.959712]  trim_bitmaps+0x350/0x4c0
>>>      >> [836583.959723]  btrfs_trim_block_group+0xb8/0x110
>>>      >> [836583.959729]  btrfs_trim_fs+0x118/0x440
>>>      >> [836583.959734]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959738]  ? security_capable+0x41/0x70
>>>      >> [836583.959746]  btrfs_ioctl_fitrim+0x113/0x180
>>>      >> [836583.959752]  btrfs_ioctl+0xdaf/0x2670
>>>      >> [836583.959759]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959763]  ? ioctl_has_perm.constprop.0.isra.0+0xd8/0x130
>>>      >> [836583.959774]  __x64_sys_ioctl+0x94/0xd0
>>>      >> [836583.959782]  do_syscall_64+0x82/0x160
>>>      >> [836583.959790]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959793]  ? syscall_exit_to_user_mode+0x72/0x220
>>>      >> [836583.959799]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959802]  ? do_syscall_64+0x8e/0x160
>>>      >> [836583.959807]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959811]  ? do_sys_openat2+0x9c/0xe0
>>>      >> [836583.959821]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959825]  ? syscall_exit_to_user_mode+0x72/0x220
>>>      >> [836583.959828]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959832]  ? do_syscall_64+0x8e/0x160
>>>      >> [836583.959835]  ? syscall_exit_to_user_mode+0x72/0x220
>>>      >> [836583.959838]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959842]  ? do_syscall_64+0x8e/0x160
>>>      >> [836583.959845]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959849]  ? do_syscall_64+0x8e/0x160
>>>      >> [836583.959851]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959855]  ? do_syscall_64+0x8e/0x160
>>>      >> [836583.959858]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959861]  ? do_syscall_64+0x8e/0x160
>>>      >> [836583.959864]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959868]  ? srso_alias_return_thunk+0x5/0xfbef5
>>>      >> [836583.959873]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>>>      >> [836583.959878] RIP: 0033:0x7f3e4261af2d
>>>      >> [836583.959944] RSP: 002b:00007ffec002f400 EFLAGS: 00000246
>>>     ORIG_RAX:
>>>      >> 0000000000000010
>>>      >> [836583.959950] RAX: ffffffffffffffda RBX: 00007ffec002f570 RCX:
>>>      >> 00007f3e4261af2d
>>>      >> [836583.959952] RDX: 00007ffec002f470 RSI: 00000000c0185879 RDI:
>>>      >> 0000000000000003
>>>      >> [836583.959955] RBP: 00007ffec002f450 R08: 0000562d74da7010 R09:
>>>      >> 00007ffec002e7f2
>>>      >> [836583.959957] R10: 0000000000000000 R11: 0000000000000246 R12:
>>>      >> 0000562d74daafc0
>>>      >> [836583.959960] R13: 0000000000000003 R14: 0000562d74daa970 R15:
>>>      >> 0000562d74daad40
>>>      >> [836583.959967]  </TASK>
>>>      >> ---
>>>      >>   fs/btrfs/extent-tree.c | 20 ++++++++++++++++----
>>>      >>   1 file changed, 16 insertions(+), 4 deletions(-)
>>>      >>
>>>      >> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>>      >> index feec49e6f9c8..7e4c1d4f2f7c 100644
>>>      >> --- a/fs/btrfs/extent-tree.c
>>>      >> +++ b/fs/btrfs/extent-tree.c
>>>      >> @@ -16,6 +16,7 @@
>>>      >>   #include <linux/percpu_counter.h>
>>>      >>   #include <linux/lockdep.h>
>>>      >>   #include <linux/crc32c.h>
>>>      >> +#include <linux/freezer.h>
>>>      >>   #include "ctree.h"
>>>      >>   #include "extent-tree.h"
>>>      >>   #include "transaction.h"
>>>      >> @@ -6361,6 +6362,11 @@ void 
>>> btrfs_error_unpin_extent_range(struct
>>>      >> btrfs_fs_info *fs_info, u64 start, u6
>>>      >>       unpin_extent_range(fs_info, start, end, false);
>>>      >>   }
>>>      >> +static bool btrfs_trim_interrupted(void)
>>>      >> +{
>>>      >> +    return fatal_signal_pending(current) || freezing(current);
>>>      >> +}
>>>      >> +
>>>      >>   /*
>>>      >>    * It used to be that old block groups would be left around
>>>     forever.
>>>      >>    * Iterating over them would be enough to trim unused space.
>>>     Since we
>>>      >> @@ -6459,8 +6465,8 @@ static int btrfs_trim_free_extents(struct
>>>      >> btrfs_device *device, u64 *trimmed)
>>>      >>           start += len;
>>>      >>           *trimmed += bytes;
>>>      >> -        if (fatal_signal_pending(current)) {
>>>      >> -            ret = -ERESTARTSYS;
>>>      >> +        if (btrfs_trim_interrupted()) {
>>>      >> +            ret = 0;
>>>      >>               break;
>>>
>>>     Here we should still return the same error number other than 0, 
>>> to let
>>>     the caller know the operation is interrupted, other than finished
>>>     normally.
>>>
>>> Here I was following how ext4 did it, my explanation for that was that
>>> the kernel
>>> may have still discarded some data before the thread was interrupted
>>> thus it made
>>> sense to report success.
>>
>> In that case, progress is reported through fstrim_range structure, not
>> through the return value.
>> Even if we returned some error code, the fstrim_range::len is still
>> updated to indicate the progress.
>>
>> So we need to keep the error code.
>>
>>>
>>>
>>>      >>           }
>>>      >> @@ -6508,6 +6514,9 @@ int btrfs_trim_fs(struct btrfs_fs_info
>>>     *fs_info,
>>>      >> struct fstrim_range *range)
>>>      >>       cache = btrfs_lookup_first_block_group(fs_info, 
>>> range->start);
>>>      >>       for (; cache; cache = btrfs_next_block_group(cache)) {
>>>      >> +        if (btrfs_trim_interrupted())
>>>      >> +            break;
>>>      >> +
>>>
>>>     The same here.
>>>
>>>      >>           if (cache->start >= range_end) {
>>>      >>               btrfs_put_block_group(cache);
>>>      >>               break;
>>>      >> @@ -6547,17 +6556,20 @@ int btrfs_trim_fs(struct btrfs_fs_info
>>>      >> *fs_info, struct fstrim_range *range)
>>>      >>       mutex_lock(&fs_devices->device_list_mutex);
>>>      >>       list_for_each_entry(device, &fs_devices->devices, 
>>> dev_list) {
>>>      >> +        if (btrfs_trim_interrupted())
>>>      >> +            break;
>>>      >> +
>>>
>>>     The same here.
>>>
>>>     Furthermore, I think we may not need the extra checks.
>>>
>>>     The fstrim is based on block groups, and a block group is 
>>> normally 1GiB,
>>>     at most 10GiB (for RAID0/5/6/10 only), thus exiting at each block 
>>> group
>>>     boundary should be enough to meet the hibernation/suspension 
>>> timeout.
>>>
>>> That's probably true, but 10seconds here wasn't enough and forcing the
>>> early return in the other cases
>>> was also required.
>>> I tried the current patch you linked earlier in my testing and that was
>>> the conclusion that led to me adding more checks.
>>
>> My bad, I forgot that we have free extents trimming, which is not
>> limited to block group boundary, and that may be the root cause.
>>
>> So in that case your extra checks are indeed needed.
>>
>> Just need to change the return value.
>>>
>>>
>>>
>>>
>>>      >>           if (test_bit(BTRFS_DEV_STATE_MISSING, 
>>> &device->dev_state))
>>>      >>               continue;
>>>      >>           ret = btrfs_trim_free_extents(device, &group_trimmed);
>>>      >> +
>>>      >> +        trimmed += group_trimmed;
>>>      >>           if (ret) {
>>>      >>               dev_failed++;
>>>      >>               dev_ret = ret;
>>>      >>               break;
>>>      >>           }
>>>      >> -
>>>      >> -        trimmed += group_trimmed;
>>>
>>>     Any special reason moving the code here?
>>>
>>> Same as not returning errno before in case of interrupt, I checked the
>>> code paths and it's still
>>> possible to trim some data (group_trimmed != 0) even in case of failure.
>>
>> Oh, then it's fine.
>>
>> Except the return code, everything looks fine to me now.
> 
> Forgot to mention that, even for error case, we should copy the 
> fstrim_range structure to the ioctl parameter to indicate any progress 
> we made.
This seems to be already the case.
range->len = trimmed; is always executed regardless of previous failures
and there doesn't seem to be any early return.

Will try adding back the errno and try the repro.

Thanks.
> 
> Thanks,
> Qu
>>
>> Just please update the commit message to explicitly mention that, we
>> have a free extent discarding phase, which can trim a lot of unallocated
>> space, and there is no limits on the trim size (unlike the block group
>> part).
>>
>> Thanks,
>> Qu
>>>
>>>     Thanks,
>>>     Qu
>>>
>>>      >>       }
>>>      >>       mutex_unlock(&fs_devices->device_list_mutex);
>>>      >
>>>
>>

