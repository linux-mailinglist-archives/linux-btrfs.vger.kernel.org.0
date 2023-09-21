Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216AD7A9E11
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 21:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjIUTzE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Sep 2023 15:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjIUTyY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Sep 2023 15:54:24 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5447091B9A;
        Thu, 21 Sep 2023 12:22:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 2568560173;
        Thu, 21 Sep 2023 21:22:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695324132; bh=PX2wFqIBZFyJNoXhgscY4UnjGGPUhV+rQrGGeIoS6t0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=z9/HFKocD8VYsdYFkOAyTegMz5blGVk6WQdA+6k6I2RedlbTq8Ot//rhItc8QQsSg
         HRkOd18etVv9B2sL1AIItuAk7E321PQ30pO8DCSLaRFLvDyQDUPRX6QCC+D16LZIdK
         s10/AVqlQpnMOXudkQPf+Wl+KVN6NvHd6QwPsy1rqGSsxImmtkAo8slC+YgL7cir5I
         iNAaBT47/Lkn/5jMFOKLdhNtJoTpCmxJb3Yom7CIoVxJpxWFFpIOVwkTj1PkWajB/n
         Qoa1Zfz1263E6jV5ONeipFjbFs/txDwuRxgAfncL1YY3LtGWmN4vuqt7G11T3ZN4xZ
         zA+hHK9aH321g==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uhgac2be-zFF; Thu, 21 Sep 2023 21:22:09 +0200 (CEST)
Received: from [192.168.1.6] (78-3-40-141.adsl.net.t-com.hr [78.3.40.141])
        by domac.alu.hr (Postfix) with ESMTPSA id 26B0A60157;
        Thu, 21 Sep 2023 21:22:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695324129; bh=PX2wFqIBZFyJNoXhgscY4UnjGGPUhV+rQrGGeIoS6t0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FhYVaIFb5/dEMbZ4a0ziNrSbCjxs/yhfZC7YCAIBaxiMevk9S5d8eau5pbVuzxuEP
         X3px327+nfU8W5QSqceGMkAZCkZfwcll7IJXnM7VY32xWDxkAAhGq/nTMZtksmjNpu
         Y3Eg8h2eC6LZky+OZb6jJ6SP633S2Va0Wq2Smo7pPw4rgA020CmT7kiz1ldj42N9h5
         Cz8iwEN1Fs9qOVCO2TbWOpuZgLeKz33qv6hEX3of8QCo1QIoEX91+jmNH/ReUu+qcl
         ftGsndfPmt3LSJQKw8rDpDB2DqIm4cXlwA2JQYV6QsqBd594Cn9pF3pHUvvj+J0joQ
         88pp1QLVfFdUg==
Message-ID: <b936c22f-5eb0-4f12-a6d5-7f69a42286f7@alu.unizg.hr>
Date:   Thu, 21 Sep 2023 21:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: KCSAN: data-race in btrfs_calculate_inode_block_rsv_size
 [btrfs] / btrfs_use_block_rsv [btrfs] [EXPERIMENTAL PATCH]
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        linux-kernel@vger.kernel.org
References: <c9e4e480-6f52-949b-e4b6-3eb0fcda3f83@alu.unizg.hr>
 <20230920152922.GC2268@twin.jikos.cz>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230920152922.GC2268@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/20/23 17:29, David Sterba wrote:
> On Wed, Sep 20, 2023 at 08:18:35AM +0200, Mirsad Todorovac wrote:
>> Hi,
>>
>> This is your friendly bug reporter again.
>>
>> Please don't throw stuff at me, as I found another KCSAN data-race problem.
>>
>> I feel like a boy who cried wolf ...
>>
>> I hope this will get some attention, as it looks this time like a real btrfs problem that could cause
>> the kernel module to make a wrong turn when managing storage in different threads simultaneously and
>> lead to the corruption of data. However, I do not have an example of this corruption, it is by now only
>> theoretical in this otherwise great filesystem.
>>
>> In fact, I can announce quite a number of KCSAN bugs already in dmesg log:
>>
>>      # of
>> occuren
>>       ces problematic function
>> -------------------------------------------
>>       182 __bitmap_and+0xa3/0x110
>>         2 __bitmap_weight+0x62/0xa0
>>       138 __call_rcu_common.constprop.0
>>         3 __cgroup_account_cputime
>>         1 __dentry_kill
>>         3 __mod_lruvec_page_state
>>        15 __percpu_counter_compare
>>         1 __percpu_counter_sum+0x8f/0x120
>>         1 acpi_ut_acquire_mutex
>>         2 amdgpu_fence_emit
>>         1 btrfs_calculate_inode_block_rsv_size
>>         1 btrfs_page_set_uptodate
>>        28 copy_from_read_buf
>>         3 d_add
>>         3 d_splice_alias
>>         1 delayacct_add_tsk+0x10d/0x630
>>         7 do_epoll_ctl
>>         1 do_vmi_align_munmap
>>        86 drm_sched_entity_is_ready
>>         4 drm_sched_entity_pop_job
>>         3 enqueue_timer
>>         1 finish_fault+0xde/0x360
>>         2 generic_fillattr
>>         2 getrusage
>>         9 getrusage+0x3ba/0xaa0
>>         1 getrusage+0x3df/0xaa0
>>         6 inode_needs_update_time
>>         1 inode_set_ctime_current
>>         1 inode_update_timestamps
>>         3 kernfs_refresh_inode
>>        22 ktime_get_mono_fast_ns+0x87/0x120
>>        13 ktime_get_mono_fast_ns+0xb0/0x120
>>        24 ktime_get_mono_fast_ns+0xc0/0x120
>>        79 mas_topiary_replace
>>        12 mas_wr_modify
>>        61 mas_wr_node_store
>>         1 memchr_inv+0x71/0x160
>>         1 memchr_inv+0xcf/0x160
>>        19 n_tty_check_unthrottle
>>         5 n_tty_kick_worker
>>        35 n_tty_poll
>>        32 n_tty_read
>>         1 n_tty_read+0x5f8/0xaf0
>>         3 osq_lock
>>        27 process_one_work
>>         4 process_one_work+0x169/0x700
>>         2 rcu_implicit_dynticks_qs
>>         1 show_stat+0x45b/0xb70
>>         3 task_mem
>>       344 tick_nohz_idle_stop_tick
>>        32 tick_nohz_next_event
>>         1 tick_nohz_next_event+0xe7/0x1e0
>>        90 tick_sched_do_timer
>>         5 tick_sched_do_timer+0x2c/0x120
>>         1 wbt_done
>>         1 wbt_issue
>>         2 wq_worker_tick
>>        37 xas_clear_mark
>>
>> ------------------------------------------------------
>>
>> This report is from a vanilla torvalds tree 6.6-rc2 kernel on Ubuntu 22.04:
>>
>> [13429.116126] ==================================================================
>> [13429.116794] BUG: KCSAN: data-race in btrfs_calculate_inode_block_rsv_size [btrfs] / btrfs_use_block_rsv [btrfs]
> 
> Thanks for the report.  Some data races are known to happen in the
> reservation code but all the critical changes are done under locks, so
> an optimistic check may skip locking to check a status but then it's
> done properly again under a lock. Generally speaking.
> 
> We had several reports from static checkers and at least in one case we
> added an annotation so KCSAN does not complain:
> 
> https://git.kernel.org/linus/748f553c3c4c4f175c6c834358632aff802d72cf
> 
> The original report is at
> 
> https://lore.kernel.org/linux-btrfs/CAAwBoOJDjei5Hnem155N_cJwiEkVwJYvgN-tQrwWbZQGhFU=cA@mail.gmail.com/
> 
> I have briefly looked at your report, it seems to be different from the
> one above but still matches the general approach to the reservations. If
> it's a false flag then we can add another wrapper with the annotation,
> unless it's a real bug.

Thank you for your bug report evaluation.

I cannot do more but pass on what KCSAN provides - my experience with btrfs is far from
required (on the level of fresh user).

However, without attempting to argue, it seems to be possible that there is a data-race,
because the read side is in the function is not protected by a lock, and theoretically
the block_rsv->failfast can change by the write-side thread while the read-side thread
is using various parts of the block_rsv structure w/o a read lock.

Best regards,
Mirsad Todorovac
