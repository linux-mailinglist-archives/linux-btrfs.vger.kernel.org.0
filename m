Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE491511C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2019 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfEFQWG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 May 2019 12:22:06 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33002 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfEFQWG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 6 May 2019 12:22:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so722498pgv.0
        for <linux-btrfs@vger.kernel.org>; Mon, 06 May 2019 09:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seravo.fi; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=VaFNGStwjFK/jFOGjVRgB/rmnPcFJ/L5EQXri8/hT8A=;
        b=LHrbv6f6KvkwBG3Hd8pP6hbzLegDeGKtMxg8DU2MuM8Jn6KiVfE+IliLiXVLP5m6WA
         3BudMuG/ePf2Y0/TaCgWMjcwrkqfFkYVnITOnoqhZpKyQVWWZtWdVdI9r39jcAT44y2y
         LVTW3vObVXfjzW5NLntRN5r7pUvXIeyyBywvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VaFNGStwjFK/jFOGjVRgB/rmnPcFJ/L5EQXri8/hT8A=;
        b=Eiy4lScDiXc4lkqcMh0VgIM3esSsHY2KLUkNFk/owtVjEt4pV5WFaKJ6aSMFfhpaKe
         xR+zEuSBKijva6+iWnMyZhSi80ovmYnabKnoIyRnYP5e+QJoUj88YVz3FjLrXVBhNggD
         Pxf5fF7q0fLISdSfM8vgVtpIEtUon3BFpxNHXxO2grDoY/BUrKm8O5gFVd/EWQfUAHOE
         PugWA4Ng2uy8fia/xT4xZnWA1REXtiVab9owMQk+63NUQN6rnsVRIahO2PFLHmVMiF3x
         1uk4pBoefl9aSxvhNyJAKKXnRnMzwemcnA3JB1/7JETEGXalF5HxDiqxJvC4ShATjn3u
         TQAg==
X-Gm-Message-State: APjAAAVfa+SDC6gyYiETeOtl8BBmahANRNCN+qIbm7uQpsPRbmrOKC6E
        g4QSeojFz9HtQ5ERkYlLYeLQVFVcufvSevIm10YIAiTFvQ==
X-Google-Smtp-Source: APXvYqzRINnFca6QM5lXzetJs7Eaxj5WV+B0qC88pSNdaHtjqrkcROpfQvL+fqD+mdac+NfJXci063EomhSdMOUsA0Q=
X-Received: by 2002:a65:60d7:: with SMTP id r23mr31612567pgv.223.1557159724629;
 Mon, 06 May 2019 09:22:04 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?T3R0byBLZWvDpGzDpGluZW4=?= <otto@seravo.fi>
Date:   Mon, 6 May 2019 19:21:36 +0300
Message-ID: <CAHj_TLB=bqYmt6imjS-QU7OUtvGzatcVDZeCeCj1EfJA-3neKQ@mail.gmail.com>
Subject: Howto read btrfs stack trace?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello!

I attempted to run btrfs balance, but it crashed soon after start.
Status is stuck on this:

$ sudo btrfs balance status -v /data
Balance on '/data' is running
0 out of about 10436 chunks balanced (1 considered), 100% left
Dumping filters: flags 0x7, state 0x1, force is off
  DATA (flags 0x0): balancing
  METADATA (flags 0x0): balancing
  SYSTEM (flags 0x0): balancing


Logs have the output below. How shall I read it and debug this situation?
What are the next steps I could test/debug?


kernel: BTRFS info (device dm-9): disk space caching is enabled
kernel: BTRFS: has skinny extents
kernel: BTRFS: checking UUID tree
kernel: BTRFS info (device dm-9): relocating block group 13693423976448 flags 20
kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.
kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: btrfs           D ffff88030bd07a98     0  2918   2892 0x00000000
kernel:  ffff88030bd07a98 ffffffff81197240 ffffffff81e13500 ffff88033fe44e00
kernel:  ffff88030bd08000 ffff88035dc88714 ffff88033fe44e00 00000000ffffffff
kernel:  ffff88035dc88718 ffff88030bd07ab0 ffffffff8185e0b5 ffff88035dc88710
kernel: Call Trace:
kernel:  [<ffffffff81197240>] ? printk+0x5a/0x76
kernel:  [<ffffffff8185e0b5>] schedule+0x35/0x80
kernel:  [<ffffffff8185e40e>] schedule_preempt_disabled+0xe/0x10
kernel:  [<ffffffff818602a7>] __mutex_lock_slowpath+0xb7/0x130
kernel:  [<ffffffff8186033f>] mutex_lock+0x1f/0x30
kernel:  [<ffffffffc047b01b>] btrfs_relocate_block_group+0x1ab/0x290 [btrfs]
kernel:  [<ffffffffc044fe47>] btrfs_relocate_chunk.isra.39+0x47/0xd0 [btrfs]
kernel:  [<ffffffffc04512fa>] __btrfs_balance+0x5ba/0xb90 [btrfs]
kernel:  [<ffffffffc0451b60>] btrfs_balance+0x290/0x5f0 [btrfs]
kernel:  [<ffffffffc045d031>] btrfs_ioctl_balance+0x381/0x390 [btrfs]
kernel:  [<ffffffffc045fe30>] btrfs_ioctl+0x550/0x28c0 [btrfs]
kernel:  [<ffffffff8120f84b>] ? mem_cgroup_try_charge+0x6b/0x1e0
kernel:  [<ffffffff811a9ba7>] ? lru_cache_add_active_or_unevictable+0x27/0xa0
kernel:  [<ffffffff811cc2ed>] ? handle_mm_fault+0xecd/0x1b80
kernel:  [<ffffffff8123016f>] do_vfs_ioctl+0x2af/0x4b0
kernel:  [<ffffffff8106dd51>] ? __do_page_fault+0x1c1/0x410
kernel:  [<ffffffff812303e9>] SyS_ioctl+0x79/0x90
kernel:  [<ffffffff81862a1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.
kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: btrfs           D ffff88030bd07a98     0  2918   2892 0x00000000
kernel:  ffff88030bd07a98 ffffffff81197240 ffffffff81e13500 ffff88033fe44e00
kernel:  ffff88030bd08000 ffff88035dc88714 ffff88033fe44e00 00000000ffffffff
kernel:  ffff88035dc88718 ffff88030bd07ab0 ffffffff8185e0b5 ffff88035dc88710
kernel: Call Trace:
kernel:  [<ffffffff81197240>] ? printk+0x5a/0x76
kernel:  [<ffffffff8185e0b5>] schedule+0x35/0x80
kernel:  [<ffffffff8185e40e>] schedule_preempt_disabled+0xe/0x10
kernel:  [<ffffffff818602a7>] __mutex_lock_slowpath+0xb7/0x130
kernel:  [<ffffffff8186033f>] mutex_lock+0x1f/0x30
kernel:  [<ffffffffc047b01b>] btrfs_relocate_block_group+0x1ab/0x290 [btrfs]
kernel:  [<ffffffffc044fe47>] btrfs_relocate_chunk.isra.39+0x47/0xd0 [btrfs]
kernel:  [<ffffffffc04512fa>] __btrfs_balance+0x5ba/0xb90 [btrfs]
kernel:  [<ffffffffc0451b60>] btrfs_balance+0x290/0x5f0 [btrfs]
kernel:  [<ffffffffc045d031>] btrfs_ioctl_balance+0x381/0x390 [btrfs]
kernel:  [<ffffffffc045fe30>] btrfs_ioctl+0x550/0x28c0 [btrfs]
kernel:  [<ffffffff8120f84b>] ? mem_cgroup_try_charge+0x6b/0x1e0
kernel:  [<ffffffff811a9ba7>] ? lru_cache_add_active_or_unevictable+0x27/0xa0
kernel:  [<ffffffff811cc2ed>] ? handle_mm_fault+0xecd/0x1b80
kernel:  [<ffffffff8123016f>] do_vfs_ioctl+0x2af/0x4b0
kernel:  [<ffffffff8106dd51>] ? __do_page_fault+0x1c1/0x410
kernel:  [<ffffffff812303e9>] SyS_ioctl+0x79/0x90
kernel:  [<ffffffff81862a1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
kernel: INFO: task btrfs:2918 blocked for more than 120 seconds.
kernel:       Not tainted 4.4.0-146-generic #172-Ubuntu
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
kernel: btrfs           D ffff88030bd07a98     0  2918   2892 0x00000000
kernel:  ffff88030bd07a98 ffffffff81197240 ffffffff81e13500 ffff88033fe44e00
kernel:  ffff88030bd08000 ffff88035dc88714 ffff88033fe44e00 00000000ffffffff
kernel:  ffff88035dc88718 ffff88030bd07ab0 ffffffff8185e0b5 ffff88035dc88710
kernel: Call Trace:
kernel:  [<ffffffff81197240>] ? printk+0x5a/0x76
kernel:  [<ffffffff8185e0b5>] schedule+0x35/0x80
kernel:  [<ffffffff8185e40e>] schedule_preempt_disabled+0xe/0x10
kernel:  [<ffffffff818602a7>] __mutex_lock_slowpath+0xb7/0x130
kernel:  [<ffffffff8186033f>] mutex_lock+0x1f/0x30
kernel:  [<ffffffffc047b01b>] btrfs_relocate_block_group+0x1ab/0x290 [btrfs]
kernel:  [<ffffffffc044fe47>] btrfs_relocate_chunk.isra.39+0x47/0xd0 [btrfs]
kernel:  [<ffffffffc04512fa>] __btrfs_balance+0x5ba/0xb90 [btrfs]
kernel:  [<ffffffffc0451b60>] btrfs_balance+0x290/0x5f0 [btrfs]
kernel:  [<ffffffffc045d031>] btrfs_ioctl_balance+0x381/0x390 [btrfs]
kernel:  [<ffffffffc045fe30>] btrfs_ioctl+0x550/0x28c0 [btrfs]
kernel:  [<ffffffff8120f84b>] ? mem_cgroup_try_charge+0x6b/0x1e0
kernel:  [<ffffffff811a9ba7>] ? lru_cache_add_active_or_unevictable+0x27/0xa0
kernel:  [<ffffffff811cc2ed>] ? handle_mm_fault+0xecd/0x1b80
kernel:  [<ffffffff8123016f>] do_vfs_ioctl+0x2af/0x4b0
kernel:  [<ffffffff8106dd51>] ? __do_page_fault+0x1c1/0x410
kernel:  [<ffffffff812303e9>] SyS_ioctl+0x79/0x90
kernel:  [<ffffffff81862a1b>] entry_SYSCALL_64_fastpath+0x22/0xcb
