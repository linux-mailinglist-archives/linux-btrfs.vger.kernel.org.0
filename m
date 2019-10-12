Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD7AFD534E
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Oct 2019 01:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfJLX3S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 12 Oct 2019 19:29:18 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:42295 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfJLX3R (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 12 Oct 2019 19:29:17 -0400
Received: by mail-vs1-f53.google.com with SMTP id m22so8574263vsl.9
        for <linux-btrfs@vger.kernel.org>; Sat, 12 Oct 2019 16:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=d0m61VEzvymd1H++bt6YmOqDors+HSUMSqMfMPaGuLI=;
        b=Zhi946triwzQUeMy53OWQnhwPIB6mwL4cgApsp1cGdCHNiKflcl74BDwhlOTMQmv/H
         RlsuZAzYucE9j5i9MBkRu4yPdjm+EOkFY7OCrMimvuVc7aK1lCC4JH6fVT4nZmYV6vyn
         VE+1rGP6LYVM0eI/ubhufFGXSrTixJFSiRb2jBz0tJyRnLgTulDubLaaXXtOMkcF04XN
         A5AHcjLeq1OxTIhwWmia4S3ME7aNfc2QY/486K7joZ2IXm3eoO3tcixNoO3sCBloeTvo
         kVcluEtLRjEwcd5CJdIrMfmELuc3XSxajckCs5GRtw+GoikLA6ZDSA7hJvOhk7V2vqmh
         AwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=d0m61VEzvymd1H++bt6YmOqDors+HSUMSqMfMPaGuLI=;
        b=Y1dl+JhF9n1xm6arpuLmP08ei6flsCga1O+6lKAe7jB1+kI2t2WuPScBM9bllqxIKr
         5Brry+Aamp2Z9uhdgan92t8GvOq9UXI46aD5WddrlDe5F5G9e60jbl9oMnu5Yn+oSpyP
         I9q2wnKBXll+3+fkVaAKg3QZ0RW9o8cSSwhNkXTYOmdN/KlLKTWKrwhQup5zeABmZs2D
         I0So32HJlYe8rW+c5YtmuwW57aY3MXk8C2jFvmm/3O685dcxET94ESi8S+OGyyoyfoQF
         hQ6voxd1yFSSCLsOsafoE5sh5PiqCaVFvENz47Bi9lc/zd5VTwZIeuMdbf00mjuA7/qD
         /d8Q==
X-Gm-Message-State: APjAAAUrRqB10TC/LACzr/99YfQkueNISdeGd043Cs9osa4YYMpxZr3s
        WdDvKO2zjVi9uCy8LMgKxyhfKQF34jQ+fILvHkLp32gr
X-Google-Smtp-Source: APXvYqwGmUhi/pmuetJuPP+u2g2QrqB8/leMsO+xhSqyryz4x/kHxqW69PYIBC9N1Kpp9PsMs6JPZGZOl3I/cZtT0iA=
X-Received: by 2002:a67:fe47:: with SMTP id m7mr13587155vsr.100.1570922956684;
 Sat, 12 Oct 2019 16:29:16 -0700 (PDT)
MIME-Version: 1.0
From:   James Harvey <jamespharvey20@gmail.com>
Date:   Sat, 12 Oct 2019 19:29:05 -0400
Message-ID: <CA+X5Wn72nYqoMLLHAUZeO43_rLL9c=zwjDYG9MKV+rcZ7x6SXw@mail.gmail.com>
Subject: 5.3.0 deadlock: btrfs_sync_file / btrfs_async_reclaim_metadata_space
 / btrfs_page_mkwrite
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Was using a temporary BTRFS volume to compile mongodb, which is quite
intensive and takes quite a bit of time.  The volume has been
deadlocked for about 12 hours.

Being a temporary volume, I just used mount without options, so it
used the defaults:  rw,relatime,ssd,space_cache,subvolid=5,subvol=/

Apologies if upgrading to 5.3.5+ will fix this.  I didn't see
discussions of a deadlock looking like this.



See the full sysrq-trigger output here: http://ix.io/1Ysp



But, for searchability, here is some of it:

systemd-journal D    0   813      1 0x00004320
Call Trace:
 ? __schedule+0x27f/0x6d0
 schedule+0x43/0xd0
 schedule_timeout+0x299/0x3d0
 io_schedule_timeout+0x19/0x40
 wait_for_common_io.constprop.0+0xcf/0x150
 ? wake_up_q+0x60/0x60
 write_all_supers+0x87f/0x940 [btrfs]
 btrfs_sync_log+0x71b/0x9f0 [btrfs]
 ? dput+0xc9/0x2d0
 btrfs_sync_file+0x364/0x460 [btrfs]
 do_fsync+0x38/0x70
 __x64_sys_fsync+0x10/0x20
 do_syscall_64+0x5f/0x1c0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9


Call Trace:
 ? __schedule+0x27f/0x6d0
 schedule+0x43/0xd0
 schedule_timeout+0x1cf/0x3d0
 ? collect_expired_timers+0xb0/0xb0
 flush_space+0x55c/0x710 [btrfs]
 btrfs_async_reclaim_metadata_space+0xc4/0x4a0 [btrfs]
 ? __schedule+0x287/0x6d0
 process_one_work+0x1d1/0x3a0
 worker_thread+0x4a/0x3d0
 kthread+0xfb/0x130
 ? process_one_work+0x3a0/0x3a0
 ? kthread_park+0x80/0x80
 ret_from_fork+0x35/0x40


Then 28 of these:

Call Trace:
 ? __schedule+0x27f/0x6d0
 schedule+0x43/0xd0
 wait_reserve_ticket+0x95/0x150 [btrfs]
 ? wait_woken+0x70/0x70
 btrfs_reserve_metadata_bytes+0x782/0x920 [btrfs]
 btrfs_block_rsv_add+0x1f/0x50 [btrfs]
 start_transaction+0x2c2/0x490 [btrfs]
 btrfs_dirty_inode+0x9d/0xd0 [btrfs]
 file_update_time+0xfd/0x150
 btrfs_page_mkwrite+0xfe/0x4e0 [btrfs]
 ? lock_page_memcg+0x11/0x90
 do_page_mkwrite+0x31/0x90
 do_wp_page+0x2c6/0x660
 __handle_mm_fault+0xc24/0x15d0
 ? call_function_single_interrupt+0xa/0x20
 handle_mm_fault+0xce/0x1f0
 __do_page_fault+0x216/0x4f0
 do_page_fault+0x31/0x130
 page_fault+0x3e/0x50
