Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B861169F2
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 20:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEGSL3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 14:11:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40858 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbfEGSL3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 14:11:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id b3so8563951plr.7
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seravo.fi; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=oZzrM3hgJrMkSQ6Nxy2pIHd7u/zqkLLwSfmmn4Vp5xs=;
        b=QCl2Ir9kk4muvUsa616SrXouzjOhhEhEyAM6HaKQfIjdnLdctn8wXi/+pTBMK05gCm
         Uca2EmCM5VR+YVTNd0O0aYOLwxG5AL8c/q3q5igOh87r9leL9R5KblQHDldZkr+p1zfb
         /vFkWd1SiBF4oqXeKT3SNjtTvZBriR3u1pgxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=oZzrM3hgJrMkSQ6Nxy2pIHd7u/zqkLLwSfmmn4Vp5xs=;
        b=Yzj66hk9E9Qzd/RQST/ClDM/mKK4zKDCMyFSTSCOjjFnSHcWub6cAHru7bZmpEAQ06
         PvuQrQBpUnDymuiqNtRvLAJvhoGSUDOpT7YrpxdqepeypvxenvPiHYCoaeyVDg19vF0j
         YUFIeYvhY7+AesSa+deZ2db7odZrnOHkupOtSWlSJWVxEWhSXpYMjv9pBlNdvVmAnZgF
         WSGhawqsjP6bf5ohJYA1I78BG0KJKLOLE/2Z7kheVlUqV3V1EreqfuxS1f7s7N+0Pwca
         78/IaNxNPrpFYAj/xqRbPv8npR/QGUo61Tzb8ml5r+ZuOgpVFk19tK/rshfOSOdn3Pg+
         91Kg==
X-Gm-Message-State: APjAAAWXLJK/sdaqOW8RVTMZAee8zRpK6UsK+slpjKWF+R+uhr6UqMUQ
        4r8vGd5v8Ib2Us/c0gd2ooTPXogj5ORnbgWGI+r2++Q=
X-Google-Smtp-Source: APXvYqwISlDEKvqIw4/VBa8lzYkMKr1EY0iv/z8sU4ryna6LfDQahkE3Sno+Z750rExmBesUOmvrQ0MRFccuR+rRh08=
X-Received: by 2002:a17:902:5c5:: with SMTP id f63mr40388443plf.327.1557252687477;
 Tue, 07 May 2019 11:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHj_TLB=bqYmt6imjS-QU7OUtvGzatcVDZeCeCj1EfJA-3neKQ@mail.gmail.com>
In-Reply-To: <CAHj_TLB=bqYmt6imjS-QU7OUtvGzatcVDZeCeCj1EfJA-3neKQ@mail.gmail.com>
From:   =?UTF-8?B?T3R0byBLZWvDpGzDpGluZW4=?= <otto@seravo.fi>
Date:   Tue, 7 May 2019 21:11:01 +0300
Message-ID: <CAHj_TLAYtermKEKMNLqRTsfJW8r_ospp4sWBcMZZo38ONfShtA@mail.gmail.com>
Subject: Re: Howto read btrfs stack trace?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Any advice here please?

ma 6. toukok. 2019 klo 19.21 Otto Kek=C3=A4l=C3=A4inen (otto@seravo.fi) kir=
joitti:
>
> Hello!
>
> I attempted to run btrfs balance, but it crashed soon after start.
> Status is stuck on this:
>
> $ sudo btrfs balance status -v /data
> Balance on '/data' is running
> 0 out of about 10436 chunks balanced (1 considered), 100% left
> Dumping filters: flags 0x7, state 0x1, force is off
>   DATA (flags 0x0): balancing
>   METADATA (flags 0x0): balancing
>   SYSTEM (flags 0x0): balancing
>
>
> Logs have the output below. How shall I read it and debug this situation?
> What are the next steps I could test/debug?
>
>
> kernel: BTRFS info (device dm-9): disk space caching is enabled
> kernel: BTRFS: has skinny extents
> kernel: BTRFS: checking UUID tree
> kernel: BTRFS info (device dm-9): relocating block group 13693423976448 f=
lags 20
> kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.
> kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: btrfs           D ffff88030bd07a98     0  2918   2892 0x00000000
> kernel:  ffff88030bd07a98 ffffffff81197240 ffffffff81e13500 ffff88033fe44=
e00
> kernel:  ffff88030bd08000 ffff88035dc88714 ffff88033fe44e00 00000000fffff=
fff
> kernel:  ffff88035dc88718 ffff88030bd07ab0 ffffffff8185e0b5 ffff88035dc88=
710
> kernel: Call Trace:
> kernel:  [<ffffffff81197240>] ? printk+0x5a/0x76
> kernel:  [<ffffffff8185e0b5>] schedule+0x35/0x80
> kernel:  [<ffffffff8185e40e>] schedule_preempt_disabled+0xe/0x10
> kernel:  [<ffffffff818602a7>] __mutex_lock_slowpath+0xb7/0x130
> kernel:  [<ffffffff8186033f>] mutex_lock+0x1f/0x30
> kernel:  [<ffffffffc047b01b>] btrfs_relocate_block_group+0x1ab/0x290 [btr=
fs]
> kernel:  [<ffffffffc044fe47>] btrfs_relocate_chunk.isra.39+0x47/0xd0 [btr=
fs]
> kernel:  [<ffffffffc04512fa>] __btrfs_balance+0x5ba/0xb90 [btrfs]
> kernel:  [<ffffffffc0451b60>] btrfs_balance+0x290/0x5f0 [btrfs]
> kernel:  [<ffffffffc045d031>] btrfs_ioctl_balance+0x381/0x390 [btrfs]
> kernel:  [<ffffffffc045fe30>] btrfs_ioctl+0x550/0x28c0 [btrfs]
> kernel:  [<ffffffff8120f84b>] ? mem_cgroup_try_charge+0x6b/0x1e0
> kernel:  [<ffffffff811a9ba7>] ? lru_cache_add_active_or_unevictable+0x27/=
0xa0
> kernel:  [<ffffffff811cc2ed>] ? handle_mm_fault+0xecd/0x1b80
> kernel:  [<ffffffff8123016f>] do_vfs_ioctl+0x2af/0x4b0
> kernel:  [<ffffffff8106dd51>] ? __do_page_fault+0x1c1/0x410
> kernel:  [<ffffffff812303e9>] SyS_ioctl+0x79/0x90
> kernel:  [<ffffffff81862a1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
> kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.
> kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: btrfs           D ffff88030bd07a98     0  2918   2892 0x00000000
> kernel:  ffff88030bd07a98 ffffffff81197240 ffffffff81e13500 ffff88033fe44=
e00
> kernel:  ffff88030bd08000 ffff88035dc88714 ffff88033fe44e00 00000000fffff=
fff
> kernel:  ffff88035dc88718 ffff88030bd07ab0 ffffffff8185e0b5 ffff88035dc88=
710
> kernel: Call Trace:
> kernel:  [<ffffffff81197240>] ? printk+0x5a/0x76
> kernel:  [<ffffffff8185e0b5>] schedule+0x35/0x80
> kernel:  [<ffffffff8185e40e>] schedule_preempt_disabled+0xe/0x10
> kernel:  [<ffffffff818602a7>] __mutex_lock_slowpath+0xb7/0x130
> kernel:  [<ffffffff8186033f>] mutex_lock+0x1f/0x30
> kernel:  [<ffffffffc047b01b>] btrfs_relocate_block_group+0x1ab/0x290 [btr=
fs]
> kernel:  [<ffffffffc044fe47>] btrfs_relocate_chunk.isra.39+0x47/0xd0 [btr=
fs]
> kernel:  [<ffffffffc04512fa>] __btrfs_balance+0x5ba/0xb90 [btrfs]
> kernel:  [<ffffffffc0451b60>] btrfs_balance+0x290/0x5f0 [btrfs]
> kernel:  [<ffffffffc045d031>] btrfs_ioctl_balance+0x381/0x390 [btrfs]
> kernel:  [<ffffffffc045fe30>] btrfs_ioctl+0x550/0x28c0 [btrfs]
> kernel:  [<ffffffff8120f84b>] ? mem_cgroup_try_charge+0x6b/0x1e0
> kernel:  [<ffffffff811a9ba7>] ? lru_cache_add_active_or_unevictable+0x27/=
0xa0
> kernel:  [<ffffffff811cc2ed>] ? handle_mm_fault+0xecd/0x1b80
> kernel:  [<ffffffff8123016f>] do_vfs_ioctl+0x2af/0x4b0
> kernel:  [<ffffffff8106dd51>] ? __do_page_fault+0x1c1/0x410
> kernel:  [<ffffffff812303e9>] SyS_ioctl+0x79/0x90
> kernel:  [<ffffffff81862a1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
> kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.
> kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
> kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> kernel: btrfs           D ffff88030bd07a98     0  2918   2892 0x00000000
> kernel:  ffff88030bd07a98 ffffffff81197240 ffffffff81e13500 ffff88033fe44=
e00
> kernel:  ffff88030bd08000 ffff88035dc88714 ffff88033fe44e00 00000000fffff=
fff
> kernel:  ffff88035dc88718 ffff88030bd07ab0 ffffffff8185e0b5 ffff88035dc88=
710
> kernel: Call Trace:
> kernel:  [<ffffffff81197240>] ? printk+0x5a/0x76
> kernel:  [<ffffffff8185e0b5>] schedule+0x35/0x80
> kernel:  [<ffffffff8185e40e>] schedule_preempt_disabled+0xe/0x10
> kernel:  [<ffffffff818602a7>] __mutex_lock_slowpath+0xb7/0x130
> kernel:  [<ffffffff8186033f>] mutex_lock+0x1f/0x30
> kernel:  [<ffffffffc047b01b>] btrfs_relocate_block_group+0x1ab/0x290 [btr=
fs]
> kernel:  [<ffffffffc044fe47>] btrfs_relocate_chunk.isra.39+0x47/0xd0 [btr=
fs]
> kernel:  [<ffffffffc04512fa>] __btrfs_balance+0x5ba/0xb90 [btrfs]
> kernel:  [<ffffffffc0451b60>] btrfs_balance+0x290/0x5f0 [btrfs]
> kernel:  [<ffffffffc045d031>] btrfs_ioctl_balance+0x381/0x390 [btrfs]
> kernel:  [<ffffffffc045fe30>] btrfs_ioctl+0x550/0x28c0 [btrfs]
> kernel:  [<ffffffff8120f84b>] ? mem_cgroup_try_charge+0x6b/0x1e0
> kernel:  [<ffffffff811a9ba7>] ? lru_cache_add_active_or_unevictable+0x27/=
0xa0
> kernel:  [<ffffffff811cc2ed>] ? handle_mm_fault+0xecd/0x1b80
> kernel:  [<ffffffff8123016f>] do_vfs_ioctl+0x2af/0x4b0
> kernel:  [<ffffffff8106dd51>] ? __do_page_fault+0x1c1/0x410
> kernel:  [<ffffffff812303e9>] SyS_ioctl+0x79/0x90
> kernel:  [<ffffffff81862a1b>] entry_SYSCALL_64_fastpath+0x22/0xcb



--=20
Otto Kek=C3=A4l=C3=A4inen
CEO
Seravo
+358 44 566 2204

Follow me at @ottokekalainen
