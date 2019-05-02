Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2055D1107E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2019 02:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfEBAMu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 May 2019 20:12:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37512 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfEBAMu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 May 2019 20:12:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id h126so536063lfh.4
        for <linux-btrfs@vger.kernel.org>; Wed, 01 May 2019 17:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lTvcx2ZOy+wksEFVTU1PXoa/j7HwuC0h7HBTpekvKWc=;
        b=vubC09X75nFt58lP5auIj92BPwmQEFz7EBNquJcnq75ZnVXIPMQSbAbrE1ehtl0b5Y
         zOzicX7x87ZbH68XHJ/kqQJxT0K9BjmMV7LCo/wajAwzMaTj4l3EbKfjVUeDk63kqQDV
         284JLB0ylDcmiAg+MJSR2E71b0Nwe2zb4Ur645B6+SGsxHbnTk5iKLJ9inbjItjNlNqQ
         DdIfMxDFSmUEixhkgkOOfaXWOGH0pBSxkK6Ud9K13A7f0/8xuWfCCHi0JtuZ5NcKYhaK
         lx6DKDXapHoTuqSDHYfH0poyJTh6sKezwpCnt/71691g992aophlswgZKC2VudhmySM0
         DD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lTvcx2ZOy+wksEFVTU1PXoa/j7HwuC0h7HBTpekvKWc=;
        b=RGB/TUVb7oD0ik/dhyL3ymfFga3HzGk926YvO9QcJenETd4tJxsOmdq2AnW6OEwOS4
         ElNxQlzmpCNkALQK7hYh/QUuDTced5WZN0rJr9GuZJvWQAzbMe8m2J9fnO3ZiSJVr7ie
         Ln8qavXdfifJE0TczMY2/F3+GMn5yVyZHmQ5bjGv+VK/2sC2Tb2FRdJ230pNpVyIWr4S
         xoRoOg2xeZBQax+3QM1FW6Grb2UGhCEIgXCJhYGq0xDHjAf3OhkrKbca0hprVsl5HbYW
         Nhjj75BjY/6OvvlBKv3fuw5IrHVLl6EvCnhJdfLl0+aet5IPYwFL9ZZ31mr2tIYfES0i
         26OA==
X-Gm-Message-State: APjAAAWA0s1FZNlvKk0m+xeTP4OpXaHSc9xc+6QzGnsH46zX8aT1tLsu
        1u/i3pTuFruxgs27DNS8QAAHpACnR4F4ikczLMQyUgibrjA=
X-Google-Smtp-Source: APXvYqy8TiMKZQzXDWeSDJEORiLPZvAB6kZ/IUQzhowuQ8UDGLlxJGRpltcoJvadq9+bROgenGWhW3V+lRA10DnqSk4=
X-Received: by 2002:ac2:5582:: with SMTP id v2mr336341lfg.19.1556755967605;
 Wed, 01 May 2019 17:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <em6b2fc230-16e7-495d-85b9-e88a08b7bcd3@ryzen>
In-Reply-To: <em6b2fc230-16e7-495d-85b9-e88a08b7bcd3@ryzen>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 1 May 2019 18:12:36 -0600
Message-ID: <CAJCQCtTcyLdK4fM9fsQb2KKm8d-gZ8xiJ68L2E_H6X5g69-fhA@mail.gmail.com>
Subject: Re: Rough (re)start with btrfs
To:     Hendrik Friedel <hendrik@friedels.name>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 1, 2019 at 7:54 AM Hendrik Friedel <hendrik@friedels.name> wrote:
>
> Hello,
>
> as discussed in the other thread, I am migrating to BTRFS (again).
> Unfortunately, I had a bit of a rough start
> [Mo Apr 29 20:44:47 2019] INFO: task btrfs-transacti:10227 blocked for
> more than 120 seconds.
> [...]
> This repeated several times while moving data over. Full log of one
> instance below.
>
> I am using btrfs-progs v4.20.2 and debian stretch with
> 4.19.0-0.bpo.2-amd64 (I think, this is the latest Kernel available in
> stretch. Please correct if I am wrong.

What scheduler is being used for the drive?

# cat /sys/block/<dev>/queue/scheduler

If it's none, then kernel version and scheduler aren't likely related
to what you're seeing.

It's not immediately urgent, but I would still look for something
newer, just because the 4.19 series already has 37 upstream updates
released, each with dozens of fixes, easily there are over 1000 fixes
available in total. I'm not a Debian user but I think there's
stretch-backports that has newer kernels?
http://jensd.be/818/linux/install-a-newer-kernel-in-debian-9-stretch-stable



> [Mo Apr 29 20:44:47 2019] INFO: task btrfs-transacti:10227 blocked for
> more than 120 seconds.
> [Mo Apr 29 20:44:47 2019]       Not tainted 4.19.0-0.bpo.2-amd64 #1
> Debian 4.19.16-1~bpo9+1
> [Mo Apr 29 20:44:47 2019] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Mo Apr 29 20:44:47 2019] btrfs-transacti D    0 10227      2 0x80000000
> [Mo Apr 29 20:44:47 2019] Call Trace:
> [Mo Apr 29 20:44:47 2019]  ? __schedule+0x3f5/0x880
> [Mo Apr 29 20:44:47 2019]  schedule+0x32/0x80
> [Mo Apr 29 20:44:47 2019]  wait_for_commit+0x41/0x80 [btrfs]
> [Mo Apr 29 20:44:47 2019]  ? remove_wait_queue+0x60/0x60
> [Mo Apr 29 20:44:47 2019]  btrfs_commit_transaction+0x10b/0x8a0 [btrfs]
> [Mo Apr 29 20:44:47 2019]  ? start_transaction+0x8f/0x3e0 [btrfs]
> [Mo Apr 29 20:44:47 2019]  transaction_kthread+0x157/0x180 [btrfs]
> [Mo Apr 29 20:44:47 2019]  kthread+0xf8/0x130
> [Mo Apr 29 20:44:47 2019]  ? btrfs_cleanup_transaction+0x500/0x500
> [btrfs]
> [Mo Apr 29 20:44:47 2019]  ? kthread_create_worker_on_cpu+0x70/0x70
> [Mo Apr 29 20:44:47 2019]  ret_from_fork+0x35/0x40
> [Mo Apr 29 20:44:47 2019] INFO: task kworker/u4:8:10576 blocked for more
> than 120 seconds.
> [Mo Apr 29 20:44:47 2019]       Not tainted 4.19.0-0.bpo.2-amd64 #1
> Debian 4.19.16-1~bpo9+1
> [Mo Apr 29 20:44:47 2019] "echo 0 >
> /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [Mo Apr 29 20:44:47 2019] kworker/u4:8    D    0 10576      2 0x80000000
> [Mo Apr 29 20:44:47 2019] Workqueue: events_unbound
> btrfs_async_reclaim_metadata_space [btrfs]
> [Mo Apr 29 20:44:47 2019] Call Trace:
> [Mo Apr 29 20:44:47 2019]  ? __schedule+0x3f5/0x880
> [Mo Apr 29 20:44:47 2019]  schedule+0x32/0x80
> [Mo Apr 29 20:44:47 2019]  wait_current_trans+0xb9/0xf0 [btrfs]
> [Mo Apr 29 20:44:47 2019]  ? remove_wait_queue+0x60/0x60
> [Mo Apr 29 20:44:47 2019]  start_transaction+0x201/0x3e0 [btrfs]
> [Mo Apr 29 20:44:47 2019]  flush_space+0x14d/0x5e0 [btrfs]
> [Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x40/0x70
> [Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x40/0x70
> [Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x40/0x70
> [Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x34/0x70
> [Mo Apr 29 20:44:47 2019]  ? __switch_to_asm+0x40/0x70
> [Mo Apr 29 20:44:47 2019]  ? get_alloc_profile+0x72/0x180 [btrfs]
> [Mo Apr 29 20:44:47 2019]  ? can_overcommit.part.63+0x55/0xe0 [btrfs]
> [Mo Apr 29 20:44:47 2019]  btrfs_async_reclaim_metadata_space+0xfb/0x4c0
> [btrfs]
> [Mo Apr 29 20:44:47 2019]  process_one_work+0x191/0x370
> [Mo Apr 29 20:44:47 2019]  worker_thread+0x4f/0x3b0
> [Mo Apr 29 20:44:47 2019]  kthread+0xf8/0x130
> [Mo Apr 29 20:44:47 2019]  ? rescuer_thread+0x340/0x340
> [Mo Apr 29 20:44:47 2019]  ? kthread_create_worker_on_cpu+0x70/0x70
> [Mo Apr 29 20:44:47 2019]  ret_from_fork+0x35/0x40

We need the entire dmesg so we can see if there are any earlier
complaints by the drive or the link. Can you attach the entire dmesg
as a file?

Also the output from

# smartctl -l gplog,0x13 /dev/sdX

If there's an error or it outputs nothing useful, then
# smarctl -x /dev/sdX

Also attach that as a file.

It's better if these things are file attachments, they're easier to
read, most MUAs do terrible line wraps.

-- 
Chris Murphy
