Return-Path: <linux-btrfs+bounces-14995-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16345AE9E07
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 15:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2A4189A86F
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8223721CC62;
	Thu, 26 Jun 2025 13:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0bqP2cC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326EF2E336E;
	Thu, 26 Jun 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942813; cv=none; b=S1IzHo+k2azHq1H4lD0f3/bTzMSp0LgE8XDA11rHYunIybWHI83A5Ay2vpUOkrCEDXtLlR/WGQNfH13m1/9S1vo6iJaIFTBT1Jq3SVB2ZzhOu3xI7vAS6zU6muSsRJvAgHR7kypYp062PJQ/5ypO8FeFIRQs4X/NLRIrVxvAU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942813; c=relaxed/simple;
	bh=l59Q2IYzQjDwEuvddBhgYTuAAdI9DL0W+F7dsJFT5NA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=XfazbgqRRdNix8JM+PPINrADOo4DGLbxBBMW/Lzc0MldM2xi2YOdheBPb8CjFu5A5BfpQbVae4CiVjHp6j6E0YGE7JsMZLEnYJYao/8vysLHHuXtW9fG7crafPaJkRZCAemyu6MlgUVpupkwnmVwxJUyKPaP0OTHxIoaJUG60gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0bqP2cC; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so795290276.3;
        Thu, 26 Jun 2025 06:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750942811; x=1751547611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l59Q2IYzQjDwEuvddBhgYTuAAdI9DL0W+F7dsJFT5NA=;
        b=P0bqP2cC7CVTBuqCv8+w+DSAosdpuUQRs0g7wrKrdQlXUHkN0Mn0glhJEWOv99qMMi
         ot5TIVJL/o3z/7OJlZE2d6WqtqrLybcBt6vXGi6DMs1VqbObqDmwZYqHunSeyQYG1lwP
         jgJY5sOJHAaW53B4+EEDR1CgG7a1Hh6bzfprLfo1zzJTHIwTjoYE3dVjQ4uVhke1648j
         SpM17LcfcPN1I79q/irQ3WYTKJ8GJtuhNyEYzzc18CFPrAM8g0ic8utwZL61VkP33TEu
         UrMbU3fwtqdPer0Pg50c1BBaWmZo8TBBXWN8ZUQpmzOHlQSO84E1vL2RBdE1PeBI6JbR
         LcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750942811; x=1751547611;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l59Q2IYzQjDwEuvddBhgYTuAAdI9DL0W+F7dsJFT5NA=;
        b=H+mNmiOop8UMQH9Lg/Qfq4WJIPYwxjUvOXz9gJU9YgCXtH8xvxCjUd1I339nFL6kdL
         pNVkpbcSUc+0ge5qFLm1rM8FLlkAZov3SKkNz4KPxw+6zgCV/q3vjcpW/2lwd42XtyxF
         Lu0SmkelUBZU99jPOGE8FRghJd07eavU8vwa4mX0GC1bRlJYsfZW4z6ASDd0Vq1lunMb
         Z8ofrZ0/CXHMN1b7PHdTG0iw8xvT0N8q6owwEZyX47BNdbF+sZOAWM4wh2xMOM9QFpmC
         gfnJGHjNw+MYTLwdMlImrsB5Y+8BxUst5F+0eySLBBPTgxouws7G+iCuwlQVwmFhEB+K
         /5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUpVTkWPV4oSZ83y7yeK6j+HzNpX+JfGsJ/y5EdcCk22kA/8UUUuFfaI+FwyPDYfVl8CdxXwDpm1JeXVhE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2oWVnSEX0gSBe2rA3hPV6l5x3PE5nAmwaL5Jgg6US+P730rXW
	7oYnHfOLZTTxT2hcJpJCB4WCaLMf5gcIvt7Q7hiIuvE8NsMH45oytkEprs3GXojrVC8X/td60Qn
	qc6dg0YmOINMtwJU59+nBvuABBmHYW4w=
X-Gm-Gg: ASbGncs3AyG8cghP4qqSXzxTDuRTK0A48E7kyfgahYaEGO+CAq1CAdUfGefJCSMcT6U
	6eBZn49gaWV9g0LANR83yxeBeMgc04rO42J7SgjWodLVpcJ8uKT8tJHmiO2uLyaLQbsiz2nqRnU
	kVLnHBT4PasuTUilyXDgnG5XskCC4kAIrTXVzuV3hTLA==
X-Google-Smtp-Source: AGHT+IHX/V7BJDRjogcwcgoxwe/caxTF1FobH7YTTtUH61VqShQLBLZ+SuP6JaZgNIKj7lJqe1L2x+T+8vOf87tnMzE=
X-Received: by 2002:a05:6902:6b0c:b0:e87:9bab:25d with SMTP id
 3f1490d57ef6-e879bab064dmr4262028276.39.1750942810614; Thu, 26 Jun 2025
 06:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cen zhang <zzzccc427@gmail.com>
Date: Thu, 26 Jun 2025 20:59:58 +0800
X-Gm-Features: Ac12FXzsG6MwkdNo-vfAOMfc9FQGmKEA_XcUaFyaxvJywwqyFAHjaDhqNFO2D9U
Message-ID: <CAFRLqsV+cMDETFuzqdKSHk_FDm6tneea45krsHqPD6B3FetLpQ@mail.gmail.com>
Subject: [BUG] btrfs: Data race between btrfs_quota_disable and
 btrfs_qgroup_rescan leads to a UAF
To: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, zhenghaoran154@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello maintainers,

I've encountered a kernel panic while using Btrfs. The issue appears
to be a use-after-free (UAF) caused by a data race between the
btrfs_quota_disable operation and a background btrfs_qgroup_rescan
task.

Kernel Version: 6.16.0-rc1-g7f6432600434-dirty
Environment: QEMU Virtual Machine

Problem Description & Root Cause Analysis:

The issue is triggered by the concurrent execution of the
btrfs_quota_disable function and the background btrfs_qgroup_rescan
worker.

When quotas are disabled via an ioctl call, the btrfs_quota_disable ->
btrfs_free_qgroup_config path iterates through the qgroup tree and
frees the memory for each btrfs_qgroup object using kfree.

Simultaneously, a background qgroup rescan task (btrfs_qgroup_rescan
-> qgroup_rescan_zero_tracking) may be running, which iterates over
and accesses the very same qgroup tree.

Due to a lack of proper locking to synchronize these two operations,
the qgroup_rescan_zero_tracking function can access a btrfs_qgroup
object that has just been freed by btrfs_free_qgroup_config.

When it then attempts to modify a member of this dangling pointer
(e.g., calling list_add in qgroup_dirty), it triggers a
use-after-free, which ultimately leads to the kernel panic.

We found this bug using our proprietary data-race detector in
conjunction with syzkaller. Our tool first detected a race condition
and then actively intervened by swapping the execution order of the
conflicting operations. This controlled reordering directly exposed a
latent use-after-free (UAF) vulnerability, which was subsequently
caught and reported by KASAN.

I believe this issue could be fixed by adding an appropriate
synchronization mechanism (e.g., a mutex) between the
btrfs_quota_disable path and the background qgroup scanning tasks.

Full kernel panic log is attached below:

var addr ffff888168296888, addr masked 888168296888
Kernel panic: ============ DATARACE ============
VarName 2268446652518064666, BlockLineNumber 9, IrLineNumber 1, is write 1
Function: found_watchpoint kernel/kccwf/wp_checker.c:75 [inline]
Function: watchpoints_monitor+0x1237/0x19a0 kernel/kccwf/wp_checker.c:155
Function: kccwf_rec_mem_access+0x7d0/0xae0 kernel/kccwf/core.c:582
Function: list_del include/linux/list.h:230 [inline]
Function: __del_qgroup_rb+0x2c2/0x17c0 fs/btrfs/qgroup.c:233
Function: btrfs_free_qgroup_config+0xa1/0x2b0 fs/btrfs/qgroup.c:645
Function: btrfs_quota_disable+0x826/0x25e0 fs/btrfs/qgroup.c:1393
Function: btrfs_ioctl_quota_ctl+0x3b3/0x4e0 fs/btrfs/ioctl.c:3703
Function: btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
Function: vfs_ioctl fs/ioctl.c:51 [inline]
Function: __do_sys_ioctl fs/ioctl.c:907 [inline]
Function: __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
Function: do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
Function: 0x0
============OTHER_INFO============
VarName 18129403906671370250, BlockLineNumber 22, IrLineNumber 1,
watchpoint index 19991
Function: set_report_info+0xa6/0x1f0 kernel/kccwf/report.c:49
Function: setup_watchpoint kernel/kccwf/wp_checker.c:102 [inline]
Function: watchpoints_monitor+0x7eb/0x19a0 kernel/kccwf/wp_checker.c:167
Function: kccwf_rec_mem_access+0x7d0/0xae0 kernel/kccwf/core.c:582
Function: __list_add include/linux/list.h:155 [inline]
Function: list_add include/linux/list.h:169 [inline]
Function: qgroup_dirty fs/btrfs/qgroup.c:1434 [inline]
Function: qgroup_rescan_zero_tracking fs/btrfs/qgroup.c:4005 [inline]
Function: btrfs_qgroup_rescan+0x4dc/0xa30 fs/btrfs/qgroup.c:4036
Function: btrfs_ioctl_quota_rescan+0x42a/0x530 fs/btrfs/ioctl.c:3943
Function: btrfs_ioctl+0x1187/0x1480 fs/btrfs/ioctl.c:5331
Function: vfs_ioctl fs/ioctl.c:51 [inline]
Function: __do_sys_ioctl fs/ioctl.c:907 [inline]
Function: __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
Function: do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
Function: do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
Function: entry_SYSCALL_64_after_hwframe+0x77/0x7f
=================END==============
Found watch_point 19991
BTRFS info (device sdb): balance: start -s
BTRFS info (device sdb): balance: ended with status: 0
BTRFS warning (device sdb): get dev_stats failed, device not found
[...]
==================================================================
BUG: KASAN: slab-use-after-free in __list_del_entry
include/linux/list.h:218 [inline]
BUG: KASAN: slab-use-after-free in list_del_init
include/linux/list.h:287 [inline]
BUG: KASAN: slab-use-after-free in btrfs_run_qgroups+0x3cd/0x1ec0
fs/btrfs/qgroup.c:3132
Read of size 8 at addr ffff888168296890 by task btrfs-transacti/228

CPU: 0 UID: 0 PID: 228 Comm: btrfs-transacti Not tainted
6.16.0-rc1-g7f6432600434-dirty #52 PREEMPT(voluntary)
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x108/0x150 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x191/0x5b0 mm/kasan/report.c:521
 kasan_report+0x139/0x170 mm/kasan/report.c:634
 __list_del_entry include/linux/list.h:218 [inline]
 list_del_init include/linux/list.h:287 [inline]
 btrfs_run_qgroups+0x3cd/0x1ec0 fs/btrfs/qgroup.c:3132
 commit_cowonly_roots+0x67c/0x1c10 fs/btrfs/transaction.c:1354
 btrfs_commit_transaction+0x2a5b/0xc800 fs/btrfs/transaction.c:2457
 transaction_kthread+0x5b7/0xcc0 fs/btrfs/disk-io.c:1590
 kthread+0x351/0x780 kernel/kthread.c:464
 ret_from_fork+0x10e/0x1c0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 127769:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x82/0x90 mm/kasan/common.c:394
 kmalloc_noprof include/linux/slab.h:905 [inline]
 kzalloc_noprof include/linux/slab.h:1039 [inline]
 btrfs_quota_enable+0x2d07/0x5d10 fs/btrfs/qgroup.c:1201
 btrfs_ioctl_quota_ctl+0x36c/0x4e0 fs/btrfs/ioctl.c:3673
 btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Freed by task 127948:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:576
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x36/0x50 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:233 [inline]
 slab_free_hook mm/slub.c:2388 [inline]
 slab_free mm/slub.c:4670 [inline]
 kfree+0xfd/0x340 mm/slub.c:4869
 btrfs_free_qgroup_config+0xcd/0x2b0 fs/btrfs/qgroup.c:647
 btrfs_quota_disable+0x826/0x25e0 fs/btrfs/qgroup.c:1393
 btrfs_ioctl_quota_ctl+0x3b3/0x4e0 fs/btrfs/ioctl.c:3703
 btrfs_ioctl+0xb3f/0x1480 fs/btrfs/ioctl.c:5323
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888168296800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 144 bytes inside of
 freed 512-byte region [ffff888168296800, ffff888168296a00)
[...]
==================================================================
Hope this helps in tracking down and fixing the issue.

Here is the detail:

Thank you for your attention to this matter.

Best regards,
Cen Zhang

