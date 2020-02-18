Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFDD162288
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Feb 2020 09:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgBRIlb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Feb 2020 03:41:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:43664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgBRIla (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Feb 2020 03:41:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 00310B240;
        Tue, 18 Feb 2020 08:41:27 +0000 (UTC)
Subject: Re: btrfs: convert metadata from raid5 to raid1
To:     Menion <menion@gmail.com>,
        =?UTF-8?Q?Sw=c3=a2mi_Petaramesh?= <swami@petaramesh.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
References: <CAJVZm6ewSViEzKRV4bwZFEYXYLhtx2QFvGiQJOD1sNdizL4HjA@mail.gmail.com>
 <641d8ba2-89c1-83ac-155f-f661f511218a@petaramesh.org>
 <CAJVZm6f6ntgnTuC76Juz9tkro1ybQaVLCV2xmPqyt5_9tPQP1Q@mail.gmail.com>
 <baa25ede-ee93-b11e-31e9-63c9e458e6e1@petaramesh.org>
 <CAJVZm6dyD1w6i6oRECGMhVOZcEH7OQvS_fP5bOyC3C7ZEi6Omg@mail.gmail.com>
 <CAJVZm6eQs228cH-VpDcuqudKHVr2zq=K4_RV--2bbAoGqTLL7g@mail.gmail.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6ec8e791-549d-37a8-e104-8c6d5b9daee8@suse.com>
Date:   Tue, 18 Feb 2020 10:41:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJVZm6eQs228cH-VpDcuqudKHVr2zq=K4_RV--2bbAoGqTLL7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 18.02.20 г. 10:34 ч., Menion wrote:
> Hello again
> 
> Task completed, I see in three occurrence of this event:
> 
> [518366.156963] INFO: task btrfs-cleaner:1034 blocked for more than 120 seconds.
> [518366.156989]       Not tainted 5.5.3-050503-generic #202002110832
> [518366.157024] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [518366.157044] btrfs-cleaner   D    0  1034      2 0x80004000
> [518366.157054] Call Trace:
> [518366.157082]  __schedule+0x2d8/0x760
> [518366.157094]  schedule+0x55/0xc0
> [518366.157105]  schedule_preempt_disabled+0xe/0x10
> [518366.157113]  __mutex_lock.isra.0+0x182/0x4f0
> [518366.157125]  __mutex_lock_slowpath+0x13/0x20
> [518366.157132]  mutex_lock+0x2e/0x40
> [518366.157261]  btrfs_delete_unused_bgs+0xc0/0x560 [btrfs]
> [518366.157322]  ? __wake_up+0x13/0x20
> [518366.157424]  cleaner_kthread+0x124/0x130 [btrfs]
> [518366.157437]  kthread+0x104/0x140
> [518366.157531]  ? kzalloc.constprop.0+0x40/0x40 [btrfs]
> [518366.157565]  ? kthread_park+0x90/0x90
> [518366.157575]  ret_from_fork+0x35/0x40
> 
> and
> 
> [518486.984177] INFO: task btrfs-cleaner:1034 blocked for more than 241 seconds.
> [518486.984204]       Not tainted 5.5.3-050503-generic #202002110832
> [518486.984216] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [518486.984233] btrfs-cleaner   D    0  1034      2 0x80004000
> [518486.984243] Call Trace:
> [518486.984271]  __schedule+0x2d8/0x760
> [518486.984284]  schedule+0x55/0xc0
> [518486.984295]  schedule_preempt_disabled+0xe/0x10
> [518486.984305]  __mutex_lock.isra.0+0x182/0x4f0
> [518486.984319]  __mutex_lock_slowpath+0x13/0x20
> [518486.984326]  mutex_lock+0x2e/0x40
> [518486.984451]  btrfs_delete_unused_bgs+0xc0/0x560 [btrfs]
> [518486.984464]  ? __wake_up+0x13/0x20
> [518486.984562]  cleaner_kthread+0x124/0x130 [btrfs]
> [518486.984573]  kthread+0x104/0x140
> [518486.984666]  ? kzalloc.constprop.0+0x40/0x40 [btrfs]
> [518486.984675]  ? kthread_park+0x90/0x90
> [518486.984686]  ret_from_fork+0x35/0x40
> 
> and
> 
> [518728.646379] INFO: task btrfs-cleaner:1034 blocked for more than 120 seconds.
> [518728.646413]       Not tainted 5.5.3-050503-generic #202002110832
> [518728.646428] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [518728.646447] btrfs-cleaner   D    0  1034      2 0x80004000
> [518728.646460] Call Trace:
> [518728.646494]  __schedule+0x2d8/0x760
> [518728.646508]  schedule+0x55/0xc0
> [518728.646522]  schedule_preempt_disabled+0xe/0x10
> [518728.646534]  __mutex_lock.isra.0+0x182/0x4f0
> [518728.646550]  __mutex_lock_slowpath+0x13/0x20
> [518728.646559]  mutex_lock+0x2e/0x40
> [518728.646719]  btrfs_delete_unused_bgs+0xc0/0x560 [btrfs]
> [518728.646735]  ? __wake_up+0x13/0x20
> [518728.646859]  cleaner_kthread+0x124/0x130 [btrfs]
> [518728.646875]  kthread+0x104/0x140
> [518728.647019]  ? kzalloc.constprop.0+0x40/0x40 [btrfs]
> [518728.647031]  ? kthread_park+0x90/0x90
> [518728.647045]  ret_from_fork+0x35/0x40
> 
> Is it a kind of normal?
> Thanks, bye


provide the output of echo w > /proc/sysrq-trigger

I suspect there were 3 times that there was lock contention on
delete_unused_bgs_mutex due to balance. Unless it persists it's fine.
