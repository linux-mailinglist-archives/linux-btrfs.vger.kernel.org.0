Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2703FEF34
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Sep 2021 16:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345431AbhIBOLH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Sep 2021 10:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbhIBOLH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Sep 2021 10:11:07 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A2C061575
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Sep 2021 07:10:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id bg1so1261737plb.13
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Sep 2021 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=RxGiopVxYi7jZI5qNDm9xodLF8ViPMNCO3OqZpcVaos=;
        b=ZH1yNQK2C6KQPivGnAJgAS/Iyqx+pk4a0loQGEBYEdbfpqd+w63GvJigdtk5f0kL2K
         OyY7SsWvbo/8l9FWb//LxtsPoHYsM22OWZAsn2ly2Aung5O/6gC3REpm2BsUMrvc8tsb
         YLfKoMijPa9gPQztFe/KzGkgx9goJ3EIIorgt7Vm/EQ5tt26JsSzcEYy4He8cbqb/NsO
         fQhNYTAJy1bz4gCUd6+j6vjNkhZAmaUvhlYXbV7lfXpeZa5DbVler9ea00Ufm3Vt7Cva
         GZ5bH2OPtcV2thMxGL69D7KjSR73I+jIXagYixlXsttXQjQ+r3Tk8bWQCMBtZ1hUNIt0
         G7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RxGiopVxYi7jZI5qNDm9xodLF8ViPMNCO3OqZpcVaos=;
        b=pmlm1xcx/bwF1Svp7F91WgkNKEe06dAt+HiFM0cQN/N4rXbFBxjQz249NxzO0VAHBW
         CH2++5dNt2qflrqXllsEkC7fuWT9G6lOPhsahnbbUH8R1tuB96csyvJgSENTcJptBSe3
         EY0cZ5f5xJg+SRgN6ZcXOwVAGljXni8M1pW/raEclr5cBN/EZwvjtC19fDCvCL4ylsH4
         +CZoVHLM26oKufhrxqzde8s7t5NteZPQf289HBBGsmay4882If8I6eoj6gAVALigPveI
         JuLxYIFNVbHJCr0hHR0v5f92EIBn72AI0pDsB4uRHVUufDTKvaBuNPpkTiPhOKh1DfoT
         exbw==
X-Gm-Message-State: AOAM5301GD35rAACHxXICzPxMHvIfhh/niPCWXRI9q5lGIVgabdEuH3I
        ef3JpTF/I/EREWkhOA+byUdzkw7dgDu9Lw==
X-Google-Smtp-Source: ABdhPJz3UOocmvKHenb3lJDKdj0qcDdv2r9rgAWNGgcRmF46p9apToZUvx8UOTo885Z665ioKanMvg==
X-Received: by 2002:a17:90a:6c41:: with SMTP id x59mr3729721pjj.68.1630591808007;
        Thu, 02 Sep 2021 07:10:08 -0700 (PDT)
Received: from [192.168.1.53] ([209.133.79.250])
        by smtp.gmail.com with ESMTPSA id 132sm2498789pfy.190.2021.09.02.07.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 07:10:07 -0700 (PDT)
Message-ID: <bfd5a7be-da05-62de-997e-2e513c606915@toxicpanda.com>
Date:   Thu, 2 Sep 2021 10:10:04 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH v2 2/7] btrfs: do not take the uuid_mutex in
 btrfs_rm_device
Content-Language: en-US
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1627419595.git.josef@toxicpanda.com>
 <4f7529acd33594df9b0b06f7011d8cd4d195fc29.1627419595.git.josef@toxicpanda.com>
 <20210902125820.GR3379@twin.jikos.cz>
From:   Josef Bacik <josef@toxicpanda.com>
In-Reply-To: <20210902125820.GR3379@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/21 8:58 AM, David Sterba wrote:
> On Tue, Jul 27, 2021 at 05:01:14PM -0400, Josef Bacik wrote:
>> We got the following lockdep splat while running xfstests (specifically
>> btrfs/003 and btrfs/020 in a row) with the new rc.  This was uncovered
>> by 87579e9b7d8d ("loop: use worker per cgroup instead of kworker") which
>> converted loop to using workqueues, which comes with lockdep
>> annotations that don't exist with kworkers.  The lockdep splat is as
>> follows
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 5.14.0-rc2-custom+ #34 Not tainted
>> ------------------------------------------------------
>> losetup/156417 is trying to acquire lock:
>> ffff9c7645b02d38 ((wq_completion)loop0){+.+.}-{0:0}, at: flush_workqueue+0x84/0x600
>>
>> but task is already holding lock:
>> ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #5 (&lo->lo_mutex){+.+.}-{3:3}:
>>         __mutex_lock+0xba/0x7c0
>>         lo_open+0x28/0x60 [loop]
>>         blkdev_get_whole+0x28/0xf0
>>         blkdev_get_by_dev.part.0+0x168/0x3c0
>>         blkdev_open+0xd2/0xe0
>>         do_dentry_open+0x163/0x3a0
>>         path_openat+0x74d/0xa40
>>         do_filp_open+0x9c/0x140
>>         do_sys_openat2+0xb1/0x170
>>         __x64_sys_openat+0x54/0x90
>>         do_syscall_64+0x3b/0x90
>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> -> #4 (&disk->open_mutex){+.+.}-{3:3}:
>>         __mutex_lock+0xba/0x7c0
>>         blkdev_get_by_dev.part.0+0xd1/0x3c0
>>         blkdev_get_by_path+0xc0/0xd0
>>         btrfs_scan_one_device+0x52/0x1f0 [btrfs]
>>         btrfs_control_ioctl+0xac/0x170 [btrfs]
>>         __x64_sys_ioctl+0x83/0xb0
>>         do_syscall_64+0x3b/0x90
>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> -> #3 (uuid_mutex){+.+.}-{3:3}:
>>         __mutex_lock+0xba/0x7c0
>>         btrfs_rm_device+0x48/0x6a0 [btrfs]
>>         btrfs_ioctl+0x2d1c/0x3110 [btrfs]
>>         __x64_sys_ioctl+0x83/0xb0
>>         do_syscall_64+0x3b/0x90
>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> -> #2 (sb_writers#11){.+.+}-{0:0}:
>>         lo_write_bvec+0x112/0x290 [loop]
>>         loop_process_work+0x25f/0xcb0 [loop]
>>         process_one_work+0x28f/0x5d0
>>         worker_thread+0x55/0x3c0
>>         kthread+0x140/0x170
>>         ret_from_fork+0x22/0x30
>>
>> -> #1 ((work_completion)(&lo->rootcg_work)){+.+.}-{0:0}:
>>         process_one_work+0x266/0x5d0
>>         worker_thread+0x55/0x3c0
>>         kthread+0x140/0x170
>>         ret_from_fork+0x22/0x30
>>
>> -> #0 ((wq_completion)loop0){+.+.}-{0:0}:
>>         __lock_acquire+0x1130/0x1dc0
>>         lock_acquire+0xf5/0x320
>>         flush_workqueue+0xae/0x600
>>         drain_workqueue+0xa0/0x110
>>         destroy_workqueue+0x36/0x250
>>         __loop_clr_fd+0x9a/0x650 [loop]
>>         lo_ioctl+0x29d/0x780 [loop]
>>         block_ioctl+0x3f/0x50
>>         __x64_sys_ioctl+0x83/0xb0
>>         do_syscall_64+0x3b/0x90
>>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> other info that might help us debug this:
>> Chain exists of:
>>    (wq_completion)loop0 --> &disk->open_mutex --> &lo->lo_mutex
>>   Possible unsafe locking scenario:
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(&lo->lo_mutex);
>>                                 lock(&disk->open_mutex);
>>                                 lock(&lo->lo_mutex);
>>    lock((wq_completion)loop0);
>>
>>   *** DEADLOCK ***
>> 1 lock held by losetup/156417:
>>   #0: ffff9c7647395468 (&lo->lo_mutex){+.+.}-{3:3}, at: __loop_clr_fd+0x41/0x650 [loop]
>>
>> stack backtrace:
>> CPU: 8 PID: 156417 Comm: losetup Not tainted 5.14.0-rc2-custom+ #34
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>> Call Trace:
>>   dump_stack_lvl+0x57/0x72
>>   check_noncircular+0x10a/0x120
>>   __lock_acquire+0x1130/0x1dc0
>>   lock_acquire+0xf5/0x320
>>   ? flush_workqueue+0x84/0x600
>>   flush_workqueue+0xae/0x600
>>   ? flush_workqueue+0x84/0x600
>>   drain_workqueue+0xa0/0x110
>>   destroy_workqueue+0x36/0x250
>>   __loop_clr_fd+0x9a/0x650 [loop]
>>   lo_ioctl+0x29d/0x780 [loop]
>>   ? __lock_acquire+0x3a0/0x1dc0
>>   ? update_dl_rq_load_avg+0x152/0x360
>>   ? lock_is_held_type+0xa5/0x120
>>   ? find_held_lock.constprop.0+0x2b/0x80
>>   block_ioctl+0x3f/0x50
>>   __x64_sys_ioctl+0x83/0xb0
>>   do_syscall_64+0x3b/0x90
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>> RIP: 0033:0x7f645884de6b
>>
>> Usually the uuid_mutex exists to protect the fs_devices that map
>> together all of the devices that match a specific uuid.  In rm_device
>> we're messing with the uuid of a device, so it makes sense to protect
>> that here.
>>
>> However in doing that it pulls in a whole host of lockdep dependencies,
>> as we call mnt_may_write() on the sb before we grab the uuid_mutex, thus
>> we end up with the dependency chain under the uuid_mutex being added
>> under the normal sb write dependency chain, which causes problems with
>> loop devices.
>>
>> We don't need the uuid mutex here however.  If we call
>> btrfs_scan_one_device() before we scratch the super block we will find
>> the fs_devices and not find the device itself and return EBUSY because
>> the fs_devices is open.  If we call it after the scratch happens it will
>> not appear to be a valid btrfs file system.
> 
> This is a bit hand wavy but the critical part of the correctness proof,
> and it's not explaining it enough IMO. The important piece happens in
> device_list_add, the fs_devices lookup and EBUSY, but all that is now
> excluded completely by the uuid_mutex from running in parallel with any
> part of rm_device.
> 
> This means that the state of the device is seen complete by each (scan,
> rm device). Without the uuid mutex the scaning can find the signature,
> then try to lookup the device in the list, while in parallel the rm
> device changes the signature or manipulates the list. But not everything
> is covered by the device list mutex so there are combinations of both
> tasks with some in-progress state.  Also count in the RCU protection.
> 
>  From high level it is what you say about ordering scan/scratch, but
> otherwise I'm not convinced that the change is not subtly breaking
> something.
> 

Yeah this is far from ideal, we really need to rework our entire device 
liftetime handling and locking, however this isn't going to break 
anything.  We are worried about rm and scan racing with each other, 
before this change we'll zero the device out under the UUID mutex so 
when scan does run it'll make sure that it can go through the whole 
device scan thing without rm messing with us.

We aren't worried if the scratch happens first, because the result is we 
don't think this is a btrfs device and we bail out.

The only case we are concerned with is we scratch _after_ scan is able 
to read the superblock and gets a seemingly valid super block, so lets 
consider this case.

Scan will call device_list_add() with the device we're removing.  We'll 
call find_fsid_with_metadata_uuid() and get our fs_devices for this 
UUID.  At this point we lock the fs_devices->device_list_mutex.  This is 
what protects us in this case, but we have two cases here.

1. We aren't to the device removal part of the RM.  We found our device, 
and device name matches our path, we go down and we set total_devices to 
our super number of devices, which doesn't affect anything because we 
haven't done the remove yet.

2. We are past the device removal part, which is protected by the 
device_list_mutex.  Scan doesn't find the device, it goes down and does the

if (fs_devices->opened)
	return -EBUSY;

check and we bail out.

Nothing about this situation is ideal, but the lockdep splat is real, 
and the fix is safe, tho admittedly a bit scary looking.  Thanks,

Josef
